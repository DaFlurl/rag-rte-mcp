# 🛠️ COMPREHENSIVE TOOL IMPLEMENTATION SPECIFICATION
## 55+ Tools for Svony Studio Evony Automation Suite

---

## 📊 TOOL CATEGORIES OVERVIEW

| Category | Tool Count | Status |
|----------|-----------|--------|
| Network & Protocol | 12 | 🔵 Spec Complete |
| Bot Automation | 15 | 🔵 Spec Complete |
| SWF Reverse Engineering | 10 | 🔵 Spec Complete |
| Encryption & Decryption | 8 | 🔵 Spec Complete |
| Data & Analysis | 10 | 🔵 Spec Complete |
| **TOTAL** | **55** | **Ready for Implementation** |

---

## 🌐 NETWORK & PROTOCOL TOOLS (12)

### Tool 1: AMF Packet Decoder
**Purpose**: Decode binary AMF3 packets into readable format
**Source Files**: `Connection.as`, AMF protocol docs
**UI Location**: Protocol Panel → Decoder Tab

```python
# Implementation: src/tools/amf_packet_decoder.py
class AMFPacketDecoder:
    """
    Decodes AMF3 (Action Message Format) binary data.
    
    Features:
    - Full AMF3 type support (primitives, arrays, objects, dates)
    - Reference resolution for strings and objects
    - Command name extraction
    - Pretty-printed output
    
    Input: Raw bytes or hex string
    Output: Structured Python dict/JSON
    """
    
    def decode(self, data: bytes) -> dict:
        """Decode AMF packet to dict."""
        pass
    
    def decode_hex(self, hex_string: str) -> dict:
        """Decode hex string to dict."""
        pass
    
    def to_json(self, data: bytes, indent: int = 2) -> str:
        """Decode to pretty JSON string."""
        pass
```

### Tool 2: Real-time Traffic Sniffer
**Purpose**: Capture and display live network traffic
**Source Files**: Encryption keys, protocol constants
**UI Location**: Testing Suite → Packet Log

```python
# Implementation: src/tools/traffic_sniffer.py
class TrafficSniffer:
    """
    Real-time network traffic capture and display.
    
    Features:
    - Packet filtering by command type
    - Search/filter by content
    - Export to pcap/json
    - Live updating display
    
    Modes:
    - Proxy mode (MITM)
    - Passive mode (with winpcap/npcap)
    """
    pass
```

### Tool 3: Packet Replay System
**Purpose**: Replay captured packets for testing
**Source Files**: Recorded sessions
**UI Location**: Testing Suite → Replay Tab

```python
# Implementation: src/tools/packet_replayer.py
class PacketReplayer:
    """
    Replay captured packet sequences.
    
    Features:
    - Variable playback speed
    - Pause/resume/step
    - Modify packets before replay
    - Compare responses
    """
    pass
```

### Tool 4: Server Response Simulator
**Purpose**: Simulate server responses for offline testing
**Source Files**: Response class definitions
**UI Location**: Testing Suite → Simulator Tab

```python
# Implementation: src/tools/server_simulator.py
class ServerSimulator:
    """
    Simulates Evony server responses.
    
    Features:
    - Configurable response templates
    - Random data generation
    - Error injection for testing
    - Recording-based responses
    """
    pass
```

### Tool 5: Man-in-the-Middle Proxy
**Purpose**: Intercept, view, and modify traffic
**Source Files**: Keys, protocol
**UI Location**: Testing Suite → Proxy

```python
# Implementation: src/tools/mitm_proxy.py
class MITMProxy:
    """
    MITM proxy for traffic interception.
    
    Features:
    - SSL/TLS termination
    - Request/response modification
    - Breakpoints on commands
    - Traffic logging
    """
    pass
```

### Tool 6: Connection Logger
**Purpose**: Log all connections with metadata
**Source Files**: Network layer
**UI Location**: Logs Panel

### Tool 7: Session Token Generator
**Purpose**: Generate valid session tokens
**Source Files**: Token key, LoginHelper.as
**UI Location**: Tools Menu → Token Gen

### Tool 8: API Call Monitor
**Purpose**: Monitor all API calls in real-time
**Source Files**: ActionFactory.as
**UI Location**: Protocol Panel → Monitor

### Tool 9: Network Latency Analyzer
**Purpose**: Measure and analyze network latency
**Source Files**: Connection.as
**UI Location**: Status Bar + Analytics

