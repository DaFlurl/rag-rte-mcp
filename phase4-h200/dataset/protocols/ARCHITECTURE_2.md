# Evony Mega Toolkit - Architecture

## System Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    MEGA TOOLKIT GUI                          │
│               (Tkinter Desktop Application)                  │
│                                                              │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐│
│  │Dashboard│ │ Scripts │ │Exploits │ │Protocol │ │  Tools  ││
│  └────┬────┘ └────┬────┘ └────┬────┘ └────┬────┘ └────┬────┘│
│       └──────────┬┴──────────┬┴──────────┬┴──────────┬┘     │
│                  │           │           │           │      │
└──────────────────┼───────────┼───────────┼───────────┼──────┘
                   │           │           │           │
                   ▼           ▼           ▼           ▼
              ┌─────────────────────────────────────────────┐
              │              CORE ENGINE                     │
              ├─────────────────────────────────────────────┤
              │  exploit_engine.py    Exploit calculations  │
              │  protocol.py          352+ AMF commands     │
              │  server.py            Script HTTP server    │
              └─────────────────────────────────────────────┘
                                    │
                    ┌───────────────┼───────────────┐
                    │               │               │
                    ▼               ▼               ▼
            ┌─────────────┐ ┌─────────────┐ ┌─────────────┐
            │  AutoEvony  │ │ FlashBrowser│ │   Scripts   │
            │   (Bot)     │ │  (Browser)  │ │    (166+)   │
            └─────────────┘ └─────────────┘ └─────────────┘
```

## Module Structure

```
EvonyMegaToolkit/
├── mega_toolkit.py          # Main GUI application (779 lines)
├── script_server.py         # Legacy script server
├── run_toolkit.bat          # Windows launcher
├── requirements.txt         # Dependencies
├── README.md                # Documentation
├── ARCHITECTURE.md          # This file
│
└── src/
    ├── __init__.py
    ├── protocol.py          # 352+ protocol commands
    ├── server.py            # HTTP script server
    │
    └── core/
        ├── __init__.py
        └── exploit_engine.py # Core exploit logic
```

## GUI Tabs

| Tab | Features |
|-----|----------|
| **Dashboard** | Status, quick launch, keys |
| **Scripts** | 166+ bot scripts, editor |
| **Exploits** | Overflow calculator, all exploits |
| **Protocol** | 352+ command reference |
| **Source** | Browse AS3 source code |
| **Tools** | Launch external tools |
| **AI** | Script generation (optional) |

## Data Sources

| Source | Path | Files |
|--------|------|-------|
| Bot Source | AS3_Scripts_(AutoEvony2) | 1,187 |
| Client Source | AS3_Scripts_(EvonyClient) | 2,091 |
| Scripts | Scripts/ | 166 |
| SOL Files | SOL_Accounts/ | 1,693 |
| Accounts | sol_analysis/ | 124 |

## Exploit Engine

### Overflow Calculations

| Troop | ID | Cost | Threshold | Gain |
|-------|------|------|-----------|------|
| Archer | 6 | 350 | 6,135,037 | ~2.1B |
| Cavalry | 7 | 800 | 2,684,355 | ~2.1B |
| Cataphract | 8 | 1500 | 1,431,656 | ~2.1B |
| Ballista | 10 | 2000 | 1,073,742 | ~2.1B |

### Encryption Keys

```python
ACTION_KEY = "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"
API_KEY = "9f758e2deccbe6244f734371b9642eda"
XOR_KEY = 0xAA
```

## Script Server

**Port:** 8088

### Endpoints

| Endpoint | Description |
|----------|-------------|
| `/epic/overflow_chain` | Multi-troop overflow |
| `/epic/race_blitz` | Rapid item use |
| `/epic/full_auto` | Complete automation |
| `/epic/valley_hide` | Hide troops |
| `/api/thresholds` | Overflow data (JSON) |
| `/api/keys` | Encryption keys (JSON) |

### AutoEvony Usage

```
includeurl http://localhost:8088/epic/overflow_chain
```

## Safety Limits

| Resource | Max Safe | Danger |
|----------|----------|--------|
| Food | 485M | 999M = RESET |
| Single Troop | 700M | Overflow |
| Transport | 495M | Limit |

## External Integrations

- **FlashBrowser**: Flash-enabled browser
- **AutoEvony**: Bot client
- **FFDEC**: SWF decompiler
- **Ghidra**: Binary analysis
