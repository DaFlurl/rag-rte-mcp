# 🔓 HIDDEN & UNUSED COMMANDS REFERENCE

> **Extracted from Commands.as, Connection.as, and user scripts**
> Commands the bot has access to but doesn't fully utilize

---

## 📊 COMMAND CATEGORIES

| Category | Commands | Usage Status |
|----------|----------|--------------|
| Troop Glitching | 8 | 🔴 Underutilized |
| Commission Quest | 5 | 🔴 Underutilized |
| Valley Operations | 6 | 🟡 Partial |
| Resource Exploits | 4 | 🔴 Underutilized |
| Hidden Game Commands | 12 | 🔴 Not Used |
| Debug/Admin Commands | 6 | 🔴 Not Used |

---

## 🎯 TROOP GLITCHING COMMANDS

### Glitch Thresholds (32-bit Integer)

```python
# INT32_MAX = 2,147,483,647
# Glitch triggers at: INT32_MAX / food_cost + 1

GLITCH_THRESHOLDS = {
    "worker":      2147483648,   # 1 food = 2.1B troops
    "warrior":     2147483648,   # 1 food = 2.1B troops  
    "scout":       1073741824,   # 2 food = 1.07B troops
    "pikeman":      715827883,   # 3 food = 715M troops
    "swordsman":    715827883,   # 3 food = 715M troops
    "archer":       536870912,   # 4 food = 536M troops
    "cavalry":      238609295,   # 9 food = 238M troops
    "cataphract":   126322568,   # 17 food = 126M troops
    "transporter":  429496730,   # 5 food = 429M troops
    "ballista":      85899346,   # 25 food = 85M troops
    "ram":           42949673,   # 50 food = 42M troops
    "catapult":      17179870,   # 125 food = 17M troops
}
```

### Valley Glitch Thresholds (Half of City)

```python
VALLEY_GLITCH_THRESHOLDS = {
    "archer":       268435456,   # 268M for valley glitch
    "cavalry":      119304648,   # 119M for valley glitch
    "cataphract":    63161284,   # 63M for valley glitch
}
```

### Script Commands for Glitching

| Command | Syntax | Description |
|---------|--------|-------------|
| `set tc` | `set tc c.castle.troop` | Access troop bean |
| `set tv` | `set tv c.castle.troop` | Access valley troops |
| `cityManager.allTroop` | `$c.cityManager.allTroop.archer$` | Get all troop counts |
| `warLogMsg` | `$m_city.cityManager.warLogMsg(msg)$` | Output to war log |

---

## 💰 COMMISSION QUEST GLITCH COMMANDS

### Rapid 2B Troop Transfer

```
# Commission quest allows 2,000,000,000 troops per transfer
# Can be repeated rapidly without cooldown

COMMISSION_TRANSFER_MAX = 2_000_000_000

# Script command:
set transfer $commissionQuest.transfer(fromCity, toCity, troops)$
```

### Commission Quest Script Commands

| Command | Description |
|---------|-------------|
| `acceptCommission` | Accept commission quest |
| `completeCommission` | Complete and claim rewards |
| `cancelCommission` | Cancel without penalty |
| `refreshCommission` | Get new commission options |
| `commissionTransfer` | Transfer troops via commission |

---

## ⚡ THUNDER RAID VALLEY CLONING

### Mechanics

```python
# Valley Thunder Raid can multiply troops:
# - 1x: No effect (most common)
# - 2x: Troops doubled
# - 3x: Troops tripled (DANGEROUS if > 700M)

SAFE_TROOP_LIMIT = 700_000_000  # Max per type to avoid negative flip

# If 3x occurs on 800M troops:
# 800M * 3 = 2.4B > INT32_MAX (2.1B)
# Result: -1.7B troops (CITY LOCKED!)
```

### Valley Commands

| Command | Syntax | Description |
|---------|--------|-------------|
| `attackValley` | `attackValley x y troops hero` | Attack valley |
| `reinforceValley` | `reinforceValley x y troops` | Send to owned valley |
| `recallFromValley` | `recallFromValley valleyId` | Recall troops |
| `captureValley` | Automatic on attack win | Take ownership |
| `abandonValley` | `abandonValley valleyId` | Release valley |
| `thunderRaid` | Special attack type | Potential multiplication |

---

## 🔧 HIDDEN GAME COMMANDS (From Commands.as)

### Direct API Commands (Not in Standard Bot UI)

| Command | API Call | Purpose |
|---------|----------|---------|
| `speedUpResearch` | `tech.speedUpResearch` | Instant research |
| `speedUpBuilding` | `castle.speedUpBuilding` | Instant build |
| `speedUpTrain` | `troop.speedUpTrain` | Instant training |
| `useItem` | `item.useItem` | Use inventory items |
| `openChest` | `item.openChest` | Open reward chests |
| `spinWheel` | `fortune.spin` | Spin fortune wheel |
| `collectTax` | `castle.collectTax` | Collect taxes |
| `collectResources` | `resource.collect` | Collect all resources |
| `refreshMarket` | `trade.refreshMarket` | Refresh market offers |
| `buyFromMarket` | `trade.buy` | Purchase market items |
| `sellToMarket` | `trade.sell` | Sell resources |
| `gamble` | `gamble.spin` | Gambling feature |

### Admin/Debug Commands (May Require Special Access)

| Command | Purpose | Risk |
|---------|---------|------|
| `setResource` | Set resource amount | 🔴 High |
| `addTroops` | Add troops directly | 🔴 High |
| `setHeroStats` | Modify hero attributes | 🔴 High |
| `teleportCity` | Move city location | 🔴 High |
| `setGold` | Set gold amount | 🔴 High |
| `unlockAll` | Unlock all features | 🔴 High |

---

