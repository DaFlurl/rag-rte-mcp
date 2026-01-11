@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul 2>&1
title BORG TOOLKIT
mode con: cols=100 lines=45

:: Handle direct run command (from hyperlinks)
if "%1"=="run" (
    set "choice=%2"
    goto process_choice
)

:: Enable ANSI colors and VT sequences for OSC 8
for /F "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "10.0" (
    reg add HKCU\Console /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1
)

:: Create ESC character for ANSI sequences
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"

:: Set Borg Green color
color 0A

:: Store script path for hyperlinks
set "SCRIPT_PATH=%~dp0"

:main_menu
cls

echo.
echo  %ESC%[92m██████╗  ██████╗ ██████╗  ██████╗ %ESC%[0m
echo  %ESC%[92m██╔══██╗██╔═══██╗██╔══██╗██╔════╝ %ESC%[0m
echo  %ESC%[92m██████╔╝██║   ██║██████╔╝██║  ███╗%ESC%[0m
echo  %ESC%[92m██╔══██╗██║   ██║██╔══██╗██║   ██║%ESC%[0m
echo  %ESC%[92m██████╔╝╚██████╔╝██║  ██║╚██████╔╝%ESC%[0m
echo  %ESC%[92m╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ %ESC%[0m
echo.
echo  %ESC%[92m████████╗ ██████╗  ██████╗ ██╗     ██╗  ██╗██╗████████╗%ESC%[0m
echo  %ESC%[92m╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██║ ██╔╝██║╚══██╔══╝%ESC%[0m
echo  %ESC%[92m   ██║   ██║   ██║██║   ██║██║     █████╔╝ ██║   ██║   %ESC%[0m
echo  %ESC%[92m   ██║   ██║   ██║██║   ██║██║     ██╔═██╗ ██║   ██║   %ESC%[0m
echo  %ESC%[92m   ██║   ╚██████╔╝╚██████╔╝███████╗██║  ██╗██║   ██║   %ESC%[0m
echo  %ESC%[92m   ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝   ╚═╝   %ESC%[0m
echo.
echo  %ESC%[90m╔════════════════════════════════════════════════════════════════╗%ESC%[0m
echo  %ESC%[90m║%ESC%[0m  %ESC%[92m"Resistance is Futile. Your accounts will be assimilated."%ESC%[0m  %ESC%[90m║%ESC%[0m
echo  %ESC%[90m╚════════════════════════════════════════════════════════════════╝%ESC%[0m
echo.
echo  %ESC%[32m┌─────────────────────────────────────────────────────────────────┐%ESC%[0m
echo  %ESC%[32m│%ESC%[0m  %ESC%]8;;file:///%SCRIPT_PATH%menu/action1.bat%ESC%\%ESC%[97;4m[1] Account Data Viewer%ESC%[0m%ESC%]8;;%ESC%\    %ESC%[90m- View account dumps in Web UI%ESC%[0m    %ESC%[32m│%ESC%[0m
echo  %ESC%[32m│%ESC%[0m  %ESC%]8;;file:///%SCRIPT_PATH%menu/action2.bat%ESC%\%ESC%[97;4m[2] Glitch Optimizer%ESC%[0m%ESC%]8;;%ESC%\      %ESC%[90m- Analyze troop glitches%ESC%[0m         %ESC%[32m│%ESC%[0m
echo  %ESC%[32m│%ESC%[0m  %ESC%]8;;file:///%SCRIPT_PATH%menu/action3.bat%ESC%\%ESC%[97;4m[3] Export to Excel%ESC%[0m%ESC%]8;;%ESC%\       %ESC%[90m- Generate Excel reports%ESC%[0m         %ESC%[32m│%ESC%[0m
echo  %ESC%[32m│%ESC%[0m  %ESC%]8;;file:///%SCRIPT_PATH%menu/action4.bat%ESC%\%ESC%[97;4m[4] Password Tester%ESC%[0m%ESC%]8;;%ESC%\       %ESC%[90m- Test account passwords%ESC%[0m         %ESC%[32m│%ESC%[0m
echo  %ESC%[32m│%ESC%[0m  %ESC%]8;;file:///%SCRIPT_PATH%menu/action5.bat%ESC%\%ESC%[97;4m[5] ID Extractor%ESC%[0m%ESC%]8;;%ESC%\          %ESC%[90m- Extract all game IDs%ESC%[0m           %ESC%[32m│%ESC%[0m
echo  %ESC%[32m│%ESC%[0m  %ESC%]8;;file:///%SCRIPT_PATH%menu/action6.bat%ESC%\%ESC%[97;4m[6] Login Validator%ESC%[0m%ESC%]8;;%ESC%\       %ESC%[90m- Validate account logins%ESC%[0m        %ESC%[32m│%ESC%[0m
echo  %ESC%[32m│%ESC%[0m  %ESC%]8;;file:///%SCRIPT_PATH%menu/action7.bat%ESC%\%ESC%[97;4m[7] Import Manager%ESC%[0m%ESC%]8;;%ESC%\        %ESC%[90m- Manage account imports%ESC%[0m         %ESC%[32m│%ESC%[0m
echo  %ESC%[32m│%ESC%[0m  %ESC%]8;;file:///%SCRIPT_PATH%menu/action0.bat%ESC%\%ESC%[97;4m[0] Exit%ESC%[0m%ESC%]8;;%ESC%\                  %ESC%[90m- Disconnect from Collective%ESC%[0m     %ESC%[32m│%ESC%[0m
echo  %ESC%[32m└─────────────────────────────────────────────────────────────────┘%ESC%[0m
echo.
echo  %ESC%[90m  (Click menu items or type number)%ESC%[0m
echo.

set /p choice="  %ESC%[92m>%ESC%[0m Select function [0-7]: "

:process_choice

if "%choice%"=="1" goto viewer
if "%choice%"=="2" goto glitch
if "%choice%"=="3" goto excel
if "%choice%"=="4" goto password
if "%choice%"=="5" goto extractor
if "%choice%"=="6" goto validator
if "%choice%"=="7" goto import
if "%choice%"=="0" goto exit

echo  %ESC%[91mInvalid selection. Try again.%ESC%[0m
timeout /t 2 >nul
goto main_menu

:viewer
cls
echo.
echo  %ESC%[92m▓▓▓ ACCOUNT DATA VIEWER ▓▓▓%ESC%[0m
echo.
python "%~dp0borg_data_viewer_web.py"
pause
goto main_menu

:glitch
cls
echo.
echo  %ESC%[92m▓▓▓ GLITCH OPTIMIZER ▓▓▓%ESC%[0m
echo.
echo  Opening GlitchOptimizer script...
start notepad "%~dp0evony_scripts\GlitchOptimizer_AllCities_v3.txt"
pause
goto main_menu

:excel
cls
echo.
echo  %ESC%[92m▓▓▓ EXPORT TO EXCEL ▓▓▓%ESC%[0m
echo.
python "%~dp0borg_data_viewer_v2.py"
pause
goto main_menu

:password
cls
echo.
echo  %ESC%[92m▓▓▓ PASSWORD TESTER ▓▓▓%ESC%[0m
echo.
python "%~dp0run_password_test_direct.py"
pause
goto main_menu

:extractor
cls
echo.
echo  %ESC%[92m▓▓▓ ID EXTRACTOR ▓▓▓%ESC%[0m
echo.
python "%~dp0extract_all_game_data.py"
echo.
echo  %ESC%[92mOutput saved to: docs\EVONY_COMPLETE_DATA.md%ESC%[0m
pause
goto main_menu

:validator
cls
echo.
echo  %ESC%[92m▓▓▓ LOGIN VALIDATOR ▓▓▓%ESC%[0m
echo.
python "%~dp0test_login.py"
pause
goto main_menu

:import
cls
echo.
echo  %ESC%[92m▓▓▓ IMPORT MANAGER ▓▓▓%ESC%[0m
echo.
call "%~dp0start_import_manager.bat"
pause
goto main_menu

:exit
cls
echo.
echo  %ESC%[92m╔══════════════════════════════════════════════════════════╗%ESC%[0m
echo  %ESC%[92m║                                                          ║%ESC%[0m
echo  %ESC%[92m║      DISCONNECTING FROM THE BORG COLLECTIVE...           ║%ESC%[0m
echo  %ESC%[92m║                                                          ║%ESC%[0m
echo  %ESC%[92m║              "We will return."                           ║%ESC%[0m
echo  %ESC%[92m║                                                          ║%ESC%[0m
echo  %ESC%[92m╚══════════════════════════════════════════════════════════╝%ESC%[0m
echo.
timeout /t 2 >nul
endlocal
exit
