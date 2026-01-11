# 🔧 Flash Reverse Engineering Toolkit v2.0

**For Evony Age II Automation Projects**

A comprehensive, production-ready collection of tools for reverse engineering Flash Player 11 era (2009-2018) SWF files, Local Shared Objects (.sol), and ActionScript bytecode.

```
Target Project: D:\EvonyToolKit\
Flash Versions: 9-11.2 (SWF versions 9-14)
Decompiled Targets: AutoEvony.swf, EvonyClient.swf, RE for Age II v1.60
Integration: Svony SOL Manager Pro v2.0, RoboEvony 2026
```

---

## 🚀 Quick Start

```powershell
# Copy this folder to your project
Copy-Item -Recurse .\flash_toolkit_complete D:\EvonyToolKit\flash

# Run the installer (downloads all tools)
cd D:\EvonyToolKit\flash\scripts
.\Install-AllTools.ps1

# Or install specific categories
.\Install-SWFTools.ps1      # SWF manipulation tools
.\Install-SOLTools.ps1       # SOL/LSO editors  
.\Install-BytecodeTools.ps1  # Bytecode assemblers
```

---

## 📊 Tool Matrix

| Category | Tool | Platform | Rating | Primary Use |
|----------|------|----------|--------|-------------|
| **SWF Decompiler** | JPEXS FFDec | Win/Linux/Mac | ★★★★★ | Full decompilation, SOL editor |
| **ABC Bytecode** | RABCDAsm | Win/Linux/Mac | ★★★★★ | AS3 bytecode patching |
| **AS1/2 Bytecode** | Flasm | Win/Linux/Mac | ★★★★☆ | Legacy ActionScript |
| **SWF→XML** | swfmill | Win/Linux/Mac | ★★★★☆ | Structure analysis |
| **SWF Utils** | SWFTools | Win/Linux/Mac | ★★★★☆ | Asset extraction |
| **SOL Parser** | rust-flash-lso | Cross-platform | ★★★★★ | Rust-based SOL parsing |
| **SOL Python** | Py3AMF | Python | ★★★★☆ | Python SOL scripting |
| **SOL Web** | Minerva | Web | ★★★★☆ | Browser-based editor |
| **Emulator** | Ruffle | Win/Linux/Mac/Web | ★★★★☆ | Run SWFs without Flash |
| **Network** | Fiddler/Charles | Win/Mac | ★★★★☆ | AMF traffic inspection |
| **Deobfuscator** | de4dot-flash | Win | ★★★☆☆ | SecureSWF removal |

---

## 📁 Folder Structure

```
D:\EvonyToolKit\flash\
├── README.md                    # This file
├── ARCHITECTURE.md              # System design & data flows
├── scripts/
│   ├── Install-AllTools.ps1     # Master installer
│   ├── Install-SWFTools.ps1     # SWF tool installer
│   ├── Install-SOLTools.ps1     # SOL tool installer
│   ├── Install-BytecodeTools.ps1
│   ├── Analyze-SWF.ps1          # Quick SWF analysis
│   ├── Extract-SOLData.ps1      # SOL data extractor
│   └── Batch-Decompile.ps1      # Batch decompilation
├── tools/
│   ├── ffdec/                   # JPEXS FFDec
│   ├── rabcdasm/                # RABCDAsm suite
│   ├── flasm/                   # Flasm AS1/2
│   ├── swfmill/                 # SWF↔XML
│   ├── swftools/                # SWFTools suite
│   ├── ruffle/                  # Flash emulator
│   └── python/                  # Py3AMF & scripts
├── docs/
│   ├── 01_TOOL_CATALOG.md       # Full tool reference
│   ├── 02_SOL_GUIDE.md          # SOL file deep dive
│   ├── 03_BYTECODE_PATCHING.md  # ABC modification
│   ├── 04_EVONY_ANALYSIS.md     # Evony-specific
│   ├── 05_API_REFERENCE.md      # Discovered APIs
│   └── QUICK_REFERENCE.md       # Cheat sheet
├── diagrams/
│   ├── architecture.svg
│   ├── tool-landscape.svg
│   └── evony-data-flow.svg
├── analysis/
│   ├── evony_strings.txt        # Extracted strings
│   ├── evony_classes.txt        # Class list
│   └── sol_structure.json       # SOL schema
└── specs/
    ├── swf_spec.pdf             # Adobe SWF spec
    ├── amf0_spec.pdf            # AMF0 format
    └── amf3_spec.pdf            # AMF3 format
```

