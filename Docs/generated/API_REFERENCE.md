# Evony Protocol API Reference

> Auto-generated documentation for Evony client-server protocol

## Overview

The Evony protocol uses AMF (Action Message Format) over HTTP for client-server communication.
All commands follow the pattern: `category.command`

---

## Command Categories

| Category | Description | Example |
|----------|-------------|---------|
| `common` | Login, server info | `common.login` |
| `castle` | Castle management | `castle.getAvailableBuildingListInside` |
| `city` | City operations | `city.modifyCityName` |
| `hero` | Hero management | `hero.tryGetSeizedHero` |
| `army` | Military commands | `army.newArmy` |
| `troop` | Troop training | `troop.produceTroop` |
| `tech` | Research | `tech.research` |
| `alliance` | Alliance ops | `alliance.create` |
| `fortifications` | Defenses | `fortifications.produceWallProtect` |
| `quest` | Quest system | `quest.award` |
| `shop` | Item shop | `shop.buy` |
| `trade` | Trading | `trade.newTrade` |
| `field` | World map | `field.getOtherFieldInfo` |

---

## Core Commands

### army.newArmy
Create a new army for attack or transport.

**Parameters:**
| Name | Type | Description |
|------|------|-------------|
| `heroId` | int | Hero leading the army |
| `castleId` | int | Source castle ID |
| `targetPoint` | int | Target coordinates (x * 1000 + y) |
| `missionType` | int | 1=attack, 2=transport, 3=scout, 4=reinforce |
| `troops` | Object | Troop composition (troopType: count) |
| `resources` | Object | Resources to send (optional) |

**Response:** `army.newArmyResponse`
- `ok`: 1 if success
- `errorCode`: Error code if failed
- `army`: ArmyBean with army details

**Error Codes:**
- `-1`: Invalid hero
- `-2`: Insufficient troops
- `-3`: Hero busy
- `-10`: Target invalid

---

### troop.produceTroop
Train troops in barracks.

**Parameters:**
| Name | Type | Description |
|------|------|-------------|
| `castleId` | int | Castle ID |
| `troopType` | int | Type of troop (see TroopType) |
| `num` | int | Number to train |
| `queueId` | int | Queue slot (0-4) |

**Troop Types:**

1 = Worker, 2 = Warrior, 3 = Scout, 4 = Pikeman,
5 = Swordsman, 6 = Archer, 7 = Cavalry, 8 = Cataphract,
9 = Transporter, 10 = Ballista, 11 = Ram, 12 = Catapult

**Error Codes:**
- `-1`: Invalid castle
- `-2`: Insufficient resources
- `-3`: Queue full
- `-4`: Barracks level too low

---

### castle.getAvailableBuildingListInside
Get buildable structures for castle interior.

**Parameters:**
| Name | Type | Description |
|------|------|-------------|
| `castleId` | int | Castle ID |

**Response:** Array of BuildingBean objects

---

### hero.tryGetSeizedHero
Attempt to capture NPC hero.

**Parameters:**
| Name | Type | Description |
|------|------|-------------|
| `heroId` | int | Target hero ID |
| `castleId` | int | Destination castle |

**Error Codes:**
- `-1`: Hero not available
- `-2`: No free hero slot
- `-51`: Already captured

---

### tech.research
Start research on technology.

**Parameters:**
| Name | Type | Description |
|------|------|-------------|
| `castleId` | int | Castle ID |
| `techType` | int | Technology type |

**Tech Types:**

Military: 1-10, Infrastructure: 11-20, Commerce: 21-30, Medicine: 31-40

---

## Bean Classes

### PlayerInfoBean
Player account information.

| Field | Type | Description |
|-------|------|-------------|
| `id` | int | Player ID |
| `name` | String | Player name |
| `level` | int | Player level |
| `prestige` | int | Prestige points |
| `honor` | int | Honor points |
| `gold` | int | Gold balance |
| `gems` | int | Gem balance |
| `allianceId` | int | Alliance ID (0 if none) |

### CastleBean
Castle/city data.

| Field | Type | Description |
|-------|------|-------------|
| `id` | int | Castle ID |
| `name` | String | Castle name |
| `level` | int | Town Hall level |
| `x` | int | X coordinate |
| `y` | int | Y coordinate |
| `resource` | ResourceBean | Current resources |
| `buildings` | Array | BuildingBean array |
| `heroes` | Array | HeroBean array |

### HeroBean
Hero information.

| Field | Type | Description |
|-------|------|-------------|
| `id` | int | Hero ID |
| `name` | String | Hero name |
| `level` | int | Hero level |
| `experience` | int | Current XP |
| `politics` | int | Politics stat |
| `attack` | int | Attack stat |
| `intelligence` | int | Intelligence stat |
| `status` | int | 0=idle, 1=mayor, 2=fighting... |

### ArmyBean
Army/march data.

| Field | Type | Description |
|-------|------|-------------|
| `id` | int | Army ID |
| `heroId` | int | Leading hero |
| `startX` | int | Origin X |
| `startY` | int | Origin Y |
| `targetX` | int | Target X |
| `targetY` | int | Target Y |
| `missionType` | int | Mission type |
| `troops` | Object | Troop composition |
| `arriveTime` | long | Arrival timestamp |

---

## Error Code Reference

| Code | Constant | Description |
|------|----------|-------------|
| `-1` | INVALID_PARAM | Invalid parameter |
| `-2` | INSUFFICIENT_RESOURCE | Not enough resources |
| `-3` | BUSY | Target is busy |
| `-4` | LEVEL_TOO_LOW | Level requirement not met |
| `-10` | INVALID_TARGET | Target doesn't exist |
| `-50` | PERMISSION_DENIED | No permission |
| `-51` | ALREADY_EXISTS | Already done |
| `-52` | ALLIANCE_NOT_FOUND | Alliance doesn't exist |
| `-100` | SERVER_ERROR | Internal server error |

---

## Response Handlers

All responses are dispatched through `ResponseDispatcher.as`:

Response handlers are mapped in ResponseDispatcher.as to callback functions
like onNewArmyResponse, onProduceResponse, onGetBuildingListResponse, etc.

---

*Generated: 2026-01-05T10:37:53.978129*
