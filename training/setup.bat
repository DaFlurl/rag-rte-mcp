@echo off
REM ============================================================
REM Evony Model Training - One-Click Setup
REM For RTX 3090 Ti with Qwen2.5-VL-7B-Instruct
REM ============================================================

echo.
echo ============================================================
echo    EVONY MODEL TRAINING SETUP
echo    Target: Qwen2.5-VL-7B-Instruct (Abliterated)
echo    GPU: RTX 3090 Ti (24GB VRAM)
echo ============================================================
echo.

REM Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python not found. Please install Python 3.10+
    pause
    exit /b 1
)

echo [1/5] Creating virtual environment...
if not exist "venv" (
    python -m venv venv
)
call venv\Scripts\activate.bat

echo [2/5] Upgrading pip...
python -m pip install --upgrade pip

echo [3/5] Installing PyTorch with CUDA...
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

echo [4/5] Installing training dependencies...
pip install transformers>=4.40.0
pip install datasets>=2.18.0
pip install accelerate>=0.28.0
pip install peft>=0.10.0
pip install bitsandbytes>=0.43.0
pip install trl>=0.8.0
pip install sentencepiece
pip install protobuf
pip install huggingface_hub
pip install tensorboard
pip install wandb
pip install flash-attn --no-build-isolation
pip install qwen-vl-utils

echo [5/5] Installing additional tools...
pip install jsonlines
pip install tqdm
pip install pyyaml

echo.
echo ============================================================
echo    SETUP COMPLETE!
echo ============================================================
echo.
echo Next steps:
echo   1. Run: download_model.bat
echo   2. Run: train.bat
echo.
pause
