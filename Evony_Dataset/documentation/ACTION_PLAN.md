# BORG TOOLKIT - Action Plan & Tools Needed

> **Status**: IN DEVELOPMENT
> **Priority**: Build working exploits first, then automation

---

## 🎯 OBJECTIVE

Build a comprehensive Evony exploitation framework that provides:
1. **Working cheats** for resources, troops, items
2. **Live networking** for packet capture and injection
3. **Automated tools** for hands-free farming and exploitation

---

## 📋 TOOLS NEEDED (Priority Order)

### Phase 1: Core Infrastructure (CRITICAL)

| Tool | Purpose | Status | Dependencies |
|------|---------|--------|--------------|
| **AMF Protocol Handler** | Encode/decode Evony packets | ✅ BUILT | pyamf |
| **Server Connection** | Connect to Evony servers | ✅ BUILT | socket, pyamf |
| **Packet Logger** | Capture all traffic | ✅ BUILT | - |
| **Signature Generator** | Generate valid packet signatures | ✅ BUILT | hashlib |

### Phase 2: Exploit Tools (HIGH PRIORITY)

| Tool | Purpose | Status | Dependencies |
|------|---------|--------|--------------|
| **Overflow Calculator** | Calculate exploit thresholds | ✅ BUILT | - |
| **Packet Forger** | Create exploit packets | ✅ BUILT | - |
| **Race Condition Engine** | Parallel packet injection | ✅ BUILT | threading |
| **Troop Glitch Executor** | Run food glitch | ✅ BUILT | connection |
| **Item Duplicator** | Duplicate items | ✅ BUILT | connection |

### Phase 3: Automation Tools (MEDIUM PRIORITY)

| Tool | Purpose | Status | Dependencies |
|------|---------|--------|--------------|
| **Cheat Sequencer** | Chain multiple exploits | ✅ BUILT | - |
| **Auto-Farmer** | Automated resource farming | 🔄 PLANNED | connection |
| **Valley Manager** | Troop hiding automation | 🔄 PLANNED | connection |
| **Quest Bot** | Auto-complete quests | 🔄 PLANNED | connection |
| **Multi-Account Manager** | Manage multiple accounts | ✅ BUILT | - |

### Phase 4: Analysis Tools (LOWER PRIORITY)

| Tool | Purpose | Status | Dependencies |
|------|---------|--------|--------------|
| **Traffic Analyzer** | Analyze captured packets | 🔄 PLANNED | - |
| **Drop Rate Tracker** | Track amulet/chest drops | 🔄 PLANNED | - |
| **Exploit Validator** | Test which exploits work | 🔄 PLANNED | connection |
| **Server Version Detector** | Detect patched servers | 🔄 PLANNED | - |

---

## 🔧 WHAT'S MISSING (From User's Resources)

### Already Have (From Source Analysis)
- ✅ Complete protocol commands (168 commands)
- ✅ All encryption keys
- ✅ Troop costs and overflow thresholds
- ✅ Item IDs and definitions
- ✅ Server communication protocol

### Need to Build
- ❌ **Live packet sniffer** (requires scapy + admin)
- ❌ **Proxy server** for traffic interception
- ❌ **GUI interface** for easy operation
- ❌ **Server emulator** for testing

### External Dependencies
```bash
# Required packages
pip install pyamf          # AMF protocol encoding
pip install pysocks        # SOCKS proxy support
pip install scapy          # Packet capture (optional)
pip install colorama       # Colored output
```

---

## 🚀 WORKING EXPLOITS (From Source Analysis)

### 1. TROOP GLITCH (Food Overflow) - KNOWN WORKING
```
Target: troop.produceTroop command
Attack: Queue troops above INT32_MAX / cost threshold
Result: Cost calculation overflows to negative
Cancel: Receive "refund" of negative = GAIN resources

Thresholds (INT32_MAX / food_cost):
- Archer: 6,135,036 troops → ~2.1B food gain
- Cavalry: 2,684,354 troops
- Cataphract: 1,431,655 troops

Status: Works on unpatched servers (pre-2012)
```

