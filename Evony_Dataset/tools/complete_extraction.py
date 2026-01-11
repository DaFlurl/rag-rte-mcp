"""
ETK Complete 1:1 Account Extraction System

This module defines what data points are needed for a COMPLETE 1:1 extraction
of an Evony account. The extraction must be done via RoboEvony since only
it can login to Evony servers.

IMPORTANT: The old JSON files in khan_Accounts_556/accounts are OUTDATED (2-4 years old).
We need FRESH extraction by logging into each account.
"""

# ============================================================================
# COMPLETE 1:1 EXTRACTION DATA POINTS
# ============================================================================

EXTRACTION_SCHEMA = {
    # PLAYER INFO
    "player": {
        "userName": "Player display name",
        "id": "Player ID",
        "prestige": "Current prestige points",
        "honor": "Current honor points",
        "title": "Player title",
        "level": "Player level",
        "allianceId": "Alliance ID",
        "allianceName": "Alliance name",
        "allianceRank": "Rank in alliance",
        "gold": "Total gold across all cities",
        "gamblerLuckFace": "Gambler face setting",
        "buffs": "Active buffs list",
        "effortPoint": "Effort points",
        "redCount": "Red item count",
        "population": "Total population",
    },
    
    # CITIES (per city)
    "cities": {
        "id": "City ID",
        "name": "City name", 
        "fieldId": "Map position (y*800+x)",
        "state": "City state",
        "population": "Current population",
        "maxPopulation": "Max population",
        "loyalty": "Loyalty percentage",
        "grievance": "Grievance level",
        "tranquility": "Tranquility level",
        "isMainCity": "Is this the main city",
        "heroCount": "Number of heroes in city",
        "wallHp": "Wall HP",
        "wallLevel": "Wall level",
    },
    
    # RESOURCES (per city)
    "resources": {
        "gold": "Gold amount",
        "food": "Food amount", 
        "wood": "Lumber amount",
        "stone": "Stone amount",
        "iron": "Iron amount",
        "goldCapacity": "Gold storage capacity",
        "foodCapacity": "Food storage capacity",
        "woodCapacity": "Lumber storage capacity",
        "stoneCapacity": "Stone storage capacity",
        "ironCapacity": "Iron storage capacity",
        "goldProduction": "Gold production per hour",
        "foodProduction": "Food production per hour",
        "woodProduction": "Lumber production per hour",
        "stoneProduction": "Stone production per hour",
        "ironProduction": "Iron production per hour",
    },
    
    # TROOPS (per city) - ALL 12 types
    "troops": {
        "peasants": "Workers",
        "militia": "Warriors",
        "scouter": "Scouts",
        "pikemen": "Pikemen",
        "swordsmen": "Swordsmen",
        "archer": "Archers",
        "lightCavalry": "Cavalry",
        "heavyCavalry": "Cataphracts",
        "carriage": "Transporters",
        "ballista": "Ballistas",
        "batteringRam": "Battering Rams",
        "catapult": "Catapults",
    },
    
    # FORTIFICATIONS (per city)
    "fortifications": {
        "trap": "Traps",
        "abatis": "Abatis",
        "archerTower": "Archer Towers",
        "rollingLogs": "Rolling Logs",
        "defensiveTrebuchet": "Defensive Trebuchets",
        "rockfall": "Rockfalls",
    },
    
    # BUILDINGS (per city)
    "buildings": {
        "typeId": "Building type ID",
        "level": "Building level",
        "positionId": "Position in city",
        "status": "Building status",
        "startTime": "Construction start time",
        "endTime": "Construction end time",
    },
    
    # HEROES (per city)
    "heroes": {
        "id": "Hero ID",
        "name": "Hero name",
        "level": "Hero level",
        "experience": "Current XP",
        "experienceNeeded": "XP needed for next level",
        "loyalty": "Hero loyalty",
        "power": "Politics stat",
        "stratagem": "Attack stat",
        "management": "Intelligence stat",
        "basePower": "Base politics",
        "baseStratagem": "Base attack",
        "baseManagement": "Base intelligence",
        "status": "Hero status (idle/marching/etc)",
        "isMayor": "Is city mayor",
        "isMarshal": "Is army marshal",
        "isAvailable": "Is available",
        "grade": "Hero grade (Common/Uncommon/Rare/Epic/Legendary/Historic)",
        "heroType": "Hero type",
        "fightingForce": "Combat power",
        "energy": "Current energy",
        "maxEnergy": "Max energy",
        "speed": "Speed stat",
        "leadership": "Leadership stat",
        "equipments": "Equipped items list",
    },
    
    # ITEMS (inventory)
    "items": {
        "id": "Item ID",
        "name": "Item name",
        "count": "Quantity",
        "category": "Item category",
        "description": "Item description",
    },
    
    # RESEARCH/TECH
    "research": {
        "techId": "Research ID",
        "level": "Research level",
        "category": "Research category (military/agriculture/etc)",
    },
    
    # QUESTS
    "quests": {
        "questId": "Quest ID",
        "status": "Quest status",
        "progress": "Quest progress",
    },
    
    # VALLEYS/NPCs owned
    "valleys": {
        "fieldId": "Valley map position",
        "type": "Valley type (forest/lake/desert/etc)",
        "level": "Valley level",
    },
    
    # ARMIES (marching)
    "armies": {
        "armyId": "Army ID",
        "startFieldId": "Start position",
        "targetFieldId": "Target position",
        "troops": "Troops in army",
        "hero": "Hero leading",
        "arriveTime": "Arrival time",
        "missionType": "Mission type (attack/transport/etc)",
    },
    
    # ALLIANCE INFO
    "alliance": {
        "id": "Alliance ID",
        "name": "Alliance name",
        "rank": "Player rank in alliance",
        "prestige": "Alliance prestige",
        "members": "Member count",
    },
    
    # MAIL (optional)
    "mail": {
        "newMailCount": "Unread mail count",
    },
    
    # BUFFS
    "buffs": {
        "buffId": "Buff ID",
        "buffName": "Buff name",
        "endTime": "Buff expiration time",
    },
}

