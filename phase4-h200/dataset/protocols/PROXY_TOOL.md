# Svony Studio - Proxy Tool Guide

> **"Network Traffic Analysis"** - Capturing and Analyzing Evony Protocol Traffic

---

## Overview

The Proxy Tool enables capturing, analyzing, and modifying network traffic between Evony clients and servers. Essential for protocol research and bot development.

---

## Proxy Modes

| Mode | Description | Use Case |
|------|-------------|----------|
| **Transparent** | Intercept all traffic | Full capture |
| **Explicit** | Client configured | Testing |
| **Reverse** | Server-side proxy | Private server |

---

## Setup

### Requirements

```bash
pip install mitmproxy>=10.0.0
pip install pyamf  # AMF decoding
```

### Basic Configuration

```yaml
# config/proxy.yaml
proxy:
  mode: explicit
  listen_host: 127.0.0.1
  listen_port: 8888
  target_host: svr12.evony.com
  target_port: 443
  ssl: true
  
amf:
  decode: true
  log_messages: true
  
capture:
  enabled: true
  output_dir: captures/
  format: json
```

---

## Starting the Proxy

### GUI Method

1. **Tools → Proxy → Start Proxy**
2. Configure settings in dialog
3. Click **Start**
4. Status shows "Listening on 127.0.0.1:8888"

### CLI Method

```bash
python main.py proxy start --port 8888 --target svr12.evony.com:443
```

### Direct mitmproxy

```bash
mitmdump -p 8888 -s addons/evony_decoder.py
```

---

## Client Configuration

### Flash Player

1. Set system proxy:
   - Host: `127.0.0.1`
   - Port: `8888`

2. Or use environment variable:
   ```bash
   set HTTP_PROXY=http://127.0.0.1:8888
   ```

### Browser (Chrome)

```bash
chrome.exe --proxy-server="127.0.0.1:8888"
```

### Evony Client (Patched)

Modify client to use proxy:
1. Open client SWF in Svony Studio
2. **Tools → Evony → Patch Server URL**
3. Set to `127.0.0.1:8888`
4. Export patched client

---

## SSL/TLS Interception

### Install CA Certificate

1. Start proxy
2. Navigate to `http://mitm.it` in browser
3. Download certificate for your platform
4. Install in system trust store

### Windows Installation

```powershell
# Export certificate
mitmproxy-ca-cert.cer

# Install (requires admin)
certutil -addstore "Root" mitmproxy-ca-cert.cer
```

### Flash Trust

Add to Flash trust file:
```
# %APPDATA%\Macromedia\Flash Player\#Security\FlashPlayerTrust\svony.cfg
D:\svony_studio
```

---

## Capture Interface

### Live View

```
┌─────────────────────────────────────────────────┐
│ Proxy Capture - Live View                 [x]   │
├─────────────────────────────────────────────────┤
│ [Start] [Stop] [Clear] [Export] [Filter: ____] │
├─────────────────────────────────────────────────┤
│ # │ Time     │ Dir │ Command      │ Size  │ St │
├───┼──────────┼─────┼──────────────┼───────┼────┤
│ 1 │ 10:00:01 │ →   │ login.login  │ 128   │ OK │
│ 2 │ 10:00:02 │ ←   │ login.login  │ 2048  │ OK │
│ 3 │ 10:00:05 │ →   │ city.getInfo │ 64    │ OK │
│ 4 │ 10:00:05 │ ←   │ city.getInfo │ 4096  │ OK │
│ 5 │ 10:00:10 │ →   │ army.train   │ 96    │ OK │
└───┴──────────┴─────┴──────────────┴───────┴────┘
│ Selected: login.login (Request)                 │
├─────────────────────────────────────────────────┤
│ {                                               │
│   "cmd": "login.login",                         │
│   "data": {                                     │
│     "username": "player1",                      │
│     "password": "5f4dcc3b..."                   │
│   },                                            │
│   "seq": 1                                      │
│ }                                               │
└─────────────────────────────────────────────────┘
```

### Message Details

Click any message to see:
- Full AMF decoded content
- Raw hex dump
- Headers
- Timing information
- Related request/response

---

## Filtering

### By Command

```
# Show only login commands
filter: cmd:login

# Show city commands
filter: cmd:city.*

# Hide keepalive
filter: -cmd:keepAlive
```

### By Content

```
# Messages containing "error"
filter: error

# Messages with specific city ID
filter: cityId:12345
```

### By Direction

```
# Only requests
filter: dir:request

# Only responses
filter: dir:response
```

---

## AMF Decoder Addon

### Custom Decoder

