#!/usr/bin/env python3
"""
REAL DATA AUDIT - NO MOCKS, NO FAKES
=====================================
ALL tests use REAL data with REAL responses.
10 second timeout per test. Production-ready testing.
"""

import sys
import os
import json
import shutil
import threading
import requests
from pathlib import Path
from datetime import datetime

sys.path.insert(0, str(Path(__file__).parent))

TIMEOUT = 10
RESULTS = {"pass": [], "fail": [], "error": [], "timeout": []}

def run_with_timeout(name, func):
    """Run with timeout, record REAL result."""
    result = [None]
    err = [None]
    
    def worker():
        try:
            result[0] = func()
        except Exception as e:
            err[0] = str(e)
    
    t = threading.Thread(target=worker, daemon=True)
    t.start()
    t.join(TIMEOUT)
    
    if t.is_alive():
        RESULTS["timeout"].append({"name": name, "timeout": TIMEOUT})
        print(f"[TIMEOUT] {name} (>{TIMEOUT}s)")
        return None
    if err[0]:
        RESULTS["error"].append({"name": name, "error": err[0]})
        print(f"[ERROR] {name}: {err[0][:60]}")
        return None
    return result[0]

def test_real(name, func, validator):
    """Test with REAL data and validate REAL result."""
    result = run_with_timeout(name, func)
    if result is None:
        return False
    
    try:
        valid, msg = validator(result)
        if valid:
            RESULTS["pass"].append({"name": name, "result": str(result)[:100]})
            print(f"[PASS] {name}: {msg}")
            return True
        else:
            RESULTS["fail"].append({"name": name, "result": str(result)[:100], "reason": msg})
            print(f"[FAIL] {name}: {msg}")
            return False
    except Exception as e:
        RESULTS["error"].append({"name": name, "error": str(e)})
        print(f"[ERROR] {name} validation: {e}")
        return False

print("="*70)
print(f"REAL DATA AUDIT - {datetime.now()}")
print("="*70)

# ============================================================================
# TEST 1: client_strings - REAL AS3 files
# ============================================================================
print("\n[TEST 1] client_strings - REAL AS3 FILES")
from evony_rte.mcp_server import handle_client_strings

def test_client_strings():
    return handle_client_strings({"filter": "", "min_length": 10})

def validate_strings(r):
    if not isinstance(r, dict):
        return False, "Not a dict"
    if "strings" not in r:
        return False, "No 'strings' key"
    if r.get("total", 0) == 0:
        return False, "Zero strings found"
    return True, f"Found {r['total']} strings"

test_real("client_strings", test_client_strings, validate_strings)

# ============================================================================
# TEST 2: advanced_tools_status - REAL tool detection
# ============================================================================
print("\n[TEST 2] advanced_tools_status - REAL TOOL DETECTION")
from evony_rte.mcp_server import handle_advanced_tools_status

def test_advanced_status():
    return handle_advanced_tools_status({})

def validate_tools(r):
    if not isinstance(r, dict):
        return False, "Not a dict"
    if "tools" not in r:
        return False, "No 'tools' key"
    if "total" not in r:
        return False, "No 'total' key"
    installed = r.get("installed", 0)
    total = r.get("total", 0)
    return True, f"{installed}/{total} tools installed"

test_real("advanced_tools_status", test_advanced_status, validate_tools)

# ============================================================================
# TEST 3: LM Studio API - REAL connection
# ============================================================================
print("\n[TEST 3] LM Studio API - REAL CONNECTION")

def test_lmstudio():
    resp = requests.get("http://localhost:1234/v1/models", timeout=5)
    return resp.json()

def validate_lmstudio(r):
    if "data" not in r:
        return False, "No 'data' key"
    if len(r["data"]) == 0:
        return False, "No models loaded"
    model = r["data"][0].get("id", "unknown")
    return True, f"Model: {model}"

test_real("lmstudio_api", test_lmstudio, validate_lmstudio)

# ============================================================================
# TEST 4: RAG Search - REAL chunks
# ============================================================================
print("\n[TEST 4] RAG Search - REAL CHUNKS")
from evony_rag.hybrid_search import get_hybrid_search

def test_rag_search():
    hs = get_hybrid_search()
    results = hs.search("SendTroops", k=5)
    return {"chunks_loaded": len(hs.chunks), "results": len(results)}

def validate_rag_search(r):
    if r["chunks_loaded"] == 0:
        return False, "Zero chunks loaded"
    return True, f"{r['chunks_loaded']} chunks, {r['results']} results"

test_real("rag_search", test_rag_search, validate_rag_search)

