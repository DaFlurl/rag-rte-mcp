<#
.SYNOPSIS
    SOL File Finder and Extractor
.DESCRIPTION
    Finds all Flash Local Shared Objects (.sol files) and extracts data
.EXAMPLE
    .\Extract-SOLData.ps1 -Domain "evony"
    .\Extract-SOLData.ps1 -AllFiles -OutputDir D:\EvonyToolKit\sol_backup
#>

param(
    [string]$Domain = "",
    [switch]$AllFiles,
    [string]$OutputDir = ".\sol_output",
    [switch]$BackupOriginals,
    [switch]$UseRustLso
)

$ErrorActionPreference = "Continue"

Write-Host @"

  ███████╗ ██████╗ ██╗         ███████╗██╗  ██╗████████╗██████╗  █████╗  ██████╗████████╗ ██████╗ ██████╗ 
  ██╔════╝██╔═══██╗██║         ██╔════╝╚██╗██╔╝╚══██╔══╝██╔══██╗██╔══██╗██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗
  ███████╗██║   ██║██║         █████╗   ╚███╔╝    ██║   ██████╔╝███████║██║        ██║   ██║   ██║██████╔╝
  ╚════██║██║   ██║██║         ██╔══╝   ██╔██╗    ██║   ██╔══██╗██╔══██║██║        ██║   ██║   ██║██╔══██╗
  ███████║╚██████╔╝███████╗    ███████╗██╔╝ ██╗   ██║   ██║  ██║██║  ██║╚██████╗   ██║   ╚██████╔╝██║  ██║
  ╚══════╝ ╚═════╝ ╚══════╝    ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝

"@ -ForegroundColor Magenta

# SOL file locations
$solPaths = @(
    "$env:APPDATA\Macromedia\Flash Player\#SharedObjects",
    "$env:APPDATA\Adobe\Flash Player\SharedObjects",
    "$env:LOCALAPPDATA\Macromedia\Flash Player\#SharedObjects"
)

# Find all SOL files
Write-Host "[1/4] Scanning for SOL files..." -ForegroundColor Yellow
$solFiles = @()
foreach ($basePath in $solPaths) {
    if (Test-Path $basePath) {
        $found = Get-ChildItem -Path $basePath -Filter "*.sol" -Recurse -ErrorAction SilentlyContinue
        $solFiles += $found
        Write-Host "  Found $($found.Count) files in $basePath"
    }
}

if ($solFiles.Count -eq 0) {
    Write-Host "No SOL files found!" -ForegroundColor Red
    Write-Host "SOL files are typically stored in:" -ForegroundColor Yellow
    foreach ($path in $solPaths) {
        Write-Host "  - $path"
    }
    exit 1
}

Write-Host "  Total: $($solFiles.Count) SOL files found" -ForegroundColor Green
Write-Host ""

# Filter by domain if specified
if ($Domain -and -not $AllFiles) {
    Write-Host "[2/4] Filtering by domain: '$Domain'" -ForegroundColor Yellow
    $solFiles = $solFiles | Where-Object { $_.FullName -match $Domain }
    Write-Host "  Filtered to $($solFiles.Count) files" -ForegroundColor Green
} elseif (-not $AllFiles) {
    Write-Host "[2/4] Filtering for Evony-related files..." -ForegroundColor Yellow
    $solFiles = $solFiles | Where-Object { 
        $_.FullName -match "evony|cevony|robo|localhost" 
    }
    Write-Host "  Filtered to $($solFiles.Count) files" -ForegroundColor Green
}
Write-Host ""

if ($solFiles.Count -eq 0) {
    Write-Host "No matching SOL files found!" -ForegroundColor Red
    exit 1
}

# Create output directory
New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null

# Display found files
Write-Host "[3/4] Found SOL files:" -ForegroundColor Yellow
$solFiles | ForEach-Object {
    $relativePath = $_.FullName -replace [regex]::Escape($env:APPDATA), '%APPDATA%'
    $size = [math]::Round($_.Length / 1KB, 2)
    Write-Host "  [$size KB] $relativePath" -ForegroundColor Gray
}
Write-Host ""

# Backup originals if requested
if ($BackupOriginals) {
    Write-Host "[3b] Backing up original files..." -ForegroundColor Yellow
    $backupDir = "$OutputDir\_backup"
    New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
    foreach ($sol in $solFiles) {
        $destName = $sol.FullName -replace '[:\\]', '_'
        Copy-Item $sol.FullName "$backupDir\$destName" -Force
    }
    Write-Host "  Backed up to $backupDir" -ForegroundColor Green
    Write-Host ""
}