# Building type IDs
BUILDING_TYPES = {
    1: "Cottage",
    2: "Barracks",
    3: "Warehouse",
    4: "Sawmill",
    5: "Quarry", 
    6: "Ironmine",
    7: "Farm",
    8: "Embassy",
    9: "Academy",
    10: "Forge",
    11: "Workshop",
    12: "Feasting Hall",
    13: "Rally Spot",
    14: "Marketplace",
    15: "Relief Station",
    16: "Stable",
    17: "Inn",
    18: "Beacon Tower",
    19: "Town Hall",
    20: "Walls",
}

# Item categories
ITEM_CATEGORIES = [
    "chest",
    "speed_up",
    "resource",
    "troop",
    "hero",
    "buff",
    "special",
    "equipment",
    "other",
]


def generate_roboevony_extraction_script():
    """
    Generate a RoboEvony script that extracts ALL data points
    and saves to JSON file.
    """
    script = '''//===============================================================
// COMPLETE 1:1 ACCOUNT EXTRACTION SCRIPT v2.0
// Extracts ALL account data and saves to JSON file
// Run in RoboEvony while logged in
//===============================================================

setsilence true

// Output file path
set email $config.username$
set safeEmail "%email%".replace("@","_at_").replace(".","_")
set outputFile "D:\\EvonyToolKit\\data\\fresh_exports\\%safeEmail%.json"

// Start JSON
set json "{"

// Timestamp
set json "%json%\\"extraction_time\\":\\"%date% %time%\\","
set json "%json%\\"extractor_version\\":\\"2.0\\","

// PLAYER INFO
set json "%json%\\"player\\":{"
set json "%json%\\"email\\":\\"%email%\\","
set json "%json%\\"userName\\":\\"%player.userName%\\","
set json "%json%\\"id\\":%player.id%,"
set json "%json%\\"prestige\\":%player.prestige%,"
set json "%json%\\"honor\\":%player.honor%,"
set json "%json%\\"title\\":\\"%player.title%\\","
set json "%json%\\"allianceName\\":\\"%player.alliance%\\","
set json "%json%\\"allianceId\\":%player.allianceId%,"
set json "%json%\\"gold\\":%player.gold%"
set json "%json%},"

// CITIES ARRAY
set json "%json%\\"cities\\":["
set cityIndex 0

label CityLoop
iferror $cities[%cityIndex%].name$ goto EndCities
if {%cityIndex%>0} set json "%json%,"

// City object
set json "%json%{"
set json "%json%\\"name\\":\\"%cities[%cityIndex%].name%\\","
set json "%json%\\"id\\":%cities[%cityIndex%].id%,"
set json "%json%\\"x\\":%cities[%cityIndex%].x%,"
set json "%json%\\"y\\":%cities[%cityIndex%].y%,"
set json "%json%\\"fieldId\\":%cities[%cityIndex%].fieldId%,"
set json "%json%\\"population\\":%cities[%cityIndex%].population%,"
set json "%json%\\"loyalty\\":%cities[%cityIndex%].loyalty%,"

// Resources
set json "%json%\\"resources\\":{"
set json "%json%\\"gold\\":%cities[%cityIndex%].resource.gold%,"
set json "%json%\\"food\\":%cities[%cityIndex%].resource.food%,"
set json "%json%\\"wood\\":%cities[%cityIndex%].resource.wood%,"
set json "%json%\\"stone\\":%cities[%cityIndex%].resource.stone%,"
set json "%json%\\"iron\\":%cities[%cityIndex%].resource.iron%,"
set json "%json%\\"goldCapacity\\":%cities[%cityIndex%].resource.goldCapacity%,"
set json "%json%\\"foodCapacity\\":%cities[%cityIndex%].resource.foodCapacity%,"
set json "%json%\\"woodCapacity\\":%cities[%cityIndex%].resource.woodCapacity%,"
set json "%json%\\"stoneCapacity\\":%cities[%cityIndex%].resource.stoneCapacity%,"
set json "%json%\\"ironCapacity\\":%cities[%cityIndex%].resource.ironCapacity%"
set json "%json%},"

// Troops
set json "%json%\\"troops\\":{"
set json "%json%\\"peasants\\":%cities[%cityIndex%].troop.peasants%,"
set json "%json%\\"militia\\":%cities[%cityIndex%].troop.militia%,"
set json "%json%\\"scouter\\":%cities[%cityIndex%].troop.scouter%,"
set json "%json%\\"pikemen\\":%cities[%cityIndex%].troop.pikemen%,"
set json "%json%\\"swordsmen\\":%cities[%cityIndex%].troop.swordsmen%,"
set json "%json%\\"archer\\":%cities[%cityIndex%].troop.archer%,"
set json "%json%\\"lightCavalry\\":%cities[%cityIndex%].troop.lightCavalry%,"
set json "%json%\\"heavyCavalry\\":%cities[%cityIndex%].troop.heavyCavalry%,"
set json "%json%\\"carriage\\":%cities[%cityIndex%].troop.carriage%,"
set json "%json%\\"ballista\\":%cities[%cityIndex%].troop.ballista%,"
set json "%json%\\"batteringRam\\":%cities[%cityIndex%].troop.batteringRam%,"
set json "%json%\\"catapult\\":%cities[%cityIndex%].troop.catapult%"
set json "%json%},"

// Fortifications
set json "%json%\\"fortifications\\":{"
set json "%json%\\"trap\\":%cities[%cityIndex%].fortification.trap%,"
set json "%json%\\"abatis\\":%cities[%cityIndex%].fortification.abatis%,"
set json "%json%\\"archerTower\\":%cities[%cityIndex%].fortification.archerTower%,"
set json "%json%\\"rollingLogs\\":%cities[%cityIndex%].fortification.rollingLogs%,"
set json "%json%\\"defensiveTrebuchet\\":%cities[%cityIndex%].fortification.defensiveTrebuchet%"
set json "%json%}"

set json "%json%}"

set cityIndex {%cityIndex%+1}
goto CityLoop

label EndCities
set json "%json%],"

// HEROES ARRAY
set json "%json%\\"heroes\\":["
set heroIndex 0

label HeroLoop
iferror $heroes[%heroIndex%].name$ goto EndHeroes
if {%heroIndex%>0} set json "%json%,"

set json "%json%{"
set json "%json%\\"name\\":\\"%heroes[%heroIndex%].name%\\","
set json "%json%\\"id\\":%heroes[%heroIndex%].id%,"
set json "%json%\\"level\\":%heroes[%heroIndex%].level%,"
set json "%json%\\"experience\\":%heroes[%heroIndex%].experience%,"
set json "%json%\\"loyalty\\":%heroes[%heroIndex%].loyalty%,"
set json "%json%\\"power\\":%heroes[%heroIndex%].power%,"
set json "%json%\\"stratagem\\":%heroes[%heroIndex%].stratagem%,"
set json "%json%\\"management\\":%heroes[%heroIndex%].management%,"
set json "%json%\\"basePower\\":%heroes[%heroIndex%].basePower%,"
set json "%json%\\"baseStratagem\\":%heroes[%heroIndex%].baseStratagem%,"
set json "%json%\\"baseManagement\\":%heroes[%heroIndex%].baseManagement%,"
set json "%json%\\"grade\\":\\"%heroes[%heroIndex%].grade%\\","
set json "%json%\\"status\\":\\"%heroes[%heroIndex%].status%\\","
set json "%json%\\"isMayor\\":%heroes[%heroIndex%].isMayor%,"
set json "%json%\\"city\\":\\"%heroes[%heroIndex%].city%\\""
set json "%json%}"

set heroIndex {%heroIndex%+1}
goto HeroLoop

label EndHeroes
set json "%json%],"

// ITEMS ARRAY
set json "%json%\\"items\\":["
set itemIndex 0

label ItemLoop
iferror $items[%itemIndex%].id$ goto EndItems
if {%itemIndex%>0} set json "%json%,"

set json "%json%{\\"id\\":\\"%items[%itemIndex%].id%\\",\\"name\\":\\"%items[%itemIndex%].name%\\",\\"count\\":%items[%itemIndex%].count%}"

set itemIndex {%itemIndex%+1}
if {%itemIndex%>1000} goto EndItems
goto ItemLoop

label EndItems
set json "%json%]"

// Close main JSON
set json "%json%}"

// Save to file
echo "Saving to: %outputFile%"
savefile "%outputFile%" "%json%"
echo "EXTRACTION COMPLETE!"
echo "Saved: %outputFile%"

setsilence false
'''
    return script


# What's MISSING from old JSON files:
MISSING_FROM_OLD_JSON = [
    "fortifications (traps, abatis, archer towers, etc)",
    "building levels and positions",
    "research/technology levels",
    "hero equipment slots",
    "hero energy and speed stats",
    "resource production rates",
    "valley/NPC ownership",
    "marching armies",
    "alliance details",
    "buff timers",
    "quest progress",
    "mail counts",
    "wall HP and level per city",
]


if __name__ == '__main__':
    # Generate and save the extraction script
    script = generate_roboevony_extraction_script()
    
    output_path = r"D:\EvonyToolKit\scripts\extraction\complete_extraction_v2.txt"
    with open(output_path, 'w') as f:
        f.write(script)
    
    print(f"Generated extraction script: {output_path}")
    print(f"\nMissing from old JSON files:")
    for item in MISSING_FROM_OLD_JSON:
        print(f"  - {item}")
