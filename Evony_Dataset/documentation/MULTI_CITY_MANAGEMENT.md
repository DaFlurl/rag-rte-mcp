# Multi-City Glitch Management Guide

## Overview

Managing food glitches across multiple cities requires coordination to:
- Fix EVEN glitches without losing troops
- Move overflow to safe destinations
- Maintain ODD glitches across all cities
- Maximize food generation account-wide

---

## Multi-City Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       ACCOUNT CITY STRUCTURE                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│                            ┌───────────────┐                                │
│                            │   ATLANTIS    │                                │
│                            │  (Capital)    │                                │
│                            │  High glitch  │                                │
│                            └───────┬───────┘                                │
│                                    │                                        │
│            ┌───────────────────────┼───────────────────────┐                │
│            │                       │                       │                │
│            ▼                       ▼                       ▼                │
│     ┌───────────┐          ┌───────────┐          ┌───────────┐            │
│     │  City 2   │          │  City 3   │          │  City 4   │            │
│     │  Storage  │◄────────►│  Active   │◄────────►│  Overflow │            │
│     │  (0 glit) │          │  Glitch   │          │  Storage  │            │
│     └───────────┘          └───────────┘          └───────────┘            │
│            │                       │                       │                │
│            └───────────────────────┼───────────────────────┘                │
│                                    │                                        │
│                            ┌───────┴───────┐                                │
│                            │   VALLEYS     │                                │
│                            │  (Temp Store) │                                │
│                            │  Half thresh  │                                │
│                            └───────────────┘                                │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## City Roles Strategy

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         CITY ROLE ASSIGNMENTS                                │
├────────────────┬────────────────────────────────────────────────────────────┤
│  Role          │  Description                                               │
├────────────────┼────────────────────────────────────────────────────────────┤
│  GLITCH CITY   │  Main glitch production city                               │
│                │  • High troop counts (100M+ per type)                      │
│                │  • Multiple glitches per troop type                        │
│                │  • Target: ODD glitches on all high-value troops           │
│                │  • Focus: Mechs, Horses, Archers                           │
├────────────────┼────────────────────────────────────────────────────────────┤
│  STORAGE CITY  │  Overflow destination                                      │
│                │  • Low or zero glitches                                    │
│                │  • Can receive any amount safely                           │
│                │  • Acts as buffer for glitch management                    │
├────────────────┼────────────────────────────────────────────────────────────┤
│  TRAINING CITY │  Troop production                                          │
│                │  • Barracks for training                                   │
│                │  • Sends new troops to glitch cities                       │
│                │  • Keeps minimal troops locally                            │
├────────────────┼────────────────────────────────────────────────────────────┤
│  VALLEY BANK   │  Temporary storage in valleys                              │
│                │  • Uses half-threshold for glitches                        │
│                │  • Good for overflow when no city available                │
│                │  • Counts toward total glitch parity                       │
└────────────────┴────────────────────────────────────────────────────────────┘
```

---

## Coordination Workflow

```
┌──────────────────────────────────────────────────────────────────────────────┐
│                    MULTI-CITY GLITCH FIX WORKFLOW                            │
└──────────────────────────────────────────────────────────────────────────────┘

STEP 1: SCAN ALL CITIES
════════════════════════
┌─────────────────┐
│ Run MultiCity   │
│ Glitch Manager  │
│ (any city)      │
└────────┬────────┘
         │
         ▼
┌─────────────────────────────────────────────────────────────────┐
│  OUTPUT:                                                        │
│  • List of EVEN glitches per city                               │
│  • Safe destination cities (0 glitches)                         │
│  • Untrain amounts for each problem                             │
└─────────────────────────────────────────────────────────────────┘


STEP 2: PRIORITIZE FIXES
════════════════════════
┌─────────────────┐
│ Identify high-  │
│ value EVEN      │
│ glitches        │
└────────┬────────┘
         │
         ▼
┌─────────────────────────────────────────────────────────────────┐
│  PRIORITY ORDER:                                                │
│  1. Catapults (cp)      - 125 food/troop - highest impact       │
│  2. Battering Rams (r)  - 50 food/troop                         │
│  3. Ballista (b)        - 25 food/troop                         │
│  4. Cataphracts (cata)  - 17 food/troop                         │
│  5. Cavalry (c)         - 9 food/troop                          │
│  6. Archers (a)         - 4 food/troop                          │
└─────────────────────────────────────────────────────────────────┘


