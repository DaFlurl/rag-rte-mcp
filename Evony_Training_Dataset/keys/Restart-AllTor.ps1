# EvonyToolKit - Restart All Tor Processes
# Kills all Tor instances and lets ETK restart them fresh

$ErrorActionPreference = "Continue"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Restarting All Tor Processes" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Find and stop all Tor processes
$torProcesses = Get-Process -Name "tor" -ErrorAction SilentlyContinue

if ($torProcesses) {
    $count = @($torProcesses).Count
    Write-Host "Found $count Tor process(es). Stopping..." -ForegroundColor Yellow
    
    foreach ($proc in $torProcesses) {
        try {
            Write-Host "  Stopping PID $($proc.Id)..." -ForegroundColor Gray
            Stop-Process -Id $proc.Id -Force
        } catch {
            Write-Host "  Failed to stop PID $($proc.Id): $_" -ForegroundColor Red
        }
    }
    
    Start-Sleep -Seconds 2
    
    # Verify they're stopped
    $remaining = Get-Process -Name "tor" -ErrorAction SilentlyContinue
    if ($remaining) {
        Write-Host "Warning: Some Tor processes still running" -ForegroundColor Yellow
    } else {
        Write-Host "All Tor processes stopped successfully" -ForegroundColor Green
    }
} else {
    Write-Host "No Tor processes found running" -ForegroundColor Gray
}

# Also clear any stale lock files in Data directories
$ETKPath = Split-Path -Parent $PSScriptRoot
$dataFolders = Get-ChildItem -Path $ETKPath -Directory -Filter "Data*" -ErrorAction SilentlyContinue

foreach ($folder in $dataFolders) {
    $lockFile = Join-Path $folder.FullName "lock"
    if (Test-Path $lockFile) {
        try {
            Remove-Item $lockFile -Force
            Write-Host "Removed stale lock file: $lockFile" -ForegroundColor Gray
        } catch {
            # Ignore errors - file may be in use
        }
    }
}

Write-Host ""
Write-Host "Done. ETK will start fresh Tor instances when needed." -ForegroundColor Green
Write-Host ""
