@echo off
REM ============================================================
REM Evony Model Training - One-Click Training
REM ============================================================

echo.
echo ============================================================
echo    EVONY MODEL TRAINING
echo    Model: Qwen2.5-VL-7B-Instruct
echo    GPU: RTX 3090 Ti (24GB VRAM)
echo ============================================================
echo.

call venv\Scripts\activate.bat

REM Prepare data first
echo [1/2] Preparing training data...
python prepare_data.py
if errorlevel 1 (
    echo ERROR: Data preparation failed!
    pause
    exit /b 1
)

REM Run training
echo.
echo [2/2] Starting training...
echo This will take 2-4 hours depending on your GPU.
echo.
python train.py

echo.
echo ============================================================
echo    TRAINING COMPLETE!
echo ============================================================
echo.
echo Model saved to: training\output\final
echo.
echo To test: Run test.bat
echo.
pause
