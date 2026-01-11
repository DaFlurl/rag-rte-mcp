@echo off
title EVONY MEGA TOOLKIT v7.0 - Complete Ultimate Edition
color 0A

echo.
echo ===========================================================================
echo          EVONY MEGA TOOLKIT v7.0 - COMPLETE ULTIMATE EDITION
echo ===========================================================================
echo.
echo   FIXES ALL PREVIOUS ISSUES:
echo.
echo   [X] ALL Commands Visible (No "22 more" limits!)
echo   [X] RIGHT-CLICK Context Menus Everywhere
echo   [X] FULL File Viewing When Clicked
echo   [X] EDITING ^& SAVING Functional
echo   [X] IMPORT/EXPORT Working
echo   [X] 8 Pre-made Templates
echo   [X] 15+ Documented Exploits
echo   [X] 352+ Protocol Commands
echo   [X] Script Server on Port 8088
echo.
echo ===========================================================================
echo.

:: Check Python
where python >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Python not found in PATH
    echo Please install Python 3.8+ and add to PATH
    pause
    exit /b 1
)

echo [INFO] Starting Evony Mega Toolkit Complete Edition...
echo.

cd /d "%~dp0"
python mega_toolkit_complete.py

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Application exited with error code %ERRORLEVEL%
    echo.
    pause
)
