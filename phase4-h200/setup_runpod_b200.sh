#!/bin/bash
# ============================================================================
# RunPod B200 Setup Script for Evony Training
# ============================================================================
# Based on official documentation:
# - Unsloth B200 Guide: https://unsloth.ai/docs/basics/fine-tuning-llms-with-blackwell-rtx-50-series-and-unsloth
# - RunPod PyTorch 2.8: https://www.runpod.io/articles/guides/pytorch-2-8-cuda-12-8
#
# Container: runpod/pytorch:2.8.0-py3.11-cuda12.8.1-cudnn-devel-ubuntu
# ============================================================================

set -e  # Exit on error

echo "============================================================================"
echo "EVONY TRAINING - B200 SETUP"
echo "============================================================================"

# Check GPU
echo ""
echo "🔍 Checking GPU..."
nvidia-smi --query-gpu=name,memory.total --format=csv,noheader

# Check PyTorch
echo ""
echo "🔍 Checking PyTorch..."
python -c "import torch; print(f'PyTorch: {torch.__version__}'); print(f'CUDA: {torch.version.cuda}')"

# Install Unsloth (official method for B200)
echo ""
echo "📦 Installing Unsloth for B200..."
pip install unsloth

# Verify installation
echo ""
echo "✅ Verifying installation..."
python -c "from unsloth import FastLanguageModel; print('Unsloth OK')"
python -c "from trl import SFTTrainer, SFTConfig; print('TRL OK')"
python -c "from datasets import Dataset; print('Datasets OK')"

echo ""
echo "============================================================================"
echo "✅ SETUP COMPLETE!"
echo "============================================================================"
echo ""
echo "To start training, run:"
echo "  python train_unsloth_b200.py"
echo ""
echo "Your dataset should be at: dataset/final_training/train.jsonl"
echo "Output will be saved to: output_evony_unsloth/"
echo ""
