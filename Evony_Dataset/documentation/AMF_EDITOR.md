# Svony Studio - AMF Editor Guide

> **"AMF Data Editing"** - Working with ActionScript Message Format

---

## Overview

AMF (Action Message Format) is Adobe's binary serialization format used for Flash/Flex communication. Svony Studio provides tools for reading, editing, and creating AMF data.

---

## AMF Versions

| Version | Name | Use Case |
|---------|------|----------|
| AMF0 | Legacy | Flash Player 6-8 |
| AMF3 | Current | Flash Player 9+, Evony |

Evony Age II uses **AMF3** exclusively.

---

## AMF3 Data Types

### Primitive Types

| Type | Marker | Example |
|------|--------|---------|
| Undefined | 0x00 | `undefined` |
| Null | 0x01 | `null` |
| False | 0x02 | `false` |
| True | 0x03 | `true` |
| Integer | 0x04 | `42`, `-100` |
| Double | 0x05 | `3.14159` |
| String | 0x06 | `"hello"` |
| Date | 0x08 | `new Date()` |
| Array | 0x09 | `[1, 2, 3]` |
| Object | 0x0A | `{name: "value"}` |
| ByteArray | 0x0C | Binary data |

### Complex Types

```python
# Typed Object (with class name)
{
    "__class__": "com.evony.model.CityBean",
    "cityId": 12345,
    "name": "MyCity",
    "x": 100,
    "y": 200
}

# Array with mixed types
[1, "two", 3.0, {"key": "value"}]

# Associative Array
{
    "0": "first",
    "1": "second",
    "key": "value"
}
```

---

## AMF Editor Interface

### Opening AMF Editor

**From SOL File:**
1. Open SOL in SOL Manager
2. Double-click AMF value
3. AMF Editor opens

**From Captured Traffic:**
1. Open Protocol Capture
2. Select AMF message
3. Click **Edit AMF**

**Standalone:**
1. **Tools → AMF Editor**
2. Load AMF file or paste hex

### Editor Layout

```
┌─────────────────────────────────────────────────┐
│ AMF Editor - message.amf                  [x]   │
├─────────────────────────────────────────────────┤
│ View: [Tree ▼] [JSON] [Hex] [Raw]              │
├────────────────┬────────────────────────────────┤
│ Structure      │ Value Editor                   │
│ ┌────────────┐ │ ┌────────────────────────────┐ │
│ │ □ root     │ │ │ Type: Object               │ │
│ │  ├─ cmd    │ │ │ Class: (anonymous)         │ │
│ │  ├─ data   │ │ │                            │ │
│ │  │  ├─ id  │ │ │ Properties:                │ │
│ │  │  └─ val │ │ │ ┌──────────────────────┐  │ │
│ │  └─ seq    │ │ │ │ cmd: "login"         │  │ │
│ └────────────┘ │ │ │ seq: 1               │  │ │
│                │ │ └──────────────────────┘  │ │
├────────────────┴────────────────────────────────┤
│ [Add] [Delete] [Move Up] [Move Down] [Save]     │
└─────────────────────────────────────────────────┘
```

---

## Editing Operations

### Edit Value

1. Select node in tree
2. Edit in Value Editor panel
3. Changes apply immediately (tree view)
4. Click **Save** to persist

### Change Type

1. Select node
2. Click **Type** dropdown
3. Select new type
4. Value converts if possible

**Type Conversions:**
```
Integer → String: 42 → "42"
String → Integer: "42" → 42, "abc" → 0
Boolean → Integer: true → 1, false → 0
```

### Add Property

1. Select parent object/array
2. Click **Add**
3. Enter key name (for objects)
4. Select type
5. Enter value

### Delete Property

1. Select node
2. Click **Delete**
3. Confirm deletion

### Reorder Array

1. Select array element
2. Use **Move Up** / **Move Down**
3. Or drag and drop in tree

---

## View Modes

### Tree View

Hierarchical display with expand/collapse.

```
□ root (Object)
├─ cmd: "login" (String)
├─ data (Object)
│  ├─ username: "player1" (String)
│  └─ password: "abc123" (String)
└─ seq: 1 (Integer)
```

### JSON View

```json
{
    "cmd": "login",
    "data": {
        "username": "player1",
        "password": "abc123"
    },
    "seq": 1
}
```

### Hex View

```
00000000: 0A 0B 01 07 63 6D 64 06  09 6C 6F 67 69 6E 09 64  |....cmd..login.d|
00000010: 61 74 61 0A 0B 01 11 75  73 65 72 6E 61 6D 65 06  |ata....username.|
00000020: 0F 70 6C 61 79 65 72 31  11 70 61 73 73 77 6F 72  |.player1.passwor|
00000030: 64 06 0D 61 62 63 31 32  33 01 07 73 65 71 04 01  |d..abc123..seq..|
```

### Raw View

Direct byte editing (advanced users).

---

## Python AMF Library

### Reading AMF

```python
from pyamf import amf3

# Read from bytes
data = amf3.decode(amf_bytes)

# Read from file
with open("message.amf", "rb") as f:
    data = amf3.decode(f.read())

# Access data
print(data["cmd"])
print(data["data"]["username"])
```

