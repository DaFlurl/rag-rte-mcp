<#
.SYNOPSIS
    Quick SWF Analysis Script
.DESCRIPTION
    Performs initial analysis on a SWF file using available tools
.EXAMPLE
    .\Analyze-SWF.ps1 -SWFPath D:\EvonyToolKit\swf\EvonyClient.swf
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$SWFPath,
    
    [string]$OutputDir = ".\analysis_output",
    
    [switch]$DecompileScripts,
    [switch]$ExtractAssets,
    [switch]$FindSecrets
)

$ErrorActionPreference = "Continue"

# Verify file exists
if (-not (Test-Path $SWFPath)) {
    Write-Error "SWF file not found: $SWFPath"
    exit 1
}

$swfName = [System.IO.Path]::GetFileNameWithoutExtension($SWFPath)
$outputPath = Join-Path $OutputDir $swfName
New-Item -ItemType Directory -Path $outputPath -Force | Out-Null

Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  SWF Analysis: $swfName" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

# Find tools
$toolsBase = Split-Path -Parent $PSScriptRoot
$ffdec = Get-ChildItem "$toolsBase\tools\ffdec" -Filter "ffdec.bat" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
$swfdump = Get-ChildItem "$toolsBase\tools\swftools" -Filter "swfdump.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
$swfstrings = Get-ChildItem "$toolsBase\tools\swftools" -Filter "swfstrings.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
$rabcdasm = Get-ChildItem "$toolsBase\tools\rabcdasm" -Filter "rabcdasm.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
$abcexport = Get-ChildItem "$toolsBase\tools\rabcdasm" -Filter "abcexport.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1

# ─────────────────────────────────────────────────────────────
# 1. Basic File Info
# ─────────────────────────────────────────────────────────────
Write-Host "[1/6] Basic File Info" -ForegroundColor Yellow
$fileInfo = Get-Item $SWFPath
@"
File: $($fileInfo.Name)
Size: $([math]::Round($fileInfo.Length / 1MB, 2)) MB ($($fileInfo.Length) bytes)
Created: $($fileInfo.CreationTime)
Modified: $($fileInfo.LastWriteTime)
"@ | Tee-Object -FilePath "$outputPath\00_file_info.txt"

# Check SWF signature
$bytes = [System.IO.File]::ReadAllBytes($SWFPath)[0..2]
$sig = [System.Text.Encoding]::ASCII.GetString($bytes)
$compression = switch ($sig) {
    "FWS" { "Uncompressed" }
    "CWS" { "ZLIB compressed" }
    "ZWS" { "LZMA compressed" }
    default { "Unknown ($sig)" }
}
Write-Host "  Signature: $sig ($compression)"
Write-Host ""

# ─────────────────────────────────────────────────────────────
# 2. SWF Dump (if swfdump available)
# ─────────────────────────────────────────────────────────────
Write-Host "[2/6] SWF Structure Dump" -ForegroundColor Yellow
if ($swfdump) {
    Write-Host "  Using swfdump..."
    & $swfdump.FullName -a $SWFPath > "$outputPath\01_swf_dump.txt" 2>&1
    
    # Quick stats
    $dump = Get-Content "$outputPath\01_swf_dump.txt" -Raw -ErrorAction SilentlyContinue
    if ($dump) {
        $frameCount = ([regex]::Matches($dump, "SHOWFRAME")).Count
        $defineCount = ([regex]::Matches($dump, "DEFINE")).Count
        Write-Host "  Frames: $frameCount, Definitions: $defineCount"
    }
} else {
    Write-Host "  swfdump not found - skipping" -ForegroundColor DarkGray
}
Write-Host ""

# ─────────────────────────────────────────────────────────────
# 3. String Extraction
# ─────────────────────────────────────────────────────────────
Write-Host "[3/6] Extracting Strings" -ForegroundColor Yellow
if ($swfstrings) {
    Write-Host "  Using swfstrings..."
    & $swfstrings.FullName $SWFPath > "$outputPath\02_strings.txt" 2>&1
    $stringCount = (Get-Content "$outputPath\02_strings.txt" -ErrorAction SilentlyContinue | Measure-Object).Count
    Write-Host "  Found $stringCount strings"
} else {
    # Fallback: simple string extraction
    Write-Host "  swfstrings not found - using fallback method..."
    $content = [System.IO.File]::ReadAllBytes($SWFPath)
    $strings = [System.Text.Encoding]::UTF8.GetString($content) -split '[^\x20-\x7E]+' | 
        Where-Object { $_.Length -ge 4 } | 
        Sort-Object -Unique
    $strings | Out-File "$outputPath\02_strings.txt"
    Write-Host "  Extracted $($strings.Count) strings (fallback method)"
}
Write-Host ""