---

## 🏆 Tier 1: Essential Tools

### 1. JPEXS Free Flash Decompiler (FFDec) — ★★★★★

The most important tool. Does 90% of what you need.

| Property | Value |
|----------|-------|
| **Repository** | https://github.com/jindrapetrik/jpexs-decompiler |
| **Latest Release** | https://github.com/jindrapetrik/jpexs-decompiler/releases/latest |
| **License** | GPL-3.0 |
| **Requirements** | Java 8+ (bundled in Windows installer) |

**Why Essential:**
- Full ActionScript 1/2/3 decompilation
- Built-in SOL editor (v7.1.0+) — edits your Evony .sol files directly
- Hex view, P-code view, decompiled view side-by-side
- Edit and recompile ActionScript
- Extract all resources (images, sounds, fonts, shapes, sprites)
- Export to FLA (Flash Professional format)
- Deobfuscate common protections
- CLI support for batch operations

**Download & Install:**
```powershell
# Windows installer (includes Java)
$release = Invoke-RestMethod "https://api.github.com/repos/jindrapetrik/jpexs-decompiler/releases/latest"
$asset = $release.assets | Where-Object { $_.name -like "*setup.exe" }
Invoke-WebRequest -Uri $asset.browser_download_url -OutFile "ffdec_setup.exe"
Start-Process "ffdec_setup.exe" -Wait
```

**Usage:**
```powershell
# GUI - open SWF
& "C:\Program Files\FFDec\ffdec.exe" "D:\EvonyToolKit\swf\EvonyClient.swf"

# CLI - export all scripts
ffdec -export script "D:\EvonyToolKit\analysis\scripts" "D:\EvonyToolKit\swf\EvonyClient.swf"

# CLI - export all images
ffdec -export image "D:\EvonyToolKit\analysis\images" "D:\EvonyToolKit\swf\EvonyClient.swf"

# CLI - search for SharedObject usage
ffdec -search "SharedObject" "D:\EvonyToolKit\swf\EvonyClient.swf"

# CLI - deobfuscate
ffdec -deobfuscate "input.swf" "output_clean.swf"
```

---

### 2. RABCDAsm — ★★★★★

ActionScript 3 bytecode assembler/disassembler. When you need to patch bytecode that FFDec can't handle.

| Property | Value |
|----------|-------|
| **Repository** | https://github.com/CyberShadow/RABCDAsm |
| **Releases** | https://github.com/CyberShadow/RABCDAsm/releases |
| **License** | GPL-3.0 |

**Included Utilities:**
- `rabcdasm` - Disassemble ABC to editable text
- `rabcasm` - Assemble text back to ABC
- `abcexport` - Extract ABC blocks from SWF
- `abcreplace` - Replace ABC blocks in SWF
- `swfdecompress` - Decompress SWF (CWS→FWS)
- `swf7zcompress` - 7-zip compression
- `swflzmacompress` - LZMA compression (Flash 11+)

**Download:**
```powershell
$release = Invoke-RestMethod "https://api.github.com/repos/CyberShadow/RABCDAsm/releases/latest"
$asset = $release.assets | Where-Object { $_.name -like "*windows-x64*" }
Invoke-WebRequest -Uri $asset.browser_download_url -OutFile "RABCDAsm.zip"
Expand-Archive "RABCDAsm.zip" -DestinationPath "D:\EvonyToolKit\flash\tools\rabcdasm"
```

