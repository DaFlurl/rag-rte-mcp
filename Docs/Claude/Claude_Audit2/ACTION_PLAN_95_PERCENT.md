# 🎯 EVONY RTE 95% TARGET ACTION PLAN
## January 11, 2026 - Comprehensive Improvement Roadmap

---

## 📊 CURRENT VS TARGET SCORES

| Component          | Current | Target | Gap   | Priority   |
| ------------------ | ------- | ------ | ----- | ---------- |
| **Infrastructure** | 95/100  | 95+    | ✅ Met | -          |
| **RAG System**     | 80/100  | 95+    | +15   | 🔴 Critical |
| **RTE Toolkit**    | 90/100  | 95+    | +5    | 🟡 High     |
| **RE Tools**       | 90/100  | 95+    | +5    | 🟡 High     |
| **Documentation**  | 85/100  | 95+    | +10   | 🟠 Medium   |
| **Bot Server**     | 75/100  | 95+    | +20   | 🔴 Critical |

**Overall Current: 85.8/100 → Target: 95+**

---

## 🔴 RAG SYSTEM: 80 → 95 (+15 points)

### Issues Identified
1. ❌ Chunks contain questions, not actual code (empty citations)
2. ❌ evony_search returns empty results
3. ❌ evony_trace returns empty results
4. ⚠️ BM25 index mismatch with chunk data

### Action Items

#### Task R1: Rebuild Chunks with REAL Code Content (+8 points)
**Priority:** CRITICAL | **Effort:** 2-3 hours

```
Current: chunks.json contains question-based training data
Target: chunks.json contains actual code snippets with file paths

Steps:
1. Create new chunk extractor that reads actual AS3 files
2. Extract code blocks with proper context (function/class)
3. Include file_path, start_line, end_line, content
4. Rebuild BM25 index from new chunks
5. Test evony_search returns relevant code
```

**Files to modify:**
- Create: `evony_rag/extract_code_chunks.py`
- Update: `evony_rag/index/chunks.json`
- Rebuild: `evony_rag/index/bm25_index.json`

#### Task R2: Fix evony_search to Return Results (+3 points)
**Priority:** CRITICAL | **Effort:** 1 hour

```
Steps:
1. Verify BM25 index loads correctly on startup
2. Add debug logging to search pipeline
3. Test with simple queries
4. Verify chunk content is searchable text
```

#### Task R3: Fix evony_trace Knowledge Graph (+2 points)
**Priority:** HIGH | **Effort:** 1 hour

```
Current: trace() uses hybrid search but returns limited results
Fixed: Already improved in this session (30+ results)

Remaining:
1. Verify KG entity lookups work
2. Add multi-hop traversal tests
3. Validate relationship following
```

#### Task R4: Populate Citations in evony_answer (+2 points)
**Priority:** HIGH | **Effort:** 30 min

```
Steps:
1. Ensure search results include source file paths
2. Format citations with file:line references
3. Include relevance scores in citations
```

### RAG Verification Checklist
- [ ] `evony_stats` shows 10,000+ chunks (real code)
- [ ] `evony_search "AMF3"` returns 5+ results with code snippets
- [ ] `evony_answer` includes populated citations array
- [ ] `evony_trace` returns multi-hop results
- [ ] Search results include actual code, not questions

---

## 🟡 RTE TOOLKIT: 90 → 95 (+5 points)

### Issues Identified
1. ⚠️ Tool count was 48, now 60 (fixed)
2. ⚠️ Some handlers timeout on WSL operations
3. ⚠️ Missing failsafe for duplicate tool launches (fixed)

### Action Items

#### Task T1: Add Timeout Handling to All Handlers (+2 points)
**Priority:** HIGH | **Effort:** 1 hour

```python
# Add to mcp_server.py
HANDLER_TIMEOUT = 30  # seconds

def handle_with_timeout(handler_func, args, timeout=HANDLER_TIMEOUT):
    try:
        return handler_func(args)
    except TimeoutError:
        return {"error": f"Operation timed out after {timeout}s"}
```

#### Task T2: Add Handler Response Validation (+1 point)
**Priority:** MEDIUM | **Effort:** 30 min

