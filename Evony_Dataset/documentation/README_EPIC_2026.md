# BORG TOOLKIT EPIC 2026

> 🚀 **Complete Multi-Account Evony Automation Platform**

---

## Quick Start

```bash
# Option 1: Double-click
start_epic.bat

# Option 2: Command line
pip install -r requirements.txt
python borg_master.py
```

Then open: **http://localhost:8089/**

---

## Architecture

```
┌────────────────────────────────────────────────────────────────┐
│                    WEB DASHBOARD (8089)                        │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐          │
│  │ Accounts │ │  Cities  │ │ HH Hunt  │ │ Exploits │          │
│  └──────────┘ └──────────┘ └──────────┘ └──────────┘          │
└────────────────────────────────────────────────────────────────┘
                              │
┌────────────────────────────────────────────────────────────────┐
│                    BORG MASTER SERVER                          │
│  • Account Manager    • Task Scheduler   • Event System        │
│  • WebSocket Hub      • REST API         • SQLite Storage      │
└────────────────────────────────────────────────────────────────┘
                              │
        ┌─────────────────────┼─────────────────────┐
        ▼                     ▼                     ▼
┌──────────────┐      ┌──────────────┐      ┌──────────────┐
│ AutoEvony #1 │      │ AutoEvony #2 │      │ AutoEvony #N │
│   Account    │      │   Account    │      │   Account    │
└──────────────┘      └──────────────┘      └──────────────┘
```

---

## Features

### 🔗 Multi-Account Management
- Register unlimited accounts
- Track all cities per account
- Real-time status monitoring
- Per-account configurations

### 🏆 HH Hunter Pro
- Coordinated cross-account hunting
- Server-wide L10 NPC scanning
- Automatic report parsing
- HH location database
- Alert broadcasts

### ⚡ Automation Engine
- Scheduled tax collection
- Quest auto-completion
- Colony farming
- NPC hunting waves
- Resource balancing
- Troop training queues

### 💥 Exploit Suite
- Troop overflow (food glitch)
- Race condition exploits
- Item duplication attempts
- Batch execution

### 📊 Real-Time Dashboard
- Account status cards
- Resource tracking
- HH discovery map
- Event log viewer
- Quick action buttons

---

## Server Endpoints

### Web Dashboard
| URL | Description |
|-----|-------------|
| `http://localhost:8089/` | Main dashboard |

### REST API
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/accounts` | List all accounts |
| POST | `/api/accounts` | Register account |
| GET | `/api/accounts/{id}` | Get account details |
| GET | `/api/cities` | List all cities |
| GET | `/api/hh` | List HH locations |
| GET | `/api/events` | Recent events |
| GET | `/api/status` | Server status |
| POST | `/api/report` | Receive state report |
| POST | `/api/hh/report` | Report HH found |
| POST | `/api/broadcast` | Send to all accounts |

### WebSocket
| URL | Description |
|-----|-------------|
| `ws://localhost:8089/ws/{account_id}` | Real-time connection |

### Bridge Scripts (for AutoEvony)
| URL | Description |
|-----|-------------|
| `/bridge/connect` | Establish connection |
| `/bridge/report_state` | Report full state |
| `/bridge/hh_hunt_pro` | Coordinated HH hunt |
| `/bridge/run_task` | Execute scheduled task |
| `/bridge/help` | List all scripts |

---

## AutoEvony Integration

### Connect an Account
In AutoEvony script console:
```
includeurl http://localhost:8089/bridge/connect
```

### Run HH Hunt
```
includeurl http://localhost:8089/bridge/hh_hunt_pro
```

### Report Full State
```
includeurl http://localhost:8089/bridge/report_state
```

### Run Scheduled Task
```
includeurl http://localhost:8089/bridge/run_task?taskType=TAX_COLLECT
```

---

## Automation Presets

### Basic Farm
- Tax collection every 15 min
- Quest completion every 60 min
- Colony levy every 30 min

### Aggressive Farm
- Tax collection every 10 min
- Quest completion every 30 min
- Colony levy every 15 min
- NPC farming every 20 min
- Amulet spins every 60 min

### HH Hunter
- Full HH scan every 120 min
- Coordinated with other accounts

### Exploit Mode
- Overflow exploit every 300 min
- Tax collection every 15 min

---

## File Structure

```
BorgToolkit/
├── borg_master.py           # Main server (Epic 2026)
├── advanced_server.py       # Script server (port 8088)
├── start_epic.bat           # Easy launcher
├── requirements.txt         # Dependencies
├── data/
│   └── borg_master.db       # SQLite database
├── src/
│   ├── automation_engine.py # Task scheduler
│   ├── connection.py        # Evony connection
│   ├── exploits.py          # Exploit engine
│   └── protocol_commands.py # 301+ commands
├── scripts/
│   └── hh_hunter/
│       ├── epic_hh_hunter.txt
│       └── hh_database.txt  # 692 HH names
└── docs/
    ├── EPIC_2026_ROADMAP.md
    ├── EPIC_HH_HUNTER_ACTION_PLAN.md
    └── PROTOCOL.md
```

---

## Advanced Usage

### Custom Automation Task
```python
from src.automation_engine import AutomationEngine, create_quick_task

engine = AutomationEngine()

# Create custom task
task = create_quick_task(
    account_id="my_account",
    task_type="npc_farm",
    interval=30,  # Every 30 minutes
    npc_level=5,
    waves=5
)
engine.add_task(task)
```

### Direct API Calls
```bash
# List accounts
curl http://localhost:8089/api/accounts

# Register account
curl -X POST http://localhost:8089/api/accounts \
  -H "Content-Type: application/json" \
  -d '{"name": "MyAccount", "server": "na1"}'

# Report HH found
curl -X POST http://localhost:8089/api/hh/report \
  -H "Content-Type: application/json" \
  -d '{"coords": "500,500", "hero_name": "Joan of Arc", "account_id": "user1"}'
```

---

## Ports

| Port | Service | Description |
|------|---------|-------------|
| 8088 | Advanced Server | Script server (exploits, HH hunter) |
| 8089 | Borg Master | Dashboard, API, WebSocket |

---

## Requirements

- Python 3.8+
- FastAPI
- Uvicorn
- SQLite (built-in)
- AutoEvony (for game connection)

---

## Security Notes

⚠️ **This toolkit is for educational purposes only.**

- Do not share your credentials
- Run on localhost only
- Use at your own risk
- Game exploits may violate ToS

---

## Changelog

### v2026.1.0 (Epic Edition)
- Multi-account management system
- Real-time WebSocket bridge
- Web dashboard with live updates
- Automation engine with presets
- HH Hunter Pro coordination
- SQLite persistent storage
- REST API endpoints
- 692 Historic Hero database

---

*Built for the Evony community by BorgToolkit*
