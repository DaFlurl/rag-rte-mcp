@echo off
echo ========================================
echo  Flash CVE Fetcher for Evony Training
echo ========================================
echo.

cd /d "%~dp0"
cd ..

python CVE_Research\fetch_flash_cves.py

echo.
echo Done! Check CVE_Research folder for output files.
pause
