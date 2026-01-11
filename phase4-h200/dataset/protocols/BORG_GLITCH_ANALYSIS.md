# Borg Account Glitch Analysis - Based on Reference Spreadsheet

## Current Troop Counts & Glitch State

```
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│                         BORG ACCOUNT - 189.8B TROOPS                                      │
├──────────────┬────────────────┬─────────────┬──────────┬──────────┬───────────┬──────────┤
│ Troop Type   │ Current Count  │ 1 Glitch At │ Glitches │ ODD/EVEN │ Food/hr   │ Status   │
├──────────────┼────────────────┼─────────────┼──────────┼──────────┼───────────┼──────────┤
│ Workers      │  2,135,728,399 │ 2,148,000,000│    0     │   ---    │     -2.1B │ No glitch│
│ Warriors     │  3,081,610,187 │ 2,148,000,000│    1     │   ODD ✓  │     -3.0B │ GEN!     │
│ Scouts       │ 20,252,277,005 │ 1,074,000,000│   18     │  EVEN ✗  │   -202.5B │ FIX!     │
│ Pikemen      │ 20,761,510,159 │   716,000,000│   29     │   ODD ✓  │   -207.6B │ GEN!     │
│ Swordsmen    │ 19,254,904,775 │   716,000,000│   26     │  EVEN ✗  │   -192.5B │ FIX!     │
│ Archers      │ 18,983,761,209 │   537,000,000│   35     │   ODD ✓  │   -189.8B │ GEN!     │
│ Cavalry      │ 19,301,789,028 │   238,666,667│   80     │  EVEN ✗  │   -193.0B │ FIX!     │
│ Cataphracts  │ 19,206,471,282 │   126,352,942│  152     │  EVEN ✗  │ -1,920.6B │ FIX!     │
│ Transporters │ 14,515,368,839 │   429,600,000│   33     │   ODD ✓  │   -145.1B │ GEN!     │
│ Ballista     │ 17,092,987,102 │    85,920,000│  198     │  EVEN ✗  │ -1,709.2B │ FIX!     │
│ Battering Ram│ 18,561,578,404 │    42,960,000│  432     │  EVEN ✗  │ -1,856.1B │ FIX!     │
│ Catapults    │ 16,683,186,332 │    17,184,000│  970     │  EVEN ✗  │-16,683.1B │ FIX!     │
├──────────────┼────────────────┼─────────────┼──────────┼──────────┼───────────┼──────────┤
│ TOTALS       │189,831,172,721 │             │  1,974   │ 5 ODD    │-23,305.2B │          │
└──────────────┴────────────────┴─────────────┴──────────┴──────────┴───────────┴──────────┘

Current Generation: 5 types ODD × 2.148B = 10.74B/hr
Current Consumption: 23,305.2B/hr
NET FOOD: -23,294.5B/hr (23.3 TRILLION DEFICIT!)
```

---

## CRITICAL: 7 Troop Types Need EVEN → ODD Fix!

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    EVEN GLITCHES TO FIX (NOT GENERATING)                     │
├──────────────┬──────────┬─────────────────┬──────────────────────────────────┤
│ Troop Type   │ Glitches │ Fix Amount      │ Recommendation                   │
├──────────────┼──────────┼─────────────────┼──────────────────────────────────┤
│ Scouts       │ 18 EVEN  │ Need: +1 glitch │ ADD 537M or UNTRAIN remainder    │
│ Swordsmen    │ 26 EVEN  │ Need: +1 glitch │ ADD 358M or UNTRAIN remainder    │
│ Cavalry      │ 80 EVEN  │ Need: +1 glitch │ ADD 119M or UNTRAIN remainder    │
│ Cataphracts  │ 152 EVEN │ Need: +1 glitch │ ADD 63M or UNTRAIN remainder     │
│ Ballista     │ 198 EVEN │ Need: +1 glitch │ ADD 43M or UNTRAIN remainder     │
│ Battering Ram│ 432 EVEN │ Need: +1 glitch │ ADD 21.5M or UNTRAIN remainder   │
│ Catapults    │ 970 EVEN │ Need: +1 glitch │ ADD 8.6M or UNTRAIN remainder    │
└──────────────┴──────────┴─────────────────┴──────────────────────────────────┘

