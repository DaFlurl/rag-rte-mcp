# Evony Age II - Network Protocol Documentation

> **"Collective Communication Protocols"** - Understanding Evony's Client-Server Communication

---

## Overview

Evony Age II uses a custom protocol built on AMF3 (Action Message Format 3) over TCP connections. This document details the protocol structure for reverse engineering purposes.

---

## Connection Architecture

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  Evony Client   │────▶│   Load Balancer │────▶│   Game Server   │
│  (Flash SWF)    │◀────│   (Port 443)    │◀────│   (Backend)     │
└─────────────────┘     └─────────────────┘     └─────────────────┘
         │                                               │
         │              ┌─────────────────┐              │
         └─────────────▶│   API Server    │◀─────────────┘
                        │   (HTTP/HTTPS)  │
                        └─────────────────┘
```

### Endpoints

| Type | Protocol | Port | Purpose |
|------|----------|------|---------|
| Game Server | TCP/SSL | 443 | Real-time gameplay |
| API Server | HTTPS | 443 | Login, updates, static data |
| CDN | HTTPS | 443 | Assets, patches |

### Server Naming

```
svr[N].evony.com       # Game servers (N = 1-200+)
api.evony.com          # API endpoint
cdn.evony.com          # Content delivery
```

---

## Packet Structure

### Basic Packet Format

```
┌──────────────┬──────────────┬─────────────────────────────┐
│  Length (4)  │  Command ID  │       AMF3 Payload          │
│  Big-endian  │   Variable   │    (Serialized Object)      │
└──────────────┴──────────────┴─────────────────────────────┘
```

### Field Details

| Field | Size | Type | Description |
|-------|------|------|-------------|
| Length | 4 bytes | uint32 BE | Total packet length |
| Command ID | Variable | U29 | Action identifier |
| Payload | Variable | AMF3 | Serialized command object |

---

## AMF3 Command Format

### Request Object

```actionscript
{
    cmd: "namespace.action",    // Command identifier
    [params]: mixed,            // Action parameters
    seq: int                    // Sequence number
}
```

### Response Object

```actionscript
{
    cmd: "namespace.action",    // Echo of request
    ok: Boolean,                // Success flag
    data: Object,               // Response data
    errorMsg: String,           // Error message (if ok=false)
    packageId: int              // Sequence confirmation
}
```

---

## Command Namespaces

### `city.*` - City Management

| Command | Parameters | Description |
|---------|------------|-------------|
| `city.getInfo` | `cityId: int` | Get city details |
| `city.build` | `slot: int, buildingType: int` | Construct building |
| `city.upgrade` | `slot: int` | Upgrade building |
| `city.demolish` | `slot: int` | Remove building |
| `city.research` | `techId: int` | Start research |

### `army.*` - Military Operations

| Command | Parameters | Description |
|---------|------------|-------------|
| `army.train` | `unitType: int, count: int` | Train troops |
| `army.march` | `units: Object, target: Point` | Send army |
| `army.attack` | `target: Point, waves: int` | Attack target |
| `army.recall` | `marchId: int` | Recall marching army |
| `army.scout` | `target: Point` | Scout location |

### `hero.*` - Hero Management

| Command | Parameters | Description |
|---------|------------|-------------|
| `hero.recruit` | - | Hire new hero |
| `hero.assign` | `heroId: int, slot: int` | Assign to building |
| `hero.fire` | `heroId: int` | Dismiss hero |
| `hero.enhance` | `heroId: int, attribute: int` | Upgrade stats |

### `alliance.*` - Alliance Operations

| Command | Parameters | Description |
|---------|------------|-------------|
| `alliance.join` | `allianceId: int` | Join alliance |
| `alliance.leave` | - | Leave current |
| `alliance.create` | `name: String` | Create new |
| `alliance.donate` | `resource: int, amount: int` | Donate to alliance |

### `quest.*` - Quest System

| Command | Parameters | Description |
|---------|------------|-------------|
| `quest.list` | - | Get available quests |
| `quest.accept` | `questId: int` | Accept quest |
| `quest.complete` | `questId: int` | Claim rewards |

### `trade.*` - Resource Trading

| Command | Parameters | Description |
|---------|------------|-------------|
| `trade.transport` | `targetCity: int, resources: Object` | Send resources |
| `trade.market.list` | - | View market |
| `trade.market.buy` | `listingId: int` | Purchase item |
| `trade.market.sell` | `itemId: int, price: int` | List for sale |

---

## Authentication Flow

```
1. Client → Server: Connect to svr[N].evony.com:443
2. Client → Server: SSL Handshake
3. Client → Server: Login command
   {
       cmd: "login.login",
       username: "player",
       password: MD5(password),
       server: "svr12"
   }
4. Server → Client: Login response
   {
       ok: true,
       data: {
           playerId: 12345,
           sessionToken: "abc123...",
           playerData: {...}
       }
   }
5. Client: Store sessionToken, proceed to game
```

### Session Maintenance

- **Keepalive**: Client sends ping every 30 seconds
- **Session timeout**: ~5 minutes of inactivity
- **Reconnect**: Use sessionToken for fast reconnect

---

## Server Push Events

The server can push events without client request:

| Event | Description |
|-------|-------------|
| `chat.message` | New chat message |
| `army.arrived` | Army reached destination |
| `building.complete` | Construction finished |
| `attack.incoming` | Enemy attack detected |
| `alliance.news` | Alliance notification |

---

## Data Types

### Resource Object

```actionscript
{
    gold: int,
    food: int,
    wood: int,
    stone: int,
    iron: int
}
```

### Point (Coordinates)

```actionscript
{
    x: int,  // 0-799
    y: int   // 0-799
}
```

### Army Units

```actionscript
{
    worker: int,
    warrior: int,
    scout: int,
    pikeman: int,
    swordsman: int,
    archer: int,
    cavalry: int,
    cataphract: int,
    transporter: int,
    ballista: int,
    ram: int,
    catapult: int
}
```

---

## Security Notes

### Password Handling

```
Client stores: MD5(plaintext_password)
Sent to server: MD5(password)
```

**Note**: Password is stored as MD5 hash in SharedObject (SOL file).

### No Additional Encryption

- SSL/TLS for transport security
- No payload encryption beyond SSL
- Session tokens are plain strings

### Rate Limiting

- Commands are rate-limited server-side
- Rapid requests may trigger temporary ban
- Bot detection: behavioral analysis

---

## Reverse Engineering Tips

### Capture Traffic

1. Use Charles Proxy with SSL certificate
2. Configure Flash to trust proxy cert
3. Intercept and decode AMF3 payloads

### Analyze Client

1. Decompile SWF with FFDec
2. Search for `Socket.send()` calls
3. Find command serialization code
4. Map command IDs to functions

### Useful Strings to Search

```
"SharedObject"     // Account storage
"URLLoader"        // HTTP requests  
"Socket"           // TCP connections
"MD5"              // Password hashing
"login"            // Auth flow
```

---

## Bot Communication

AutoEvony and RoboEvony implement this protocol:

```
autoevony.cmds.Commands  →  Implements game commands
autoevony.data.Session   →  Manages connection
roboevony.core.Network   →  Socket handler
```

---

## Related Diagrams

- `network_protocol.svg` - Visual protocol flow
- `amf_protocol.svg` - AMF3 encoding details
- `evony_architecture.svg` - Client structure

---

*Document Version: 1.0.0 | For educational purposes only*
