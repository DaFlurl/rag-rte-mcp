# 🎯 SVONY STUDIO - MASTER ACTION PLAN v2
## Complete Implementation Roadmap - Zero Simulated Data Policy

---

> **Created**: January 2, 2026
> **Working Location**: `D:\svony_studio`
> **Standard**: Enterprise-Grade, Production-Ready, NO Placeholders
> **Policy**: ZERO simulated, mocked, or fake data - EVERYTHING must work with real data

---

## 📊 EXECUTIVE AUDIT SUMMARY

| Category | Total Features | Currently Working | Gap | Priority |
|----------|---------------|-------------------|-----|----------|
| FFDec Integration | 66 | 15 (23%) | 51 | 🔴 CRITICAL |
| RABCDAsm Features | 24 | 3 (13%) | 21 | 🔴 CRITICAL |
| SOL Management | 18 | 12 (67%) | 6 | 🟡 HIGH |
| Protocol Analysis | 22 | 4 (18%) | 18 | 🔴 CRITICAL |
| Bot Framework | 28 | 8 (29%) | 20 | 🔴 CRITICAL |
| Evony Analysis | 35 | 10 (29%) | 25 | 🔴 CRITICAL |
| Reverse Engineering | 55 | 0 (0%) | 55 | 🔴 CRITICAL |
| Encryption Tools | 8 | 0 (0%) | 8 | 🔴 CRITICAL |
| UI Components | 45 | 18 (40%) | 27 | 🟡 HIGH |
| Build System | 15 | 2 (13%) | 13 | 🟡 HIGH |
| Theme System | 12 | 8 (67%) | 4 | 🟢 MEDIUM |
| **TOTAL** | **328** | **80 (24%)** | **248** | 🔴 **CRITICAL** |

### ⚠️ CRITICAL FINDINGS

1. **76% of documented features are NOT accessible in GUI**
2. **12 stub functions in main.py** doing nothing (just log messages)
3. **4 panels created but not imported** into main.py
4. **55 reverse engineering tools** documented but ZERO implemented
5. **All encryption/decryption tools** missing from GUI

---

## 🚫 ZERO SIMULATION POLICY

### BANNED PATTERNS (Remove All):
```python
# ❌ BANNED - Remove all of these:
def _simulate_*()        # Any simulate function
return {"simulated": True}
# // DONE: implement later
pass  # Empty function bodies
"Not implemented yet"
mock_data = {}
fake_response = {}
placeholder = True
```

### REQUIRED PATTERNS (Use These Instead):
```python
# ✅ REQUIRED - Use these instead:
def _real_function():
    try:
        result = actual_api_call()
        return result
    except ConnectionError:
        self._show_error("Not connected. Configure connection in Settings.")
        return None
    except Exception as e:
        self._log_error(f"Operation failed: {e}")
        raise
```

---

## 📋 PHASE 0: EMERGENCY FIXES (Week 1)

### 0.1 Remove All Stub Functions

| # | Function | File | Line | Current | Required Action |
|---|----------|------|------|---------|-----------------|
| 1 | `_deobfuscate_swf()` | main.py | 1531 | Just logs | Wire to `ffdec.deobfuscate()` |
| 2 | `_batch_decompile()` | main.py | 1536 | Just logs | Wire to `ffdec.batch_export()` |
| 3 | `_protocol_sniffer()` | main.py | 1545 | "not yet" | Wire to `ProtocolAnalyzer.start_capture()` |
| 4 | `_patch_server_url()` | main.py | 1596 | Just logs | Wire to `patcher.apply_preset()` |
| 5 | `_disable_version_check()` | main.py | 1601 | Just logs | Wire to `patcher.apply_preset()` |
| 6 | `_filter_assets()` | main.py | 1393 | Just logs | Implement actual filter logic |
| 7 | `_on_tree_right_click()` | main.py | 1365 | `pass` | Show actual context menu |
| 8 | `_filter_project_tree()` | main.py | 1352 | Just logs | Implement tree filter |
| 9 | `_toggle_capture()` | protocol_panel.py | ~100 | UI only | Connect to analyzer |
| 10 | `_request_new_identity()` | tor_status_panel.py | ~80 | Callback | Call `tor_manager.new_identity()` |
| 11 | `_stop_bot()` | running_bots_panel.py | ~120 | Remove | Actually kill process |
| 12 | `_restart_bot()` | running_bots_panel.py | ~140 | Remove+add | Kill+relaunch process |

### 0.2 Import Missing Panels

```python
# Add to main.py imports:
from src.ui.panels.asset_panel import AssetBrowserPanel
from src.ui.panels.city_panel import CityPanel
from src.ui.panels.hero_panel import HeroPanel
from src.ui.panels.map_panel import MapPanel
from src.ui.panels.army_dialog import ArmyDialog
```

