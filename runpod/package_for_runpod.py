#!/usr/bin/env python3
"""
Package training files for RunPod upload
Creates a single zip with everything needed for training
"""

import os
import json
import zipfile
from pathlib import Path
from datetime import datetime

SCRIPT_DIR = Path(__file__).parent
PROJECT_DIR = SCRIPT_DIR.parent
OUTPUT_ZIP = SCRIPT_DIR / "evony_training_package.zip"

def package():
    print("="*60)
    print("PACKAGING FOR RUNPOD")
    print(f"Started: {datetime.now()}")
    print("="*60)
    
    # Files to include
    files_to_add = []
    
    # 1. Training data - prioritize perfect dataset
    data_dir = PROJECT_DIR / "training" / "data"
    if data_dir.exists():
        # Add perfect dataset first
        perfect_file = data_dir / "train_perfect_messages.jsonl"
        if perfect_file.exists():
            files_to_add.append((perfect_file, f"data/{perfect_file.name}"))
            print(f"✓ Perfect dataset: {perfect_file.name}")
        
        # Add other data files
        for f in data_dir.glob("*.jsonl"):
            if f.name != "train_perfect_messages.jsonl":
                files_to_add.append((f, f"data/{f.name}"))
        for f in data_dir.glob("*.json"):
            files_to_add.append((f, f"data/{f.name}"))
        print(f"✓ Training data: {len(list(data_dir.glob('*')))} files")
    else:
        print("WARNING: training/data not found!")
        # Try alternate location
        alt_data = PROJECT_DIR / "Evony_Training_Data"
        if alt_data.exists():
            for f in ["evony_filtered_quality.json", "evony_augmented_10k.json"]:
                path = alt_data / f
                if path.exists():
                    files_to_add.append((path, f"data/{f}"))
            print(f"✓ Using alternate data location")
    
    # 2. Training scripts
    scripts = [
        (SCRIPT_DIR / "train_runpod.py", "train_runpod.py"),
        (SCRIPT_DIR / "train_runpod_borg.py", "train_runpod_borg.py"),
        (SCRIPT_DIR / "borg_display.py", "borg_display.py"),
        (SCRIPT_DIR / "borg_theme.py", "borg_theme.py"),
        (SCRIPT_DIR / "evaluate.py", "evaluate.py"),
        (SCRIPT_DIR / "requirements.txt", "requirements.txt"),
        (SCRIPT_DIR / "staged_training.py", "staged_training.py"),
        (SCRIPT_DIR / "RUNBOOK.md", "RUNBOOK.md"),
    ]
    
    for src, dst in scripts:
        if src.exists():
            files_to_add.append((src, dst))
    print(f"✓ Training scripts: {len(scripts)} files")
    
    # 3. Create startup script
    startup_script = """#!/bin/bash
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
"""
    
    startup_path = SCRIPT_DIR / "start_training.sh"
    with open(startup_path, "w", newline="\n") as f:
        f.write(startup_script)
    files_to_add.append((startup_path, "start_training.sh"))
    print("✓ Startup script created")
    
    # 4. Create zip
    print(f"\nCreating {OUTPUT_ZIP.name}...")
    
    with zipfile.ZipFile(OUTPUT_ZIP, 'w', zipfile.ZIP_DEFLATED) as zf:
        for src, dst in files_to_add:
            if src.exists():
                zf.write(src, dst)
                print(f"  + {dst}")
    
    # Get zip size
    size_mb = OUTPUT_ZIP.stat().st_size / (1024 * 1024)
    
    print(f"\n✅ PACKAGE READY")
    print(f"   File: {OUTPUT_ZIP}")
    print(f"   Size: {size_mb:.1f} MB")
    print(f"   Files: {len(files_to_add)}")
    
    # Instructions
    print(f"""
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NEXT STEPS:

Option A: Automated (via API)
  python runpod_orchestrator.py

Option B: Manual Upload
  1. Go to https://runpod.io/console/pods
  2. Create pod: PyTorch 2.1 + 1x H100 80GB
  3. Upload: {OUTPUT_ZIP.name}
  4. SSH in and run:
     cd /workspace
     unzip evony_training_package.zip
     bash start_training.sh
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
""")
    
    return True


if __name__ == "__main__":
    package()
