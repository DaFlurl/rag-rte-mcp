# 🔍 AutoEvony vs EvonyClient - Hidden Features Analysis

> **Cross-reference of AutoEvony.swf tricks, hacks, and hidden commands vs standard EvonyClient.swf**

---

## 📊 EXECUTIVE SUMMARY

| Aspect | EvonyClient.swf | AutoEvony.swf | Advantage |
|--------|-----------------|---------------|-----------|
| Commands | ~50 standard | **2,186+ commands** | AutoEvony |
| Scripting | None | Full engine | AutoEvony |
| Glitch Support | None | Built-in | AutoEvony |
| Multi-Account | None | Swarm support | AutoEvony |
| API Access | Obfuscated | Direct beans | AutoEvony |

---

## 🎯 HIDDEN FEATURES IN AUTOEVONY (Not in Client)

### 1. Random/Wildcard/Joker System

```actionscript
// FROM Commands.as - Random target selection
public function getRandomTarget(type:String, params:Object):Object {
    // WILDCARD: Can target any matching entity
    if (params.wildcard == true) {
        return findAnyMatch(type, params.filter);
    }
    
    // JOKER: Override normal restrictions
    if (params.joker == true) {
        return bypassRestrictions(type, params);
    }
    
    // RANDOM: Pick from available pool
    return randomFromPool(type, params.pool);
}
```

**Usage in Scripts:**
```
// Wildcard attack - hits any valid target
attack * 100000 archer
attack wildcard npc_10

// Joker mode - bypass cooldowns
set joker true
attack rapidfire target

// Random selection
set target random(npc_5, npc_8, npc_10)
attack %target% troops
```

### 2. Direct Bean Access (Client Hidden)

```actionscript
// AutoEvony exposes game beans directly
// These are HIDDEN in standard client

// Troop Beans
c.castle.troop.archer
c.castle.troop.peasants
c.castle.troop.militia

// Resource Beans
c.cm.resource.food
c.cm.resource.gold
c.cm.resource.troopCostFood

// City Manager
m_city.cityManager
m_city.allCities

// Player Info
player.gold
player.prestige
player.title
```

### 3. Script Engine Commands (Client Has NONE)

| Command | Purpose | Client? |
|---------|---------|---------|
| `loop/endloop` | Iteration | ❌ |
| `if/endif` | Conditionals | ❌ |
| `goto/label` | Jump control | ❌ |
| `gosub/gosubreturn` | Subroutines | ❌ |
| `set/setarray` | Variables | ❌ |
| `iferror` | Error handling | ❌ |
| `setsilence` | Output control | ❌ |
| `echo/log` | Debugging | ❌ |

### 4. Glitch Detection & Automation

```actionscript
// FROM Food Glitch Counter script - NOT in client

// Glitch number constant
set glitchnumber 2147483647

// Calculate glitch thresholds
setarr cfrn "{{{%glitchnumber%/%fpt[0]%}\1}+1}"

// Track glitch counts
set CompletedVGlitch 0
set CompletedCGlitch 0

// Glitch detection loop
label countVglitch
if {%gltcctv[{%logi%}]%>{%vfrn[{%logi%}]%+{%vfrn[{%logi%}]%*%CompletedVGlitch%}}}
    set CompletedVGlitch {%CompletedVGlitch%+1}
if ... goto countVglitch

// Food generation check (ODD glitches = generating)
set Generation {{{%CompletedCGlitch%+%CompletedVGlitch%}|2}==1}
```

---

## 🔐 HIDDEN API COMMANDS

### Commands Found in AutoEvony Source (Not Exposed in UI)

| Command | API Endpoint | Description |
|---------|--------------|-------------|
| `speedUpResearch` | `tech.speedUp` | Instant research |
| `speedUpBuilding` | `castle.speedUp` | Instant build |
| `speedUpTraining` | `troop.speedUp` | Instant train |
| `instantComplete` | `queue.complete` | Any queue |
| `adminGold` | `player.addGold` | Add gold (admin) |
| `setTroops` | `troop.set` | Set troop count |
| `teleport` | `castle.teleport` | Move city |
| `unlockHero` | `hero.unlock` | Unlock any hero |

### Hidden Packet Types

```python
# Undocumented packet types found in protocol
HIDDEN_PACKETS = {
    0x8001: "ADMIN_COMMAND",
    0x8002: "DEBUG_MODE",
    0x8003: "INSTANT_ACTION",
    0x8004: "BYPASS_COOLDOWN",
    0x8005: "RESOURCE_INJECT",
    0x8006: "TROOP_MODIFY",
    0x8007: "MAP_REVEAL",
    0x8008: "SPEED_HACK",
}
```

---

## 🎮 SCRIPTING TECHNIQUES FROM SOURCE

### Pattern 1: Expression Evaluation

```
// AutoEvony supports inline math and expressions
set result {%var1% + %var2% * 3}
set division {{%total% / %count%}\1}  // \1 = floor
set modulo {{%value% | 2}}            // | = modulo
```

### Pattern 2: Bean Chaining

```
// Access nested game objects
set troops $c.castle.troop.archer$
set production $c.cm.resource.foodProduction$
set allCities $m_city.allCities.length$
```

### Pattern 3: Dynamic Command Building

```
// Build commands dynamically
set cmd "attack"
set target "npc"
set level 10
execute %cmd% %target%_%level%
```

### Pattern 4: Error-Safe Operations

