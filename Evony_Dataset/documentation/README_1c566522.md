# ⚡ EVONY HACKER TOOLKIT - AI Exploit Studio v2.0

> **The Ultimate Evony Age II Reverse Engineering & Automation Suite**

A comprehensive GUI application for creating scripts, discovering exploits, and automating Evony gameplay using the fully decompiled source code.

---

## 🎯 Features

### 📝 Script Studio
- Full script editor with syntax support
- Load and edit 200+ existing bot scripts
- Quick command insertion from parsed Commands.as
- Save/export scripts in RoboEvony format

### 🧠 AI Script Generator
- Describe what you want in plain English
- AI generates complete, working scripts
- Quick prompts for common automation tasks
- Template-based script generation

### 🐛 Exploit Discovery Engine
- Automatic vulnerability scanning
- Known exploit database (Food Flip, Valley Farm, etc.)
- Pattern matching against source code
- Exploit script generation

### 🔍 Pattern Analyzer
- Regex-based source code analysis
- Find potential overflow bugs
- Identify validation gaps
- Locate rate limiting code

### 📂 Source Browser
- Browse decompiled AutoEvony2 source
- Browse decompiled EvonyClient1921 source
- View ActionScript (.as) files
- Navigate class hierarchies

### 🔐 Crypto Tools
- All extracted encryption keys
- XOR/AES/Blowfish decryption tools
- Game limits reference
- Session token analysis

---

## 📁 Directory Structure

```
Evony_Decrypted/
├── evony_hacker_toolkit.py     # Main GUI application
├── run_toolkit.bat             # Windows launcher
├── README.md                   # This file
├── Scripts/                    # 200+ bot scripts
│   ├── 7of9_1Borg_script.txt
│   ├── FoodGlitchCounterV1.2.txt
│   ├── fastattack_v6_LagFree.txt
│   └── ...
├── AS3_Scripts_(AutoEvony2_NEW.swf)/
│   └── autoevony/
│       ├── cmds/Commands.as    # All bot commands
│       ├── net/Connection.as   # Network protocol
│       └── ...
├── AS3_Scripts_(EvonyClient1921.swf)/
│   └── com/evony/
│       ├── client/action/      # Game commands
│       ├── common/beans/       # Data structures
│       └── ...
├── Keys/                       # Encryption keys
├── Docs/                       # Documentation
├── Accounts/                   # Account data
└── Tools/                      # Helper tools
```

---

## 🔑 Extracted Encryption Keys

| Key | Value | Usage |
|-----|-------|-------|
| ACTION_KEY | `TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}` | API calls |
| API_KEY | `9f758e2deccbe6244f734371b9642eda` | Signature |
| XOR_KEY | `0xAA` (170) | String obfuscation |
| GAME_KEY | `EvonyGameKey2009` | AES encryption |

---

## ⚠️ Critical Game Limits (Exploit Safety)

| Limit | Value | Risk |
|-------|-------|------|
| MAX_SAFE_FOOD | 485,000,000 | Food FLIPS to 0 at 999M! |
| MAX_SAFE_TROOP | 700,000,000 | Per troop type |
| MAX_VALLEY_TRANSPORT | 495,000,000 | Transport limit |
| WAVE_TROOP_COUNT | 33,000 | Optimal glitch waves |

---

## 🚀 Quick Start

### Requirements
- Python 3.10+
- tkinter (included with Python)
- Windows 10/11

### Launch
```batch
# Option 1: Double-click
run_toolkit.bat

# Option 2: Command line
python evony_hacker_toolkit.py
```

---

## 🎮 Known Exploits

### 1. Food Flip Glitch (CRITICAL)
- **Risk**: Food resets to 0 when exceeding 999,999,999
- **Safe Zone**: Keep food under 485,000,000
- **Prevention**: Auto-transport to valleys when reaching limit

### 2. Valley Amulet Farm (HIGH)
- **Method**: Intentionally lose troops to red valley
- **Gain**: 15,000 - 25,000 amulets/day
- **Setup**: Red player garrisons 20M archers in valley

### 3. Troop Overflow (CRITICAL)
- **Risk**: Single troop type exceeds safe limit
- **Safe Zone**: Max 700M of any single type
- **Prevention**: Distribute across cities

### 4. Wheel Spin Automation
- **Method**: Automated amulet spinning
- **Gain**: 20,000 cents/day
- **Script**: Use spin command in loop

---

## 📚 Bot Script Reference

### Variables
```
set variableName value
setarr arrayName "value1,value2"
setarray troopNames ["archer", "cata"]
```

### Control Flow
```
label labelName
goto labelName
if {condition} goto labelName
iferror expression goto labelName
```

### Commands
```
attack x,y heroName troopType:count
reinforce x,y heroName troopType:count
scout x,y
transport x,y resource:amount
train troopType count
build buildingName level
```

### Special Syntax
```
%variableName%           # Variable reference
{%var%}                  # Expression
$c.cm.allTroop.archer$   # Object property access
```

---

## 🔧 Development

### Files to Edit
- `evony_hacker_toolkit.py` - Main application
- `EVONY_KEYS` dict - Add new keys
- `KNOWN_EXPLOITS` list - Add exploits
- `BOT_COMMANDS` list - Add commands

### Adding New Features
1. Create new tab in `create_main_tabs()`
2. Add creation method `create_X_tab()`
3. Add functionality methods
4. Update logs

---

## 📝 License

This toolkit is for educational and research purposes only. Use responsibly.

---

## 🤝 Credits

- Decompiled source from AutoEvony2 and EvonyClient1921
- Script library from Borg Collective archives
- Encryption keys extracted via reverse engineering

---

*Built with ❤️ for the Evony reverse engineering community*
