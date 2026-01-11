# Bot Server Start Script with Failsafe
# Checks if already running, starts if not

$ErrorActionPreference = "SilentlyContinue"
$botPath = "C:\Users\Admin\Downloads\Evony_Decrypted\evony_bot"
$pythonExe = "C:\Python313\python.exe"
$botUrl = "http://localhost:9999/api/status"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  BOT SERVER START SCRIPT" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Check if already running
Write-Host "`n[1] Checking if bot server is already running..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri $botUrl -TimeoutSec 3 -ErrorAction Stop
    if ($response.StatusCode -eq 200) {
        Write-Host "    Bot server is already running!" -ForegroundColor Green
        Write-Host "    Status: $($response.Content)" -ForegroundColor Gray
        exit 0
    }
} catch {
    Write-Host "    Bot server not running." -ForegroundColor Gray
}

# Start the server
Write-Host "`n[2] Starting bot server..." -ForegroundColor Yellow
$process = Start-Process -FilePath $pythonExe `
    -ArgumentList "server.py" `
    -WorkingDirectory $botPath `
    -PassThru `
    -WindowStyle Minimized

Write-Host "    Process started (PID: $($process.Id))" -ForegroundColor Gray

# Wait for startup
Write-Host "`n[3] Waiting for server to initialize..." -ForegroundColor Yellow
$maxAttempts = 10
$attempt = 0
$started = $false

while ($attempt -lt $maxAttempts) {
    Start-Sleep -Seconds 1
    $attempt++
    Write-Host "    Attempt $attempt/$maxAttempts..." -ForegroundColor Gray
    
    try {
        $response = Invoke-WebRequest -Uri $botUrl -TimeoutSec 3 -ErrorAction Stop
        if ($response.StatusCode -eq 200) {
            $started = $true
            break
        }
    } catch {
        # Not ready yet
    }
}

if ($started) {
    Write-Host "`n========================================" -ForegroundColor Green
    Write-Host "  BOT SERVER STARTED SUCCESSFULLY!" -ForegroundColor Green
    Write-Host "  PID: $($process.Id)" -ForegroundColor Green
    Write-Host "  URL: http://localhost:9999" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
} else {
    Write-Host "`n========================================" -ForegroundColor Red
    Write-Host "  BOT SERVER FAILED TO START" -ForegroundColor Red
    Write-Host "  Check evony_bot\server.py for errors" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    exit 1
}