```python
# addons/evony_decoder.py
from mitmproxy import ctx
from pyamf import amf3
import json

class EvonyDecoder:
    def __init__(self):
        self.captures = []
    
    def request(self, flow):
        self._decode_amf(flow, "request")
    
    def response(self, flow):
        self._decode_amf(flow, "response")
    
    def _decode_amf(self, flow, direction):
        content = flow.request.content if direction == "request" else flow.response.content
        
        try:
            # Skip first 4 bytes (length prefix)
            amf_data = content[4:]
            decoded = amf3.decode(amf_data)
            
            capture = {
                "timestamp": flow.timestamp_start,
                "direction": direction,
                "cmd": decoded.get("cmd", "unknown"),
                "data": decoded
            }
            
            self.captures.append(capture)
            ctx.log.info(f"[{direction}] {decoded.get('cmd')}")
            
        except Exception as e:
            ctx.log.warn(f"Failed to decode AMF: {e}")

addons = [EvonyDecoder()]
```

---

## Message Modification

### Intercept and Modify

```python
# addons/evony_modifier.py
from mitmproxy import ctx
from pyamf import amf3

class EvonyModifier:
    def request(self, flow):
        if self._is_amf(flow.request):
            data = self._decode(flow.request.content)
            
            # Modify request
            if data.get("cmd") == "army.train":
                # Double training amount
                data["data"]["count"] *= 2
            
            flow.request.content = self._encode(data)
    
    def response(self, flow):
        if self._is_amf(flow.response):
            data = self._decode(flow.response.content)
            
            # Modify response
            if "resources" in data.get("data", {}):
                # Show modified resources
                data["data"]["resources"]["gold"] = 999999
            
            flow.response.content = self._encode(data)
    
    def _is_amf(self, message):
        return len(message.content) > 4
    
    def _decode(self, content):
        return amf3.decode(content[4:])
    
    def _encode(self, data):
        amf_bytes = amf3.encode(data)
        return len(amf_bytes).to_bytes(4, 'big') + amf_bytes
```

### Block Messages

```python
def request(self, flow):
    data = self._decode(flow.request.content)
    
    # Block certain commands
    blocked = ["shop.buy", "item.use"]
    if data.get("cmd") in blocked:
        flow.response = mitmproxy.http.Response.make(
            403, b"Blocked", {"Content-Type": "text/plain"}
        )
```

---

## Export Options

### Export to JSON

```bash
python main.py proxy export --format json -o captures.json
```

Output:
```json
{
    "captures": [
        {
            "timestamp": "2026-01-02T10:00:01Z",
            "direction": "request",
            "cmd": "login.login",
            "data": {...}
        }
    ]
}
```

### Export to HAR

```bash
python main.py proxy export --format har -o captures.har
```

### Export Protocol Documentation

```bash
python main.py proxy export --format docs -o protocol_docs/
```

Generates markdown documentation of discovered commands.

---

## Replay Tool

### Replay Single Message

```bash
python main.py proxy replay message.json --target svr12.evony.com:443
```

### Replay Session

```bash
python main.py proxy replay session.json --speed 2x
```

### Fuzzing

```bash
# Fuzz string parameters
python main.py proxy fuzz login.json --field data.username

# Fuzz integer parameters
python main.py proxy fuzz train.json --field data.count --range 1-1000000
```

---

## Security Considerations

### Credential Exposure

- Captured traffic may contain passwords
- Store captures securely
- Don't share raw captures

### Legal Considerations

- Only capture your own traffic
- Check game ToS before use
- Research purposes only

### Network Security

- Don't expose proxy to network
- Use localhost only
- Disable when not in use

---

## Troubleshooting

### Connection Refused

```
Error: Connection refused to svr12.evony.com:443
```

**Solutions:**
1. Check target server is correct
2. Verify SSL certificate installed
3. Check firewall settings

### SSL Errors

```
Error: SSL certificate verify failed
```

**Solutions:**
1. Install mitmproxy CA certificate
2. Add to Flash Player trust
3. Check certificate not expired

### AMF Decode Errors

```
Error: Invalid AMF data
```

**Solutions:**
1. Check length prefix handling
2. Verify AMF3 vs AMF0
3. Check for compression

---

## CLI Reference

```bash
# Start proxy
python main.py proxy start [--port 8888] [--target HOST:PORT]

# Stop proxy
python main.py proxy stop

# Export captures
python main.py proxy export [--format json|har|docs] [-o OUTPUT]

# Replay messages
python main.py proxy replay FILE [--speed 1x|2x|realtime]

# Clear captures
python main.py proxy clear
```

---

## Related Documentation

- `evony/EVONY_PROTOCOL.md` - Protocol details
- `evony/COMMAND_REFERENCE.md` - Command IDs
- `AMF_EDITOR.md` - AMF editing
- `formats/AMF_ENCODING.md` - AMF format

---

*Document Version: 1.0.0 | Proxy Tool Guide*
