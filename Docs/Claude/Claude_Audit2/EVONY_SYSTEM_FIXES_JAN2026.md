# 🔧 EVONY RTE SYSTEM FIXES & RECOMMENDATIONS
## January 11, 2026 - Technical Implementation Guide

---

## 🚨 CRITICAL FIXES REQUIRED

### Fix 1: RAG Chunk Count Bug

**Location:** `evony_rag/mcp_server_v2.py` or `precision_rag.py`

**Problem:** `evony_stats` reports 1 chunk instead of ~17,000

**Root Cause:** Code counts file lines, not JSON array elements

**Current Code (Broken):**
```python
def get_chunk_count(self):
    with open(self.chunks_path) as f:
        return len(f.readlines())  # Returns 1 for single-line JSON
```

**Fixed Code:**
```python
import json

def get_chunk_count(self):
    with open(self.chunks_path, 'r', encoding='utf-8') as f:
        chunks = json.load(f)
        return len(chunks) if isinstance(chunks, list) else 1
```

**File to Modify:** 
- `C:\Users\Admin\Downloads\Evony_Decrypted\evony_rag\mcp_server_v2.py`
- Search for `evony_stats` handler or `get_chunk_count`

---

### Fix 2: Empty Search Results

**Location:** `evony_rag/precision_rag.py`

**Problem:** `evony_search` returns empty results array

**Possible Causes:**
1. BM25 index not loading on startup
2. Query preprocessing strips all terms
3. Index path misconfigured

**Debug Steps:**
```python
# Add to precision_rag.py for debugging
import logging
logging.basicConfig(level=logging.DEBUG)

class PrecisionRAG:
    def __init__(self):
        self.logger = logging.getLogger(__name__)
        self.load_indices()
    
    def load_indices(self):
        self.logger.debug(f"Loading chunks from {self.chunks_path}")
        # ... existing code ...
        self.logger.debug(f"Loaded {len(self.chunks)} chunks")
        self.logger.debug(f"BM25 index has {len(self.bm25_index)} terms")
```

**Fix if BM25 not loading:**
```python
def load_bm25(self):
    try:
        with open(self.bm25_path, 'r', encoding='utf-8') as f:
            self.bm25_data = json.load(f)
        # Verify structure
        if 'term_freqs' not in self.bm25_data:
            self.rebuild_bm25()
    except Exception as e:
        self.logger.error(f"BM25 load failed: {e}")
        self.rebuild_bm25()
```

---

### Fix 3: Empty Knowledge Graph Trace

**Location:** `evony_rag/knowledge_graph.py`

**Problem:** `evony_trace` returns empty trace array

**Debug:**
```python
def trace(self, topic, depth=3):
    self.logger.debug(f"Tracing '{topic}' with depth {depth}")
    self.logger.debug(f"KG has {len(self.entities)} entities")
    
    # Check if topic exists
    matches = [e for e in self.entities if topic.lower() in e.lower()]
    self.logger.debug(f"Found {len(matches)} matches for '{topic}'")
    
    if not matches:
        return {"trace": [], "message": f"No entities matching '{topic}'"}
    
    # Continue with traversal...
```

**Fix if KG not loading:**
```python
def load_kg(self):
    kg_path = os.path.join(self.index_dir, 'kg_full.json')
    if not os.path.exists(kg_path):
        self.logger.warning("kg_full.json not found, creating empty KG")
        self.entities = {}
        self.relationships = []
        return
    
    with open(kg_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
        self.entities = data.get('entities', {})
        self.relationships = data.get('relationships', [])
    
    self.logger.info(f"Loaded KG: {len(self.entities)} entities, {len(self.relationships)} rels")
```

---

### Fix 4: Empty Citations in evony_answer

**Location:** `evony_rag/precision_rag.py` or `citation_formatter.py`

**Problem:** Answer generated but citations array is empty

**Fix:**
```python
def answer_with_citations(self, question):
    # Get relevant chunks
    results = self.search(question, k=5)
    
    if not results:
        return self.llm_only_answer(question)
    
    # Build context
    context = "\n\n".join([r['content'] for r in results])
    
    # Generate answer
    answer = self.llm.generate(
        system="Answer based on context. Cite sources.",
        user=f"Context:\n{context}\n\nQuestion: {question}"
    )
    
    # Extract citations - ENSURE THIS RUNS
    citations = []
    for i, r in enumerate(results):
        citations.append({
            "source": r.get('source', 'unknown'),
            "chunk_id": r.get('id', i),
            "relevance": r.get('score', 0.0)
        })
    
    return {
        "answer": answer,
        "citations": citations,  # Now populated
        "mode": self.mode,
        "model": "lmstudio"
    }
```

---

## ⚠️ HIGH PRIORITY FIXES

### Fix 5: Bot Server Auto-Start

**Problem:** Bot server requires manual start

**Solution - PowerShell Startup Script:**

Create `C:\Users\Admin\Downloads\Evony_Decrypted\scripts\start_all.ps1`:

