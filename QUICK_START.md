# Evony MCP - Quick Start Guide

**Get started with Evony reverse engineering in 30 minutes**

---

## 🚀 Quick Setup (10 minutes)

### **Prerequisites Check**

```powershell
# Check Python version (need 3.8+)
python --version

# Check if tools installed
pip list | grep -E "pyamf|pymem|psutil"
wireshark -v

# Check AS3 files exist
ls "C:\Users\Admin\Downloads\Evony_Decrypted\AS3_Scripts_(AutoEvony2_NEW.swf)"
```

### **Install Missing Dependencies**

```powershell
# Install Python packages
pip install pyamf pymem psutil sentence-transformers

# Install Wireshark (if not installed)
# Download from: https://www.wireshark.org/download.html
```

---

## 🔍 Immediate Capabilities (Working Now)

### **1. Search Client Code**

```python
# In Claude/Windsurf chat:
"Search AS3 code for 'march' functions"

# Returns: 50 results including doQuickMarch, marchSkillParam, etc.
```

### **2. List Active Exploits**

```python
"Show me all known exploits"

# Returns:
# - overflow_archer (INT32 overflow on troop production)
# - flip_negative_troops (disband negative = add troops)
# - race_double_spend (timing attack on shop)
# - negative_transport (transport negative resources)
```

### **3. Find Vulnerabilities**

```python
"Scan for integer overflow vulnerabilities"

# Scans 552 files, finds 50 potential issues
```

### **4. Analyze Network Traffic**

```python
"List network interfaces for packet capture"

# Shows 23 interfaces including WiFi, Ethernet, VMware
```

### **5. Search Processes**

```python
"Find Evony processes"

# Returns: roboevony.exe (PID: 98508, 153.9 MB RAM)
```

---

## ⚠️ Known Issues (Don't Try Yet)

**These will fail until fixes are applied:**

1. ❌ `"Search knowledge base for march mechanics"` - encoding error
2. ❌ `"Map doQuickMarch to server handler"` - returns empty
3. ❌ `"Show validation rules for troop.produceTroop"` - not implemented

---

## 🎯 Sample Workflows (Working)

### **Workflow 1: Find Overflow Exploit**

```
You: "Search AS3 code for troop production functions"
Claude: [returns doQuickMarch, produceTroop, etc.]

You: "Analyze protocol for troop.produceTroop"
Claude: [shows 300+ fields, all type "unknown"]

You: "Show me the overflow_archer exploit details"
Claude: [explains 6,135,037 archers costs overflow INT32]

You: "Test this exploit"
Claude: [runs test harness, shows before/after state]
```

### **Workflow 2: Scan for Race Conditions**

```
You: "Find potential race condition vulnerabilities"
Claude: [scans 552 files, finds async operations]

You: "Show me the race_double_spend exploit"
Claude: [explains timing attack on shop.useGoods]

You: "List all race condition patterns found"
Claude: [50+ locations with "Async", "setInterval", etc.]
```

### **Workflow 3: Memory Scanning**

```
You: "Find Evony processes"
Claude: [roboevony.exe PID 98508]

You: "Scan memory for value 1000"
Claude: [searches process memory for int value]
```

---

## 🐛 Troubleshooting

### **Problem: "Encoding error" when searching knowledge**

**Cause**: Bug in evony-knowledge RAG system  
**Fix**: Wait for Phase 1 fixes (see TECHNICAL_IMPLEMENTATION_GUIDE.md)  
**Workaround**: Use `client_search` instead for AS3 code

### **Problem: "Tool not implemented" errors**

**Cause**: Some tools are stubs  
**Affected**: xref_validation, game_resources, game_troops  
**Fix**: See implementation guide for database seeding  
**Workaround**: Use working tools only

### **Problem: memory_processes crashes without filter**

**Cause**: Missing parameter bug  
**Fix**: Always provide filter parameter  
**Example**: `"Find processes with filter 'evony'"`

---

## 📊 What Works Right Now

| Feature | Status | Example |
|---------|--------|---------|
| **AS3 Code Search** | ✅ WORKING | "Search for validation" → 24 results |
| **Exploit List** | ✅ WORKING | "Show exploits" → 5 active |
| **Vulnerability Scan** | ✅ WORKING | "Find overflows" → 50 found |
| **Protocol Analysis** | ⚠️ PARTIAL | Shows fields but types "unknown" |
| **Packet Decode** | ✅ WORKING | AMF3 → JSON works |
| **Packet Encode** | ⚠️ PARTIAL | Returns JSON not binary |
| **Memory Processes** | ⚠️ BUGGY | Works with filter parameter |
| **Network Interfaces** | ✅ WORKING | Lists 23 interfaces |
| **Knowledge Search** | ❌ BROKEN | Encoding error |
| **Cross-Reference** | ❌ EMPTY | Returns no mappings |

