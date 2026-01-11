@echo off
title BORG TOOLKIT EPIC 2026

echo.
echo  ===============================================================
echo  ██████╗  ██████╗ ██████╗  ██████╗     ███████╗██████╗ ██╗ ██████╗
echo  ██╔══██╗██╔═══██╗██╔══██╗██╔════╝     ██╔════╝██╔══██╗██║██╔════╝
echo  ██████╔╝██║   ██║██████╔╝██║  ███╗    █████╗  ██████╔╝██║██║     
echo  ██╔══██╗██║   ██║██╔══██╗██║   ██║    ██╔══╝  ██╔═══╝ ██║██║     
echo  ██████╔╝╚██████╔╝██║  ██║╚██████╔╝    ███████╗██║     ██║╚██████╗
echo  ╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝     ╚══════╝╚═╝     ╚═╝ ╚═════╝
echo                        2 0 2 6   E D I T I O N
echo  ===============================================================
echo.

echo [1] Checking Python installation...
python --version
if errorlevel 1 (
    echo ERROR: Python not found! Please install Python 3.8+
    pause
    exit /b 1
)

echo.
echo [2] Checking dependencies...
pip show fastapi >nul 2>&1
if errorlevel 1 (
    echo Installing dependencies...
    pip install -r requirements.txt
)

echo.
echo [3] Starting BORG MASTER SERVER...
echo.
echo  Server URLs:
echo    Dashboard:  http://localhost:8089/
echo    API:        http://localhost:8089/api/
echo    Bridge:     http://localhost:8089/bridge/
echo.
echo  AutoEvony Commands:
echo    includeurl http://localhost:8089/bridge/connect
echo    includeurl http://localhost:8089/bridge/hh_hunt_pro
echo.
echo  Press Ctrl+C to stop
echo  ===============================================================
echo.

python borg_master.py

pause
