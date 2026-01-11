@echo off
title EVONY MEGA TOOLKIT v6.0 - Ultimate Complete Edition
color 0A

echo.
echo ====================================================================
echo        EVONY MEGA TOOLKIT v6.0 - ULTIMATE COMPLETE EDITION
echo ====================================================================
echo.
echo  Features:
echo    - 352+ Protocol Commands
echo    - 166+ Bot Scripts
echo    - 15+ Documented Exploits
echo    - 124 Account Credentials
echo    - 3,278 AS3 Source Files
echo    - Script Server (Port 8088)
echo    - Full File Viewer
echo    - Modern Dark Theme UI
echo.
echo ====================================================================
echo.

:: Check Python
where python >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Python not found in PATH
    echo Please install Python 3.8+ and add to PATH
    pause
    exit /b 1
)

echo [INFO] Starting Evony Mega Toolkit...
echo.

cd /d "%~dp0"
python mega_toolkit_ultimate.py

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Application exited with error code %ERRORLEVEL%
    echo.
    echo Troubleshooting:
    echo   1. Install dependencies: pip install -r requirements.txt
    echo   2. Check Python version: python --version (need 3.8+)
    echo   3. Check for error messages above
    echo.
    pause
)
