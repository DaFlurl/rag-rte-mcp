# Evony Hub - Architecture

## System Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              EVONY HUB                                       │
│                    Unified Exploitation Framework                           │
│                                                                             │
│   ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐       │
│   │    GUI      │  │   Server    │  │  Automation │  │   Scanner   │       │
│   │  (gui.py)   │  │ (server.py) │  │(automation) │  │ (scanner)   │       │
│   └──────┬──────┘  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘       │
│          │                │                │                │              │
│          └────────────────┴────────────────┴────────────────┘              │
│                                   │                                         │
│                    ┌──────────────┴──────────────┐                         │
│                    │       CORE MODULES          │                         │
│                    ├─────────────────────────────┤                         │
│                    │  borg_toolkit.py            │  Exploit engine         │
│                    │  exploit_discovery.py       │  Auto vulnerability     │
│                    │  glitch_calculator.py       │  Overflow calc          │
│                    │  protocol_exploiter.py      │  Protocol manip         │
│                    │  indexer.py                 │  File indexing          │
│                    │  organizer.py               │  Auto organize          │
│                    │  scheduler.py               │  Task scheduling        │
│                    │  watcher.py                 │  File monitoring        │
│                    └─────────────────────────────┘                         │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
        ┌───────────────────────────┼───────────────────────────┐
        │                           │                           │
        ▼                           ▼                           ▼
┌───────────────┐         ┌───────────────┐         ┌───────────────┐
│  AutoEvony    │         │ FlashBrowser  │         │  Evony Game   │
│   (Bot)       │◄───────►│  (Browser)    │◄───────►│   Servers     │
└───────────────┘         └───────────────┘         └───────────────┘
```

## Module Dependencies

```
main.py
├── config.py              # Central configuration
├── borg_toolkit.py        # Core exploitation (BorgToolkit merged)
│   ├── PROTOCOL_COMMANDS  # 352+ AMF commands
│   ├── ENCRYPTION_KEYS    # All extracted keys
│   ├── TROOP_DATA         # Overflow thresholds
│   └── EXPLOITS           # Exploit definitions
├── exploit_discovery.py   # Automated vulnerability scanner
│   ├── ExploitDiscoveryEngine
│   └── run_full_discovery()
├── glitch_calculator.py   # Integer overflow calculator
│   ├── GlitchCalculator
│   └── run_glitch_calculator()
├── protocol_exploiter.py  # Protocol manipulation tools
│   ├── CommandRegistry
│   └── generate_exploit_toolkit()
├── indexer.py             # File indexing system
│   └── EvonyIndexer
├── organizer.py           # Auto file organization
│   └── EvonyOrganizer
├── scanner.py             # Directory scanner
│   └── EvonyScanner
├── scheduler.py           # Task scheduling
│   └── EvonyScheduler
└── watcher.py             # File system watcher
    └── FileWatcher
```

## Data Flow

```
┌─────────────────┐
│  External Data  │  (Scripts, SOLs, Source code)
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   File Watcher  │  monitors data/ inbox
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│    Organizer    │  categorizes files
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│     Indexer     │  builds searchable index
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│     Scanner     │  extracts exploits/patterns
└────────┬────────┘
         │
         ▼
┌─────────────────────────────────────────────┐
│              Exploit Database               │
├─────────────────────────────────────────────┤
│  • 352+ Protocol Commands                   │
│  • 12 Troop Overflow Thresholds            │
│  • 6 Encryption Keys                       │
│  • 15+ Documented Exploits                 │
│  • 166+ Bot Scripts                        │
│  • 124 Account Credentials                 │
└─────────────────────────────────────────────┘
         │
         ▼
┌─────────────────┐
│  Script Server  │  serves to AutoEvony
│   Port 8088     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   AutoEvony     │  includeurl http://localhost:8088/...
└─────────────────┘
```

## Integrated Toolkits

| Toolkit | Location | Status | Key Features |
|---------|----------|--------|--------------|
| **evony_hub** | ./evony_hub/ | Core | Main hub, automation |
| **BorgToolkit** | ./BorgToolkit/ | Merged | Exploit server, scripts |
| **EvonyMasterSuite** | ./EvonyMasterSuite/ | Linked | Web dashboard |
| **EvonyMegaToolkit** | ./EvonyMegaToolkit/ | Linked | GUI toolkit |
| **Svony_Automation** | ./Svony_Automation/ | Linked | Advanced automation |
| **FlashBrowser** | ./FlashBrowser/ | External | Flash-enabled browser |

## Port Assignments

| Service | Port | Purpose |
|---------|------|---------|
| Script Server | 8088 | AutoEvony includeurl |
| Control API | 8089 | Remote control |
| Master Dashboard | 9000 | Web interface |
| Borg Exploit Server | 8090 | BorgToolkit API |

## Configuration

File: `config.py`

```python
# Core paths
HUB_ROOT = Path(r"C:\Users\Admin\Downloads\Evony_Decrypted")
DATA_INBOX = HUB_ROOT / "data"

# Category definitions
CATEGORIES = {
    'docs': {'path': 'Docs', 'extensions': ['.md', '.txt', '.pdf']},
    'scripts': {'path': 'Scripts', 'extensions': ['.txt', '.re', '.rob']},
    'source': {'path': 'AS3_Scripts_*', 'extensions': ['.as']},
    'tools': {'path': 'Tools', 'extensions': ['.py', '.exe']},
    'accounts': {'path': 'Accounts', 'extensions': ['.txt', '.xlsx']},
}

# Server config
SCRIPT_SERVER_PORT = 8088
CONTROL_SERVER_PORT = 8089
```

## Exploit Categories

### 1. Integer Overflow
- Troop production overflow
- Resource calculation overflow
- Timer overflow

### 2. Race Conditions
- Item use duplication
- Army cloning
- Trade manipulation

### 3. Validation Bypass
- Security code enumeration
- Package ID discovery
- Quest manipulation

### 4. Protocol Manipulation
- Packet injection
- Command forging
- Signature bypass

## Usage Patterns

### Interactive Mode
```bash
python -m evony_hub.main
```

### Daemon Mode (Background)
```bash
python -m evony_hub.main --daemon
```

### Server Only
```bash
python -m evony_hub.server
```

### GUI Mode
```bash
python -m evony_hub.gui
```

### Full Automation
```bash
python -m evony_hub.automation
```

## File Organization Rules

| Pattern | Category | Action |
|---------|----------|--------|
| `*.as` | Source | → AS3_Scripts/ |
| `*.sol` | Data | → SOL_Accounts/ |
| `*glitch*.txt` | Exploits | → Scripts/ |
| `*.py` | Tools | → Tools/ |
| `*account*.txt` | Accounts | → Accounts/ |

## Security Notes

### Safety Limits
| Resource | Max Safe | Danger |
|----------|----------|--------|
| Food | 485M | Resets at 999M |
| Troops | 700M | Overflow |
| Transport | 495M | Limit |

### Encryption Keys
All keys extracted and stored in `borg_toolkit.py`:
- ACTION_KEY
- API_KEY
- USER_INFO_KEY
- XOR_KEY
- LOGIN_SALT
- GAME_KEY