### 0.3 Wire Existing Panels

| Panel | File Exists | Imported | Used in Tab | Action |
|-------|-------------|----------|-------------|--------|
| AssetBrowserPanel | ✅ asset_panel.py | ❌ | ❌ | Import + Add to Assets tab |
| CityPanel | ✅ city_panel.py | ❌ | ❌ | Import + Add to Bots tab |
| HeroPanel | ✅ hero_panel.py | ❌ | ❌ | Import + Add to Bots tab |
| MapPanel | ✅ map_panel.py | ❌ | ❌ | Import + Add to Analysis tab |
| ArmyDialog | ✅ army_dialog.py | ❌ | ❌ | Import + Add to Bots menu |

---

## 📋 PHASE 1: CORE TABS COMPLETION (Weeks 2-3)

### 1.1 New Tab Structure Required

```
Svony Studio Tabs (REQUIRED):
├── 📁 Project        [EXISTS - Needs enhancement]
├── 🔬 SWF Analyzer   [EXISTS - 23% complete]
├── 🔐 Crypto Tools   [NEW - 0% complete]      ← CREATE
├── 📡 Protocol       [EXISTS - 18% complete]
├── 🤖 Bots           [EXISTS - 29% complete]
├── 📜 Scripts        [EXISTS - 40% complete]
├── 🎨 Assets         [EXISTS - 25% complete]
├── 📊 Data Browser   [NEW - 0% complete]      ← CREATE
├── 🧪 Testing Suite  [EXISTS - 10% complete]
├── 🛠️ RE Tools       [NEW - 0% complete]      ← CREATE
├── 🔍 Search         [EXISTS - 50% complete]
├── 📝 Console        [EXISTS - 100% complete]
└── ⚙️ Settings       [EXISTS - 80% complete]
```

### 1.2 🔐 Crypto Tools Tab (NEW)

Create `src/ui/panels/crypto_panel.py`:

```
┌─────────────────────────────────────────────────────────────────┐
│  🔐 ENCRYPTION & DECRYPTION TOOLS                              │
├─────────────────────────────────────────────────────────────────┤
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐ │
│  │ XOR Decrypter   │  │ AES Decrypter   │  │ Blowfish Dec.   │ │
│  │ Key: 0xAA       │  │ Key: [Config]   │  │ Key: [Config]   │ │
│  │ [Decrypt File]  │  │ [Decrypt File]  │  │ [Decrypt File]  │ │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘ │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │ Universal Decryptor                                         ││
│  │ ───────────────────────────────────────────────────────────││
│  │ Input: [File/Hex/Base64 Input                            ] ││
│  │ Algorithm: [Auto-Detect ▼]  Key: [                       ] ││
│  │ [Decrypt]  [Encrypt]  [Analyze]  [Export]                  ││
│  └─────────────────────────────────────────────────────────────┘│
│                                                                 │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │ Known Evony Keys                                            ││
│  │ ───────────────────────────────────────────────────────────││
│  │ ☑ API Key:      9f758e2deccbe6244f734371b9642eda           ││
│  │ ☑ Token Key:    IUGI_md5_key_{djfiji3*4930}...             ││
│  │ ☑ Game Key:     EvonyGameKey2009                           ││
│  │ ☑ Network Key:  EvonyNetKey2009                            ││
│  │ ☑ XOR Key:      0xAA (170)                                 ││
│  │ [Copy All]  [Export Keys]  [Import Custom]                 ││
│  └─────────────────────────────────────────────────────────────┘│
│                                                                 │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │ Hash Calculator                                             ││
│  │ ───────────────────────────────────────────────────────────││
│  │ Input: [                                                 ] ││
│  │ MD5:    [                                                ] ││
│  │ SHA1:   [                                                ] ││
│  │ SHA256: [                                                ] ││
│  │ [Calculate]  [Verify]  [Reverse Lookup]                    ││
│  └─────────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────────┘
```

### 1.3 📊 Data Browser Tab (NEW)

Create `src/ui/panels/data_browser_panel.py`:

```
┌─────────────────────────────────────────────────────────────────┐
│  📊 EVONY DATA BROWSER                                         │
├─────────────────────────────────────────────────────────────────┤
│  Data Files: [XMLTroop.bin ▼] [Load] [Decrypt] [Export JSON]   │
├───────────────────┬─────────────────────────────────────────────┤
│  Data Categories  │  Data Viewer                                │
│  ─────────────────│  ───────────────────────────────────────────│
│  📊 Troops        │  ┌─────────────────────────────────────────┐│
│  🏗️ Buildings     │  │ Troop: Warrior                          ││
│  🔬 Technologies  │  │ ───────────────────────────────────────││
│  📦 Items         │  │ Attack:    5   | Defense:   5           ││
│  🏰 Fortifications│  │ Life:     50   | Speed:    200          ││
│  👤 Player Logos  │  │ Range:     0   | Load:      20          ││
│  🏰 Castle Logos  │  │ Food/hr:  3.0  | Upkeep:   1.0          ││
│  ⚔️ Equipment     │  │ Build Time: 15s | Cost: 50F, 30W, 0S    ││
│                   │  │ Requirements: Barracks Lv1              ││
│                   │  └─────────────────────────────────────────┘│
│                   │                                             │
│                   │  [Edit Values] [Save Changes] [Compare]     │
└───────────────────┴─────────────────────────────────────────────┘
```