### Tool 10: Packet Fuzzer
**Purpose**: Test server with malformed packets
**Source Files**: Protocol spec
**UI Location**: Tools Menu → Security

### Tool 11: Traffic Pattern Analyzer
**Purpose**: Analyze traffic patterns for optimization
**Source Files**: Recorded sessions
**UI Location**: Analytics Panel

### Tool 12: Protocol Documentation Generator
**Purpose**: Auto-generate protocol docs from captures
**Source Files**: Captured packets
**UI Location**: Tools Menu → Generate Docs

---

## 🤖 BOT AUTOMATION TOOLS (15)

### Tool 13: Command Executor
**Purpose**: Execute bot commands with full parameter support
**Source Files**: `Commands.as` (2,186 lines)
**UI Location**: Bot Panel → Commands Tab

```python
# Implementation: src/tools/command_executor.py
class CommandExecutor:
    """
    Execute AutoEvony bot commands.
    
    Available Commands (from Commands.as):
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
    
    Features:
    - Parameter validation
    - Response handling
    - Error recovery
    - Logging
    """
    
    def execute(self, command: str, **params) -> dict:
        """Execute a command with parameters."""
        pass
    
    def execute_batch(self, commands: list) -> list:
        """Execute multiple commands in sequence."""
        pass
```

### Tool 14: Script IDE
**Purpose**: Create, edit, and run automation scripts
**Source Files**: `Script.as`, `ScriptCmd.as`
**UI Location**: Bot Panel → Scripts Tab

```python
# Implementation: src/tools/script_ide.py
class ScriptIDE:
    """
    Full-featured script editor for bot automation.
    
    Features:
    - Syntax highlighting for bot script language
    - Auto-completion for commands
    - Script validation before run
    - Debugging with breakpoints
    - Script templates library
    - Import/export scripts
    
    Script Format (from ScriptCmd.as):
    - Comments: # or //
    - Variables: $varname = value
    - Commands: commandName(param1, param2)
    - Conditions: if resource.gold > 100000
    - Loops: repeat 10 times
    - Delays: wait 5 seconds
    """
    pass
```

### Tool 15: Multi-City Manager
**Purpose**: Manage multiple cities from one interface
**Source Files**: `CityManager.as`
**UI Location**: Bot Panel → Cities Tab

```python
# Implementation: src/tools/city_manager.py
class MultiCityManager:
    """
    Unified management for all player cities.
    
    Features:
    - City overview dashboard
    - Resource comparison
    - Troop distribution
    - Building queues
    - Hero assignments
    - Bulk actions
    
    City Operations:
    - Switch active city
    - Compare cities side-by-side
    - Transfer resources between cities
    - Coordinate attacks from multiple cities
    """
    pass
```

### Tool 16: Auto-Build System
**Purpose**: Automate building construction
**Source Files**: `BuildingManager.as`
**UI Location**: Bot Panel → Build Tab

```python
# Implementation: src/tools/auto_build.py
class AutoBuildSystem:
    """
    Automated building construction and upgrade.
    
    Features:
    - Build queue management
    - Upgrade prioritization
    - Resource-aware scheduling
    - Dependency checking
    - Optimal build order calculation
    
    Building Types (from constants):
    - Townhall, Cottage, Warehouse, Granary
    - Barracks, Stable, Workshop, Relief Station
    - Academy, Forge, Market, Embassy
    - Walls, Beacon Tower, Rally Spot
    """
    pass
```

### Tool 17: Army Automation
**Purpose**: Automate troop training and management
**Source Files**: `ArmyDetailsWin.as`
**UI Location**: Bot Panel → Army Tab

### Tool 18: NPC Farm Bot
**Purpose**: Automated NPC farming
**Source Files**: `Commands.as` qFarm function
**UI Location**: Bot Panel → Farm Tab

### Tool 19: Resource Manager
**Purpose**: Optimize resource production and storage
**Source Files**: `ResourceBean.as`
**UI Location**: Bot Panel → Resources Tab

### Tool 20: Hero Manager
**Purpose**: Manage heroes across all cities
**Source Files**: `HeroBean.as`
**UI Location**: Bot Panel → Heroes Tab

### Tool 21: Alliance Tools
**Purpose**: Alliance management automation
**Source Files**: `AllianceConstants.as`
**UI Location**: Bot Panel → Alliance Tab

### Tool 22: Mail Automation
**Purpose**: Automated mail sending and reading
**Source Files**: `MailBean.as`, `MailConstants.as`
**UI Location**: Bot Panel → Mail Tab

