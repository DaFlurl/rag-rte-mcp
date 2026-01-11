#!/usr/bin/env python3
"""
Generate Protocol Training Data for Evony
Target: 750+ examples covering commands, packets, encryption
"""

import json
from pathlib import Path

SCRIPT_DIR = Path(__file__).parent
OUTPUT_FILE = SCRIPT_DIR / "train_protocol.jsonl"

SYSTEM_PROMPT = """You are an expert in Evony game internals, ActionScript 3 programming, and the AutoEvony bot framework. You have complete knowledge of:
- The AMF3 protocol structure
- All 301+ game commands
- Packet encryption/decryption
- Request/response patterns

Provide accurate, technical responses with exact command syntax."""

def create_example(question, answer):
    return {
        "messages": [
            {"role": "system", "content": SYSTEM_PROMPT},
            {"role": "user", "content": question},
            {"role": "assistant", "content": answer}
        ]
    }

examples = []

# ============================================================================
# AMF PROTOCOL STRUCTURE
# ============================================================================

examples.append(create_example(
    "What is the Evony AMF protocol structure?",
    """The Evony AMF protocol uses Action Message Format 3 (AMF3) for client-server communication:

**Packet Structure:**
```
[Header: 5 bytes][Body: variable]
```

**Header Format:**
- Byte 0: Protocol version (0x01)
- Bytes 1-4: Body length (big-endian uint32)

**Body Format:**
- AMF3 encoded data containing:
  - `cmd`: Command string (e.g., "army.sendArmy")
  - `data`: Command parameters object
  - `seq`: Sequence number for request/response matching

**Example Request:**
```
{
  "cmd": "city.getStoreList",
  "data": {"castleId": 12345},
  "seq": 1
}
```"""
))

examples.append(create_example(
    "How does Evony encrypt protocol data?",
    """Evony uses AES-128 encryption in CBC mode:

**Encryption Details:**
- Algorithm: AES-128
- Mode: CBC (Cipher Block Chaining)
- Padding: PKCS5
- Key: Derived from session handshake
- IV: MD5 hash of key + zeros

**Encryption Flow:**
1. Serialize data to AMF3 format
2. Apply PKCS5 padding
3. Encrypt with AES-128-CBC
4. Base64 encode result

**Decryption Flow:**
1. Base64 decode received data
2. Decrypt with AES-128-CBC
3. Remove PKCS5 padding
4. Deserialize AMF3 to object

**Code Example:**
```actionscript
var encrypted:String = CryptoJS.AES.encrypt(
    data,
    key,
    {iv: iv, mode: CryptoJS.mode.CBC, padding: CryptoJS.pad.Pkcs7}
).toString();
```"""
))

# ============================================================================
# COMMAND CATEGORIES
# ============================================================================

