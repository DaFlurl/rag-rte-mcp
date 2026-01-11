@echo off
title EVONY MASTER HUB
cd /d "%~dp0"

echo ============================================================
echo           EVONY MASTER HUB - Unified Framework
echo ============================================================
echo.
echo Choose launch mode:
echo.
echo   1. GUI Mode (Recommended) - Full graphical interface
echo   2. Server Mode - Script server for AutoEvony
echo   3. Full Automation - Watcher + Server + Scheduler
echo   4. Console Mode - Interactive menu
echo   5. Exit
echo.
set /p choice="Enter choice (1-5): "

if "%choice%"=="1" (
    echo Starting GUI...
    python -m evony_hub.gui
)
if "%choice%"=="2" (
    echo Starting Script Server...
    python -m evony_hub.server
)
if "%choice%"=="3" (
    echo Starting Full Automation...
    python -m evony_hub.automation
)
if "%choice%"=="4" (
    echo Starting Console Mode...
    python -m evony_hub.main
)
if "%choice%"=="5" (
    exit
)

pause