STEP 3: CHOOSE ACTION
═════════════════════
                    ┌────────────────────┐
                    │ Amount to remove   │
                    │ = remaining + 1    │
                    └──────────┬─────────┘
                               │
               ┌───────────────┴───────────────┐
               ▼                               ▼
      ┌────────────────┐              ┌────────────────┐
      │  < 1,000,000   │              │  ≥ 1,000,000   │
      │  (under 1M)    │              │  (1M or more)  │
      └───────┬────────┘              └───────┬────────┘
              │                               │
              ▼                               ▼
      ┌────────────────┐              ┌────────────────┐
      │    UNTRAIN     │              │     MOVE       │
      │                │              │                │
      │ Quick & simple │              │ Preserve       │
      │ Small loss     │              │ troops         │
      └────────────────┘              └───────┬────────┘
                                              │
                              ┌───────────────┴───────────────┐
                              ▼                               ▼
                     ┌────────────────┐              ┌────────────────┐
                     │ CLOSEST CITY   │              │    VALLEY      │
                     │ with 0 glitch  │              │ (if no safe    │
                     │ of this type   │              │  city)         │
                     └────────────────┘              └────────────────┘


STEP 4: EXECUTE & VERIFY
════════════════════════
┌─────────────────┐
│ Execute action  │
│ (untrain/move)  │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Re-run Glitch   │
│ Counter         │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Verify ODD      │
│ glitches now    │
└─────────────────┘
```

---

## Move to Closest City Logic

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    CLOSEST CITY SELECTION                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│   CRITERIA (in order of preference):                                         │
│                                                                              │
│   1. DISTANCE                                                               │
│      • Closer cities = faster troop arrival                                 │
│      • Less time troops are "in transit" (vulnerable)                       │
│                                                                              │
│   2. GLITCH STATE                                                           │
│      • Prefer cities with 0 glitches of target troop type                   │
│      • Second choice: cities with ODD glitches (send multiples)             │
│      • Avoid: cities with EVEN glitches (would make worse)                  │
│                                                                              │
│   3. CAPACITY                                                               │
│      • Check space to next glitch threshold                                 │
│      • Ensure receiving won't break destination's glitches                  │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘

                      SOURCE CITY
                      (EVEN glitch)
                           │
                           │ Troops to move
                           ▼
         ┌─────────────────────────────────────┐
         │         FIND CLOSEST SAFE           │
         └─────────────────────────────────────┘
                           │
         ┌─────────────────┼─────────────────┐
         │                 │                 │
         ▼                 ▼                 ▼
   ┌───────────┐    ┌───────────┐    ┌───────────┐
   │  City A   │    │  City B   │    │  City C   │
   │  50 miles │    │  100 miles│    │  200 miles│
   │  0 glitch │    │  3 glitch │    │  0 glitch │
   │   ✓ BEST  │    │  (ODD ok) │    │  (backup) │
   └───────────┘    └───────────┘    └───────────┘
```

---

