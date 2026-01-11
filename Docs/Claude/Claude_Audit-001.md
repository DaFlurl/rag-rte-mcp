🎯 Evony RTE - Windsurf IDE Action Plan
Target: Bring system from 90% → 100% production-ready
Timeline: Priority 1 today, Priority 2 this week, Priority 3 this month
Current Status: A- (90/100) - One critical fix needed

🔥 Priority 1: Fix Bot Server Auto-Start (TODAY)
Issue
Bot server requires manual start in separate terminal before game interaction handlers work.
Solution: Activate integrated_bot_server.py
Step 1: Review Current Integration Module
bash# In Windsurf terminal
cat C:\Users\Admin\Downloads\Evony_Decrypted\evony_rte\integrated_bot_server.py
Step 2: Modify evony_rte/__init__.py
Open: C:\Users\Admin\Downloads\Evony_Decrypted\evony_rte\__init__.py
Add at line 1:
python"""
Evony RTE MCP Server Package
Auto-starts bot server on import
"""
import os
import sys
import logging
from pathlib import Path

# Auto-start bot server
BOT_PORT = None
BOT_PROCESS = None

def start_bot_server():
    """Start bot server with automatic port selection"""
    global BOT_PORT, BOT_PROCESS
    
    import subprocess
    import socket
    
    bot_script = Path(__file__).parent.parent / "evony_bot" / "server.py"
    python_exe = sys.executable
    
    # Try ports 9999, 9998, 9997, 9996
    for port in [9999, 9998, 9997, 9996]:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        result = sock.connect_ex(('localhost', port))
        sock.close()
        
        if result != 0:  # Port is available
            try:
                BOT_PROCESS = subprocess.Popen(
                    [python_exe, str(bot_script), "--port", str(port)],
                    stdout=subprocess.PIPE,
                    stderr=subprocess.PIPE,
                    creationflags=subprocess.CREATE_NO_WINDOW if os.name == 'nt' else 0
                )
                BOT_PORT = port
                logging.info(f"Bot server auto-started on port {port}")
                return port
            except Exception as e:
                logging.error(f"Failed to start bot server on port {port}: {e}")
                continue
    
    logging.warning("Could not start bot server - all ports in use")
    return None

# Auto-start on import
try:
    BOT_PORT = start_bot_server()
    if BOT_PORT:
        print(f"✅ Evony Bot Server running on port {BOT_PORT}")
    else:
        print("⚠️ Bot server failed to start - check logs")
except Exception as e:
    print(f"⚠️ Bot server auto-start error: {e}")
    logging.error(f"Bot server auto-start failed: {e}")
Step 3: Update Bot Server to Accept Port Argument
Open: C:\Users\Admin\Downloads\Evony_Decrypted\evony_bot\server.py
Find the line (around line 2400):
pythonPORT = 9999
Replace with:
pythonimport argparse

# Parse command line arguments
parser = argparse.ArgumentParser(description='Evony Bot Server')
parser.add_argument('--port', type=int, default=9999, help='Server port (default: 9999)')
args = parser.parse_args()
PORT = args.port
Step 4: Test Auto-Start
powershell# In Windsurf terminal
cd C:\Users\Admin\Downloads\Evony_Decrypted

# Test import triggers auto-start
python -c "import evony_rte; import time; time.sleep(2)"

# Verify bot server running
curl http://localhost:9999/api/status
```

**Expected Output**:
```
✅ Evony Bot Server running on port 9999
{"connected": false, "logged_in": false, ...}
Step 5: Add Graceful Shutdown
Add to evony_rte/__init__.py after bot start:
pythonimport atexit

def shutdown_bot_server():
    """Cleanup bot server on exit"""
    global BOT_PROCESS
    if BOT_PROCESS:
        BOT_PROCESS.terminate()
        BOT_PROCESS.wait(timeout=5)
        logging.info("Bot server stopped")

atexit.register(shutdown_bot_server)
```

**Verification Checklist**:
- [ ] Bot server starts automatically when MCP loads
- [ ] Bot server tries alternate ports if 9999 in use
- [ ] Bot server shuts down cleanly on exit
- [ ] Game interaction handlers work without manual start

**Time Estimate**: 1-2 hours

---

## 📚 Priority 2A: Create API Reference (THIS WEEK)

### Create `API_REFERENCE.md`

**Windsurf Command**:
```
@Cascade Create comprehensive API reference for all 48 MCP handlers
Location: C:\Users\Admin\Downloads\Evony_Decrypted\evony_rte\API_REFERENCE.md
Include:
- Handler signature with all parameters
- Parameter descriptions and types
- Return value structure
- Usage examples for each handler
- Group by category (Packet Tools, Client Analysis, etc.)
Use the audit report categories as template
Manual Template (if Cascade unavailable):
markdown# Evony RTE - MCP Handler API Reference