### 1.4 🛠️ RE Tools Tab (NEW)

Create `src/ui/panels/re_tools_panel.py`:

```
┌─────────────────────────────────────────────────────────────────┐
│  🛠️ REVERSE ENGINEERING TOOLKIT                                │
├─────────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────────────────────────┐│
│  │ SWF Analysis                                                ││
│  │ [Structure] [ABC Dump] [Constants] [Symbols] [Binary]       ││
│  └─────────────────────────────────────────────────────────────┘│
│                                                                 │
│  ┌───────────────────────┬─────────────────────────────────────┐│
│  │ ABC Explorer          │  Bytecode Viewer                    ││
│  │ ─────────────────────│  ────────────────────────────────── ││
│  │ 📁 autoevony          │  pushstring "login"                 ││
│  │   📁 cmds             │  pushstring "password"              ││
│  │     📄 Commands       │  callproperty                       ││
│  │   📁 net              │  returnvalue                        ││
│  │     📄 Connection     │                                     ││
│  │   📁 scripts          │  ──────────────────────────────────││
│  │     📄 Script         │  Decompiled AS3:                    ││
│  │     📄 ScriptCmd      │  public function login(...):void {  ││
│  │                       │    var cmd:String = "login";        ││
│  │ [Expand All]          │    connection.send(cmd, data);      ││
│  │ [Find Pattern]        │  }                                  ││
│  └───────────────────────┴─────────────────────────────────────┘│
│                                                                 │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │ Quick Tools                                                 ││
│  │ [Deobfuscate] [Dump Strings] [Find Crypto] [Export P-code] ││
│  └─────────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────────┘
```

---

## 📋 PHASE 2: REVERSE ENGINEERING TOOLS (Weeks 4-6)

### 2.1 Tools to Create (55 Total)


#### CATEGORY A: Network & Protocol Tools (12 tools)

| # | Tool Name | Implementation File | Tab Location | Priority |
|---|-----------|---------------------|--------------|----------|
| 1 | AMF Packet Decoder | `src/tools/amf_decoder.py` | Protocol → Decoder | 🔴 CRITICAL |
| 2 | Real-time Traffic Sniffer | `src/tools/traffic_sniffer.py` | Testing → Sniffer | 🔴 CRITICAL |
| 3 | Packet Replay System | `src/tools/packet_replayer.py` | Testing → Replay | 🔴 CRITICAL |
| 4 | Server Response Simulator | `src/tools/server_simulator.py` | Testing → Simulator | 🟡 HIGH |
| 5 | Man-in-the-Middle Proxy | `src/tools/mitm_proxy.py` | Testing → Proxy | 🟡 HIGH |
| 6 | Connection Logger | `src/tools/connection_logger.py` | Protocol → Logger | 🟡 HIGH |
| 7 | Session Token Generator | `src/tools/token_generator.py` | Crypto → Tokens | 🟢 MEDIUM |
| 8 | API Call Monitor | `src/tools/api_monitor.py` | Protocol → Monitor | 🟢 MEDIUM |
| 9 | Network Latency Analyzer | `src/tools/latency_analyzer.py` | Protocol → Stats | 🟢 MEDIUM |
| 10 | Packet Fuzzer | `src/tools/packet_fuzzer.py` | Testing → Security | 🟢 MEDIUM |
| 11 | Traffic Pattern Analyzer | `src/tools/pattern_analyzer.py` | Protocol → Analysis | 🟢 MEDIUM |
| 12 | Protocol Doc Generator | `src/tools/protocol_docs.py` | Tools Menu | 🟢 MEDIUM |

#### CATEGORY B: Bot Automation Tools (15 tools)

