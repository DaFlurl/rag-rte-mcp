# Evony RTE MCP Handler API Reference

**Version**: 2.0.0  
**Total Handlers**: 55  
**Last Updated**: January 10, 2026

---

## Quick Reference

| Category | Handlers | Description |
|----------|----------|-------------|
| Packet Tools | 5 | AMF3 encoding/decoding, capture, inject |
| Client Analysis | 4 | Search, strings, callgraph, decompile |
| Exploit Framework | 4 | List, test, scan, create exploits |
| Game Interaction | 5 | Connect, send, resources, troops, status |
| Proxy Tools | 6 | Start, stop, capture, inject, session |
| RE Tools | 11 | FFDec, Ghidra, radare2, scapy, zeek |
| Cross-Reference | 3 | Client-server mapping, validation |
| System Tools | 4 | Stats, vulnerabilities, protocol analysis |
| Stealth Tools | 5 | Account scan, traffic intercept, config |
| Diagram Tools | 3 | Callgraph, exploit flow, custom diagrams |

---

## Packet Tools

### packet_capture
Start/stop packet capture for Evony traffic analysis.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| action | string | Yes | "start", "stop", or "status" |
| duration | integer | No | Capture duration in seconds (default: 30) |
| filter | string | No | Packet filter (e.g., "march", "battle") |

**Example**:
```python
handle_tool('packet_capture', {'action': 'start', 'duration': 60})
```

**Returns**:
```json
{
  "status": "capturing",
  "duration": 60,
  "output_file": "captures/capture_20260110.pcap"
}
```

---

### packet_decode
Decode AMF3 packet from hex or base64.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| data | string | Yes | Hex or base64 encoded AMF3 data |
| format | string | No | "hex" or "base64" (default: "hex") |

**Example**:
```python
handle_tool('packet_decode', {
    'data': '0a0b0107636d64...',
    'format': 'hex'
})
```

**Returns**:
```json
{
  "decoded": {"cmd": "city.getInfo", "data": {"castleId": 12345}},
  "amf3_type": "object",
  "size": 43
}
```

---

### packet_encode
Encode data to AMF3 packet format.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| cmd | string | Yes | Command name (e.g., "city.getInfo") |
| data | object | Yes | Command parameters |

**Example**:
```python
handle_tool('packet_encode', {
    'cmd': 'troop.produceTroop',
    'data': {'troopType': 6, 'num': 100, 'castleId': 12345}
})
```

**Returns**:
```json
{
  "success": true,
  "command": "troop.produceTroop",
  "amf3_hex": "0a0b0107636d64...",
  "amf3_length": 67,
  "with_prefix_hex": "00000043..."
}
```

---

### packet_inject
Inject custom packet to game server.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| cmd | string | Yes | Command to inject |
| data | object | Yes | Command parameters |
| verify | boolean | No | Verify state after injection |

**Example**:
```python
handle_tool('packet_inject', {
    'cmd': 'city.getInfo',
    'data': {'castleId': 12345},
    'verify': True
})
```

---

### packet_replay
Replay a captured packet with modifications.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| packet_index | integer | Yes | Index of captured packet |
| modifications | object | No | Fields to modify |

---

## Client Analysis Tools

### client_search
Search decompiled ActionScript code.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| query | string | Yes | Search term |
| type | string | No | "class", "function", "string", "all" |
| limit | integer | No | Max results (default: 50) |

**Example**:
```python
handle_tool('client_search', {
    'query': 'TroopCommands',
    'type': 'class',
    'limit': 20
})
```

---

### client_strings
Extract strings from decompiled client.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| filter | string | No | Filter pattern |
| min_length | integer | No | Minimum string length (default: 4) |

---

### client_callgraph
Generate function call graph.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| function | string | No | Root function name |
| depth | integer | No | Max depth (default: 3) |

---

## Exploit Framework

### exploit_list
List all documented exploits.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| category | string | No | Filter by category |
| status | string | No | Filter by status |

**Example**:
```python
handle_tool('exploit_list', {'category': 'overflow'})
```

**Returns**:
```json
{
  "exploits": {
    "overflow_archer": {
      "name": "Archer Integer Overflow",
      "category": "overflow",
      "status": "testing",
      "cmd": "troop.produceTroop"
    }
  },
  "total": 5
}
```

---

### exploit_test
Test an exploit with verification.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| exploit_id | string | Yes | Exploit identifier |
| dry_run | boolean | No | Simulate only (default: true) |
| verify | boolean | No | Verify result |

---

### exploit_scan
Scan for vulnerabilities.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| target | string | No | Specific command to scan |
| types | array | No | Vulnerability types to check |

---

### exploit_create
Create custom exploit template.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| name | string | Yes | Exploit name |
| cmd | string | Yes | Target command |
| payload | object | Yes | Exploit payload |

---

## Game Interaction Tools

### game_connect
Connect to Evony game server.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| server | string | Yes | Server name (e.g., "na45") |
| method | string | No | "proxy" or "bot" |

