@echo off
REM ============================================================
REM Test Trained Evony Model
REM ============================================================

echo.
echo ============================================================
echo    TESTING EVONY MODEL
echo ============================================================
echo.

call venv\Scripts\activate.bat

python test.py

pause
