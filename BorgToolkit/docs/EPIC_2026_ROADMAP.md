# BorgToolkit Epic 2026 - Complete Enhancement Roadmap

## Vision
Transform BorgToolkit from a script server into a **complete multi-account automation platform** with real-time connections, web dashboard, and seamless city management.

---

## Current State Analysis

### What EXISTS:
| Component | Status | Location |
|-----------|--------|----------|
| Script Server | ✅ Working | `advanced_server.py` |
| Protocol Commands | ✅ 301+ commands | `src/protocol_commands.py` |
| Exploit Engine | ✅ Basic | `src/exploits.py` |
| Bot Integration | ✅ Script generation | `src/bot_integration.py` |
| HH Hunter | ✅ Complete | `scripts/hh_hunter/` |

### What's MISSING:
| Component | Priority | Impact |
|-----------|----------|--------|
| Multi-Account Manager | 🔴 CRITICAL | Handle multiple accounts seamlessly |
| Real-Time WebSocket Bridge | 🔴 CRITICAL | Live data sync with accounts |
| Web Dashboard UI | 🟡 HIGH | Easy control interface |
| Account State Sync | 🟡 HIGH | Know all cities, heroes, resources |
| Scheduled Automation | 🟡 HIGH | Run tasks on timers |
| Alert System | 🟢 MEDIUM | Notifications for events |
| Database Storage | 🟢 MEDIUM | Persist account data |

---

## Epic 2026 Architecture

```
┌──────────────────────────────────────────────────────────────────────────────┐
│                        BORG TOOLKIT EPIC 2026                                │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────────┐ │
│  │                         WEB DASHBOARD (React)                           │ │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐      │ │
│  │  │ Accounts │ │  Cities  │ │  Heroes  │ │ HH Hunt  │ │ Exploits │      │ │
│  │  └──────────┘ └──────────┘ └──────────┘ └──────────┘ └──────────┘      │ │
│  └─────────────────────────────────────────────────────────────────────────┘ │
│                                    │                                         │
│                                    ▼                                         │
│  ┌─────────────────────────────────────────────────────────────────────────┐ │
│  │                    BORG MASTER SERVER (Python/FastAPI)                  │ │
│  │                                                                         │ │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐    │ │
│  │  │  Account    │  │   Task      │  │   Event     │  │   Script    │    │ │
│  │  │  Manager    │  │  Scheduler  │  │   System    │  │   Engine    │    │ │
│  │  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘    │ │
│  │                                                                         │ │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐    │ │
│  │  │  WebSocket  │  │   REST      │  │   SQLite    │  │   Exploit   │    │ │
│  │  │  Hub        │  │   API       │  │   Storage   │  │   Engine    │    │ │
│  │  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘    │ │
│  └─────────────────────────────────────────────────────────────────────────┘ │
│                                    │                                         │
│                    ┌───────────────┼───────────────┐                         │
│                    ▼               ▼               ▼                         │
│  ┌─────────────────────┐ ┌─────────────────────┐ ┌─────────────────────┐    │
│  │    AutoEvony #1     │ │    AutoEvony #2     │ │    AutoEvony #N     │    │
│  │  ┌───────────────┐  │ │  ┌───────────────┐  │ │  ┌───────────────┐  │    │
│  │  │ Account: user1│  │ │  │ Account: user2│  │ │  │ Account: userN│  │    │
│  │  │ Cities: 5     │  │ │  │ Cities: 3     │  │ │  │ Cities: 7     │  │    │
│  │  └───────────────┘  │ │  └───────────────┘  │ │  └───────────────┘  │    │
│  │        │            │ │        │            │ │        │            │    │
│  │        ▼            │ │        ▼            │ │        ▼            │    │
│  │   Evony Server      │ │   Evony Server      │ │   Evony Server      │    │
│  └─────────────────────┘ └─────────────────────┘ └─────────────────────┘    │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
```

---

## Epic Features List

### 1. ACCOUNT MANAGEMENT
- [ ] Multi-account registration and storage
- [ ] Per-account configuration profiles
- [ ] Account grouping (farms, mains, alliance)
- [ ] Credential encryption
- [ ] Session persistence

### 2. CITY MANAGEMENT
- [ ] Auto-detect all cities per account
- [ ] City-specific automation profiles
- [ ] Resource tracking across all cities
- [ ] Hero assignment optimizer
- [ ] Building queue manager

### 3. REAL-TIME SYNC
- [ ] WebSocket connection to each AutoEvony instance
- [ ] Live resource updates
- [ ] Army movement tracking
- [ ] Event notifications (attacks, scouts)
- [ ] Heartbeat monitoring

### 4. HH HUNTER PRO
- [ ] Cross-account HH hunting coordination
- [ ] Server-wide L10 NPC database
- [ ] Auto-capture when HH found
- [ ] HH rarity/value scoring
- [ ] Hunt scheduling by time zones

### 5. AUTOMATION SUITE
- [ ] Scheduled tax collection
- [ ] Auto-quest completion
- [ ] Colony management
- [ ] NPC farming schedules
- [ ] Resource balancing between cities

### 6. EXPLOIT ENGINE
- [ ] One-click overflow on any city
- [ ] Batch exploits across accounts
- [ ] Race condition automation
- [ ] Validation bypass tools
- [ ] Safe exploit recommendations

### 7. WEB DASHBOARD
- [ ] Account overview cards
- [ ] City detail panels
- [ ] Real-time resource graphs
- [ ] HH hunt status map
- [ ] Exploit launcher
- [ ] Log viewer

### 8. ALERTS & NOTIFICATIONS
- [ ] Discord webhook integration
- [ ] Email alerts
- [ ] Browser notifications
- [ ] Attack warnings
- [ ] HH found alerts

---

## Implementation Phases

### Phase 1: Core Infrastructure (Week 1)
1. Build FastAPI master server
2. Create SQLite database schema
3. Implement account manager
4. Build WebSocket hub

### Phase 2: AutoEvony Bridge (Week 2)
1. Create bridge script for AutoEvony
2. Implement state reporting
3. Build command receiver
4. Test bi-directional communication

### Phase 3: Feature Modules (Week 3)
1. HH Hunter Pro
2. Automation scheduler
3. Exploit engine integration
4. Event system

### Phase 4: Web Dashboard (Week 4)
1. React frontend setup
2. Account management UI
3. City overview panels
4. Real-time data binding

### Phase 5: Polish & Deploy (Week 5)
1. Docker containerization
2. Documentation
3. Testing & bug fixes
4. Release

---

## Technology Stack

| Layer | Technology | Purpose |
|-------|------------|---------|
| Backend | Python 3.11 + FastAPI | Master server |
| Database | SQLite + SQLAlchemy | Data persistence |
| WebSocket | python-socketio | Real-time comms |
| Frontend | React + TailwindCSS | Web dashboard |
| Bot Bridge | AutoEvony Scripts | Connection to game |

---

## Quick Start Commands

```bash
# Install dependencies
pip install fastapi uvicorn sqlalchemy python-socketio aiosqlite

# Start master server
python borg_master.py

# Access dashboard
http://localhost:8089

# In AutoEvony, connect bridge:
includeurl http://localhost:8089/bridge/connect
```

---

*Document Created: 2026-01-03*
*Target: Epic 2026 Release*
