# Advanced Scripts Suite - Complete Summary

## Total Scripts Created: 25

---

## Scripts Using REAL CityState.as Commands

### Combat Scripts (10)
| Script | Real Commands Used | Purpose |
|--------|-------------------|---------|
| `attack_master_v2.0.txt` | attack, getspamhero | Ultimate configurable attack |
| `quick_spam_v2.0.txt` | attack, getspamhero | Fast copy/paste spam |
| `coordinated_strike_v2.0.txt` | attack, getspamhero | Multi-city sync attack |
| `defense_buster_v2.0.txt` | attack, scout | 4-phase heavy assault |
| `recall_glitch_attack_v2.0.txt` | attack, useitem | Recall timing exploit |
| `lockout_master_v2.0.txt` | spamattack, attack | 1-troop lockout from 100 accounts |
| `rainbow_attack_v2.0.txt` | attack | Mixed troop types (cav/cata/arch/mech) |
| `guarded_attack_v2.0.txt` | guardedattack, setguard, endguardedattack | Scout-protected attacks |
| `loyalty_capture_v2.0.txt` | loyaltyattack, capture, endloyaltyattack | City capture |
| `spam_attack_config_v2.0.txt` | spamattack, spamheroes, findhero, endspamattack | Built-in spam system |

### Mass Coordination Scripts (2)
| Script | Real Commands Used | Purpose |
|--------|-------------------|---------|
| `mass_account_coordinator_v2.0.txt` | attack, getspamhero | 10-100 account coordination |
| `multi_city_coordinator_v1.0.txt` | completequests, upgrade, research, train, levy | All cities management |

### Farming Scripts (4)
| Script | Real Commands Used | Purpose |
|--------|-------------------|---------|
| `npc_spam_master_v2.0.txt` | findnpc, attack, scanmap | NPC farming |
| `npc_10_farmer_v2.0.txt` | npc10list, npc10troops, npc10heroes, npc10limit, distancepolicy | Level 10 NPC farming |
| `smart_farm_v2.0.txt` | findnpc, findvalley, attack | Intelligent farming |
| `valley_capture_v2.0.txt` | findvalley, attack | Valley capture |

### Resource/Troop Management (2)
| Script | Real Commands Used | Purpose |
|--------|-------------------|---------|
| `keep_troop_feeder_v2.0.txt` | keeptroop, keepresource, dumptroop, dumpresource, endkeeptroop | Continuous feeding |
| `scheduled_tasks_v1.0.txt` | levy, comfort, completequests | Time-based automation |

### Defense Scripts (2)
| Script | Real Commands Used | Purpose |
|--------|-------------------|---------|
| `defensive_auto_v1.0.txt` | setgatepolicy, comfort, levy | Threat response |
| `evacuate_defense_v2.0.txt` | evacuatetown, endevacuate, gatepolicy, resourcelimits | Emergency evacuation |

### City Management (3)
| Script | Real Commands Used | Purpose |
|--------|-------------------|---------|
| `city_lifecycle_manager_v1.0.txt` | create, upgrade, research, train, comfort, levy, hirehero, setmayor | Full city management |
| `hero_optimizer_v1.0.txt` | hirehero, firehero, setmayor, getspamhero | Hero management |
| `account_warmup_v1.0.txt` | completequests, create, upgrade, research, train, hirehero | New account setup |

### Glitch Scripts (1)
| Script | Real Commands Used | Purpose |
|--------|-------------------|---------|
| `glitch_suite_v1.0.txt` | useitem, production, train | Food/troop glitches |

### Basic/Utility (1)
| Script | Real Commands Used | Purpose |
|--------|-------------------|---------|
| `npc_farmer_v1.0.txt` | findnpc, attack, train | Basic NPC farm |

---

## Real Commands Reference (from CityState.as)

### Attack Commands
```
attack coords hero troops           // Send attack
spamattack coords troop count       // Built-in spam
guardedattack coords atk scouts def // Scout-protected
loyaltyattack coords numCav         // Loyalty reduction
capture coords numCav               // City capture
endspamattack                       // Stop spam
endguardedattack                    // Stop guarded
endloyaltyattack                    // Stop loyalty
```

### Troop/Resource Commands
```
keeptroop coords troop minCount     // Auto-send troops
keepresource coords res minCount    // Auto-send resources
dumptroop coords cond tr            // Dump excess troops
dumpresource coords cond res        // Dump excess resources
endkeeptroop                        // Stop troop feed
endkeepresource                     // Stop resource feed
```

### NPC Commands
```
npclist str                         // Set NPC targets
npctroops str                       // Set NPC troops
npcheroes str                       // Set NPC heroes
npc10list str                       // Level 10 NPC targets
npc10troops str                     // Level 10 troops
npc10heroes str                     // Level 10 heroes
npc10limit str                      // Level 10 limits
```

### Defense Commands
```
evacuatetown coords                 // Emergency evacuate
endevacuate                         // End evacuation
gatepolicy peace atk sb mixed       // Gate settings
resourcelimits food wood stone iron // Resource caps
```

### Hero Commands
```
getspamhero attrib                  // Get spam hero
findhero attrib minLevel method     // Find/hire hero
spamheroes str                      // Configure spam heroes
firehero name                       // Fire hero
```

### Policy Commands
```
distancepolicy npc buildnpc hunt valley map  // Distance settings
```

### Scanning
```
scanmap coords radius               // Scan map
scanrec coords1 coords2             // Scan rectangle
rescanmap coords radius             // Force rescan
```

---

## Test Accounts Ready

| Account | Archers | Server | Status |
|---------|---------|--------|--------|
| toygarc@hotmail.com | 60,000,000 | cc2 | Ready |
| watsonj50@hotmail.com | 40,000,000 | cc2 | Ready |
| robcuaw2250@aol.com | 7,000,000 | cc2 | Ready |

**Total Test Archers: 107,000,000**

---

## Scripts Still Missing (Gaps)

| Gap | Description | Priority |
|-----|-------------|----------|
| Alliance Coordinator | Mass alliance attacks | Medium |
| Rally Attack System | Rally point management | High |
| Report Cleaner | cleanreports, cleannpcreports | Low |
| Item User | Bulk useitem automation | Medium |
| Research Optimizer | techgoals, checkresearch | Medium |
| Building Optimizer | buildinggoals, troopgoal | Medium |
| Transport Manager | Trade/transport automation | Medium |
| Medal Farmer | listmedals, useitem | Low |

---

## Configuration Features (All Scripts)

Every script includes:
```
// === FEATURES ENABLE/DISABLE ===
set enableFeature1 1        // Toggle feature on/off
set enableFeature2 0        // 0=off, 1=on
set enableLogging 1         // Status output
set enableSafetyCheck 1     // Safety limits

// === RUN MODE ===
set runMode "loop"          // once, loop, timer, count
set maxRuns 0               // For count mode
set timerMinutes 0          // For timer mode
```

---

## File Location
```
D:\EvonyToolKit\scripts\v2_new\
```

---

*All 25 scripts require real account testing before considered working*
