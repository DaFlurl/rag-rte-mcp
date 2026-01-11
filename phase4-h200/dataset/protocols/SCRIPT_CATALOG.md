# Advanced Attack Scripts Catalog v2.0

## Overview
- **Total Scripts**: 16
- **Status**: All UNTESTED (require real account validation)
- **Test Accounts Available**: 3 Borg accounts with troops

---

## Test Accounts Ready

| Email | Server | Archers | Status |
|-------|--------|---------|--------|
| toygarc@hotmail.com | cc2 | 60,000,000 | ✓ Ready |
| watsonj50@hotmail.com | cc2 | 40,000,000 | ✓ Ready |
| robcuaw2250@aol.com | cc2 | 7,000,000 | ✓ Ready |

---

## Script Categories

### 🎯 COMBAT SCRIPTS

#### 1. attack_master_v2.0.txt
**The King of Attack Scripts** - Ultimate configurable combat automation

| Feature | Options |
|---------|---------|
| Target | X,Y coordinates, type (player/npc) |
| Troops | Archers, warriors, cavalry, catapults, ballista |
| Heroes | Spam mode, specific hero, min attack stat |
| Attack Mode | spam, single, wave, rally |
| Run Mode | once, loop, timer, count |
| Features | Scout first, auto-recall, troop check, cooldown, safety limits |

```
// Quick Setup Example
set targetX 100
set targetY 200
set archerCount 50000
set waveCount 10
set attackMode "spam"
set runMode "loop"
```

---

#### 2. quick_spam_v2.0.txt
**Fast & Simple** - Copy/paste ready for rapid deployment

| Feature | Default |
|---------|---------|
| Waves | 10 |
| Archers | 50,000 |
| Delay | 2000ms |
| Scout First | Off |
| Loop Mode | Off |

```
// Minimal Config
set x 100
set y 200
set waves 10
set archers 50000
```

---

#### 3. coordinated_strike_v2.0.txt
**Multi-City Attack** - Synchronized strikes from multiple cities

| Feature | Options |
|---------|---------|
| Cities | Up to 5 cities |
| Total Waves | Configurable |
| Stagger Mode | simultaneous, timed |
| Pre-Scout | Enable/disable |
| Wave Balance | Auto-distribute across cities |

---

#### 4. defense_buster_v2.0.txt
**Heavy Assault** - Break through fortified targets

| Phase | Purpose |
|-------|---------|
| Phase 1 | Reconnaissance (scout waves) |
| Phase 2 | Fortification destruction (catapults) |
| Phase 3 | Main assault (archers) |
| Phase 4 | Cleanup operations |

---

#### 5. recall_glitch_attack_v2.0.txt
**Exploit Timing** - Rapid attacks using recall glitch

| Feature | Details |
|---------|---------|
| Glitch Item | player.trick.qlbx |
| Timing | 50ms precision |
| Method | Send → Recall → Resend |

⚠️ **Warning**: Timing-critical, may not work on all servers

---

### 🌾 FARMING SCRIPTS

#### 6. npc_spam_master_v2.0.txt
**NPC Farming** - Advanced NPC farming with full config

| Feature | Options |
|---------|---------|
| NPC Level | 1-10 |
| Search Radius | Configurable |
| Waves/NPC | Multiple |
| Hero Rotation | Auto-rotate through heroes |
| Smart Targeting | Avoid recent targets |

---

#### 7. smart_farm_v2.0.txt
**Intelligent Farming** - Optimized resource farming

| Mode | Target |
|------|--------|
| npc | NPC farming |
| valley | Valley capture |
| mixed | Both |

Features: March time optimization, loot value filtering, troop reserves

---

#### 8. valley_capture_v2.0.txt
**Valley Farming** - Automated valley capture

| Feature | Options |
|---------|---------|
| Level | 5-10 preferred |
| Type Filter | Forest, desert, flat, etc. |
| Max Captures | Per cycle limit |

---

### 🏰 CITY MANAGEMENT

#### 9. city_lifecycle_manager_v1.0.txt
**Full City Management** - From scratch to max

| Phase | Actions |
|-------|---------|
| Quests | Auto-complete |
| Building | Priority queue |
| Research | Path automation |
| Training | Troop production |
| Resources | Tax, levy, comfort |
| Heroes | Hire, assign mayor |

---

#### 10. multi_city_coordinator_v1.0.txt
**Cross-City Actions** - Coordinate all cities

| Feature | Actions |
|---------|---------|
| Per City | Quests, building, research, training, levy |
| Balance | Resource distribution |
| Sync | Coordinated attacks |

---

#### 11. scheduled_tasks_v1.0.txt
**Time-Based Automation** - Recurring tasks

| Task | Interval |
|------|----------|
| Levy | 15 minutes |
| Comfort | 60 minutes |
| Quests | 5 minutes |
| Resource Check | 10 minutes |

---

### 🛡️ DEFENSE & UTILITY

#### 12. defensive_auto_v1.0.txt
**Threat Response** - Automatic defense

| Feature | Action |
|---------|--------|
| Incoming Detection | Monitor attacks |
| Troop Hiding | Send to safe location |
| Resource Protection | Market/transfer |
| Gate Control | Auto-close |

