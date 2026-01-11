# 🔧 SVONY STUDIO - COMPLETE TOOLS REGISTRY
## 55 Tools with Full Implementation Specifications

---

> **Purpose**: Detailed specification for every tool to be integrated into Svony Studio
> **Standard**: Each tool must be FULLY FUNCTIONAL - no stubs, no simulations
> **Location**: `D:\svony_studio\src\tools\`

---

## 📊 TOOL STATUS TRACKER

| ID | Tool Name | Status | File | Lines | Tests |
|----|-----------|--------|------|-------|-------|
| 1 | AMF Packet Decoder | 🔴 TODO | amf_decoder.py | 0/400 | ❌ |
| 2 | Traffic Sniffer | 🔴 TODO | traffic_sniffer.py | 0/600 | ❌ |
| 3 | Packet Replayer | 🔴 TODO | packet_replayer.py | 0/300 | ❌ |
| 4 | Server Simulator | 🔴 TODO | server_simulator.py | 0/500 | ❌ |
| 5 | MITM Proxy | 🔴 TODO | mitm_proxy.py | 0/800 | ❌ |
| 6 | Connection Logger | 🔴 TODO | connection_logger.py | 0/200 | ❌ |
| 7 | Token Generator | 🔴 TODO | token_generator.py | 0/150 | ❌ |
| 8 | API Monitor | 🔴 TODO | api_monitor.py | 0/250 | ❌ |
| 9 | Latency Analyzer | 🔴 TODO | latency_analyzer.py | 0/200 | ❌ |
| 10 | Packet Fuzzer | 🔴 TODO | packet_fuzzer.py | 0/350 | ❌ |
| ... | ... | ... | ... | ... | ... |

---

## 🌐 CATEGORY A: NETWORK & PROTOCOL TOOLS (12)

### TOOL #1: AMF Packet Decoder
**Priority**: 🔴 CRITICAL
**File**: `src/tools/network/amf_decoder.py`
**UI Location**: Protocol Tab → Decoder Sub-tab

```python
"""
AMF3 (Action Message Format) Packet Decoder

Decodes binary AMF3 data from Evony network traffic into readable Python objects.
Supports all AMF3 types including references, external classes, and vectors.
"""

class AMF3Type(Enum):
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
    BYTEARRAY = 0x0C
    VECTOR_INT = 0x0D
    VECTOR_UINT = 0x0E
    VECTOR_DOUBLE = 0x0F
    VECTOR_OBJECT = 0x10
    DICTIONARY = 0x11

class AMFDecoder:
    """
    Full AMF3 decoder implementation.
    
    Methods:
        decode(data: bytes) -> Any
        decode_hex(hex_string: str) -> Any
        decode_base64(b64_string: str) -> Any
        to_json(data: bytes, indent: int = 2) -> str
        decode_command(data: bytes) -> Tuple[str, dict]
        
    Example:
        decoder = AMFDecoder()
        packet = bytes.fromhex("0a0b01...")
        result = decoder.decode(packet)
        print(decoder.to_json(packet))
    """
    
    def __init__(self):
        self.string_refs: List[str] = []
        self.object_refs: List[Any] = []
        self.trait_refs: List[dict] = []
        
    def decode(self, data: bytes) -> Any:
        """Decode AMF3 binary data to Python object."""
        # MUST IMPLEMENT: Full AMF3 decoding
        pass
        
    def _read_u29(self, stream: BytesIO) -> int:
        """Read variable-length unsigned 29-bit integer."""
        # MUST IMPLEMENT: U29 reading per AMF3 spec
        pass
        
    def _read_string(self, stream: BytesIO) -> str:
        """Read AMF3 string with reference support."""
        # MUST IMPLEMENT: String reading with refs
        pass

