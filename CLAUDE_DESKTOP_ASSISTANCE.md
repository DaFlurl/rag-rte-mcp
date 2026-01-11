# Evony RTE MCP Server - Claude Desktop Assistance Request

## Project Overview
- **Location**: `C:\Users\Admin\Downloads\Evony_Decrypted\evony_rte`
- **Purpose**: Reverse engineering toolkit for Evony Age II game protocol
- **MCP Handlers**: 55 total handlers for packet analysis, exploit testing, game interaction
- **RAG Knowledge Base**: 166,043 chunks of Evony-specific knowledge

## Current Status
- **55 handlers defined** in `mcp_server.py`
- **Bot server** available at `evony_bot/server.py`
- **FFDec via WSL** for SWF decompilation (Windows GUI disabled)
- **AMF3 encoding/decoding** implemented

## Critical Requirements (STRICT)
1. **NO MOCKED DATA** - All responses must be real
2. **NO SIMULATED DATA** - Only actual game protocol data
3. **NO FAKE DATA** - Production-ready code only
4. **BOT SERVER ALWAYS RUNNING** - Integrated with MCP server
5. **RAG ALWAYS ACTIVE** - Query for Evony-specific knowledge

## Issues Needing Assistance

### Issue 1: Handler Testing Without Live Connection
**Problem**: Some handlers return errors when bot server or proxy isn't connected
**Affected Handlers**:
- `game_send` - Returns "Not connected to server"
- `packet_inject` - Returns "Not connected to server" 
- `packet_replay` - Requires captured packets

**Solution Needed**: 
- Bot server must auto-start with MCP
- All handlers must work with real server connection
- No fallback to mock responses

### Issue 2: Bot Server Integration
**Location**: `C:\Users\Admin\Downloads\Evony_Decrypted\evony_bot\server.py`
**Current State**: Standalone server, not integrated with MCP
**Needed**:
- Auto-start bot server when MCP initializes
- Auto-switch ports if port in use (9999, 9998, 9997...)
- Keep server running as long as MCP is active
- Restart if server crashes

### Issue 3: WSL Tool Installation Failed
**Tools that failed to compile**:
- `swftools` - Compilation errors (undefined references)
- `flasm` - Type conflicts in gperf output

**Error from dpkg**:
```
Errors were encountered while processing: postfix
E: Sub-process /usr/bin/dpkg returned an error code (1)
```

**Workaround Applied**: Using FFDec via WSL as alternative
**Location**: `/opt/ffdec/ffdec.sh` in WSL Ubuntu

### Issue 4: RAG Integration
**RAG MCP Tool**: `evony-knowledge` 
**Stats**: 166,043 chunks, 55,871 symbols
**Modes**: research, forensics, full_access

**Needed**: RAG should be queried automatically when:
- Fixing handler issues
- Looking up Evony protocol commands
- Finding real packet data examples

## Key Files

### MCP Server
```
C:\Users\Admin\Downloads\Evony_Decrypted\evony_rte\
├── mcp_server.py          # Main MCP server with 55 handlers
├── advanced_re_tools.py   # RE tool integrations
├── proxy_hook.py          # Traffic interception proxy
├── amf3_tools.py          # AMF3 encoding/decoding
├── tool_integration.py    # External tool wrappers
├── server_launcher.py     # CLI for Windsurf/Claude
└── integrated_bot_server.py # Auto-starting bot server
```

### Bot Server
```
C:\Users\Admin\Downloads\Evony_Decrypted\evony_bot\
├── server.py              # Main bot server (102KB)
├── exploit_implementations.py
└── requirements.txt
```

### Test Files
```
C:\Users\Admin\Downloads\Evony_Decrypted\evony_rte\
├── test_all_tools.py      # Basic handler test
├── test_comprehensive.py  # Full parameter testing
└── AutoEvony.swf          # Test SWF file
```

## Handler Categories

### Packet Tools (working)
- `packet_capture`, `packet_decode`, `packet_encode`

### Game Tools (need live connection)
- `game_send`, `game_status`, `game_connect`, `game_resources`, `game_troops`

### Exploit Tools (working)
- `exploit_list`, `exploit_test`, `exploit_scan`, `exploit_create`

### RE Tools (working via FFDec)
- `ffdec`, `swf_extract`, `flasm_disasm`, `rabcdasm_export`

### Proxy Tools (need AutoEvony running)
- `proxy_start`, `proxy_stop`, `proxy_inject`, `packet_inject`, `packet_replay`

## Commands for Testing

### Start Bot Server
```powershell
cd C:\Users\Admin\Downloads\Evony_Decrypted\evony_bot
C:\Python313\python.exe server.py
```

### Run Handler Tests
```powershell
cd C:\Users\Admin\Downloads\Evony_Decrypted
C:\Python313\python.exe evony_rte\test_comprehensive.py
```

### Use Server Launcher CLI
```powershell
cd C:\Users\Admin\Downloads\Evony_Decrypted
C:\Python313\python.exe -m evony_rte.server_launcher start
C:\Python313\python.exe -m evony_rte.server_launcher status
C:\Python313\python.exe -m evony_rte.server_launcher test
```

### Query Evony RAG
Use MCP tool `mcp0_evony_search` with queries like:
- "AMF3 packet format encoding"
- "troop produceTroop command parameters"
- "city.getInfo response structure"

## Goal
**55/55 handlers passing with ZERO errors**
- All handlers return real data
- Bot server always running
- RAG actively assisting
- Production-ready code

## Contact
For questions about this project, query the Evony RAG knowledge base or examine the source files listed above.
