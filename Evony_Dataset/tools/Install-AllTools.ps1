<#
.SYNOPSIS
    Flash Reverse Engineering Toolkit - Master Installer
.DESCRIPTION
    Downloads and installs all essential tools for Flash/SWF/SOL analysis
.NOTES
    Target: D:\EvonyToolKit\flash\tools
    Run as Administrator for best results
#>

param(
    [string]$ToolsPath = "D:\EvonyToolKit\flash\tools",
    [switch]$SkipJava,
    [switch]$SkipPython,
    [switch]$Force
)

$ErrorActionPreference = "Continue"
$ProgressPreference = "SilentlyContinue"

# Colors for output
function Write-Status($msg) { Write-Host "[*] $msg" -ForegroundColor Cyan }
function Write-Success($msg) { Write-Host "[+] $msg" -ForegroundColor Green }
function Write-Warning($msg) { Write-Host "[!] $msg" -ForegroundColor Yellow }
function Write-Error($msg) { Write-Host "[-] $msg" -ForegroundColor Red }

Write-Host @"

  ███████╗██╗      █████╗ ███████╗██╗  ██╗    ████████╗ ██████╗  ██████╗ ██╗     ███████╗
  ██╔════╝██║     ██╔══██╗██╔════╝██║  ██║    ╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██╔════╝
  █████╗  ██║     ███████║███████╗███████║       ██║   ██║   ██║██║   ██║██║     ███████╗
  ██╔══╝  ██║     ██╔══██║╚════██║██╔══██║       ██║   ██║   ██║██║   ██║██║     ╚════██║
  ██║     ███████╗██║  ██║███████║██║  ██║       ██║   ╚██████╔╝╚██████╔╝███████╗███████║
  ╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝       ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚══════╝
                                                                                         
                    Flash RE Toolkit v2.0 - Master Installer
                    =========================================

"@ -ForegroundColor Magenta

# Create directories
Write-Status "Creating directory structure..."
$dirs = @(
    $ToolsPath,
    "$ToolsPath\ffdec",
    "$ToolsPath\rabcdasm",
    "$ToolsPath\flasm",
    "$ToolsPath\swfmill",
    "$ToolsPath\swftools",
    "$ToolsPath\ruffle",
    "$ToolsPath\python",
    "$ToolsPath\sol-editors",
    "$ToolsPath\specs",
    "$ToolsPath\_temp"
)
foreach ($dir in $dirs) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
}
Write-Success "Directories created"

$tempDir = "$ToolsPath\_temp"

# ============================================================
# 1. JPEXS Free Flash Decompiler (FFDec)
# ============================================================
Write-Status "Installing JPEXS FFDec..."
try {
    $release = Invoke-RestMethod "https://api.github.com/repos/jindrapetrik/jpexs-decompiler/releases/latest"
    $version = $release.tag_name
    Write-Status "Latest version: $version"
    
    # Get ZIP version (portable, no installer needed)
    $zipAsset = $release.assets | Where-Object { $_.name -like "ffdec_*_nightly*.zip" -or $_.name -like "ffdec_*.zip" } | Select-Object -First 1
    
    if ($zipAsset) {
        $zipPath = "$tempDir\ffdec.zip"
        Write-Status "Downloading FFDec ($($zipAsset.name))..."
        Invoke-WebRequest -Uri $zipAsset.browser_download_url -OutFile $zipPath
        
        Write-Status "Extracting FFDec..."
        Expand-Archive -Path $zipPath -DestinationPath "$ToolsPath\ffdec" -Force
        Remove-Item $zipPath -Force
        Write-Success "FFDec installed to $ToolsPath\ffdec"
    } else {
        Write-Warning "Could not find FFDec ZIP. Download manually from:"
        Write-Warning "https://github.com/jindrapetrik/jpexs-decompiler/releases"
    }
} catch {
    Write-Error "Failed to install FFDec: $_"
    Write-Warning "Manual download: https://github.com/jindrapetrik/jpexs-decompiler/releases"
}