# Extract data using Python (Py3AMF)
Write-Host "[4/4] Extracting SOL data..." -ForegroundColor Yellow

# Check for Python
$pythonAvailable = $false
try {
    $pythonCheck = python --version 2>&1
    if ($pythonCheck -match "Python 3") {
        $pythonAvailable = $true
    }
} catch {}

if ($pythonAvailable) {
    Write-Host "  Using Python + Py3AMF..." -ForegroundColor Green
    
    # Create extraction script
    $extractScript = @'
import sys
import os
import json

try:
    import pyamf.sol
except ImportError:
    print("ERROR: Py3AMF not installed. Run: pip install Py3AMF")
    sys.exit(1)

def extract_sol(path):
    try:
        with open(path, "rb") as f:
            data = pyamf.sol.load(f)
        return {"status": "ok", "data": data}
    except Exception as e:
        return {"status": "error", "error": str(e)}

def serialize(obj):
    """Convert objects to JSON-serializable format"""
    if hasattr(obj, '__dict__'):
        return {k: serialize(v) for k, v in obj.__dict__.items()}
    elif isinstance(obj, dict):
        return {str(k): serialize(v) for k, v in obj.items()}
    elif isinstance(obj, (list, tuple)):
        return [serialize(i) for i in obj]
    elif isinstance(obj, bytes):
        return obj.hex()
    else:
        try:
            json.dumps(obj)
            return obj
        except:
            return str(obj)

if __name__ == "__main__":
    sol_path = sys.argv[1]
    output_path = sys.argv[2] if len(sys.argv) > 2 else sol_path.replace(".sol", ".json")
    
    result = extract_sol(sol_path)
    
    if result["status"] == "ok":
        serialized = serialize(result["data"])
        with open(output_path, "w") as f:
            json.dump(serialized, f, indent=2, default=str)
        print(f"OK: {output_path}")
    else:
        print(f"ERROR: {result['error']}")
'@
    
    $extractScriptPath = "$OutputDir\_extract_sol.py"
    $extractScript | Out-File $extractScriptPath -Encoding UTF8
    
    # Process each file
    $successCount = 0
    $errorCount = 0
    
    foreach ($sol in $solFiles) {
        $outputName = $sol.Name -replace '\.sol$', '.json'
        $domainFolder = Split-Path (Split-Path $sol.FullName -Parent) -Leaf
        $outputSubDir = "$OutputDir\$domainFolder"
        New-Item -ItemType Directory -Path $outputSubDir -Force | Out-Null
        $outputFile = "$outputSubDir\$outputName"
        
        $result = python $extractScriptPath $sol.FullName $outputFile 2>&1
        
        if ($result -match "^OK:") {
            $successCount++
            Write-Host "  ✓ $($sol.Name)" -ForegroundColor Green
        } else {
            $errorCount++
            Write-Host "  ✗ $($sol.Name): $result" -ForegroundColor Red
        }
    }
    
    # Cleanup
    Remove-Item $extractScriptPath -Force -ErrorAction SilentlyContinue
    
    Write-Host ""
    Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host "  Extraction Complete!" -ForegroundColor Green
    Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host "  Success: $successCount" -ForegroundColor Green
    Write-Host "  Errors:  $errorCount" -ForegroundColor $(if ($errorCount -gt 0) { "Red" } else { "Green" })
    Write-Host "  Output:  $OutputDir" -ForegroundColor White
    
} else {
    Write-Host "  Python not available - listing files only" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "To extract SOL data, either:" -ForegroundColor Yellow
    Write-Host "  1. Install Python 3 and Py3AMF: pip install Py3AMF"
    Write-Host "  2. Use web editor: https://mariani.life/projects/minerva/"
    Write-Host "  3. Use web editor: https://nicholashamilton.org/tools/lso/"
    Write-Host ""
    
    # Create listing file
    $listing = @()
    foreach ($sol in $solFiles) {
        $listing += [PSCustomObject]@{
            Name = $sol.Name
            Path = $sol.FullName
            Size = $sol.Length
            Modified = $sol.LastWriteTime
        }
    }
    $listing | Export-Csv "$OutputDir\sol_file_listing.csv" -NoTypeInformation
    Write-Host "File listing saved to: $OutputDir\sol_file_listing.csv" -ForegroundColor Green
}

Write-Host ""
Write-Host "Next steps:" -ForegroundColor Magenta
Write-Host "  1. Review extracted JSON files in $OutputDir"
Write-Host "  2. Edit with: https://mariani.life/projects/minerva/"
Write-Host "  3. For Svony integration, import JSON into your database"
Write-Host ""
