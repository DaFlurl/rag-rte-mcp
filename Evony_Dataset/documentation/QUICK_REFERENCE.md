# Flash RE Tools - Quick Reference Card

Print this and keep it handy!

---

## 🔧 SWF Analysis

### FFDec (GUI)
```powershell
ffdec.exe input.swf                    # Open in GUI
```

### FFDec (CLI)
```powershell
ffdec -export script ./out input.swf   # Export all scripts
ffdec -export image ./out input.swf    # Export all images
ffdec -export all ./out input.swf      # Export everything
ffdec -search "SharedObject" input.swf # Search text
ffdec -deobfuscate in.swf out.swf      # Deobfuscate
```

### SWFTools
```powershell
swfdump -a input.swf > dump.txt        # Full structure dump
swfstrings input.swf > strings.txt     # Extract all strings
swfextract input.swf                   # List extractable items
swfextract -j 1-999 input.swf          # Extract all JPEGs
```

---

## 🔨 Bytecode Patching (RABCDAsm)

```powershell
# Complete workflow:
swfdecompress input.swf                # 1. Decompress
abcexport input.swf                    # 2. Export ABC blocks
rabcdasm input-0.abc                   # 3. Disassemble to text
notepad input-0\*.asasm                # 4. Edit .asasm files
rabcasm input-0\input-0.main.asasm     # 5. Reassemble
abcreplace input.swf 0 input-0\*.abc   # 6. Replace in SWF
swflzmacompress input.swf              # 7. Recompress (optional)
```

---

## 📁 SOL Files

### Locations
```
%APPDATA%\Macromedia\Flash Player\#SharedObjects\<random>\<domain>\
```

### Find Evony SOL Files
```powershell
Get-ChildItem -Recurse "$env:APPDATA\Macromedia" -Filter "*.sol" | 
    Where-Object { $_.FullName -match "evony" }
```

### Python (Py3AMF)
```python
import pyamf.sol

# Read
data = pyamf.sol.load(open("save.sol", "rb"))
print(data)

# Modify
data['score'] = 9999

# Write
pyamf.sol.save(open("save.sol", "wb"), data, "save")
```

### Web Editors (No Install)
- **Minerva**: https://mariani.life/projects/minerva/
- **LSO Editor**: https://nicholashamilton.org/tools/lso/

---

## 🔍 Search Patterns

```powershell
# Find SharedObject usage
Select-String -Path "scripts\*.as" -Pattern "SharedObject|getLocal"

# Find network calls
Select-String -Path "scripts\*.as" -Pattern "URLLoader|NetConnection|sendAndLoad"

# Find URLs
Select-String -Path "scripts\*.as" -Pattern "https?://[^\s\"']+"

# Find crypto
Select-String -Path "scripts\*.as" -Pattern "MD5|SHA|encrypt|password"
```

---

## 📋 Common Tasks

| Task | Tool | Notes |
|------|------|-------|
| Open SWF GUI | FFDec | Best starting point |
| Extract scripts | FFDec CLI | `-export script` |
| Find strings | swfstrings | Quick text scan |
| Edit SOL | Minerva | Web-based, easy |
| Patch bytecode | RABCDAsm | For obfuscated code |
| Run SWF | Ruffle | No Flash Player needed |
| Inspect traffic | Fiddler | AMF plugin |

---

## 🌐 Download Links

| Tool | URL |
|------|-----|
| FFDec | https://github.com/jindrapetrik/jpexs-decompiler/releases |
| RABCDAsm | https://github.com/CyberShadow/RABCDAsm/releases |
| Ruffle | https://ruffle.rs/downloads |
| SWFTools | http://www.swftools.org/download.html |
| Flasm | https://sourceforge.net/projects/flasm/ |
| Minerva | https://mariani.life/projects/minerva/ |
| Py3AMF | `pip install Py3AMF` |

---

## 📚 Adobe Specs

- **SWF Format**: Search "Adobe SWF file format specification PDF"
- **AVM2**: Search "Adobe AVM2 overview PDF"
- **AMF0/3**: Search "Adobe AMF specification PDF"

---

## 🎯 Evony Quick Reference

### Key Classes
```
com.evony.client.LoginManager       # Login flow
com.evony.client.action.ActionFactory # API calls
com.evony.common.beans.*            # Data structures
autoevony.cmds.Commands             # Bot commands
```

### SOL Names
```
cevony_sol      # Account credentials
evony_settings  # Client preferences
```

### Key Fields in cevony_sol
```
username, password, server, serverIp, playerId, playerName
```
