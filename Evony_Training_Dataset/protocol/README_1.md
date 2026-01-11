# ╔══════════════════════════════════════════════════════════════════════════╗
# ║                      EVONY MEGA TOOLKIT                                   ║
# ║               Complete Protocol • 246 Commands • Live Exploits            ║
# ╚══════════════════════════════════════════════════════════════════════════╝

## 🚀 Quick Start

### Option 1: GUI Toolkit
```bash
python mega_toolkit.py
```

### Option 2: Script Server (for AutoEvony)
```bash
python script_server.py
```
Then in AutoEvony:
```
includeurl http://localhost:8888/exploit/overflow_all
```

---

## 📊 What's Inside

| Component | Count | Description |
|-----------|-------|-------------|
| **Protocol Commands** | 246 | Complete client API extracted from EvonyClient1921.swf |
| **Bot Scripts** | 166+ | AutoEvony script library |
| **Source Files** | 3,278 | Decompiled AS3 from client & bot |
| **SOL Accounts** | 1,693 | Flash cookie files |
| **Known Exploits** | 8 | Documented vulnerabilities |
| **Encryption Keys** | 7 | Extracted from source |

---

## 🔑 Extracted Encryption Keys

```python
ACTION_KEY = "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"
API_KEY = "9f758e2deccbe6244f734371b9642eda"
USER_INFO_KEY = "IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}"
XOR_KEY = 0xAA (170)
LOGIN_SALT = "evony"
GAME_KEY = "EvonyGameKey2009"
NETWORK_KEY = "EvonyNetKey2009"
```

---

## ⚠️ Critical Game Limits

| Limit | Value | Warning |
|-------|-------|---------|
| MAX_SAFE_FOOD | 485,000,000 | **FLIPS TO 0 AT 999M!** |
| MAX_SAFE_TROOP | 700,000,000 | Per type |
| MAX_VALLEY_TRANSPORT | 495,000,000 | |
| INT32_MAX | 2,147,483,647 | Used for overflow calc |

---

## 💉 Exploit Scripts

### Available via Script Server

| Endpoint | Description |
|----------|-------------|
| `/exploit/overflow_all` | Train all troop types at overflow threshold |
| `/exploit/race_blitz` | Rapid-fire 50 item uses |
| `/exploit/amulet_farm` | Valley farming for 25K amulets/day |
| `/exploit/security_probe` | Test common security codes |
| `/exploit/resource_safe` | Monitor food to prevent flip |

### Troop Overflow Thresholds

| Troop | Cost | Threshold | Expected Gain |
|-------|------|-----------|---------------|
| Worker | 50 | 42,949,673 | ~2.1B food |
| Warrior | 75 | 28,633,116 | ~2.1B food |
| Scout | 100 | 21,474,837 | ~2.1B food |
| Pikeman | 200 | 10,737,419 | ~2.1B food |
| Swordsman | 250 | 8,589,935 | ~2.1B food |
| **Archer** | 350 | **6,135,037** | **~2.1B food** |
| Cavalry | 800 | 2,684,355 | ~2.1B food |
| Cataphract | 1500 | 1,431,656 | ~2.1B food |
| Transporter | 500 | 4,294,967 | ~2.1B food |
| Ballista | 2000 | 1,073,742 | ~2.1B food |
| Ram | 3000 | 715,827 | ~2.1B food |
| Catapult | 5000 | 429,496 | ~2.1B food |

---

## 📡 Protocol Command Categories (246 Total)

