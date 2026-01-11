# Svony Studio - Troubleshooting Guide

> **"Problem Solver"** - Comprehensive Troubleshooting Reference

---

## Quick Diagnostics

### Run Diagnostic Check

```powershell
python scripts/diagnose.py
```

This checks:
- Python version and dependencies
- Java installation
- FFDec accessibility
- Configuration validity
- File permissions

---

## Application Issues

### Application Won't Start

**Symptoms:**
- Window doesn't appear
- Crashes immediately
- Python errors in terminal

**Solutions:**

1. **Check Python version**
   ```powershell
   python --version
   # Requires 3.11+
   ```

2. **Reinstall dependencies**
   ```powershell
   pip install -r requirements.txt --force-reinstall
   ```

3. **Check for conflicting packages**
   ```powershell
   pip check
   ```

4. **View error log**
   ```powershell
   Get-Content logs\svony_studio.log -Tail 50
   ```

5. **Run with verbose logging**
   ```powershell
   python main.py --verbose
   ```

---

### Application Freezes

**Symptoms:**
- UI becomes unresponsive
- "Not Responding" in title bar
- Must force close

**Solutions:**

1. **Wait for long operations**
   - Large SWF decompilation takes time
   - Check console for progress

2. **Increase memory allocation**
   Edit `config/settings.yaml`:
   ```yaml
   performance:
     max_memory_mb: 4096
   ```

3. **Process files in batches**
   - Don't open multiple large SWFs
   - Close unused tabs

4. **Check system resources**
   ```powershell
   Get-Process python | Select-Object CPU, WorkingSet
   ```

---

### Slow Performance

**Symptoms:**
- Operations take too long
- UI lag
- High CPU usage

**Solutions:**

1. **Enable caching**
   ```yaml
   # config/settings.yaml
   cache:
     enabled: true
     max_size_mb: 500
   ```

2. **Use SSD storage**
   - Move project to SSD
   - Set temp directory to SSD

3. **Reduce decompilation depth**
   ```yaml
   decompile:
     parallel: true
     max_threads: 4
   ```

4. **Close background processes**

---

## FFDec Issues

### FFDec Not Found

**Error:**
```
Error: FFDec not found at specified path
```

**Solutions:**

1. **Verify installation**
   ```powershell
   Test-Path "C:\Program Files (x86)\FFDec\ffdec.bat"
   ```

2. **Set environment variable**
   ```powershell
   [Environment]::SetEnvironmentVariable("FFDEC_PATH", "C:\Program Files (x86)\FFDec", "User")
   ```

3. **Edit configuration**
   ```yaml
   # config/settings.yaml
   tools:
     ffdec_path: "C:/Program Files (x86)/FFDec"
   ```

4. **Reinstall FFDec**
   - Download latest from GitHub
   - Run installer as Administrator

---

### FFDec Crashes During Decompilation

**Error:**
```
FFDec process terminated unexpectedly
```

**Solutions:**

1. **Increase Java heap**
   Edit `ffdec.bat`:
   ```batch
   java -Xmx4g -jar ffdec.jar %*
   ```

2. **Update Java**
   - Install Java 17+ LTS
   - Verify: `java -version`

3. **Try command line**
   ```powershell
   & "C:\Program Files (x86)\FFDec\ffdec.bat" -export script "output" "file.swf"
   ```

4. **Check SWF integrity**
   ```powershell
   python -c "import swftools; swftools.validate('file.swf')"
   ```

---

### Decompilation Errors

**Error:**
```
Decompilation failed: Invalid bytecode
```

**Solutions:**

1. **Use P-code instead**
   - Right-click script
   - Select "View P-code"

2. **Try different deobfuscation level**
   ```powershell
   python main.py swf deobfuscate file.swf --level 2
   ```

3. **Export as binary**
   - Export ABC bytecode
   - Use RABCDAsm for analysis

4. **Check FFDec version**
   - Update to latest release
   - Report issue with sample file

---

## SWF Issues

### Cannot Open SWF File

**Error:**
```
Error: Invalid SWF file format
```

