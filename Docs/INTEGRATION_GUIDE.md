# Evony RTE Integration Guide

**Version**: 2.0.0  
**Last Updated**: January 10, 2026

---

## Quick Start

### 1. Basic Import
```python
import evony_rte  # Auto-starts bot server on port 9999
from evony_rte.mcp_server import handle_tool
```

### 2. First Command
```python
# Encode a game command
result = handle_tool('packet_encode', {
    'cmd': 'city.getInfo',
    'data': {'castleId': 12345}
})
print(result['amf3_hex'])
```

---

## 3-Layer Testing Strategy

### Layer 1: Inline Validation (Always On)
Every handler automatically validates input:

```python
# Bad input example
result = handle_tool('packet_encode', {
    'cmd': 123,  # Should be string
    'data': 'not a dict'  # Should be dict
})
# Returns:
# {
#     'error': 'Invalid input for packet_encode',
#     'validation_errors': ['cmd must be str, got int', 'data must be dict, got str'],
#     'expected_schema': {'cmd': 'str (optional)', 'data': 'dict (optional)'}
# }
```

### Layer 2: Self-Test Mode
Quick health check for any handler:

```python
# Test a single handler
result = handle_tool('packet_encode', {'_self_test': True})
# Returns: {'handler': 'packet_encode', 'self_test': 'passed', ...}

# Test all handlers
from evony_rte.mcp_server import run_all_self_tests
results = run_all_self_tests()
print(f"Passed: {results['passed']}/{results['total']}")
```

### Layer 3: Formal Test Suite
Run pytest for comprehensive testing:

```bash
cd C:\Users\Admin\Downloads\Evony_Decrypted
python -m pytest evony_rte/tests/ -v
```

---

## Handler Categories

### Packet Tools
| Handler | Description | Example |
|---------|-------------|---------|
| `packet_encode` | Encode data to AMF3 | `{'cmd': 'city.getInfo', 'data': {...}}` |
| `packet_decode` | Decode AMF3 packet | `{'data': 'hex_string', 'format': 'hex'}` |
| `packet_capture` | Capture game traffic | `{'action': 'start', 'duration': 30}` |
| `packet_inject` | Inject packet to game | `{'cmd': '...', 'data': {...}}` |
| `packet_replay` | Replay captured packet | `{'packet_index': 0}` |

### Exploit Framework
| Handler | Description | Example |
|---------|-------------|---------|
| `exploit_list` | List all exploits | `{'category': 'overflow'}` |
| `exploit_test` | Test exploit (dry run) | `{'exploit_id': 'overflow_archer', 'dry_run': True}` |
| `exploit_scan` | Scan for vulnerabilities | `{'target': 'troop.produceTroop'}` |
| `exploit_create` | Create new exploit | `{'name': 'test', 'cmd': '...'}` |

### Game Interaction
| Handler | Description | Example |
|---------|-------------|---------|
| `game_send` | Send command to game | `{'cmd': 'city.getInfo', 'data': {...}}` |
| `game_status` | Get game connection status | `{}` |
| `game_resources` | Get resource counts | `{'castle_id': 12345}` |
| `game_troops` | Get troop counts | `{'castle_id': 12345}` |

### RE Tools
| Handler | Description | Example |
|---------|-------------|---------|
| `ffdec` | FFDec Flash decompiler | `{'action': 'decompile', 'swf_file': '...'}` |
| `ghidra` | Ghidra binary analysis | `{'action': 'status'}` |
| `radare2` | Radare2 analysis | `{'action': 'analyze', 'file': '...'}` |
| `scapy` | Scapy packet crafting | `{'action': 'status'}` |

---

## Bot Server Integration

### Auto-Start
The bot server starts automatically when you import `evony_rte`:

```python
import evony_rte
port = evony_rte.get_bot_port()  # Returns 9999 (or next available)
```

### Manual Control
```python
from evony_rte.integrated_bot_server import get_bot_server

bot = get_bot_server()
bot.start()  # Start manually
bot.stop()   # Stop server
status = bot.get_status()  # Check status
```

### REST API
When running, the bot server exposes:

