# Evony MCP Toolkit - Comprehensive Design

## Overview
A unified MCP (Model Context Protocol) server that exposes Evony reverse engineering, exploitation, modding, and scripting tools to AI assistants (Windsurf/Claude/ChatGPT).

## Core MCP Tools (Mega-Tools Pattern)

### 1. `evony_connection` - Connection Management
```
Actions: connect, disconnect, status, reconnect, test_port
- connect: TCP to game server with retry logic
- disconnect: Clean disconnect
- status: Connection state, login state, latency
- reconnect: Auto-reconnect with session restore
- test_port: Probe different ports (443, 9339, etc.)
```

### 2. `evony_auth` - Authentication & Accounts
```
Actions: login, logout, register, attach_account, list_accounts, switch_account
- login: SHA1 password hash, retry 1-3 times
- attach_account: Save credentials to local encrypted store
- list_accounts: Show saved accounts
- switch_account: Quick account switching
- session_info: Current session details
```

### 3. `evony_packet` - Packet Operations
```
Actions: send, send_template, capture, replay, decode, encode
- send: Send raw AMF3 packet
- send_template: Use exploit templates
- capture: Start packet capture session
- replay: Replay captured packets
- decode: Decode AMF3 to JSON
- encode: Encode JSON to AMF3
```

### 4. `evony_discover` - Game Data Discovery
```
Actions: player_info, castle_info, heroes, armies, resources, alliance, map_scan
- player_info: Get player details and IDs
- castle_info: Castle IDs, buildings, resources
- heroes: List heroes with stats
- armies: Active army movements
- resources: Current resource counts
- alliance: Alliance info and members
- map_scan: Scan map area for targets
```

### 5. `evony_exploit` - Exploit Framework
```
Actions: list_exploits, run_exploit, create_exploit, test_exploit
Categories:
- resource: Resource manipulation exploits
- combat: Army/troop exploits
- hero: Hero stat exploits
- shop: Shop/item exploits
- alliance: Alliance exploits
- admin: Admin command injection
```

### 6. `evony_script` - Scripting Engine
```
Actions: run, list, create, schedule, stop
- run: Execute automation script
- list: Available scripts
- create: Create new script from template
- schedule: Schedule script execution
- stop: Stop running script
```

### 7. `evony_mod` - Game Modding
```
Actions: list_mods, apply_mod, create_mod, extract_assets
- list_mods: Available game modifications
- apply_mod: Apply SWF/memory mod
- create_mod: Create new mod from template
- extract_assets: Extract game assets (images, sounds)
```

### 8. `evony_analyze` - Reverse Engineering
```
Actions: decompile_swf, analyze_protocol, trace_calls, memory_scan, find_patterns
- decompile_swf: Extract AS3 source
- analyze_protocol: Protocol reverse engineering
- trace_calls: Trace function calls
- memory_scan: Scan for values in memory
- find_patterns: Find exploit patterns in code
```

### 9. `evony_search` - Knowledge Base
```
Actions: search, lookup, list_commands, list_beans
- search: Semantic search over Evony codebase
- lookup: Direct lookup of class/function
- list_commands: All available game commands
- list_beans: All data bean classes
```

## Feature Matrix

| Feature | Description | Priority |
|---------|-------------|----------|
| Multi-account support | Attach/switch between accounts | High |
| Packet capture/replay | Record and replay sessions | High |
| Auto-reconnect | Handle disconnects gracefully | High |
| Exploit templates | Pre-built exploit payloads | High |
| Automation scripts | Bot scripts for farming | Medium |
| Memory scanning | Find values in game memory | Medium |
| SWF decompilation | Extract and analyze source | Medium |
| Asset extraction | Extract game images/sounds | Low |
| Proxy mode | MITM for packet inspection | Low |

## Integration Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    AI Assistants                             │
│  (Windsurf/Claude/ChatGPT via MCP)                          │
└──────────────────────┬──────────────────────────────────────┘
                       │ MCP Protocol
                       ▼
┌─────────────────────────────────────────────────────────────┐
│              Evony MCP Server (Python)                       │
│  ┌─────────────┬─────────────┬─────────────┬─────────────┐  │
│  │ Connection  │    Auth     │   Packet    │   Exploit   │  │
│  │   Manager   │   Manager   │   Handler   │   Engine    │  │
│  └─────────────┴─────────────┴─────────────┴─────────────┘  │
│  ┌─────────────┬─────────────┬─────────────┬─────────────┐  │
│  │  Scripting  │   Modding   │  Analysis   │  Knowledge  │  │
│  │   Engine    │   Tools     │   Tools     │    Base     │  │
│  └─────────────┴─────────────┴─────────────┴─────────────┘  │
└──────────────────────┬──────────────────────────────────────┘
                       │ TCP/AMF3
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                   Evony Game Server                          │
│                   (cc2.evony.com:443)                        │
└─────────────────────────────────────────────────────────────┘
```

## Example MCP Tool Calls

```python
# Connect to server and login
evony_connection(action="connect", host="cc2.evony.com", port=443)
evony_auth(action="login", username="user@email.com", password="pass123")

# Discover game data
evony_discover(action="player_info")
evony_discover(action="heroes")
evony_discover(action="castle_info", castle_id=12345)

# Run exploit
evony_exploit(action="run_exploit", exploit="resource_overflow", params={"amount": 999999})

# Search knowledge base
evony_search(action="search", query="login authentication SHA1 password")

# Capture and replay
evony_packet(action="capture", duration=60)
evony_packet(action="replay", session_id="capture_001")
```

## Implementation Phases

### Phase 1: Core Connection (Current)
- [x] TCP connection with retry
- [x] AMF3 encode/decode
- [x] Basic web UI
- [ ] Fix 4-byte buffer issue
- [ ] Successful login flow

### Phase 2: MCP Integration
- [ ] Convert to MCP server format
- [ ] Implement mega-tools pattern
- [ ] Add to mcp_config.json
- [ ] Test with Windsurf

### Phase 3: Advanced Features
- [ ] Multi-account support
- [ ] Packet capture/replay
- [ ] Exploit templates expansion
- [ ] Automation scripting

### Phase 4: Analysis Tools
- [ ] SWF decompilation integration
- [ ] Memory scanning
- [ ] Protocol analyzer
- [ ] Pattern finder

## Files Structure
```
evony_bot/
├── server.py              # Current web server
├── mcp_server.py          # MCP server (to create)
├── core/
│   ├── connection.py      # Connection manager
│   ├── auth.py            # Authentication
│   ├── packet.py          # Packet handling
│   └── amf3.py            # AMF3 codec
├── exploits/
│   ├── templates.py       # Exploit templates
│   └── payloads/          # Payload definitions
├── scripts/
│   └── automation/        # Bot scripts
├── analysis/
│   ├── decompiler.py      # SWF analysis
│   └── protocol.py        # Protocol analysis
└── accounts/
    └── store.py           # Account storage
```

## Security Notes
- Credentials stored with local encryption
- No hardcoded keys in code
- Session tokens handled securely
- Rate limiting on exploit tools