---

### game_send
Send command to game server.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| cmd | string | Yes | Command name |
| data | object | Yes | Command parameters |
| wait_response | boolean | No | Wait for response |

**Example**:
```python
handle_tool('game_send', {
    'cmd': 'city.getInfo',
    'data': {'castleId': 12345}
})
```

---

### game_status
Get current game connection status.

---

### game_resources
Get current resources from session.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| castle_id | integer | No | Specific castle ID |

---

### game_troops
Get current troop counts from session.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| castle_id | integer | No | Specific castle ID |

---

## Proxy Tools

### proxy_start
Start proxy to intercept game traffic.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| server | string | No | Target server (default: "na45") |
| port | integer | No | Local port (default: 9998) |

---

### proxy_stop
Stop the proxy.

---

### proxy_status
Get proxy status and statistics.

---

### proxy_capture
Get captured packets.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| limit | integer | No | Max packets (default: 100) |
| filter | string | No | Filter by command |

---

### proxy_inject
Inject command through proxy.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| cmd | string | Yes | Command to inject |
| data | object | Yes | Command parameters |

---

### proxy_session
Get live session state.

---

## Advanced RE Tools

### ffdec
FFDec SWF decompiler operations.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| action | string | Yes | "decompile", "list_abc", "export" |
| swf_file | string | No | SWF file path |
| output_dir | string | No | Output directory |

---

### ghidra
Ghidra RE framework operations.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| action | string | Yes | "analyze", "export", "status" |
| file | string | No | File to analyze |
| project | string | No | Project name |

---

### radare2
Radare2 RE operations.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| action | string | Yes | "analyze", "functions", "strings" |
| file | string | No | File to analyze |

---

### scapy
Scapy packet crafting.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| action | string | Yes | "craft", "send", "interfaces" |
| protocol | string | No | Protocol type |

---

### zeek
Zeek network security monitoring.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| action | string | Yes | "analyze", "status" |
| pcap_file | string | No | PCAP file to analyze |

---

### ngrep
Network pattern grep.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| action | string | Yes | "search", "status" |
| pattern | string | No | Search pattern |

---

### tcpflow
TCP stream extraction.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| action | string | Yes | "extract", "status" |
| pcap_file | string | No | PCAP file |

---

### swfmill
SWF to XML conversion.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| action | string | Yes | "swf2xml", "xml2swf", "status" |
| input_file | string | No | Input file |

---

## System Tools

### rte_stats
Get RTE system statistics.

---

### tools_status
Get status of all integrated tools.

---

### advanced_tools_status
Get status of advanced RE tools.

---

### find_vulnerabilities
Auto-scan for vulnerabilities.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| target | string | No | Specific target |
| depth | string | No | "quick" or "deep" |

---

### analyze_protocol
Analyze protocol structure.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| command | string | No | Specific command |

---

### diff_versions
Compare client/server versions.

---

## Cross-Reference Tools

### xref_client_server
Map client functions to server handlers.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| function | string | No | Client function name |

---

### xref_packet_handler
Find handler code for packet types.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| packet_type | string | No | Packet type to find |

---

### xref_validation
Find validation points for commands.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| command | string | No | Command to analyze |

---

## Stealth Tools

### stealth_config
Configure stealth settings.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| action | string | Yes | "get", "set" |
| setting | string | No | Setting name |
| value | any | No | Setting value |

---

### account_scan
Scan account for vulnerabilities.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| depth | string | No | "quick" or "full" |

---

### traffic_intercept
Configure traffic interception.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| action | string | Yes | "start", "stop", "status" |

---

### troop_repair
Troop repair exploit testing.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| action | string | Yes | "test", "verify" |

---

### failsafe_status
Get failsafe system status.

---

## Diagram Tools

### diagram_generate
Generate diagrams with Graphviz.

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| type | string | Yes | "callgraph", "exploit_flow", "custom" |
| name | string | No | Output name |
| data | object | No | Diagram data |

---

## Error Codes

| Code | Description |
|------|-------------|
| `error` | General error with message |
| `not_configured` | Tool not installed/configured |
| `not_connected` | Not connected to game server |
| `file_not_found` | Specified file doesn't exist |
| `timeout` | Operation timed out |
| `permission_denied` | Insufficient permissions |

---

## Common Patterns

### Check Tool Status
```python
handle_tool('tools_status', {})
handle_tool('advanced_tools_status', {})
```

### Encode and Send Command
```python
# Encode first
encoded = handle_tool('packet_encode', {'cmd': 'city.getInfo', 'data': {'castleId': 123}})

# Then send
result = handle_tool('game_send', {'cmd': 'city.getInfo', 'data': {'castleId': 123}})
```

### Test Exploit Safely
```python
# Always use dry_run first
result = handle_tool('exploit_test', {'exploit_id': 'overflow_archer', 'dry_run': True})
```

---

**End of API Reference**