# Required exports
__all__ = ['AMFDecoder', 'AMF3Type']
```

**Dependencies**: None (pure Python)
**Test File**: `tests/test_amf_decoder.py`
**Test Cases**:
- Decode all primitive types
- Decode arrays and objects
- Handle string references
- Decode Evony login response
- Decode city data packet

---

### TOOL #2: Real-time Traffic Sniffer
**Priority**: 🔴 CRITICAL
**File**: `src/tools/network/traffic_sniffer.py`
**UI Location**: Testing Suite → Sniffer Tab

```python
"""
Real-time Network Traffic Sniffer for Evony

Captures and decodes live network traffic between Evony client and server.
Supports proxy mode (MITM) and passive mode (packet capture).
"""

class TrafficSniffer:
    """
    Network traffic capture and analysis.
    
    Modes:
        - proxy: MITM proxy intercepts all traffic
        - passive: Captures packets without interception
        
    Methods:
        start_capture(mode: str = "proxy", port: int = 8888) -> None
        stop_capture() -> List[Packet]
        get_packets(filter_cmd: str = None) -> List[Packet]
        export_session(path: str, format: str = "json") -> None
        
    Signals:
        packet_captured(packet: Packet)
        connection_established(host: str, port: int)
        connection_closed()
    """
    
    def __init__(self, decoder: AMFDecoder = None):
        self.decoder = decoder or AMFDecoder()
        self.packets: List[Packet] = []
        self.is_capturing = False
        
    def start_capture(self, mode: str = "proxy", port: int = 8888):
        """Start capturing traffic."""
        # MUST IMPLEMENT: Actual packet capture
        pass

@dataclass
class Packet:
    """Captured packet data"""
    timestamp: datetime
    direction: str  # "inbound" or "outbound"
    command: str
    raw_data: bytes
    decoded_data: dict
    source_ip: str
    dest_ip: str
```

**Dependencies**: 
- `scapy` or `pyshark` for packet capture
- `mitmproxy` for proxy mode
**Test Cases**:
- Capture login sequence
- Filter by command type
- Export to JSON/PCAP

---

### TOOL #3: Packet Replay System
**Priority**: 🔴 CRITICAL
**File**: `src/tools/network/packet_replayer.py`

```python
"""
Packet Replay System

Replays captured packet sequences for testing and debugging.
Supports variable speed, pause/resume, and packet modification.
"""

class PacketReplayer:
    """
    Replay captured network sessions.
    
    Methods:
        load_session(path: str) -> int  # Returns packet count
        play(speed: float = 1.0) -> None
        pause() -> None
        resume() -> None
        step() -> Packet  # Single step
        seek(index: int) -> None
        modify_packet(index: int, data: dict) -> None
    """
    pass
```

---

### TOOL #4: Server Response Simulator
**Priority**: 🟡 HIGH
**File**: `src/tools/network/server_simulator.py`

```python
"""
Server Response Simulator

Simulates Evony server responses for offline testing.
Uses recorded sessions or generates synthetic responses.
"""

class ServerSimulator:
    """
    Simulate server responses.
    
    Methods:
        start(port: int = 8889) -> None
        stop() -> None
        set_response(command: str, response: dict) -> None
        load_responses(path: str) -> None
        inject_error(command: str, error: str) -> None
    """
    pass
```

---

### TOOL #5: Man-in-the-Middle Proxy
**Priority**: 🟡 HIGH
**File**: `src/tools/network/mitm_proxy.py`

```python
"""
MITM Proxy for Traffic Interception

Intercepts, views, and modifies traffic between client and server.
Supports breakpoints, request/response modification, and logging.
"""

class MITMProxy:
    """
    Full MITM proxy implementation.
    
    Features:
        - SSL/TLS termination
        - Request modification
        - Response modification
        - Breakpoints on commands
        - Traffic logging
        
    Methods:
        start(listen_port: int, target_host: str, target_port: int)
        stop()
        add_breakpoint(command: str, callback: Callable)
        remove_breakpoint(command: str)
        modify_request(command: str, modifier: Callable)
        modify_response(command: str, modifier: Callable)
    """
    pass
