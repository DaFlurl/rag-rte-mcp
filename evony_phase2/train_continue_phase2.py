#!/usr/bin/env python3
"""
Continue Phase 2 Training - Resume from Checkpoint
==================================================
Resumes training from existing Phase 2 checkpoint on H200.

To continue training:
1. Upload this package to RunPod
2. Extract: unzip evony_phase2_continue.zip
3. Run: python train_continue_phase2.py

This will automatically find and resume from the latest checkpoint.
"""

import os
import json
import torch
from pathlib import Path
from datetime import datetime

# Paths
WORKSPACE = Path("/workspace")
DATA_DIR = WORKSPACE / "data"
OUTPUT_DIR = WORKSPACE / "output_phase2"
CHECKPOINT_DIR = OUTPUT_DIR / "checkpoint-*"

# ============================================================
# CONTINUE TRAINING CONFIG
# ============================================================
CONFIG = {
    # Model (same as Phase 2)
    "model_name": "huihui-ai/Qwen2.5-Coder-7B-Instruct-abliterated",
    
    # Phase 2 Settings (unchanged)
    "max_seq_length": 4096,
    "batch_size": 4,
    "gradient_accumulation": 4,
    "learning_rate": 1e-5,      # Keep same for continuity
    
    # CONTINUE SETTINGS
    "num_epochs": 3,            # Additional epochs to train
    "warmup_ratio": 0.01,       # Lower warmup for continuation
    
    # LoRA (same as Phase 2)
    "load_in_4bit": True,
    "lora_r": 32,
    "lora_alpha": 64,
    "lora_dropout": 0.0,
    
    # Checkpointing
    "save_steps": 200,
    "save_total_limit": 5,
    "logging_steps": 10,
}

# Guardrails (same as Phase 2)
GUARDRAILS = {
    "min_steps_per_sec": 0.3,
    "good_steps_per_sec": 0.5,
    "borderline_steps_per_sec": 0.4,
    "warmup_minutes": 2,          # Shorter warmup for continuation
    "check_after_minutes": 5,     # Earlier check
    "session_hours": 2.0,         # Shorter session for continuation
    "cost_per_hour": 3.59,        # H200 SXM rate
}

def find_latest_checkpoint():
    """Find the latest checkpoint to resume from"""
    print("\n[RESUME] Searching for checkpoints...")
    
    # Look for checkpoint directories
    checkpoints = list(OUTPUT_DIR.glob("checkpoint-*"))
    
    if not checkpoints:
        print("[ERROR] No checkpoints found!")
        print("        Make sure Phase 2 training ran and saved checkpoints")
        return None
    
    # Sort by step number (extract from checkpoint-XXX)
    checkpoints.sort(key=lambda x: int(x.name.split("-")[1]), reverse=True)
    
    latest = checkpoints[0]
    step_num = int(latest.name.split("-")[1])
    
    print(f"[RESUME] Found latest checkpoint: {latest.name} (step {step_num})")
    
    # Verify checkpoint has required files
    required_files = ["adapter_model.safetensors", "adapter_config.json", "training_args.bin"]
    missing = [f for f in required_files if not (latest / f).exists()]
    
    if missing:
        print(f"[ERROR] Checkpoint missing files: {missing}")
        return None
    
    print(f"[RESUME] Checkpoint verified ✓")
    return latest

def load_training_info():
    """Load training info from Phase 2"""
    info_file = OUTPUT_DIR / "training_info.json"
    
    if info_file.exists():
        with open(info_file, 'r') as f:
            return json.load(f)
    
    print("[WARNING] No training_info.json found")
    return {}

def setup_environment():
    """Setup training environment"""
    print("Setting up continue training environment...")
    
    # Check workspace
    if not WORKSPACE.exists():
        print("[ERROR] /workspace not found!")
        return False
    
    # Check data
    if not DATA_DIR.exists():
        print("[ERROR] Data directory not found!")
        print("        Make sure data/ is uploaded from Phase 2")
        return False
    
    # Check GPU
    if torch.cuda.is_available():
        gpu = torch.cuda.get_device_name(0)
        mem = torch.cuda.get_device_properties(0).total_memory / 1024**3
        print(f"GPU: {gpu} ({mem:.1f}GB)")
        
        if "H200" in gpu:
            print("✓ H200 detected - optimal for Phase 2")
        elif "H100" in gpu:
            print("✓ H100 detected - compatible")
        else:
            print("⚠ Different GPU detected - may affect performance")
    else:
        print("ERROR: No GPU detected!")
        return False
    
    return True

