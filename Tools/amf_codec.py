"""
AMF/JSON/XML Codec - Action Message Format Encoder/Decoder

Handles encoding and decoding of game protocol formats:
- AMF0 (Action Message Format version 0)
- AMF3 (Action Message Format version 3)
- JSON payloads
- XML payloads
- Binary protocol wrappers
"""

import logging
import struct
import json
import io
from dataclasses import dataclass, field
from enum import IntEnum
from typing import Dict, Optional, List, Any, Tuple, Union
from datetime import datetime
import xml.etree.ElementTree as ET

logger = logging.getLogger(__name__)


class AMF0Type(IntEnum):
    """AMF0 data type markers"""
    NUMBER = 0x00
    BOOLEAN = 0x01
    STRING = 0x02
    OBJECT = 0x03
    MOVIECLIP = 0x04  # Reserved
    NULL = 0x05
    UNDEFINED = 0x06
    REFERENCE = 0x07
    ECMA_ARRAY = 0x08
    OBJECT_END = 0x09
    STRICT_ARRAY = 0x0A
    DATE = 0x0B
    LONG_STRING = 0x0C
    UNSUPPORTED = 0x0D
    RECORDSET = 0x0E  # Reserved
    XML_DOCUMENT = 0x0F
    TYPED_OBJECT = 0x10
    AVMPLUS_OBJECT = 0x11  # Switch to AMF3


class AMF3Type(IntEnum):
    """AMF3 data type markers"""
    UNDEFINED = 0x00
    NULL = 0x01
    FALSE = 0x02
    TRUE = 0x03
    INTEGER = 0x04
    DOUBLE = 0x05
    STRING = 0x06
    XML_DOC = 0x07
    DATE = 0x08
    ARRAY = 0x09
    OBJECT = 0x0A
    XML = 0x0B
    BYTE_ARRAY = 0x0C
    VECTOR_INT = 0x0D
    VECTOR_UINT = 0x0E
    VECTOR_DOUBLE = 0x0F
    VECTOR_OBJECT = 0x10
    DICTIONARY = 0x11


@dataclass
class AMFMessage:
    """An AMF message"""
    target_uri: str
    response_uri: str
    data: Any
    
    def to_dict(self) -> Dict:
        return {
            "target_uri": self.target_uri,
            "response_uri": self.response_uri,
            "data": self.data,
        }


@dataclass
class AMFPacket:
    """A complete AMF packet with headers and messages"""
    version: int
    headers: List[Dict] = field(default_factory=list)
    messages: List[AMFMessage] = field(default_factory=list)
    
    def to_dict(self) -> Dict:
        return {
            "version": self.version,
            "headers": self.headers,
            "messages": [m.to_dict() for m in self.messages],
        }