## Safe Send Amount Calculator

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    SAFE SEND CALCULATIONS                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│   SCENARIO 1: Destination has 0 glitches                                    │
│   ─────────────────────────────────────────                                 │
│   • Send ANY amount - completely safe                                       │
│   • Will create new glitches in destination                                 │
│   • Check if result will be ODD (generating) there too                      │
│                                                                              │
│   SCENARIO 2: Destination has ODD glitches (generating)                     │
│   ─────────────────────────────────────────────────────                     │
│   • Send EXACT MULTIPLES of threshold                                       │
│   • Each multiple adds EVEN glitches (2 per 2x threshold)                   │
│   • Preserves ODD state in destination                                      │
│                                                                              │
│   SCENARIO 3: Destination has EVEN glitches (not generating)                │
│   ─────────────────────────────────────────────────────────                 │
│   • Calculate: space_to_next = threshold - remaining                        │
│   • Send exactly that amount to ADD one glitch (make ODD)                   │
│   • Helps fix destination AND moves your overflow!                          │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Example Calculation

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  EXAMPLE: Moving Catapults                                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  SOURCE CITY (your city):                                                   │
│  • Catapults: 1,958,219,180                                                 │
│  • Glitches: 114 (EVEN - not generating)                                    │
│  • Remaining: 15,159,740                                                    │
│  • Need to remove: 15,159,741 to flip to 113 (ODD)                          │
│                                                                              │
│  DESTINATION OPTIONS:                                                       │
│                                                                              │
│  Option A - City with 0 catapult glitches:                                  │
│  ┌─────────────────────────────────────────────────────────────┐            │
│  │  Send: 15,159,741 catapults                                 │            │
│  │  Result (source): 113 glitches (ODD) ✓ GENERATING           │            │
│  │  Result (dest): 0 glitches still (under threshold)          │            │
│  └─────────────────────────────────────────────────────────────┘            │
│                                                                              │
│  Option B - City with 3 catapult glitches (ODD):                            │
│  ┌─────────────────────────────────────────────────────────────┐            │
│  │  Send: 17,179,870 (1× threshold) - includes your 15.1M     │            │
│  │  Result (source): 113 glitches (ODD) ✓ GENERATING           │            │
│  │  Result (dest): 4 glitches (EVEN) ✗ BROKEN!                │            │
│  │  BETTER: Send 34,359,740 (2× threshold)                     │            │
│  │  Result (dest): 5 glitches (ODD) ✓ STILL GENERATING         │            │
│  └─────────────────────────────────────────────────────────────┘            │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Coordinated Fix Commands

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    COMMAND SEQUENCE EXAMPLE                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│   SITUATION: Main city has multiple EVEN glitches                           │
│                                                                              │
│   STEP 1: From main city, move overflow to storage city                     │
│   ─────────────────────────────────────────────────────                     │
│   reinforce StorageCity none cp:15159741                                    │
│   reinforce StorageCity none r:4399943                                      │
│                                                                              │
│   STEP 2: Small amounts - just untrain                                      │
│   ─────────────────────────────────────────────────────                     │
│   untrain b:85900       // Ballista < 1M, just untrain                      │
│                                                                              │
│   STEP 3: Verify fixes                                                      │
│   ─────────────────────────────────────────────────────                     │
│   // Run FoodGlitchCounterV1.2 script                                       │
│   // All troops should now show "Food Generation: true!"                    │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Account-Wide Optimization

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    MAXIMIZE FOOD GENERATION                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│   GOAL: Get ODD glitches on ALL high-value troop types in ALL cities        │
│                                                                              │
│   Each ODD glitch = +2,147,483,647 food/hour                                │
│                                                                              │
│   EXAMPLE (10 cities, all mechs ODD):                                       │
│   ┌─────────────────────────────────────────────────────────────┐            │
│   │  Catapults:  10 cities × ODD = +21,474,836,470 food/hr     │            │
│   │  Batt. Rams: 10 cities × ODD = +21,474,836,470 food/hr     │            │
│   │  Ballista:   10 cities × ODD = +21,474,836,470 food/hr     │            │
│   │  Cataphracts:10 cities × ODD = +21,474,836,470 food/hr     │            │
│   │  ───────────────────────────────────────────────────────── │            │
│   │  TOTAL:                        +85,899,345,880 food/hr     │            │
│   └─────────────────────────────────────────────────────────────┘            │
│                                                                              │
│   This completely negates any food consumption from troops!                 │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Troubleshooting

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    COMMON ISSUES & SOLUTIONS                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│   ISSUE: Moved troops but destination now has EVEN glitches                 │
│   SOLUTION: Send another threshold multiple to flip back to ODD             │
│                                                                              │
│   ISSUE: No safe city to send to (all have glitches)                        │
│   SOLUTION: Use valleys as temporary storage                                │
│                                                                              │
│   ISSUE: Untrain command not working                                        │
│   SOLUTION: Check you have enough troops, use correct abbreviation          │
│                                                                              │
│   ISSUE: City locked (negative troops)                                      │
│   SOLUTION: Send ALL negative troop types to a valley to unlock             │
│                                                                              │
│   ISSUE: Glitch count keeps changing                                        │
│   SOLUTION: Stop training/attacking while managing glitches                 │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Related Documents

- [GLITCH_MECHANICS.md](GLITCH_MECHANICS.md) - Core glitch mechanics explained
- [MOVE_VS_UNTRAIN.md](MOVE_VS_UNTRAIN.md) - Decision logic for fixing glitches
- [SCRIPTS_REFERENCE.md](SCRIPTS_REFERENCE.md) - AutoEvony script documentation

---

*Document version 1.0 - Created for BorgToolkit*
