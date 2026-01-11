@echo off
REM ============================================================
REM Download Qwen2.5-VL-7B-Instruct Model
REM ============================================================

echo.
echo ============================================================
echo    DOWNLOADING MODEL
echo    Qwen2.5-VL-7B-Instruct (Abliterated version)
echo ============================================================
echo.

call venv\Scripts\activate.bat

echo This will download ~15GB. Make sure you have space.
echo.

python download_model.py

echo.
echo ============================================================
echo    DOWNLOAD COMPLETE!
echo ============================================================
echo.
echo Next: Run train.bat to start training
echo.
pause
