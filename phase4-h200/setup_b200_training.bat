@echo off
REM ╔══════════════════════════════════════════════════════════════════════════════╗
REM ║                    B200 FP16 TRAINING SETUP                                  ║
REM ║                    PyTorch 2.8+ | NVIDIA B200 Optimized                      ║
REM ╚══════════════════════════════════════════════════════════════════════════════╝

echo.
echo ============================================================
echo       B200 FP16 EPIC TRAINING ENVIRONMENT SETUP
echo ============================================================
echo.

REM Check Python version
python --version
if errorlevel 1 (
    echo ERROR: Python not found! Please install Python 3.10+
    pause
    exit /b 1
)

echo.
echo [1/5] Creating virtual environment...
if not exist "b200_env" (
    python -m venv b200_env
    echo     Created: b200_env
) else (
    echo     Already exists: b200_env
)

echo.
echo [2/5] Activating environment...
call b200_env\Scripts\activate.bat

echo.
echo [3/5] Upgrading pip...
python -m pip install --upgrade pip --quiet

echo.
echo [4/5] Installing PyTorch 2.8+ with CUDA 12.6...
echo     This may take a few minutes...
pip install torch>=2.8.0 torchvision>=0.20.0 torchaudio>=2.5.0 --index-url https://download.pytorch.org/whl/cu126

echo.
echo [5/5] Installing dependencies...
pip install transformers>=4.45.0 datasets>=3.0.0 accelerate>=1.0.0
pip install peft>=0.13.0 trl>=0.12.0 bitsandbytes>=0.44.0
pip install sentencepiece protobuf scipy einops safetensors
pip install wandb tensorboard tqdm

echo.
echo ============================================================
echo       OPTIONAL: Install Unsloth for 2x speedup
echo ============================================================
echo.
echo To install Unsloth (recommended):
echo     pip install unsloth
echo.
echo To install Flash Attention (recommended):
echo     pip install flash-attn --no-build-isolation
echo.

echo.
echo ============================================================
echo       VERIFYING INSTALLATION
echo ============================================================
python -c "import torch; print(f'PyTorch: {torch.__version__}'); print(f'CUDA Available: {torch.cuda.is_available()}'); print(f'GPU: {torch.cuda.get_device_name(0) if torch.cuda.is_available() else \"N/A\"}')"

echo.
echo ============================================================
echo       SETUP COMPLETE!
echo ============================================================
echo.
echo To start training:
echo     1. Activate environment: b200_env\Scripts\activate
echo     2. Run training: python train_b200_fp16_epic.py
echo.
echo Dataset location: dataset\enums_cve\FINAL_VERIFIED_DATASET.jsonl
echo.
pause