## Packet Tools (5 handlers)

### packet_capture
Start/stop packet capture for Evony traffic analysis.

**Parameters**:
- `action` (string, required): "start" | "stop" | "status"
- `duration` (integer, optional): Capture duration in seconds (default: 30)
- `filter` (string, optional): Packet filter (e.g., "march", "battle", "trade")

**Returns**:
```json
{
  "status": "capturing",
  "duration": 30,
  "output_file": "captures/capture_20260110_123456.pcap"
}
```

**Example**:
```python
handle_tool('packet_capture', {
    'action': 'start',
    'duration': 60,
    'filter': 'march'
})
```

### packet_encode
Encode data to AMF3 packet format.

**Parameters**:
- `cmd` (string, required): Command name (e.g., "city.getInfo")
- `data` (object, required): Command parameters

**Returns**:
```json
{
  "success": true,
  "command": "city.getInfo",
  "amf3_hex": "0a0b0107636d64...",
  "amf3_length": 43,
  "ready_to_send": "0000002b0a0b..."
}
```

**Example**:
```python
handle_tool('packet_encode', {
    'cmd': 'troop.produceTroop',
    'data': {
        'troopType': 6,
        'num': 100,
        'castleId': 12345
    }
})
```

[... continue for all 48 handlers ...]
```

**Time Estimate**: 4-6 hours

---

## 🔧 Priority 2B: Create Troubleshooting Guide (THIS WEEK)

### Create `TROUBLESHOOTING.md`

**Windsurf Command**:
```
@Cascade Create troubleshooting guide
Location: C:\Users\Admin\Downloads\Evony_Decrypted\TROUBLESHOOTING.md
Include sections:
1. Bot Server Issues (connection, port conflicts, crashes)
2. MCP Handler Errors (common failures per category)
3. Network/WSL Issues (tshark, FFDec)
4. RAG Search Problems (empty results, slow queries)
5. Exploit Testing Safety (verification failures)
Each issue needs: Symptom, Cause, Solution, Prevention
Quick Template:
markdown# Evony RTE Troubleshooting Guide

## Bot Server Issues

### Issue: "Connection refused to localhost:9999"
**Symptom**: Game interaction handlers fail with connection error
**Cause**: Bot server not running
**Solution**:
```bash
# Check if running
curl http://localhost:9999/api/status

# Start manually
cd C:\Users\Admin\Downloads\Evony_Decrypted\evony_bot
python server.py
```
**Prevention**: Verify auto-start enabled in `evony_rte/__init__.py`

### Issue: "Address already in use on port 9999"
**Symptom**: Bot server fails to start
**Cause**: Another process using port 9999
**Solution**:
```powershell
# Find process using port
netstat -ano | findstr :9999
taskkill /PID  /F

# Or use alternate port
python server.py --port 9998
```
**Prevention**: Auto-start uses port rotation (9999, 9998, 9997...)

[... continue for 15-20 common issues ...]
Time Estimate: 3-4 hours

🧪 Priority 2C: Create Test Suite (THIS WEEK)
Setup Pytest Structure
Windsurf Terminal:
bashcd C:\Users\Admin\Downloads\Evony_Decrypted\evony_rte

# Create test directory
mkdir tests
cd tests

# Create test files
New-Item __init__.py
New-Item test_amf3_encoding.py
New-Item test_handlers.py
New-Item test_bot_server.py
New-Item test_exploit_framework.py
New-Item conftest.py
Create tests/conftest.py (Pytest Config)
python"""
Pytest configuration for Evony RTE tests
"""
import pytest
import sys
from pathlib import Path

# Add parent directory to path
sys.path.insert(0, str(Path(__file__).parent.parent))

@pytest.fixture
def bot_server_running():
    """Ensure bot server is running for tests"""
    import requests
    try:
        r = requests.get('http://localhost:9999/api/status', timeout=1)
        return r.status_code == 200
    except:
        pytest.skip("Bot server not running")

@pytest.fixture
def sample_amf3_data():
    """Sample data for AMF3 tests"""
    return {
        'cmd': 'city.getInfo',
        'data': {'castleId': 12345}
    }