```python
# Ensure all handlers return valid JSON
def validate_handler_response(response):
    if response is None:
        return {"error": "Handler returned None"}
    if not isinstance(response, dict):
        return {"result": response}
    return response
```

#### Task T3: Add Error Recovery for WSL Operations (+2 points)
**Priority:** HIGH | **Effort:** 1 hour

```python
def run_wsl_with_retry(cmd, retries=3):
    for attempt in range(retries):
        result = run_wsl_command(cmd)
        if not result.get("error"):
            return result
        time.sleep(1)
    return {"error": f"WSL operation failed after {retries} attempts"}
```

### RTE Verification Checklist
- [ ] All 60 handlers respond without timeout
- [ ] WSL tools (zeek, ngrep, tcpflow) work reliably
- [ ] Error messages are clear and actionable
- [ ] No handlers return None or invalid responses

---

## 🟡 RE TOOLS: 90 → 95 (+5 points)

### Issues Identified
1. ❌ Flasm missing (using FFDec instead)
2. ⚠️ Ghidra was launching GUI on version check (fixed)
3. ⚠️ Process detection had false positives (fixed)

### Action Items

#### Task E1: Install Flasm or Document Alternative (+2 points)
**Priority:** MEDIUM | **Effort:** 30 min

```powershell
# Option A: Install Flasm
choco install flasm

# Option B: Document FFDec as replacement
# FFDec provides all flasm functionality via:
# - P-code disassembly
# - Direct ABC editing
# - Script export/import
```

#### Task E2: Add Tool Health Check Endpoint (+2 points)
**Priority:** HIGH | **Effort:** 30 min

```python
def handle_re_tools_health(args: Dict) -> Dict:
    """Check health of all RE tools"""
    health = {}
    tools = ["ffdec", "ghidra", "radare2", "wireshark", "tshark"]
    
    for tool in tools:
        status = get_tool_status(tool)
        running = check_tool_running(tool)
        health[tool] = {
            "installed": status.get("installed", False),
            "running": running.get("running", False),
            "path": status.get("path", "N/A")
        }
    
    return {"tools": health, "total": len(tools), "healthy": sum(1 for t in health.values() if t["installed"])}
```

#### Task E3: Verify All Tool Integrations Work (+1 point)
**Priority:** MEDIUM | **Effort:** 30 min

```
Test each tool:
1. FFDec: decompile SWF → verify AS3 output
2. Ghidra: headless analysis → verify function list
3. Radare2: binary analysis → verify strings
4. Wireshark/tshark: packet capture → verify PCAP
5. WSL tools: zeek, ngrep, tcpflow → verify output
```

### RE Tools Verification Checklist
- [ ] 10/10 tools installed and working
- [ ] All tools respond to health check
- [ ] No duplicate process launches possible
- [ ] Tool paths correctly configured

---

## 🟠 DOCUMENTATION: 85 → 95 (+10 points)

### Issues Identified
1. ⚠️ Some API endpoints undocumented
2. ⚠️ Missing troubleshooting guide
3. ⚠️ No quick-start guide for new users

### Action Items

#### Task D1: Create API Reference Document (+3 points)
**Priority:** HIGH | **Effort:** 1 hour

```markdown
# Create: Docs/API_REFERENCE.md

## evony-knowledge MCP Tools
| Tool         | Parameters | Returns           | Example |
| ------------ | ---------- | ----------------- | ------- |
| evony_search | query, k   | results[]         | ...     |
| evony_answer | question   | answer, citations | ...     |
...

## evony-rte MCP Tools
| Tool          | Parameters   | Returns | Example |
| ------------- | ------------ | ------- | ------- |
| packet_decode | data, format | decoded | ...     |
...
```

#### Task D2: Create Troubleshooting Guide (+3 points)
**Priority:** HIGH | **Effort:** 1 hour

