#!/bin/bash
# WSL2 Setup for Evony Phase 3 Training with Unsloth

echo "🔧 Setting up WSL2 for Evony Phase 3 Training..."

# Create venv
python3 -m venv ~/evony_venv
source ~/evony_venv/bin/activate

# Install CUDA torch
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124

# Install unsloth and dependencies
pip install "unsloth[colab-new] @ git+https://github.com/unslothai/unsloth.git"
pip install trl datasets transformers accelerate bitsandbytes rich peft

echo "✅ Setup complete!"
echo ""
echo "To train, run:"
echo "  source ~/evony_venv/bin/activate"
echo "  cd /mnt/c/Users/Admin/Downloads/Evony_Decrypted/phase3-3090"
echo "  python3 train_phase3_tv.py"
