# Bot Server Stop Script
# Gracefully stops the bot server

$ErrorActionPreference = "SilentlyContinue"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  BOT SERVER STOP SCRIPT" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Find Python processes running server.py
Write-Host "`n[1] Finding bot server processes..." -ForegroundColor Yellow

$processes = Get-CimInstance Win32_Process -Filter "name='python.exe'" | 
    Where-Object { $_.CommandLine -like "*server.py*" -and $_.CommandLine -like "*evony_bot*" }

if ($processes.Count -eq 0) {
    Write-Host "    No bot server processes found." -ForegroundColor Gray
    exit 0
}

Write-Host "    Found $($processes.Count) process(es)" -ForegroundColor Gray

# Stop each process
Write-Host "`n[2] Stopping processes..." -ForegroundColor Yellow
foreach ($proc in $processes) {
    Write-Host "    Stopping PID $($proc.ProcessId)..." -ForegroundColor Gray
    Stop-Process -Id $proc.ProcessId -Force
}

# Verify stopped
Start-Sleep -Seconds 2
$remaining = Get-CimInstance Win32_Process -Filter "name='python.exe'" | 
    Where-Object { $_.CommandLine -like "*server.py*" -and $_.CommandLine -like "*evony_bot*" }

if ($remaining.Count -eq 0) {
    Write-Host "`n========================================" -ForegroundColor Green
    Write-Host "  BOT SERVER STOPPED SUCCESSFULLY" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
} else {
    Write-Host "`n========================================" -ForegroundColor Red
    Write-Host "  SOME PROCESSES MAY STILL BE RUNNING" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
}

# Also stop guardian if running
$guardianStop = "C:\Users\Admin\Downloads\Evony_Decrypted\scripts\bot_guardian_stop.flag"
if (-not (Test-Path $guardianStop)) {
    New-Item -ItemType File -Path $guardianStop -Force | Out-Null
    Write-Host "`nGuardian stop signal sent." -ForegroundColor Gray
}
