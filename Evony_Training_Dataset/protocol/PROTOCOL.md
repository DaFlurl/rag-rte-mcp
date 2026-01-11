# BORG TOOLKIT - Protocol Reference

> Complete AMF protocol documentation extracted from Evony client source

---

## Protocol Overview

Evony uses **AMF (Action Message Format)** over TCP sockets for client-server communication.

```
┌─────────────────────────────────────────────────────────────────┐
│                    EVONY PROTOCOL STACK                         │
├─────────────────────────────────────────────────────────────────┤
│  Application Layer  │  Game Commands (troop.*, shop.*, etc.)   │
├─────────────────────┼───────────────────────────────────────────┤
│  Serialization      │  AMF3 (Action Message Format)            │
├─────────────────────┼───────────────────────────────────────────┤
│  Framing            │  4-byte length prefix (Big Endian)       │
├─────────────────────┼───────────────────────────────────────────┤
│  Transport          │  TCP Socket                               │
├─────────────────────┼───────────────────────────────────────────┤
│  Network            │  IP                                       │
└─────────────────────┴───────────────────────────────────────────┘
```

---

## Packet Structure

### Request Packet

```
┌──────────────┬────────────────────────────────────────────────────┐
│   4 bytes    │                  N bytes                           │
│  (length)    │               (AMF payload)                        │
├──────────────┼────────────────────────────────────────────────────┤
│  Big-Endian  │  {                                                 │
│   uint32     │    "cmd": "command.name",                          │
│              │    "data": {                                       │
│              │      "param1": value1,                             │
│              │      "param2": value2                              │
│              │    }                                               │
│              │  }                                                 │
└──────────────┴────────────────────────────────────────────────────┘
```

### Response Packet

```
┌──────────────┬────────────────────────────────────────────────────┐
│   4 bytes    │                  N bytes                           │
│  (length)    │               (AMF payload)                        │
├──────────────┼────────────────────────────────────────────────────┤
│  Big-Endian  │  {                                                 │
│   uint32     │    "cmd": "command.name",                          │
│              │    "ok": 1,  // 1 = success, -1 = error            │
│              │    "errorMsg": "",                                 │
│              │    "packageId": 12345,                             │
│              │    "data": { ... }                                 │
│              │  }                                                 │
└──────────────┴────────────────────────────────────────────────────┘
```

---

## Command Categories

### Troop Commands (`troop.*`)

| Command | Parameters | Description |
|---------|------------|-------------|
| `troop.produceTroop` | castleId, positionId, troopType, num, isShare, toIdle | Train troops |
| `troop.cancelTroopProduce` | castleId, positionId, queueId | Cancel training |
| `troop.disbandTroop` | castleId, troopType, num | Disband troops |
| `troop.getProduceQueue` | castleId | Get training queue |
| `troop.accTroopProduce` | castleId, positionId, queueId, itemId | Speed up training |

### Shop Commands (`shop.*`)

| Command | Parameters | Description |
|---------|------------|-------------|
| `shop.buy` | itemId, amount | Purchase item |
| `shop.useGoods` | castleId, itemId, num | Use item |
| `shop.buyResource` | castleId, foodUse, woodUse, ironUse, stoneUse | Buy resources |
| `shop.useDevilItem` | x, y, itemId, paramdata | Use devil item |
| `shop.useAngelItem` | playername, itemId | Use angel item |

### Army Commands (`army.*`)

| Command | Parameters | Description |
|---------|------------|-------------|
| `army.newArmy` | castleId, newArmyBean | Create army |
| `army.callBackArmy` | castleId, armyId | Recall army |
| `army.setArmyGoOut` | castleId, armyId, goOutType | Set march |
| `army.speedUpArmy` | armyId, itemId | Speed up army |

### Common Commands (`common.*`)

