# Evony Food Glitch Mechanics - Complete Guide

## Overview

The Food Glitch is a 32-bit integer overflow exploit in Evony that allows massive food generation. This document explains the mechanics, thresholds, and management strategies.

---

## How Food Glitches Work

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        32-BIT INTEGER OVERFLOW                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│   Maximum 32-bit signed integer: 2,147,483,647 (INT32_MAX)                  │
│                                                                              │
│   When (troops × food_cost) exceeds INT32_MAX → OVERFLOW → GLITCH           │
│                                                                              │
│   Glitch Threshold = INT32_MAX ÷ food_cost + 1                              │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Glitch Thresholds by Troop Type

```
┌──────────────────┬───────────┬─────────────────┬─────────────────┐
│    Troop Type    │ Food/Hour │ City Threshold  │ Valley Threshold│
├──────────────────┼───────────┼─────────────────┼─────────────────┤
│ Workers (wo)     │     1     │  2,147,483,648  │  1,073,741,824  │
│ Warriors (w)     │     1     │  2,147,483,648  │  1,073,741,824  │
│ Scouts (s)       │     2     │  1,073,741,824  │    536,870,912  │
│ Pikemen (p)      │     3     │    715,827,883  │    357,913,941  │
│ Swordsmen (sw)   │     3     │    715,827,883  │    357,913,941  │
│ Archers (a)      │     4     │    536,870,912  │    268,435,456  │
│ Cavalry (c)      │     9     │    238,609,295  │    119,304,647  │
│ Cataphracts(cata)│    17     │    126,322,568  │     63,161,284  │
│ Transporters (t) │     5     │    429,496,730  │    214,748,365  │
│ Ballista (b)     │    25     │     85,899,346  │     42,949,673  │
│ Battering Ram (r)│    50     │     42,949,673  │     21,474,836  │
│ Catapults (cp)   │   125     │     17,179,870  │      8,589,935  │
└──────────────────┴───────────┴─────────────────┴─────────────────┘
```

---

## ODD vs EVEN Glitches

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         GLITCH PARITY RULE                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│   ┌─────────────────┐              ┌─────────────────┐                      │
│   │  ODD GLITCHES   │              │  EVEN GLITCHES  │                      │
│   │  (1, 3, 5, 7..) │              │  (2, 4, 6, 8..) │                      │
│   ├─────────────────┤              ├─────────────────┤                      │
│   │                 │              │                 │                      │
│   │  ✓ GENERATING   │              │  ✗ NOT          │                      │
│   │    FOOD!        │              │    GENERATING   │                      │
│   │                 │              │                 │                      │
│   │  +2,147,483,647 │              │  Normal food    │                      │
│   │  food per hour  │              │  consumption    │                      │
│   │  per troop type │              │                 │                      │
│   │                 │              │                 │                      │
│   └─────────────────┘              └─────────────────┘                      │
│                                                                              │
│   Formula: is_generating = (total_glitches % 2) == 1                        │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Glitch Calculation Flow

```
                              ┌──────────────────┐
                              │  Troop Count in  │
                              │      City        │
                              └────────┬─────────┘
                                       │
                                       ▼
                    ┌──────────────────────────────────┐
                    │  Divide by City Threshold        │
                    │  glitches = count ÷ threshold    │
                    │  remaining = count % threshold   │
                    └────────────────┬─────────────────┘
                                     │
                         ┌───────────┴───────────┐
                         ▼                       ▼
                 ┌───────────────┐       ┌───────────────┐
                 │ glitches > 0  │       │ glitches = 0  │
                 └───────┬───────┘       └───────┬───────┘
                         │                       │
              ┌──────────┴──────────┐            │
              ▼                     ▼            ▼
      ┌───────────────┐     ┌───────────────┐  ┌──────────────┐
      │ ODD glitches  │     │ EVEN glitches │  │ No glitches  │
      │ = GENERATING  │     │ = NOT GEN     │  │ Normal food  │
      │ ✓ +INT32_MAX  │     │ ✗ Fix needed! │  │ consumption  │
      └───────────────┘     └───────────────┘  └──────────────┘
```

---

## City vs Valley Glitches

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    CITY vs VALLEY GLITCH LOCATIONS                          │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│   CITY GLITCHES                       VALLEY GLITCHES                       │
│   ─────────────                       ───────────────                       │
│   • Troops IN the city                • Troops in valleys                   │
│   • Full threshold applies            • HALF threshold applies              │
│   • Easier to manage                  • Troops in reinforcements            │
│   • Can untrain directly              • Cannot untrain directly             │
│                                                                              │
│   ┌─────────────┐                     ┌─────────────┐                       │
│   │    CITY     │  ──reinforce──►     │   VALLEY    │                       │
│   │  Threshold  │                     │  Threshold  │                       │
│   │  = FULL     │  ◄──recall────      │  = HALF     │                       │
│   └─────────────┘                     └─────────────┘                       │
│                                                                              │
│   TOTAL GLITCHES = City Glitches + Valley Glitches                          │
│   (both count toward ODD/EVEN parity)                                       │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Example: Catapult Glitch Calculation

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  EXAMPLE: 1,958,219,180 Catapults in City                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Catapult threshold = 17,179,870                                            │
│                                                                              │
│  Calculation:                                                               │
│  ┌─────────────────────────────────────────────────────────────┐            │
│  │  1,958,219,180 ÷ 17,179,870 = 113 remainder 15,159,740     │            │
│  └─────────────────────────────────────────────────────────────┘            │
│                                                                              │
│  Result:                                                                    │
│  • Glitches: 114 (113 complete + 1 because remainder > 0 logic)             │
│  • Remaining: 15,159,740 toward next glitch                                 │
│  • 114 is EVEN → ✗ NOT GENERATING                                           │
│                                                                              │
│  To Fix (flip to ODD):                                                      │
│  • Untrain: 15,159,741 catapults                                            │
│  • Result: 113 glitches (ODD) → ✓ GENERATING                                │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Safe Limits

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           SAFETY THRESHOLDS                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│   DANGER ZONE: > 700,000,000 troops per type                                │
│   ──────────────────────────────────────────                                │
│   • Thunder Raid can 3x multiply troops                                     │
│   • 700M × 3 = 2.1B > INT32_MAX = NEGATIVE OVERFLOW                         │
│   • City becomes LOCKED (unusable)                                          │
│                                                                              │
│   ┌────────────────────────────────────────────────────────────┐            │
│   │  0          350M         700M        1.4B       2.1B       │            │
│   │  ├───────────┼────────────┼───────────┼──────────┤         │            │
│   │  │   SAFE    │   SAFE     │  CAUTION  │  DANGER  │         │            │
│   │  │           │            │ (no 3x)   │ (locked) │         │            │
│   │  └───────────┴────────────┴───────────┴──────────┘         │            │
│   └────────────────────────────────────────────────────────────┘            │
│                                                                              │
│   COMMISSION TRANSFER MAX: 2,000,000,000 per transfer                       │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Related Documents

- [MOVE_VS_UNTRAIN.md](MOVE_VS_UNTRAIN.md) - Decision logic for fixing glitches
- [SCRIPTS_REFERENCE.md](SCRIPTS_REFERENCE.md) - AutoEvony script documentation
- [MULTI_CITY_MANAGEMENT.md](MULTI_CITY_MANAGEMENT.md) - Coordinating across cities

---

*Document version 1.0 - Created for BorgToolkit*