---

## 🎮 Try These Commands Now

### **Safe to Try (Will Work)**

```
1. "Search AS3 code for 'resource' functions"
2. "List all network interfaces"
3. "Show me the overflow_archer exploit"
4. "Find processes containing 'evony'"
5. "Scan for bypass vulnerabilities"
6. "Analyze protocol for troop.produceTroop"
7. "Show me all known exploits"
```

### **Don't Try Yet (Will Fail)**

```
1. "Search knowledge base for anything"  # Encoding error
2. "Map client to server for any function"  # Empty results
3. "Show validation rules for commands"  # Not implemented
4. "Get castle resources"  # Not implemented
5. "List processes" (without filter)  # Crashes
```

---

## 🔧 Quick Fixes You Can Apply Now

### **Fix 1: Make memory_processes Work Without Filter**

**File**: `evony-rte/server/tools/memory.py`

**Change**:
```python
# OLD (crashes):
def memory_processes(filter: str):

# NEW (works):
def memory_processes(filter: Optional[str] = None):
    if filter is None:
        # Return all processes
```

### **Fix 2: Enable Binary Packet Encoding**

**File**: `evony-rte/server/tools/packet.py`

**Add**:
```python
import pyamf

def packet_encode(cmd, data):
    amf3_bytes = pyamf.encode({'cmd': cmd, 'data': data}, encoding=pyamf.AMF3).getvalue()
    return {
        "amf3_hex": amf3_bytes.hex(),
        "amf3_base64": base64.b64encode(amf3_bytes).decode()
    }
```

---

## 📚 Learning Path

### **Day 1: Explore What Works**
- Search AS3 code for interesting functions
- Review existing exploits
- Run vulnerability scanner
- List network interfaces

### **Day 2: Understand Limitations**
- Try broken features to see errors
- Read audit document (EVONY_MCP_COMPLETE_AUDIT.md)
- Understand what needs fixing

### **Day 3: Apply Quick Fixes**
- Fix memory_processes parameter bug
- Enable binary packet encoding
- Test fixes work

### **Week 2: Major Fixes**
- Fix knowledge base encoding bug
- Seed cross-reference database
- Implement xref_validation

### **Week 3: Advanced Features**
- Integrate EVA backend source
- Build exploit generator
- Add automated testing

---

## 🎯 Your Next Actions

**Immediate (Next 30 minutes)**:
1. ✅ Verify all prerequisites installed
2. ✅ Test the 7 "safe to try" commands
3. ✅ Review existing 5 exploits
4. ✅ Scan for overflow vulnerabilities

**Short Term (This Week)**:
1. Apply memory_processes fix
2. Enable binary packet encoding  
3. Test packet encode/decode roundtrip
4. Document any new issues found

**Medium Term (Next 2 Weeks)**:
1. Fix knowledge base encoding bug
2. Seed cross-reference database
3. Implement xref_validation with real data
4. Add EVA backend source integration

---

## 📞 Getting Help

**If Something Breaks**:
1. Check error message against "Known Issues" section
2. Read EVONY_MCP_COMPLETE_AUDIT.md for detailed analysis
3. See TECHNICAL_IMPLEMENTATION_GUIDE.md for fixes
4. File issue with MCP server logs

**If You Want to Contribute**:
1. Pick a bug from audit document
2. Implement fix from implementation guide
3. Add tests to verify fix works
4. Update documentation

---

## 🎉 Success Criteria

**You're ready to move forward when:**

✅ You can search AS3 code successfully  
✅ You can list all exploits  
✅ You can run vulnerability scanner  
✅ You understand what's broken and why  
✅ You've read the complete audit document  
✅ You know which fixes to apply first  

**You'll know you're 100% complete when:**

✅ Knowledge base search works  
✅ Cross-reference returns mappings  
✅ Packet replay works end-to-end  
✅ Exploit generator runs automatically  
✅ All documented tools work  
✅ Test suite passes 100%  

---

**Happy Hacking!** 🚀

See you on the other side with a complete Evony reverse engineering platform.
