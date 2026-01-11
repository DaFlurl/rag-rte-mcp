@echo off
title Svony Automation
color 0A

echo.
echo  ===============================================
echo   SVONY AUTOMATION - Multi-Account Framework
echo  ===============================================
echo.

cd /d "%~dp0"

echo [1] Exploit Panel (Main GUI)
echo [2] Swarm Controller (Multi-Account)
echo [3] Real-Time Tester
echo [4] Troop Glitch Manager
echo [5] City Manager
echo [6] Debug Mode
echo [0] Exit
echo.

choice /c 1234560 /n /m "Select option: "

if errorlevel 7 goto end
if errorlevel 6 goto debug
if errorlevel 5 goto city
if errorlevel 4 goto troop
if errorlevel 3 goto tester
if errorlevel 2 goto swarm
if errorlevel 1 goto panel

:panel
python exploit_panel.py
goto end

:swarm
python swarm_controller.py
goto end

:tester
python realtime_tester.py
goto end

:troop
python troop_glitch_manager.py
goto end

:city
python city_manager.py
goto end

:debug
python realtime_debug.py --verbose
goto end

:end