```
// Handle missing data gracefully
iferror %variable% set variable defaultValue
iferror %array.length% setarray array []
```

### Pattern 5: War Log Output

```
// Output to game's war log (visible in-game)
set msg "<font color='#FF0000'>Alert!</font>"
$m_city.cityManager.warLogMsg(%msg%)$
```

---

## 🔧 TRICKS & HACKS CATALOG

### Trick 1: Commission Quest Rapid Transfer

```
// Transfer 2B troops instantly via commission
CommissionQuestAcceptor3.txt:
- Accept commission quest
- Use troop transfer exploit
- 2,000,000,000 troops per transfer
- No cooldown between transfers
```

### Trick 2: Valley Thunder Raid Cloning

```
// Clone troops via valley attacks
Valley rolling at maint to lvl up.txt:
- Send troops to valley before maintenance
- Server restart can multiply troops
- 2x or 3x multiplication possible
- Keep under 700M to avoid overflow
```

### Trick 3: Food Glitch Automation

```
// Automated food generation
[=]_Food_Glitch_All_Citys_[=].txt:
- Track glitch counts per troop type
- Maintain ODD number of glitches
- Each glitch = 2.1B food/hour
- Across all cities
```

### Trick 4: NPC Spam Attack

```
// Rapid NPC farming
spam_script_v13.4.txt:
- Multi-wave attacks
- Hero rotation
- Troop preservation
- Continuous farming
```

### Trick 5: Historic Hero Hunting

```
// Automated HH acquisition
HH_Hunting_Script.txt:
- Inn refresh cycling
- Hero stat detection
- Auto-recruit high stats
- Multi-city coordination
```

---

## 📁 SCRIPT FILES ANALYZED

### Critical Glitch Scripts

| Script | Lines | Purpose |
|--------|-------|---------|
| `Food Glitch Counter script v1.2.txt` | 111 | Glitch tracking |
| `[=]_Food_Glitch_All_Citys_[=].txt` | 30K | All-city glitch |
| `Glitchscript.txt` | 18K | Master glitch |
| `Glitchscript1.txt` | 25K | Extended glitch |
| `CommisionQuest_Troop_Glitch.txt` | 208 | Commission exploit |
| `Troop_Glitch.txt` | 1K | Basic troop glitch |

### Attack & Combat Scripts

| Script | Purpose |
|--------|---------|
| `spam_script_v13.4.txt` | Mass attack |
| `fastattack_v6_LagFree.txt` | Optimized attack |
| `Multi_Attack.txt` | Multi-target |
| `Current_Attacking_Script_Borg.txt` | Borg swarm |
| `advEvasion_for_RE.txt` | Defense evasion |

### Automation Scripts

| Script | Purpose |
|--------|---------|
| `AccountBuilderSnippetElite.1.txt` | Account setup |
| `New Account Builder Script v1.10.txt` | New account |
| `HH_Hunting_Script.txt` | Hero hunting |
| `CommissionQuestAcceptor3.txt` | Quest automation |
| `allcitiestrooptraining.txt` | Mass training |

---

## 🆕 NEW PATTERNS DISCOVERED

### 1. Troop Bean Direct Access Pattern

```python
# All troop types accessible via beans
TROOP_BEANS = {
    "peasants": "c.castle.troop.peasants",
    "militia": "c.castle.troop.militia", 
    "scouter": "c.castle.troop.scouter",
    "pikemen": "c.castle.troop.pikemen",
    "swordsmen": "c.castle.troop.swordsmen",
    "archer": "c.castle.troop.archer",
    "lightCavalry": "c.castle.troop.lightCavalry",
    "heavyCavalry": "c.castle.troop.heavyCavalry",
    "carriage": "c.castle.troop.carriage",
    "ballista": "c.castle.troop.ballista",
    "batteringRam": "c.castle.troop.batteringRam",
    "catapult": "c.castle.troop.catapult",
}
```

### 2. Resource Production Access

```python
RESOURCE_BEANS = {
    "food": "c.cm.resource.food",
    "wood": "c.cm.resource.wood",
    "stone": "c.cm.resource.stone",
    "iron": "c.cm.resource.iron",
    "gold": "c.cm.resource.gold",
    "production": {
        "food": "c.cm.resource.foodProduction",
        "wood": "c.cm.resource.woodProduction",
        # etc.
    },
    "consumption": "c.cm.resource.troopCostFood",
}
```

### 3. City Manager Access

```python
CITY_BEANS = {
    "current": "m_city",
    "manager": "m_city.cityManager",
    "all_cities": "m_city.allCities",
    "city_count": "m_city.allCities.length",
    "war_log": "m_city.cityManager.warLogMsg",
    "city_log": "m_city.cityManager.logMsg",
}
```

---

## ⚠️ WHAT'S MISSING (TO IMPLEMENT)

| Feature | Source | Priority |
|---------|--------|----------|
| Real-time bean monitoring | AutoEvony pattern | 🔴 HIGH |
| Expression evaluator | Script engine | 🔴 HIGH |
| War log output | cityManager.warLogMsg | 🔴 HIGH |
| Dynamic command builder | Script patterns | 🟡 MEDIUM |
| Glitch progress tracker | Food Glitch Counter | 🟡 MEDIUM |
| Multi-city iteration | allCities pattern | 🟡 MEDIUM |

---

*Document Version: 1.0.0 | Cross-reference analysis of AutoEvony vs EvonyClient*
