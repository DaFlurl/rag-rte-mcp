# Svony Automation - Advanced Multi-Account Automation

## Overview

Enterprise-grade automation framework for Evony with:
- Multi-account swarm coordination
- Real-time exploit discovery
- AMF protocol manipulation  
- City and troop management
- Glitch/exploit automation

## Quick Start

```bash
# Install dependencies
pip install -r requirements.txt

# Run the main automation panel
python exploit_panel.py

# Or run specific modules:
python swarm_controller.py      # Multi-account coordination
python realtime_tester.py       # Live exploit testing
python troop_glitch_manager.py  # Troop overflow automation
```

## Modules

| Module | Purpose | Key Features |
|--------|---------|--------------|
| `swarm_controller.py` | Multi-account coordination | Borg-style attacks, resource pooling |
| `exploit_panel.py` | Main control panel | GUI for all exploits |
| `exploit_manager.py` | Exploit orchestration | Chain exploits, scheduling |
| `exploit_discovery.py` | Auto vulnerability scan | Pattern matching, fuzzing |
| `troop_glitch_manager.py` | Troop overflow | All 12 troop types |
| `city_manager.py` | City automation | Building, research, troops |
| `amf_commander.py` | Protocol manipulation | Packet creation, injection |
| `account_parser.py` | Account management | SOL parsing, credentials |
| `script_engine.py` | Script execution | AutoEvony script runner |
| `realtime_tester.py` | Live testing | Debug mode, packet capture |
| `realtime_debug.py` | Debug tools | Protocol analysis |

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                   EXPLOIT PANEL                          │
│              (Main Control Interface)                    │
└─────────────────────────────────────────────────────────┘
                          │
    ┌─────────────────────┼─────────────────────┐
    │                     │                     │
    ▼                     ▼                     ▼
┌───────────┐      ┌───────────┐      ┌───────────┐
│  Swarm    │      │  Exploit  │      │   City    │
│ Controller│      │  Manager  │      │  Manager  │
└───────────┘      └───────────┘      └───────────┘
    │                     │                     │
    └─────────────────────┼─────────────────────┘
                          │
                          ▼
              ┌───────────────────────┐
              │    AMF Commander      │
              │  (Protocol Layer)     │
              └───────────────────────┘
                          │
                          ▼
              ┌───────────────────────┐
              │   Account Parser      │
              │  (124 accounts)       │
              └───────────────────────┘
```

## Multi-Account Swarm

The swarm controller enables Borg-style coordination:

```python
from swarm_controller import SwarmController

swarm = SwarmController()
swarm.load_accounts()  # Load from SOL files

# Coordinate attack
swarm.coordinate_attack(
    target=(500, 500),
    accounts=['acc1', 'acc2', 'acc3'],
    troops={'archer': 50000, 'cavalry': 10000}
)

# Resource pooling
swarm.pool_resources(
    target_account='main',
    source_accounts=['alt1', 'alt2', 'alt3'],
    resource='food',
    amount=100_000_000
)
```

## Exploit Chains

```python
from exploit_manager import ExploitManager

mgr = ExploitManager()

# Run overflow chain
mgr.run_chain([
    ('troop_overflow', {'troop': 6, 'count': 6135037}),
    ('cancel_queue', {}),
    ('troop_overflow', {'troop': 7, 'count': 2684355}),
    ('cancel_queue', {}),
])

# Schedule recurring exploit
mgr.schedule_exploit(
    exploit='troop_overflow',
    interval_minutes=30,
    params={'troop': 6}
)
```

## Troop Overflow Reference

| Troop | ID | Cost | Threshold | Script |
|-------|------|------|-----------|--------|
| Worker | 1 | 50 | 42,949,673 | `train wo:42949673` |
| Warrior | 2 | 75 | 28,633,116 | `train wa:28633116` |
| Scout | 3 | 100 | 21,474,837 | `train sc:21474837` |
| Pikeman | 4 | 200 | 10,737,419 | `train pi:10737419` |
| Swordsman | 5 | 250 | 8,589,935 | `train sw:8589935` |
| **Archer** | 6 | 350 | **6,135,037** | `train a:6135037` |
| Cavalry | 7 | 800 | 2,684,355 | `train cav:2684355` |
| Cataphract | 8 | 1500 | 1,431,656 | `train cata:1431656` |
| Transporter | 9 | 300 | 7,158,279 | `train tr:7158279` |
| Ballista | 10 | 2000 | 1,073,742 | `train ba:1073742` |
| Ram | 11 | 2500 | 858,994 | `train r:858994` |
| Catapult | 12 | 3000 | 715,828 | `train c:715828` |

## AMF Protocol

```python
from amf_commander import AMFCommander

cmd = AMFCommander()

# Create packet
packet = cmd.create_packet(
    command='troop.produceTroop',
    params={'troopType': 6, 'num': 6135037}
)

# Send with signature
response = cmd.send_signed(packet)
```

## Real-Time Testing

```bash
# Start debug mode
python realtime_debug.py --verbose

# Capture packets
python realtime_tester.py --capture

# Replay attack
python realtime_tester.py --replay overflow_chain.json
```

## Configuration

Create `config.json`:

```json
{
    "accounts_path": "../sol_analysis/accounts_extracted.json",
    "scripts_path": "../Scripts",
    "server_url": "http://cc2.evony.com",
    "default_proxy": "127.0.0.1:9998",
    "safety_limits": {
        "max_food": 485000000,
        "max_troops": 700000000
    }
}
```

## Safety Features

- **Food Monitor**: Alerts when food > 400M
- **Overflow Protection**: Auto-cancel at limits
- **Account Rotation**: Distribute load
- **Rate Limiting**: Prevent detection
- **Auto-Backup**: Save before risky operations