| # | Tool Name | Implementation File | Tab Location | Priority |
|---|-----------|---------------------|--------------|----------|
| 13 | Command Executor | `src/tools/command_executor.py` | Bots → Commands | 🔴 CRITICAL |
| 14 | Script IDE | `src/tools/script_ide.py` | Scripts Tab | 🔴 CRITICAL |
| 15 | Multi-City Manager | `src/tools/city_manager.py` | Bots → Cities | 🔴 CRITICAL |
| 16 | Auto-Build System | `src/tools/auto_build.py` | Bots → Build | 🔴 CRITICAL |
| 17 | Army Automation | `src/tools/army_automation.py` | Bots → Army | 🔴 CRITICAL |
| 18 | NPC Farm Bot | `src/tools/npc_farmer.py` | Bots → Farming | 🔴 CRITICAL |
| 19 | Resource Manager | `src/tools/resource_manager.py` | Bots → Resources | 🟡 HIGH |
| 20 | Hero Manager | `src/tools/hero_manager.py` | Bots → Heroes | 🟡 HIGH |
| 21 | Alliance Tools | `src/tools/alliance_tools.py` | Bots → Alliance | 🟡 HIGH |
| 22 | Mail Automation | `src/tools/mail_automation.py` | Bots → Mail | 🟡 HIGH |
| 23 | Report Analyzer | `src/tools/report_analyzer.py` | Bots → Reports | 🟡 HIGH |
| 24 | Colony Manager | `src/tools/colony_manager.py` | Bots → Colonies | 🟢 MEDIUM |
| 25 | Timing Optimizer | `src/tools/timing_optimizer.py` | Bots → Scheduler | 🟢 MEDIUM |
| 26 | Script Converter | `src/tools/script_converter.py` | Scripts → Import | 🟢 MEDIUM |
| 27 | Glitch Detector | `src/tools/glitch_detector.py` | Bots → Debug | 🟢 MEDIUM |

#### CATEGORY C: SWF Reverse Engineering (10 tools)

| # | Tool Name | Implementation File | Tab Location | Priority |
|---|-----------|---------------------|--------------|----------|
| 28 | ABC Bytecode Browser | `src/tools/abc_browser.py` | RE Tools → ABC | 🔴 CRITICAL |
| 29 | SWF Structure Viewer | `src/tools/swf_structure.py` | RE Tools → Structure | 🔴 CRITICAL |
| 30 | Class Hierarchy Browser | `src/tools/class_hierarchy.py` | RE Tools → Classes | 🟡 HIGH |
| 31 | Asset Extractor | `src/tools/asset_extractor.py` | Assets → Extract | 🟡 HIGH |
| 32 | Symbol Table Viewer | `src/tools/symbol_viewer.py` | RE Tools → Symbols | 🟡 HIGH |
| 33 | Constant Pool Explorer | `src/tools/constant_pool.py` | RE Tools → Constants | 🟡 HIGH |
| 34 | Method Decompiler View | `src/tools/method_viewer.py` | RE Tools → Methods | 🟢 MEDIUM |
| 35 | Binary Data Inspector | `src/tools/binary_inspector.py` | RE Tools → Binary | 🟢 MEDIUM |
| 36 | SWF Recompiler | `src/tools/swf_recompiler.py` | Build → Recompile | 🟢 MEDIUM |
| 37 | SWF Diff Tool | `src/tools/swf_diff.py` | RE Tools → Compare | 🟢 MEDIUM |

#### CATEGORY D: Encryption & Decryption (8 tools)

| # | Tool Name | Implementation File | Tab Location | Priority |
|---|-----------|---------------------|--------------|----------|
| 38 | Universal Decryptor | `src/tools/universal_decryptor.py` | Crypto → Universal | 🔴 CRITICAL |
| 39 | XOR Decrypter | `src/tools/xor_decrypter.py` | Crypto → XOR | 🔴 CRITICAL |
| 40 | AES Decrypter | `src/tools/aes_decrypter.py` | Crypto → AES | 🔴 CRITICAL |
| 41 | Blowfish Decrypter | `src/tools/blowfish_decrypter.py` | Crypto → Blowfish | 🟡 HIGH |
| 42 | MD5 Hash Calculator | `src/tools/hash_calculator.py` | Crypto → Hashes | 🟡 HIGH |
| 43 | Token Generator | `src/tools/evony_token_gen.py` | Crypto → Tokens | 🟡 HIGH |
| 44 | Session Key Extractor | `src/tools/session_extractor.py` | Crypto → Sessions | 🟢 MEDIUM |
| 45 | Password Hash Reverser | `src/tools/hash_reverser.py` | Crypto → Reverse | 🟢 MEDIUM |

#### CATEGORY E: Data & Analysis (10 tools)

