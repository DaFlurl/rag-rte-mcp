# BORG TOOLKIT

**Enterprise NSA-Grade Evony Exploitation Framework**

> Complete protocol knowledge • 301+ commands • Automated exploit discovery

---

## 🚀 Quick Start

### Option 1: Advanced Exploit Server (Recommended)
```bash
python advanced_server.py
```
Then in AutoEvony:
```
includeurl http://localhost:8088/epic/overflow_chain
```

### Option 2: Local Script Files
Copy scripts from `scripts/` to AutoEvony and load them.

---

## 🔥 EPIC EXPLOITS

### Advanced Server Endpoints
| Endpoint | Description |
|----------|-------------|
| `/epic/overflow_chain` | ALL troop types overflow - maximum gain |
| `/epic/infinite_resources` | Combined exploits for unlimited resources |
| `/epic/race_blitz` | 50 rapid item uses (race condition) |
| `/epic/full_auto` | Complete automation loop |
| `/epic/security_bypass` | Security code enumeration |
| `/api/CMD?params` | Raw command injection |
| `/calc/overflow?troop=6` | Calculate overflow values |

### Overflow Thresholds (All Troops)
| Troop | Cost | Threshold | Expected Gain |
|-------|------|-----------|---------------|
| Worker | 50 | 42,949,673 | ~2.1B food |
| Warrior | 75 | 28,633,116 | ~2.1B food |
| Scout | 100 | 21,474,837 | ~2.1B food |
| Pikeman | 200 | 10,737,419 | ~2.1B food |
| Swordsman | 250 | 8,589,935 | ~2.1B food |
| **Archer** | 350 | **6,135,037** | ~2.1B food |
| Cavalry | 800 | 2,684,355 | ~2.1B food |
| Cataphract | 1500 | 1,431,656 | ~2.1B food |
| Ballista | 2000 | 1,073,742 | ~2.1B food |

---

## 📁 Project Structure

```
BorgToolkit/
├── advanced_server.py       # EPIC exploit server
├── script_server.py         # Basic script server
├── src/
│   ├── protocol_commands.py # 301+ extracted commands
│   ├── exploit_engine.py    # Automated exploit discovery
│   ├── connection.py        # Live server connection
│   ├── injection.py         # Packet forging with keys
│   ├── exploits.py          # Exploit implementations
│   ├── cheats.py            # Cheat sequences
│   ├── bot_integration.py   # AutoEvony integration
│   └── client_wrapper.py    # evony_client wrapper
├── scripts/
│   ├── 01_troop_overflow.txt
│   ├── 02_valley_hide.txt
│   ├── 03_gold_farm.txt
│   └── discovery/
│       ├── ultimate_overflow_chain.txt
│       └── race_condition_blitz.txt
└── docs/
    ├── AUTOEVONY_INTEGRATION.md
    ├── EXPLOITS.md
    └── ACTION_PLAN.md
```

---

## 🔑 Extracted Encryption Keys

```python
ACTION_KEY = "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"
API_KEY = "9f758e2deccbe6244f734371b9642eda"
USER_INFO_KEY = "IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}"
XOR_KEY = 0xAA
LOGIN_SALT = "evony"
```

---

## 📡 Protocol Commands (301+)

Categories extracted from source:
- `troop.*` - Troop production, overflow exploits
- `shop.*` - Item use, purchases, race conditions
- `common.*` - Packages, rewards, security
- `army.*` - Army movement, cloning attempts
- `castle.*` - Building exploits
- `colony.*` - Colony farming
- `quest.*` - Quest reward enumeration
- `hero.*` - Hero stat manipulation
- And 20+ more categories...

---

## 🎯 Exploit Types

| Type | Description | Example |
|------|-------------|---------|
| **Integer Overflow** | num > INT32_MAX/cost | `train a:6135037` |
| **Negative Values** | Invert operations | `num=-1` |
| **Race Condition** | Rapid fire requests | 100 useitem calls |
| **Validation Bypass** | Boundary values | `rate=101` |
| **Enumeration** | Find hidden values | `ruleId=1-1000` |

---

## 📋 Requirements

```bash
pip install pyamf pysocks
# Or for Python 3.10+:
pip install Py3AMF pysocks
```

---

## 📚 Documentation

- `docs/AUTOEVONY_INTEGRATION.md` - Bot scripting guide
- `docs/EXPLOITS.md` - Detailed exploit documentation
- `docs/ACTION_PLAN.md` - Development roadmap
- `diagrams/architecture.md` - System architecture
