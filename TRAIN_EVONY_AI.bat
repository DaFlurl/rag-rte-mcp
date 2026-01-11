@echo off
title Evony AI - Training
echo.
echo ============================================================
echo           EVONY AI - UNSLOTH TRAINING
echo ============================================================
echo.
echo Model: Qwen2.5-3B-Instruct
echo GPU: RTX 3090 Ti
echo Dataset: 36,370 examples
echo.
echo Training will take approximately 2-4 hours.
echo Progress will be logged every 10 steps.
echo.
echo ============================================================
echo.

cd /d "c:\Users\Admin\Downloads\Evony_Decrypted\evony_ai"
python train_unsloth.py

echo.
echo ============================================================
echo Training complete! Run CHAT_EVONY_AI.bat to test.
echo ============================================================
pause