# ─────────────────────────────────────────────────────────────
# 4. Search for Interesting Patterns
# ─────────────────────────────────────────────────────────────
Write-Host "[4/6] Pattern Search" -ForegroundColor Yellow
$strings = Get-Content "$outputPath\02_strings.txt" -ErrorAction SilentlyContinue

$patterns = @{
    "SharedObject" = "SOL/Cookie usage"
    "getLocal" = "SOL access"
    "URLLoader" = "HTTP requests"
    "NetConnection" = "AMF/Socket connections"
    "Socket" = "Raw socket usage"
    "MD5|SHA|encrypt|decrypt" = "Crypto functions"
    "password|passwd|secret|key|token" = "Potential secrets"
    "http://|https://" = "URLs"
    "\.php|\.asp|\.swf" = "Server endpoints"
    "evony|Evony" = "Game-specific"
}

$findings = @()
foreach ($pattern in $patterns.Keys) {
    $matches = $strings | Where-Object { $_ -match $pattern }
    if ($matches) {
        $findings += "[$($patterns[$pattern])] Found $($matches.Count) matches for '$pattern'"
        $matches | Out-File "$outputPath\03_pattern_$($pattern -replace '[|/\\]','_').txt"
    }
}

if ($findings.Count -gt 0) {
    $findings | ForEach-Object { Write-Host "  $_" }
    $findings | Out-File "$outputPath\03_pattern_summary.txt"
} else {
    Write-Host "  No notable patterns found" -ForegroundColor DarkGray
}
Write-Host ""

# ─────────────────────────────────────────────────────────────
# 5. ABC Export (if available)
# ─────────────────────────────────────────────────────────────
Write-Host "[5/6] ABC Bytecode Export" -ForegroundColor Yellow
if ($abcexport) {
    Write-Host "  Using abcexport..."
    Push-Location $outputPath
    try {
        & $abcexport.FullName $SWFPath 2>&1 | Out-Null
        $abcFiles = Get-ChildItem "*.abc" -ErrorAction SilentlyContinue
        Write-Host "  Exported $($abcFiles.Count) ABC block(s)"
        $abcFiles | ForEach-Object { Write-Host "    - $($_.Name) ($([math]::Round($_.Length/1KB, 1)) KB)" }
    } finally {
        Pop-Location
    }
} else {
    Write-Host "  abcexport not found - skipping" -ForegroundColor DarkGray
}
Write-Host ""

# ─────────────────────────────────────────────────────────────
# 6. FFDec Decompilation (if requested)
# ─────────────────────────────────────────────────────────────
Write-Host "[6/6] Script Decompilation" -ForegroundColor Yellow
if ($DecompileScripts) {
    if ($ffdec) {
        Write-Host "  Using FFDec (this may take a while)..."
        $scriptsDir = "$outputPath\scripts"
        New-Item -ItemType Directory -Path $scriptsDir -Force | Out-Null
        & $ffdec.FullName -export script $scriptsDir $SWFPath 2>&1 | Out-Null
        $scriptCount = (Get-ChildItem $scriptsDir -Recurse -Filter "*.as" -ErrorAction SilentlyContinue | Measure-Object).Count
        Write-Host "  Exported $scriptCount ActionScript files"
    } else {
        Write-Host "  FFDec not found - skipping" -ForegroundColor DarkGray
        Write-Host "  Run: ffdec.bat -export script $outputPath\scripts $SWFPath"
    }
} else {
    Write-Host "  Skipped (use -DecompileScripts to enable)" -ForegroundColor DarkGray
}
Write-Host ""

# ─────────────────────────────────────────────────────────────
# Summary
# ─────────────────────────────────────────────────────────────
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  Analysis Complete!" -ForegroundColor Green
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
Write-Host "Output saved to: $outputPath" -ForegroundColor White
Write-Host ""
Write-Host "Files created:" -ForegroundColor White
Get-ChildItem $outputPath -File | ForEach-Object { 
    Write-Host "  - $($_.Name)" -ForegroundColor Gray
}
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Review 02_strings.txt for interesting data"
Write-Host "  2. Check 03_pattern_*.txt for specific findings"
Write-Host "  3. Open in FFDec GUI: ffdec.bat $SWFPath"
Write-Host "  4. Search SharedObject patterns in decompiled scripts"
Write-Host ""
