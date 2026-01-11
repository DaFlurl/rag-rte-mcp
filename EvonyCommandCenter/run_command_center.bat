@echo off
title Evony Ultimate Command Center v3.0
color 0A

echo.
echo ===============================================================================
echo                    EVONY ULTIMATE COMMAND CENTER v3.0
echo ===============================================================================
echo.
echo  Integrated Features:
echo  - FlashBrowser + AutoEvony Integration
echo  - 352 Protocol Commands (Complete AMF API)
echo  - 1,693 SOL Account Manager
echo  - 166+ Bot Scripts Library
echo  - AI Script Generator
echo  - Exploit Discovery Engine
echo  - Source Code Browser (3,278 AS3 files)
echo  - Pattern Vulnerability Analyzer
echo  - Complete Crypto Toolkit
echo.
echo  Built from 120,470 files of extracted Evony data
echo ===============================================================================
echo.

REM Check for Python
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python not found!
    echo Please install Python 3.10+ from https://python.org
    pause
    exit /b 1
)

echo Starting Evony Command Center...
echo.

cd /d "%~dp0"
python evony_command_center.py

if errorlevel 1 (
    echo.
    echo ERROR: Application crashed or failed to start.
    pause
)
