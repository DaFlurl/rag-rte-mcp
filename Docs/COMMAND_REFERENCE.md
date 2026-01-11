# Evony Age II - Complete Command Reference

> **"Protocol Commands"** - Full Command ID Mapping for Bot Development

---

## Overview

This document provides a complete mapping of Evony Age II protocol command IDs, parameters, and responses. Essential for building bots and understanding client-server communication.

---

## Command ID Ranges

| Range | Category | Description |
|-------|----------|-------------|
| 10000-10999 | Authentication | Login, logout, session |
| 20000-20999 | City | Building, resources, queues |
| 30000-30999 | Army | Troops, marches, combat |
| 40000-40999 | Alliance | Alliance operations |
| 50000-50999 | Map | World map, scouting |
| 60000-60999 | Chat | Messaging, mail |
| 70000-70999 | Quest | Quests, achievements |
| 80000-80999 | Shop | Items, purchases |
| 90000-90999 | System | Notifications, sync |

---

## Authentication Commands (10000-10999)

### `login.login` (10001)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "login.login",
    "username": str,           # Account username
    "password": str,           # MD5 hashed password
    "server": str,             # Server identifier (e.g., "svr12")
    "version": str,            # Client version
    "platform": str            # "flash" | "mobile"
}
```

**Response:**
```python
{
    "ok": bool,
    "data": {
        "playerId": int,
        "playerName": str,
        "sessionToken": str,
        "serverTime": int,     # Unix timestamp
        "playerData": {...}    # Full player state
    },
    "errorMsg": str            # If ok=false
}
```

### `login.loginSession` (10002)

**Direction:** Client → Server

**Purpose:** Reconnect using existing session token

**Parameters:**
```python
{
    "cmd": "login.loginSession",
    "sessionToken": str,
    "playerId": int
}
```

### `login.logout` (10003)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "login.logout"
}
```

### `login.keepAlive` (10010)

**Direction:** Client → Server

**Purpose:** Heartbeat every 30 seconds

**Parameters:**
```python
{
    "cmd": "login.keepAlive",
    "timestamp": int
}
```

---

## City Commands (20000-20999)

### `city.getInfo` (20001)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "city.getInfo",
    "cityId": int
}
```

**Response:**
```python
{
    "ok": true,
    "data": {
        "cityId": int,
        "name": str,
        "x": int,
        "y": int,
        "level": int,
        "population": int,
        "loyalty": int,
        "resources": {
            "gold": int,
            "food": int,
            "wood": int,
            "stone": int,
            "iron": int,
            "goldRate": int,
            "foodRate": int,
            "woodRate": int,
            "stoneRate": int,
            "ironRate": int
        },
        "buildings": [...],
        "troops": {...},
        "buildQueue": [...],
        "techQueue": [...]
    }
}
```

### `city.build` (20010)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "city.build",
    "cityId": int,
    "slot": int,              # Building slot (0-40)
    "buildingType": int       # Building type ID
}
```

**Building Type IDs:**
```python
BUILDING_TYPES = {
    1: "Cottage",
    2: "Barracks",
    3: "Warehouse",
    4: "Farm",
    5: "Sawmill",
    6: "Quarry",
    7: "Ironmine",
    8: "Academy",
    9: "Forge",
    10: "Workshop",
    11: "Stable",
    12: "Relief Station",
    13: "Rally Spot",
    14: "Beacon Tower",
    15: "Embassy",
    16: "Marketplace",
    17: "Inn",
    18: "Feasting Hall",
    19: "Town Hall",
    20: "Wall"
}
```

### `city.upgrade` (20011)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "city.upgrade",
    "cityId": int,
    "slot": int
}
```

### `city.demolish` (20012)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "city.demolish",
    "cityId": int,
    "slot": int
}
```

### `city.cancelBuild` (20013)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "city.cancelBuild",
    "cityId": int,
    "queueId": int
}
```

### `city.speedUpBuild` (20014)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "city.speedUpBuild",
    "cityId": int,
    "queueId": int,
    "itemId": int             # Speed-up item ID
}
```

---

## Research Commands (21000-21999)

