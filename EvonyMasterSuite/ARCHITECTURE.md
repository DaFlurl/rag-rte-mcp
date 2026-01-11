# EVONY MASTER SUITE - Architecture

## System Overview

```
┌──────────────────────────────────────────────────────────────────────┐
│                        EVONY MASTER SUITE                             │
│                Ultimate Integrated Hacking Framework                  │
└──────────────────────────────────────────────────────────────────────┘
                                    │
        ┌───────────────────────────┼───────────────────────────┐
        │                           │                           │
        ▼                           ▼                           ▼
┌───────────────┐         ┌───────────────┐         ┌───────────────┐
│  Master Suite │         │   BorgToolkit │         │   AutoEvony   │
│  Web Server   │         │Exploit Server │         │  Integration  │
│  Port: 9000   │         │  Port: 8088   │         │  Port: 8088   │
└───────────────┘         └───────────────┘         └───────────────┘
        │                           │                           │
        └───────────────────────────┼───────────────────────────┘
                                    │
                    ┌───────────────┼───────────────┐
                    │               │               │
                    ▼               ▼               ▼
            ┌─────────────┐ ┌─────────────┐ ┌─────────────┐
            │ FlashBrowser│ │ AutoEvony2  │ │ Evony Game  │
            │  (Electron) │ │   (.swf)    │ │   Server    │
            └─────────────┘ └─────────────┘ └─────────────┘
```

## Components

### 1. Master Suite (master_suite.py)
**Port: 9000**

Main dashboard and management interface:
- Account manager (124 accounts)
- Script library (166+ scripts)
- Exploit engine
- Protocol reference (301+ commands)
- Source browser (3,278 AS3 files)
- Crypto tools

Endpoints:
```
GET /              - Dashboard
GET /accounts      - Account list
GET /scripts       - Script library
GET /protocol      - Protocol commands
GET /generate/*    - Exploit generators
GET /api/*         - JSON API
```

### 2. BorgToolkit (BorgToolkit/advanced_server.py)
**Port: 8088**

Exploit framework server:
- Pre-built exploit scripts
- Overflow calculators
- Raw command injection
- Signature generation

Endpoints:
```
GET /epic/overflow_chain    - Multi-troop overflow
GET /epic/race_blitz        - Race condition attack
GET /epic/full_auto         - Complete automation
GET /api/CMD?params         - Raw command injection
GET /calc/overflow?troop=6  - Calculate overflow
```

### 3. AutoEvony Integration (autoevony_integration.py)
**Port: 8088**

Bridge between AutoEvony and web browser:
- Script serving for `includeurl`
- Custom script injection
- Control API

Usage in AutoEvony:
```
includeurl http://localhost:8088/overflow_chain
```

### 4. Browser Controller (browser_controller.py)

FlashBrowser automation:
- Launch browser with URLs
- Game server selection
- Process management

### 5. Protocol Injector (protocol_injector.py)

AMF packet creation:
- Signature generation
- Login hash creation
- Packet building

## Data Sources

### Extracted Resources

| Source | Location | Count |
|--------|----------|-------|
| Bot Source | AS3_Scripts_(AutoEvony2) | 1,187 files |
| Client Source | AS3_Scripts_(EvonyClient) | 2,091 files |
| Scripts | Scripts/ | 166 files |
| SOL Files | SOL_Accounts/ | 1,693 files |
| Accounts | sol_analysis/accounts.json | 124 accounts |
| Tools | Tools/ | 16,705 files |

### Encryption Keys

```python
ACTION_KEY = "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"
API_KEY = "9f758e2deccbe6244f734371b9642eda"
USER_INFO_KEY = "IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}"
XOR_KEY = 0xAA
LOGIN_SALT = "evony"
```

### Troop Overflow Thresholds

| Troop | ID | Food Cost | Overflow Threshold |
|-------|------|-----------|-------------------|
| Worker | 1 | 50 | 42,949,673 |
| Warrior | 2 | 75 | 28,633,116 |
| Scout | 3 | 100 | 21,474,837 |
| Archer | 6 | 350 | 6,135,037 |
| Cavalry | 7 | 800 | 2,684,355 |
| Cataphract | 8 | 1500 | 1,431,656 |
| Ballista | 10 | 2000 | 1,073,742 |

## Workflow

### Standard Exploit Flow

```
1. Start Master Suite
   python master_suite.py
   
2. Open Dashboard
   http://localhost:9000
   
3. Start FlashBrowser
   FlashBrowser/FlashBrowser.exe
   
4. Load Game
   http://cc2.evony.com/s.html
   
5. Start AutoEvony
   Load AutoEvony2.swf in Flash Player
   
6. Execute Exploits
   In AutoEvony: includeurl http://localhost:8088/overflow_chain
```

### AutoEvony + Browser Integration

The screenshot shows both running together:
- AutoEvony (top): Script editor, bot commands
- Browser (bottom): Game client with embedded Flash

AutoEvony can:
- Control the embedded browser
- Execute scripts that interact with game
- Monitor game state
- Automate gameplay

## File Structure

```
Evony_Decrypted/
├── EvonyMasterSuite/           # THIS SUITE
│   ├── master_suite.py         # Main web dashboard (1,364 lines)
│   ├── autoevony_integration.py # AutoEvony bridge
│   ├── browser_controller.py   # FlashBrowser control
│   ├── protocol_injector.py    # AMF packet tools
│   ├── run_suite.bat           # Windows launcher
│   └── README.md               # Documentation
│
├── BorgToolkit/                # Exploit framework
│   ├── advanced_server.py      # HTTP exploit server
│   ├── src/                    # Python modules
│   ├── scripts/                # Pre-built exploits
│   └── docs/                   # Documentation
│
├── AS3_Scripts_(AutoEvony2)/   # Bot source code
├── AS3_Scripts_(EvonyClient)/  # Client source code
├── Scripts/                    # Bot scripts
├── Accounts/                   # Account lists
├── sol_analysis/               # Extracted SOL data
├── FlashBrowser/               # Electron Flash browser
├── Tools/                      # RE tools (Ghidra, FFDEC, etc.)
├── PyAMF/                      # Python AMF library
└── FluorineFx-AMF-Library/     # .NET AMF library
```

## Security Considerations

### Safety Limits

| Limit | Value | Warning |
|-------|-------|---------|
| Max Safe Food | 485M | Flips to 0 at 999M! |
| Max Single Troop | 700M | Overflow risk |
| Valley Transport | 495M | Server limit |

### Critical Warnings

1. **Food Flip Bug**: Food WILL reset to 0 if it exceeds 999,000,000
2. **Troop Overflow**: Single troop type overflow at 700M+
3. **Account Security**: 124 accounts extracted - use responsibly
