# Evony RTE Troubleshooting Guide

**Version**: 2.0.0  
**Last Updated**: January 10, 2026

---

## Quick Diagnostics

```powershell
# Check bot server
curl http://localhost:9999/api/status

# Check all handlers
C:\Python313\python.exe evony_rte\test_comprehensive.py

# Check tool status
python -c "from evony_rte.mcp_server import handle_tool; print(handle_tool('tools_status', {}))"
```

---

## Bot Server Issues

### Issue: "Connection refused to localhost:9999"

**Symptom**: Game interaction handlers fail with connection error

**Cause**: Bot server not running

**Solution**:
```powershell
# Check if running
curl http://localhost:9999/api/status

# Start manually
cd C:\Users\Admin\Downloads\Evony_Decrypted\evony_bot
C:\Python313\python.exe server.py

# Or use launcher
python -m evony_rte.server_launcher start
```

**Prevention**: Bot server now auto-starts when importing `evony_rte` module

---

### Issue: "Address already in use on port 9999"

**Symptom**: Bot server fails to start

**Cause**: Another process using port 9999

**Solution**:
```powershell
# Find process using port
netstat -ano | findstr :9999

# Kill process by PID
taskkill /PID <PID> /F

# Or use alternate port
python server.py --port 9998
```

**Prevention**: Auto-start uses port rotation (9999, 9998, 9997...)

---

### Issue: Bot server crashes silently

**Symptom**: Bot server stops responding without error

**Cause**: Unhandled exception in bot server

**Solution**:
```powershell
# Check logs
Get-Content C:\Users\Admin\Downloads\Evony_Decrypted\evony_rte\logs\*.log -Tail 50

# Restart with verbose logging
python server.py --debug
```

---

## MCP Handler Errors

### Issue: "Tool 'X' not yet implemented"

**Symptom**: Handler returns not implemented error

**Cause**: Handler not registered in HANDLERS dict

**Solution**:
```python
# Check available handlers
from evony_rte.mcp_server import HANDLERS
print(list(HANDLERS.keys()))
```

---

### Issue: Handler returns empty results

**Symptom**: Search or analysis returns no data

**Cause**: Missing source files or wrong path

**Solution**:
```powershell
# Verify AS3_Scripts directory exists
Test-Path "C:\Users\Admin\Downloads\Evony_Decrypted\AS3_Scripts_(AutoEvony2_NEW.swf)"

# Check for decompiled files
Get-ChildItem "C:\Users\Admin\Downloads\Evony_Decrypted\AS3_Scripts_(AutoEvony2_NEW.swf)" -Recurse -Filter "*.as" | Measure
```

---

### Issue: Packet encoding fails

**Symptom**: AMF3 encoding returns error

**Cause**: Invalid data types or missing fields

**Solution**:
```python
# Test with known good data
from evony_rte.mcp_server import handle_tool
result = handle_tool('packet_encode', {
    'cmd': 'city.getInfo',
    'data': {'castleId': 12345}
})
print(result)
```

---

## WSL/Tool Issues

### Issue: FFDec not found

**Symptom**: FFDec handler returns "not installed"

**Cause**: FFDec not installed in WSL

**Solution**:
```bash
# Check WSL FFDec
wsl ls -la /opt/ffdec/ffdec.sh

# Install if missing
wsl sudo mkdir -p /opt/ffdec
wsl wget -O /tmp/ffdec.zip https://github.com/jindrapetrik/jpexs-decompiler/releases/download/version24.1.1/ffdec_24.1.1.zip
wsl unzip /tmp/ffdec.zip -d /opt/ffdec
```

---

### Issue: WSL command timeout

**Symptom**: WSL commands hang or timeout

**Cause**: WSL not started or slow initialization

**Solution**:
```powershell
# Restart WSL
wsl --shutdown
wsl

# Check WSL status
wsl --status
```

---

### Issue: Ghidra not detected

**Symptom**: Ghidra handler returns "not configured"

**Cause**: GHIDRA_HOME not set or wrong path

