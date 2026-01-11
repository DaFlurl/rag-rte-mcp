# Evony RTE - Complete Requirements & Missing Tools

## 🎯 Goal: End-to-End Reverse Engineering & Exploit Testing

Complete system that allows Claude/Windsurf to:
1. Search/analyze decompiled client code
2. Capture/decode/replay network packets
3. Test exploits with verification
4. Cross-reference client ↔ server code
5. Generate exploit reports

---

## 📊 CURRENT STATE (32 tools)

### evony-knowledge (7 tools) ✅
- `evony_search` - Hybrid search ✅
- `evony_answer` - RAG answers ✅
- `evony_open` - Open files ✅
- `evony_symbol` - Symbol lookup ✅
- `evony_trace` - Concept tracing ✅
- `evony_mode` - Set mode ✅
- `evony_stats` - Statistics ✅
- **BUG FIXED:** encoding error in semantic search

### evony-rte (25 tools) 🆕
- 8 implemented, 17 skeleton

---

## 🔴 ALL MISSING TOOLS (43 tools needed)

### Category 1: Packet Analysis (12 tools)
| Tool | Purpose | Dependency |
|------|---------|------------|
| `tshark_capture` | Capture live traffic | tshark |
| `tshark_filter` | Filter captured packets | tshark |
| `tshark_export` | Export to JSON/PCAP | tshark |
| `amf3_decode_full` | Complete AMF3 decoding | pyamf |
| `amf3_encode_full` | Complete AMF3 encoding | pyamf |
| `packet_diff` | Compare two packets | - |
| `packet_fuzz` | Fuzz packet fields | - |
| `packet_template` | Create packet templates | - |
| `ssl_intercept` | SSL/TLS MITM | mitmproxy |
| `proxy_start` | Start intercept proxy | mitmproxy |
| `proxy_inject` | Inject via proxy | mitmproxy |
| `websocket_capture` | WebSocket traffic | - |

### Category 2: Client Analysis (10 tools)
| Tool | Purpose | Dependency |
|------|---------|------------|
| `jpexs_decompile` | Decompile SWF | JPEXS |
| `jpexs_extract` | Extract assets | JPEXS |
| `jpexs_search` | Search decompiled | JPEXS |
| `ast_parse` | Parse AS3 to AST | - |
| `ast_callgraph` | Generate call graphs | - |
| `ast_dataflow` | Data flow analysis | - |
| `swf_diff` | Diff SWF versions | JPEXS |
| `swf_patch` | Patch SWF binary | - |
| `strings_extract` | Extract all strings | - |
| `crypto_analyze` | Find crypto/keys | - |

### Category 3: Memory/Runtime (8 tools)
| Tool | Purpose | Dependency |
|------|---------|------------|
| `memory_scan` | Scan process memory | pymem |
| `memory_read` | Read memory address | pymem |
| `memory_write` | Write memory address | pymem |
| `memory_pattern` | Find patterns | pymem |
| `memory_watch` | Watch value changes | pymem |
| `process_list` | List game processes | psutil |
| `process_inject` | Inject DLL/code | - |
| `debugger_attach` | Attach debugger | - |

### Category 4: Game Integration (8 tools)
| Tool | Purpose | Dependency |
|------|---------|------------|
| `game_login_full` | Full login with anti-bot | - |
| `game_heartbeat` | Keepalive packets | - |
| `game_batch_send` | Send command batch | - |
| `game_state_snapshot` | Snapshot all state | - |
| `game_state_diff` | Diff two snapshots | - |
| `game_verify_exploit` | Verify exploit worked | - |
| `game_rollback` | Rollback state | - |
| `game_multi_account` | Multi-account support | - |

### Category 5: Cross-Reference (5 tools)
| Tool | Purpose | Dependency |
|------|---------|------------|
| `xref_db_init` | Initialize xref DB | sqlite3 |
| `xref_add_mapping` | Add client↔server map | sqlite3 |
| `xref_query` | Query mappings | sqlite3 |
| `xref_validation_points` | Find validation | - |
| `xref_auto_discover` | Auto-discover links | - |

---

## 📦 EXTERNAL DEPENDENCIES

### Must Install:
```bash
# Network Analysis
pip install pyshark scapy mitmproxy

# Packet Decoding
pip install pyamf

# Memory Analysis
pip install pymem psutil

# Database
pip install sqlite3  # Usually built-in

# Additional
pip install pycryptodome  # For crypto analysis
```

### External Tools:
```
1. tshark/Wireshark - https://www.wireshark.org/download.html
   - Required for: tshark_capture, tshark_filter, tshark_export
   - Install: choco install wireshark

2. JPEXS Free Flash Decompiler - https://github.com/jindrapetrik/jpexs-decompiler
   - Required for: jpexs_decompile, jpexs_extract, jpexs_search, swf_diff
   - Install: Download from releases

3. mitmproxy - https://mitmproxy.org/
   - Required for: ssl_intercept, proxy_start, proxy_inject
   - Install: pip install mitmproxy

4. Npcap - https://npcap.com/
   - Required for: Raw packet capture on Windows
   - Install: Download installer
```

---

## 🏗️ IMPLEMENTATION PLAN

### Phase 1: Core Infrastructure (Week 1)
1. ✅ Fix evony-knowledge RAG bug
2. ✅ Create evony-rte basic MCP server
3. 🔧 Add tshark integration
4. 🔧 Add JPEXS integration
5. 🔧 Add full AMF3 decode/encode

### Phase 2: Network Layer (Week 2)
1. Real packet capture with tshark
2. MITM proxy for SSL traffic
3. Packet replay with modifications
4. WebSocket support

### Phase 3: Memory Layer (Week 3)
1. Process memory scanning
2. Value watching
3. Pattern matching
4. Basic injection

### Phase 4: Integration (Week 4)
1. Cross-reference database
2. Full game integration
3. Exploit verification
4. Report generation

---

## 📋 IMMEDIATE ACTION ITEMS

### Step 1: Install Dependencies
```powershell
# Install Python packages
pip install pyshark scapy pymem psutil pycryptodome

# Install tshark (requires admin)
choco install wireshark -y

# Download JPEXS
# https://github.com/jindrapetrik/jpexs-decompiler/releases
```

### Step 2: Add Tools to evony-rte
I will now add the missing tools to the evony-rte MCP server.

### Step 3: Test
After adding tools, restart Claude Desktop and test.

---

## 📊 TOOL COUNT SUMMARY

| Category | Current | Missing | Total Needed |
|----------|---------|---------|--------------|
| Packet Analysis | 5 | 12 | 17 |
| Client Analysis | 4 | 10 | 14 |
| Memory/Runtime | 0 | 8 | 8 |
| Game Integration | 5 | 8 | 13 |
| Cross-Reference | 3 | 5 | 8 |
| Exploit Testing | 4 | 0 | 4 |
| Utility | 4 | 0 | 4 |
| **TOTAL** | **25** | **43** | **68** |

**Current: 32 tools (evony-knowledge + evony-rte)**
**Missing: 43 tools**
**Complete System: 75 tools**