# ============================================================
# 2. RABCDAsm
# ============================================================
Write-Status "Installing RABCDAsm..."
try {
    $release = Invoke-RestMethod "https://api.github.com/repos/CyberShadow/RABCDAsm/releases/latest"
    $version = $release.tag_name
    Write-Status "Latest version: $version"
    
    $asset = $release.assets | Where-Object { $_.name -like "*windows-x64*" } | Select-Object -First 1
    
    if ($asset) {
        $zipPath = "$tempDir\rabcdasm.zip"
        Write-Status "Downloading RABCDAsm..."
        Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $zipPath
        
        Write-Status "Extracting RABCDAsm..."
        Expand-Archive -Path $zipPath -DestinationPath "$ToolsPath\rabcdasm" -Force
        Remove-Item $zipPath -Force
        Write-Success "RABCDAsm installed to $ToolsPath\rabcdasm"
    }
} catch {
    Write-Error "Failed to install RABCDAsm: $_"
    Write-Warning "Manual download: https://github.com/CyberShadow/RABCDAsm/releases"
}

# ============================================================
# 3. Ruffle (Flash Emulator)
# ============================================================
Write-Status "Installing Ruffle..."
try {
    $release = Invoke-RestMethod "https://api.github.com/repos/ruffle-rs/ruffle/releases/latest"
    $version = $release.tag_name
    Write-Status "Latest version: $version"
    
    $asset = $release.assets | Where-Object { $_.name -like "*windows-x86_64*" -and $_.name -notlike "*debug*" } | Select-Object -First 1
    
    if ($asset) {
        $zipPath = "$tempDir\ruffle.zip"
        Write-Status "Downloading Ruffle..."
        Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $zipPath
        
        Write-Status "Extracting Ruffle..."
        Expand-Archive -Path $zipPath -DestinationPath "$ToolsPath\ruffle" -Force
        Remove-Item $zipPath -Force
        Write-Success "Ruffle installed to $ToolsPath\ruffle"
    }
} catch {
    Write-Error "Failed to install Ruffle: $_"
    Write-Warning "Manual download: https://ruffle.rs/downloads"
}

# ============================================================
# 4. SWFTools
# ============================================================
Write-Status "Installing SWFTools..."
Write-Warning "SWFTools requires manual download (no automated releases)"
Write-Warning "Download from: http://www.swftools.org/download.html"
Write-Warning "Extract to: $ToolsPath\swftools"

# Create placeholder readme
@"
# SWFTools Installation

SWFTools must be downloaded manually:
1. Go to http://www.swftools.org/download.html
2. Download swftools-xxxx-win32.zip
3. Extract contents to this folder

Included tools:
- swfdump.exe   - Dump SWF structure
- swfextract.exe - Extract assets
- swfstrings.exe - Extract text strings
- swfcombine.exe - Merge SWFs
- swfrender.exe  - Render to PNG
"@ | Out-File "$ToolsPath\swftools\README.txt" -Encoding UTF8

# ============================================================
# 5. Flasm
# ============================================================
Write-Status "Installing Flasm..."
Write-Warning "Flasm requires manual download from SourceForge"
Write-Warning "Download from: https://sourceforge.net/projects/flasm/"
Write-Warning "Extract to: $ToolsPath\flasm"

@"
# Flasm Installation

Flasm must be downloaded manually:
1. Go to https://sourceforge.net/projects/flasm/
2. Download flasm-1.62-win.zip (or latest)
3. Extract contents to this folder

Usage:
- flasm -d movie.swf > movie.flm    # Disassemble
- flasm -u movie.swf                 # Update with changes
- flasm -x movie.swf                 # Decompress
"@ | Out-File "$ToolsPath\flasm\README.txt" -Encoding UTF8

