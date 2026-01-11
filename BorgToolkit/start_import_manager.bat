@echo off
title Borg Import Manager
color 0A

echo ============================================================
echo   BORG TOOLKIT - Account Import Manager
echo ============================================================
echo.

:: Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python not found! Please install Python 3.8+
    pause
    exit /b 1
)

:: Install dependencies
echo Installing dependencies...
pip install fastapi uvicorn python-multipart openpyxl striprtf PyPDF2 --quiet

echo.
echo Starting Import Manager on http://localhost:8091/
echo.
echo Known account directories:
echo   - C:\Users\Admin\Downloads\Evony_Decrypted\Accounts
echo   - C:\Users\Admin\Downloads\Evony_Decrypted\Scripts\khan_Accounts_556
echo   - C:\Users\Admin\Downloads\Evony_Decrypted\SOL_Accounts
echo   - C:\Users\Admin\Downloads\Evony_Decrypted\checkme
echo.
echo Features:
echo   - Import from CSV, TXT, JSON, XLSX, RTF, PDF
echo   - Auto-scan multiple directories
echo   - Deduplicate accounts
echo   - Login validation with 3-5 retries
echo   - Edit failed passwords and resubmit
echo   - Export active/failed accounts
echo.
echo ============================================================
echo.

python borg_import_manager.py

pause