command_categories = {
    "army": {
        "desc": "Troop movement, attacks, and army management",
        "commands": [
            ("sendArmy", "Send army to target", "castleId, heroId, troops[], targetX, targetY, missionType"),
            ("callBackArmy", "Recall army", "armyId"),
            ("getArmyInfo", "Get army details", "armyId"),
            ("disbandArmy", "Disband army", "armyId"),
            ("speedUpArmy", "Use item to speed army", "armyId, itemId"),
        ]
    },
    "building": {
        "desc": "Construction and upgrades",
        "commands": [
            ("construct", "Build new building", "castleId, positionId, buildingType"),
            ("upgrade", "Upgrade building", "castleId, positionId"),
            ("demolish", "Demolish building", "castleId, positionId"),
            ("speedUp", "Speed up construction", "castleId, positionId, itemId"),
            ("cancelBuilding", "Cancel construction", "castleId, positionId"),
        ]
    },
    "city": {
        "desc": "City management and information",
        "commands": [
            ("getStoreList", "Get warehouse contents", "castleId"),
            ("getCastleInfo", "Get city information", "castleId"),
            ("modifyFlag", "Change city flag", "castleId, flagType"),
            ("comfort", "Perform comfort action", "castleId, comfortType"),
            ("levy", "Collect taxes", "castleId"),
        ]
    },
    "hero": {
        "desc": "Hero recruitment and management",
        "commands": [
            ("getHeroList", "List all heroes", "castleId"),
            ("fireHero", "Dismiss hero", "castleId, heroId"),
            ("promoteHero", "Promote hero", "castleId, heroId"),
            ("refreshHeroList", "Refresh inn heroes", "castleId"),
            ("hireHero", "Hire hero from inn", "castleId, heroId"),
            ("changeName", "Rename hero", "castleId, heroId, newName"),
        ]
    },
    "alliance": {
        "desc": "Alliance operations",
        "commands": [
            ("getAllianceInfo", "Get alliance details", "allianceId"),
            ("createAlliance", "Create new alliance", "name, description"),
            ("joinAlliance", "Request to join", "allianceId"),
            ("leaveAlliance", "Leave alliance", ""),
            ("kickMember", "Kick member", "playerId"),
            ("promoteOfficer", "Promote to officer", "playerId, rank"),
        ]
    },
    "mail": {
        "desc": "Messaging system",
        "commands": [
            ("getMail", "Get mail list", "pageNo, mailType"),
            ("readMail", "Read mail", "mailId"),
            ("sendMail", "Send mail", "toPlayer, subject, content"),
            ("deleteMail", "Delete mail", "mailId"),
            ("reportMail", "Report spam", "mailId"),
        ]
    },
    "quest": {
        "desc": "Quests and achievements",
        "commands": [
            ("getQuestList", "Get available quests", "castleId"),
            ("acceptQuest", "Accept quest", "castleId, questId"),
            ("completeQuest", "Complete quest", "castleId, questId"),
            ("getAchievements", "Get achievements", ""),
        ]
    },
    "shop": {
        "desc": "Item shop and inventory",
        "commands": [
            ("getShopList", "Get shop items", "shopType"),
            ("buyItem", "Purchase item", "itemId, quantity"),
            ("useItem", "Use item", "castleId, itemId"),
            ("getInventory", "Get inventory", ""),
        ]
    },
    "trade": {
        "desc": "Market trading",
        "commands": [
            ("getMarketList", "Get market offers", "castleId, resourceType"),
            ("createOffer", "Create trade offer", "castleId, sellType, sellAmount, buyType, buyAmount"),
            ("acceptOffer", "Accept offer", "offerId"),
            ("cancelOffer", "Cancel offer", "offerId"),
        ]
    },
    "fortifications": {
        "desc": "Defense building",
        "commands": [
            ("buildFort", "Build fortification", "castleId, fortType, amount"),
            ("getFortList", "Get fortifications", "castleId"),
            ("repairWall", "Repair wall", "castleId"),
        ]
    },
    "tech": {
        "desc": "Technology research",
        "commands": [
            ("research", "Start research", "castleId, techId"),
            ("cancelResearch", "Cancel research", "castleId"),
            ("speedUpResearch", "Speed up research", "castleId, itemId"),
            ("getTechList", "Get tech tree", "castleId"),
        ]
    },
}

for category, info in command_categories.items():
    # Category overview
    examples.append(create_example(
        f"What commands are in the {category}.* category?",
        f"The `{category}.*` category handles {info['desc']}.\n\n**Available Commands:**\n" +
        "\n".join([f"- `{category}.{cmd[0]}` - {cmd[1]}" for cmd in info['commands']])
    ))
    
    # Individual commands
    for cmd_name, cmd_desc, cmd_params in info['commands']:
        examples.append(create_example(
            f"What is the {category}.{cmd_name} command?",
            f"`{category}.{cmd_name}` - {cmd_desc}\n\n**Parameters:** {cmd_params}\n\n**Example Request:**\n```json\n{{\n  \"cmd\": \"{category}.{cmd_name}\",\n  \"data\": {{}},\n  \"seq\": 1\n}}\n```"
        ))

# ============================================================================
# PACKET EXAMPLES
# ============================================================================

examples.append(create_example(
    "Show me an example army.sendArmy request packet",
    """**army.sendArmy Request:**

```json
{
  "cmd": "army.sendArmy",
  "data": {
    "castleId": 12345,
    "heroId": 67890,
    "troops": [
      {"type": 7, "amount": 1000},
      {"type": 8, "amount": 500}
    ],
    "targetX": 150,
    "targetY": 200,
    "missionType": 5
  },
  "seq": 42
}
```

**Parameters Explained:**
- `castleId`: Source city ID
- `heroId`: Leading hero ID
- `troops`: Array of {type: TFConstants, amount}
- `targetX/Y`: World map coordinates
- `missionType`: ObjConstants.ARMY_MISSION_* (5 = attack)

**Expected Response:**
```json
{
  "cmd": "army.sendArmy",
  "result": 0,
  "data": {
    "armyId": 99999,
    "arrivalTime": 1234567890
  },
  "seq": 42
}
```"""
))