# ============================================================================
# TEST 5: RAG Answer - REAL LLM response
# ============================================================================
print("\n[TEST 5] RAG Answer - REAL LLM RESPONSE")
from evony_rag.precision_rag import PrecisionRAG

def test_rag_answer():
    rag = PrecisionRAG()
    return rag.query("What is SendTroops?")

def validate_rag_answer(r):
    if not r:
        return False, "No response"
    if not r.get("answer"):
        return False, "Empty answer"
    return True, f"Answer: {r['answer'][:50]}..."

test_real("rag_answer", test_rag_answer, validate_rag_answer)

# ============================================================================
# TEST 6: exploit_list - REAL data
# ============================================================================
print("\n[TEST 6] exploit_list - REAL DATA")
from evony_rte.mcp_server import handle_exploit_list

def test_exploit_list():
    return handle_exploit_list({"category": "all"})

def validate_exploits(r):
    if not isinstance(r, dict):
        return False, "Not a dict"
    if "exploits" not in r:
        return False, "No 'exploits' key"
    count = len(r.get("exploits", []))
    return True, f"{count} exploits found"

test_real("exploit_list", test_exploit_list, validate_exploits)

# ============================================================================
# TEST 7: Feedback Collector - REAL init
# ============================================================================
print("\n[TEST 7] Feedback Collector - REAL INIT")
from evony_rag.feedback_loop import FeedbackCollector

def test_feedback():
    fc = FeedbackCollector()
    return {"initialized": True, "has_record": hasattr(fc, 'record_feedback')}

def validate_feedback(r):
    if not r.get("initialized"):
        return False, "Not initialized"
    if not r.get("has_record"):
        return False, "Missing record_feedback method"
    return True, "FeedbackCollector ready"

test_real("feedback_collector", test_feedback, validate_feedback)

# ============================================================================
# TEST 8: Question Formatter - REAL formatting
# ============================================================================
print("\n[TEST 8] Question Formatter - REAL FORMAT")
from evony_rag.question_formatter import EvonyQuestionFormatter

def test_formatter():
    fmt = EvonyQuestionFormatter()
    result = fmt.format("food glitch exploit")
    return {"formatted": result, "patterns": len(fmt.PATTERNS)}

def validate_formatter(r):
    if not r.get("formatted"):
        return False, "No formatted result"
    return True, f"{r['patterns']} patterns, formatted OK"

test_real("question_formatter", test_formatter, validate_formatter)

# ============================================================================
# TEST 9: Reranker - REAL init
# ============================================================================
print("\n[TEST 9] Reranker - REAL INIT")
from evony_rag.reranker import ResultReranker

def test_reranker():
    rr = ResultReranker()
    return {"initialized": True, "has_rerank": hasattr(rr, 'rerank')}

def validate_reranker(r):
    if not r.get("initialized"):
        return False, "Not initialized"
    return True, "Reranker ready"

test_real("reranker", test_reranker, validate_reranker)

# ============================================================================
# TEST 10: Tshark - REAL detection
# ============================================================================
print("\n[TEST 10] Tshark - REAL DETECTION")

def test_tshark():
    path = shutil.which("tshark")
    return {"found": path is not None, "path": path}

def validate_tshark(r):
    if not r.get("found"):
        return False, "Tshark not in PATH"
    return True, f"Found: {r['path']}"

test_real("tshark", test_tshark, validate_tshark)

# ============================================================================
# SUMMARY
# ============================================================================
print("\n" + "="*70)
print("REAL DATA AUDIT SUMMARY")
print("="*70)
print(f"PASS:    {len(RESULTS['pass'])}")
print(f"FAIL:    {len(RESULTS['fail'])}")
print(f"ERROR:   {len(RESULTS['error'])}")
print(f"TIMEOUT: {len(RESULTS['timeout'])}")

if RESULTS["fail"]:
    print("\n--- FAILURES ---")
    for f in RESULTS["fail"]:
        print(f"  {f['name']}: {f['reason']}")

if RESULTS["error"]:
    print("\n--- ERRORS ---")
    for e in RESULTS["error"]:
        print(f"  {e['name']}: {e['error'][:60]}")

if RESULTS["timeout"]:
    print("\n--- TIMEOUTS ---")
    for t in RESULTS["timeout"]:
        print(f"  {t['name']}: >{t['timeout']}s")

# Save full results
with open("real_audit_results.json", "w") as f:
    json.dump(RESULTS, f, indent=2)

total = len(RESULTS['pass']) + len(RESULTS['fail']) + len(RESULTS['error']) + len(RESULTS['timeout'])
print(f"\nTotal tests: {total}")
print(f"Pass rate: {len(RESULTS['pass'])/total*100:.1f}%" if total > 0 else "N/A")
print("="*70)