After fixing ALL to ODD:
New Generation: 12 types × 2.148B = 25.776B/hr
Still Deficit: 23,305B - 25.8B = -23,279B/hr (still 23T deficit!)
```

---

## THE MATH PROBLEM

```
╔═══════════════════════════════════════════════════════════════════════════════╗
║                     WHY 189B TROOPS CANNOT BE BALANCED                         ║
╠═══════════════════════════════════════════════════════════════════════════════╣
║                                                                               ║
║   MAX POSSIBLE GENERATION (10 cities × 12 types ODD):                        ║
║   = 10 × 12 × 2,148,000,000 = 257,760,000,000/hr (257.7B)                    ║
║                                                                               ║
║   YOUR CONSUMPTION: 23,305,203,459,779/hr (23.3 TRILLION)                    ║
║                                                                               ║
║   ┌─────────────────────────────────────────────────────────────────┐        ║
║   │  Consumption is 90x higher than max generation!                 │        ║
║   │  NO GLITCH CONFIGURATION CAN FIX THIS                           │        ║
║   └─────────────────────────────────────────────────────────────────┘        ║
║                                                                               ║
║   BREAKDOWN OF WHY:                                                          ║
║   • Your Catapults alone: 16.6B × 125 = 2,085 TRILLION/hr                   ║
║   • That's 8x MORE than all possible generation combined!                    ║
║                                                                               ║
╚═══════════════════════════════════════════════════════════════════════════════╝
```

---

## SOLUTION OPTIONS

### Option 1: Massive Troop Reduction (For Balanced Food)

To achieve BALANCED (0 net) food with your reference numbers:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│        BALANCED CONFIGURATION - ~25B TROOPS TOTAL (per city)                 │
├──────────────┬─────────────┬────────────┬───────────┬───────────────────────┤
│ Troop Type   │ Per City    │ Glitches   │ Food/hr   │ Notes                 │
├──────────────┼─────────────┼────────────┼───────────┼───────────────────────┤
│ Workers      │ 2,148,000,001│ 1 ODD ✓   │  -2.148B  │ Just over threshold   │
│ Warriors     │ 2,148,000,001│ 1 ODD ✓   │  -2.148B  │ Just over threshold   │
│ Scouts       │ 1,074,000,001│ 1 ODD ✓   │  -2.148B  │ Just over threshold   │
│ Pikemen      │   716,000,001│ 1 ODD ✓   │  -2.148B  │ Just over threshold   │
│ Swordsmen    │   716,000,001│ 1 ODD ✓   │  -2.148B  │ Just over threshold   │
│ Archers      │   537,000,001│ 1 ODD ✓   │  -2.148B  │ Just over threshold   │
│ Cavalry      │   238,666,668│ 1 ODD ✓   │  -2.148B  │ Just over threshold   │
│ Cataphracts  │   126,352,943│ 1 ODD ✓   │  -2.148B  │ Just over threshold   │
│ Transporters │   429,600,001│ 1 ODD ✓   │  -2.148B  │ Just over threshold   │
│ Ballista     │    85,920,001│ 1 ODD ✓   │  -2.148B  │ Just over threshold   │
│ Battering Ram│    42,960,001│ 1 ODD ✓   │  -2.148B  │ Just over threshold   │
│ Catapults    │    17,184,001│ 1 ODD ✓   │  -2.148B  │ Just over threshold   │
├──────────────┼─────────────┼────────────┼───────────┼───────────────────────┤
│ CITY TOTAL   │ 8,279,683,620│ 12 ODD    │ -25.78B   │                       │
│ GENERATED    │             │           │ +25.78B   │ 12 types ODD          │
│ NET FOOD     │             │           │    ~0     │ BALANCED!             │
└──────────────┴─────────────┴────────────┴───────────┴───────────────────────┘

10 Cities Total: 82.8B troops with BALANCED food (0 net)
```

---

### Option 2: Positive Food Configuration (+8B to +10B per city)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│        POSITIVE FOOD - +10B/hr per city (reduce troop counts)                │
├──────────────┬─────────────┬────────────┬───────────┬───────────────────────┤
│ Troop Type   │ Per City    │ Glitches   │ Food/hr   │ Notes                 │
├──────────────┼─────────────┼────────────┼───────────┼───────────────────────┤
│ Workers      │   500,000,000│ 0         │    -500M  │ Below threshold       │
│ Warriors     │   500,000,000│ 0         │    -500M  │ Below threshold       │
│ Scouts       │ 1,074,000,001│ 1 ODD ✓   │  -2.148B  │ 1 glitch              │
│ Pikemen      │   716,000,001│ 1 ODD ✓   │  -2.148B  │ 1 glitch              │
│ Swordsmen    │   716,000,001│ 1 ODD ✓   │  -2.148B  │ 1 glitch              │
│ Archers      │   537,000,001│ 1 ODD ✓   │  -2.148B  │ 1 glitch              │
│ Cavalry      │   238,666,668│ 1 ODD ✓   │  -2.148B  │ 1 glitch              │
│ Cataphracts  │   126,352,943│ 1 ODD ✓   │  -2.148B  │ 1 glitch              │
│ Transporters │   100,000,000│ 0         │    -500M  │ Below threshold       │
│ Ballista     │    85,920,001│ 1 ODD ✓   │  -2.148B  │ 1 glitch              │
│ Battering Ram│    42,960,001│ 1 ODD ✓   │  -2.148B  │ 1 glitch              │
│ Catapults    │    17,184,001│ 1 ODD ✓   │  -2.148B  │ 1 glitch              │
├──────────────┼─────────────┼────────────┼───────────┼───────────────────────┤
│ CITY TOTAL   │ 4,654,083,617│ 10 ODD    │ -22.98B   │                       │
│ GENERATED    │             │           │ +21.48B   │ 10 types ODD          │
│ NET FOOD     │             │           │  ~-1.5B   │ Hmm, still negative   │
└──────────────┴─────────────┴────────────┴───────────┴───────────────────────┘

