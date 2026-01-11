# Move vs Untrain Decision Guide

## Overview

When fixing EVEN glitches (not generating food), you have two options:
1. **UNTRAIN** - Remove troops permanently
2. **MOVE** - Send troops to another city/valley

**General Rule: MOVE is always recommended when dealing with millions of troops.**

---

## Decision Flow Diagram

```
                         ┌─────────────────────────┐
                         │  EVEN GLITCHES DETECTED │
                         │  (Not Generating Food)  │
                         └───────────┬─────────────┘
                                     │
                                     ▼
                    ┌────────────────────────────────┐
                    │  How many troops to remove to  │
                    │  flip to ODD (generating)?     │
                    │                                │
                    │  Amount = remaining + 1        │
                    └────────────────┬───────────────┘
                                     │
                         ┌───────────┴───────────┐
                         ▼                       ▼
              ┌──────────────────┐    ┌──────────────────┐
              │  < 1,000,000     │    │  ≥ 1,000,000     │
              │  (under 1M)      │    │  (1M or more)    │
              └────────┬─────────┘    └────────┬─────────┘
                       │                       │
                       ▼                       ▼
              ┌──────────────────┐    ┌──────────────────┐
              │    UNTRAIN       │    │      MOVE        │
              │   Recommended    │    │   Recommended    │
              │                  │    │                  │
              │  • Quick         │    │  • Preserves     │
              │  • Simple        │    │    troops        │
              │  • Small loss    │    │  • Can help      │
              │                  │    │    other cities  │
              └──────────────────┘    └────────┬─────────┘
                                               │
                                   ┌───────────┴───────────┐
                                   ▼                       ▼
                          ┌───────────────┐      ┌───────────────┐
                          │ Send to City  │      │ Send to Valley│
                          │ with 0 glitch │      │ (temp storage)│
                          │ of this type  │      │               │
                          └───────────────┘      └───────────────┘
```

---

## Detailed Decision Matrix

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                      MOVE vs UNTRAIN DECISION MATRIX                         │
├───────────────────┬─────────────────────────────────────────────────────────┤
│  Troops to Remove │  Recommended Action                                     │
├───────────────────┼─────────────────────────────────────────────────────────┤
│  < 100,000        │  UNTRAIN - Negligible loss                              │
│  (under 100K)     │  Command: untrain [abbr]:[amount]                       │
├───────────────────┼─────────────────────────────────────────────────────────┤
│  100K - 1M        │  UNTRAIN or MOVE - Your choice                          │
│                   │  Consider city storage capacity                          │
├───────────────────┼─────────────────────────────────────────────────────────┤
│  1M - 50M         │  MOVE PREFERRED - Significant troops                    │
│                   │  Send to nearest city with space                        │
├───────────────────┼─────────────────────────────────────────────────────────┤
│  50M - 500M       │  MOVE REQUIRED - Major troop investment                 │
│                   │  Send in threshold multiples                            │
├───────────────────┼─────────────────────────────────────────────────────────┤
│  > 500M           │  MOVE CAREFULLY - Send to multiple cities               │
│                   │  Use valleys as overflow storage                        │
└───────────────────┴─────────────────────────────────────────────────────────┘
```

---

## UNTRAIN Method

### When to Use
- Small amounts (< 1M troops)
- Quick fix needed
- No safe destination available
- Training capacity is high (can rebuild quickly)

### How It Works

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           UNTRAIN PROCESS                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│   BEFORE:  1,958,219,180 catapults                                          │
│            114 glitches (EVEN - not generating)                             │
│            15,159,740 remaining toward next glitch                          │
│                                                                              │
│   COMMAND: untrain cp:15159741                                              │
│                                                                              │
│   AFTER:   1,943,059,439 catapults                                          │
│            113 glitches (ODD - GENERATING!)                                 │
│            17,179,869 remaining (almost full toward next)                   │
│                                                                              │
│   RESULT:  ✓ Now generating +2,147,483,647 food/hour from catapults        │
│            ✗ Lost 15,159,741 catapults permanently                         │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Command Format
```
untrain [troop_abbr]:[amount]

Examples:
  untrain cp:15159741    # Untrain catapults
  untrain r:4399943      # Untrain battering rams
  untrain cata:126322568 # Untrain cataphracts
```

---

## MOVE Method

### When to Use
- Large amounts (≥ 1M troops)
- Want to preserve troops
- Have safe destination city
- Building glitches in another city

### Safe Destination Criteria

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                      SAFE DESTINATION CHECKLIST                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│   BEST: City with 0 glitches of that troop type                             │
│   ─────────────────────────────────────────────                             │
│   • Any amount can be sent safely                                           │
│   • Will create new glitches (may become ODD = generating)                  │
│                                                                              │
│   GOOD: City with ODD glitches (already generating)                         │
│   ─────────────────────────────────────────────────                         │
│   • Send in MULTIPLES of threshold to maintain ODD                          │
│   • Example: Send 1× or 2× threshold amount                                 │
│                                                                              │
│   CAUTION: City with EVEN glitches (not generating)                         │
│   ─────────────────────────────────────────────────                         │
│   • Send exact amount to flip their glitches to ODD                         │
│   • Or send in multiples of threshold                                       │
│                                                                              │
│   ALTERNATIVE: Valley (temporary storage)                                   │
│   ─────────────────────────────────────────────────                         │
│   • Uses HALF threshold (valley glitches)                                   │
│   • Good for overflow when no city available                                │
│   • Counts toward total glitch parity                                       │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Move Commands

```
# Reinforce to another city (keeps troops there)
reinforce [cityname] none [troop_abbr]:[amount]