**Solutions:**

1. **Verify file type**
   ```powershell
   # Check magic bytes
   Format-Hex file.swf -Count 8
   # Should show: 46 57 53 (FWS) or 43 57 53 (CWS) or 5A 57 53 (ZWS)
   ```

2. **File may be compressed**
   ```powershell
   python main.py swf compress file.swf --method none -o decompressed.swf
   ```

3. **File may be corrupted**
   - Re-download original
   - Check file size matches expected

4. **File is not SWF**
   - Check actual format
   - May be renamed executable

---

### SWF Opens But Shows No Content

**Symptoms:**
- Project tree is empty
- No scripts found
- No assets visible

**Solutions:**

1. **Wait for full load**
   - Large files take time
   - Watch console for progress

2. **Check SWF version**
   - Very old SWFs may have limited support
   - Check console for version info

3. **Try manual export**
   ```powershell
   python main.py swf export file.swf --type all -o output/
   ```

---

### Script Editing Fails

**Error:**
```
Recompilation failed: Syntax error
```

**Solutions:**

1. **Check ActionScript syntax**
   - Verify brackets match
   - Check semicolons
   - Validate imports

2. **Compare with original**
   - View original P-code
   - Identify specific error line

3. **Use incremental changes**
   - Make small edits
   - Recompile after each change

---

## SOL Issues

### SOL Files Not Found

**Symptoms:**
- Scan returns no results
- Expected files missing

**Solutions:**

1. **Run as Administrator**
   - Some locations require elevated access

2. **Check all locations**
   ```powershell
   # Flash Player
   Get-ChildItem "$env:APPDATA\Macromedia\Flash Player" -Recurse -Filter "*.sol"
   
   # Chrome
   Get-ChildItem "$env:LOCALAPPDATA\Google\Chrome\User Data" -Recurse -Filter "*.sol"
   ```