Create tests/test_amf3_encoding.py
python"""
Test AMF3 encoding/decoding functionality
"""
import pytest
from evony_rte.mcp_server import handle_tool

def test_packet_encode_basic(sample_amf3_data):
    """Test basic AMF3 encoding"""
    result = handle_tool('packet_encode', sample_amf3_data)
    
    assert result['success'] == True
    assert 'amf3_hex' in result
    assert len(result['amf3_hex']) > 0
    assert result['command'] == 'city.getInfo'

def test_packet_encode_integer_overflow():
    """Test AMF3 encoding with large integers"""
    result = handle_tool('packet_encode', {
        'cmd': 'troop.produceTroop',
        'data': {
            'troopType': 6,
            'num': 2147483647  # INT32_MAX
        }
    })
    
    assert result['success'] == True
    assert 'amf3_hex' in result

def test_packet_decode_hex():
    """Test AMF3 decoding from hex"""
    # First encode
    encoded = handle_tool('packet_encode', {
        'cmd': 'test.command',
        'data': {'testKey': 'testValue'}
    })
    
    # Then decode
    decoded = handle_tool('packet_decode', {
        'data': encoded['amf3_hex'],
        'format': 'hex'
    })
    
    assert 'decoded' in decoded
    assert 'test.command' in str(decoded['decoded'])

# Add 10-15 more AMF3 tests
Create tests/test_handlers.py
python"""
Test MCP handler functionality
"""
import pytest
from evony_rte.mcp_server import handle_tool

class TestPacketTools:
    """Test packet manipulation handlers"""
    
    def test_packet_capture_status(self):
        """Test packet capture status check"""
        result = handle_tool('packet_capture', {'action': 'status'})
        assert 'status' in result
    
    def test_packet_encode_all_types(self):
        """Test encoding various data types"""
        test_cases = [
            {'cmd': 'test', 'data': {'int': 123}},
            {'cmd': 'test', 'data': {'str': 'hello'}},
            {'cmd': 'test', 'data': {'bool': True}},
            {'cmd': 'test', 'data': {'null': None}},
            {'cmd': 'test', 'data': {'array': [1, 2, 3]}},
        ]
        
        for case in test_cases:
            result = handle_tool('packet_encode', case)
            assert result['success'] == True

class TestClientAnalysis:
    """Test client code analysis handlers"""
    
    def test_client_search_existing_class(self):
        """Test searching for known ActionScript class"""
        result = handle_tool('client_search', {
            'query': 'TroopCommands',
            'type': 'class'
        })
        
        assert 'results' in result
        assert len(result['results']) > 0
    
    def test_client_search_nonexistent(self):
        """Test search with no results"""
        result = handle_tool('client_search', {
            'query': 'NonexistentClass123456',
            'type': 'class'
        })
        
        assert 'results' in result
        assert len(result['results']) == 0

# Add 20-30 more handler tests
Create tests/test_bot_server.py
python"""
Test bot server functionality
"""
import pytest
import requests

def test_bot_server_status(bot_server_running):
    """Test bot server status endpoint"""
    r = requests.get('http://localhost:9999/api/status')
    assert r.status_code == 200
    
    data = r.json()
    assert 'connected' in data
    assert 'logged_in' in data
    assert 'pyamf' in data

def test_bot_server_connect_endpoint():
    """Test bot server connect endpoint structure"""
    # Don't actually connect, just verify endpoint exists
    r = requests.post('http://localhost:9999/api/connect', json={
        'server': 'test',
        'email': 'test@example.com',
        'password': 'test'
    })
    
    # Should fail (no real server) but endpoint should respond
    assert r.status_code in [200, 400, 500]

# Add 10-15 more bot server tests
Create tests/test_exploit_framework.py
python"""
Test exploit framework safety features
"""
import pytest
from evony_rte.mcp_server import handle_tool

def test_exploit_list():
    """Test exploit enumeration"""
    result = handle_tool('exploit_list', {})
    
    assert 'exploits' in result
    assert 'total' in result
    assert result['total'] == 5

def test_exploit_list_categories():
    """Test exploit categorization"""
    result = handle_tool('exploit_list', {})
    
    categories = set()
    for exploit in result['exploits'].values():
        categories.add(exploit['category'])
    
    assert 'overflow' in categories
    assert 'bypass' in categories

def test_exploit_dry_run():
    """Test exploit dry-run mode (no actual execution)"""
    result = handle_tool('exploit_test', {
        'exploit_id': 'overflow_archer',
        'dry_run': True
    })
    
    assert 'simulated' in str(result).lower() or 'dry' in str(result).lower()