```powershell
# start_all.ps1 - Start all Evony services

$evonyRoot = "C:\Users\Admin\Downloads\Evony_Decrypted"
$pythonExe = "C:\Python313\python.exe"

Write-Host "Starting Evony Services..." -ForegroundColor Cyan

# 1. Start Bot Server
Write-Host "Starting Bot Server..." -ForegroundColor Yellow
Start-Process -FilePath $pythonExe `
    -ArgumentList "server.py" `
    -WorkingDirectory "$evonyRoot\evony_bot" `
    -WindowStyle Minimized

Start-Sleep -Seconds 2

# 2. Verify Bot Server
try {
    $response = Invoke-WebRequest -Uri "http://localhost:9999/api/status" -TimeoutSec 5
    Write-Host "Bot Server: RUNNING" -ForegroundColor Green
} catch {
    Write-Host "Bot Server: FAILED TO START" -ForegroundColor Red
}

# 3. Check LM Studio
try {
    $lmResponse = Invoke-WebRequest -Uri "http://localhost:1234/v1/models" -TimeoutSec 5
    Write-Host "LM Studio: RUNNING" -ForegroundColor Green
} catch {
    Write-Host "LM Studio: NOT RUNNING (start manually)" -ForegroundColor Yellow
}

Write-Host "`nAll services initialized!" -ForegroundColor Cyan
```

**Add to Windows Startup:**
```powershell
$startup = [Environment]::GetFolderPath('Startup')
Copy-Item "$evonyRoot\scripts\start_all.ps1" "$startup\evony_autostart.ps1"
```

---

### Fix 6: MCP Handler Timeouts

**Problem:** evony-rte handlers timing out in Claude Desktop

**Possible Causes:**
1. Long-running WSL operations
2. Network tool timeouts
3. Large file processing

**Fix - Add timeout handling:**
```python
import asyncio
from concurrent.futures import ThreadPoolExecutor, TimeoutError

class RTEHandler:
    def __init__(self):
        self.executor = ThreadPoolExecutor(max_workers=4)
        self.timeout = 30  # seconds
    
    async def handle_with_timeout(self, tool_name, params):
        loop = asyncio.get_event_loop()
        try:
            result = await asyncio.wait_for(
                loop.run_in_executor(
                    self.executor,
                    self.handlers[tool_name],
                    params
                ),
                timeout=self.timeout
            )
            return result
        except TimeoutError:
            return {
                "error": f"Operation timed out after {self.timeout}s",
                "tool": tool_name,
                "suggestion": "Try with smaller input or check tool availability"
            }
```

---

## 📝 RECOMMENDED IMPROVEMENTS

### Improvement 1: Automated Test Suite

Create `C:\Users\Admin\Downloads\Evony_Decrypted\tests\test_all_handlers.py`:

```python
#!/usr/bin/env python3
"""Automated test suite for Evony MCP servers"""

import json
import requests
import sys
from datetime import datetime

class EvonyTester:
    def __init__(self):
        self.results = []
        self.passed = 0
        self.failed = 0
    
    def test_rag(self):
        """Test RAG handlers"""
        tests = [
            ("evony_stats", {}, lambda r: "chunks" in r),
            ("evony_mode", {"mode": "full_access"}, lambda r: r.get("mode") == "full_access"),
            ("evony_answer", {"question": "What is AMF3?"}, lambda r: "answer" in r),
        ]
        
        for name, params, validator in tests:
            result = self.call_mcp("evony-knowledge", name, params)
            passed = validator(result) if result else False
            self.record(f"RAG:{name}", passed, result)
    
    def test_rte(self):
        """Test RTE handlers"""
        tests = [
            ("rte_stats", {}, lambda r: "version" in r),
            ("exploit_list", {}, lambda r: isinstance(r, list) or "exploits" in str(r)),
        ]
        
        for name, params, validator in tests:
            result = self.call_mcp("evony-rte", name, params)
            passed = validator(result) if result else False
            self.record(f"RTE:{name}", passed, result)
    
    def call_mcp(self, server, tool, params):
        # Implementation depends on MCP transport
        # This is a placeholder for actual MCP calls
        return {"status": "mock"}
    
    def record(self, test_name, passed, result):
        status = "✅ PASS" if passed else "❌ FAIL"
        self.results.append({
            "test": test_name,
            "passed": passed,
            "result": str(result)[:100]
        })
        if passed:
            self.passed += 1
        else:
            self.failed += 1
        print(f"{status}: {test_name}")
    
    def report(self):
        print(f"\n{'='*50}")
        print(f"RESULTS: {self.passed}/{self.passed + self.failed} passed")
        print(f"{'='*50}")
        return self.passed, self.failed

if __name__ == "__main__":
    tester = EvonyTester()
    tester.test_rag()
    tester.test_rte()
    passed, failed = tester.report()
    sys.exit(0 if failed == 0 else 1)