### 2. VALLEY HIDING (Food Bypass) - ALWAYS WORKS
```
Target: Troop upkeep calculation
Attack: Send troops to valleys
Result: Troops don't consume food while marching/stationed

Method:
1. Find distant empty valley
2. Send troops with hero
3. Troops stay indefinitely
4. Recall when needed

Status: WORKING - Game mechanic, not exploit
```

### 3. RACE CONDITION DUPLICATION - VARIABLE
```
Target: Item/quest reward validation
Attack: Send many simultaneous packets
Result: May process multiple before decrementing

Targets:
- shop.useGoods (items)
- quest.award (quest rewards)
- commissionQuest.completeCommissionQuest

Status: Effectiveness varies by server load
```

### 4. NEGATIVE VALUE INJECTION - THEORETICAL
```
Target: Commands accepting numeric values
Attack: Send negative numbers
Result: Reverse operation (buy becomes sell, etc.)

Targets:
- shop.buy (num=-1 = free items?)
- shop.sellItem (num=-1 = buy items?)
- troop.disbandTroop (num=-1 = gain troops?)

Status: Most likely patched, requires testing
```

---

## 📊 DATA EXTRACTION NEEDS

### From Client Source (HAVE)
- [x] Protocol commands and parameters
- [x] Data bean structures
- [x] Error codes
- [x] Encryption keys
- [x] Item definitions

### From Live Server (NEED)
- [ ] Current protocol version
- [ ] Server-side validation rules
- [ ] Patched exploit detection
- [ ] Rate limiting thresholds

### From Packet Capture (NEED)
- [ ] Login handshake sequence
- [ ] Session token format
- [ ] Command response format
- [ ] Error handling patterns

---

## 🛠️ BUILD ORDER

### Immediate (This Session)
1. ✅ Create folder structure
2. ✅ Build connection module
3. ✅ Build injection module
4. ✅ Build exploits module
5. ✅ Build cheats module
6. 🔄 Create documentation
7. 🔄 Create main launcher

### Next Session
1. Build GUI interface
2. Add packet capture
3. Add traffic analysis
4. Test on live server
5. Document working exploits

### Future
1. Server emulator for testing
2. ML-based drop prediction
3. Multi-server support
4. Bot integration

---

## ⚠️ IMPORTANT NOTES

### Legal Disclaimer
This toolkit is for **educational and research purposes only**.
Using exploits on live servers may violate Terms of Service.

### Server Detection
Servers may detect:
- Unusual packet patterns
- Too-fast request rates
- Known exploit signatures
- Multiple simultaneous connections

### Mitigation
- Use proxies/VPNs
- Add random delays
- Vary request patterns
- Limit exploit frequency

---

## 📁 FILE STRUCTURE

```
BorgToolkit/
├── src/
│   ├── __init__.py         # Package init
│   ├── connection.py       # Server connection
│   ├── injection.py        # Packet injection
│   ├── exploits.py         # Working exploits
│   ├── cheats.py          # Automated cheats
│   ├── protocol.py        # Protocol definitions
│   └── crypto.py          # Encryption utilities
├── docs/
│   ├── ACTION_PLAN.md     # This file
│   ├── EXPLOITS.md        # Exploit documentation
│   ├── PROTOCOL.md        # Protocol reference
│   └── SETUP.md           # Setup instructions
├── diagrams/
│   ├── architecture.svg   # System architecture
│   ├── exploit_flow.svg   # Exploit execution flow
│   └── protocol.svg       # Protocol diagram
├── exploits/
│   ├── food_glitch.py     # Food overflow exploit
│   ├── item_dupe.py       # Item duplication
│   └── race_condition.py  # Race condition tools
├── network/
│   ├── sniffer.py         # Packet capture
│   └── proxy.py           # MITM proxy
├── cheats/
│   ├── auto_farm.py       # Auto farming
│   └── sequences/         # Cheat sequences
└── run_borg.py            # Main launcher
```

---

*Last Updated: 2026-01-03*
*Borg Collective - Resistance is Futile*
