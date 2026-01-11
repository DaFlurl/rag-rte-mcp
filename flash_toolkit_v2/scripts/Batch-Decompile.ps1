<#
.SYNOPSIS
    Batch decompile all SWF files in a directory
.EXAMPLE
    .\Batch-Decompile.ps1 -InputDir D:\EvonyToolKit\swf -OutputDir D:\EvonyToolKit\analysis
#>

param(
    [string]$InputDir = "D:\EvonyToolKit\swf",
    [string]$OutputDir = "D:\EvonyToolKit\analysis",
    [switch]$Scripts,
    [switch]$Images,
    [switch]$All
)

$ErrorActionPreference = "Continue"

Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  Batch SWF Decompiler" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

# Find FFDec
$ffdecPaths = @(
    "D:\EvonyToolKit\flash\tools\ffdec\ffdec.bat",
    "D:\EvonyToolKit\flash\tools\ffdec\ffdec.jar",
    "C:\Program Files\FFDec\ffdec.bat",
    "$env:PROGRAMFILES\FFDec\ffdec.bat"
)

$ffdec = $null
foreach ($path in $ffdecPaths) {
    if (Test-Path $path) {
        $ffdec = $path
        break
    }
}

# Also search in current toolkit
if (-not $ffdec) {
    $toolsBase = Split-Path -Parent $PSScriptRoot
    $found = Get-ChildItem "$toolsBase\tools\ffdec" -Filter "ffdec*" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($found) { $ffdec = $found.FullName }
}

if (-not $ffdec) {
    Write-Host "FFDec not found!" -ForegroundColor Red
    Write-Host "Please install FFDec first using: .\Install-AllTools.ps1"
    Write-Host "Or download from: https://github.com/jindrapetrik/jpexs-decompiler/releases"
    exit 1
}

Write-Host "Using FFDec: $ffdec" -ForegroundColor Green
Write-Host ""

# Find SWF files
$swfFiles = Get-ChildItem -Path $InputDir -Filter "*.swf" -ErrorAction SilentlyContinue

if ($swfFiles.Count -eq 0) {
    Write-Host "No SWF files found in $InputDir" -ForegroundColor Red
    exit 1
}

Write-Host "Found $($swfFiles.Count) SWF files:" -ForegroundColor Yellow
$swfFiles | ForEach-Object { Write-Host "  - $($_.Name)" }
Write-Host ""

# Determine what to export
if (-not ($Scripts -or $Images -or $All)) {
    $All = $true
}

$exportTypes = @()
if ($All) { $exportTypes = @("all") }
else {
    if ($Scripts) { $exportTypes += "script" }
    if ($Images) { $exportTypes += "image" }
}

# Process each SWF
foreach ($swf in $swfFiles) {
    $swfName = [System.IO.Path]::GetFileNameWithoutExtension($swf.Name)
    Write-Host "Processing: $($swf.Name)" -ForegroundColor Cyan
    
    foreach ($exportType in $exportTypes) {
        $outPath = Join-Path $OutputDir "$swfName\$exportType"
        New-Item -ItemType Directory -Path $outPath -Force | Out-Null
        
        Write-Host "  Exporting $exportType..." -ForegroundColor Gray
        
        if ($ffdec -like "*.jar") {
            java -jar $ffdec -export $exportType $outPath $swf.FullName 2>&1 | Out-Null
        } else {
            & $ffdec -export $exportType $outPath $swf.FullName 2>&1 | Out-Null
        }
        
        $count = (Get-ChildItem $outPath -Recurse -File -ErrorAction SilentlyContinue | Measure-Object).Count
        Write-Host "    → Exported $count files" -ForegroundColor Green
    }
    Write-Host ""
}

Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  Complete!" -ForegroundColor Green
Write-Host "  Output: $OutputDir" -ForegroundColor White
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