### Tool 23: Report Analyzer
**Purpose**: Analyze battle and scout reports
**Source Files**: `ReportBean.as`
**UI Location**: Bot Panel → Reports Tab

### Tool 24: Colony Manager
**Purpose**: Manage colonies and vassals
**Source Files**: `ColonyBean.as`
**UI Location**: Bot Panel → Colonies Tab

### Tool 25: Timing Optimizer
**Purpose**: Optimize action timing for efficiency
**Source Files**: Game timing constants
**UI Location**: Bot Panel → Timing Tab

### Tool 26: Script Converter
**Purpose**: Convert between script formats
**Source Files**: Script documentation
**UI Location**: Tools Menu → Convert

### Tool 27: Glitch Detector
**Purpose**: Detect exploitable game glitches
**Source Files**: Game logic analysis
**UI Location**: Tools Menu → Advanced

---

## 🔧 SWF REVERSE ENGINEERING TOOLS (10)

### Tool 28: ABC Bytecode Browser
**Purpose**: Browse ActionScript bytecode
**Source Files**: FFDEC, extracted SWFs
**UI Location**: SWF Panel → ABC Tab

```python
# Implementation: src/tools/abc_browser.py
class ABCBytecodeExplorer:
    """
    Browse and analyze ABC bytecode from SWF files.
    
    Features:
    - Class/method hierarchy view
    - Bytecode disassembly
    - Constant pool explorer
    - Cross-reference search
    - Export to text/JSON
    
    ABC Sections:
    - Constant Pool (ints, uints, doubles, strings, namespaces)
    - Method Info
    - Metadata Info
    - Instance Info
    - Class Info
    - Script Info
    - Method Body
    """
    pass
```

### Tool 29: SWF Structure Viewer
**Purpose**: View SWF file structure
**Source Files**: SWF format spec
**UI Location**: SWF Panel → Structure Tab

### Tool 30: Class Hierarchy Browser
**Purpose**: Browse class inheritance
**Source Files**: Decompiled sources
**UI Location**: SWF Panel → Classes Tab

### Tool 31: Asset Extractor
**Purpose**: Extract all assets from SWF
**Source Files**: SWF files
**UI Location**: SWF Panel → Assets Tab

### Tool 32: Symbol Table Viewer
**Purpose**: View SWF symbol table
**Source Files**: SWF format
**UI Location**: SWF Panel → Symbols Tab

### Tool 33: Constant Pool Explorer
**Purpose**: Browse constant pool entries
**Source Files**: ABC format
**UI Location**: SWF Panel → Constants Tab

### Tool 34: Method Decompiler View
**Purpose**: Decompile individual methods
**Source Files**: FFDEC integration
**UI Location**: SWF Panel → Decompile Tab

### Tool 35: Binary Data Inspector
**Purpose**: Inspect embedded binary data
**Source Files**: binaryData folder
**UI Location**: SWF Panel → Binary Tab

### Tool 36: SWF Recompiler
**Purpose**: Recompile modified SWF
**Source Files**: FFDEC, RABCDAsm
**UI Location**: SWF Panel → Recompile Tab

### Tool 37: Diff Tool
**Purpose**: Compare SWF versions
**Source Files**: Multiple SWF versions
**UI Location**: Tools Menu → Diff

---

## 🔐 ENCRYPTION & DECRYPTION TOOLS (8)

### Tool 38: Universal Decryptor
**Purpose**: Decrypt any Evony encrypted data
**Source Files**: `evony_full_decryptor.py` (827 lines)
**UI Location**: Tools Menu → Decrypt

```python
# Implementation: src/tools/universal_decryptor.py
class UniversalDecryptor:
    """
    Decrypt any Evony encrypted content.
    
    Supported Algorithms:
    - AES-128/192/256 (ECB, CBC)
    - Blowfish
    - 3DES
    - RC4
    - XOR (0xAA key)
    - Custom Evony algorithm
    
    Auto-Detection:
    - Analyzes data headers
    - Tries all keys and algorithms
    - Validates decryption result
    """
    
    KNOWN_KEYS = {
        'api': '9f758e2deccbe6244f734371b9642eda',
        'token': 'IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}',
        'action': 'TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}',
        'evony_key1': 'PlayEvony',
        'evony_key2': 'Celebrate',
        'evony_key3': 'EarnPrestige',
        'evony_key4': 'VisitAndReward',
        'game': 'EvonyGameKey2009',
        'network': 'EvonyNetKey2009'
    }
```