**Patching Workflow:**
```powershell
cd D:\EvonyToolKit\swf

# 1. Decompress SWF (optional but recommended)
swfdecompress.exe EvonyClient.swf

# 2. Export all ABC blocks
abcexport.exe EvonyClient.swf
# Creates: EvonyClient-0.abc, EvonyClient-1.abc, ...

# 3. Disassemble the ABC block you want to patch
rabcdasm.exe EvonyClient-0.abc
# Creates: EvonyClient-0/ directory with .asasm files

# 4. Edit the .asasm files with your changes
notepad EvonyClient-0\com\evony\client\LoginManager.class.asasm

# 5. Reassemble
rabcasm.exe EvonyClient-0\EvonyClient-0.main.asasm

# 6. Replace in SWF
abcreplace.exe EvonyClient.swf 0 EvonyClient-0\EvonyClient-0.main.abc

# 7. Recompress (optional)
swflzmacompress.exe EvonyClient.swf
```

---

### 3. rust-flash-lso — ★★★★★

The most robust SOL parser. Powers the Ruffle emulator's save system.

| Property | Value |
|----------|-------|
| **Repository** | https://github.com/ruffle-rs/rust-flash-lso |
| **Crate** | https://crates.io/crates/flash-lso |
| **Web Editor** | https://nicholashamilton.org/tools/lso/ |

**Why Use This:**
- Written in safe Rust — no crashes on malformed files
- Full AMF0 and AMF3 support
- Handles circular references
- Handles IExternalizable custom types
- Extensively fuzzed

**Web Editor (No Install):**
1. Go to https://nicholashamilton.org/tools/lso/
2. Drag and drop your .sol file
3. Edit values in the tree view
4. Download modified file

**Build from Source:**
```powershell
# Requires Rust toolchain
cargo install lso-to-json
lso-to-json config.sol > config.json
```

---

### 4. Py3AMF — ★★★★☆

Python library for AMF and SOL manipulation. Perfect for scripting.

| Property | Value |
|----------|-------|
| **Repository** | https://github.com/StdCarrot/Py3AMF |
| **PyPI** | https://pypi.org/project/Py3AMF/ |

**Install:**
```powershell
pip install Py3AMF
```

**Usage:**
```python
import pyamf.sol

# Read .sol file
with open("cevony_sol.sol", "rb") as f:
    data = pyamf.sol.load(f)
    
print(data)
# Output: {'username': 'player1', 'server': 'cc2', 'password': '...'}

# Modify values
data['server'] = 'na100'

# Save back
with open("cevony_sol.sol", "wb") as f:
    pyamf.sol.save(f, data, "cevony_sol")
```

---

## 🏅 Tier 2: High-Value Tools

### 5. Flasm — ★★★★☆

ActionScript 1/2 bytecode assembler. For older SWF versions.

| Property | Value |
|----------|-------|
| **SourceForge** | https://sourceforge.net/projects/flasm/ |
| **GitHub Mirror** | https://github.com/nickshanks/Flasm |

```powershell
# Disassemble
flasm.exe -d movie.swf > movie.flm

# Reassemble with changes
flasm.exe -u movie.swf

# Decompress SWF
flasm.exe -x movie.swf
```

---

### 6. swfmill — ★★★★☆

Convert SWF to/from XML for programmatic analysis.

| Property | Value |
|----------|-------|
| **Repository** | https://github.com/nickshanks/swfmill |
| **Website** | https://www.swfmill.org/ |

```powershell
# SWF to XML
swfmill.exe swf2xml input.swf output.xml

# XML to SWF
swfmill.exe xml2swf modified.xml output.swf
```

---

### 7. SWFTools — ★★★★☆

Swiss-army knife utilities.

| Property | Value |
|----------|-------|
| **Repository** | https://github.com/matthiaskramm/swftools |
| **Website** | http://www.swftools.org/ |

**Included:**
- `swfdump` - Dump structure
- `swfextract` - Extract assets
- `swfstrings` - Extract text
- `swfcombine` - Merge SWFs
- `swfrender` - Render to PNG

```powershell
# Dump full analysis
swfdump.exe -a EvonyClient.swf > evony_dump.txt

# Extract all strings (find SharedObject keys!)
swfstrings.exe EvonyClient.swf > evony_strings.txt

# List extractable assets
swfextract.exe EvonyClient.swf

# Extract JPEG #42
swfextract.exe -j 42 -o asset42.jpg EvonyClient.swf
```