Need even fewer troops for positive food!
```

---

### Option 3: True +10B Per City Config

```
┌─────────────────────────────────────────────────────────────────────────────┐
│        TRUE +10B/hr per city - MINIMAL TROOPS                                │
├──────────────┬─────────────┬────────────┬───────────┬───────────────────────┤
│ Troop Type   │ Per City    │ Glitches   │ Food/hr   │ Notes                 │
├──────────────┼─────────────┼────────────┼───────────┼───────────────────────┤
│ Workers      │    50,000,000│ 0         │     -50M  │ Minimal               │
│ Warriors     │    50,000,000│ 0         │     -50M  │ Minimal               │
│ Scouts       │ 1,074,000,001│ 1 ODD ✓   │  -2.148B  │ 1 glitch              │
│ Pikemen      │   716,000,001│ 1 ODD ✓   │  -2.148B  │ 1 glitch              │
│ Swordsmen    │   716,000,001│ 1 ODD ✓   │  -2.148B  │ 1 glitch              │
│ Archers      │   537,000,001│ 1 ODD ✓   │  -2.148B  │ 1 glitch              │
│ Cavalry      │   238,666,668│ 1 ODD ✓   │  -2.148B  │ 1 glitch              │
│ Cataphracts  │   126,352,943│ 1 ODD ✓   │  -2.148B  │ 1 glitch              │
│ Transporters │    50,000,000│ 0         │    -250M  │ Minimal               │
│ Ballista     │    85,920,001│ 1 ODD ✓   │  -2.148B  │ 1 glitch              │
│ Battering Ram│    42,960,001│ 1 ODD ✓   │  -2.148B  │ 1 glitch              │
│ Catapults    │    17,184,001│ 1 ODD ✓   │  -2.148B  │ 1 glitch              │
├──────────────┼─────────────┼────────────┼───────────┼───────────────────────┤
│ CITY TOTAL   │ 3,704,083,617│ 10 ODD    │ -15.78B   │                       │
│ GENERATED    │             │           │ +21.48B   │ 10 types ODD          │
│ NET FOOD     │             │           │  +5.7B    │ POSITIVE!             │
└──────────────┴─────────────┴────────────┴───────────┴───────────────────────┘

10 Cities: ~37B troops with +57B/hr total net food
```

---

## YOUR OPTIONS SUMMARY

```
╔═══════════════════════════════════════════════════════════════════════════════╗
║                         REALISTIC OPTIONS FOR BORG                            ║
╠═══════════════════════════════════════════════════════════════════════════════╣
║                                                                               ║
║  OPTION A: Keep 189B Troops                                                  ║
║  • Fix all EVEN → ODD (7 types)                                              ║
║  • Still -23T/hr deficit                                                     ║
║  • MUST farm food constantly or use food items                               ║
║                                                                               ║
║  OPTION B: Reduce to ~80B Troops (Balanced)                                  ║
║  • All 12 types at 1 glitch ODD per city                                     ║
║  • ~0 net food (balanced)                                                    ║
║  • Reduce: -109B troops (58% reduction)                                      ║
║                                                                               ║
║  OPTION C: Reduce to ~37B Troops (+5.7B/hr per city)                         ║
║  • 10 types at 1 glitch, 2 types minimal                                     ║
║  • +57B/hr total net food                                                    ║
║  • Reduce: -152B troops (80% reduction)                                      ║
║                                                                               ║
║  OPTION D: Keep Mechs, Sacrifice Others                                      ║
║  • Keep catapults, rams, ballista, cataphracts                               ║
║  • Reduce foot troops to near zero                                           ║
║  • Still negative but less deficit                                           ║
║                                                                               ║
╚═══════════════════════════════════════════════════════════════════════════════╝
```

---

## IMMEDIATE ACTIONS (Fix EVEN Glitches)

Even without reducing troops, fix these EVEN glitches to gain +15B generation:

```
7 types EVEN → ODD = 7 × 2.148B = +15.036B/hr more generation

Commands to run per city (calculate exact remainder first):
• Scouts: untrain s:[remainder+1] OR train s:[threshold-remainder]
• Swordsmen: untrain sw:[remainder+1]
• Cavalry: untrain c:[remainder+1]
• Cataphracts: untrain cata:[remainder+1]
• Ballista: untrain b:[remainder+1]
• Battering Rams: untrain r:[remainder+1]
• Catapults: untrain cp:[remainder+1]
```

Run the PerCity_TroopCollector.txt script to get exact remainders per city!