class AMFDecoder:
    """Decodes AMF0 and AMF3 binary data"""
    
    def __init__(self):
        self._string_refs: List[str] = []
        self._object_refs: List[Any] = []
        self._trait_refs: List[Dict] = []
        
    def decode(self, data: bytes) -> AMFPacket:
        """Decode a complete AMF packet"""
        self._reset_refs()
        stream = io.BytesIO(data)
        
        # Read version
        version = struct.unpack(">H", stream.read(2))[0]
        
        # Read headers
        header_count = struct.unpack(">H", stream.read(2))[0]
        headers = []
        for _ in range(header_count):
            headers.append(self._decode_header(stream))
            
        # Read messages
        message_count = struct.unpack(">H", stream.read(2))[0]
        messages = []
        for _ in range(message_count):
            messages.append(self._decode_message(stream, version))
            
        return AMFPacket(version=version, headers=headers, messages=messages)
        
    def decode_value(self, data: bytes, amf_version: int = 0) -> Any:
        """Decode a single AMF value"""
        self._reset_refs()
        stream = io.BytesIO(data)
        
        if amf_version == 0:
            return self._decode_amf0(stream)
        else:
            return self._decode_amf3(stream)
            
    def _reset_refs(self):
        """Reset reference tables"""
        self._string_refs = []
        self._object_refs = []
        self._trait_refs = []
        
    def _decode_header(self, stream: io.BytesIO) -> Dict:
        """Decode AMF header"""
        name = self._read_utf8(stream)
        must_understand = struct.unpack(">?", stream.read(1))[0]
        length = struct.unpack(">I", stream.read(4))[0]
        value = self._decode_amf0(stream)
        
        return {
            "name": name,
            "must_understand": must_understand,
            "value": value,
        }
        
    def _decode_message(self, stream: io.BytesIO, version: int) -> AMFMessage:
        """Decode AMF message"""
        target_uri = self._read_utf8(stream)
        response_uri = self._read_utf8(stream)
        length = struct.unpack(">I", stream.read(4))[0]
        
        # Decode message data
        if version == 3:
            data = self._decode_amf3(stream)
        else:
            data = self._decode_amf0(stream)
            
        return AMFMessage(
            target_uri=target_uri,
            response_uri=response_uri,
            data=data,
        )
        
    def _decode_amf0(self, stream: io.BytesIO) -> Any:
        """Decode AMF0 value"""
        type_marker = struct.unpack(">B", stream.read(1))[0]
        
        if type_marker == AMF0Type.NUMBER:
            return struct.unpack(">d", stream.read(8))[0]
            
        elif type_marker == AMF0Type.BOOLEAN:
            return struct.unpack(">?", stream.read(1))[0]
            
        elif type_marker == AMF0Type.STRING:
            return self._read_utf8(stream)
            
        elif type_marker == AMF0Type.OBJECT:
            return self._decode_amf0_object(stream)
            
        elif type_marker == AMF0Type.NULL:
            return None
            
        elif type_marker == AMF0Type.UNDEFINED:
            return None
            
        elif type_marker == AMF0Type.REFERENCE:
            ref = struct.unpack(">H", stream.read(2))[0]
            return self._object_refs[ref] if ref < len(self._object_refs) else None
            
        elif type_marker == AMF0Type.ECMA_ARRAY:
            count = struct.unpack(">I", stream.read(4))[0]
            return self._decode_amf0_object(stream)
            
        elif type_marker == AMF0Type.STRICT_ARRAY:
            count = struct.unpack(">I", stream.read(4))[0]
            arr = []
            for _ in range(count):
                arr.append(self._decode_amf0(stream))
            return arr
            
        elif type_marker == AMF0Type.DATE:
            timestamp = struct.unpack(">d", stream.read(8))[0]
            timezone = struct.unpack(">h", stream.read(2))[0]
            return datetime.fromtimestamp(timestamp / 1000)
            
        elif type_marker == AMF0Type.LONG_STRING:
            length = struct.unpack(">I", stream.read(4))[0]
            return stream.read(length).decode('utf-8')
            
        elif type_marker == AMF0Type.XML_DOCUMENT:
            length = struct.unpack(">I", stream.read(4))[0]
            return stream.read(length).decode('utf-8')
            
        elif type_marker == AMF0Type.TYPED_OBJECT:
            class_name = self._read_utf8(stream)
            obj = self._decode_amf0_object(stream)
            obj['__class__'] = class_name
            return obj
            
        elif type_marker == AMF0Type.AVMPLUS_OBJECT:
            return self._decode_amf3(stream)
            
        else:
            logger.warning(f"Unknown AMF0 type: {type_marker}")
            return None
            
    def _decode_amf0_object(self, stream: io.BytesIO) -> Dict:
        """Decode AMF0 object"""
        obj = {}
        self._object_refs.append(obj)
        
        while True:
            key = self._read_utf8(stream)
            type_marker = struct.unpack(">B", stream.read(1))[0]
            
            if type_marker == AMF0Type.OBJECT_END:
                break
                
            # Put back the type marker
            stream.seek(-1, 1)
            obj[key] = self._decode_amf0(stream)
            
        return obj
        
    def _decode_amf3(self, stream: io.BytesIO) -> Any:
        """Decode AMF3 value"""
        type_marker = struct.unpack(">B", stream.read(1))[0]
        
        if type_marker == AMF3Type.UNDEFINED:
            return None
            
        elif type_marker == AMF3Type.NULL:
            return None
            
        elif type_marker == AMF3Type.FALSE:
            return False
            
        elif type_marker == AMF3Type.TRUE:
            return True
            
        elif type_marker == AMF3Type.INTEGER:
            return self._read_u29(stream)
            
        elif type_marker == AMF3Type.DOUBLE:
            return struct.unpack(">d", stream.read(8))[0]
            
        elif type_marker == AMF3Type.STRING:
            return self._read_amf3_string(stream)
            
        elif type_marker == AMF3Type.ARRAY:
            return self._decode_amf3_array(stream)
            
        elif type_marker == AMF3Type.OBJECT:
            return self._decode_amf3_object(stream)
            
        elif type_marker == AMF3Type.DATE:
            ref = self._read_u29(stream)
            if ref & 1 == 0:
                return self._object_refs[ref >> 1]
            timestamp = struct.unpack(">d", stream.read(8))[0]
            date = datetime.fromtimestamp(timestamp / 1000)
            self._object_refs.append(date)
            return date
            
        elif type_marker == AMF3Type.BYTE_ARRAY:
            ref = self._read_u29(stream)
            if ref & 1 == 0:
                return self._object_refs[ref >> 1]
            length = ref >> 1
            data = stream.read(length)
            self._object_refs.append(data)
            return data
            
        elif type_marker in [AMF3Type.XML_DOC, AMF3Type.XML]:
            ref = self._read_u29(stream)
            if ref & 1 == 0:
                return self._object_refs[ref >> 1]
            length = ref >> 1
            xml_str = stream.read(length).decode('utf-8')
            self._object_refs.append(xml_str)
            return xml_str
            
        else:
            logger.warning(f"Unknown AMF3 type: {type_marker}")
            return None
            
    def _decode_amf3_array(self, stream: io.BytesIO) -> Union[List, Dict]:
        """Decode AMF3 array"""
        ref = self._read_u29(stream)
        
        if ref & 1 == 0:
            return self._object_refs[ref >> 1]
            
        count = ref >> 1
        
        # Read associative portion (key-value pairs)
        assoc = {}
        while True:
            key = self._read_amf3_string(stream)
            if not key:
                break
            assoc[key] = self._decode_amf3(stream)
            
        # Read dense portion
        dense = []
        for _ in range(count):
            dense.append(self._decode_amf3(stream))
            
        if assoc:
            result = {**assoc}
            for i, v in enumerate(dense):
                result[str(i)] = v
            self._object_refs.append(result)
            return result
        else:
            self._object_refs.append(dense)
            return dense
            
    def _decode_amf3_object(self, stream: io.BytesIO) -> Dict:
        """Decode AMF3 object"""
        ref = self._read_u29(stream)
        
        if ref & 1 == 0:
            return self._object_refs[ref >> 1]
            
        traits_ref = ref >> 1
        
        if traits_ref & 1 == 0:
            traits = self._trait_refs[traits_ref >> 1]
        else:
            # Read traits
            class_name = self._read_amf3_string(stream)
            is_externalizable = bool(traits_ref & 2)
            is_dynamic = bool(traits_ref & 4)
            prop_count = traits_ref >> 3
            
            props = []
            for _ in range(prop_count):
                props.append(self._read_amf3_string(stream))
                
            traits = {
                "class_name": class_name,
                "is_externalizable": is_externalizable,
                "is_dynamic": is_dynamic,
                "properties": props,
            }
            self._trait_refs.append(traits)
            
        obj = {}
        if traits["class_name"]:
            obj["__class__"] = traits["class_name"]
            
        self._object_refs.append(obj)
        
        # Read property values
        for prop in traits["properties"]:
            obj[prop] = self._decode_amf3(stream)
            
        # Read dynamic properties
        if traits["is_dynamic"]:
            while True:
                key = self._read_amf3_string(stream)
                if not key:
                    break
                obj[key] = self._decode_amf3(stream)
                
        return obj
        
    def _read_utf8(self, stream: io.BytesIO) -> str:
        """Read UTF-8 string with 16-bit length"""
        length = struct.unpack(">H", stream.read(2))[0]
        return stream.read(length).decode('utf-8') if length > 0 else ""
        
    def _read_u29(self, stream: io.BytesIO) -> int:
        """Read variable-length unsigned 29-bit integer"""
        result = 0
        for i in range(4):
            byte = struct.unpack(">B", stream.read(1))[0]
            if i < 3:
                result = (result << 7) | (byte & 0x7F)
                if byte & 0x80 == 0:
                    break
            else:
                result = (result << 8) | byte
        return result
        
    def _read_amf3_string(self, stream: io.BytesIO) -> str:
        """Read AMF3 string"""
        ref = self._read_u29(stream)
        
        if ref & 1 == 0:
            idx = ref >> 1
            return self._string_refs[idx] if idx < len(self._string_refs) else ""
            
        length = ref >> 1
        if length == 0:
            return ""
            
        string = stream.read(length).decode('utf-8')
        self._string_refs.append(string)
        return string