```

---

## 🤖 CATEGORY B: BOT AUTOMATION TOOLS (15)

### TOOL #13: Command Executor
**Priority**: 🔴 CRITICAL
**File**: `src/tools/automation/command_executor.py`

```python
"""
Bot Command Executor

Executes AutoEvony bot commands with full parameter validation.
Direct interface to Commands.as (2,186 lines of command definitions).

Available Commands (from source analysis):
- qFarm(npcLevel, maxTroops, heroType)
- trainTroops(cityId, troopType, count)
- buildStructure(cityId, buildingType, position)
- attackTarget(x, y, armyConfig)
- collectResources(cityId)
- reassignHero(heroId, cityId)
- sendMail(recipient, subject, body)
- dismissTroops(cityId, troopType, count)
- transportResources(fromCity, toCity, resources)
- scoutTarget(x, y)
- ... (50+ more commands)
"""

class CommandExecutor:
    """
    Execute bot commands safely.
    
    Methods:
        execute(command: str, **params) -> CommandResult
        execute_batch(commands: List[dict]) -> List[CommandResult]
        validate_params(command: str, params: dict) -> bool
        get_command_help(command: str) -> str
        list_commands() -> List[str]
    """
    
    # Command definitions from Commands.as
    COMMANDS = {
        "qFarm": {
            "params": ["npcLevel", "maxTroops", "heroType"],
            "types": [int, int, str],
            "description": "Quick farm NPC at specified level"
        },
        "trainTroops": {
            "params": ["cityId", "troopType", "count"],
            "types": [int, str, int],
            "description": "Train troops in specified city"
        },
        # ... all 50+ commands
    }
```

---

### TOOL #14: Script IDE
**Priority**: 🔴 CRITICAL
**File**: `src/tools/automation/script_ide.py`

```python
"""
Bot Script IDE

Full-featured editor for creating and managing bot automation scripts.
Based on Script.as and ScriptCmd.as from AutoEvony source.

Script Language Features:
- Variables: $varname = value
- Commands: commandName(param1, param2)
- Conditions: if resource.gold > 100000
- Loops: repeat 10 times
- Delays: wait 5 seconds
- Comments: # or //
"""

class ScriptIDE:
    """
    Script editor with validation and debugging.
    
    Methods:
        new_script(name: str) -> Script
        open_script(path: str) -> Script
        save_script(script: Script, path: str) -> bool
        validate_script(script: Script) -> List[ValidationError]
        run_script(script: Script) -> ScriptResult
        debug_script(script: Script, breakpoints: List[int]) -> None
        stop_script() -> None
    """
    pass
```

---

## 🔐 CATEGORY D: ENCRYPTION TOOLS (8)

### TOOL #38: Universal Decryptor
**Priority**: 🔴 CRITICAL
**File**: `src/tools/crypto/universal_decryptor.py`

```python
"""
Universal Evony Decryptor

Decrypts all Evony data formats using extracted keys.
Auto-detects encryption type and applies correct decryption.

Known Keys (from source analysis):
- API Key: 9f758e2deccbe6244f734371b9642eda
- Token Key: IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}
- Game Keys: EvonyGameKey2009, EvonyNetKey2009, etc.
- XOR Key: 0xAA (170)
- Salts: evony_salt_2010, evony_session_2010, evony_game_2010
"""

class UniversalDecryptor:
    """
    Auto-detect and decrypt Evony data.
    
    Methods:
        decrypt(data: bytes) -> Tuple[bytes, str]  # Returns (decrypted, method_used)
        decrypt_file(path: str, output: str = None) -> str
        detect_encryption(data: bytes) -> str
        set_custom_key(name: str, key: bytes) -> None
    """
    
    # All known keys
    KEYS = {
        "api": bytes.fromhex("9f758e2deccbe6244f734371b9642eda"),
        "xor": bytes([0xAA]),
        "game": b"EvonyGameKey2009",
        "network": b"EvonyNetKey2009",
        "resource": b"EvonyResKey2009",
        "config": b"EvonyConfigKey2009",
        "data": b"EvonyDataKey2009",
    }
    
    SALTS = {
        "password": b"evony_salt_2010",
        "session": b"evony_session_2010",
        "game": b"evony_game_2010",
    }