3. **Check browser-specific paths**
   - Firefox: `%APPDATA%\Mozilla\Firefox\Profiles\`
   - Edge: `%LOCALAPPDATA%\Microsoft\Edge\User Data\`

4. **Verify Flash was used**
   - SOL only created after Flash use
   - Play Evony in browser first

---

### SOL Parse Error

**Error:**
```
Error: Failed to parse SOL file
```

**Solutions:**

1. **File may be corrupted**
   ```powershell
   # Check file header
   Format-Hex file.sol -Count 16
   # Should start with: 00 BF (SOL magic)
   ```

2. **Try AMF version switch**
   ```python
   # Some SOLs use AMF0 instead of AMF3
   from pyamf import sol
   data = sol.load(open('file.sol', 'rb'), strict=False)
   ```

3. **Restore from backup**
   - Check `backups/` folder
   - Restore previous version

---

### SOL Edit Not Saving

**Symptoms:**
- Changes don't persist
- File unchanged after save

**Solutions:**

1. **Check file permissions**
   ```powershell
   icacls file.sol
   ```

2. **Close browser/Flash**
   - File may be locked
   - Close all Flash instances

3. **Disable read-only**
   ```powershell
   attrib -r file.sol
   ```

---

## Protocol Issues

### Traffic Capture Not Working

**Symptoms:**
- No packets captured
- Empty capture window

**Solutions:**

1. **Check proxy settings**
   - System proxy configured?
   - Port not blocked?

2. **SSL/TLS issues**
   ```powershell
   # Install mitmproxy certificate
   mitmproxy --mode regular@8888
   # Then install ~/.mitmproxy/mitmproxy-ca-cert.pem
   ```

3. **Firewall blocking**
   ```powershell
   # Allow port
   New-NetFirewallRule -DisplayName "Svony Proxy" -Direction Inbound -LocalPort 8888 -Protocol TCP -Action Allow
   ```

---

### AMF Decode Errors

**Error:**
```
Error: Failed to decode AMF message
```

**Solutions:**

1. **Check AMF version**
   ```python
   # Try both AMF0 and AMF3
   import pyamf
   pyamf.decode(data, encoding=pyamf.AMF3)
   ```

2. **Data may be encrypted**
   - Evony uses plain AMF (no encryption)
   - If encrypted, check for custom protocol

3. **Incomplete packet**
   - Ensure full packet captured
   - Check packet boundaries

---

## Bot Issues

### Script Validation Fails

**Error:**
```
Line 15: Unknown command 'ATACK'
```

**Solutions:**

1. **Check spelling**
   - Commands are case-sensitive
   - Refer to `BOT_SCRIPTING.md`

2. **Check syntax**
   ```
   # Correct
   ATTACK_NPC 5 1
   
   # Wrong
   ATTACK NPC 5,1
   ```

3. **Use script templates**
   - Start from working template
   - Modify incrementally

---

### Bot Connection Failed

**Error:**
```
Connection refused: svr12.evony.com:443
```

**Solutions:**

1. **Check server status**
   - Server may be down
   - Try different server

2. **Check network**
   ```powershell
   Test-NetConnection svr12.evony.com -Port 443
   ```

3. **Firewall/antivirus**
   - May block connections
   - Add exception

4. **Tor issues**
   ```powershell
   # Restart Tor
   Restart-Service tor
   ```

---

### Bot Gets Banned

**Symptoms:**
- Account suspended
- Login rejected

**Prevention:**

1. **Use realistic delays**
   ```
   # Add randomization
   WAIT 300
   WAIT_RANDOM 60
   ```

2. **Rotate IPs**
   - Use Tor with rotation
   - Change identity periodically

3. **Limit actions**
   - Don't run 24/7
   - Simulate human patterns

---

## Configuration Issues

### Config File Errors

**Error:**
```
Error: Invalid YAML syntax in settings.yaml
```

**Solutions:**

1. **Validate YAML**
   ```powershell
   python -c "import yaml; yaml.safe_load(open('config/settings.yaml'))"
   ```

2. **Check indentation**
   - Use spaces, not tabs
   - Consistent 2-space indent

3. **Quote special characters**
   ```yaml
   # Wrong
   path: C:\Program Files\FFDec
   
   # Correct
   path: "C:\\Program Files\\FFDec"
   # Or
   path: "C:/Program Files/FFDec"
   ```

4. **Reset to defaults**
   ```powershell
   Copy-Item config/settings.yaml.example config/settings.yaml
   ```

---

### Environment Variable Issues

**Symptoms:**
- Settings not applied
- Paths incorrect

**Solutions:**

1. **Check variable is set**
   ```powershell
   $env:FFDEC_PATH
   ```

2. **Set permanently**
   ```powershell
   [Environment]::SetEnvironmentVariable("FFDEC_PATH", "path", "User")
   ```

3. **Restart terminal**
   - Changes require new session

---

## Error Messages Reference

| Error | Cause | Solution |
|-------|-------|----------|
| `ModuleNotFoundError` | Missing dependency | `pip install -r requirements.txt` |
| `FileNotFoundError` | Path incorrect | Verify file exists |
| `PermissionError` | Access denied | Run as Admin / Check permissions |
| `ConnectionRefused` | Server/port issue | Check network / firewall |
| `TimeoutError` | Slow response | Increase timeout / Check connection |
| `ValueError: Invalid SWF` | Corrupt/wrong file | Verify file format |
| `UnicodeDecodeError` | Encoding issue | Specify encoding / Use binary mode |
| `MemoryError` | Insufficient RAM | Close applications / Increase memory |

---

## Getting Help

If troubleshooting doesn't resolve your issue:

1. **Collect information**
   - Error messages (full text)
   - Log files (`logs/`)
   - Steps to reproduce

2. **Search existing issues**
   - GitHub Issues
   - FAQ document

3. **Create bug report**
   - Include all collected info
   - Attach sample files if possible

---

## Related Documentation

- `FAQ.md` - Common questions
- `INSTALLATION_GUIDE.md` - Setup help
- `CLI_REFERENCE.md` - Command help
- `USER_GUIDE.md` - Usage guide

---

*Document Version: 1.0.0 | Troubleshooting Guide*
