# Evony Food Glitch Documentation

## Overview

Complete documentation for managing Food Glitches in Evony using AutoEvony scripts.

---

## Quick Start

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         QUICK START GUIDE                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│   1. Run FoodGlitchCounterV1.2.txt in your city                             │
│   2. Look for "Food Generation: false!" messages (EVEN glitches)            │
│   3. Check the "remaining" amount:                                          │
│      • < 1M  → UNTRAIN that amount + 1                                      │
│      • ≥ 1M  → MOVE to nearest safe city                                    │
│   4. Re-run script to verify fix                                            │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Documentation Index

| Document | Description |
|----------|-------------|
| [GLITCH_MECHANICS.md](GLITCH_MECHANICS.md) | Core mechanics: thresholds, ODD/EVEN rules, overflow |
| [MOVE_VS_UNTRAIN.md](MOVE_VS_UNTRAIN.md) | **Decision guide**: when to move vs untrain troops |
| [SCRIPTS_REFERENCE.md](SCRIPTS_REFERENCE.md) | Script documentation and command reference |
| [MULTI_CITY_MANAGEMENT.md](MULTI_CITY_MANAGEMENT.md) | Coordinating glitches across multiple cities |

---

## Scripts Location

All scripts are in `evony_scripts/` folder:

```
evony_scripts/
├── FoodGlitchCounterV1.2.txt    # Original Ogliss script
├── GlitchManager_MultiCity.txt  # Scan all cities
├── GlitchOptimizer_AutoFix.txt  # Auto-calculate fixes
├── SafeTroopMover_v1.txt        # Safe movement calculator
└── Troop_&_RSS_Counter.txt      # Count troops/resources
```

---

## Key Rule: Move vs Untrain

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                              │
│   Amount to fix < 1,000,000   →   UNTRAIN (quick, small loss)               │
│                                                                              │
│   Amount to fix ≥ 1,000,000   →   MOVE (preserve troops)                    │
│                                                                              │
│   MOVING IS ALWAYS RECOMMENDED WHEN IN THE MILLIONS!                        │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Glitch Thresholds Quick Reference

| Troop | Abbr | Food | City Threshold | Valley Threshold |
|-------|------|------|----------------|------------------|
| Workers | wo | 1 | 2,147,483,648 | 1,073,741,824 |
| Warriors | w | 1 | 2,147,483,648 | 1,073,741,824 |
| Scouts | s | 2 | 1,073,741,824 | 536,870,912 |
| Pikemen | p | 3 | 715,827,883 | 357,913,941 |
| Swordsmen | sw | 3 | 715,827,883 | 357,913,941 |
| Archers | a | 4 | 536,870,912 | 268,435,456 |
| Cavalry | c | 9 | 238,609,295 | 119,304,647 |
| Cataphracts | cata | 17 | 126,322,568 | 63,161,284 |
| Transporters | t | 5 | 429,496,730 | 214,748,365 |
| Ballista | b | 25 | 85,899,346 | 42,949,673 |
| Battering Ram | r | 50 | 42,949,673 | 21,474,836 |
| **Catapults** | **cp** | **125** | **17,179,870** | **8,589,935** |

---

## Visual Decision Tree

```
                    ┌─────────────────────┐
                    │  EVEN GLITCHES?     │
                    │  (Not Generating)   │
                    └──────────┬──────────┘
                               │
                    ┌──────────┴──────────┐
                    │  remaining + 1 =    │
                    │  fix_amount         │
                    └──────────┬──────────┘
                               │
              ┌────────────────┼────────────────┐
              │                │                │
              ▼                ▼                ▼
       ┌────────────┐   ┌────────────┐   ┌────────────┐
       │  < 100K    │   │ 100K - 1M  │   │   ≥ 1M     │
       │            │   │            │   │            │
       │  UNTRAIN   │   │  EITHER    │   │   MOVE     │
       │  Always    │   │  OK        │   │  Always    │
       └────────────┘   └────────────┘   └─────┬──────┘
                                               │
                               ┌───────────────┴───────────────┐
                               │                               │
                               ▼                               ▼
                        ┌────────────┐                  ┌────────────┐
                        │ To city    │                  │ To valley  │
                        │ 0 glitch   │                  │ (backup)   │
                        │ BEST       │                  │            │
                        └────────────┘                  └────────────┘
```

---

## Command Examples

```bash
# UNTRAIN (small amounts)
untrain cp:15159741
untrain r:4399943

# MOVE TO CITY (large amounts, preserves troops)
reinforce CityName none cp:17179870
deploy reinforce 363,627 none r:42949673

# MOVE TO VALLEY (temporary overflow)
reinforce 100,200 none cp:8589935
```

---

*Documentation version 1.0 - BorgToolkit*
