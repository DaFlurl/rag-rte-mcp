# EvonyToolKit - Tor Update Script
# This script downloads and updates Tor binaries to the latest version
# Run as Administrator for best results

param(
    [switch]$Force,
    [switch]$BackupOnly
)

$ErrorActionPreference = "Stop"
$ETKPath = Split-Path -Parent $PSScriptRoot
$TorPath = Join-Path $ETKPath "Tor"
$BackupPath = Join-Path $ETKPath "Tor_backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
$TempPath = Join-Path $env:TEMP "ETK_TorUpdate"

# Tor Expert Bundle download URL (update version as needed)
$TorVersion = "0.4.8.12"
$TorDownloadUrl = "https://archive.torproject.org/tor-package-archive/torbrowser/13.5.7/tor-expert-bundle-windows-x86_64-13.5.7.tar.gz"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $color = switch ($Level) {
        "INFO"    { "White" }
        "SUCCESS" { "Green" }
        "WARNING" { "Yellow" }
        "ERROR"   { "Red" }
        default   { "White" }
    }
    Write-Host "[$timestamp] [$Level] $Message" -ForegroundColor $color
}

function Stop-TorProcesses {
    Write-Log "Stopping any running Tor processes..."
    $torProcesses = Get-Process -Name "tor" -ErrorAction SilentlyContinue
    if ($torProcesses) {
        $torProcesses | Stop-Process -Force
        Start-Sleep -Seconds 2
        Write-Log "Tor processes stopped" -Level "SUCCESS"
    } else {
        Write-Log "No Tor processes running"
    }
}

function Backup-TorFolder {
    Write-Log "Creating backup of current Tor folder..."
    if (Test-Path $TorPath) {
        Copy-Item -Path $TorPath -Destination $BackupPath -Recurse -Force
        Write-Log "Backup created: $BackupPath" -Level "SUCCESS"
        return $true
    } else {
        Write-Log "Tor folder not found at: $TorPath" -Level "ERROR"
        return $false
    }
}

function Get-CurrentTorVersion {
    $torExe = Join-Path $TorPath "tor.exe"
    if (Test-Path $torExe) {
        try {
            $output = & $torExe --version 2>&1
            if ($output -match "Tor version ([\d\.]+)") {
                return $Matches[1]
            }
        } catch {
            Write-Log "Could not determine current Tor version" -Level "WARNING"
        }
    }
    return "Unknown"
}

function Download-TorBundle {
    Write-Log "Downloading Tor Expert Bundle..."
    
    if (-not (Test-Path $TempPath)) {
        New-Item -ItemType Directory -Path $TempPath -Force | Out-Null
    }
    
    $downloadFile = Join-Path $TempPath "tor-expert-bundle.tar.gz"
    
    try {
        # Use System.Net.WebClient for download
        $webClient = New-Object System.Net.WebClient
        $webClient.DownloadFile($TorDownloadUrl, $downloadFile)
        Write-Log "Download completed" -Level "SUCCESS"
        return $downloadFile
    } catch {
        Write-Log "Failed to download: $_" -Level "ERROR"
        
        # Alternative: Try with Invoke-WebRequest
        try {
            Write-Log "Trying alternative download method..."
            Invoke-WebRequest -Uri $TorDownloadUrl -OutFile $downloadFile -UseBasicParsing
            Write-Log "Download completed (alternative method)" -Level "SUCCESS"
            return $downloadFile
        } catch {
            Write-Log "All download methods failed: $_" -Level "ERROR"
            return $null
        }
    }
}

function Extract-TorBundle {
    param([string]$ArchiveFile)
    
    Write-Log "Extracting Tor bundle..."
    $extractPath = Join-Path $TempPath "extracted"
    
    if (Test-Path $extractPath) {
        Remove-Item -Path $extractPath -Recurse -Force
    }
    New-Item -ItemType Directory -Path $extractPath -Force | Out-Null
    
    # Try using tar (available in Windows 10+)
    try {
        tar -xzf $ArchiveFile -C $extractPath 2>&1 | Out-Null
        Write-Log "Extraction completed" -Level "SUCCESS"
        return $extractPath
    } catch {
        Write-Log "tar extraction failed, trying 7-Zip..." -Level "WARNING"
        
        # Try 7-Zip if available
        $7zipPath = "C:\Program Files\7-Zip\7z.exe"
        if (Test-Path $7zipPath) {
            & $7zipPath x $ArchiveFile -o"$extractPath" -y | Out-Null
            $tarFile = Get-ChildItem -Path $extractPath -Filter "*.tar" | Select-Object -First 1
            if ($tarFile) {
                & $7zipPath x $tarFile.FullName -o"$extractPath" -y | Out-Null
            }
            Write-Log "Extraction completed (7-Zip)" -Level "SUCCESS"
            return $extractPath
        }
        
        Write-Log "No extraction tool available. Please install 7-Zip or use Windows 10+" -Level "ERROR"
        return $null
    }
}