### Tool 39: XOR Decrypter
**Purpose**: Fast XOR decryption
**Source Files**: XOR key (0xAA)
**UI Location**: Tools Menu → XOR

### Tool 40: AES Decrypter
**Purpose**: AES decryption with mode selection
**Source Files**: AES keys
**UI Location**: Tools Menu → AES

### Tool 41: Blowfish Decrypter
**Purpose**: Blowfish decryption
**Source Files**: Blowfish key
**UI Location**: Tools Menu → Blowfish

### Tool 42: MD5 Hash Calculator
**Purpose**: Calculate and verify MD5 hashes
**Source Files**: Token verification
**UI Location**: Tools Menu → Hash

### Tool 43: Token Generator
**Purpose**: Generate valid auth tokens
**Source Files**: Token key
**UI Location**: Tools Menu → Token

### Tool 44: Session Key Extractor
**Purpose**: Extract session keys from traffic
**Source Files**: Protocol analysis
**UI Location**: Protocol Panel → Keys

### Tool 45: Password Hash Reverser
**Purpose**: Reverse password hashes
**Source Files**: Salt values
**UI Location**: Tools Menu → Password

---

## 📈 DATA & ANALYSIS TOOLS (10)

### Tool 46: Troop Statistics Calculator
**Purpose**: Calculate troop stats and costs
**Source Files**: `XMLTroop.bin`
**UI Location**: Data Panel → Troops Tab

```python
# Implementation: src/tools/troop_calculator.py
class TroopCalculator:
    """
    Calculate troop statistics, costs, and battle outcomes.
    
    Data Source: XMLTroop.bin
    
    Troop Types:
    - Workers, Warriors, Scouts
    - Pikemen, Swordsmen, Archers
    - Cavalry, Cataphracts
    - Transporters, Ballista, Rams, Catapults
    
    Calculations:
    - Training cost (resources, time)
    - Upkeep cost
    - Combat stats (attack, defense, speed, range, load)
    - Battle outcome prediction
    """
    pass
```

### Tool 47: Building Cost Calculator
**Purpose**: Calculate building costs and times
**Source Files**: `XMLBuilding.bin`
**UI Location**: Data Panel → Buildings Tab

### Tool 48: Tech Tree Viewer
**Purpose**: View and plan technology research
**Source Files**: `XMLTech.bin`
**UI Location**: Data Panel → Tech Tab

### Tool 49: Item Database Browser
**Purpose**: Browse all game items
**Source Files**: `XMLItem.bin`
**UI Location**: Data Panel → Items Tab

### Tool 50: Equipment Database
**Purpose**: Browse hero equipment
**Source Files**: `XMLEquipment.bin`
**UI Location**: Data Panel → Equipment Tab

### Tool 51: Fort Stats Viewer
**Purpose**: View fortification statistics
**Source Files**: `XMLFort.bin`
**UI Location**: Data Panel → Forts Tab

### Tool 52: Logo Browser
**Purpose**: Browse alliance logos
**Source Files**: `XMLLogo.bin`
**UI Location**: Data Panel → Logos Tab

### Tool 53: Battle Simulator
**Purpose**: Simulate battle outcomes
**Source Files**: Battle mechanics
**UI Location**: Data Panel → Battle Sim Tab

### Tool 54: March Time Calculator
**Purpose**: Calculate march times
**Source Files**: Map data, troop speeds
**UI Location**: Data Panel → March Tab

### Tool 55: Resource Flow Analyzer
**Purpose**: Analyze resource production/consumption
**Source Files**: City data
**UI Location**: Data Panel → Flow Tab

---

## 🖥️ UI INTEGRATION PLAN

### Main Navigation Structure

