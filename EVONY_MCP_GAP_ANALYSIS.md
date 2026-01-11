# Evony MCP Tools - Gap Analysis & Roadmap

## Current MCP Servers (4 Total)

### 1. evony-knowledge (RAG) - 7 tools ✅
| Tool | Purpose | Status |
|------|---------|--------|
| `evony_search` | Hybrid lexical+semantic search | ✅ Working |
| `evony_answer` | RAG-powered answers with citations | ✅ Working |
| `evony_open` | Open files from knowledge base | ✅ Working |
| `evony_symbol` | Find symbol definitions | ✅ Working |
| `evony_trace` | Multi-hop concept tracing | ✅ Working |
| `evony_mode` | Set query mode (research/forensics/full_access) | ✅ Working |
| `evony_stats` | Knowledge base statistics | ✅ Working |

### 2. evony-rte (Real-Time Engineering) - 25 tools 🆕
| Tool | Purpose | Status |
|------|---------|--------|
| `packet_capture` | Start/stop packet capture | ✅ Implemented |
| `packet_decode` | Decode AMF3 packets | ✅ Implemented |
| `packet_encode` | Encode data to AMF3 | ✅ Implemented |
| `packet_replay` | Replay captured packets | 🔧 Skeleton |
| `packet_inject` | Inject custom packets | 🔧 Skeleton |
| `client_search` | Search decompiled AS3 code | ✅ Implemented |
| `client_decompile` | Decompile SWF/class | 🔧 Skeleton |
| `client_callgraph` | Generate call graphs | 🔧 Skeleton |
| `client_strings` | Extract strings from client | 🔧 Skeleton |
| `exploit_list` | List known exploits | ✅ Implemented |
| `exploit_test` | Test exploit with verification | ✅ Implemented |
| `exploit_create` | Create new exploit template | 🔧 Skeleton |
| `exploit_scan` | Scan for vulnerabilities | 🔧 Skeleton |
| `game_connect` | Connect to game server | 🔧 Skeleton |
| `game_status` | Get connection status | ✅ Implemented |
| `game_resources` | Get resource counts | 🔧 Skeleton |
| `game_troops` | Get troop counts | 🔧 Skeleton |
| `game_send` | Send raw command | 🔧 Skeleton |
| `xref_client_server` | Cross-reference client→server | 🔧 Skeleton |
| `xref_packet_handler` | Find packet handlers | 🔧 Skeleton |
| `xref_validation` | Find validation points | 🔧 Skeleton |
| `diff_versions` | Compare client versions | 🔧 Skeleton |
| `analyze_protocol` | Analyze protocol structure | 🔧 Skeleton |
| `find_vulnerabilities` | Auto-scan for vulns | 🔧 Skeleton |
| `rte_stats` | RTE system stats | ✅ Implemented |

### 3. verda-cloud - 28 tools ✅
GPU cloud management (not Evony-specific)

### 4. Windows-MCP - 10 tools ✅
Windows system tools

---

## 🔴 CRITICAL GAPS - What's Missing

### Gap 1: Live Game Integration (Priority: HIGH)
**Problem:** Can search code but can't interact with live game from MCP
**Missing Tools:**
- `game_login` - Full login flow with anti-bot measures
- `game_heartbeat` - Maintain connection keepalive
- `game_batch_cmd` - Send multiple commands with proper timing
- `game_verify_state` - Before/after state verification

**Solution:** Integrate `evony_bot/server.py` functionality into MCP

### Gap 2: Packet Capture/Injection (Priority: HIGH)
**Problem:** Can't capture real traffic from game client
**Missing:**
- Wireshark integration or raw socket capture
- MITM proxy for SSL traffic
- Packet modification in-flight

**Solution:** Add pcap library + mitmproxy integration

### Gap 3: SWF Decompilation Automation (Priority: MEDIUM)
**Problem:** AS3 scripts are static, can't decompile new SWFs
**Missing:**
- JPEXS CLI integration
- Auto-index new decompiled code
- Diff between SWF versions

**Solution:** Add JPEXS wrapper + auto-indexer

### Gap 4: Exploit Verification (Priority: HIGH)
**Problem:** Can't verify if exploits actually worked
**Missing:**
- State snapshots before/after
- Resource/troop diff calculator
- Success criteria checker

**Solution:** Add verification layer to exploit_test

### Gap 5: Cross-Reference Database (Priority: MEDIUM)
**Problem:** No mapping between client functions ↔ server handlers
**Missing:**
- SQLite DB for mappings
- Auto-discovery of client→server links
- Validation point tracker

**Solution:** Build cross-ref database with known mappings

---

## 📊 Tool Count Summary

| MCP Server | Implemented | Skeleton | Total |
|------------|-------------|----------|-------|
| evony-knowledge | 7 | 0 | 7 |
| evony-rte | 8 | 17 | 25 |
| **Evony Total** | **15** | **17** | **32** |

### Tools Still Needed for Complete Coverage: ~15 more

1. **game_login** - Full authenticated connection
2. **game_heartbeat** - Connection keepalive
3. **game_batch_cmd** - Timed command batches
4. **game_verify_state** - State verification
5. **capture_traffic** - Real packet capture
6. **mitm_setup** - SSL interception
7. **swf_decompile** - JPEXS automation
8. **swf_diff** - Version comparison
9. **db_xref_add** - Add cross-reference
10. **db_xref_query** - Query cross-references
11. **exploit_verify** - Verify exploit success
12. **exploit_batch** - Run multiple exploits
13. **vuln_scan_deep** - Deep vulnerability scan
14. **protocol_fuzz** - Protocol fuzzing
15. **report_generate** - Generate exploit reports

---

## 🎯 Implementation Priority

### Phase 1: Core Functionality (This Week)
1. ✅ evony-rte basic structure
2. 🔧 Integrate bot server commands into MCP
3. 🔧 Add state verification to exploit_test
4. 🔧 Complete client_search with better indexing

### Phase 2: Live Integration (Next Week)
1. Full game_connect with anti-bot
2. packet_capture with real traffic
3. exploit_verify with before/after

### Phase 3: Advanced Analysis (Later)
1. Cross-reference database
2. JPEXS automation
3. Protocol fuzzing

---

## 🚀 Quick Start

**Restart Claude Desktop** to load new evony-rte server.

Then try:
```
Use evony-rte to list all exploits
Use evony-rte to search client code for "produceTroop"
Use evony-rte to get RTE stats
```
