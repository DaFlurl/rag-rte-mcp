# ⚔️ EVONY ULTIMATE COMMAND CENTER v3.0

> **The most comprehensive Evony Age II reverse engineering and automation toolkit**

Built from **120,470 extracted files** including complete game client source, bot source, AMF libraries, and 23 RE tools.

## 📊 What's Included

| Component | Count | Description |
|-----------|-------|-------------|
| **Total Files** | 120,470 | Complete extraction |
| **Protocol Commands** | 352 | Full AMF API |
| **SOL Accounts** | 1,693 | Flash cookie profiles |
| **Bot Scripts** | 166+ | AutoEvony automation |
| **AS3 Source Files** | 3,278 | Decompiled ActionScript |
| **RE Tools** | 23 | FFDEC, Ghidra, dnSpy, etc. |

## 🚀 Quick Start

1. **Run the launcher:**
   ```batch
   run_command_center.bat
   ```

2. **Or manually:**
   ```batch
   cd C:\Users\Admin\Downloads\Evony_Decrypted\EvonyCommandCenter
   python evony_command_center.py
   ```

## 🔑 Encryption Keys (Extracted)

```python
ACTION_KEY = "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"
API_KEY = "9f758e2deccbe6244f734371b9642eda"
USER_INFO_KEY = "IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}"
XOR_KEY = 0xAA (170)
GAME_KEY = "EvonyGameKey2009"
NETWORK_KEY = "EvonyNetKey2009"
```

## ⚠️ Critical Game Limits

| Limit | Value | Risk |
|-------|-------|------|
| MAX_SAFE_FOOD | 485,000,000 | CRITICAL - Flips to 0 at 999M! |
| MAX_SAFE_TROOP | 700,000,000 | CRITICAL - Single type overflow |
| VALLEY_TRANSPORT | 495,000,000 | Medium - Transport exploit |
| INT32_MAX | 2,147,483,647 | Reference |

## 💀 Known Exploits

1. **Food Flip Glitch** (CRITICAL)
   - Food resets to 0 when exceeding 999M
   - Safe max: 485M

2. **Troop Overflow** (CRITICAL)
   - Single troop type overflows at 700M+
   
3. **Valley Amulet Farm** (HIGH)
   - Intentional troop loss for 25K+ amulets/day

4. **Commission Quest Glitch** (MEDIUM)
   - Resource multiplication via timing exploit

5. **Wheel Automation** (LOW)
   - ~20K cents/day automated

## 📁 Directory Structure

```
Evony_Decrypted/
├── AS3_Scripts_(AutoEvony2_NEW.swf)/    # Bot source (1,187 files)
├── AS3_Scripts_(EvonyClient1921.swf)/   # Client source (2,091 files)
├── Scripts/                              # Bot scripts (166+)
├── FlashBrowser/                         # Electron Flash browser
├── Tools/                                # RE tools (23)
│   ├── ffdec_22.0.2/                    # SWF decompiler
│   ├── ghidra_11.3/                     # NSA RE tool
│   ├── dnSpy64/                         # .NET decompiler
│   └── ...
├── PyAMF/                               # Python AMF library
├── FluorineFx-AMF-Library/              # .NET AMF library
├── SOL_Accounts/                        # Flash cookies
├── Macromedia/                          # SOL data
├── Keys/                                # Encryption keys
└── EvonyCommandCenter/                  # This toolkit
```

## 🎮 Features

### 📊 Dashboard
- System stats overview
- Quick launch buttons
- Encryption keys display

### 📜 Script Studio
- 166+ script library
- Syntax-aware editor
- Load/save scripts

### 📡 Protocol Commander
- All 352 AMF commands
- Command builder
- Category filtering

### 💀 Exploit Engine
- Known exploit database
- Vulnerability scanner
- Exploit script generator

### 📂 Source Browser
- 3,278 AS3 files
- Pattern search
- Source viewer

### 🔐 Crypto Tools
- All encryption keys
- Signature generator (MD5, API, XOR)
- Game limits reference

## 🔧 Integrated Tools

| Tool | Path | Purpose |
|------|------|---------|
| FlashBrowser | `FlashBrowser/FlashBrowser.exe` | Flash-enabled browser |
| FFDEC | `Tools/ffdec_22.0.2/ffdec.exe` | SWF decompiler |
| Ghidra | `Tools/ghidra_11.3/ghidraRun.bat` | Binary analysis |
| dnSpy | `Tools/dnSpy64/dnSpy.exe` | .NET decompiler |
| Ruffle | `Tools/ruffle/ruffle.exe` | Flash emulator |

## 📡 Protocol Categories (352 Commands)

- **alliance** - Alliance management
- **army** - Army/troop control
- **capital** - Capital city actions
- **castle** - Building/construction
- **city** - City management
- **colony** - Colony operations
- **commission** - Quest system
- **common** - Chat/general
- **fortifications** - Defenses
- **hero** - Hero management
- **interior** - Resource production
- **mail** - Messaging
- **quest** - Quests
- **rank** - Rankings
- **shop** - Store
- **tech** - Research
- **trade** - Trading
- **troop** - Troop production
- **gamemaster** - GM commands

## 🛠️ Requirements

- Python 3.10+
- Windows 10/11
- tkinter (included with Python)

## 📝 License

For educational and research purposes only.

---

**Built with 120,470 files of Evony data • 352 commands • 3,278 source files**