```
Svony Studio
├── File Menu
│   ├── New Project
│   ├── Open SWF...
│   ├── Recent Files
│   └── Exit
│
├── Tools Menu
│   ├── Decrypt
│   │   ├── Universal Decryptor (Tool 38)
│   │   ├── XOR Decrypter (Tool 39)
│   │   ├── AES Decrypter (Tool 40)
│   │   └── Blowfish Decrypter (Tool 41)
│   │
│   ├── Hash Tools
│   │   ├── MD5 Calculator (Tool 42)
│   │   └── Token Generator (Tool 43)
│   │
│   ├── Convert
│   │   ├── Script Converter (Tool 26)
│   │   └── Protocol Doc Generator (Tool 12)
│   │
│   └── Advanced
│       ├── Packet Fuzzer (Tool 10)
│       └── Glitch Detector (Tool 27)
│
├── Main Tabs
│   ├── Testing Suite
│   │   ├── Dual SWF Viewer
│   │   ├── Packet Interceptor (Tool 5)
│   │   ├── Traffic Sniffer (Tool 2)
│   │   ├── Packet Log
│   │   ├── Packet Detail (Tool 1)
│   │   ├── Replay Tab (Tool 3)
│   │   └── Simulator Tab (Tool 4)
│   │
│   ├── Bot Panel
│   │   ├── Commands Tab (Tool 13)
│   │   ├── Scripts Tab (Tool 14)
│   │   ├── Cities Tab (Tool 15)
│   │   ├── Build Tab (Tool 16)
│   │   ├── Army Tab (Tool 17)
│   │   ├── Farm Tab (Tool 18)
│   │   ├── Resources Tab (Tool 19)
│   │   ├── Heroes Tab (Tool 20)
│   │   ├── Alliance Tab (Tool 21)
│   │   ├── Mail Tab (Tool 22)
│   │   ├── Reports Tab (Tool 23)
│   │   ├── Colonies Tab (Tool 24)
│   │   └── Timing Tab (Tool 25)
│   │
│   ├── SWF Panel
│   │   ├── Structure Tab (Tool 29)
│   │   ├── ABC Tab (Tool 28)
│   │   ├── Classes Tab (Tool 30)
│   │   ├── Assets Tab (Tool 31)
│   │   ├── Symbols Tab (Tool 32)
│   │   ├── Constants Tab (Tool 33)
│   │   ├── Decompile Tab (Tool 34)
│   │   ├── Binary Tab (Tool 35)
│   │   └── Recompile Tab (Tool 36)
│   │
│   ├── Protocol Panel
│   │   ├── Decoder Tab (Tool 1)
│   │   ├── Monitor Tab (Tool 8)
│   │   ├── Keys Tab (Tool 44)
│   │   └── Latency (Tool 9)
│   │
│   ├── Data Panel
│   │   ├── Troops Tab (Tool 46)
│   │   ├── Buildings Tab (Tool 47)
│   │   ├── Tech Tab (Tool 48)
│   │   ├── Items Tab (Tool 49)
│   │   ├── Equipment Tab (Tool 50)
│   │   ├── Forts Tab (Tool 51)
│   │   ├── Logos Tab (Tool 52)
│   │   ├── Battle Sim Tab (Tool 53)
│   │   ├── March Tab (Tool 54)
│   │   └── Flow Tab (Tool 55)
│   │
│   └── AI Panel
│       ├── Recording Tab
│       ├── Learning Tab
│       ├── Automation Tab
│       └── Settings Tab
│
└── Status Bar
    ├── Connection Status
    ├── Packet Count
    ├── Memory Usage
    └── Current Task
```

---

## 📅 IMPLEMENTATION PRIORITY

### Phase 1: Core Tools (Week 1-2)
1. ✅ AMF Packet Decoder (Tool 1)
2. ✅ Universal Decryptor (Tool 38)
3. ✅ MITM Proxy (Tool 5)
4. ✅ Command Executor (Tool 13)
5. ✅ Traffic Sniffer (Tool 2)

### Phase 2: Bot Tools (Week 3-4)
6. Script IDE (Tool 14)
7. Multi-City Manager (Tool 15)
8. Auto-Build System (Tool 16)
9. NPC Farm Bot (Tool 18)
10. Hero Manager (Tool 20)

### Phase 3: Analysis Tools (Week 5-6)
11. Troop Calculator (Tool 46)
12. Building Calculator (Tool 47)
13. Battle Simulator (Tool 53)
14. ABC Bytecode Browser (Tool 28)
15. Report Analyzer (Tool 23)

### Phase 4: Advanced Tools (Week 7-8)
16. Script Converter (Tool 26)
17. Packet Replayer (Tool 3)
18. Server Simulator (Tool 4)
19. SWF Recompiler (Tool 36)
20. Remaining tools

---

## ✅ SUCCESS CRITERIA

Each tool is considered complete when:
1. **Functional**: Core features work as specified
2. **Integrated**: Appears in correct UI location
3. **Documented**: User guide and API docs exist
4. **Tested**: Unit tests pass with >80% coverage
5. **Stable**: No crashes under normal use

---

This specification provides a complete roadmap for implementing all 55 tools in Svony Studio.
