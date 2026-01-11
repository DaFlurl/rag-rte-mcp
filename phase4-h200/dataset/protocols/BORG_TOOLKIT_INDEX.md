# 🤖 BORG TOOLKIT - Complete Evony RE Framework

> **Generated**: 2026-01-03
> **Source**: EvonyClient1921.swf (Flash 9/10, 2009-2018 era)
> **Status**: OPERATIONAL

---

## 📊 TOOLKIT SUMMARY

| Component | Count | Description |
|-----------|-------|-------------|
| **Protocol Commands** | 168 | Complete game command API |
| **Data Beans** | 78 | All game data structures |
| **Critical Exploits** | 8 | High-risk vulnerability vectors |
| **Flash CVEs** | 5 | Applicable Flash vulnerabilities |
| **Glitch Thresholds** | 12 | Troop overflow calculations |
| **Docs Imported** | 70 | From D:\Svony_Studio |

---

## 🔥 CRITICAL EXPLOITS

### 1. TROOP GLITCH (Integer Overflow)
```
Command: troop.produceTroop
Risk: CRITICAL
Mechanism: Integer overflow in 'num' parameter
Thresholds:
  - Archer: 6,135,036
  - Cavalry: 2,684,354
  - Cataphract: 1,431,655
  - Catapult: 357,913
```

### 2. QUEST RACE CONDITION
```
Command: quest.award
Risk: HIGH
Mechanism: Complete quest multiple times via race condition
Technique: Send simultaneous packets
```

### 3. ITEM USE RACE CONDITION
```
Command: shop.useItem
Risk: HIGH
Mechanism: Use item multiple times before validation
```

### 4. NEGATIVE VALUE INJECTION
```
Commands: shop.buy, shop.sellItem, troop.disbandTroop
Risk: HIGH
Mechanism: Negative num = reverse operation (buy->sell, cost->refund)
```

---

## 🔑 ENCRYPTION KEYS

```python
ACTION_KEY = "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"
API_KEY = "9f758e2deccbe6244f734371b9642eda"
USER_INFO_KEY = "IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}"
XOR_KEY = 0xAA
```

---

## 📁 TOOLKIT STRUCTURE

```
evony_hub/
├── __init__.py              # Package init
├── config.py                # Configuration & categories
├── borg_toolkit.py          # Main toolkit (168 commands, exploits)
├── exploit_discovery.py     # Source code analyzer
├── glitch_calculator.py     # Overflow calculations
├── protocol_exploiter.py    # Packet manipulation
├── indexer.py               # Auto-indexing system
├── organizer.py             # Auto-organization
├── watcher.py               # File monitoring
├── scanner.py               # External drive scanner
├── run_borg.py              # Interactive launcher
└── reports/                 # Generated reports
```

---

## 🎮 PROTOCOL COMMAND CATEGORIES

| Category | Commands | High Risk |
|----------|----------|-----------|
| troop | 7 | produceTroop, cancelTroopProduce, disbandTroop |
| army | 14 | newArmy, callBackArmy |
| common | 34 | - |
| quest | 3 | award |
| shop | 7 | buy, useItem, sellItem |
| hero | 15 | awardHero |
| castle | 9 | - |
| city | 7 | construct |
| colony | 11 | levyFood, levyArmy |
| alliance | 8 | - |
| trade | 6 | createTrade |
| tech | 4 | - |
| fortifications | 5 | produceFortification |
| interior | 4 | - |
| mail | 4 | - |
| report | 3 | - |
| commissionQuest | 4 | completeCommissionQuest |
| gamblingRanking | 3 | gamble |
| security | 4 | - |
| field | 2 | - |
| equipment | 5 | - |
| npcHero | 3 | - |
| truce | 3 | - |
| furlough | 2 | - |

---

## 🐛 FLASH CVE DATABASE

| CVE | Name | Relevance |
|-----|------|-----------|
| CVE-2009-1869 | AVM2 Integer Overflow | HIGH |
| CVE-2010-1297 | newfunction Overflow | HIGH |
| CVE-2011-0611 | Memory Corruption | MEDIUM |
| CVE-2012-0779 | Type Confusion | MEDIUM |
| CVE-2015-0311 | Use-After-Free | LOW |

---

## 🧮 TROOP GLITCH THRESHOLDS

| Troop | Threshold | Food Cost | Overflow At |
|-------|-----------|-----------|-------------|
| Worker | 42,949,672 | 50 | 2,147,483,600 |
| Warrior | 21,474,836 | 100 | 2,147,483,600 |
| Scout | 10,737,418 | 200 | 2,147,483,600 |
| Pikeman | 4,294,967 | 500 | 2,147,483,500 |
| Swordsman | 2,147,483 | 1000 | 2,147,483,000 |
| **Archer** | **6,135,036** | 350 | 2,147,262,600 |
| Cavalry | 2,684,354 | 800 | 2,147,483,200 |
| Cataphract | 1,431,655 | 1500 | 2,147,482,500 |
| Transporter | 4,294,967 | 500 | 2,147,483,500 |
| Ballista | 858,993 | 2500 | 2,147,482,500 |
| Ram | 536,870 | 4000 | 2,147,480,000 |
| Catapult | 357,913 | 6000 | 2,147,478,000 |

---

## 🚀 QUICK START

```python
# Run interactive toolkit
python evony_hub/run_borg.py

# Or use programmatically
from evony_hub.borg_toolkit import BorgToolkit

toolkit = BorgToolkit()

# Get critical exploits
exploits = toolkit.get_critical_exploits()

# Calculate glitch
result = toolkit.calculate_overflow('archer', 6135037)
print(f"Gain on cancel: {result['gain_on_cancel']:,} food")

# Generate signature
sig = toolkit.generate_signature("my_data", "API_KEY")
```

---

## 📚 DOCUMENTATION (70 files from D:\Svony_Studio)

Located in: `Docs/svony_docs/`

Key documents:
- `ADVANCED_RE_FRAMEWORK.md` - RE methodology
- `AI_AUTOMATION_MASTER_PLAN.md` - Automation strategies
- `BOT_INTEGRATION_SPEC.md` - Bot integration guide
- `DEVELOPMENT_ROADMAP.md` - Project roadmap
- `FFDEC_GAP_ANALYSIS.md` - Decompiler analysis
- `MASTER_RESOURCE_INDEX.md` - Resource index
- `REALTIME_RE_VISION.md` - Real-time RE tools
- `ROBOEVONY_FEATURE_ANALYSIS.md` - RoboEvony analysis
- `TOOL_IMPLEMENTATION_SPEC.md` - Tool specs

---

## 🔄 AUTO-ORGANIZATION SYSTEM

Drop files in `data/` folder for automatic categorization:

```
data/           <- DROP FILES HERE
  ↓ Auto-organized to:
Scripts/        <- .txt bot scripts
Tools/          <- .py, .ps1, .exe tools
Docs/           <- .md, .docx documentation
Source/         <- .as, .swf source code
Exploits/       <- Exploit-related files
Accounts/       <- .sol, credential files
Diagrams/       <- .svg, .png visuals
Keys/           <- Encryption keys
Data/           <- .json, .xml data files
```

---

## ⚡ EXPLOITATION WORKFLOW

1. **Identify Target**: Choose command from registry
2. **Calculate Parameters**: Use glitch calculator for overflow values
3. **Forge Packet**: Use protocol_exploiter to create AMF packet
4. **Test**: Send to server (use proxy for interception)
5. **Analyze Response**: Check for successful exploitation

---

*Resistance is futile. The Borg Toolkit assimilates all Evony knowledge.*
