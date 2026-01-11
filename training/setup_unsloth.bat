@echo off
REM ============================================================
REM Unsloth Setup for Qwen2.5-VL-7B Training
REM Multi-task SFT + QLoRA - RTX 3090 Ti Optimized
REM ============================================================

echo.
echo ============================================================
echo    UNSLOTH TRAINING SETUP
echo    Model: Qwen2.5-VL-7B-Instruct
echo    Method: Multi-task SFT + QLoRA
echo    GPU: RTX 3090 Ti (24GB VRAM)
echo ============================================================
echo.

REM Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python not found. Install Python 3.10+
    pause
    exit /b 1
)

echo [1/4] Creating virtual environment...
if not exist "venv" (
    python -m venv venv
)
call venv\Scripts\activate.bat

echo [2/4] Upgrading pip...
python -m pip install --upgrade pip

echo [3/4] Installing Unsloth + dependencies...
REM Unsloth with CUDA 12.1
pip install "unsloth[colab-new] @ git+https://github.com/unslothai/unsloth.git"
pip install --no-deps trl peft accelerate bitsandbytes
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
pip install transformers datasets huggingface_hub
pip install qwen-vl-utils
pip install pillow

echo [4/4] Installing additional tools...
pip install tensorboard wandb jsonlines tqdm pyyaml

echo.
echo ============================================================
echo    SETUP COMPLETE!
echo ============================================================
echo.
echo Next: Run train_unsloth.bat
echo.
pause