**Solution**:
```powershell
# Check Ghidra installation
Test-Path "C:\ProgramData\chocolatey\lib\ghidra\tools\ghidra_12.0_PUBLIC"

# Set environment variable
$env:GHIDRA_HOME = "C:\ProgramData\chocolatey\lib\ghidra\tools\ghidra_12.0_PUBLIC"
```

---

### Issue: tshark/Wireshark not capturing

**Symptom**: Packet capture returns empty

**Cause**: Wrong interface or no traffic

**Solution**:
```powershell
# List interfaces
tshark -D

# Capture on specific interface
tshark -i <interface_number> -c 10
```

---

## Network Issues

### Issue: Cannot connect to Evony server

**Symptom**: game_connect fails with timeout

**Cause**: Network issues, wrong server, or firewall

**Solution**:
```powershell
# Test connectivity
Test-NetConnection -ComputerName na45.evony.com -Port 443

# Check firewall
Get-NetFirewallRule | Where-Object {$_.DisplayName -like "*Python*"}
```

---

### Issue: Proxy not intercepting traffic

**Symptom**: proxy_capture returns empty

**Cause**: Client not configured to use proxy

**Solution**:
1. Configure AutoEvony to use localhost:9998 as proxy
2. Or use packet capture (tshark) instead

---

## RAG/Knowledge Base Issues

### Issue: RAG returns generic Python docs

**Symptom**: evony_search returns unrelated results

**Cause**: Query too broad or wrong search mode

**Solution**:
```python
# Use evony_answer instead for questions
# Use specific search terms
# Check RAG mode: evony_mode tool
```

---

### Issue: RAG connection timeout

**Symptom**: RAG queries fail with timeout

**Cause**: LM Studio not running or slow model

**Solution**:
```powershell
# Check LM Studio is running
# Verify model is loaded
# Check localhost:1234 is accessible
```

---

## Exploit Testing Issues

### Issue: Exploit test returns "not connected"

**Symptom**: exploit_test fails without connection

**Cause**: Bot server not connected to game

**Solution**:
```python
# Use dry_run mode for testing without connection
handle_tool('exploit_test', {'exploit_id': 'overflow_archer', 'dry_run': True})
```

---

### Issue: State verification fails

**Symptom**: Exploit appears to work but verification fails

**Cause**: Server-side validation or timing issues

**Solution**:
1. Increase wait time between exploit and verification
2. Check for server-side patches
3. Try different exploit parameters

---

## Performance Issues

### Issue: Handlers responding slowly

**Symptom**: Response times > 5 seconds

**Cause**: Large file searches or uncached operations

**Solution**:
```python
# Check performance stats
handle_tool('performance_stats', {})

# Enable caching
# Reduce search scope
```

---

### Issue: High memory usage

**Symptom**: Python process using > 2GB RAM

**Cause**: Large file caching or memory leaks

**Solution**:
```powershell
# Restart bot server
python -m evony_rte.server_launcher stop
python -m evony_rte.server_launcher start
```

---

## Quick Fixes

| Problem | Quick Fix |
|---------|-----------|
| Bot server down | `python -m evony_rte.server_launcher start` |
| Handler not found | Check `HANDLERS.keys()` in mcp_server.py |
| WSL not responding | `wsl --shutdown` then `wsl` |
| FFDec not working | Check `/opt/ffdec/ffdec.sh` exists |
| Empty search results | Verify AS3_Scripts directory |
| Connection refused | Start bot server first |
| Timeout errors | Increase timeout or check network |

---

## Log Files

| Log | Location | Purpose |
|-----|----------|---------|
| RTE Logs | `evony_rte/logs/rte_*.log` | MCP handler logs |
| Proxy Logs | `evony_rte/logs/proxy_*.log` | Traffic interception |
| Bot Logs | `evony_bot/logs/` | Bot server logs |
| Captures | `evony_rte/captures/` | PCAP files |

---

## Getting Help

1. **Check this guide** for common issues
2. **Query RAG**: `evony_answer("how to fix X")`
3. **Check logs**: Look in `evony_rte/logs/`
4. **Run diagnostics**: `test_comprehensive.py`
5. **Review audit**: `SYSTEM_AUDIT_REPORT.md`

---

**End of Troubleshooting Guide**