### `tech.research` (21001)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "tech.research",
    "cityId": int,
    "techId": int
}
```

**Technology IDs:**
```python
TECH_IDS = {
    # Military
    1: "Military Science",
    2: "Military Tradition",
    3: "Iron Working",
    4: "Logistics",
    5: "Compass",
    6: "Horseback Riding",
    
    # Resource
    10: "Agriculture",
    11: "Lumbering",
    12: "Masonry",
    13: "Mining",
    
    # City
    20: "Construction",
    21: "Engineering",
    22: "Machinery",
    
    # Special
    30: "Medicine",
    31: "Archery",
    32: "Privateering",
    33: "Informatics"
}
```

### `tech.cancelResearch` (21002)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "tech.cancelResearch",
    "cityId": int
}
```

---

## Army Commands (30000-30999)

### `army.getInfo` (30001)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "army.getInfo",
    "cityId": int
}
```

### `army.train` (30010)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "army.train",
    "cityId": int,
    "troopType": int,
    "count": int
}
```

**Troop Type IDs:**
```python
TROOP_TYPES = {
    1: "Worker",
    2: "Warrior",
    3: "Scout",
    4: "Pikeman",
    5: "Swordsman",
    6: "Archer",
    7: "Cavalry",
    8: "Cataphract",
    9: "Transporter",
    10: "Ballista",
    11: "Battering Ram",
    12: "Catapult"
}
```

### `army.cancelTrain` (30011)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "army.cancelTrain",
    "cityId": int,
    "queueId": int
}
```

### `army.march` (30020)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "army.march",
    "cityId": int,
    "targetX": int,
    "targetY": int,
    "heroId": int,
    "troops": {
        "worker": int,
        "warrior": int,
        "scout": int,
        "pikeman": int,
        "swordsman": int,
        "archer": int,
        "cavalry": int,
        "cataphract": int,
        "transporter": int,
        "ballista": int,
        "ram": int,
        "catapult": int
    },
    "missionType": int,       # See mission types below
    "resource": {             # For transport missions
        "gold": int,
        "food": int,
        "wood": int,
        "stone": int,
        "iron": int
    }
}
```

**Mission Types:**
```python
MISSION_TYPES = {
    1: "Attack",
    2: "Reinforce",
    3: "Scout",
    4: "Transport",
    5: "Capture",
    6: "Conquer",
    7: "Occupy"
}
```

### `army.recall` (30021)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "army.recall",
    "marchId": int
}
```

### `army.scout` (30022)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "army.scout",
    "cityId": int,
    "targetX": int,
    "targetY": int,
    "scoutCount": int,
    "heroId": int              # Optional
}
```

### `army.attackNpc` (30030)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "army.attackNpc",
    "cityId": int,
    "npcId": int,              # NPC city ID
    "heroId": int,
    "troops": {...},
    "waves": int               # Number of attack waves
}
```

---

## Hero Commands (35000-35999)

### `hero.getList` (35001)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "hero.getList",
    "cityId": int
}
```

### `hero.recruit` (35010)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "hero.recruit",
    "cityId": int,
    "heroId": int              # Inn hero slot
}
```

### `hero.fire` (35011)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "hero.fire",
    "cityId": int,
    "heroId": int
}
```

### `hero.enhance` (35020)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "hero.enhance",
    "heroId": int,
    "attribute": int,          # 1=attack, 2=politics, 3=intel
    "amount": int
}
```

### `hero.rename` (35021)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "hero.rename",
    "heroId": int,
    "newName": str
}
```

---

## Alliance Commands (40000-40999)

### `alliance.getInfo` (40001)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "alliance.getInfo",
    "allianceId": int
}
```

### `alliance.create` (40010)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "alliance.create",
    "name": str,
    "description": str
}
```

### `alliance.join` (40011)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "alliance.join",
    "allianceId": int
}
```

### `alliance.leave` (40012)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "alliance.leave"
}
```

### `alliance.donate` (40020)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "alliance.donate",
    "resource": str,           # "gold", "food", etc.
    "amount": int
}
```

---

## Map Commands (50000-50999)

### `map.getTile` (50001)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "map.getTile",
    "x": int,
    "y": int
}
```

**Response:**
```python
{
    "ok": true,
    "data": {
        "x": int,
        "y": int,
        "type": int,           # Tile type
        "level": int,          # For NPCs/valleys
        "owner": {
            "playerId": int,
            "playerName": str,
            "allianceTag": str
        },
        "cityName": str        # If city
    }
}
```