function Update-TorFiles {
    param([string]$ExtractPath)
    
    Write-Log "Updating Tor files..."
    
    # Find the tor directory in extracted files
    $torDir = Get-ChildItem -Path $ExtractPath -Directory -Recurse | 
              Where-Object { $_.Name -eq "tor" } | 
              Select-Object -First 1
    
    if (-not $torDir) {
        Write-Log "Could not find tor directory in extracted files" -Level "ERROR"
        return $false
    }
    
    # Files to update
    $filesToUpdate = @(
        "tor.exe",
        "geoip",
        "geoip6",
        "libevent*.dll",
        "libssl*.dll",
        "libcrypto*.dll",
        "zlib1.dll",
        "libwinpthread*.dll",
        "libgcc*.dll"
    )
    
    foreach ($pattern in $filesToUpdate) {
        $sourceFiles = Get-ChildItem -Path $torDir.FullName -Filter $pattern -ErrorAction SilentlyContinue
        foreach ($file in $sourceFiles) {
            $destFile = Join-Path $TorPath $file.Name
            try {
                Copy-Item -Path $file.FullName -Destination $destFile -Force
                Write-Log "Updated: $($file.Name)" -Level "SUCCESS"
            } catch {
                Write-Log "Failed to update $($file.Name): $_" -Level "WARNING"
            }
        }
    }
    
    # Update pluggable transports if available
    $ptDir = Get-ChildItem -Path $ExtractPath -Directory -Recurse | 
             Where-Object { $_.Name -eq "pluggable_transports" -or $_.Name -eq "PluggableTransports" } | 
             Select-Object -First 1
    
    if ($ptDir) {
        $destPTDir = Join-Path $TorPath "PluggableTransports"
        $ptFiles = @("obfs4proxy.exe", "snowflake-client.exe", "conjure-client.exe", "lyrebird.exe")
        
        foreach ($ptFile in $ptFiles) {
            $sourceFile = Get-ChildItem -Path $ptDir.FullName -Filter $ptFile -ErrorAction SilentlyContinue
            if ($sourceFile) {
                $destFile = Join-Path $destPTDir $sourceFile.Name
                try {
                    Copy-Item -Path $sourceFile.FullName -Destination $destFile -Force
                    Write-Log "Updated PT: $($sourceFile.Name)" -Level "SUCCESS"
                } catch {
                    Write-Log "Failed to update PT $($sourceFile.Name): $_" -Level "WARNING"
                }
            }
        }
    }
    
    return $true
}

function Cleanup-TempFiles {
    Write-Log "Cleaning up temporary files..."
    if (Test-Path $TempPath) {
        Remove-Item -Path $TempPath -Recurse -Force -ErrorAction SilentlyContinue
    }
    Write-Log "Cleanup completed" -Level "SUCCESS"
}

# Main execution
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  EvonyToolKit - Tor Update Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check current version
$currentVersion = Get-CurrentTorVersion
Write-Log "Current Tor version: $currentVersion"
Write-Log "Target Tor version: $TorVersion"

# Stop running Tor processes
Stop-TorProcesses

# Create backup
$backupSuccess = Backup-TorFolder
if (-not $backupSuccess) {
    Write-Log "Backup failed. Aborting update." -Level "ERROR"
    exit 1
}

if ($BackupOnly) {
    Write-Log "Backup-only mode. Exiting." -Level "SUCCESS"
    exit 0
}

# Download new Tor bundle
$archiveFile = Download-TorBundle
if (-not $archiveFile) {
    Write-Log "Download failed. Your original Tor folder is preserved." -Level "ERROR"
    Write-Log "You can manually download from: https://www.torproject.org/download/tor/" -Level "INFO"
    exit 1
}

# Extract bundle
$extractPath = Extract-TorBundle -ArchiveFile $archiveFile
if (-not $extractPath) {
    Write-Log "Extraction failed. Your original Tor folder is preserved." -Level "ERROR"
    exit 1
}

# Update files
$updateSuccess = Update-TorFiles -ExtractPath $extractPath
if ($updateSuccess) {
    Write-Log "Tor update completed successfully!" -Level "SUCCESS"
    
    # Verify new version
    $newVersion = Get-CurrentTorVersion
    Write-Log "New Tor version: $newVersion" -Level "SUCCESS"
} else {
    Write-Log "Update had issues. Check the log above." -Level "WARNING"
    Write-Log "You can restore from backup: $BackupPath" -Level "INFO"
}

# Cleanup
Cleanup-TempFiles

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Update Process Complete" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Backup location: $BackupPath" -ForegroundColor Yellow
Write-Host ""
Write-Host "If you experience issues, restore from backup:" -ForegroundColor Yellow
Write-Host "  Remove-Item '$TorPath' -Recurse -Force" -ForegroundColor Gray
Write-Host "  Rename-Item '$BackupPath' 'Tor'" -ForegroundColor Gray
Write-Host ""
