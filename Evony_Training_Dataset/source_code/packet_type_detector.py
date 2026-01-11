"""
PacketTypeDetector - Classify and Analyze Game Protocol Packets

Identifies packet types from raw/decrypted data:
- Command packets (client → server)
- Response packets (server → client)
- Heartbeat/system packets
- Chat/mail packets
"""

import logging
import struct
import re
from dataclasses import dataclass, field
from enum import Enum, IntEnum
from typing import Dict, Optional, List, Any, Tuple, Set
from collections import defaultdict
import time
import json

logger = logging.getLogger(__name__)


class PacketDirection(Enum):
    """Direction of packet flow"""
    CLIENT_TO_SERVER = "c2s"
    SERVER_TO_CLIENT = "s2c"
    UNKNOWN = "unknown"


class PacketCategory(Enum):
    """High-level packet categories"""
    LOGIN = "login"
    CITY = "city"
    ARMY = "army"
    RESEARCH = "research"
    ALLIANCE = "alliance"
    CHAT = "chat"
    MAP = "map"
    HERO = "hero"
    ITEM = "item"
    QUEST = "quest"
    EVENT = "event"
    TRADE = "trade"
    SYSTEM = "system"
    HEARTBEAT = "heartbeat"
    UNKNOWN = "unknown"


class CommandID(IntEnum):
    """Known command IDs (extracted from protocol analysis)"""
    # Login/Session
    LOGIN_REQUEST = 0x0001
    LOGOUT = 0x0002
    KEEPALIVE_PING = 0xF001
    KEEPALIVE_PONG = 0xF002
    
    # City Commands
    CITY_BUILD = 0x0101
    CITY_UPGRADE = 0x0102
    CITY_DEMOLISH = 0x0103
    CITY_SPEEDUP = 0x0104
    CITY_CANCEL = 0x0105
    
    # Army Commands
    ATTACK_SEND = 0x0010
    ATTACK_CANCEL = 0x0011
    MARCH_CREATE = 0x0020
    MARCH_RECALL = 0x0021
    SCOUT_SEND = 0x0030
    SCOUT_CANCEL = 0x0031
    TROOP_TRAIN = 0x0301
    TROOP_DISMISS = 0x0302
    TROOP_HEAL = 0x0303
    
    # Research
    RESEARCH_START = 0x0201
    RESEARCH_CANCEL = 0x0202
    RESEARCH_SPEEDUP = 0x0203
    
    # Alliance
    ALLIANCE_JOIN = 0x0401
    ALLIANCE_LEAVE = 0x0402
    ALLIANCE_DONATE = 0x0403
    ALLIANCE_CHAT = 0x0404
    
    # Trade
    TRADE_CREATE = 0x0040
    TRADE_CANCEL = 0x0041
    TRADE_ACCEPT = 0x0042
    
    # Map
    MAP_VIEW = 0x0501
    MAP_TILE_INFO = 0x0502
    
    # Hero
    HERO_ASSIGN = 0x0601
    HERO_UNASSIGN = 0x0602
    HERO_UPGRADE = 0x0603
    
    # Responses (0x8000+ = response versions)
    LOGIN_RESPONSE = 0x8001
    BUILD_RESULT = 0x8101
    ATTACK_RESULT = 0x8010
    MARCH_UPDATE = 0x8020
    SCOUT_REPORT = 0x8030
    RESEARCH_RESULT = 0x8201
    TRAIN_RESULT = 0x8301
    ALLIANCE_UPDATE = 0x8401
    TRADE_RESULT = 0x8040
    WORLD_MAP_UPDATE = 0x9001
    PLAYER_UPDATE = 0x9002
    RESOURCE_UPDATE = 0x9003
    CHAT_MESSAGE = 0x8050
    MAIL_RECEIVED = 0x8060
    
    # System
    SERVER_TIME = 0xF003
    VERSION_CHECK = 0xF004
    ERROR_RESPONSE = 0xFFFF


@dataclass
class PacketHeader:
    """Parsed packet header"""
    version: int
    length: int
    command_id: int
    sequence: int
    flags: int = 0
    
    @property
    def is_response(self) -> bool:
        return self.command_id >= 0x8000
        
    @property
    def is_system(self) -> bool:
        return self.command_id >= 0xF000