| # | Tool Name | Implementation File | Tab Location | Priority |
|---|-----------|---------------------|--------------|----------|
| 46 | Troop Stats Calculator | `src/tools/troop_calculator.py` | Data → Troops | 🔴 CRITICAL |
| 47 | Building Cost Calculator | `src/tools/building_calculator.py` | Data → Buildings | 🔴 CRITICAL |
| 48 | Tech Tree Viewer | `src/tools/tech_tree.py` | Data → Tech | 🟡 HIGH |
| 49 | Item Database Browser | `src/tools/item_browser.py` | Data → Items | 🟡 HIGH |
| 50 | Equipment Database | `src/tools/equipment_browser.py` | Data → Equipment | 🟡 HIGH |
| 51 | Fort Stats Viewer | `src/tools/fort_viewer.py` | Data → Forts | 🟡 HIGH |
| 52 | Player Logo Browser | `src/tools/logo_browser.py` | Data → Logos | 🟢 MEDIUM |
| 53 | Castle Logo Browser | `src/tools/castle_logos.py` | Data → Castles | 🟢 MEDIUM |
| 54 | Battle Simulator | `src/tools/battle_simulator.py` | Data → Battle | 🟢 MEDIUM |
| 55 | March Time Calculator | `src/tools/march_calculator.py` | Data → March | 🟢 MEDIUM |

---

## 📋 PHASE 3: THEME SYSTEM EXPANSION (Week 4)

### 3.1 Current Themes (8 Defined)

```python
class ThemePreset(Enum):
    BORG = "borg"                    # ✅ Black/green (current default)
    BORG_DARK = "borg_dark"          # ✅ Darker green variant
    ROBOEVONY_DARK = "roboevony_dark"# ✅ Dark blue/orange
    ROBOEVONY_GOLD = "roboevony_gold"# ✅ Olive/gold/orange
    SOL_MANAGER = "sol_manager"      # ✅ Dark gray/orange/teal
    SVONY_CLASSIC = "svony_classic"  # ✅ Original style
    CYBER_PUNK = "cyber_punk"        # ✅ Neon pink/cyan
    MIDNIGHT_BLUE = "midnight_blue"  # ✅ Deep blue/light blue
```

### 3.2 New Themes to Add (4 More)

```python
# Add to ThemePreset enum in theme_manager.py:

BLOOD_MOON = "blood_moon"         # 🆕 Dark red/crimson
FOREST_NIGHT = "forest_night"     # 🆕 Dark green/mint  
AMBER_ALERT = "amber_alert"       # 🆕 Orange/gold warmth
STEEL_GRAY = "steel_gray"         # 🆕 Industrial gray/blue
```

### 3.3 Theme Color Definitions (NEW)

```python
# Add to THEME_PRESETS in theme_manager.py:

"blood_moon": Theme(
    name="Blood Moon",
    preset=ThemePreset.BLOOD_MOON,
    colors=ColorScheme(
        bg_darkest="#0a0000",
        bg_dark="#150505",
        bg_medium="#251010",
        bg_light="#351818",
        accent_primary="#cc0000",      # Blood red
        accent_secondary="#ff3333",    # Lighter red
        accent_tertiary="#ff6600",     # Orange
        text_primary="#ffcccc",
        text_secondary="#aa8888",
    )
),

"forest_night": Theme(
    name="Forest Night",
    preset=ThemePreset.FOREST_NIGHT,
    colors=ColorScheme(
        bg_darkest="#000a05",
        bg_dark="#051510",
        bg_medium="#102518",
        bg_light="#183525",
        accent_primary="#00aa55",      # Forest green
        accent_secondary="#55ffaa",    # Mint
        accent_tertiary="#88ff88",     # Light green
        text_primary="#ccffdd",
        text_secondary="#88aa99",
    )
),

"amber_alert": Theme(
    name="Amber Alert",
    preset=ThemePreset.AMBER_ALERT,
    colors=ColorScheme(
        bg_darkest="#0a0500",
        bg_dark="#151005",
        bg_medium="#252010",
        bg_light="#353018",
        accent_primary="#ff9900",      # Amber
        accent_secondary="#ffcc00",    # Gold
        accent_tertiary="#ffff66",     # Yellow
        text_primary="#fff5cc",
        text_secondary="#aa9955",
    )
),

"steel_gray": Theme(
    name="Steel Gray",
    preset=ThemePreset.STEEL_GRAY,
    colors=ColorScheme(
        bg_darkest="#0a0a0f",
        bg_dark="#151520",
        bg_medium="#252535",
        bg_light="#353545",
        accent_primary="#6688aa",      # Steel blue
        accent_secondary="#88aacc",    # Light steel
        accent_tertiary="#aaccee",     # Pale blue
        text_primary="#ddeeff",
        text_secondary="#8899aa",
    )
),
```

### 3.4 Background Images (AutoEvony Style)

Create `assets/backgrounds/` folder with:

```
assets/backgrounds/
├── borg_circuit.png         # Circuit board pattern
├── evony_map_dark.png       # Darkened game map
├── medieval_stone.png       # Stone texture
├── parchment_dark.png       # Dark parchment
├── matrix_rain.png          # Matrix-style falling code
├── starfield.png            # Space background
├── forge_fire.png           # Fiery forge
├── castle_night.png         # Castle at night
├── war_camp.png             # Military camp
├── ancient_scroll.png       # Scroll texture
├── dragon_scales.png        # Dragon scale pattern
└── custom/                  # User custom backgrounds
```