```markdown
# Create: Docs/TROUBLESHOOTING.md

## Common Issues

### RAG Returns Empty Results
1. Check: evony_stats shows chunks > 0
2. Check: BM25 index exists
3. Fix: Run rebuild_bm25.py

### Tool Launch Fails
1. Check: running_tools shows status
2. Check: Tool path exists
3. Fix: Reinstall via chocolatey

### Bot Server Won't Start
1. Check: Port 9999 not in use
2. Check: Python environment
3. Fix: netstat -ano | findstr 9999
```

#### Task D3: Create Quick-Start Guide (+2 points)
**Priority:** MEDIUM | **Effort:** 30 min

```markdown
# Create: Docs/QUICK_START.md

## 5-Minute Setup

1. Start LM Studio, load evony-7b model
2. Start Bot Server: python evony_bot/server.py
3. Open Claude Desktop
4. Use evony_search to query codebase
5. Use evony_answer for AI-powered analysis
```

#### Task D4: Update Existing Docs with Fixes (+2 points)
**Priority:** MEDIUM | **Effort:** 30 min

```
Update:
- DOCUMENTATION_INDEX.md - Add new docs
- README.md - Add quick-start section
- Audit reports - Mark issues as fixed
```

### Documentation Verification Checklist
- [ ] All 60 MCP handlers documented
- [ ] Troubleshooting guide covers common issues
- [ ] Quick-start guide tested by fresh user
- [ ] All docs linked from index

---

## 🔴 BOT SERVER: 75 → 95 (+20 points)

### Issues Identified
1. ❌ Manual start required (no auto-start)
2. ⚠️ No health monitoring
3. ⚠️ No graceful shutdown
4. ⚠️ Limited error handling

### Action Items

#### Task B1: Create Auto-Start Script (+5 points)
**Priority:** CRITICAL | **Effort:** 30 min

```powershell
# Create: scripts/start_bot_server.ps1

$botPath = "C:\Users\Admin\Downloads\Evony_Decrypted\evony_bot"
$pythonExe = "C:\Python313\python.exe"

# Check if already running
$existing = Get-Process -Name python -ErrorAction SilentlyContinue | 
    Where-Object { $_.CommandLine -like "*server.py*" }

if ($existing) {
    Write-Host "Bot server already running (PID: $($existing.Id))"
    exit 0
}

# Start server
Start-Process -FilePath $pythonExe `
    -ArgumentList "server.py" `
    -WorkingDirectory $botPath `
    -WindowStyle Hidden

# Wait and verify
Start-Sleep -Seconds 3
try {
    $response = Invoke-WebRequest -Uri "http://localhost:9999/api/status" -TimeoutSec 5
    Write-Host "Bot server started successfully"
} catch {
    Write-Host "Bot server failed to start"
    exit 1
}
```

#### Task B2: Add Health Check Endpoint (+3 points)
**Priority:** HIGH | **Effort:** 30 min

```python
# Add to evony_bot/server.py

@app.route('/api/health')
def health_check():
    return jsonify({
        "status": "healthy",
        "uptime": time.time() - start_time,
        "connections": len(active_connections),
        "memory_mb": psutil.Process().memory_info().rss / 1024 / 1024
    })
```

#### Task B3: Add Graceful Shutdown (+3 points)
**Priority:** HIGH | **Effort:** 30 min

```python
# Add to evony_bot/server.py

import signal
import atexit

def graceful_shutdown(signum=None, frame=None):
    logger.info("Shutting down gracefully...")
    # Close all connections
    for conn in active_connections:
        conn.close()
    # Save state if needed
    save_session_state()
    logger.info("Shutdown complete")
    sys.exit(0)

signal.signal(signal.SIGTERM, graceful_shutdown)
signal.signal(signal.SIGINT, graceful_shutdown)
atexit.register(graceful_shutdown)
```

#### Task B4: Add Connection Retry Logic (+3 points)
**Priority:** HIGH | **Effort:** 30 min

```python
# Add to evony_bot/server.py

def connect_with_retry(host, port, max_retries=3):
    for attempt in range(max_retries):
        try:
            sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            sock.connect((host, port))
            return sock
        except Exception as e:
            logger.warning(f"Connection attempt {attempt+1} failed: {e}")
            time.sleep(2 ** attempt)  # Exponential backoff
    raise ConnectionError(f"Failed to connect after {max_retries} attempts")
