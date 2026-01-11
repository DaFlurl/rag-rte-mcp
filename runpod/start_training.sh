#!/bin/bash
# RunPod Startup Script - Qwen2.5-Coder-7B Training
# SVONY STUDIO BORG EDITION
cd /workspace

echo "=== ENVIRONMENT SETUP ==="
# Fix torch version conflict with torchaudio
pip uninstall -y torchaudio 2>/dev/null || true

echo "Installing dependencies (no upgrades)..."
pip install --no-deps unsloth unsloth_zoo
pip install --no-deps transformers datasets peft trl accelerate bitsandbytes sentencepiece
pip install rich pyfiglet 2>/dev/null || true

echo ""
echo "=== STARTING BORG TRAINING ==="
# Use Borg display version for fancy terminal
python train_runpod_borg.py

echo ""
echo "=== RUNNING EVALUATION ==="
python evaluate.py

echo ""
echo "=== ASSIMILATION COMPLETE ==="
echo "Results saved to /workspace/output/"
echo "Download the merged model from /workspace/output/merged/"
