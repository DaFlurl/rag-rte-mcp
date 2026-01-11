@echo off
REM ============================================================
REM Unsloth Training - Qwen2.5-VL-7B Multi-task SFT
REM ============================================================

echo.
echo ============================================================
echo    UNSLOTH MULTI-TASK SFT TRAINING
echo    Model: Qwen2.5-VL-7B-Instruct
echo    Method: QLoRA (4-bit)
echo    GPU: RTX 3090 Ti
echo ============================================================
echo.

call venv\Scripts\activate.bat

REM Prepare multi-task dataset
echo [1/2] Preparing multi-task dataset...
python prepare_multitask.py
if errorlevel 1 (
    echo ERROR: Dataset preparation failed!
    pause
    exit /b 1
)

REM Run training
echo.
echo [2/2] Starting Unsloth training...
echo Estimated time: 2-4 hours
echo.
python train_unsloth.py

echo.
echo ============================================================
echo    TRAINING COMPLETE!
echo ============================================================
echo.
echo Model saved to: training\output\final (LoRA adapter)
echo Merged model: training\output\merged
echo.
pause
