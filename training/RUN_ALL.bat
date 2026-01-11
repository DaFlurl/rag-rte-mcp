@echo off
REM ============================================================
REM EVONY MODEL TRAINING - COMPLETE AUTOMATED PIPELINE
REM One-click to train your own Evony knowledge model
REM ============================================================

echo.
echo ============================================================
echo    EVONY MODEL TRAINING - FULL PIPELINE
echo    Model: Qwen2.5-VL-7B-Instruct
echo    GPU: RTX 3090 Ti (24GB VRAM)
echo ============================================================
echo.
echo This script will:
echo   1. Setup Python environment and dependencies
echo   2. Download the base model (~15GB)
echo   3. Prepare training data (10,000+ examples)
echo   4. Fine-tune the model (2-4 hours)
echo   5. Test the trained model
echo.
echo Press any key to start, or Ctrl+C to cancel...
pause >nul

echo.
echo ============================================================
echo [STEP 1/5] SETTING UP ENVIRONMENT
echo ============================================================
call setup.bat
if errorlevel 1 (
    echo ERROR: Setup failed!
    pause
    exit /b 1
)

echo.
echo ============================================================
echo [STEP 2/5] DOWNLOADING MODEL
echo ============================================================
call venv\Scripts\activate.bat
python download_model.py
if errorlevel 1 (
    echo ERROR: Model download failed!
    pause
    exit /b 1
)

echo.
echo ============================================================
echo [STEP 3/5] PREPARING DATA
echo ============================================================
python prepare_data.py
if errorlevel 1 (
    echo ERROR: Data preparation failed!
    pause
    exit /b 1
)

echo.
echo ============================================================
echo [STEP 4/5] TRAINING MODEL
echo ============================================================
echo This will take 2-4 hours. Do not close this window.
echo.
python train.py
if errorlevel 1 (
    echo ERROR: Training failed!
    pause
    exit /b 1
)

echo.
echo ============================================================
echo [STEP 5/5] TESTING MODEL
echo ============================================================
python test.py

echo.
echo ============================================================
echo    ALL STEPS COMPLETE!
echo ============================================================
echo.
echo Your trained Evony model is at: training\output\final
echo.
echo To chat with your model: python test.py --interactive
echo.
pause