```

---

### TOOL #39: XOR Decrypter
**Priority**: 🔴 CRITICAL
**File**: `src/tools/crypto/xor_decrypter.py`

```python
"""
XOR Decrypter

Simple XOR decryption using Evony's known XOR key (0xAA).
Used for basic obfuscation in client data.
"""

class XORDecrypter:
    """
    XOR encryption/decryption.
    
    Methods:
        decrypt(data: bytes, key: int = 0xAA) -> bytes
        encrypt(data: bytes, key: int = 0xAA) -> bytes
        decrypt_file(path: str, output: str = None) -> str
        detect_xor_key(data: bytes) -> int
    """
    
    DEFAULT_KEY = 0xAA  # 170 decimal
    
    def decrypt(self, data: bytes, key: int = None) -> bytes:
        """XOR decrypt data."""
        key = key or self.DEFAULT_KEY
        return bytes([b ^ key for b in data])
```

---

## 📊 CATEGORY E: DATA & ANALYSIS TOOLS (10)

### TOOL #46: Troop Statistics Calculator
**Priority**: 🔴 CRITICAL
**File**: `src/tools/data/troop_calculator.py`

```python
"""
Troop Statistics Calculator

Parses XMLTroop.bin and provides troop data analysis.
Calculates attack power, resource costs, training times.

Data Location: G:\...\swf5_contents\binaryData\XMLTroop.bin
"""

class TroopCalculator:
    """
    Troop statistics and calculations.
    
    Methods:
        load_data(path: str = None) -> bool
        get_troop(name: str) -> TroopData
        list_troops() -> List[str]
        calculate_attack_power(army: dict) -> int
        calculate_training_cost(troop: str, count: int) -> ResourceCost
        calculate_training_time(troop: str, count: int, barracks_level: int) -> int
        compare_troops(troop1: str, troop2: str) -> ComparisonResult
    """
    
    # Troop types (from source)
    TROOP_TYPES = [
        "Worker", "Warrior", "Scout", "Pikeman", "Swordsman",
        "Archer", "Cavalry", "Cataphract", "Transporter",
        "Ballista", "Battering Ram", "Catapult"
    ]

@dataclass
class TroopData:
    """Troop statistics"""
    name: str
    attack: int
    defense: int
    life: int
    speed: int
    range: int
    load: int
    food_per_hour: float
    upkeep: float
    build_time: int  # seconds
    cost: ResourceCost
    requirements: List[str]
```

---

## 🗂️ IMPLEMENTATION CHECKLIST

For each tool, verify:

- [ ] File created in correct location
- [ ] All methods implemented (no `pass` or stubs)
- [ ] Docstrings complete
- [ ] Type hints on all methods
- [ ] Error handling implemented
- [ ] Logging added
- [ ] Unit tests created
- [ ] Integration test added
- [ ] UI panel wired up
- [ ] Documentation updated

---

## 📁 FILE STRUCTURE TEMPLATE

Each tool file should follow this structure:

```python
"""
Tool Name - Brief Description

Detailed description of what this tool does.
Reference to source files used.
"""

import logging
from typing import Any, Dict, List, Optional, Tuple
from dataclasses import dataclass
from pathlib import Path

logger = logging.getLogger(__name__)

# Constants
DEFAULT_VALUE = ...

# Data classes
@dataclass
class ResultData:
    """Result data structure"""
    pass

# Main class
class ToolName:
    """
    Main tool class.
    
    Attributes:
        attr1: Description
        
    Methods:
        method1: Description
    """
    
    def __init__(self, config: dict = None):
        """Initialize tool."""
        self.config = config or {}
        
    def main_method(self, param: type) -> ReturnType:
        """
        Method description.
        
        Args:
            param: Description
            
        Returns:
            Description
            
        Raises:
            ErrorType: When condition
        """
        try:
            # Implementation
            pass
        except Exception as e:
            logger.error(f"Error: {e}")
            raise

# Module exports
__all__ = ['ToolName', 'ResultData']
```

---

*This registry tracks all 55 tools. Update status as implemented.*
