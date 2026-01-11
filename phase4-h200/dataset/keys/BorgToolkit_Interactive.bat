@echo off
title BORG TOOLKIT
cd /d "%~dp0"

:: Check if prompt_toolkit is installed for interactive mode
python -c "import prompt_toolkit" 2>nul
if errorlevel 1 (
    echo Installing prompt_toolkit for interactive menus...
    pip install prompt_toolkit -q
)

:: Run the Python launcher
python borg_launcher.py %*
