@echo off
title BORG ACCOUNT EXTRACTOR

echo.
echo  ================================================================
echo   ____   ___  ____   ____   _______  _______ ____      _    ____ 
echo  ^|  _ \ / _ \^|  _ \ / ___^| ^| ____\ \/ /_   _^|  _ \    / \  / ___^|
echo  ^| ^|_) ^| ^| ^| ^| ^|_) ^| ^|  _  ^|  _^|  \  /  ^| ^| ^| ^|_) ^|  / _ \^| ^|    
echo  ^|  _ ^<^| ^|_^| ^|  _ ^<^| ^|_^| ^| ^| ^|___ /  \  ^| ^| ^|  _ ^<  / ___ \ ^|___ 
echo  ^|_^| \_\\___/^|_^| \_\\____^| ^|_____/_/\_\ ^|_^| ^|_^| \_\/_/   \_\____^|
echo                    ACCOUNT DATA EXTRACTOR
echo  ================================================================
echo.

echo [1] Checking Python...
python --version
if errorlevel 1 (
    echo ERROR: Python not found!
    pause
    exit /b 1
)

echo.
echo [2] Checking dependencies...
pip show fastapi >nul 2>&1
if errorlevel 1 (
    echo Installing dependencies...
    pip install fastapi uvicorn python-multipart pyamf pysocks
)

echo.
echo [3] Starting ACCOUNT EXTRACTOR UI...
echo.
echo  ================================================================
echo   Dashboard: http://localhost:8090/
echo.
echo   Features:
echo     - Add accounts (single or bulk CSV)
echo     - Direct connection to Evony servers
echo     - Extract ALL account data (1:1 dump)
echo     - View Cities, Troops, Heroes, Resources
echo     - Export to CSV/JSON
echo     - Tor proxy rotation support
echo  ================================================================
echo.

python borg_extractor_ui.py

pause
