@echo off
title Evony Master Suite
color 0A

echo.
echo  ============================================
echo   EVONY MASTER SUITE
echo   Ultimate Integrated Hacking Framework
echo  ============================================
echo.

:: Check for Python
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python not found!
    echo Please install Python 3.10+ from python.org
    pause
    exit /b 1
)

echo [OK] Python found
echo.

:: Navigate to script directory
cd /d "%~dp0"

echo Starting Master Suite server...
echo.
echo Dashboard will open at: http://localhost:9000
echo.

:: Run the server
python master_suite.py

pause