---

#### 13. hero_optimizer_v1.0.txt
**Hero Management** - Optimization automation

| Phase | Action |
|-------|--------|
| Acquire | Hire high-stat heroes |
| Level | Use experience items |
| Optimize | Assign attribute points |
| Assign | Roles (mayor, attack, scout) |
| Fire | Remove weak heroes |

---

#### 14. account_warmup_v1.0.txt
**New Account Setup** - Progression automation

| Phase | Content |
|-------|---------|
| 1 | Tutorial quests |
| 2 | Basic buildings |
| 3 | Resource buildings |
| 4 | Military buildings |
| 5 | Hero acquisition |
| 6 | Expansion prep |

---

### ⚡ GLITCH SCRIPTS

#### 15. glitch_suite_v1.0.txt
**Glitch Automation** - Multiple exploits

| Glitch | Method |
|--------|--------|
| Food Flip | Production timing exploit |
| Troop Transfer | Instant movement |
| Commission Quest | Rapid quest farming |
| Resource Overflow | Bypass warehouse cap |

⚠️ **Timing Critical**: 50-500ms windows

---

## Configuration Reference

### Run Modes
| Mode | Description |
|------|-------------|
| `once` | Execute once and stop |
| `loop` | Continuous execution |
| `timer` | Run every X minutes |
| `count` | Run X times then stop |

### Troop Strings
| Code | Troop Type |
|------|------------|
| `a` | Archers |
| `w` | Warriors |
| `s` | Scouts |
| `p` | Pikemen/Catapults |
| `c` | Cavalry |
| `b` | Ballista |
| `t` | Transporters |

Example: `a50000w10000` = 50k archers + 10k warriors

### Common Features
| Feature | Purpose |
|---------|---------|
| `enableScoutFirst` | Scout before attacking |
| `enableTroopCheck` | Verify troops available |
| `enableCooldown` | Wait between cycles |
| `enableLogging` | Output status messages |
| `enableSafetyStop` | Prevent runaway scripts |

---

## Testing Protocol

### Before Testing
1. Verify account has troops (use test framework)
2. Set target coordinates to safe NPC/valley
3. Set conservative wave counts first
4. Enable all logging

### Test Process
1. Load script in AE2/RoboEvony
2. Run script
3. Monitor output
4. Check for errors
5. Record result

### After Testing
```python
# In Python:
from script_test_framework import record_test_result
record_test_result('script_name.txt', 'account_email', 'PASSED')
```

---

## Script Status

| Script | Status | Tested By | Date |
|--------|--------|-----------|------|
| attack_master_v2.0.txt | ❌ UNTESTED | - | - |
| quick_spam_v2.0.txt | ❌ UNTESTED | - | - |
| coordinated_strike_v2.0.txt | ❌ UNTESTED | - | - |
| defense_buster_v2.0.txt | ❌ UNTESTED | - | - |
| recall_glitch_attack_v2.0.txt | ❌ UNTESTED | - | - |
| npc_spam_master_v2.0.txt | ❌ UNTESTED | - | - |
| smart_farm_v2.0.txt | ❌ UNTESTED | - | - |
| valley_capture_v2.0.txt | ❌ UNTESTED | - | - |
| city_lifecycle_manager_v1.0.txt | ❌ UNTESTED | - | - |
| multi_city_coordinator_v1.0.txt | ❌ UNTESTED | - | - |
| scheduled_tasks_v1.0.txt | ❌ UNTESTED | - | - |
| defensive_auto_v1.0.txt | ❌ UNTESTED | - | - |
| hero_optimizer_v1.0.txt | ❌ UNTESTED | - | - |
| account_warmup_v1.0.txt | ❌ UNTESTED | - | - |
| glitch_suite_v1.0.txt | ❌ UNTESTED | - | - |
| npc_farmer_v1.0.txt | ❌ UNTESTED | - | - |

---

## Files Location

```
D:\EvonyToolKit\scripts\v2_new\
├── attack_master_v2.0.txt          # King of attack scripts
├── quick_spam_v2.0.txt             # Fast simple spam
├── coordinated_strike_v2.0.txt     # Multi-city attack
├── defense_buster_v2.0.txt         # Heavy assault
├── recall_glitch_attack_v2.0.txt   # Recall exploit
├── npc_spam_master_v2.0.txt        # NPC farming
├── smart_farm_v2.0.txt             # Intelligent farming
├── valley_capture_v2.0.txt         # Valley farming
├── city_lifecycle_manager_v1.0.txt # City management
├── multi_city_coordinator_v1.0.txt # Cross-city
├── scheduled_tasks_v1.0.txt        # Timed tasks
├── defensive_auto_v1.0.txt         # Defense
├── hero_optimizer_v1.0.txt         # Hero management
├── account_warmup_v1.0.txt         # New account
├── glitch_suite_v1.0.txt           # Glitch exploits
├── npc_farmer_v1.0.txt             # Basic NPC farm
└── SCRIPT_CATALOG.md               # This file
```

---

*All scripts require real account testing before considered working*