class AMFEncoder:
    """Encodes Python data to AMF0 and AMF3 binary"""
    
    def __init__(self):
        self._string_refs: Dict[str, int] = {}
        self._object_refs: Dict[int, int] = {}
        
    def encode(self, messages: List[Dict], version: int = 0) -> bytes:
        """Encode a complete AMF packet"""
        self._reset_refs()
        stream = io.BytesIO()
        
        # Write version
        stream.write(struct.pack(">H", version))
        
        # Write headers (none for now)
        stream.write(struct.pack(">H", 0))
        
        # Write messages
        stream.write(struct.pack(">H", len(messages)))
        
        for msg in messages:
            self._encode_message(stream, msg, version)
            
        return stream.getvalue()
        
    def encode_value(self, value: Any, amf_version: int = 0) -> bytes:
        """Encode a single value"""
        self._reset_refs()
        stream = io.BytesIO()
        
        if amf_version == 0:
            self._encode_amf0(stream, value)
        else:
            self._encode_amf3(stream, value)
            
        return stream.getvalue()
        
    def _reset_refs(self):
        """Reset reference tables"""
        self._string_refs = {}
        self._object_refs = {}
        
    def _encode_message(self, stream: io.BytesIO, msg: Dict, version: int):
        """Encode AMF message"""
        target_uri = msg.get("target_uri", "null")
        response_uri = msg.get("response_uri", "/1")
        data = msg.get("data")
        
        self._write_utf8(stream, target_uri)
        self._write_utf8(stream, response_uri)
        
        # Encode data to temporary buffer
        temp = io.BytesIO()
        if version == 3:
            self._encode_amf3(temp, data)
        else:
            self._encode_amf0(temp, data)
            
        data_bytes = temp.getvalue()
        stream.write(struct.pack(">I", len(data_bytes)))
        stream.write(data_bytes)
        
    def _encode_amf0(self, stream: io.BytesIO, value: Any):
        """Encode value as AMF0"""
        if value is None:
            stream.write(struct.pack(">B", AMF0Type.NULL))
            
        elif isinstance(value, bool):
            stream.write(struct.pack(">B", AMF0Type.BOOLEAN))
            stream.write(struct.pack(">?", value))
            
        elif isinstance(value, (int, float)):
            stream.write(struct.pack(">B", AMF0Type.NUMBER))
            stream.write(struct.pack(">d", float(value)))
            
        elif isinstance(value, str):
            if len(value) > 65535:
                stream.write(struct.pack(">B", AMF0Type.LONG_STRING))
                encoded = value.encode('utf-8')
                stream.write(struct.pack(">I", len(encoded)))
                stream.write(encoded)
            else:
                stream.write(struct.pack(">B", AMF0Type.STRING))
                self._write_utf8(stream, value)
                
        elif isinstance(value, list):
            stream.write(struct.pack(">B", AMF0Type.STRICT_ARRAY))
            stream.write(struct.pack(">I", len(value)))
            for item in value:
                self._encode_amf0(stream, item)
                
        elif isinstance(value, dict):
            class_name = value.get("__class__")
            if class_name:
                stream.write(struct.pack(">B", AMF0Type.TYPED_OBJECT))
                self._write_utf8(stream, class_name)
            else:
                stream.write(struct.pack(">B", AMF0Type.OBJECT))
                
            for key, val in value.items():
                if key == "__class__":
                    continue
                self._write_utf8(stream, str(key))
                self._encode_amf0(stream, val)
                
            self._write_utf8(stream, "")
            stream.write(struct.pack(">B", AMF0Type.OBJECT_END))
            
        elif isinstance(value, datetime):
            stream.write(struct.pack(">B", AMF0Type.DATE))
            timestamp = value.timestamp() * 1000
            stream.write(struct.pack(">d", timestamp))
            stream.write(struct.pack(">h", 0))  # timezone
            
        elif isinstance(value, bytes):
            # Encode as string
            stream.write(struct.pack(">B", AMF0Type.STRING))
            self._write_utf8(stream, value.hex())
            
        else:
            stream.write(struct.pack(">B", AMF0Type.NULL))
            
    def _encode_amf3(self, stream: io.BytesIO, value: Any):
        """Encode value as AMF3"""
        if value is None:
            stream.write(struct.pack(">B", AMF3Type.NULL))
            
        elif isinstance(value, bool):
            stream.write(struct.pack(">B", AMF3Type.TRUE if value else AMF3Type.FALSE))
            
        elif isinstance(value, int) and -268435456 <= value <= 268435455:
            stream.write(struct.pack(">B", AMF3Type.INTEGER))
            self._write_u29(stream, value & 0x1FFFFFFF)
            
        elif isinstance(value, (int, float)):
            stream.write(struct.pack(">B", AMF3Type.DOUBLE))
            stream.write(struct.pack(">d", float(value)))
            
        elif isinstance(value, str):
            stream.write(struct.pack(">B", AMF3Type.STRING))
            self._write_amf3_string(stream, value)
            
        elif isinstance(value, list):
            stream.write(struct.pack(">B", AMF3Type.ARRAY))
            self._write_u29(stream, (len(value) << 1) | 1)
            stream.write(struct.pack(">B", 1))  # Empty key (end of assoc)
            for item in value:
                self._encode_amf3(stream, item)
                
        elif isinstance(value, dict):
            stream.write(struct.pack(">B", AMF3Type.OBJECT))
            # Dynamic object with no class name
            self._write_u29(stream, 0x0B)  # traits ref + dynamic
            self._write_amf3_string(stream, "")  # empty class name
            
            for key, val in value.items():
                self._write_amf3_string(stream, str(key))
                self._encode_amf3(stream, val)
                
            self._write_amf3_string(stream, "")  # End of dynamic props
            
        elif isinstance(value, bytes):
            stream.write(struct.pack(">B", AMF3Type.BYTE_ARRAY))
            self._write_u29(stream, (len(value) << 1) | 1)
            stream.write(value)
            
        elif isinstance(value, datetime):
            stream.write(struct.pack(">B", AMF3Type.DATE))
            self._write_u29(stream, 1)  # Not a reference
            timestamp = value.timestamp() * 1000
            stream.write(struct.pack(">d", timestamp))
            
        else:
            stream.write(struct.pack(">B", AMF3Type.NULL))
            
    def _write_utf8(self, stream: io.BytesIO, value: str):
        """Write UTF-8 string with 16-bit length"""
        encoded = value.encode('utf-8')
        stream.write(struct.pack(">H", len(encoded)))
        stream.write(encoded)
        
    def _write_u29(self, stream: io.BytesIO, value: int):
        """Write variable-length unsigned 29-bit integer"""
        value &= 0x1FFFFFFF
        
        if value < 0x80:
            stream.write(struct.pack(">B", value))
        elif value < 0x4000:
            stream.write(struct.pack(">B", (value >> 7) | 0x80))
            stream.write(struct.pack(">B", value & 0x7F))
        elif value < 0x200000:
            stream.write(struct.pack(">B", (value >> 14) | 0x80))
            stream.write(struct.pack(">B", ((value >> 7) & 0x7F) | 0x80))
            stream.write(struct.pack(">B", value & 0x7F))
        else:
            stream.write(struct.pack(">B", (value >> 22) | 0x80))
            stream.write(struct.pack(">B", ((value >> 15) & 0x7F) | 0x80))
            stream.write(struct.pack(">B", ((value >> 8) & 0x7F) | 0x80))
            stream.write(struct.pack(">B", value & 0xFF))
            
    def _write_amf3_string(self, stream: io.BytesIO, value: str):
        """Write AMF3 string"""
        if not value:
            self._write_u29(stream, 1)  # Empty string
            return
            
        if value in self._string_refs:
            self._write_u29(stream, self._string_refs[value] << 1)
        else:
            encoded = value.encode('utf-8')
            self._write_u29(stream, (len(encoded) << 1) | 1)
            stream.write(encoded)
            self._string_refs[value] = len(self._string_refs)