# ============================================================
# 6. swfmill
# ============================================================
Write-Status "Installing swfmill..."
Write-Warning "swfmill requires manual download"
Write-Warning "Download from: https://www.swfmill.org/"
Write-Warning "Extract to: $ToolsPath\swfmill"

@"
# swfmill Installation

swfmill must be downloaded manually:
1. Go to https://www.swfmill.org/
2. Download Windows binary
3. Extract to this folder

Usage:
- swfmill swf2xml input.swf output.xml   # SWF to XML
- swfmill xml2swf input.xml output.swf   # XML to SWF
"@ | Out-File "$ToolsPath\swfmill\README.txt" -Encoding UTF8

# ============================================================
# 7. Python Tools (Py3AMF)
# ============================================================
if (-not $SkipPython) {
    Write-Status "Installing Python tools..."
    try {
        $pythonCheck = python --version 2>&1
        if ($pythonCheck -match "Python 3") {
            Write-Status "Python 3 found: $pythonCheck"
            
            Write-Status "Installing Py3AMF..."
            python -m pip install Py3AMF --quiet
            Write-Success "Py3AMF installed"
            
            # Create helper script
            @'
#!/usr/bin/env python3
"""
SOL File Reader/Writer using Py3AMF
Usage: python sol_tool.py <command> <file.sol> [output]

Commands:
  read   - Read and print SOL contents
  dump   - Dump to JSON
  edit   - Interactive edit mode
"""

import sys
import json
import pyamf.sol

def read_sol(path):
    with open(path, "rb") as f:
        data = pyamf.sol.load(f)
    return data

def write_sol(path, data, name=None):
    if name is None:
        name = path.replace(".sol", "").split("/")[-1].split("\\")[-1]
    with open(path, "wb") as f:
        pyamf.sol.save(f, data, name)

def main():
    if len(sys.argv) < 3:
        print(__doc__)
        return
    
    cmd = sys.argv[1]
    path = sys.argv[2]
    
    if cmd == "read":
        data = read_sol(path)
        print(data)
    
    elif cmd == "dump":
        data = read_sol(path)
        output = sys.argv[3] if len(sys.argv) > 3 else path.replace(".sol", ".json")
        with open(output, "w") as f:
            json.dump(data, f, indent=2, default=str)
        print(f"Dumped to {output}")
    
    elif cmd == "edit":
        data = read_sol(path)
        print("Current data:", data)
        print("\nEnter key=value pairs (empty to finish):")
        while True:
            line = input("> ").strip()
            if not line:
                break
            key, value = line.split("=", 1)
            # Try to parse value as JSON, fallback to string
            try:
                data[key] = json.loads(value)
            except:
                data[key] = value
        write_sol(path, data)
        print(f"Saved to {path}")

if __name__ == "__main__":
    main()
'@ | Out-File "$ToolsPath\python\sol_tool.py" -Encoding UTF8
            Write-Success "Created sol_tool.py helper script"
            
        } else {
            Write-Warning "Python 3 not found. Install from https://python.org"
        }
    } catch {
        Write-Warning "Python setup skipped: $_"
    }
}

# ============================================================
# 8. SOL Editors (Info)
# ============================================================
Write-Status "Setting up SOL editors info..."
@"
# SOL Editor Options

## Web-Based (No Install)
1. **Minerva** - https://mariani.life/projects/minerva/
   - Drag & drop SOL files
   - Full AMF0/AMF3 support
   - Edit and download

2. **rust-flash-lso Editor** - https://nicholashamilton.org/tools/lso/
   - Based on Ruffle's SOL parser
   - Very reliable

## Desktop Apps (Manual Download)
3. **SolVE** - https://sourceforge.net/projects/solve-lso/
   - Java cross-platform
   - GUI editor

4. **FlashCookiesView** - https://www.nirsoft.net/utils/flash_cookies_view.html
   - Windows only
   - Browse all SOL files on system

5. **.sol Editor** - https://sourceforge.net/projects/soleditor/
   - Simple Windows editor