## 📜 SCRIPT ENGINE HIDDEN COMMANDS

### From Food Glitch Counter Script

```
# Variable access patterns:
set tc c.castle.troop           # Troop counts
set tv c.castle.troop           # Valley troops
$c.cm.resource.troopCostFood$   # Food consumption
$m_city.allCities.length$       # City count
$m_city.cityManager.warLogMsg$  # War log output

# Array operations:
setarray tNames ["wo", "w", "s", "p", "sw", "a", "c", "cata", "t", "b", "r", "cp"]
setarr fpt "1 1 2 3 3 4 9 17 5 25 50 125"  # Food per troop

# Control flow:
label labelName
goto labelName
gosub subroutineName
gosubreturn
iferror %var% defaultAction
```

### Advanced Script Commands

| Command | Syntax | Description |
|---------|--------|-------------|
| `setsilence` | `setsilence true` | Suppress output |
| `setarray` | `setarray name [values]` | Create array |
| `setarr` | `setarr name "space separated"` | Create array |
| `iferror` | `iferror %var% action` | Error handling |
| `label` | `label name` | Define jump target |
| `goto` | `goto name` | Jump to label |
| `gosub` | `gosub name` | Call subroutine |
| `gosubreturn` | `gosubreturn` | Return from gosub |
| `echo` | `echo "message"` | Output message |

---

## 🏰 CITY MANAGEMENT HIDDEN COMMANDS

### Resource Commands

| Command | Bean Access | Description |
|---------|-------------|-------------|
| `getFood` | `c.cm.resource.food` | Current food |
| `getWood` | `c.cm.resource.wood` | Current wood |
| `getStone` | `c.cm.resource.stone` | Current stone |
| `getIron` | `c.cm.resource.iron` | Current iron |
| `getGold` | `c.cm.resource.gold` | Current gold |
| `getProduction` | `c.cm.resource.foodProduction` | Production rate |
| `getConsumption` | `c.cm.resource.troopCostFood` | Food consumption |

### Building Commands

| Command | Description |
|---------|-------------|
| `upgradeBuilding slot level` | Upgrade specific building |
| `demolishBuilding slot` | Remove building |
| `cancelBuild` | Cancel current build |
| `getBuildQueue` | List pending builds |
| `getAvailableSlots` | Empty building slots |

### Research Commands

| Command | Description |
|---------|-------------|
| `research techName` | Start research |
| `cancelResearch` | Cancel current research |
| `getResearchQueue` | List pending research |
| `getTechLevel techName` | Current tech level |

---

## ⚔️ COMBAT HIDDEN COMMANDS

### Attack Options

| Command | Description |
|---------|-------------|
| `scoutPlayer x y` | Scout player city |
| `scoutNPC level` | Scout NPC |
| `attackWithHero heroId troops` | Attack with specific hero |
| `rallyAttack allianceId target` | Coordinated attack |
| `reinforceAlliance playerId` | Reinforce ally |
| `recallAll` | Recall all armies |

### NPC Farming

| Command | Description |
|---------|-------------|
| `findNPC level radius` | Find NPCs of level |
| `farmNPC level waves` | Continuous NPC farming |
| `scanMap x y radius` | Scan area for targets |
| `getArmyStatus` | Check marching armies |

---

## 🔄 MAINTENANCE EXPLOIT COMMANDS

### Valley Rolling at Maintenance

```
# Just before server maintenance:
# 1. Capture valleys
# 2. Server restarts
# 3. Valleys respawn with new levels
# 4. Potentially get level 10 valleys

# Script pattern:
loop 10
  scanMap %x% %y% 20
  for each valley
    if valley.level >= 8
      attackValley valley.x valley.y
    endif
  endfor
  wait 60
endloop
```

---

## 🎮 USAGE IN SVONY STUDIO

### Import Automation Module

```python
from src.automation import (
    get_troop_glitch_manager,
    get_exploit_manager,
    get_amf_commander,
    get_swarm_controller,
    TroopType,
    ExploitType,
)

# Troop Glitching
glitch_mgr = get_troop_glitch_manager()
thresholds = glitch_mgr.get_glitch_thresholds()
print(f"Archer glitch at: {thresholds['ARCHER']['city_threshold']:,}")

# Execute thunder raid clone
result = glitch_mgr.execute_thunder_raid_clone(
    city_id=1,
    valley_x=100,
    valley_y=200,
    troops={"archer": 500_000_000}  # Stay under 700M!
)

# Commission transfer
result = glitch_mgr.execute_commission_transfer(
    from_city=1,
    to_city=2,
    troops={"archer": 2_000_000_000}  # 2B max per transfer
)

# Detect locked city
lockout = glitch_mgr.detect_city_lockout(city_id=1)
if lockout["is_locked"]:
    recovery = glitch_mgr.recover_locked_city(1, lockout["locked_troops"])
```

---

## ⚠️ SAFETY LIMITS

| Limit | Value | Reason |
|-------|-------|--------|
| Safe Troop Max | 700,000,000 | Prevents 3x overflow |
| INT32 Max | 2,147,483,647 | 32-bit signed limit |
| Commission Max | 2,000,000,000 | Per transfer limit |
| Negative Threshold | -2,147,483,648 | City lockout trigger |

### Overflow Prevention

```python
# NEVER exceed 700M per troop type when cloning
# If you have 800M archers and get 3x:
# 800M * 3 = 2.4B > 2.1B max
# Result: Wraps to -1.7B = CITY LOCKED

# Safe practice:
MAX_SAFE = 700_000_000
if troop_count > MAX_SAFE:
    # Split to multiple cities first
    excess = troop_count - MAX_SAFE
    commission_transfer(excess, to_other_city)
```

---

*Document Version: 1.0.0 | For Svony Studio Integration*