@dataclass
class PacketInfo:
    """Complete packet information"""
    packet_id: str
    direction: PacketDirection
    category: PacketCategory
    command_id: int
    command_name: str
    header: PacketHeader
    payload: bytes
    decoded_payload: Optional[Dict] = None
    timestamp: float = field(default_factory=time.time)
    raw_data: bytes = b""
    metadata: Dict[str, Any] = field(default_factory=dict)
    
    def to_dict(self) -> Dict:
        return {
            "packet_id": self.packet_id,
            "direction": self.direction.value,
            "category": self.category.value,
            "command_id": hex(self.command_id),
            "command_name": self.command_name,
            "timestamp": self.timestamp,
            "payload_length": len(self.payload),
            "decoded_payload": self.decoded_payload,
            "metadata": self.metadata,
        }


class PacketTypeDetector:
    """
    Detects and classifies game protocol packets.
    
    Features:
    - Header parsing for multiple protocol versions
    - Command ID to name mapping
    - Category classification
    - Pattern learning for unknown packets
    - Protocol statistics
    """
    
    # Header format: version(2) + length(2) + cmd_id(2) + seq(2) + flags(2)
    HEADER_SIZE = 10
    HEADER_FORMAT = "<HHHHH"
    
    # Alternative header formats for different protocol versions
    ALT_HEADER_FORMATS = {
        "v1": "<HHH",      # 6 bytes: version, length, cmd_id
        "v2": "<HHHH",     # 8 bytes: version, length, cmd_id, seq
        "v3": "<HHHHH",    # 10 bytes: version, length, cmd_id, seq, flags
    }
    
    # Command ID to category mapping
    CATEGORY_MAP = {
        range(0x0001, 0x0010): PacketCategory.LOGIN,
        range(0x0010, 0x0040): PacketCategory.ARMY,
        range(0x0040, 0x0050): PacketCategory.TRADE,
        range(0x0101, 0x0200): PacketCategory.CITY,
        range(0x0201, 0x0300): PacketCategory.RESEARCH,
        range(0x0301, 0x0400): PacketCategory.ARMY,
        range(0x0401, 0x0500): PacketCategory.ALLIANCE,
        range(0x0501, 0x0600): PacketCategory.MAP,
        range(0x0601, 0x0700): PacketCategory.HERO,
        range(0x8001, 0x8010): PacketCategory.LOGIN,
        range(0x8010, 0x8040): PacketCategory.ARMY,
        range(0x8040, 0x8050): PacketCategory.TRADE,
        range(0x8050, 0x8070): PacketCategory.CHAT,
        range(0x8101, 0x8200): PacketCategory.CITY,
        range(0x8201, 0x8300): PacketCategory.RESEARCH,
        range(0x8301, 0x8400): PacketCategory.ARMY,
        range(0x8401, 0x8500): PacketCategory.ALLIANCE,
        range(0x9001, 0x9100): PacketCategory.SYSTEM,
        range(0xF001, 0xFFFF): PacketCategory.HEARTBEAT,
    }
    
    def __init__(self):
        # Build command name lookup
        self._command_names: Dict[int, str] = {}
        for cmd in CommandID:
            self._command_names[cmd.value] = cmd.name
            
        # Statistics
        self._stats = defaultdict(int)
        self._unknown_commands: Set[int] = set()
        self._packet_counter = 0
        
        # Pattern learning
        self._learned_patterns: Dict[int, Dict] = {}
        
    def detect(self, data: bytes, 
               direction: PacketDirection = PacketDirection.UNKNOWN) -> Optional[PacketInfo]:
        """Detect packet type from raw/decrypted data"""
        if len(data) < 6:
            return None
            
        try:
            # Try different header formats
            header = self._parse_header(data)
            if not header:
                return None
                
            # Extract payload
            payload_start = self._get_payload_offset(data)
            payload = data[payload_start:]
            
            # Determine direction from command ID if unknown
            if direction == PacketDirection.UNKNOWN:
                direction = self._infer_direction(header.command_id)
                
            # Get category
            category = self._get_category(header.command_id)
            
            # Get command name
            command_name = self._command_names.get(
                header.command_id, 
                f"UNKNOWN_{hex(header.command_id)}"
            )
            
            # Generate packet ID
            self._packet_counter += 1
            packet_id = f"pkt_{self._packet_counter:08d}"
            
            # Create packet info
            packet_info = PacketInfo(
                packet_id=packet_id,
                direction=direction,
                category=category,
                command_id=header.command_id,
                command_name=command_name,
                header=header,
                payload=payload,
                raw_data=data,
            )
            
            # Try to decode payload
            packet_info.decoded_payload = self._decode_payload(
                header.command_id, payload
            )
            
            # Update statistics
            self._update_stats(packet_info)
            
            return packet_info
            
        except Exception as e:
            logger.error(f"Failed to detect packet type: {e}")
            return None
            
    def detect_from_amf(self, amf_data: Dict, 
                        direction: PacketDirection = PacketDirection.UNKNOWN) -> Optional[PacketInfo]:
        """Detect packet type from decoded AMF data"""
        try:
            # AMF packets typically have a 'cmd' or 'command' field
            cmd_field = amf_data.get('cmd') or amf_data.get('command') or amf_data.get('c')
            
            if not cmd_field:
                return None
                
            # Try to find matching command
            command_id = self._find_command_by_name(cmd_field)
            
            self._packet_counter += 1
            
            return PacketInfo(
                packet_id=f"pkt_{self._packet_counter:08d}",
                direction=direction,
                category=self._get_category(command_id),
                command_id=command_id,
                command_name=str(cmd_field),
                header=PacketHeader(0, 0, command_id, 0),
                payload=b"",
                decoded_payload=amf_data,
            )
            
        except Exception as e:
            logger.error(f"Failed to detect AMF packet: {e}")
            return None
            
    def learn_pattern(self, command_id: int, packet_samples: List[PacketInfo]):
        """Learn packet structure from samples"""
        if not packet_samples:
            return
            
        patterns = {
            "command_id": command_id,
            "samples": len(packet_samples),
            "avg_payload_size": sum(len(p.payload) for p in packet_samples) / len(packet_samples),
            "directions": list(set(p.direction.value for p in packet_samples)),
            "field_patterns": self._extract_field_patterns(packet_samples),
        }
        
        self._learned_patterns[command_id] = patterns
        logger.info(f"Learned pattern for command {hex(command_id)}")
        
    def get_command_info(self, command_id: int) -> Dict:
        """Get information about a command"""
        return {
            "command_id": hex(command_id),
            "name": self._command_names.get(command_id, "UNKNOWN"),
            "category": self._get_category(command_id).value,
            "is_response": command_id >= 0x8000,
            "is_system": command_id >= 0xF000,
            "learned_pattern": self._learned_patterns.get(command_id),
        }
        
    def get_all_commands(self) -> List[Dict]:
        """Get all known commands"""
        commands = []
        for cmd_id, name in self._command_names.items():
            commands.append(self.get_command_info(cmd_id))
        return commands
        
    def get_statistics(self) -> Dict:
        """Get detection statistics"""
        return {
            "total_packets": self._packet_counter,
            "by_category": dict(self._stats),
            "unknown_commands": list(self._unknown_commands),
            "learned_patterns": len(self._learned_patterns),
        }
        
    def register_command(self, command_id: int, name: str, 
                         category: PacketCategory = PacketCategory.UNKNOWN):
        """Register a new command"""
        self._command_names[command_id] = name
        logger.info(f"Registered command: {name} ({hex(command_id)})")
        
    # ========== Private Methods ==========
    
    def _parse_header(self, data: bytes) -> Optional[PacketHeader]:
        """Parse packet header"""
        if len(data) < 6:
            return None
            
        # Try v3 format first (full header)
        if len(data) >= 10:
            try:
                version, length, cmd_id, seq, flags = struct.unpack(
                    self.HEADER_FORMAT, data[:10]
                )
                return PacketHeader(version, length, cmd_id, seq, flags)
            except:
                pass
                
        # Try v2 format
        if len(data) >= 8:
            try:
                version, length, cmd_id, seq = struct.unpack(
                    self.ALT_HEADER_FORMATS["v2"], data[:8]
                )
                return PacketHeader(version, length, cmd_id, seq)
            except:
                pass
                
        # Try v1 format (minimal)
        try:
            version, length, cmd_id = struct.unpack(
                self.ALT_HEADER_FORMATS["v1"], data[:6]
            )
            return PacketHeader(version, length, cmd_id, 0)
        except:
            return None
            
    def _get_payload_offset(self, data: bytes) -> int:
        """Determine where payload starts"""
        # Check for AMF marker
        if len(data) > 2 and data[0:2] == b'\x00\x03':
            return 0  # AMF data starts at beginning
            
        # Standard header size
        if len(data) >= 10:
            return 10
        elif len(data) >= 8:
            return 8
        else:
            return 6
            
    def _infer_direction(self, command_id: int) -> PacketDirection:
        """Infer direction from command ID"""
        if command_id >= 0x8000:
            return PacketDirection.SERVER_TO_CLIENT
        else:
            return PacketDirection.CLIENT_TO_SERVER
            
    def _get_category(self, command_id: int) -> PacketCategory:
        """Get category for command ID"""
        for cmd_range, category in self.CATEGORY_MAP.items():
            if command_id in cmd_range:
                return category
        return PacketCategory.UNKNOWN
        
    def _decode_payload(self, command_id: int, payload: bytes) -> Optional[Dict]:
        """Try to decode payload based on command"""
        if not payload:
            return None
            
        # Check if it's JSON
        try:
            if payload[0:1] in [b'{', b'[']:
                return json.loads(payload.decode('utf-8'))
        except:
            pass
            
        # Check learned patterns
        if command_id in self._learned_patterns:
            pattern = self._learned_patterns[command_id]
            return self._apply_pattern(payload, pattern)
            
        return None
        
    def _apply_pattern(self, payload: bytes, pattern: Dict) -> Optional[Dict]:
        """Apply learned pattern to decode payload"""
        # Basic implementation - extend based on pattern analysis
        field_patterns = pattern.get("field_patterns", {})
        result = {}
        
        for field_name, field_info in field_patterns.items():
            offset = field_info.get("offset", 0)
            size = field_info.get("size", 4)
            field_type = field_info.get("type", "int")
            
            try:
                if field_type == "int":
                    if size == 4:
                        result[field_name] = struct.unpack("<I", payload[offset:offset+4])[0]
                    elif size == 2:
                        result[field_name] = struct.unpack("<H", payload[offset:offset+2])[0]
                elif field_type == "string":
                    end = payload.find(b'\x00', offset)
                    result[field_name] = payload[offset:end].decode('utf-8', errors='ignore')
            except:
                pass
                
        return result if result else None
        
    def _extract_field_patterns(self, samples: List[PacketInfo]) -> Dict:
        """Extract field patterns from packet samples"""
        patterns = {}
        
        # Analyze decoded payloads for common fields
        if samples and samples[0].decoded_payload:
            for key in samples[0].decoded_payload.keys():
                values = [s.decoded_payload.get(key) for s in samples if s.decoded_payload]
                if all(isinstance(v, int) for v in values if v is not None):
                    patterns[key] = {"type": "int", "size": 4}
                elif all(isinstance(v, str) for v in values if v is not None):
                    patterns[key] = {"type": "string"}
                    
        return patterns
        
    def _find_command_by_name(self, name: str) -> int:
        """Find command ID by name"""
        name_upper = name.upper().replace(".", "_")
        
        for cmd_id, cmd_name in self._command_names.items():
            if cmd_name == name_upper or name_upper in cmd_name:
                return cmd_id
                
        # Unknown command
        return 0xFFFF
        
    def _update_stats(self, packet_info: PacketInfo):
        """Update statistics"""
        self._stats[packet_info.category.value] += 1
        self._stats["total"] += 1
        
        if packet_info.command_name.startswith("UNKNOWN"):
            self._unknown_commands.add(packet_info.command_id)


# Singleton
_detector: Optional[PacketTypeDetector] = None

def get_packet_type_detector() -> PacketTypeDetector:
    """Get singleton packet type detector"""
    global _detector
    if _detector is None:
        _detector = PacketTypeDetector()
    return _detector
