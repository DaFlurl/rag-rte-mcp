#!/bin/bash
# SVONY STUDIO PHASE 2 SETUP
# Includes Training TV Borg Display
# Phase 2 Training Setup Script
# Run this on RunPod after uploading evony_phase2.zip

echo "╔══════════════════════════════════════════════════════════════════════╗"
echo "║  EVONY CODER PHASE 2 SETUP                                           ║"
echo "╚══════════════════════════════════════════════════════════════════════╝"

# Check if already extracted
if [ ! -f "/workspace/train_runpod_v2.py" ]; then
    echo "[1/4] Extracting package..."
    cd /workspace
    unzip -o evony_phase2.zip
else
    echo "[1/4] Already extracted, skipping..."
fi

# Install dependencies (safe - no upgrades)
echo "[2/4] Installing dependencies..."
pip uninstall -y torchaudio 2>/dev/null
pip install --no-deps unsloth unsloth_zoo 2>/dev/null
pip install --no-deps datasets peft trl accelerate bitsandbytes sentencepiece 2>/dev/null
pip install rich pyfiglet 2>/dev/null  # Training TV display

# Verify data exists
echo "[3/4] Checking data..."
if [ -f "/workspace/data/train_complete_source.jsonl" ]; then
    LINES=$(wc -l < /workspace/data/train_complete_source.jsonl)
    echo "       ✓ train_complete_source.jsonl ($LINES examples)"
else
    echo "       ✗ ERROR: Data not found!"
    echo "       Upload data.zip and extract to /workspace/data/"
    exit 1
fi

if [ -f "/workspace/data/val_normalized.jsonl" ]; then
    VAL_LINES=$(wc -l < /workspace/data/val_normalized.jsonl)
    echo "       ✓ val_normalized.jsonl ($VAL_LINES examples)"
fi

# Show config
echo "[4/4] Phase 2 Configuration (Claude-approved):"
echo "       Model: Qwen2.5-Coder-7B-Instruct-abliterated"
echo "       Context: 4096 (was 8192)"
echo "       Batch: 4 x 4 = 16 (conservative)"
echo "       LR: 1e-5 (refinement)"
echo "       Epochs: +2 (total 5, test before adding more)"
echo ""
echo "╔══════════════════════════════════════════════════════════════════════╗"
echo "║  SVONY STUDIO TRAINING TV - PHASE 2                                  ║"
echo "╠══════════════════════════════════════════════════════════════════════╣"
echo "║  For BORG DISPLAY (recommended):                                     ║"
echo "║    python train_runpod_v2_borg.py                                    ║"
echo "║                                                                      ║"
echo "║  For plain output:                                                   ║"
echo "║    python train_runpod_v2.py                                         ║"
echo "╚══════════════════════════════════════════════════════════════════════╝"