# Deploy reinforce to coordinates
deploy reinforce [x,y] none [troop_abbr]:[amount]

# Transport with troops
Transport [x,y] [troop_abbr]:[amount]

# Send to valley
reinforce [valleyX,valleyY] none [troop_abbr]:[amount]

Examples:
  reinforce Atlantis none cp:17179870      # Send 1 threshold of catapults
  deploy reinforce 363,627 none r:42949673 # Send 1 threshold of rams
```

---

## Preserving Glitch Parity When Moving

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    SAFE MOVEMENT AMOUNTS                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│   To preserve glitch parity in DESTINATION, send EXACT MULTIPLES:           │
│                                                                              │
│   ┌─────────────────┬──────────────────────────────────────────┐            │
│   │   Troop Type    │   Safe Send Amounts (multiples)          │            │
│   ├─────────────────┼──────────────────────────────────────────┤            │
│   │   Catapults     │   17,179,870 × N  (1×, 2×, 3×, etc.)     │            │
│   │   Battering Ram │   42,949,673 × N                         │            │
│   │   Ballista      │   85,899,346 × N                         │            │
│   │   Cataphracts   │   126,322,568 × N                        │            │
│   │   Cavalry       │   238,609,295 × N                        │            │
│   │   Transporters  │   429,496,730 × N                        │            │
│   │   Archers       │   536,870,912 × N                        │            │
│   │   Pike/Sword    │   715,827,883 × N                        │            │
│   │   Scouts        │   1,073,741,824 × N                      │            │
│   │   Workers/War   │   2,147,483,648 × N                      │            │
│   └─────────────────┴──────────────────────────────────────────┘            │
│                                                                              │
│   WHY: Sending exact multiples adds EVEN number of glitches                 │
│        to destination, preserving their ODD/EVEN state                      │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Complete Decision Workflow

```
┌──────────────────────────────────────────────────────────────────────────────┐
│                     GLITCH FIX COMPLETE WORKFLOW                             │
└──────────────────────────────────────────────────────────────────────────────┘

     ┌──────────────┐
     │ Run Glitch   │
     │ Counter      │
     │ Script       │
     └──────┬───────┘
            │
            ▼
     ┌──────────────┐     ┌──────────────────────────────────────┐
     │ EVEN glitch  │────►│ Calculate: remaining + 1 = fix_amount │
     │ detected?    │     └──────────────────┬───────────────────┘
     └──────────────┘                        │
            │ No                             │
            ▼                    ┌───────────┴───────────┐
     ┌──────────────┐            ▼                       ▼
     │ Already ODD  │    ┌───────────────┐       ┌───────────────┐
     │ ✓ Generating │    │ fix_amount    │       │ fix_amount    │
     └──────────────┘    │ < 1,000,000   │       │ ≥ 1,000,000   │
                         └───────┬───────┘       └───────┬───────┘
                                 │                       │
                                 ▼                       ▼
                         ┌───────────────┐       ┌───────────────┐
                         │   UNTRAIN     │       │ Find nearest  │
                         │   directly    │       │ safe city     │
                         └───────────────┘       └───────┬───────┘
                                                         │
                                         ┌───────────────┼───────────────┐
                                         ▼               ▼               ▼
                                  ┌───────────┐   ┌───────────┐   ┌───────────┐
                                  │ City with │   │ City with │   │ No safe   │
                                  │ 0 glitch  │   │ ODD glitch│   │ city      │
                                  └─────┬─────┘   └─────┬─────┘   └─────┬─────┘
                                        │               │               │
                                        ▼               ▼               ▼
                                  ┌───────────┐   ┌───────────┐   ┌───────────┐
                                  │ Send any  │   │ Send 1×   │   │ Send to   │
                                  │ amount    │   │ threshold │   │ valley    │
                                  └───────────┘   └───────────┘   └───────────┘
```

---

## Quick Reference Card

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         QUICK REFERENCE                                      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│   UNTRAIN (< 1M):     untrain [abbr]:[remaining+1]                          │
│   MOVE (≥ 1M):        reinforce [dest] none [abbr]:[threshold×N]            │
│   TO VALLEY:          reinforce [x,y] none [abbr]:[valley_threshold×N]      │
│                                                                              │
│   TROOP ABBREVIATIONS:                                                       │
│   wo=Workers  w=Warriors  s=Scouts  p=Pike  sw=Sword  a=Archer              │
│   c=Cavalry  cata=Cataphract  t=Transport  b=Ballista  r=Ram  cp=Catapult   │
│                                                                              │
│   RULE OF THUMB:                                                             │
│   • Under 1M → Untrain (quick fix)                                          │
│   • 1M-50M   → Move to nearest city with 0 glitches                         │
│   • Over 50M → Move in threshold multiples to preserve parity               │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Related Documents

- [GLITCH_MECHANICS.md](GLITCH_MECHANICS.md) - Core glitch mechanics explained
- [SCRIPTS_REFERENCE.md](SCRIPTS_REFERENCE.md) - AutoEvony script documentation
- [MULTI_CITY_MANAGEMENT.md](MULTI_CITY_MANAGEMENT.md) - Coordinating across cities

---

*Document version 1.0 - Created for BorgToolkit*