```

---

### Improvement 2: Health Check Endpoint

Add to `evony_rag/mcp_server_v2.py`:

```python
@handler("evony_health")
async def health_check():
    """Comprehensive health check"""
    health = {
        "timestamp": datetime.now().isoformat(),
        "status": "healthy",
        "components": {}
    }
    
    # Check chunks
    try:
        chunks = json.load(open(CHUNKS_PATH))
        health["components"]["chunks"] = {
            "status": "ok",
            "count": len(chunks)
        }
    except Exception as e:
        health["components"]["chunks"] = {
            "status": "error",
            "error": str(e)
        }
        health["status"] = "degraded"
    
    # Check KG
    try:
        kg = json.load(open(KG_PATH))
        health["components"]["knowledge_graph"] = {
            "status": "ok",
            "entities": len(kg.get("entities", {})),
            "relationships": len(kg.get("relationships", []))
        }
    except Exception as e:
        health["components"]["knowledge_graph"] = {
            "status": "error",
            "error": str(e)
        }
        health["status"] = "degraded"
    
    # Check LM Studio
    try:
        resp = requests.get("http://localhost:1234/v1/models", timeout=2)
        health["components"]["lmstudio"] = {
            "status": "ok",
            "models": len(resp.json().get("data", []))
        }
    except:
        health["components"]["lmstudio"] = {
            "status": "unavailable"
        }
    
    return health
```

---

### Improvement 3: Index Verification Script

Create `C:\Users\Admin\Downloads\Evony_Decrypted\evony_rag\verify_all.py`:

```python
#!/usr/bin/env python3
"""Verify all RAG indices are valid and consistent"""

import json
import os
from pathlib import Path

INDEX_DIR = Path(__file__).parent / "index"

def verify_chunks():
    """Verify chunks.json"""
    path = INDEX_DIR / "chunks.json"
    print(f"Checking {path}...")
    
    if not path.exists():
        return False, "File not found"
    
    try:
        with open(path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        if not isinstance(data, list):
            return False, f"Expected list, got {type(data)}"
        
        count = len(data)
        print(f"  ✅ Valid JSON array with {count} chunks")
        return True, count
    except json.JSONDecodeError as e:
        return False, f"Invalid JSON: {e}"

def verify_bm25():
    """Verify BM25 index"""
    path = INDEX_DIR / "bm25_index.json"
    print(f"Checking {path}...")
    
    if not path.exists():
        return False, "File not found"
    
    try:
        with open(path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        terms = len(data.get('term_freqs', data.get('vocabulary', {})))
        print(f"  ✅ Valid BM25 index with {terms} terms")
        return True, terms
    except json.JSONDecodeError as e:
        return False, f"Invalid JSON: {e}"

def verify_kg():
    """Verify knowledge graph"""
    path = INDEX_DIR / "kg_full.json"
    print(f"Checking {path}...")
    
    if not path.exists():
        return False, "File not found"
    
    try:
        with open(path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        entities = len(data.get('entities', {}))
        rels = len(data.get('relationships', []))
        print(f"  ✅ Valid KG with {entities} entities, {rels} relationships")
        return True, {"entities": entities, "relationships": rels}
    except json.JSONDecodeError as e:
        return False, f"Invalid JSON: {e}"

def main():
    print("=" * 60)
    print("EVONY RAG INDEX VERIFICATION")
    print("=" * 60 + "\n")
    
    results = {}
    
    results['chunks'] = verify_chunks()
    results['bm25'] = verify_bm25()
    results['kg'] = verify_kg()
    
    print("\n" + "=" * 60)
    print("SUMMARY")
    print("=" * 60)
    
    all_ok = True
    for name, (ok, info) in results.items():
        status = "✅" if ok else "❌"
        print(f"{status} {name}: {info}")
        if not ok:
            all_ok = False
    
    print("\n" + ("ALL INDICES VALID" if all_ok else "SOME INDICES NEED REPAIR"))
    return 0 if all_ok else 1

if __name__ == "__main__":
    exit(main())
```

---

## 📋 QUICK FIX COMMANDS

```powershell
# Navigate to project
cd C:\Users\Admin\Downloads\Evony_Decrypted

# Verify indices
python evony_rag\verify_all.py

# Rebuild if needed
python evony_rag\rebuild_indices_full.py

# Test RAG
python -c "from evony_rag.precision_rag import PrecisionRAG; r=PrecisionRAG(); print(r.query('AMF3'))"

# Start bot server
Start-Process python -ArgumentList "server.py" -WorkingDirectory "evony_bot"

# Check bot status
curl http://localhost:9999/api/status

# Check LM Studio
curl http://localhost:1234/v1/models
```

---

## ✅ VERIFICATION CHECKLIST

After applying fixes, verify:

- [ ] `evony_stats` shows ~17,000 chunks
- [ ] `evony_search` returns results
- [ ] `evony_answer` includes citations
- [ ] `evony_trace` traverses knowledge graph
- [ ] Bot server auto-starts
- [ ] All 48 RTE handlers respond
- [ ] LM Studio integration working
- [ ] No MCP timeouts

---

*Generated: January 11, 2026 | Document Version: 1.0*
