# Evony AutoEvony Scripts Reference

## Overview

This document describes all glitch management scripts included in the `evony_scripts/` folder.

---

## Scripts Summary

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         SCRIPT OVERVIEW                                      │
├──────────────────────────┬──────────────────────────────────────────────────┤
│  Script                  │  Purpose                                         │
├──────────────────────────┼──────────────────────────────────────────────────┤
│  FoodGlitchCounterV1.2   │  Original Ogliss script - analyze current city   │
│  GlitchManager_MultiCity │  Scan ALL cities, find problems                  │
│  GlitchOptimizer_AutoFix │  Calculate & execute untrains                    │
│  SafeTroopMover_v1       │  Calculate safe send amounts                     │
│  Troop_&_RSS_Counter     │  Count troops and resources                      │
└──────────────────────────┴──────────────────────────────────────────────────┘
```

---

## 1. FoodGlitchCounterV1.2.txt

**Author:** Ogliss  
**Purpose:** Analyze food glitch state for the current city

### Features
- Displays glitch count per troop type
- Shows progress toward next glitch
- Indicates ODD (generating) vs EVEN (not generating)
- Full and Lite display modes

### Configuration
```
set Mode full    // "full" or "lite"
set Output WarLog // "Log" or "WarLog"
```

### Output Example
```
Type: Catapults
    City Glitches: 114
      City Glitch Progress: 88 percent
      City Glitch Details: 15159740 / 17179870 need 2020130
  Food Generation: false! 
you need an odd number of glitches to generate food!
```

### Flow Diagram
```
┌─────────────────┐
│  Start Script   │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ For each troop  │◄──────────────┐
│ type (0-11)     │               │
└────────┬────────┘               │
         │                        │
         ▼                        │
┌─────────────────┐               │
│ Get city count  │               │
│ Get valley count│               │
└────────┬────────┘               │
         │                        │
         ▼                        │
┌─────────────────┐               │
│ Count glitches  │               │
│ city & valley   │               │
└────────┬────────┘               │
         │                        │
         ▼                        │
┌─────────────────┐               │
│ Check ODD/EVEN  │               │
│ Build message   │               │
└────────┬────────┘               │
         │                        │
         ▼                        │
┌─────────────────┐    No         │
│ More troops?    │───────────────┘
└────────┬────────┘
         │ Yes (done)
         ▼
┌─────────────────┐
│ Output to Log   │
└─────────────────┘
```

---

## 2. GlitchManager_MultiCity.txt

**Author:** Borg (Enhanced)  
**Purpose:** Scan ALL cities at once, identify problems across account

### Features
- Scans every city automatically
- Identifies EVEN glitches needing fix
- Lists safe destination cities
- Shows untrain commands for quick fixes

### Configuration
```
set Mode full              // Display mode
set Output WarLog          // Output destination
set UntrainThreshold 50000000  // Only show fix for < 50M remaining
set ShowOnlyProblems true  // Hide troops with no issues
```

### Output Sections
1. **Per-City Analysis** - Each city's glitch state
2. **Problem Highlights** - EVEN glitches in red
3. **Safe Cities List** - Cities that can receive overflow
4. **Quick Reference** - Command format reminder

### Multi-City Scan Flow
```
┌──────────────────┐
│ Get total cities │
│ from m_city      │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ For each city    │◄─────────────────┐
│ index 0 to N     │                  │
└────────┬─────────┘                  │
         │                            │
         ▼                            │
┌──────────────────┐                  │
│ Get city ref     │                  │
│ allCities[index] │                  │
└────────┬─────────┘                  │
         │                            │
         ▼                            │
┌──────────────────┐                  │
│ Analyze all 12   │                  │
│ troop types      │                  │
└────────┬─────────┘                  │
         │                            │
         ▼                            │
┌──────────────────┐                  │
│ Log problems     │                  │
│ Mark safe cities │                  │
└────────┬─────────┘                  │
         │                            │
         ▼                            │
┌──────────────────┐    No            │
│ More cities?     │──────────────────┘
└────────┬─────────┘
         │ Done
         ▼