class JSONCodec:
    """JSON encoder/decoder for game data"""
    
    @staticmethod
    def encode(data: Any) -> bytes:
        """Encode data to JSON bytes"""
        return json.dumps(data, separators=(',', ':')).encode('utf-8')
        
    @staticmethod
    def decode(data: bytes) -> Any:
        """Decode JSON bytes to data"""
        return json.loads(data.decode('utf-8'))
        
    @staticmethod
    def pretty_encode(data: Any) -> str:
        """Encode data to pretty JSON string"""
        return json.dumps(data, indent=2)


class XMLCodec:
    """XML encoder/decoder for game data"""
    
    @staticmethod
    def encode(data: Dict, root_name: str = "root") -> bytes:
        """Encode dict to XML bytes"""
        root = ET.Element(root_name)
        XMLCodec._dict_to_xml(data, root)
        return ET.tostring(root, encoding='utf-8')
        
    @staticmethod
    def decode(data: bytes) -> Dict:
        """Decode XML bytes to dict"""
        root = ET.fromstring(data)
        return XMLCodec._xml_to_dict(root)
        
    @staticmethod
    def _dict_to_xml(data: Any, parent: ET.Element):
        """Convert dict to XML elements"""
        if isinstance(data, dict):
            for key, value in data.items():
                child = ET.SubElement(parent, str(key))
                XMLCodec._dict_to_xml(value, child)
        elif isinstance(data, list):
            for item in data:
                child = ET.SubElement(parent, "item")
                XMLCodec._dict_to_xml(item, child)
        else:
            parent.text = str(data) if data is not None else ""
            
    @staticmethod
    def _xml_to_dict(element: ET.Element) -> Any:
        """Convert XML element to dict"""
        if len(element) == 0:
            # Leaf node
            text = element.text
            if text is None:
                return None
            # Try to parse as number
            try:
                if '.' in text:
                    return float(text)
                return int(text)
            except ValueError:
                if text.lower() == 'true':
                    return True
                elif text.lower() == 'false':
                    return False
                return text
                
        # Check if all children have same name (array)
        child_names = [child.tag for child in element]
        if len(set(child_names)) == 1 and child_names[0] == "item":
            return [XMLCodec._xml_to_dict(child) for child in element]
            
        # Object
        result = {}
        for child in element:
            result[child.tag] = XMLCodec._xml_to_dict(child)
        return result


