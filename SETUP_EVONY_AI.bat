@echo off
title Evony AI - Setup
echo.
echo ============================================================
echo           EVONY AI - UNSLOTH TRAINING SETUP
echo ============================================================
echo.
echo This will install Unsloth and dependencies for RTX 3090 Ti
echo.

cd /d "c:\Users\Admin\Downloads\Evony_Decrypted\evony_ai"

echo [1/3] Installing PyTorch with CUDA...
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

echo.
echo [2/3] Installing Unsloth...
pip install "unsloth[colab-new] @ git+https://github.com/unslothai/unsloth.git"

echo.
echo [3/3] Installing training dependencies...
pip install -r requirements_unsloth.txt

echo.
echo ============================================================
echo Setup complete! Run TRAIN_EVONY_AI.bat to start training.
echo ============================================================
pause
