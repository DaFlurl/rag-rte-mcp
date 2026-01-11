@echo off
:: EVONY HACKER TOOLKIT - Setup Script
:: ====================================
echo.
echo  ========================================
echo   EVONY HACKER TOOLKIT - AI Exploit Studio
echo  ========================================
echo.

:: Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python not found! Please install Python 3.10+
    pause
    exit /b 1
)

echo [OK] Python found

:: Create directories if needed
if not exist "Scripts" mkdir Scripts
if not exist "Source" mkdir Source
if not exist "Output" mkdir Output

:: Check if toolkit exists
if not exist "evony_hacker_toolkit.py" (
    echo [ERROR] evony_hacker_toolkit.py not found!
    echo Please ensure the toolkit file is in this directory.
    pause
    exit /b 1
)

echo [OK] Toolkit found

:: Run the toolkit
echo.
echo Starting Evony Hacker Toolkit...
echo.
python evony_hacker_toolkit.py

pause