**Tile Types:**
```python
TILE_TYPES = {
    0: "Flatland",
    1: "NPC City",
    2: "Player City",
    3: "Forest",
    4: "Desert",
    5: "Hill",
    6: "Lake",
    7: "Swamp",
    8: "Grassland"
}
```

### `map.getArea` (50002)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "map.getArea",
    "centerX": int,
    "centerY": int,
    "radius": int              # Typically 5-10
}
```

### `map.search` (50010)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "map.search",
    "searchType": int,         # 1=NPC, 2=Valley, 3=Player
    "level": int,              # Optional, filter by level
    "radius": int
}
```

---

## Chat Commands (60000-60999)

### `chat.send` (60001)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "chat.send",
    "channel": int,            # 1=World, 2=Alliance, 3=Whisper
    "message": str,
    "targetPlayerId": int      # For whisper
}
```

### `chat.receive` (60002)

**Direction:** Server → Client (Push)

**Data:**
```python
{
    "channel": int,
    "senderId": int,
    "senderName": str,
    "message": str,
    "timestamp": int
}
```

---

## Quest Commands (70000-70999)

### `quest.getList` (70001)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "quest.getList"
}
```

### `quest.accept` (70010)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "quest.accept",
    "questId": int
}
```

### `quest.complete` (70011)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "quest.complete",
    "questId": int
}
```

---

## Shop Commands (80000-80999)

### `shop.getItems` (80001)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "shop.getItems",
    "category": int
}
```

### `shop.buy` (80010)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "shop.buy",
    "itemId": int,
    "count": int
}
```

### `shop.useItem` (80020)

**Direction:** Client → Server

**Parameters:**
```python
{
    "cmd": "shop.useItem",
    "itemId": int,
    "cityId": int,             # If city-specific
    "targetId": int            # If targeted use
}
```

---

## Server Push Events (90000-90999)

### `event.attack` (90001)

**Direction:** Server → Client

**Data:**
```python
{
    "eventType": "attack",
    "attackerId": int,
    "attackerName": str,
    "targetCityId": int,
    "arrivalTime": int,
    "troops": {...}
}
```

### `event.buildComplete` (90002)

**Direction:** Server → Client

**Data:**
```python
{
    "eventType": "buildComplete",
    "cityId": int,
    "slot": int,
    "buildingType": int,
    "level": int
}
```

### `event.marchReturn` (90003)

**Direction:** Server → Client

**Data:**
```python
{
    "eventType": "marchReturn",
    "marchId": int,
    "loot": {...},
    "casualties": {...}
}
```

---

## Error Codes

```python
ERROR_CODES = {
    0: "Success",
    1: "Unknown Error",
    100: "Invalid Session",
    101: "Session Expired",
    102: "Already Logged In",
    200: "Invalid City",
    201: "City Not Owned",
    202: "Insufficient Resources",
    203: "Queue Full",
    204: "Building Requirements Not Met",
    300: "Insufficient Troops",
    301: "Hero Busy",
    302: "March Limit Reached",
    400: "Alliance Not Found",
    401: "Already In Alliance",
    500: "Rate Limited",
    501: "Maintenance Mode"
}
```

---

## Python Client Example

```python
from evony.protocol import EvonyClient

client = EvonyClient()
client.connect("svr12.evony.com", 443)

# Login
response = client.send({
    "cmd": "login.login",
    "username": "player",
    "password": "md5hash",
    "server": "svr12"
})

if response["ok"]:
    session = response["data"]["sessionToken"]
    
    # Get city info
    city = client.send({
        "cmd": "city.getInfo",
        "cityId": response["data"]["playerData"]["mainCityId"]
    })
    
    # Train troops
    client.send({
        "cmd": "army.train",
        "cityId": city["data"]["cityId"],
        "troopType": 6,  # Archer
        "count": 1000
    })
```

---

## Related Documentation

- `EVONY_PROTOCOL.md` - Protocol overview
- `formats/AMF_ENCODING.md` - AMF3 encoding details
- `BOT_SCRIPTING.md` - Bot automation
- `BATTLE_MECHANICS.md` - Combat formulas

---

*Document Version: 1.0.0 | Reverse-engineered from AutoEvony, RoboEvony, SPITFIRE*
