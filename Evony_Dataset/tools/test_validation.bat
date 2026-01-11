@echo off
title Borg Login Validator Test
color 0A

echo ============================================================
echo   BORG TOOLKIT - Login Validation Test
echo ============================================================
echo.

python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python not found!
    pause
    exit /b 1
)

echo Installing dependencies...
pip install pysocks --quiet

echo.
python test_login.py

pause