| Category | Commands | Key Functions |
|----------|----------|---------------|
| `alliance` | 31 | Create, join, manage alliances |
| `army` | 14 | Move troops, call back, exercise |
| `capital` | 7 | Levy resources, taxes |
| `castle` | 19 | Build, upgrade, demolish |
| `celeb` | 4 | Rankings by prestige/title |
| `city` | 13 | Construct castles, rename |
| `colony` | 15 | Colony management, levy |
| `commission` | 9 | Commission quests |
| `common` | 44 | Chat, packages, security |
| `equipment` | 6 | Gems, equipment tech |
| `equipmenttech` | 5 | Research equipment |
| `field` | 3 | Field info |
| `fortifications` | 6 | Wall defenses |
| `friend` | 5 | Friends, blocks |
| `furlough` | 2 | Vacation mode |
| `gamblingranking` | 3 | Wheel rankings |
| `gamemaster` | 8 | Admin commands (restricted) |
| `hero` | 26 | Hire, level, manage heroes |
| `interior` | 5 | Tax rate, production |
| `mail` | 8 | Send, receive, delete mail |
| `npchero` | 4 | NPC heroes |
| `quest` | 11 | Accept, complete quests |
| `rank` | 6 | Player/alliance rankings |
| `report` | 6 | Battle reports |
| `shop` | 9 | Buy items, **use items (exploit!)** |
| `stratagem` | 1 | Use stratagems |
| `tech` | 5 | Research technology |
| `trade` | 6 | Marketplace trading |
| `troop` | 7 | **Train troops (overflow!)** |
| `truce` | 3 | Peace/truce modes |
| `visit` | 7 | Visit other players |
| `vote` | 2 | Player voting |

---

## 🛠️ Tools Included

| Tool | Location | Purpose |
|------|----------|---------|
| FlashBrowser | `../FlashBrowser/` | Electron browser with Flash support |
| FFDEC | `../Tools/ffdec/` | Flash decompiler |
| dnSpy | `../Tools/dnSpy64/` | .NET decompiler |
| RABCDAsm | `../Tools/rabcdasm/` | ActionScript assembler |
| Ghidra | `../Tools/ghidra_11.3/` | Reverse engineering |
| PyAMF | `../PyAMF/` | Python AMF library |
| FluorineFx | `../FluorineFx-AMF-Library/` | .NET AMF library |

---

## 📁 Project Structure

```
EvonyMegaToolkit/
├── mega_toolkit.py          # Main GUI application
├── script_server.py         # HTTP server for AutoEvony
├── run_toolkit.bat          # Windows launcher
├── requirements.txt         # Python dependencies
├── README.md                # This file
└── src/
    └── protocol.py          # 246 protocol commands + exploits
```

---

## 🌐 FlashBrowser Integration

FlashBrowser allows running AutoEvony2_NEW.swf with embedded web browser:

1. Launch FlashBrowser: `../FlashBrowser/FlashBrowser.exe`
2. Open `AutoEvony2_NEW.swf`
3. Login to your account
4. Use Script tab to load/run scripts
5. Embedded browser shows game client in real-time

---

## 📜 AutoEvony Script Syntax

### Variables
```
set var value
setarr arr "val1,val2,val3"
setarray arr ["val1", "val2"]
```

### Control Flow
```
label myLabel
goto myLabel
if {%condition%} goto myLabel
```

### Commands
```
attack x,y hero:troops
reinforce x,y hero:troops
train type:count
transport x,y hero g:f:w:s:i
```

### Variable References
```
%var%              ; Simple variable
{%var%}            ; In expressions
$c.cm.allTroop.archer$   ; Game state reference
```

---

## ⚠️ Disclaimer

This toolkit is for educational and research purposes only. Use of exploits may violate game terms of service and result in account bans. The authors are not responsible for any consequences of using this software.

---

## 📝 Changelog

### v1.0.0
- Initial release
- 246 protocol commands extracted
- 8 known exploits documented
- GUI toolkit with 7 tabs
- HTTP script server
- FlashBrowser integration

---

## 🔗 Related Projects

- **BorgToolkit**: Earlier version with basic exploits
- **Svony Studio**: Main reverse engineering platform
- **evony_automation_tools**: Android ADB automation

---

*Generated by Evony Mega Toolkit - 246 Commands | 166+ Scripts | Live Exploits*