---

## 📋 PHASE 4: TESTING SUITE COMPLETION (Week 5)

### 4.1 Dual SWF Testing Panel

```
┌─────────────────────────────────────────────────────────────────────────┐
│  🧪 EVONY TESTING SUITE - Dual Client Analysis                         │
├─────────────────────────────────────────────────────────────────────────┤
│  ┌────────────────────────────┐    ┌────────────────────────────┐      │
│  │ EVONY CLIENT (1921)        │    │ AUTOEVONY BOT              │      │
│  │ ──────────────────────────│    │ ──────────────────────────│      │
│  │ [Load SWF] [Refresh]      │    │ [Load SWF] [Refresh]      │      │
│  │                           │    │                           │      │
│  │ ┌───────────────────────┐ │    │ ┌───────────────────────┐ │      │
│  │ │                       │ │    │ │                       │ │      │
│  │ │   Flash Preview       │ │ ←→ │   Flash Preview       │ │      │
│  │ │   (Ruffle/Adobe)      │ │    │ │   (Ruffle/Adobe)      │ │      │
│  │ │                       │ │    │ │                       │ │      │
│  │ └───────────────────────┘ │    │ └───────────────────────┘ │      │
│  │                           │    │                           │      │
│  │ Status: Connected         │    │ Status: Ready             │      │
│  │ Server: na1.evony.com     │    │ Target: Client            │      │
│  └────────────────────────────┘    └────────────────────────────┘      │
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────────┐│
│  │ 📡 PACKET INTERCEPTOR (MITM Mode)                                   ││
│  │ ─────────────────────────────────────────────────────────────────── ││
│  │ [▶ Start Capture] [⏹ Stop] [🗑 Clear] [💾 Save Session]             ││
│  │                                                                     ││
│  │ Filter: [All Commands ▼] Search: [________________] [🔍]            ││
│  │                                                                     ││
│  │ ┌─────┬───────────┬──────────────────────────────────────────────┐ ││
│  │ │ Dir │ Command   │ Data (Decrypted AMF3)                        │ ││
│  │ ├─────┼───────────┼──────────────────────────────────────────────┤ ││
│  │ │ →   │ login     │ {user: "test", pass_hash: "9f758e2d..."}     │ ││
│  │ │ ←   │ loginResp │ {ok: 1, session: "abc123", cities: [...]}    │ ││
│  │ │ →   │ getCities │ {session: "abc123"}                          │ ││
│  │ │ ←   │ cityData  │ {cities: [{id: 1, name: "Test", ...}]}       │ ││
│  │ │ →   │ qFarm     │ {npcLv: 5, troops: 10000, hero: "attack"}    │ ││
│  │ └─────┴───────────┴──────────────────────────────────────────────┘ ││
│  │                                                                     ││
│  │ [Inject Packet] [Replay Selected] [Export JSON] [Generate Docs]     ││
│  └─────────────────────────────────────────────────────────────────────┘│
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────────┐│
│  │ 🔧 COMMAND SENDER (Manual Testing)                                  ││
│  │ ─────────────────────────────────────────────────────────────────── ││
│  │ Command: [login ▼]                                                  ││
│  │ Parameters:                                                         ││
│  │   username: [________________]                                      ││
│  │   password: [________________]                                      ││
│  │   server:   [na1.evony.com ▼]                                       ││
│  │                                                                     ││
│  │ [Send to Client] [Send to Bot] [Send Raw AMF]                       ││
│  └─────────────────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 📋 PHASE 5: AI/ML INTEGRATION (Weeks 6-8)

### 5.1 Script Recording System

```python
# src/tools/script_recorder.py

class ScriptRecorder:
    """
    Records user actions in AutoEvony for AI learning.
    
    Features:
    - Record all bot actions with timestamps
    - Capture game state before/after each action
    - Export to training datasets
    - Playback recorded sessions
    """
    
    def start_recording(self):
        """Start recording user actions."""
        pass
    
    def stop_recording(self) -> RecordedSession:
        """Stop and return recorded session."""
        pass
    
    def export_dataset(self, format: str = "json") -> Path:
        """Export recordings as AI training data."""
        pass