```

#### Task B5: Add Request Logging (+3 points)
**Priority:** MEDIUM | **Effort:** 30 min

```python
# Add to evony_bot/server.py

import logging
from datetime import datetime

logging.basicConfig(
    filename='bot_server.log',
    level=logging.INFO,
    format='%(asctime)s [%(levelname)s] %(message)s'
)

@app.before_request
def log_request():
    logging.info(f"REQUEST: {request.method} {request.path} from {request.remote_addr}")

@app.after_request
def log_response(response):
    logging.info(f"RESPONSE: {response.status_code}")
    return response
```

#### Task B6: Add Status Dashboard (+3 points)
**Priority:** MEDIUM | **Effort:** 1 hour

```python
# Add to evony_bot/server.py

@app.route('/dashboard')
def dashboard():
    return render_template('dashboard.html', 
        status="running",
        uptime=get_uptime(),
        connections=len(active_connections),
        requests_today=request_counter,
        last_error=last_error_message
    )
```

### Bot Server Verification Checklist
- [ ] Server auto-starts with script
- [ ] /api/health returns status
- [ ] Graceful shutdown on SIGTERM
- [ ] Connection retries on failure
- [ ] All requests logged
- [ ] Dashboard accessible

---

## 📅 IMPLEMENTATION SCHEDULE

### Phase 1: Critical Fixes (Day 1) - Target: 88%
| Time | Task                    | Component | Points |
| ---- | ----------------------- | --------- | ------ |
| 0-2h | R1: Rebuild code chunks | RAG       | +8     |
| 2-3h | B1: Auto-start script   | Bot       | +5     |
| 3-4h | R2: Fix evony_search    | RAG       | +3     |

### Phase 2: High Priority (Day 2) - Target: 93%
| Time | Task                     | Component | Points |
| ---- | ------------------------ | --------- | ------ |
| 0-1h | T1: Timeout handling     | RTE       | +2     |
| 1-2h | B2-B3: Health + Shutdown | Bot       | +6     |
| 2-3h | D1: API Reference        | Docs      | +3     |
| 3-4h | E1-E2: Flasm + Health    | RE        | +4     |

### Phase 3: Polish (Day 3) - Target: 95%+
| Time | Task                     | Component | Points |
| ---- | ------------------------ | --------- | ------ |
| 0-1h | R3-R4: Trace + Citations | RAG       | +4     |
| 1-2h | B4-B6: Retry + Logging   | Bot       | +9     |
| 2-3h | D2-D4: Troubleshooting   | Docs      | +7     |
| 3-4h | T2-T3: Validation        | RTE       | +3     |

---

## ✅ FINAL VERIFICATION

### Target Scores (95%+ each)
| Component      | Current  | After Phase 1 | After Phase 2 | Final      |
| -------------- | -------- | ------------- | ------------- | ---------- |
| Infrastructure | 95       | 95            | 95            | 95 ✅       |
| RAG System     | 80       | 91            | 94            | 96 ✅       |
| RTE Toolkit    | 90       | 90            | 94            | 97 ✅       |
| RE Tools       | 90       | 90            | 96            | 96 ✅       |
| Documentation  | 85       | 85            | 93            | 97 ✅       |
| Bot Server     | 75       | 80            | 91            | 97 ✅       |
| **OVERALL**    | **85.8** | **88.5**      | **93.8**      | **96.3 ✅** |

### Sign-Off Checklist
- [ ] All components at 95%+
- [ ] No critical bugs remaining
- [ ] All handlers respond correctly
- [ ] Documentation complete
- [ ] Bot server production-ready
- [ ] RAG returns useful results

---

## 🚀 IMMEDIATE NEXT STEPS

1. **START NOW:** Task R1 - Rebuild chunks with real code
2. **THEN:** Task B1 - Create auto-start script
3. **THEN:** Task R2 - Fix evony_search

**Estimated time to 95%: 8-12 hours of focused work**

---

*Generated: January 11, 2026 | Target: 95%+ All Components*
*Manual Bot Server: As Requested - No Auto-Connect*
