@echo off
title Evony Hub - Unified Framework
color 0A

echo.
echo  ===============================================
echo   EVONY HUB - UNIFIED EXPLOITATION FRAMEWORK
echo  ===============================================
echo.

cd /d "%~dp0"

echo [1] GUI Mode (Recommended)
echo [2] Server Mode (AutoEvony Integration)
echo [3] Full Automation (Background)
echo [4] Interactive Menu
echo [5] Run Scan
echo [6] Generate Report
echo [0] Exit
echo.

choice /c 1234560 /n /m "Select option: "

if errorlevel 7 goto end
if errorlevel 6 goto report
if errorlevel 5 goto scan
if errorlevel 4 goto menu
if errorlevel 3 goto automation
if errorlevel 2 goto server
if errorlevel 1 goto gui

:gui
echo Starting GUI...
python gui.py
goto end

:server
echo Starting Script Server on port 8088...
echo.
echo In AutoEvony use: includeurl http://localhost:8088/epic/overflow_chain
echo.
python server.py
goto end

:automation
echo Starting Full Automation...
python automation.py
goto end

:menu
echo Starting Interactive Menu...
python main.py
goto end

:scan
echo Running Full Scan...
python main.py --scan
pause
goto end

:report
echo Generating Report...
python main.py --report
pause
goto end

:end
