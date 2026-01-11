# Evony Command Center - Architecture

## System Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                      EVONY COMMAND CENTER v3.0                               │
│                  Ultimate Integrated Control Panel                           │
│                                                                             │
│   Built from 120,470 files • 352 Commands • 1,693 Accounts • 166 Scripts   │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
        ┌───────────────────────────┼───────────────────────────┐
        │                           │                           │
        ▼                           ▼                           ▼
┌───────────────┐         ┌───────────────┐         ┌───────────────┐
│   GUI Layer   │         │ Script Server │         │ Data Manager  │
│  (Tkinter)    │         │  (Port 8088)  │         │ (JSON/SOL)    │
└───────────────┘         └───────────────┘         └───────────────┘
        │                           │                           │
        └───────────────────────────┼───────────────────────────┘
                                    │
                    ┌───────────────┼───────────────┐
                    │               │               │
                    ▼               ▼               ▼
            ┌─────────────┐ ┌─────────────┐ ┌─────────────┐
            │   Protocol  │ │   Exploit   │ │   Crypto    │
            │   Engine    │ │   Engine    │ │   Toolkit   │
            └─────────────┘ └─────────────┘ └─────────────┘
```

## Features Matrix

| Feature | Status | Description |
|---------|--------|-------------|
| FlashBrowser Integration | ✅ | Launch and control Flash browser |
| AutoEvony Integration | ✅ | Script execution via includeurl |
| 352 Protocol Commands | ✅ | Complete AMF API reference |
| 1,693 SOL Accounts | ✅ | Account manager with credentials |
| 166+ Bot Scripts | ✅ | Script library with editor |
| AI Script Generator | ✅ | Generate scripts from prompts |
| Exploit Discovery | ✅ | Automated vulnerability scanning |
| AMF Intercept/Inject | ✅ | Protocol manipulation |
| Multi-Account Swarm | ✅ | Borg-style coordination |
| Source Browser | ✅ | Browse 3,278 AS3 files |
| Pattern Analyzer | ✅ | Find vulnerabilities |
| Crypto Toolkit | ✅ | All encryption keys |

## GUI Tabs

| Tab | Purpose |
|-----|---------|
| 🎯 Dashboard | Status, quick actions, keys |
| 📡 Protocol | 352+ command browser |
| 📜 Scripts | Script editor & library |
| 💀 Exploits | Overflow calculator, chains |
| 🔐 Crypto | Keys, signatures, hashing |
| 👤 Accounts | SOL manager (1,693 accounts) |
| 🔍 Source | AS3 source browser |
| 🤖 Swarm | Multi-account controller |
| 🛠️ Tools | External tool launcher |

## Protocol Command Categories

| Category | Count | Key Commands |
|----------|-------|--------------|
| alliance | 28 | getAllianceInfo, join, exit |
| army | 24 | newArmy, callBackArmy |
| castle | 18 | upgrade, speedUpBuild |
| common | 22 | getPackage, authSecurityCode |
| hero | 16 | hireHero, promoteHero |
| interior | 14 | taxLevy, comforting |
| quest | 12 | award, obtainQuest |
| shop | 18 | useGoods, buy |
| tech | 8 | research, speedUpResearch |
| troop | 14 | produceTroop, cancelProduce |
| **Total** | **352+** | |

## Encryption Keys

```python
ENCRYPTION_KEYS = {
    "ACTION_KEY": "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}",
    "API_KEY": "9f758e2deccbe6244f734371b9642eda",
    "USER_INFO_KEY": "IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}",
    "XOR_KEY": "0xAA (170)",
    "GAME_KEY": "EvonyGameKey2009",
    "NETWORK_KEY": "EvonyNetKey2009",
}
```

## Safety Limits

| Limit | Value | Warning |
|-------|-------|---------|
| INT32_MAX | 2,147,483,647 | Overflow boundary |
| MAX_SAFE_FOOD | 485,000,000 | Keep below this! |
| MAX_SAFE_TROOP | 700,000,000 | Per troop type |
| FOOD_FLIP | 999,000,000 | RESETS TO 0! |
| VALLEY_TRANSPORT | 495,000,000 | Server limit |

## Troop Overflow Thresholds

| Troop | ID | Cost | Threshold | Script |
|-------|------|------|-----------|--------|
| Worker | 1 | 50 | 42,949,673 | `train wo:42949673` |
| Archer | 6 | 350 | 6,135,037 | `train a:6135037` |
| Cavalry | 7 | 800 | 2,684,355 | `train cav:2684355` |
| Cataphract | 8 | 1500 | 1,431,656 | `train cata:1431656` |
| Ballista | 10 | 2000 | 1,073,742 | `train ba:1073742` |

## File Structure

```
EvonyCommandCenter/
├── evony_command_center.py  # Main application (937 lines)
├── run_command_center.bat   # Windows launcher
├── requirements.txt         # Dependencies
├── README.md                # Documentation
├── ARCHITECTURE.md          # This file
│
└── src/
    ├── __init__.py
    ├── protocol.py          # Protocol definitions
    ├── exploits.py          # Exploit engine
    └── crypto.py            # Crypto utilities
```

## Usage

```bash
# Run the command center
python evony_command_center.py

# Or double-click
run_command_center.bat
```

## AutoEvony Integration

Script server runs on port 8088:

```
includeurl http://localhost:8088/overflow_chain
includeurl http://localhost:8088/race_blitz
includeurl http://localhost:8088/full_auto
```

## External Tools

| Tool | Path | Purpose |
|------|------|---------|
| FlashBrowser | FlashBrowser/FlashBrowser.exe | Flash browser |
| FFDEC | Tools/ffdec/ | SWF decompiler |
| dnSpy | Tools/dnSpy64/ | .NET debugger |
| Ghidra | Tools/ghidra_11.3/ | Binary analysis |