| Command | Parameters | Description |
|---------|------------|-------------|
| `common.getPackage` | ruleId, serial | Claim package |
| `common.getPackageList` | - | List packages |
| `common.mapInfo` | x, y | Get map info |
| `common.privateChat` | targetName, msg | Private message |
| `common.worldChat` | msg | World chat |

### Security Commands (`common.*`)

| Command | Parameters | Description |
|---------|------------|-------------|
| `common.setSecurityCode` | code | Set PIN |
| `common.authSecurityCode` | code | Verify PIN |
| `common.removeSecurityCode` | - | Remove PIN |
| `common.changeSecurityCode` | curCode, newCode | Change PIN |

### Interior Commands (`interior.*`)

| Command | Parameters | Description |
|---------|------------|-------------|
| `interior.taxLevy` | castleId | Collect taxes |
| `interior.comforting` | castleId, type | Comfort population |
| `interior.getPopulationInfo` | castleId | Get population info |

### Colony Commands (`colony.*`)

| Command | Parameters | Description |
|---------|------------|-------------|
| `colony.levyResource` | castleId, colonyId, type | Levy resources |
| `colony.levyArmy` | castleId, colonyId | Levy troops |
| `colony.getAllColonies` | castleId | List colonies |

### Quest Commands (`quest.*`)

| Command | Parameters | Description |
|---------|------------|-------------|
| `quest.getQuestList` | castleId | List quests |
| `quest.award` | castleId, questId | Claim reward |
| `quest.getAwardItems` | questId | Preview reward |

---

## Data Types

### Troop Types

| ID | Name | Food Cost | Overflow Threshold |
|----|------|-----------|-------------------|
| 1 | Worker | 50 | 42,949,673 |
| 2 | Warrior | 75 | 28,633,116 |
| 3 | Scout | 100 | 21,474,837 |
| 4 | Pikeman | 200 | 10,737,419 |
| 5 | Swordsman | 250 | 8,589,935 |
| 6 | Archer | 350 | 6,135,037 |
| 7 | Cavalry | 800 | 2,684,355 |
| 8 | Cataphract | 1500 | 1,431,656 |
| 9 | Transporter | 300 | 7,158,279 |
| 10 | Ballista | 2000 | 1,073,742 |
| 11 | Ram | 2500 | 858,994 |
| 12 | Catapult | 3000 | 715,828 |

### Resource Types

| ID | Name |
|----|------|
| 0 | Gold |
| 1 | Food |
| 2 | Wood |
| 3 | Stone |
| 4 | Iron |

### Mission Types

| ID | Name |
|----|------|
| 1 | Attack |
| 2 | Reinforce |
| 3 | Transport |
| 4 | Scout |
| 5 | Occupy |

---

## Error Codes

| Code | Description |
|------|-------------|
| -1 | General error |
| -2 | Invalid parameters |
| -3 | Insufficient resources |
| -4 | Insufficient troops |
| -5 | Building occupied |
| -6 | Queue full |
| -7 | Level too low |
| -8 | Already in progress |
| -99 | Server error |

---

## Authentication

### Login Flow

```
1. Client → Server: VERSION_COMMAND
2. Server → Client: Version OK
3. Client → Server: LOGIN_COMMAND (email, password_hash)
4. Server → Client: Session token + player data
```

### Password Hashing

```python
password_hash = MD5(password + "evony")
```

### Action Signatures

```python
signature = MD5(command + json_params + ACTION_KEY)

ACTION_KEY = "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"
```

---

## Session Management

### Session Token

Received after successful login. Must be included in subsequent requests.

### Keepalive

Client sends periodic keepalive packets to maintain connection:
```python
common.step()  # Every 30 seconds
```

---

## Rate Limiting

Observed limits (may vary by server):
- Commands: ~10 per second
- Chat: ~1 per 3 seconds  
- Army dispatch: ~1 per 2 seconds

---

*Last Updated: 2026-01-03*
*Source: EvonyClient1921.swf decompilation*
