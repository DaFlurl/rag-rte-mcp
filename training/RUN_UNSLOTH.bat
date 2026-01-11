@echo off
REM ============================================================
REM COMPLETE UNSLOTH TRAINING PIPELINE
REM One-click: Setup → Data → Train → Test
REM ============================================================

echo.
echo ============================================================
echo    EVONY MODEL - COMPLETE TRAINING PIPELINE
echo    Model: Qwen2.5-VL-7B-Instruct
echo    Method: Multi-task SFT + QLoRA (Unsloth)
echo    GPU: RTX 3090 Ti (24GB VRAM)
echo ============================================================
echo.
echo This will:
echo   1. Setup Unsloth environment
echo   2. Prepare multi-task dataset (5 skill buckets)
echo   3. Train with QLoRA (2-4 hours)
echo   4. Save LoRA adapter + merged model
echo.
echo Press any key to start...
pause >nul

echo.
echo ============================================================
echo [STEP 1/3] SETTING UP UNSLOTH
echo ============================================================
call setup_unsloth.bat
if errorlevel 1 goto :error

echo.
echo ============================================================
echo [STEP 2/3] PREPARING MULTI-TASK DATA
echo ============================================================
call venv\Scripts\activate.bat
python prepare_multitask.py
if errorlevel 1 goto :error

echo.
echo ============================================================
echo [STEP 3/3] TRAINING WITH UNSLOTH
echo ============================================================
echo This will take 2-4 hours. Do not close this window.
echo.
python train_unsloth.py
if errorlevel 1 goto :error

echo.
echo ============================================================
echo    ALL STEPS COMPLETE!
echo ============================================================
echo.
echo Your trained Evony model:
echo   LoRA adapter: training\output\final
echo   Merged model: training\output\merged
echo.
echo To test: python test_unsloth.py
echo.
pause
exit /b 0

:error
echo.
echo ============================================================
echo    ERROR: Training failed!
echo ============================================================
pause
exit /b 1
