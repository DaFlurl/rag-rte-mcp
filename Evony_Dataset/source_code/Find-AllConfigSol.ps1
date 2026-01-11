# Find-AllConfigSol.ps1
# Searches ALL drives for config.sol files in Flash SharedObjects folders
# Works with PowerShell 5.1+ using background jobs

$drives = @('C:', 'D:', 'E:', 'F:', 'G:')

# Possible SharedObjects locations
$patterns = @(
    'Users\*\AppData\Roaming\Macromedia\Flash Player\#SharedObjects',
    'Users\*\AppData\Local\Macromedia\Flash Player\#SharedObjects',
    'Macromedia\Flash Player\#SharedObjects',
    'SOL_Backups',
    'EvonyToolKit\Macromedia',
    'EvonyToolKit\SOL_Backups',
    'AI-Evony'
)

Write-Host "=" * 70
Write-Host "SEARCHING ALL DRIVES FOR config.sol FILES"
Write-Host "=" * 70

$allResults = @()

foreach ($drive in $drives) {
    if (-not (Test-Path $drive)) {
        Write-Host "[$drive] Not available" -ForegroundColor DarkGray
        continue
    }
    
    Write-Host "[$drive] Searching..." -ForegroundColor Cyan
    
    # Search each pattern
    foreach ($pattern in $patterns) {
        $searchPath = Join-Path $drive $pattern
        
        # Use wildcard expansion
        $paths = Get-Item -Path $searchPath -ErrorAction SilentlyContinue
        
        foreach ($p in $paths) {
            if (Test-Path -LiteralPath $p.FullName) {
                $files = Get-ChildItem -Path $p.FullName -Filter "config.sol" -Recurse -ErrorAction SilentlyContinue
                foreach ($f in $files) {
                    $allResults += $f.FullName
                }
            }
        }
    }
    
    # Also do a broader search for any config.sol
    $broadFiles = Get-ChildItem -Path $drive -Filter "config.sol" -Recurse -ErrorAction SilentlyContinue -Depth 15
    foreach ($f in $broadFiles) {
        $allResults += $f.FullName
    }
}

# Deduplicate
$uniqueFiles = $allResults | Sort-Object -Unique

Write-Host ""
Write-Host "=" * 70
Write-Host "RESULTS"
Write-Host "=" * 70
Write-Host "Total config.sol files found: $($uniqueFiles.Count)"

# Save to file
$outputFile = "D:\EvonyToolKit\scripts\extraction\all_config_sol_paths.txt"
$uniqueFiles | Out-File -FilePath $outputFile -Encoding UTF8

Write-Host "Saved to: $outputFile"

# Show breakdown by drive
foreach ($drive in $drives) {
    $count = ($uniqueFiles | Where-Object { $_.StartsWith($drive) }).Count
    if ($count -gt 0) {
        Write-Host "  $drive : $count files"
    }
}