class ProtocolCodec:
    """
    Unified codec for all game protocol formats.
    
    Auto-detects format and provides encode/decode methods.
    """
    
    def __init__(self):
        self._amf_decoder = AMFDecoder()
        self._amf_encoder = AMFEncoder()
        
    def detect_format(self, data: bytes) -> str:
        """Detect data format"""
        if len(data) < 2:
            return "unknown"
            
        # Check for AMF
        if data[0:2] == b'\x00\x00' or data[0:2] == b'\x00\x03':
            return "amf"
            
        # Check for JSON
        if data[0:1] in [b'{', b'[']:
            return "json"
            
        # Check for XML
        if data[0:1] == b'<' or data[0:5] == b'<?xml':
            return "xml"
            
        return "binary"
        
    def decode(self, data: bytes, format_hint: str = None) -> Tuple[str, Any]:
        """
        Decode data, auto-detecting format.
        Returns (format, decoded_data)
        """
        format_type = format_hint or self.detect_format(data)
        
        try:
            if format_type == "amf":
                return "amf", self._amf_decoder.decode(data).to_dict()
            elif format_type == "json":
                return "json", JSONCodec.decode(data)
            elif format_type == "xml":
                return "xml", XMLCodec.decode(data)
            else:
                return "binary", {"raw": data.hex(), "length": len(data)}
        except Exception as e:
            logger.error(f"Decode error ({format_type}): {e}")
            return "error", {"error": str(e), "raw": data.hex()[:100]}
            
    def encode(self, data: Any, format_type: str = "amf", 
               amf_version: int = 0) -> bytes:
        """Encode data to specified format"""
        try:
            if format_type == "amf":
                if isinstance(data, dict) and "messages" in data:
                    return self._amf_encoder.encode(data["messages"], amf_version)
                return self._amf_encoder.encode_value(data, amf_version)
            elif format_type == "json":
                return JSONCodec.encode(data)
            elif format_type == "xml":
                return XMLCodec.encode(data)
            else:
                if isinstance(data, bytes):
                    return data
                return str(data).encode('utf-8')
        except Exception as e:
            logger.error(f"Encode error ({format_type}): {e}")
            return b""
            
    def get_statistics(self) -> Dict:
        """Get codec statistics"""
        return {
            "formats_supported": ["amf0", "amf3", "json", "xml", "binary"],
        }


# Singleton
_codec: Optional[ProtocolCodec] = None

def get_protocol_codec() -> ProtocolCodec:
    """Get singleton protocol codec"""
    global _codec
    if _codec is None:
        _codec = ProtocolCodec()
    return _codec
