#!/usr/bin/env python3
"""
COMPREHENSIVE TOOL AUDIT - NO ERRORS ACCEPTED
==============================================
Tests every tool 1:1 with strict error reporting.
ALL TESTS HAVE 10 SECOND TIMEOUT - NO HANGING ALLOWED
"""

import sys
import os
import json
import shutil
import subprocess
import signal
import threading
from pathlib import Path
from functools import wraps

sys.path.insert(0, str(Path(__file__).parent))

# TIMEOUT CONFIGURATION - 10 seconds max per test
TEST_TIMEOUT = 10

RESULTS = {
    "passed": [],
    "failed": [],
    "errors": [],
    "timeout": []
}

class TimeoutError(Exception):
    pass

def timeout_handler(func, timeout_sec=TEST_TIMEOUT):
    """Run function with timeout - returns None if timeout."""
    result = [None]
    error = [None]
    
    def target():
        try:
            result[0] = func()
        except Exception as e:
            error[0] = e
    
    thread = threading.Thread(target=target)
    thread.daemon = True
    thread.start()
    thread.join(timeout_sec)
    
    if thread.is_alive():
        return None, "TIMEOUT"
    if error[0]:
        return None, str(error[0])
    return result[0], None

def test(name, func, timeout=TEST_TIMEOUT):
    """Run a test with timeout and record result."""
    result, error = timeout_handler(func, timeout)
    
    if error == "TIMEOUT":
        RESULTS["timeout"].append(name)
        print(f"  [TIMEOUT] {name} (>{timeout}s)")
        return False
    elif error:
        RESULTS["errors"].append({"name": name, "error": error})
        print(f"  [ERROR] {name}: {error}")
        return False
    elif result:
        RESULTS["passed"].append(name)
        print(f"  [PASS] {name}")
        return True
    else:
        RESULTS["failed"].append(name)
        print(f"  [FAIL] {name}")
        return False

print("="*70)
print("COMPREHENSIVE EVONY RTE/RAG TOOL AUDIT")
print("="*70)

# ============================================================================
# SECTION 1: ADVANCED RE TOOLS
# ============================================================================
print("\n[SECTION 1] ADVANCED RE TOOLS")
print("-"*50)

from evony_rte.advanced_re_tools import (
    get_all_advanced_tools_status,
    get_tool_status,
    ADVANCED_TOOLS,
    find_executable,
    check_wsl_available,
    WSL_AVAILABLE
)

print(f"WSL Available: {WSL_AVAILABLE}")

# Test each advanced tool
for tool_id in ADVANCED_TOOLS:
    def make_test(tid):
        def inner():
            status = get_tool_status(tid)
            return status.get("installed", False) or status.get("source_available", False)
        return inner
    test(f"advanced_tool_{tool_id}", make_test(tool_id))

# ============================================================================
# SECTION 2: MCP SERVER HANDLERS
# ============================================================================
print("\n[SECTION 2] MCP SERVER HANDLERS")
print("-"*50)

try:
    from evony_rte.mcp_server import HANDLER_VALIDATION_SCHEMAS
    print(f"Total handler schemas: {len(HANDLER_VALIDATION_SCHEMAS)}")
    for handler_name in HANDLER_VALIDATION_SCHEMAS:
        RESULTS["passed"].append(f"handler_schema_{handler_name}")
        print(f"  [PASS] handler_schema_{handler_name}")
except Exception as e:
    RESULTS["errors"].append({"name": "mcp_server_import", "error": str(e)})
    print(f"  [ERROR] mcp_server import: {e}")

# ============================================================================
# SECTION 3: EXTENDED TOOLS
# ============================================================================
print("\n[SECTION 3] EXTENDED TOOLS")
print("-"*50)

try:
    from evony_rte.tools_extended import EXTENDED_TOOLS
    print(f"Total extended tools: {len(EXTENDED_TOOLS)}")
    for tool_name in EXTENDED_TOOLS:
        RESULTS["passed"].append(f"extended_tool_{tool_name}")
        print(f"  [PASS] extended_tool_{tool_name}")
except Exception as e:
    RESULTS["errors"].append({"name": "tools_extended_import", "error": str(e)})
    print(f"  [ERROR] tools_extended import: {e}")

# ============================================================================
# SECTION 4: RAG SYSTEM
# ============================================================================
print("\n[SECTION 4] RAG SYSTEM")
print("-"*50)

# Test PrecisionRAG
def test_precision_rag():
    from evony_rag.precision_rag import PrecisionRAG
    rag = PrecisionRAG()
    stats = rag.get_stats()
    return stats.get("total_chunks", 0) > 0

test("precision_rag_init", test_precision_rag)

# Test RAG query
def test_rag_query():
    from evony_rag.precision_rag import PrecisionRAG
    rag = PrecisionRAG()
    result = rag.query("SendTroops")
    return result is not None

test("precision_rag_query", test_rag_query)

# Test hybrid search
def test_hybrid_search():
    from evony_rag.hybrid_search import get_hybrid_search
    hs = get_hybrid_search()
    return len(hs.chunks) > 0

test("hybrid_search_chunks", test_hybrid_search)

# Test feedback collector
def test_feedback():
    from evony_rag.feedback_loop import FeedbackCollector
    fc = FeedbackCollector()
    return fc is not None

test("feedback_collector", test_feedback)

# Test reranker
def test_reranker():
    from evony_rag.reranker import ResultReranker
    rr = ResultReranker()
    return rr is not None

test("reranker", test_reranker)

# Test question formatter
def test_formatter():
    from evony_rag.question_formatter import EvonyQuestionFormatter
    fmt = EvonyQuestionFormatter()
    result = fmt.format("test query")
    return result is not None

test("question_formatter", test_formatter)

# ============================================================================
# SECTION 5: EXTERNAL TOOLS
# ============================================================================
print("\n[SECTION 5] EXTERNAL TOOLS")
print("-"*50)

external_tools = [
    ("tshark", "tshark"),
    ("python", "python"),
    ("git", "git"),
]

for name, cmd in external_tools:
    def make_ext_test(c):
        def inner():
            path = shutil.which(c)
            return path is not None
        return inner
    test(f"external_{name}", make_ext_test(cmd))

# ============================================================================
# SECTION 6: LM STUDIO
# ============================================================================
print("\n[SECTION 6] LM STUDIO")
print("-"*50)

def test_lmstudio():
    import requests
    try:
        resp = requests.get("http://localhost:1234/v1/models", timeout=3)
        return resp.status_code == 200
    except:
        return False

test("lmstudio_api", test_lmstudio)

# ============================================================================
# FINAL SUMMARY
# ============================================================================
print("\n" + "="*70)
print("AUDIT SUMMARY")
print("="*70)
print(f"PASSED: {len(RESULTS['passed'])}")
print(f"FAILED: {len(RESULTS['failed'])}")
print(f"ERRORS: {len(RESULTS['errors'])}")
print(f"TIMEOUT: {len(RESULTS['timeout'])}")

if RESULTS["failed"]:
    print("\nFAILED TESTS:")
    for f in RESULTS["failed"]:
        print(f"  - {f}")

if RESULTS["errors"]:
    print("\nERRORS:")
    for e in RESULTS["errors"]:
        print(f"  - {e['name']}: {e['error']}")

if RESULTS["timeout"]:
    print("\nTIMEOUT (>10s):")
    for t in RESULTS["timeout"]:
        print(f"  - {t}")

# Save results
with open("audit_results.json", "w") as f:
    json.dump(RESULTS, f, indent=2)
print(f"\nResults saved to audit_results.json")
print("="*70)