```

### 5.2 AI Learning Pipeline

```
┌─────────────────────────────────────────────────────────────────────────┐
│  🤖 AI AUTOMATION LEARNING                                              │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  1. RECORD SESSIONS                                                     │
│  ─────────────────                                                      │
│  [▶ Start Recording] [⏹ Stop] Sessions: 47 recorded                    │
│                                                                         │
│  2. TRAINING DATA                                                       │
│  ────────────────                                                       │
│  ┌───────────────────────────────────────────────────────────────────┐ │
│  │ Dataset: city_management_v1.json                                   │ │
│  │ Actions: 15,234  |  Success Rate: 94.2%  |  Size: 45MB            │ │
│  │ Categories: Build (4521), Farm (3892), Army (2341), Resource (...)│ │
│  └───────────────────────────────────────────────────────────────────┘ │
│                                                                         │
│  3. MODEL TRAINING                                                      │
│  ────────────────                                                       │
│  Provider: [LM Studio (Local) ▼]  Model: [qwen3-32b ▼]                 │
│  [Train Decision Model] [Train Timing Model] [Train Resource Model]    │
│                                                                         │
│  4. AI ASSISTANT                                                        │
│  ──────────────                                                         │
│  ☑ Auto-suggest next actions                                           │
│  ☑ Optimize build queues                                               │
│  ☑ Manage multiple cities                                              │
│  ☑ Respond to attacks                                                  │
│  ☐ Full autonomous mode (CAUTION)                                      │
│                                                                         │
│  [Enable AI Assistant] [Configure Guardrails] [View Decisions]          │
└─────────────────────────────────────────────────────────────────────────┘
```

### 5.3 Safety Guardrails

```python
# src/ai/guardrails.py

class AIGuardrails:
    """
    Safety limits for AI automation.
    """
    
    # Resource limits (never exceed)
    MAX_GOLD_SPEND_PER_HOUR = 1_000_000
    MAX_TROOPS_TRAIN_PER_HOUR = 50_000
    MAX_ATTACKS_PER_HOUR = 10
    
    # Actions requiring confirmation
    CONFIRM_ACTIONS = [
        "dismiss_troops",
        "abandon_city", 
        "leave_alliance",
        "spend_cents",  # Real money
    ]
    
    # Forbidden actions (AI can NEVER do)
    FORBIDDEN_ACTIONS = [
        "delete_account",
        "change_password",
        "change_email",
    ]
    
    # Cool-down timers (prevent spam)
    COOLDOWNS = {
        "attack": 60,      # 1 minute between attacks
        "mail": 30,        # 30 seconds between mails
        "farm_npc": 10,    # 10 seconds between farms
    }
```

---

## 📋 PHASE 6: COMPLETE FILE STRUCTURE

### 6.1 New Files to Create

```
D:\svony_studio\
├── src/
│   ├── tools/                          # NEW - All 55 tools
│   │   ├── __init__.py
│   │   ├── network/
│   │   │   ├── amf_decoder.py          # Tool 1
│   │   │   ├── traffic_sniffer.py      # Tool 2
│   │   │   ├── packet_replayer.py      # Tool 3
│   │   │   ├── server_simulator.py     # Tool 4
│   │   │   ├── mitm_proxy.py           # Tool 5
│   │   │   ├── connection_logger.py    # Tool 6
│   │   │   ├── token_generator.py      # Tool 7
│   │   │   ├── api_monitor.py          # Tool 8
│   │   │   ├── latency_analyzer.py     # Tool 9
│   │   │   ├── packet_fuzzer.py        # Tool 10
│   │   │   ├── pattern_analyzer.py     # Tool 11
│   │   │   └── protocol_docs.py        # Tool 12
│   │   ├── automation/
│   │   │   ├── command_executor.py     # Tool 13
│   │   │   ├── script_ide.py           # Tool 14
│   │   │   ├── city_manager.py         # Tool 15
│   │   │   ├── auto_build.py           # Tool 16
│   │   │   ├── army_automation.py      # Tool 17
│   │   │   ├── npc_farmer.py           # Tool 18
│   │   │   ├── resource_manager.py     # Tool 19
│   │   │   ├── hero_manager.py         # Tool 20
│   │   │   ├── alliance_tools.py       # Tool 21
│   │   │   ├── mail_automation.py      # Tool 22
│   │   │   ├── report_analyzer.py      # Tool 23
│   │   │   ├── colony_manager.py       # Tool 24
│   │   │   ├── timing_optimizer.py     # Tool 25
│   │   │   ├── script_converter.py     # Tool 26
│   │   │   └── glitch_detector.py      # Tool 27
│   │   ├── reverse_engineering/
│   │   │   ├── abc_browser.py          # Tool 28
│   │   │   ├── swf_structure.py        # Tool 29
│   │   │   ├── class_hierarchy.py      # Tool 30
│   │   │   ├── asset_extractor.py      # Tool 31
│   │   │   ├── symbol_viewer.py        # Tool 32
│   │   │   ├── constant_pool.py        # Tool 33
│   │   │   ├── method_viewer.py        # Tool 34
│   │   │   ├── binary_inspector.py     # Tool 35
│   │   │   ├── swf_recompiler.py       # Tool 36
│   │   │   └── swf_diff.py             # Tool 37
│   │   ├── crypto/
│   │   │   ├── universal_decryptor.py  # Tool 38
│   │   │   ├── xor_decrypter.py        # Tool 39
│   │   │   ├── aes_decrypter.py        # Tool 40
│   │   │   ├── blowfish_decrypter.py   # Tool 41
│   │   │   ├── hash_calculator.py      # Tool 42
│   │   │   ├── evony_token_gen.py      # Tool 43
│   │   │   ├── session_extractor.py    # Tool 44
│   │   │   └── hash_reverser.py        # Tool 45
│   │   └── data/
│   │       ├── troop_calculator.py     # Tool 46
│   │       ├── building_calculator.py  # Tool 47
│   │       ├── tech_tree.py            # Tool 48
│   │       ├── item_browser.py         # Tool 49
│   │       ├── equipment_browser.py    # Tool 50
│   │       ├── fort_viewer.py          # Tool 51
│   │       ├── logo_browser.py         # Tool 52
│   │       ├── castle_logos.py         # Tool 53
│   │       ├── battle_simulator.py     # Tool 54
│   │       └── march_calculator.py     # Tool 55
│   ├── ui/panels/
│   │   ├── crypto_panel.py             # NEW - Crypto Tools tab
│   │   ├── data_browser_panel.py       # NEW - Data Browser tab
│   │   ├── re_tools_panel.py           # NEW - RE Tools tab
│   │   └── ai_assistant_panel.py       # NEW - AI Assistant panel
│   └── ai/
│       ├── __init__.py                 # NEW - AI module
│       ├── script_recorder.py          # NEW - Recording system
│       ├── training_pipeline.py        # NEW - Model training
│       ├── decision_engine.py          # NEW - AI decisions
│       └── guardrails.py               # NEW - Safety limits
├── assets/
│   └── backgrounds/                    # NEW - Theme backgrounds
│       ├── borg_circuit.png
│       ├── evony_map_dark.png
│       └── ... (10 more)
└── scripts/
    ├── run_dev.ps1                     # NEW - Dev launcher
    ├── run_prod.ps1                    # NEW - Prod launcher
    └── test_all.ps1                    # NEW - Full test suite