---

### 8. Ruffle — ★★★★☆

Modern Flash emulator. Run SWFs without Adobe Flash Player.

| Property | Value |
|----------|-------|
| **Repository** | https://github.com/ruffle-rs/ruffle |
| **Website** | https://ruffle.rs/ |
| **Downloads** | https://ruffle.rs/downloads |

```powershell
# Run SWF
ruffle.exe EvonyClient.swf
```

---

## 🔬 Tier 3: SOL-Specific Tools

### 9. Minerva (Web) — ★★★★☆
- **URL:** https://mariani.life/projects/minerva/
- **Use:** Drag & drop SOL editing in browser

### 10. SolVE — ★★★☆☆
- **URL:** https://sourceforge.net/projects/solve-lso/
- **Use:** Java cross-platform GUI editor

### 11. FlashCookiesView — ★★★☆☆
- **URL:** https://www.nirsoft.net/utils/flash_cookies_view.html
- **Use:** Windows utility to browse all SOL files

### 12. .sol Editor — ★★★☆☆
- **URL:** https://sourceforge.net/projects/soleditor/
- **Use:** Simple Windows GUI

---

## 📍 SOL File Locations

**Windows (Standard Flash Player):**
```
%APPDATA%\Macromedia\Flash Player\#SharedObjects\<random>\<domain>\
```

**Windows (Standalone Projector like RoboEvony):**
```
%APPDATA%\Macromedia\Flash Player\#SharedObjects\<random>\localhost\
```

**Your Evony SOL files are likely at:**
```
C:\Users\Dave\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\ABC123\evony.com\
C:\Users\Dave\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\ABC123\localhost\
```

**Quick Find Script:**
```powershell
# Find all Evony-related SOL files
Get-ChildItem -Recurse "$env:APPDATA\Macromedia" -Filter "*.sol" | 
    Where-Object { $_.FullName -match "evony|cevony|robo" } |
    Select-Object FullName, Length, LastWriteTime
```

---

## 🎯 Evony-Specific Analysis

### Known SharedObject Names
Based on decompiled code analysis:

| SOL Name | Purpose | Key Fields |
|----------|---------|------------|
| `cevony_sol` | Account credentials | username, password, server, email |
| `evony_settings` | Client preferences | volume, quality, language |
| `evony_cache` | Cached game data | mapData, cityData |

### Key Classes to Analyze

```
com.evony.client.LoginManager           # Login flow
com.evony.client.action.ActionFactory   # API calls
com.evony.common.beans.*                # Data structures
com.evony.common.module.*               # Protocol handlers
autoevony.cmds.Commands                 # Bot commands
autoevony.net.Connection                # Network layer
```

### Finding API Endpoints
```powershell
# Search decompiled scripts for API patterns
Select-String -Path "D:\EvonyToolKit\analysis\scripts\*.as" -Pattern "sendAndLoad|URLLoader|NetConnection"
```

---

## 📚 Adobe Specifications

Download these for deep understanding:

| Spec | URL |
|------|-----|
| **SWF File Format** | https://www.adobe.com/content/dam/acom/en/devnet/pdf/swf-file-format-spec.pdf |
| **AVM2 Overview** | https://www.adobe.com/content/dam/acom/en/devnet/pdf/avm2overview.pdf |
| **AMF0 Spec** | https://www.adobe.com/content/dam/acom/en/devnet/pdf/amf0-file-format-specification.pdf |
| **AMF3 Spec** | https://www.adobe.com/content/dam/acom/en/devnet/pdf/amf-file-format-spec.pdf |

---

## 🔄 Version History

- **v2.0.0** (2026-01-01) - Complete rewrite with working scripts
- **v1.0.0** (2026-01-01) - Initial compilation

---

## 📞 Integration with Svony

Your Svony SOL Manager at `D:\EvonyToolKit\Svony` should integrate:

1. **rust-flash-lso** - Core parsing engine for reading .sol files
2. **Py3AMF** - Python scripting for batch operations
3. **FFDec CLI** - SWF analysis automation

See `docs/04_EVONY_ANALYSIS.md` for integration patterns.
