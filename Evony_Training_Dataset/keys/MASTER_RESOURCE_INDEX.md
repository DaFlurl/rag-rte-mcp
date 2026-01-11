# 🎮 SVONY STUDIO - MASTER RESOURCE INDEX
## Comprehensive Evony Client, RoboEvony, AutoEvony & Bot Automation Reference

---

> **Generated**: 2026-01-02
> **Purpose**: Complete index of all Evony-related resources across D:\, E:\, G:\ drives for Svony Studio development
> **Total Files Found**: 20,000+ Evony-related files

---

## 📑 TABLE OF CONTENTS

1. [Executive Summary](#executive-summary)
2. [Critical Discoveries](#critical-discoveries)
3. [Encryption Keys & Secrets](#encryption-keys--secrets)
4. [Source Code Index](#source-code-index)
5. [SWF & Flash Assets](#swf--flash-assets)
6. [Bot Scripts Library](#bot-scripts-library)
7. [Automation Tools](#automation-tools)
8. [AI/ML Integration Points](#aiml-integration-points)
9. [Protocol & Network](#protocol--network)
10. [Configuration Files](#configuration-files)
11. [Documentation & Guides](#documentation--guides)
12. [Development Tools](#development-tools)
13. [Feature Roadmap](#feature-roadmap)

---

## 📊 EXECUTIVE SUMMARY

### Resource Distribution by Drive

| Drive | Evony Files | Primary Content |
|-------|-------------|-----------------|
| **D:\** | 1,560+ | Bot accounts, scripts, ETK, SWF files |
| **G:\** | 19,073+ | Source code, analysis tools, extracted AS3 |
| **E:\** | Scanning | Additional backups |

### Key Resource Categories

| Category | Count | Priority |
|----------|-------|----------|
| Decompiled AS3 Scripts | 500+ | 🔴 CRITICAL |
| Bot Automation Scripts | 200+ | 🔴 CRITICAL |
| Encryption/Decryption Tools | 15+ | 🔴 CRITICAL |
| SWF Client Files | 2,160+ | 🟡 HIGH |
| Account Configurations | 50+ | 🟡 HIGH |
| Documentation | 100+ | 🟢 MEDIUM |

---

## 🔑 CRITICAL DISCOVERIES

### Extracted Encryption Keys (FROM SOURCE CODE)

```python
# FROM: G:\Local-Games-Projects\evony_scripts_collection\evony_full_decryptor.py

KNOWN_KEYS = {
    'api': '9f758e2deccbe6244f734371b9642eda',
    'token': 'IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}',
    'action': 'TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}',
    'evony_key1': 'PlayEvony',
    'evony_key2': 'Celebrate',
    'evony_key3': 'EarnPrestige',
    'evony_key4': 'VisitAndReward'
}

KNOWN_SALTS = {
    'password': 'evony_salt_2010',
    'session': 'evony_session_2010',
    'game': 'evony_game_2010',
    'player': 'player_salt',
    'castle': 'castle_salt'
}
```

### Static Encryption Keys (FROM CRYPTO MODULE)

```python
# FROM: G:\Evony_CentOS\Electron_Browser\tools\evony_crypto.py

STATIC_KEYS = {
    'game': b'EvonyGameKey2009',
    'network': b'EvonyNetKey2009',
    'resource': b'EvonyResKey2009',
    'config': b'EvonyConfigKey2009',
    'data': b'EvonyDataKey2009'
}

ENCRYPTION_MARKERS = {
    'aes': {
        'header': b'\x45\x56\x4F\x01',  # EVO1
        'salt': b'\x45\x56\x53\x4C',    # EVSL
        'resource': b'\x52\x45\x53\x01', # RES1
        'config': b'\x43\x46\x47\x01'    # CFG1
    },
    'blowfish': {
        'header': b'\x45\x56\x4F\x02',   # EVO2
        'resource': b'\x52\x45\x53\x02', # RES2
        'data': b'\x44\x41\x54\x01'      # DAT1
    },
    'xor': {
        'header': b'\x45\x56\x4F\x03',   # EVO3
        'resource': b'\x52\x45\x53\x03', # RES3
        'text': b'\x54\x58\x54\x01'      # TXT1
    }
}
```

### XOR Decryption Key
```python
# FROM: G:\Local-Games-Projects\evony_missing_scripts\decrypt_evony_protections.py
XOR_KEY = 0xAA  # Simple XOR decryption
```

---

## 🔐 ENCRYPTION KEYS & SECRETS

### File Locations

| File | Path | Content |
|------|------|---------|
| **evony_full_decryptor.py** | `G:\Local-Games-Projects\evony_scripts_collection\` | Full decryption toolkit with all keys |
| **evony_crypto.py** | `G:\Evony_CentOS\Electron_Browser\tools\` | Crypto utilities & markers |
| **decrypt_evony_protections.py** | `G:\Local-Games-Projects\evony_missing_scripts\` | XOR protection bypass |
| **evony_openAI_API_KEY.txt** | `D:\Users\Admin\Desktop\evony\` | OpenAI integration key |

### Decryption Methods Available

| Method | Supported | Key Size |
|--------|-----------|----------|
| AES-ECB | ✅ | 128/192/256-bit |
| AES-CBC | ✅ | 128/192/256-bit |
| Blowfish | ✅ | Variable |
| 3DES | ✅ | 168-bit |
| RC4 | ✅ | Variable |
| XOR | ✅ | 8-bit (0xAA) |
| MD5-Context | ✅ | Hash-based |
| PBKDF2 | ✅ | Derived |


---

## 📁 SOURCE CODE INDEX

### AutoEvony Decompiled Source (CRITICAL)

**Base Path**: `G:\Evony_CentOS\Electron_Browser\tools\_development\tools\extracted\swf5_contents\scripts\autoevony\`

#### Core Modules

| Module | Path | Use Case |
|--------|------|----------|
| **Commands.as** | `cmds\Commands.as` | 2,186 lines - ALL bot commands |
| **Connection.as** | `net\Connection.as` | 807 lines - Network/AMF connection |
| **Script.as** | `scripts\Script.as` | Script execution engine |
| **ScriptCmd.as** | `scripts\ScriptCmd.as` | Script command parser |
| **CityState.as** | `scripts\CityState.as` | City state machine |
| **CityManager.as** | `management\CityManager.as` | City automation |
| **BuildingManager.as** | `management\BuildingManager.as` | Building automation |
| **LoginHelper.as** | `player\LoginHelper.as` | Login/auth handling |
| **Map.as** | `player\Map.as` | Map navigation |
| **MasterTimer.as** | `player\MasterTimer.as` | Timing/scheduling |

#### GUI Components

| Component | Path | Use Case |
|-----------|------|----------|
| **MainScreen.as** | `gui\MainScreen.as` | Main bot interface |
| **LoginScreen.as** | `gui\LoginScreen.as` | Login UI |
| **CityPanel.as** | `gui\CityPanel.as` | City management panel |
| **ChatPanel.as** | `gui\ChatPanel.as` | Chat interface |
| **MapCanvas.as** | `gui\MapCanvas.as` | Map renderer |
| **Snippets.as** | `gui\Snippets.as` | Script snippets UI |
| **TopInfo.as** | `gui\TopInfo.as` | Status bar |
| **AlertWin.as** | `gui\AlertWin.as` | Alert dialogs |
| **ArmyDetailsWin.as** | `gui\ArmyDetailsWin.as` | Army management |

#### Common Utilities

| Utility | Path | Use Case |
|---------|------|----------|
| **Utils.as** | `common\Utils.as` | Helper functions |
| **Items.as** | `common\Items.as` | Item definitions |
| **BuildingType.as** | `common\BuildingType.as` | Building types |
| **TechType.as** | `common\TechType.as` | Technology types |
| **GearType.as** | `common\GearType.as` | Equipment types |
| **TrainTroopHelper.as** | `common\TrainTroopHelper.as` | Troop training |

#### Event System

| Event | Path | Use Case |
|-------|------|----------|
| **OnLoginEvent.as** | `event\OnLoginEvent.as` | Login events |
| **OnLoggedOutEvent.as** | `event\OnLoggedOutEvent.as` | Logout events |
| **CityStateCompleteEvent.as** | `event\CityStateCompleteEvent.as` | City updates |
| **ScriptLogEvent.as** | `event\ScriptLogEvent.as` | Script logging |
| **WarLogEvent.as** | `event\WarLogEvent.as` | War notifications |
| **StopScriptEvent.as** | `event\StopScriptEvent.as` | Script control |

### Evony Client Beans (Data Models)

**Discovered in Commands.as imports:**

| Bean | Purpose |
|------|---------|
| `ArmyBean` | Army unit data |
| `CastleBean` | Castle/city data |
| `ColonyBean` | Colony data |
| `HeroBean` | Hero attributes |
| `MailBean` | Mail messages |
| `MapCastleBean` | Map castle info |
| `PlayerInfoBean` | Player profile |
| `ReportBean` | Battle reports |
| `ResourceBean` | Resources |
| `TroopBean` | Troop counts |
| `PackageBean` | Item packages |

---

## 🎬 SWF & FLASH ASSETS

### Primary SWF Files

| File | Path | Size | Purpose |
|------|------|------|---------|
| **AutoEvony2.swf** | Multiple locations | ~2MB | Bot client |
| **EvonyClient1921.swf** | `G:\Evony_CentOS\Electron_Browser\tools\` | Full | Game client |
| **playerProductInstall.swf** | Various | Small | Flash installer |

### SWF Distribution

```
D:\Users\marki\Desktop\new bot\AutoEvony2.swf
D:\Users\marki\Desktop\ETK accounts\*\AutoEvony2.swf  (50+ copies)
D:\Users\Admin\Desktop\new bot\AutoEvony2.swf
G:\Evony_CentOS\Electron_Browser\tools\client.swf
G:\Evony_CentOS\Electron_Browser\tools\embedded_*.swf
```

### Extracted SWF Contents

**Path**: `G:\Evony_CentOS\Electron_Browser\tools\_development\tools\extracted\`

| Folder | Content |
|--------|---------|
| `swf1_contents/` | Building SWFs |
| `swf2_contents/` | UI components |
| `swf3_contents/` | Map assets |
| `swf4_contents/` | Buttons/sprites |
| `swf5_contents/` | AutoEvony source (MAIN) |

### Asset Categories

| Type | Count | Location |
|------|-------|----------|
| Scripts (.as) | 500+ | `scripts/` |
| Images (.png) | 130+ | `images/` |
| Fonts (.ttf) | 4 | `fonts/` |
| Sounds (.mp3) | 10+ | `sounds/` |
| Shapes | 100+ | `shapes/` |
| Sprites | 50+ | `sprites/` |

---

## 🤖 BOT SCRIPTS LIBRARY

### Script Categories

#### Automation Scripts
**Path**: `G:\Evony_CentOS\Electron_Browser\tools\scripts\automation\`

| Script | Purpose | Priority |
|--------|---------|----------|
| `script_generator.py` | Generate new scripts | 🔴 |
| `script_validator.py` | Validate script syntax | 🔴 |
| `window_automation.py` | Window control | 🟡 |
| `process_automation.py` | Process management | 🟡 |
| `chatbot_manager.py` | Chat automation | 🟡 |
| `glitch_manager.py` | Exploit management | 🔴 |

#### Combat Scripts
**Path**: `G:\Evony_CentOS\Electron_Browser\tools\scripts\combat\`

| Script | Purpose |
|--------|---------|
| `combat_strategy.py` | AI combat decisions |
| `troop_manager.py` | Troop coordination |
| `troop_operations.py` | Attack operations |
| `troop_safety.py` | Defense automation |
| `troop_exploits.py` | Combat exploits |
| `attack_strategy.txt` | Attack templates |
| `advanced_evasion.txt` | Evasion tactics |

#### RoboEvony Scripts (Text-Based)
**Path**: `D:\Users\Admin\Desktop\evony_2024\`

| Script | Lines | Purpose |
|--------|-------|---------|
| `spam_script_v13.4.txt` | 500+ | Mass attack |
| `fastattack_v6_LagFree.txt` | 200+ | Quick strikes |
| `FoodGlitchCounterV1.2.txt` | 100+ | Food exploit |
| `HH_Hunting_Script.txt` | 150+ | Historic heroes |
| `Legendary_Hero_Script.txt` | 100+ | Legendary heroes |
| `CommissionQuestAcceptor3.txt` | 50+ | Quest automation |
| `Valley rolling at maint.txt` | 50+ | Valley exploit |



---

## 🔧 AUTOMATION TOOLS

### Python Analysis Tools

**Path**: `G:\Evony_CentOS\Electron_Browser\tools\`

| Tool | Purpose | Integration |
|------|---------|-------------|
| `evony_full_decryptor.py` | Full decryption suite | Core |
| `evony_crypto.py` | Crypto utilities | Core |
| `evony_abc_analyzer.py` | ABC bytecode analysis | SWF |
| `evony_swf_analyzer.py` | SWF structure | SWF |
| `evony_master_analyzer.py` | Combined analysis | Core |
| `evony_realtime_decrypt.py` | Live decryption | Network |
| `network_analyzer.py` | Traffic analysis | Network |
| `swf_deobfuscator.py` | Deobfuscation | SWF |
| `swf_extractor.py` | Asset extraction | SWF |
| `flash_debugger.py` | Debug Flash | Debug |
| `binary_analyzer.py` | Binary analysis | RE |

### PowerShell Scripts

| Script | Purpose |
|--------|---------|
| `analyze_evony.ps1` | Main analysis |
| `analyze_swf.ps1` | SWF processing |
| `capture_swf.ps1` | Network capture |
| `deep_capture.ps1` | Deep inspection |
| `monitor_flash.ps1` | Flash monitoring |
| `start_analysis.ps1` | Launch analysis |

### Account Management

**Path**: `D:\Users\marki\Desktop\ETK accounts\`

| Script | Purpose |
|--------|---------|
| `launch_all_roboevony.ps1` | Mass launch |
| `launch_all_roboevony.bat` | Batch launch |
| `kill_all_roboevony.bat` | Mass terminate |
| `monitor_roboevony.bat` | Health monitor |

### Development Tools

**Path**: `G:\Evony_CentOS\Electron_Browser\tools\dev_tools\`

| Tool | Config File | Purpose |
|------|-------------|---------|
| Ghidra | `ghidra_config.json` | Binary RE |
| IDA Free | `ida_free_config.json` | Disassembly |
| x64dbg | `x64dbg_config.json` | Debugging |
| Wireshark | `wireshark_config.json` | Network |
| CheatEngine | `cheat_engine_config.json` | Memory |
| Binary Ninja | `binary_ninja_config.json` | Analysis |
| DNSpy | `dnspy_config.json` | .NET RE |
| Process Hacker | `process_hacker_config.json` | Process |

---

## 🤖 AI/ML INTEGRATION POINTS

### Current AI Integrations

| Integration | Path | Purpose |
|-------------|------|---------|
| OpenAI API Key | `D:\Users\Admin\Desktop\evony\evony_openAI_API_KEY.txt` | LLM |
| AI Chat Log | `D:\Users\Admin\Desktop\evony\AI-Evony_Chat.txt` | History |

### Proposed AI Features for Svony Studio

#### Vision AI (Screenshot Analysis)
```
- Map scanning and NPC detection
- Troop count recognition from screenshots
- Building level identification
- Hero stat extraction from images
- Battle report OCR
```

#### LLM Integration (Script Generation)
```
- Natural language to bot script conversion
- Script optimization suggestions
- Error explanation and fixes
- Strategy recommendations
- Chat response generation
```

#### ML Features
```
- Attack timing optimization
- Resource prediction
- Player behavior analysis
- NPC respawn pattern learning
- Optimal build order calculation
```

### Integration Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    SVONY STUDIO AI LAYER                     │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │ Vision API  │  │   LLM API   │  │   Local ML Models   │  │
│  │ (GPT-4V,    │  │ (GPT-4,     │  │ (Scikit, PyTorch)   │  │
│  │  Claude)    │  │  Claude)    │  │                     │  │
│  └──────┬──────┘  └──────┬──────┘  └──────────┬──────────┘  │
│         │                │                     │             │
│  ┌──────▼────────────────▼─────────────────────▼──────────┐ │
│  │                   AI Coordinator                        │ │
│  │  - Request routing                                      │ │
│  │  - Response caching                                     │ │
│  │  - Fallback handling                                    │ │
│  └─────────────────────────┬───────────────────────────────┘ │
│                            │                                 │
├────────────────────────────▼─────────────────────────────────┤
│                    BOT AUTOMATION LAYER                      │
│                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐       │
│  │ Script Gen   │  │ Map Scanner  │  │ Decision     │       │
│  │ Engine       │  │              │  │ Engine       │       │
│  └──────────────┘  └──────────────┘  └──────────────┘       │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## 📡 PROTOCOL & NETWORK

### Server Configuration

**From**: `G:\Evony_CentOS\Electron_Browser\tools\evony_analysis\config_cc2.evony.com.xml`

```xml
<serverID>CC2</serverID>
<SID>375</SID>
<serverAlias>Parapet</serverAlias>
<server>216.66.17.168</server>
<port>443</port>
```

### Known Endpoints

| Endpoint | Purpose |
|----------|---------|
| `http://www.evony.com` | Home page |
| `http://user.evony.com/index.do` | User services |
| `http://pay.evony.com/index.do` | Payment |
| `http://bbs.evony.com/` | Forums |
| `http://cc2.evony.com/bulletin/Bulletin.txt` | Announcements |
| `http://cc2.evony.com/RSS_msg.xml` | News feed |

### AMF Protocol Details

**From Connection.as:**

```actionscript
// Connection constants
private static const MAX_PACKAGE_SIZE:int = 1048576;  // 1MB
private static const VERSION_COMMAND:String = "gameClient.version";

// Session management
public var EvonySessionCookies:String = null;
public var FBSessionCookies:String = null;
private var connectionCheckTimer:Timer = new Timer(300000);  // 5 min
public var reconnectTimer:Timer = new Timer(10000);  // 10 sec
```

### Network Tools

| Tool | Path | Purpose |
|------|------|---------|
| `network_analyzer.py` | `G:\...\tools\` | Traffic analysis |
| `fiddler_script.cs` | `G:\...\tools\` | Fiddler integration |
| `proxy/` | `G:\...\tools\proxy\` | MITM proxy |



---

## ⚙️ CONFIGURATION FILES

### Server Configs

| File | Path | Content |
|------|------|---------|
| `config_cc2.evony.com.xml` | `G:\...\evony_analysis\` | CC2 Parapet server |
| `config_cc3.evony.com.xml` | `G:\...\evony_analysis\` | CC3 server |
| `crossdomain.xml` | Various | Flash security policy |

### Tool Configurations

| File | Path | Purpose |
|------|------|---------|
| `toolkit_config.json` | `G:\...\tools\` | Master toolkit config |
| `analysis_config.json` | `G:\...\analysis_scripts\` | Analysis settings |
| `global_rules.json` | `G:\...\config\` | Global rules |
| `workspace_rules.json` | `G:\...\config\` | Workspace rules |

### Bot Account Configs

**Path**: `D:\Users\marki\Desktop\evony\khan\accounts\`

Account JSON files for various players:
- `Anton.evony.json`
- `cobra-evony.json`
- `kenzoevony.json`
- `martyevony1.json`
- `martyevony4.json`
- `godivaevony.json`
- `goose22evony.json`

---

## 📚 DOCUMENTATION & GUIDES

### Strategy Guides

| Document | Path | Content |
|----------|------|---------|
| `EVONY ADVANCE GUIDE.txt.docx` | `G:\Local-Games-Projects\Evony_Age_II\` | Advanced strategies |
| `MAP OF EVONY STATES.docx` | Same | State/HC map |
| `Stealth_Braves Handbook.docx` | Same | Tactics guide |
| `Madballs Ultimate Alt Setup.docx` | Same | Alt account guide |
| `IMPORTANCE OF HEROES.docx` | Same | Hero guide |
| `FB PERKS.docx` | Same | Facebook perks |
| `Hod_s Method NPC lvl 10.docx` | Same | NPC farming |

### Spreadsheets

| File | Path | Content |
|------|------|---------|
| `Na2 Elite Evony Game Map Ver 6.xls.xlsx` | Multiple | Game map |
| `Khans Comprehensive Log Sheet v2.0.xlsx` | `G:\...\Evony_Age_II\` | Activity log |
| `Evony Cheat Sheet.ods.xlsx` | Same | Quick reference |
| `City Manager Commands.xlsx` | Same | Command reference |
| `Evony Troop Count Blank.xls` | `D:\...\evony_2024\` | Troop tracker |

### Script Documentation

| Document | Path | Content |
|----------|------|---------|
| `[Start] - Tutorial - Free Edition.txt` | `D:\...\evony_2024\` | Beginner tutorial |
| `[Start] - Snippet - Free edition.txt` | Same | Script snippets |
| `RE_Bot_Script_SyntaxHighlighter.xml` | Same | Syntax rules |
| `TroopTrainingByIoshik-1.pdf` | Same | Training guide |

---

## 🛠️ DEVELOPMENT TOOLS

### Flash/SWF Tools

| Tool | Path | Purpose |
|------|------|---------|
| **AS3 Sorcerer** | `G:\...\tools\AS3 Sorcerer\` | AS3 decompiler |
| **FlashBrowser** | `G:\...\tools\FlashBrowser\` | Flash player |
| **rabcdasm** | `G:\...\tools\bin\rabcdasm\` | ABC disassembler |
| **FlashBrowser_v1.0.6** | `D:\...\evony_2024\` | Browser version |
| **flashcookiesview** | `D:\...\evony_2024\` | SOL viewer |

### Analysis Scripts

| Script | Path | Purpose |
|--------|------|---------|
| `roboevony_analyzer.py` | `G:\...\analysis_scripts\` | Bot analysis |
| `game_patterns.js` | `G:\...\analysis\` | Pattern matching |
| `analyze_binary.py` | `G:\...\ghidra_scripts\` | Binary analysis |

### Build Tools

| Tool | Path | Purpose |
|------|------|---------|
| **EvonyToolKit 2.0.0.0** | `D:\...\evony_2024\` | Full toolkit |
| **EvonyToolKit 1.0.2.5** | `G:\...\Evony_Age_II\` | Older version |
| **EvonyToolKit 1.0.1.6A** | Same | Legacy |
| **EvonyToolKit 1.0.1.3F** | Same | Legacy |
| **EvonyToolKit 1.0.0.8C** | Same | Legacy |

### Runtime Dependencies

**Path**: `D:\Users\Admin\Desktop\evony_2024\[=]_Runtimes_[=]\`

| Runtime | Purpose |
|---------|---------|
| `Directx_June2010` | DirectX |
| `Visual-C-AIO` | VC++ Redist |
| `windowsdesktop-runtime-5.0.17` | .NET 5 |
| `windowsdesktop-runtime-6.0.20` | .NET 6 |
| `windowsdesktop-runtime-7.0.9` | .NET 7 |
| `windowsdesktop-runtime-8.0.0` | .NET 8 |

---

## 🚀 FEATURE ROADMAP

### Phase 1: Core Bot Features (Week 1-2)

| Feature | Source | Priority |
|---------|--------|----------|
| AMF Protocol Client | `Connection.as` | 🔴 |
| Command Executor | `Commands.as` | 🔴 |
| Script Parser | `Script.as`, `ScriptCmd.as` | 🔴 |
| Decryption Engine | `evony_full_decryptor.py` | 🔴 |
| City Manager | `CityManager.as` | 🔴 |

### Phase 2: Automation Features (Week 3-4)

| Feature | Source | Priority |
|---------|--------|----------|
| Multi-City Tabs | `CityPanel.as` | 🟡 |
| Army Deployment | `ArmyDetailsWin.as` | 🟡 |
| Script Generator | `script_generator.py` | 🟡 |
| Glitch Manager | `glitch_manager.py` | 🟡 |
| Chat Automation | `chatbot_manager.py` | 🟡 |

### Phase 3: AI Integration (Week 5-6)

| Feature | Integration | Priority |
|---------|-------------|----------|
| Map Vision AI | GPT-4V/Claude | 🟡 |
| Script NLP | GPT-4/Claude | 🟡 |
| Decision Engine | Local ML | 🟢 |
| Pattern Learning | Scikit-learn | 🟢 |

### Phase 4: Advanced Tools (Week 7-8)

| Feature | Source | Priority |
|---------|--------|----------|
| Protocol Replay | Network tools | 🟢 |
| Live SWF Editing | SWF tools | 🟢 |
| Memory Scanner | CheatEngine | 🟢 |
| Multi-Account | ETK scripts | 🟢 |



---

## 📂 COMPLETE FILE PATH INDEX

### D:\ Drive - Bot Accounts & Tools

```
D:\svony_studio\                          # Main Svony Studio project
D:\Users\Admin\Desktop\evony_2024\        # 2024 Evony resources
D:\Users\Admin\Desktop\evony\             # Active Evony folder
D:\Users\Admin\Desktop\ETK accounts\      # ETK account folders (50+)
D:\Users\Admin\Desktop\new bot\           # New bot setup
D:\Users\Admin\Desktop\mark evony accounts\  # Personal accounts
D:\Users\marki\Desktop\evony\             # Alternative user evony
D:\Users\marki\Desktop\ETK accounts\      # Alt ETK accounts
```

### G:\ Drive - Analysis & Source Code

```
G:\Evony_CentOS\Electron_Browser\tools\   # Main analysis toolkit
    ├── _development\                     # Development resources
    │   ├── tools\extracted\              # Extracted SWF contents
    │   │   └── swf5_contents\scripts\    # AutoEvony source (CRITICAL)
    │   ├── docs\                         # Documentation
    │   └── RoboEvony_Skeleton_Extracted\ # Bot skeleton
    ├── analysis_scripts\                 # Analysis tools
    ├── captured_files\                   # Network captures
    ├── client_files\                     # Client assets
    ├── evony_analysis\                   # Server configs
    ├── scripts\                          # Bot scripts
    │   ├── automation\                   # Automation scripts
    │   ├── combat\                       # Combat scripts
    │   ├── hero\                         # Hero management
    │   ├── quest\                        # Quest automation
    │   └── resource\                     # Resource scripts
    └── dev_tools\                        # Development tools

G:\Local-Games-Projects\
    ├── evony_scripts_collection\         # Decryption scripts
    │   └── extracted_as3_scripts\        # Decrypted AS3 (44 files)
    ├── evony_missing_scripts\            # Additional tools
    ├── evony_private_server\             # Private server code
    ├── Evony_Age_II\                     # Guides & spreadsheets
    ├── Tkinter_Full\RoboEvony\           # Python RoboEvony
    └── evony_swf_analysis_scripts\       # SWF analysis

G:\Evony_UI\                              # UI development
G:\var\log\roboevony\                     # Bot logs
```

---

## 🔄 QUICK REFERENCE TABLES

### Most Important Files

| Rank | File | Path | Why |
|------|------|------|-----|
| 1 | `Commands.as` | `G:\...\autoevony\cmds\` | All 2,186 bot commands |
| 2 | `Connection.as` | `G:\...\autoevony\net\` | Network protocol |
| 3 | `evony_full_decryptor.py` | `G:\...\evony_scripts_collection\` | All encryption keys |
| 4 | `evony_crypto.py` | `G:\...\tools\` | Crypto utilities |
| 5 | `CityManager.as` | `G:\...\autoevony\management\` | City automation |
| 6 | `Script.as` | `G:\...\autoevony\scripts\` | Script engine |
| 7 | `LoginHelper.as` | `G:\...\autoevony\player\` | Auth handling |
| 8 | `config_cc2.evony.com.xml` | `G:\...\evony_analysis\` | Server config |

### Executable Tools

| Tool | Path | Version |
|------|------|---------|
| `roboevony.exe` | Various | 1.60, 1.79f |
| `EvonyToolKit2.0.0.0.exe` | `D:\...\evony_2024\` | 2.0.0.0 |
| `as3s.exe` | `G:\...\AS3 Sorcerer\` | Latest |
| `FlashBrowser200.exe` | `D:\...\evony_2024\` | 200 |

### Key Python Scripts

| Script | Purpose | Integrate? |
|--------|---------|------------|
| `evony_full_decryptor.py` | Decryption | ✅ Yes |
| `evony_crypto.py` | Crypto utils | ✅ Yes |
| `script_generator.py` | Script gen | ✅ Yes |
| `network_analyzer.py` | Traffic | ✅ Yes |
| `combat_strategy.py` | Combat AI | ✅ Yes |
| `troop_manager.py` | Troop AI | ✅ Yes |

---

## 📊 STATISTICS SUMMARY

### File Counts by Type

| Type | D:\ | G:\ | Total |
|------|-----|-----|-------|
| `.swf` | 200+ | 100+ | 300+ |
| `.as` | - | 500+ | 500+ |
| `.py` | 20+ | 80+ | 100+ |
| `.txt` (scripts) | 100+ | 150+ | 250+ |
| `.json` | 50+ | 30+ | 80+ |
| `.xlsx/.xls` | 20+ | 10+ | 30+ |

### Bot Account Folders

| Location | Count |
|----------|-------|
| `D:\Users\marki\Desktop\ETK accounts\` | 50+ |
| `D:\Users\Admin\Desktop\ETK accounts\` | 50+ |
| `D:\Users\Admin\Desktop\Borgs accounts\` | 20+ |
| `D:\Users\marki\Desktop\evony\` | 20+ |

---

## 🔒 SECURITY NOTES

### Sensitive Files (Handle with Care)

| File | Content | Location |
|------|---------|----------|
| `evony_openAI_API_KEY.txt` | OpenAI key | `D:\...\evony\` |
| `Evony Accounts.txt` | Login creds | Multiple |
| `*.json` in `khan\accounts\` | Account data | `D:\...\evony\khan\` |
| Server configs | IP/ports | `G:\...\evony_analysis\` |

### Encryption Keys (DO NOT SHARE)

All keys documented in this index are from decompiled source code for personal use only.

---

## ✅ NEXT STEPS

1. **Import Core AS3 to Svony** - Port Commands.as, Connection.as logic
2. **Integrate Decryption** - Add evony_full_decryptor.py to core
3. **Build Script Engine** - Based on Script.as, ScriptCmd.as
4. **Add AI Layer** - Vision + LLM integration
5. **Create Multi-Account Manager** - Based on ETK launcher scripts
6. **Implement Protocol Proxy** - From network tools

---

*This index is a living document. Update as new resources are discovered.*

**Last Updated**: 2026-01-02
**Author**: Svony Studio Development Team