def load_dataset():
    """Load training data"""
    print("\nLoading dataset...")
    
    train_file = DATA_DIR / "train_complete_source.jsonl"
    val_file = DATA_DIR / "val_normalized.jsonl"
    
    if not train_file.exists():
        print(f"[ERROR] Training data not found: {train_file}")
        return None, None
    
    if not val_file.exists():
        print(f"[ERROR] Validation data not found: {val_file}")
        return None, None
    
    from datasets import load_dataset
    
    # Load datasets
    train_data = load_dataset('json', data_files=str(train_file), split='train')
    val_data = load_dataset('json', data_files=str(val_file), split='train')
    
    print(f"✓ Loaded {len(train_data):,} training examples")
    print(f"✓ Loaded {len(val_data):,} validation examples")
    
    return train_data, val_data

def format_messages(example):
    """Format messages for SFTTrainer"""
    if 'messages' in example:
        return example
    elif 'instruction' in example:
        # Convert instruction format to messages
        messages = [
            {"role": "user", "content": example['instruction']}
        ]
        if 'output' in example:
            messages.append({"role": "assistant", "content": example['output']})
        return {"messages": messages}
    else:
        return {"messages": []}

def main():
    """Main training function"""
    print("""
╔══════════════════════════════════════════════════════════════════════╗
║           EVONY CODER - PHASE 2 CONTINUE TRAINING                     ║
║              Resume from Checkpoint on H200 GPU                        ║
╚══════════════════════════════════════════════════════════════════════╝
    """)
    
    # Setup
    if not setup_environment():
        return False
    
    # Find checkpoint
    checkpoint_path = find_latest_checkpoint()
    if checkpoint_path is None:
        return False
    
    # Load training info
    training_info = load_training_info()
    if training_info:
        print(f"\n[INFO] Previous training:")
        print(f"       Phase: {training_info.get('phase', 'Unknown')}")
        print(f"       Epochs: {training_info.get('epochs', 'Unknown')}")
        print(f"       Examples: {training_info.get('examples', 'Unknown'):,}")
        print(f"       Context: {training_info.get('context_length', 'Unknown')}")
        print(f"       Learning Rate: {training_info.get('learning_rate', 'Unknown')}")
        print(f"       Completed: {training_info.get('completed', 'Unknown')}")
    
    # Load data
    train_data, val_data = load_dataset()
    if train_data is None:
        return False
    
    # Format data
    print("\n[DATA] Formatting for SFTTrainer...")
    train_data = train_data.map(format_messages)
    val_data = val_data.map(format_messages)
    
    # Load model with Unsloth
    print(f"\n[MODEL] Loading {CONFIG['model_name']}...")
    print(f"        Context: {CONFIG['max_seq_length']} tokens")
    print(f"        Resuming from: {checkpoint_path.name}")
    
    try:
        from unsloth import FastLanguageModel
    except ImportError:
        print("[ERROR] Unsloth not installed!")
        print("        Run: pip install unsloth")
        return False
    
    # Load model
    model, tokenizer = FastLanguageModel.from_pretrained(
        model_name=CONFIG["model_name"],
        max_seq_length=CONFIG["max_seq_length"],
        load_in_4bit=CONFIG["load_in_4bit"],
        dtype=None,
    )
    
    # Apply LoRA (same config as Phase 2)
    print("[MODEL] Applying LoRA adapters...")
    model = FastLanguageModel.get_peft_model(
        model,
        r=CONFIG["lora_r"],
        lora_alpha=CONFIG["lora_alpha"],
        lora_dropout=CONFIG["lora_dropout"],
        target_modules=[
            "q_proj", "k_proj", "v_proj", "o_proj",
            "gate_proj", "up_proj", "down_proj",
        ],
        bias="none",
        use_gradient_checkpointing="unsloth",
        random_state=42,
    )
    
    # Load checkpoint weights
    print(f"[RESUME] Loading checkpoint weights...")
    from peft import PeftModel
    model = PeftModel.from_pretrained(model, str(checkpoint_path))
    print("✓ Checkpoint loaded successfully")
    
    # Setup trainer
    print("\n[TRAINER] Setting up SFTTrainer...")
    from trl import SFTTrainer, SFTConfig
    
    # Training arguments
    training_args = SFTConfig(
        output_dir=str(OUTPUT_DIR),
        
        # Batch settings
        per_device_train_batch_size=CONFIG["batch_size"],
        gradient_accumulation_steps=CONFIG["gradient_accumulation"],
        
        # Learning rate
        learning_rate=CONFIG["learning_rate"],
        warmup_ratio=CONFIG["warmup_ratio"],
        lr_scheduler_type="cosine",
        
        # Training duration
        num_train_epochs=CONFIG["num_epochs"],
        
        # Precision
        fp16=True,
        bf16=False,
        
        # Logging
        logging_steps=CONFIG["logging_steps"],
        logging_first_step=True,
        report_to="none",
        
        # Checkpointing
        save_steps=CONFIG["save_steps"],
        save_total_limit=CONFIG["save_total_limit"],
        save_safetensors=True,
        
        # Performance
        optim="adamw_8bit",
        gradient_checkpointing=True,
        max_grad_norm=1.0,
        
        # Data
        max_seq_length=CONFIG["max_seq_length"],
        packing=True,
        
        # Resume
        resume_from_checkpoint=str(checkpoint_path),
        
        # Seed
        seed=42,
    )
    
    # Create trainer
    trainer = SFTTrainer(
        model=model,
        processing_class=tokenizer,
        train_dataset=train_data,
        eval_dataset=val_data,
        args=training_args,
    )
    
    # Train
    print("\n" + "="*70)
    print("🚀 CONTINUING PHASE 2 TRAINING")
    print("="*70)
    print(f"📊 Additional epochs: {CONFIG['num_epochs']}")
    print(f"📊 Learning rate: {CONFIG['learning_rate']}")
    print(f"📊 Save every: {CONFIG['save_steps']} steps")
    print(f"📊 Checkpoint: {checkpoint_path.name}")
    print("-"*70)
    
    start_time = datetime.now()
    
    try:
        # Train
        train_result = trainer.train()
        
        # Save final model
        print("\n[SAVE] Saving continued model...")
        final_dir = OUTPUT_DIR / "continued"
        trainer.save_model(str(final_dir))
        tokenizer.save_pretrained(str(final_dir))
        
        # Update training info
        total_epochs = training_info.get('total_epochs', 5) + CONFIG['num_epochs']
        info = {
            "phase": 2,
            "continued": True,
            "resumed_from": checkpoint_path.name,
            "model": CONFIG["model_name"],
            "additional_epochs": CONFIG["num_epochs"],
            "total_epochs": total_epochs,
            "examples": len(train_data),
            "context_length": CONFIG["max_seq_length"],
            "learning_rate": CONFIG["learning_rate"],
            "completed": datetime.now().isoformat(),
            "previous_info": training_info,
        }
        
        with open(OUTPUT_DIR / "training_info_continued.json", 'w') as f:
            json.dump(info, f, indent=2)
        
        # Summary
        elapsed = (datetime.now() - start_time).total_seconds() / 60
        print(f"""
╔══════════════════════════════════════════════════════════════════════╗
║  ✅ PHASE 2 CONTINUATION COMPLETE                                     ║
╠══════════════════════════════════════════════════════════════════════╣
║  Duration: {elapsed:.1f} minutes                                          ║
║  Additional Epochs: {CONFIG['num_epochs']}                                    ║
║  Total Epochs: {total_epochs}                                               ║
║  Final Loss: {train_result.training_loss:.4f}                           ║
║  Output: {OUTPUT_DIR}/continued/                                        ║
╚══════════════════════════════════════════════════════════════════════╝
        """)
        
        return True
        
    except KeyboardInterrupt:
        print("\n⚠️ Training interrupted by user")
        return False
    except Exception as e:
        print(f"\n❌ Training error: {e}")
        return False

if __name__ == "__main__":
    success = main()
    if success:
        print("\n🎉 Phase 2 continuation completed successfully!")
    else:
        print("\n❌ Phase 2 continuation failed!")
        exit(1)