```
GET  http://localhost:9999/api/status
POST http://localhost:9999/api/send
GET  http://localhost:9999/api/game/resources
GET  http://localhost:9999/api/game/troops
```

---

## Claude Desktop Integration

### MCP Configuration
Add to `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "evony-rte": {
      "command": "python",
      "args": ["-m", "evony_rte.mcp_server"],
      "cwd": "C:\\Users\\Admin\\Downloads\\Evony_Decrypted"
    }
  }
}
```

### Available Tools in Claude
All 55 handlers become available as MCP tools:
- `evony_search` - Search knowledge base
- `evony_trace` - Multi-hop tracing
- `packet_encode` - Encode AMF3
- `exploit_list` - List exploits
- ... and 51 more

---

## Validation Schema Reference

Every handler has a validation schema:

```python
from evony_rte.mcp_server import HANDLER_VALIDATION_SCHEMAS

# View schema for any handler
schema = HANDLER_VALIDATION_SCHEMAS['packet_encode']
# {'cmd': (str, False), 'data': (dict, False)}
# Format: field_name: (expected_type, is_required)
```

### Custom Validation
```python
from evony_rte.mcp_server import validate_handler_input

# Validate manually
errors = validate_handler_input('my_handler', args, {
    'required_field': (str, True),
    'optional_field': (int, False)
})
if errors:
    return errors
```

---

## Error Handling

### Standard Error Response
All handlers return consistent error format:

```python
{
    'error': 'Description of what went wrong',
    'validation_errors': ['list', 'of', 'specific', 'issues'],  # If validation failed
    'handler': 'handler_name',  # Which handler failed
    'args_received': ['list', 'of', 'keys']  # What was passed
}
```

### Exception Handling
Handlers catch exceptions automatically:

```python
result = handle_tool('some_handler', bad_args)
if 'error' in result:
    print(f"Failed: {result['error']}")
else:
    print(f"Success: {result}")
```

---

## Performance

### Caching
Response caching is available:

```python
from evony_rte.mcp_performance import ResponseCache

cache = ResponseCache()
cached_result = cache.get('key')
cache.set('key', result, ttl=300)  # 5 minute TTL
```

### Metrics
```python
result = handle_tool('performance_stats', {})
# Returns timing data for all handlers
```

---

## File Locations

| File | Purpose |
|------|---------|
| `evony_rte/mcp_server.py` | Main MCP server, all handlers |
| `evony_rte/__init__.py` | Auto-start, version info |
| `evony_rte/integrated_bot_server.py` | Bot server integration |
| `evony_rte/tools_extended.py` | Extended tool handlers |
| `evony_rte/advanced_re_tools.py` | Ghidra, FFDec, etc. |
| `evony_rte/tests/` | Pytest test suite |
| `Docs/API_REFERENCE.md` | Complete API docs |
| `Docs/TROUBLESHOOTING.md` | Common issues & fixes |

---

## Common Patterns

### Encode and Send
```python
# Encode command
encoded = handle_tool('packet_encode', {
    'cmd': 'troop.produceTroop',
    'data': {'troopType': 6, 'num': 1000}
})

# Send to game
result = handle_tool('game_send', {
    'cmd': 'troop.produceTroop',
    'data': {'troopType': 6, 'num': 1000}
})
```

### Exploit Testing (Safe)
```python
# Always use dry_run first
result = handle_tool('exploit_test', {
    'exploit_id': 'overflow_archer',
    'dry_run': True  # SAFE - no actual execution
})

# Review payload before real test
print(f"Would send: {result['payload']}")
```

### Search Knowledge Base
```python
# Search for protocol info
result = handle_tool('evony_search', {
    'query': 'troop production commands'
})

# Multi-hop trace
result = handle_tool('evony_trace', {
    'entity': 'TroopCommands',
    'depth': 3
})
```

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 2.0.0 | Jan 2026 | 3-layer testing, auto-validation, 55 handlers |
| 1.5.0 | Dec 2025 | Bot server integration |
| 1.0.0 | Nov 2025 | Initial release |

---

## Support

- **API Reference**: `Docs/API_REFERENCE.md`
- **Troubleshooting**: `Docs/TROUBLESHOOTING.md`
- **Action Plan**: `Docs/Claude/ACTION_PLAN.md`