```

---

## 📋 IMPLEMENTATION TIMELINE

### Week 1: Emergency Fixes (Phase 0)
- [ ] Remove all 12 stub functions
- [ ] Wire existing functions to real implementations
- [ ] Import missing panels into main.py
- [ ] Fix all "not implemented" messages

### Week 2: Core Tabs Part 1 (Phase 1A)
- [ ] Create Crypto Tools tab with panel
- [ ] Implement XOR/AES/Blowfish decrypters
- [ ] Wire encryption keys from config
- [ ] Add hash calculator

### Week 3: Core Tabs Part 2 (Phase 1B)
- [ ] Create Data Browser tab
- [ ] Create RE Tools tab
- [ ] Wire to existing data files
- [ ] Add XML.bin parsers

### Week 4: Theme System + RE Tools Start (Phase 2A + 3)
- [ ] Add 4 new themes
- [ ] Create background image system
- [ ] Start ABC Browser tool
- [ ] Start SWF Structure viewer

### Week 5: Testing Suite (Phase 4)
- [ ] Complete dual-SWF panel
- [ ] Implement packet capture
- [ ] Add AMF decoder
- [ ] Add packet replay

### Week 6-7: Remaining Tools (Phase 2B)
- [ ] Network tools (12)
- [ ] Automation tools (15)
- [ ] Crypto tools (8)
- [ ] Data tools (10)

### Week 8: AI Integration (Phase 5)
- [ ] Script recorder
- [ ] Training pipeline
- [ ] AI assistant panel
- [ ] Guardrails system

---

## 📊 SUCCESS METRICS

| Metric | Current | Target | Gap |
|--------|---------|--------|-----|
| GUI Feature Coverage | 24% | 100% | 76% |
| Working Functions | 80 | 328 | 248 |
| Stub Functions | 12 | 0 | -12 |
| Tools Implemented | 0 | 55 | 55 |
| Themes Available | 8 | 12 | 4 |
| AI Features | 0 | 5 | 5 |
| Test Coverage | ~20% | 85% | 65% |

---

## 🚀 NEXT IMMEDIATE STEPS

1. **RIGHT NOW**: Fix the 12 stub functions in main.py
2. **TODAY**: Import the 4 missing panels
3. **THIS WEEK**: Create Crypto Tools panel
4. **THIS WEEK**: Create Data Browser panel
5. **THIS WEEK**: Create RE Tools panel

**Start Command:**
```powershell
cd D:\svony_studio
python main.py
```

---

*This action plan replaces all previous roadmaps. Follow phases in order.*
*ZERO TOLERANCE for simulated, mocked, or placeholder code.*
