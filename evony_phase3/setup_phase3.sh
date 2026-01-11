#!/bin/bash
# ============================================================
# EVONY PHASE 3 SETUP - RUNPOD H200
# ============================================================
echo "🚀 Setting up Evony Phase 3 Training Environment..."

# Install dependencies
echo "[1/3] Installing Unsloth + dependencies..."
pip install --upgrade pip
pip install unsloth trl datasets transformers accelerate bitsandbytes
pip install rich  # For Training TV

# Verify GPU
echo "[2/3] Checking GPU..."
python -c "import torch; print(f'GPU: {torch.cuda.get_device_name(0)}'); print(f'VRAM: {torch.cuda.get_device_properties(0).total_memory/1e9:.1f} GB')"

# Check files
echo "[3/3] Checking training files..."
ls -la *.jsonl *.py

echo ""
echo "============================================================"
echo "✅ SETUP COMPLETE!"
echo "============================================================"
echo ""
echo "To start training:"
echo "  python train_phase3_tv.py"
echo ""
echo "Files:"
echo "  - train_final.jsonl (21,132 examples)"
echo "  - train_phase3_tv.py (Training TV script)"
echo "  - validation_prompts_v2.json (80 prompts)"
echo ""
