#!/usr/bin/env python3
"""
Download Qwen2.5-VL-7B-Instruct Model
Abliterated (uncensored) version for training
"""

import os
import sys
from pathlib import Path

def main():
    print("="*60)
    print("DOWNLOADING QWEN2.5-VL-7B-INSTRUCT")
    print("="*60)
    
    try:
        from huggingface_hub import snapshot_download, login
    except ImportError:
        print("Installing huggingface_hub...")
        os.system("pip install huggingface_hub")
        from huggingface_hub import snapshot_download, login
    
    # Model options - try abliterated first, fall back to official
    models = [
        ("huihui-ai/Qwen2.5-VL-7B-Instruct-abliterated", "abliterated"),
        ("Qwen/Qwen2.5-VL-7B-Instruct", "official"),
    ]
    
    model_dir = Path(__file__).parent / "models"
    model_dir.mkdir(exist_ok=True)
    
    for model_id, model_type in models:
        print(f"\nTrying: {model_id} ({model_type})")
        
        try:
            local_dir = model_dir / "qwen2.5-vl-7b"
            
            print(f"Downloading to: {local_dir}")
            print("This may take 10-30 minutes depending on connection...")
            
            snapshot_download(
                repo_id=model_id,
                local_dir=str(local_dir),
                local_dir_use_symlinks=False,
                resume_download=True,
            )
            
            print(f"\n✅ Downloaded: {model_id}")
            print(f"Location: {local_dir}")
            
            # Save model info
            info_file = local_dir / "model_info.txt"
            with open(info_file, "w") as f:
                f.write(f"Model: {model_id}\n")
                f.write(f"Type: {model_type}\n")
                f.write(f"Downloaded by: Evony Training Setup\n")
            
            return True
            
        except Exception as e:
            print(f"Failed: {e}")
            continue
    
    print("\n❌ Could not download model. Check your internet connection.")
    print("You may need to login: huggingface-cli login")
    return False


if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