# Add 10-15 more exploit tests
Run Tests
Windsurf Terminal:
bashcd C:\Users\Admin\Downloads\Evony_Decrypted\evony_rte

# Install pytest
pip install pytest pytest-cov

# Run all tests
pytest tests/ -v

# Run with coverage
pytest tests/ --cov=evony_rte --cov-report=html

# Run specific test file
pytest tests/test_amf3_encoding.py -v
```

**Time Estimate**: 6-8 hours

---

## 📊 Priority 3A: Add Metrics Dashboard (THIS MONTH)

### Create `metrics_dashboard.py`

**Windsurf Command**:
```
@Cascade Create metrics collection and dashboard
Location: C:\Users\Admin\Downloads\Evony_Decrypted\evony_rte\metrics_dashboard.py
Features:
- Handler call counters
- Response time tracking
- Error rate monitoring
- Success/failure ratios
- Export to JSON/CSV
- Optional web dashboard (Flask)
```

**Time Estimate**: 4-6 hours

---

## 🖥️ Priority 3B: MCP Web UI (THIS MONTH)

### Create Web Dashboard (like bot server has)

**Windsurf Command**:
```
@Cascade Create web UI for MCP server
Location: C:\Users\Admin\Downloads\Evony_Decrypted\evony_rte\web_ui.py
Features:
- Handler testing interface (select handler, enter params, run)
- Log viewer (live tail, search, filter)
- Metrics dashboard (from Priority 3A)
- System status (bot server, tools, RAG)
Reuse bot server HTML/CSS style
Time Estimate: 8-10 hours

🔧 Priority 3C: Install Ghidra (THIS MONTH)
Optional Advanced RE Tool
Windsurf Terminal:
powershell# Option 1: Chocolatey
choco install ghidra

# Option 2: Manual
# Download from https://ghidra-sre.org/
# Extract to C:\ghidra
# Add to PATH

# Test installation
analyzeHeadless -help
```

**Add Ghidra Handler**:
```
@Cascade Add Ghidra handler to mcp_server.py
Actions: analyze, export, status
Use headless analyzer for CLI operations
Time Estimate: 2-3 hours

📋 Execution Checklist
Today (Priority 1)

 Review integrated_bot_server.py
 Modify evony_rte/__init__.py with auto-start code
 Update evony_bot/server.py to accept --port argument
 Test auto-start functionality
 Verify game interaction handlers work
 Add graceful shutdown handler
 Update audit report to A+ (95-100%)

This Week (Priority 2)

 Create API_REFERENCE.md (48 handlers documented)
 Create TROUBLESHOOTING.md (15-20 common issues)
 Setup pytest structure
 Write AMF3 encoding tests (10-15 tests)
 Write handler tests (20-30 tests)
 Write bot server tests (10-15 tests)
 Write exploit framework tests (10-15 tests)
 Run full test suite and achieve 80%+ coverage

This Month (Priority 3)

 Create metrics collection system
 Build web dashboard for MCP server
 Install Ghidra (optional)
 Add Ghidra handler to MCP (optional)
 Write integration guide for other MCP clients
 Update all documentation


🎯 Success Metrics
After Priority 1 (Today):

✅ Bot server auto-starts with MCP
✅ Zero manual terminal commands required
✅ System grade: A+ (95%)

After Priority 2 (This Week):

✅ Complete API documentation
✅ Comprehensive troubleshooting guide
✅ 50-70 automated tests
✅ 80%+ code coverage
✅ System grade: A+ (98%)

After Priority 3 (This Month):

✅ Metrics/monitoring dashboard
✅ Web UI for MCP testing
✅ Advanced RE capabilities (Ghidra)
✅ System grade: A++ (100%)
✅ Enterprise production-ready


🚀 Quick Start (Do This Now)
In Windsurf Terminal:
powershellcd C:\Users\Admin\Downloads\Evony_Decrypted

# 1. Open key files
code evony_rte\__init__.py
code evony_bot\server.py

# 2. Apply Priority 1 changes (use code above)

# 3. Test
python -c "import evony_rte; import time; time.sleep(2)"
curl http://localhost:9999/api/status

# 4. If working, commit
git add -A
git commit -m "feat: bot server auto-start + port rotation"
```

**Expected Output**:
```
✅ Evony Bot Server running on port 9999
{"connected": false, "logged_in": false, "pyamf": true}