┌──────────────────┐
│ Output summary   │
│ Safe city list   │
└──────────────────┘
```

---

## 3. GlitchOptimizer_AutoFix.txt

**Author:** Borg (Enhanced)  
**Purpose:** Calculate exact untrain amounts and optionally execute

### Features
- Calculates minimum untrain to flip EVEN → ODD
- Preview mode (safe, no changes)
- Auto-execute mode (actually untrains)
- Safety checks (won't remove all glitches)

### Configuration
```
set AutoExecute false      // true = actually untrain, false = preview
set MaxUntrainAmount 100000000  // Safety limit
set OnlyFixNearThreshold 50000000  // Only fix if remaining < this
set FocusHighValue true    // Prioritize mechs/horses/archers
```

### Safety Features
```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        SAFETY CHECKS                                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│   ✓ Won't untrain if only 1 glitch (would remove all glitches)              │
│   ✓ Respects MaxUntrainAmount limit                                         │
│   ✓ Preview mode by default (must enable AutoExecute)                       │
│   ✓ Skips troops far from threshold (optional)                              │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Decision Flow
```
┌──────────────────┐
│ Check troop type │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐     ┌──────────────────┐
│ Has glitches?    │─No─►│ Skip (nothing    │
└────────┬─────────┘     │ to fix)          │
         │ Yes           └──────────────────┘
         ▼
┌──────────────────┐     ┌──────────────────┐
│ Is ODD?          │─Yes►│ Skip (already    │
└────────┬─────────┘     │ generating)      │
         │ No            └──────────────────┘
         ▼
┌──────────────────┐     ┌──────────────────┐
│ Only 1 glitch?   │─Yes►│ WARN: Would      │
└────────┬─────────┘     │ remove all!      │
         │ No            └──────────────────┘
         ▼
┌──────────────────┐     ┌──────────────────┐
│ Over max amount? │─Yes►│ WARN: Too much   │
└────────┬─────────┘     │ to untrain       │
         │ No            └──────────────────┘
         ▼
┌──────────────────┐
│ Calculate fix    │
│ Show command     │
│ Execute if auto  │
└──────────────────┘
```

---

## 4. SafeTroopMover_v1.txt

**Author:** Borg (Enhanced)  
**Purpose:** Calculate safe amounts to send between cities

### Features
- Analyzes specific troop type across all cities
- Shows each city's capacity to receive
- Calculates safe send amounts (threshold multiples)
- Provides move commands

### Configuration
```
set TargetTroop cp         // Troop to analyze (wo,w,s,p,sw,a,c,cata,t,b,r,cp)
set MinKeepInCity 10000000 // Minimum troops to keep in source
```

### Output Information
For each destination city:
- Current troop count
- Current glitch count and state
- Space to next glitch
- Safety status (SAFE, CAUTION-ODD, CAUTION-EVEN)
- Recommended send amount

### Destination Analysis
```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    DESTINATION STATUS CODES                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│   🟢 SAFE         │  0 glitches - send any amount                           │
│   🟡 CAUTION-ODD  │  ODD glitches - send in threshold multiples             │
│   🟠 CAUTION-EVEN │  EVEN glitches - can fix by sending right amount        │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 5. Troop_&_RSS_Counter.txt

**Author:** Community  
**Purpose:** Count total troops and resources across all cities

### Features
- Tallies all troop types
- Calculates total food consumption
- Shows per-city breakdown
- Resource totals

---

## Command Quick Reference

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    COMMON COMMANDS                                           │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│   UNTRAIN TROOPS:                                                            │
│   untrain [abbr]:[amount]                                                    │
│   Example: untrain cp:15159741                                               │
│                                                                              │
│   REINFORCE CITY:                                                            │
│   reinforce [cityname] none [abbr]:[amount]                                  │
│   Example: reinforce Atlantis none cp:17179870                               │
│                                                                              │
│   REINFORCE COORDINATES:                                                     │
│   deploy reinforce [x,y] none [abbr]:[amount]                                │
│   Example: deploy reinforce 363,627 none r:42949673                          │
│                                                                              │
│   TRANSPORT:                                                                 │
│   Transport [x,y] [abbr]:[amount] [resource]:[amount]                        │
│   Example: Transport 363,627 t:125000 g:1000000000                           │
│                                                                              │
│   RECALL:                                                                    │
│   recall [x,y]                                                               │
│   Example: recall 363,627                                                    │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Troop Abbreviations

```
┌──────────────┬────────────────┬──────────────┬────────────────┐
│ Abbreviation │ Troop Name     │ Abbreviation │ Troop Name     │
├──────────────┼────────────────┼──────────────┼────────────────┤
│     wo       │ Workers        │     c        │ Cavalry        │
│     w        │ Warriors       │     cata     │ Cataphracts    │
│     s        │ Scouts         │     t        │ Transporters   │
│     p        │ Pikemen        │     b        │ Ballista       │
│     sw       │ Swordsmen      │     r        │ Battering Ram  │
│     a        │ Archers        │     cp       │ Catapults      │
└──────────────┴────────────────┴──────────────┴────────────────┘
```

---

## Related Documents

- [GLITCH_MECHANICS.md](GLITCH_MECHANICS.md) - Core glitch mechanics explained
- [MOVE_VS_UNTRAIN.md](MOVE_VS_UNTRAIN.md) - Decision logic for fixing glitches
- [MULTI_CITY_MANAGEMENT.md](MULTI_CITY_MANAGEMENT.md) - Coordinating across cities

---

*Document version 1.0 - Created for BorgToolkit*