examples.append(create_example(
    "Show me an example building.construct request",
    """**building.construct Request:**

```json
{
  "cmd": "building.construct",
  "data": {
    "castleId": 12345,
    "positionId": 8,
    "buildingType": 2
  },
  "seq": 15
}
```

**Parameters:**
- `castleId`: City to build in
- `positionId`: Slot number (0-31 inside, 0-40 outside)
- `buildingType`: BuildingConstants type (2 = Cottage)

**Response (Success):**
```json
{
  "cmd": "building.construct",
  "result": 0,
  "data": {
    "completionTime": 1234567890,
    "queueSlot": 1
  },
  "seq": 15
}
```

**Response (Error):**
```json
{
  "cmd": "building.construct",
  "result": -4,
  "seq": 15
}
```
Result -4 = BUILD_POSITION_NOT_IDLE"""
))

# ============================================================================
# NETWORKING CLASSES
# ============================================================================

examples.append(create_example(
    "How does GameClient.as handle server connections?",
    """GameClient.as manages server connections using the Socket class:

**Connection Flow:**
1. Create Socket instance
2. Add event listeners (CONNECT, IO_ERROR, CLOSE)
3. Call socket.connect(host, port)
4. On connect, perform handshake
5. Begin AMF communication

**Key Methods:**
```actionscript
public class GameClient {
    private var socket:Socket;
    
    public function connect(host:String, port:int):void {
        socket = new Socket();
        socket.addEventListener(Event.CONNECT, onConnect);
        socket.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
        socket.connect(host, port);
    }
    
    private function onConnect(e:Event):void {
        // Handshake
        sendHandshake();
    }
    
    public function send(cmd:String, data:Object):void {
        var packet:ByteArray = AMFSerializer.encode({
            cmd: cmd,
            data: data,
            seq: nextSeq++
        });
        socket.writeBytes(packet);
        socket.flush();
    }
}
```"""
))

examples.append(create_example(
    "What is the CommMgr class in Evony?",
    """CommMgr (Communication Manager) coordinates all network communication:

**Responsibilities:**
1. Queue outgoing requests
2. Match responses to requests by sequence number
3. Handle timeouts and retries
4. Dispatch responses to handlers

**Structure:**
```actionscript
public class CommMgr {
    private var pendingRequests:Dictionary;
    private var requestQueue:Array;
    private var socket:GameSocket;
    
    public function sendRequest(cmd:String, data:Object, 
                                callback:Function):void {
        var seq:int = nextSequence++;
        pendingRequests[seq] = {
            cmd: cmd,
            callback: callback,
            timestamp: getTimer()
        };
        socket.send(cmd, data, seq);
    }
    
    public function handleResponse(response:Object):void {
        var pending:Object = pendingRequests[response.seq];
        if (pending) {
            delete pendingRequests[response.seq];
            pending.callback(response);
        }
    }
}
```"""
))

# ============================================================================
# RESPONSE HANDLING
# ============================================================================

examples.append(create_example(
    "How do I handle protocol errors in Evony?",
    """Error handling for Evony protocol:

**Response Structure:**
```json
{
  "cmd": "command.name",
  "result": 0,      // 0 = success, negative = error
  "data": {...},    // Only present on success
  "seq": 123
}
```

**Error Handling Pattern:**
```actionscript
function handleResponse(response:Object):void {
    if (response.result == 0) {
        // Success
        processData(response.data);
    } else {
        // Error
        switch (response.result) {
            case ErrorCode.RESOURCE_NOT_ENOUGH:
                showMessage("Not enough resources");
                break;
            case ErrorCode.NO_DEPEND_BUILDING:
                showBuildingRequirements();
                break;
            case ErrorCode.BUILDING_QUEUE_ERROR:
                // Queue full
                break;
            default:
                showMessage("Error: " + response.result);
        }
    }
}
```

**Common Error Codes:**
- -1: Resource insufficient
- -4: Position occupied
- -8: Missing building
- -9: Missing tech
- -200: Security code needed"""
))

# ============================================================================
# SAVE OUTPUT
# ============================================================================

print(f"Generated {len(examples)} protocol training examples")

with open(OUTPUT_FILE, 'w', encoding='utf-8') as f:
    for ex in examples:
        f.write(json.dumps(ex) + '\n')

print(f"Saved to: {OUTPUT_FILE}")
print(f"Size: {OUTPUT_FILE.stat().st_size / 1024:.2f} KB")