### Writing AMF

```python
from pyamf import amf3

# Create data structure
message = {
    "cmd": "login",
    "data": {
        "username": "player1",
        "password": "abc123"
    },
    "seq": 1
}

# Encode to bytes
amf_bytes = amf3.encode(message)

# Write to file
with open("message.amf", "wb") as f:
    f.write(amf_bytes)
```

### Typed Objects

```python
from pyamf import register_class

# Define class
class CityBean:
    def __init__(self):
        self.cityId = 0
        self.name = ""
        self.x = 0
        self.y = 0

# Register for AMF
register_class(CityBean, "com.evony.model.CityBean")

# Now decoding will create CityBean instances
city = amf3.decode(city_amf_bytes)
print(city.name)  # Typed access
```

---

## Evony AMF Patterns

### Command Message

```python
# Client → Server
{
    "cmd": "city.getInfo",
    "data": {
        "cityId": 12345
    },
    "seq": 42
}
```

### Response Message

```python
# Server → Client
{
    "ok": True,
    "seq": 42,
    "data": {
        "cityId": 12345,
        "name": "MyCity",
        "x": 100,
        "y": 200,
        "level": 10,
        "resources": {
            "gold": 50000,
            "food": 100000,
            "wood": 75000,
            "stone": 60000,
            "iron": 45000
        }
    }
}
```

### Error Response

```python
{
    "ok": False,
    "seq": 42,
    "errorCode": 202,
    "errorMsg": "Insufficient resources"
}
```

---

## SOL AMF Data

### SOL Structure

```python
# Evony SOL (cevony_sol.sol)
{
    "data": {
        "username": "player1",
        "password": "5f4dcc3b...",  # MD5 hash
        "server": "svr12.evony.com",
        "autoLogin": True,
        "settings": {
            "sound": True,
            "music": False,
            "quality": "high"
        }
    }
}
```

### Editing Credentials

```python
# Read SOL
from pyamf.sol import SOL

sol = SOL("cevony_sol.sol")
data = sol.data

# Modify
data["username"] = "newplayer"
data["server"] = "svr15.evony.com"

# Save
sol.save()
```

---

## Protocol Analysis

### Capture AMF Traffic

```python
# Using mitmproxy addon
from mitmproxy import ctx
from pyamf import amf3

class AMFCapture:
    def request(self, flow):
        if "amf" in flow.request.headers.get("content-type", ""):
            try:
                data = amf3.decode(flow.request.content)
                ctx.log.info(f"AMF Request: {data}")
            except:
                pass
    
    def response(self, flow):
        if "amf" in flow.response.headers.get("content-type", ""):
            try:
                data = amf3.decode(flow.response.content)
                ctx.log.info(f"AMF Response: {data}")
            except:
                pass
```

### Replay Messages

```python
import socket
from pyamf import amf3

def send_amf(host, port, message):
    """Send AMF message to server."""
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.connect((host, port))
    
    # Encode message
    amf_bytes = amf3.encode(message)
    
    # Send with length prefix (Evony protocol)
    length = len(amf_bytes)
    sock.send(length.to_bytes(4, 'big'))
    sock.send(amf_bytes)
    
    # Receive response
    resp_len = int.from_bytes(sock.recv(4), 'big')
    resp_bytes = sock.recv(resp_len)
    
    return amf3.decode(resp_bytes)
```

---

## CLI Commands

### Decode AMF

```bash
# Decode to JSON
python main.py amf decode message.amf -o message.json

# Decode hex string
python main.py amf decode --hex "0A0B01..." -o message.json
```

### Encode AMF

```bash
# Encode from JSON
python main.py amf encode message.json -o message.amf
```

### Inspect AMF

```bash
# Show structure
python main.py amf inspect message.amf

# Output:
# Type: Object
# Properties: 3
#   cmd: String = "login"
#   data: Object (2 properties)
#   seq: Integer = 1
```

---

## Best Practices

### Editing Safety

1. **Backup** before editing
2. **Validate** structure after changes
3. **Test** with target application
4. **Document** changes made

### Type Preservation

- Keep same types when editing values
- Use proper markers for new values
- Preserve class names for typed objects

### String Encoding

- AMF3 strings are UTF-8
- Handle special characters properly
- Watch for string reference optimization

---

## Troubleshooting

### Decode Errors

**Error:** `Invalid marker byte`
- File may be AMF0, try AMF0 decoder
- File may be corrupted
- Check for compression wrapper

**Error:** `String reference out of range`
- AMF stream was truncated
- Reference table corrupted

### Encode Errors

**Error:** `Cannot serialize type`
- Unsupported Python type
- Register custom class first

---

## Related Documentation

- `formats/AMF_ENCODING.md` - AMF specification
- `formats/SOL_FORMAT.md` - SOL file format
- `evony/EVONY_PROTOCOL.md` - Protocol details
- `PROXY_TOOL.md` - Traffic capture

---

*Document Version: 1.0.0 | AMF Editor Guide*
