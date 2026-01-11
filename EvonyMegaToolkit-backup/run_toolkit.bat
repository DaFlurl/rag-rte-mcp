@echo off
title Evony Mega Toolkit
color 0A

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║            EVONY MEGA TOOLKIT LAUNCHER                       ║
echo ║        246 Commands ^| 166 Scripts ^| Live Exploits           ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

:: Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python not found! Please install Python 3.10+
    pause
    exit /b 1
)

echo [OK] Python found
echo.

:: Menu
echo Select an option:
echo.
echo   1. Launch GUI Toolkit
echo   2. Start Script Server (for AutoEvony)
echo   3. Launch FlashBrowser
echo   4. Open Tools Directory
echo   5. Open Scripts Directory
echo   6. Exit
echo.

set /p choice="Enter choice (1-6): "

if "%choice%"=="1" goto gui
if "%choice%"=="2" goto server
if "%choice%"=="3" goto flashbrowser
if "%choice%"=="4" goto tools
if "%choice%"=="5" goto scripts
if "%choice%"=="6" goto end

echo Invalid choice
pause
goto :eof

:gui
echo.
echo Starting GUI Toolkit...
python "%~dp0mega_toolkit.py"
goto end

:server
echo.
echo Starting Script Server on port 8888...
echo.
echo In AutoEvony, use:
echo   includeurl http://localhost:8888/exploit/overflow_all
echo.
python "%~dp0script_server.py"
goto end

:flashbrowser
echo.
echo Launching FlashBrowser...
if exist "%~dp0..\FlashBrowser\FlashBrowser.exe" (
    start "" "%~dp0..\FlashBrowser\FlashBrowser.exe"
) else (
    echo [ERROR] FlashBrowser not found!
)
goto end

:tools
echo.
echo Opening Tools directory...
if exist "%~dp0..\Tools" (
    start "" "%~dp0..\Tools"
) else (
    echo [ERROR] Tools directory not found!
)
goto end

:scripts
echo.
echo Opening Scripts directory...
if exist "%~dp0..\Scripts" (
    start "" "%~dp0..\Scripts"
) else (
    echo [ERROR] Scripts directory not found!
)
goto end

:end
echo.
pause
