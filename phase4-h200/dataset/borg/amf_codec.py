"""
AMF Codec - Copied from Svony Studio for Evony data extraction
Handles AMF3 encoding/decoding for game protocol
"""

import struct
import io
import json
import logging
from dataclasses import dataclass, field
from enum import IntEnum
from typing import Dict, Optional, List, Any, Union
from datetime import datetime

logger = logging.getLogger(__name__)


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


class AMF3Decoder:
    """Decodes AMF3 binary data to Python objects"""
    
    def __init__(self):
        self._string_refs: List[str] = []
        self._object_refs: List[Any] = []
        self._trait_refs: List[Dict] = []
        
    def decode(self, data: bytes) -> Any:
        """Decode AMF3 data"""
        self._reset_refs()
        stream = io.BytesIO(data)
        return self._decode_value(stream)
        
    def _reset_refs(self):
        self._string_refs = []
        self._object_refs = []
        self._trait_refs = []
        
    def _decode_value(self, stream: io.BytesIO) -> Any:
        """Decode a single AMF3 value"""
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
            return self._read_string(stream)
        elif type_marker == AMF3Type.ARRAY:
            return self._decode_array(stream)
        elif type_marker == AMF3Type.OBJECT:
            return self._decode_object(stream)
        elif type_marker == AMF3Type.DATE:
            ref = self._read_u29(stream)
            if ref & 1 == 0:
                return self._object_refs[ref >> 1]
            timestamp = struct.unpack(">d", stream.read(8))[0]
            date = timestamp
            self._object_refs.append(date)
            return date
        elif type_marker == AMF3Type.BYTE_ARRAY:
            ref = self._read_u29(stream)
            if ref & 1 == 0:
                return self._object_refs[ref >> 1]
            length = ref >> 1
            data = stream.read(length)
            self._object_refs.append(data)
            return data.hex()
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
        
    def _read_string(self, stream: io.BytesIO) -> str:
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
        
    def _decode_array(self, stream: io.BytesIO) -> Union[List, Dict]:
        """Decode AMF3 array"""
        ref = self._read_u29(stream)
        
        if ref & 1 == 0:
            return self._object_refs[ref >> 1]
            
        count = ref >> 1
        
        # Read associative portion
        assoc = {}
        while True:
            key = self._read_string(stream)
            if not key:
                break
            assoc[key] = self._decode_value(stream)
            
        # Read dense portion
        dense = []
        for _ in range(count):
            dense.append(self._decode_value(stream))
            
        if assoc:
            result = {**assoc}
            for i, v in enumerate(dense):
                result[str(i)] = v
            self._object_refs.append(result)
            return result
        else:
            self._object_refs.append(dense)
            return dense
            
    def _decode_object(self, stream: io.BytesIO) -> Dict:
        """Decode AMF3 object"""
        ref = self._read_u29(stream)
        
        if ref & 1 == 0:
            return self._object_refs[ref >> 1]
            
        traits_ref = ref >> 1
        
        if traits_ref & 1 == 0:
            traits = self._trait_refs[traits_ref >> 1]
        else:
            class_name = self._read_string(stream)
            is_externalizable = bool(traits_ref & 2)
            is_dynamic = bool(traits_ref & 4)
            prop_count = traits_ref >> 3
            
            props = []
            for _ in range(prop_count):
                props.append(self._read_string(stream))
                
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
        
        for prop in traits["properties"]:
            obj[prop] = self._decode_value(stream)
            
        if traits["is_dynamic"]:
            while True:
                key = self._read_string(stream)
                if not key:
                    break
                obj[key] = self._decode_value(stream)
                
        return obj


class AMF3Encoder:
    """Encodes Python objects to AMF3 binary"""
    
    def __init__(self):
        self._string_refs: Dict[str, int] = {}
        self._object_refs: Dict[int, int] = {}
        
    def encode(self, value: Any) -> bytes:
        """Encode value to AMF3"""
        self._reset_refs()
        stream = io.BytesIO()
        self._encode_value(stream, value)
        return stream.getvalue()
        
    def _reset_refs(self):
        self._string_refs = {}
        self._object_refs = {}
        
    def _encode_value(self, stream: io.BytesIO, value: Any):
        """Encode a single value"""
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
            self._write_string(stream, value)
        elif isinstance(value, list):
            stream.write(struct.pack(">B", AMF3Type.ARRAY))
            self._write_u29(stream, (len(value) << 1) | 1)
            stream.write(struct.pack(">B", 1))  # Empty assoc
            for item in value:
                self._encode_value(stream, item)
        elif isinstance(value, dict):
            stream.write(struct.pack(">B", AMF3Type.OBJECT))
            self._write_u29(stream, 0x0B)  # Dynamic object
            self._write_string(stream, "")  # No class name
            for key, val in value.items():
                self._write_string(stream, str(key))
                self._encode_value(stream, val)
            self._write_string(stream, "")  # End dynamic
        elif isinstance(value, bytes):
            stream.write(struct.pack(">B", AMF3Type.BYTE_ARRAY))
            self._write_u29(stream, (len(value) << 1) | 1)
            stream.write(value)
        else:
            stream.write(struct.pack(">B", AMF3Type.NULL))
            
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
            
    def _write_string(self, stream: io.BytesIO, value: str):
        """Write AMF3 string"""
        if not value:
            self._write_u29(stream, 1)
            return
            
        if value in self._string_refs:
            self._write_u29(stream, self._string_refs[value] << 1)
        else:
            encoded = value.encode('utf-8')
            self._write_u29(stream, (len(encoded) << 1) | 1)
            stream.write(encoded)
            self._string_refs[value] = len(self._string_refs)
