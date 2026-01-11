@echo off
REM ============================================================
REM RunPod Automated Training Launcher
REM H100 80GB - QLoRA SFT - Full Automation
REM ============================================================

echo.
echo ============================================================
echo    RUNPOD AUTOMATED TRAINING
echo    GPU: H100 80GB (or A100/4090 fallback)
echo    Cost: ~$3-5 for full training
echo    Time: ~1-2 hours
echo ============================================================
echo.

REM Check for .env
if not exist ".env" (
    echo ERROR: .env file not found!
    echo.
    echo 1. Copy .env.template to .env
    echo 2. Add your RunPod API key
    echo 3. Run this script again
    echo.
    echo Get API key at: https://runpod.io/console/user/settings
    pause
    exit /b 1
)

REM Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python not found!
    pause
    exit /b 1
)

REM Install requirements
echo Installing local requirements...
pip install runpod python-dotenv requests >nul 2>&1

REM Package training files
echo.
echo Packaging training data...
python package_for_runpod.py
if errorlevel 1 (
    echo ERROR: Packaging failed!
    pause
    exit /b 1
)

REM Run orchestrator
echo.
echo Starting RunPod orchestrator...
python runpod_orchestrator.py

pause