## Python (via Py3AMF)
Use the sol_tool.py script in the python folder

## SOL File Locations
Windows: %APPDATA%\Macromedia\Flash Player\#SharedObjects\<random>\<domain>\
"@ | Out-File "$ToolsPath\sol-editors\README.txt" -Encoding UTF8

# ============================================================
# 9. Specifications (Links)
# ============================================================
Write-Status "Creating specification links..."
@"
# Adobe Flash Specifications

Download these PDFs for reference:

## SWF File Format
https://www.adobe.com/content/dam/acom/en/devnet/pdf/swf-file-format-spec.pdf

## ActionScript Virtual Machine 2 (AVM2) Overview
https://www.adobe.com/content/dam/acom/en/devnet/pdf/avm2overview.pdf

## AMF0 Specification
https://www.adobe.com/content/dam/acom/en/devnet/pdf/amf0-file-format-specification.pdf

## AMF3 Specification  
https://www.adobe.com/content/dam/acom/en/devnet/pdf/amf-file-format-spec.pdf

---

Note: Adobe links may change. Search "Adobe SWF specification PDF" if broken.
"@ | Out-File "$ToolsPath\specs\README.txt" -Encoding UTF8

# ============================================================
# Cleanup
# ============================================================
if (Test-Path $tempDir) {
    Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue
}

# ============================================================
# Add to PATH (optional)
# ============================================================
Write-Status "Adding tools to PATH for current session..."
$env:Path = "$ToolsPath\ffdec;$ToolsPath\rabcdasm;$ToolsPath\ruffle;$ToolsPath\swftools;$env:Path"

# ============================================================
# Summary
# ============================================================
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "                    INSTALLATION SUMMARY                     " -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

$installed = @()
$manual = @()

if (Test-Path "$ToolsPath\ffdec\ffdec.jar" -or (Get-ChildItem "$ToolsPath\ffdec" -Filter "*.jar" -ErrorAction SilentlyContinue)) {
    $installed += "FFDec"
} elseif (Get-ChildItem "$ToolsPath\ffdec" -ErrorAction SilentlyContinue) {
    $installed += "FFDec (check contents)"
} else {
    $manual += "FFDec - https://github.com/jindrapetrik/jpexs-decompiler/releases"
}

if (Test-Path "$ToolsPath\rabcdasm\rabcdasm.exe") {
    $installed += "RABCDAsm"
} else {
    $manual += "RABCDAsm - https://github.com/CyberShadow/RABCDAsm/releases"
}

if (Test-Path "$ToolsPath\ruffle\ruffle.exe") {
    $installed += "Ruffle"
} else {
    $manual += "Ruffle - https://ruffle.rs/downloads"
}

# Always manual
$manual += "SWFTools - http://www.swftools.org/download.html"
$manual += "Flasm - https://sourceforge.net/projects/flasm/"
$manual += "swfmill - https://www.swfmill.org/"

if ($installed.Count -gt 0) {
    Write-Host "✅ Auto-Installed:" -ForegroundColor Green
    foreach ($tool in $installed) {
        Write-Host "   - $tool" -ForegroundColor Green
    }
    Write-Host ""
}

Write-Host "📥 Manual Download Required:" -ForegroundColor Yellow
foreach ($tool in $manual) {
    Write-Host "   - $tool" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "🌐 Web-Based Tools (No Install):" -ForegroundColor Cyan
Write-Host "   - Minerva SOL Editor: https://mariani.life/projects/minerva/"
Write-Host "   - LSO Editor: https://nicholashamilton.org/tools/lso/"
Write-Host ""
Write-Host "📁 Tools installed to: $ToolsPath" -ForegroundColor White
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Magenta
Write-Host "1. Download manual tools from links above"
Write-Host "2. Test with: ffdec.bat D:\EvonyToolKit\swf\EvonyClient.swf"
Write-Host "3. See docs\ folder for usage guides"
Write-Host ""
