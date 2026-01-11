# EvonyToolKit - Tor Setup Verification Script
# Verifies Tor installation and configuration

$ErrorActionPreference = "Continue"
$ETKPath = Split-Path -Parent $PSScriptRoot
$TorPath = Join-Path $ETKPath "Tor"
$ProxyPath = Join-Path $ETKPath "Proxy"

$issues = @()
$warnings = @()

function Write-Status {
    param([string]$Check, [bool]$Passed, [string]$Details = "")
    $status = if ($Passed) { "[PASS]" } else { "[FAIL]" }
    $color = if ($Passed) { "Green" } else { "Red" }
    Write-Host "$status $Check" -ForegroundColor $color
    if ($Details) {
        Write-Host "       $Details" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  EvonyToolKit - Setup Verification" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check 1: Tor executable exists
$torExe = Join-Path $TorPath "tor.exe"
$torExists = Test-Path $torExe
Write-Status "Tor executable exists" $torExists $torExe
if (-not $torExists) { $issues += "tor.exe not found" }

# Check 2: Tor version
if ($torExists) {
    try {
        $output = & $torExe --version 2>&1
        if ($output -match "Tor version ([\d\.]+)") {
            $version = $Matches[1]
            $versionParts = $version.Split('.')
            $isModern = [int]$versionParts[1] -ge 4
            Write-Status "Tor version is modern (0.4.x+)" $isModern "Version: $version"
            if (-not $isModern) { 
                $issues += "Tor version $version is outdated - update recommended" 
            }
        }
    } catch {
        Write-Status "Tor version check" $false "Could not determine version"
        $warnings += "Could not verify Tor version"
    }
}

# Check 3: GeoIP files exist
$geoip = Join-Path $TorPath "geoip"
$geoip6 = Join-Path $TorPath "geoip6"
$geoipExists = (Test-Path $geoip) -and (Test-Path $geoip6)
Write-Status "GeoIP databases exist" $geoipExists
if (-not $geoipExists) { $warnings += "GeoIP databases missing - relay selection may be suboptimal" }

# Check 4: Required DLLs
$requiredDlls = @("libevent*.dll", "zlib1.dll")
$missingDlls = @()
foreach ($pattern in $requiredDlls) {
    $found = Get-ChildItem -Path $TorPath -Filter $pattern -ErrorAction SilentlyContinue
    if (-not $found) { $missingDlls += $pattern }
}
$dllsOk = $missingDlls.Count -eq 0
Write-Status "Required DLLs present" $dllsOk
if (-not $dllsOk) { $issues += "Missing DLLs: $($missingDlls -join ', ')" }

# Check 5: Pluggable Transports
$ptPath = Join-Path $TorPath "PluggableTransports"
$obfs4 = Join-Path $ptPath "obfs4proxy.exe"
$ptExists = Test-Path $obfs4
Write-Status "obfs4proxy exists" $ptExists
if (-not $ptExists) { $warnings += "obfs4proxy.exe missing - bridges may not work" }

# Check 6: Proxifier profiles
$defaultProfile = Join-Path $ProxyPath "Profiles\Default.ppx"
$profileExists = Test-Path $defaultProfile
Write-Status "Proxifier profile exists" $profileExists
if (-not $profileExists) { $issues += "Default Proxifier profile not found" }

# Check 7: Proxifier profile node rules (verify fix)
if ($profileExists) {
    $content = Get-Content $defaultProfile -Raw
    $node31Match = $content -match '<Name>Node31</Name>[\s\S]*?<Action type="Proxy">131</Action>'
    $node50Match = $content -match '<Name>Node50</Name>[\s\S]*?<Action type="Proxy">150</Action>'
    $rulesOk = $node31Match -and $node50Match
    Write-Status "Proxifier rules for nodes 31-50 correct" $rulesOk
    if (-not $rulesOk) { $issues += "Proxifier rules for nodes 31-50 may still have bugs" }
}

# Check 8: ETK executable
$etkExe = Join-Path $ETKPath "ETK.exe"
$etkExists = Test-Path $etkExe
Write-Status "ETK.exe exists" $etkExists
if (-not $etkExists) { $issues += "ETK.exe not found" }

# Check 9: Config file
$configIni = Join-Path $ETKPath "config.ini"
$configExists = Test-Path $configIni
Write-Status "config.ini exists" $configExists
if (-not $configExists) { $warnings += "config.ini not found - no accounts configured" }

# Summary
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

if ($issues.Count -eq 0 -and $warnings.Count -eq 0) {
    Write-Host "All checks passed! Your setup looks good." -ForegroundColor Green
} else {
    if ($issues.Count -gt 0) {
        Write-Host "ISSUES FOUND ($($issues.Count)):" -ForegroundColor Red
        foreach ($issue in $issues) {
            Write-Host "  - $issue" -ForegroundColor Red
        }
        Write-Host ""
    }
    
    if ($warnings.Count -gt 0) {
        Write-Host "WARNINGS ($($warnings.Count)):" -ForegroundColor Yellow
        foreach ($warning in $warnings) {
            Write-Host "  - $warning" -ForegroundColor Yellow
        }
    }
}

Write-Host ""
Write-Host "Run 'Update-Tor.ps1' to update Tor binaries" -ForegroundColor Cyan
Write-Host ""
