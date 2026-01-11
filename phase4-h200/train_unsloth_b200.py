#!/usr/bin/env python3
"""
Evony Training Script - B200 GPU with Unsloth
==============================================
Based on official documentation:
- Unsloth: https://github.com/unslothai/unsloth
- HuggingFace TRL SFTTrainer: https://huggingface.co/docs/trl/en/sft_trainer
- RunPod B200: https://www.runpod.io/articles/guides/pytorch-2-8-cuda-12-8

Dataset format: ChatML messages (natively supported by SFTTrainer)
{"messages": [{"role": "user", "content": "..."}, {"role": "assistant", "content": "..."}]}
"""

import os
import sys
import json
import signal
import time
from datetime import datetime
from pathlib import Path

# ============================================================================
# CONFIGURATION - Edit these values as needed
# ============================================================================

CONFIG = {
    # Model
    "model_name": "huihui-ai/Huihui-Qwen3-4B-Instruct-2507-abliterated",
    "max_seq_length": 4096,
    
    # LoRA Configuration (from official docs)
    "lora_r": 16,
    "lora_alpha": 16,
    "lora_dropout": 0,
    "lora_target_modules": ["q_proj", "k_proj", "v_proj", "o_proj",
                           "gate_proj", "up_proj", "down_proj"],
    
    # Training
    "batch_size": 4,
    "gradient_accumulation_steps": 4,
    "learning_rate": 2e-4,
    "num_epochs": 3,
    "warmup_ratio": 0.03,
    "weight_decay": 0.01,
    
    # Checkpointing
    "save_steps": 100,
    "save_total_limit": 10,
    "logging_steps": 10,
    
    # Paths
    "dataset_path": "dataset/final_training/train.jsonl",
    "output_dir": "output_evony_unsloth",
    
    # Options
    "load_in_4bit": True,
    "use_gradient_checkpointing": True,
}

# ============================================================================
# SETUP AND VALIDATION
# ============================================================================

def check_environment():
    """Verify GPU and dependencies are available."""
    print("=" * 70)
    print("EVONY TRAINING - B200 GPU with Unsloth")
    print("=" * 70)
    
    import torch
    
    if not torch.cuda.is_available():
        print("❌ CUDA not available!")
        sys.exit(1)
    
    gpu_name = torch.cuda.get_device_name(0)
    gpu_memory = torch.cuda.get_device_properties(0).total_memory / 1e9
    
    print(f"✅ GPU: {gpu_name}")
    print(f"✅ Memory: {gpu_memory:.1f} GB")
    print(f"✅ PyTorch: {torch.__version__}")
    print(f"✅ CUDA: {torch.version.cuda}")
    
    return True

# ============================================================================
# SIGNAL HANDLERS FOR GRACEFUL SHUTDOWN
# ============================================================================

TRAINER = None
SHUTDOWN_REQUESTED = False

def emergency_save(reason="shutdown"):
    """Save model on emergency shutdown."""
    global TRAINER
    if TRAINER is None:
        print("⚠️ No trainer to save")
        return
    
    try:
        save_path = f"{CONFIG['output_dir']}/emergency_{reason}_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
        print(f"\n🚨 EMERGENCY SAVE: {save_path}")
        TRAINER.save_model(save_path)
        print(f"✅ Emergency save complete")
    except Exception as e:
        print(f"❌ Emergency save failed: {e}")

def signal_handler(signum, frame):
    """Handle shutdown signals gracefully."""
    global SHUTDOWN_REQUESTED
    SHUTDOWN_REQUESTED = True
    sig_name = signal.Signals(signum).name if hasattr(signal, 'Signals') else str(signum)
    print(f"\n⚠️ Received {sig_name} - saving checkpoint...")
    emergency_save(f"signal_{sig_name}")
    sys.exit(0)

def setup_signal_handlers():
    """Register signal handlers."""
    signal.signal(signal.SIGTERM, signal_handler)
    signal.signal(signal.SIGINT, signal_handler)
    if hasattr(signal, 'SIGHUP'):
        signal.signal(signal.SIGHUP, signal_handler)
    print("✅ Signal handlers registered for graceful shutdown")

# ============================================================================
# DATASET LOADING
# ============================================================================

def load_dataset_from_jsonl(path):
    """Load dataset from JSONL file with messages format."""
    from datasets import Dataset
    
    print(f"📚 Loading dataset: {path}")
    
    data = []
    with open(path, 'r', encoding='utf-8') as f:
        for line_num, line in enumerate(f, 1):
            line = line.strip()
            if not line:
                continue
            try:
                item = json.loads(line)
                # Validate messages format
                if 'messages' in item and isinstance(item['messages'], list):
                    data.append(item)
            except json.JSONDecodeError as e:
                print(f"⚠️ Skipping line {line_num}: {e}")
    
    print(f"✅ Loaded {len(data):,} examples")
    return Dataset.from_list(data)

# ============================================================================
# MAIN TRAINING FUNCTION
# ============================================================================

def train():
    """Main training function using Unsloth."""
    global TRAINER
    
    # Check environment first
    check_environment()
    setup_signal_handlers()
    
    print("\n" + "=" * 70)
    print("LOADING MODEL WITH UNSLOTH")
    print("=" * 70)
    
    # Import Unsloth
    try:
        from unsloth import FastLanguageModel
        print("✅ Unsloth imported successfully")
    except ImportError as e:
        print(f"❌ Unsloth not installed: {e}")
        print("Run: pip install unsloth")
        sys.exit(1)
    
    # Load model with Unsloth
    print(f"📦 Loading model: {CONFIG['model_name']}")
    
    model, tokenizer = FastLanguageModel.from_pretrained(
        model_name=CONFIG['model_name'],
        max_seq_length=CONFIG['max_seq_length'],
        load_in_4bit=CONFIG['load_in_4bit'],
        dtype=None,  # Auto-detect
    )
    
    print("✅ Model loaded")
    
    # Apply LoRA with Unsloth
    print("🔧 Applying LoRA adapters...")
    
    model = FastLanguageModel.get_peft_model(
        model,
        r=CONFIG['lora_r'],
        lora_alpha=CONFIG['lora_alpha'],
        lora_dropout=CONFIG['lora_dropout'],
        target_modules=CONFIG['lora_target_modules'],
        use_gradient_checkpointing=CONFIG['use_gradient_checkpointing'],
        random_state=42,
    )
    
    # Count trainable parameters
    trainable = sum(p.numel() for p in model.parameters() if p.requires_grad)
    total = sum(p.numel() for p in model.parameters())
    print(f"📊 Trainable: {trainable:,} / {total:,} ({100*trainable/total:.2f}%)")
    
    # Load dataset
    print("\n" + "=" * 70)
    print("LOADING DATASET")
    print("=" * 70)
    
    dataset = load_dataset_from_jsonl(CONFIG['dataset_path'])
    
    # Setup training
    print("\n" + "=" * 70)
    print("STARTING TRAINING")
    print("=" * 70)
    
    from trl import SFTTrainer, SFTConfig
    
    # Create output directory
    os.makedirs(CONFIG['output_dir'], exist_ok=True)
    
    # Training configuration (from official docs)
    training_args = SFTConfig(
        output_dir=CONFIG['output_dir'],
        
        # Batch settings
        per_device_train_batch_size=CONFIG['batch_size'],
        gradient_accumulation_steps=CONFIG['gradient_accumulation_steps'],
        
        # Learning rate
        learning_rate=CONFIG['learning_rate'],
        warmup_ratio=CONFIG['warmup_ratio'],
        lr_scheduler_type="cosine",
        weight_decay=CONFIG['weight_decay'],
        
        # Training duration
        num_train_epochs=CONFIG['num_epochs'],
        
        # Precision
        fp16=True,
        bf16=False,
        
        # Logging
        logging_steps=CONFIG['logging_steps'],
        logging_first_step=True,
        report_to="none",
        
        # Checkpointing
        save_steps=CONFIG['save_steps'],
        save_total_limit=CONFIG['save_total_limit'],
        save_safetensors=True,
        
        # Performance
        optim="adamw_8bit",
        gradient_checkpointing=CONFIG['use_gradient_checkpointing'],
        max_grad_norm=1.0,
        
        # Data
        max_seq_length=CONFIG['max_seq_length'],
        packing=True,  # Pack multiple examples for efficiency
        
        # Seed
        seed=42,
    )
    
    # Create trainer - SFTTrainer handles messages format automatically!
    TRAINER = SFTTrainer(
        model=model,
        processing_class=tokenizer,
        train_dataset=dataset,
        args=training_args,
    )
    
    print(f"⏱️ Training {CONFIG['num_epochs']} epochs")
    print(f"💾 Saving every {CONFIG['save_steps']} steps")
    print(f"💾 Keeping {CONFIG['save_total_limit']} checkpoints")
    print("🔥 Training started!")
    print("⚡ Graceful shutdown enabled - Ctrl+C or server stop will save")
    print("-" * 70)
    
    start_time = time.time()
    
    try:
        # Train
        train_result = TRAINER.train()
        
        # Save final model
        print("\n" + "=" * 70)
        print("SAVING FINAL MODEL")
        print("=" * 70)
        
        final_path = f"{CONFIG['output_dir']}/final"
        TRAINER.save_model(final_path)
        tokenizer.save_pretrained(final_path)
        print(f"✅ Model saved to: {final_path}")
        
        # Also save LoRA adapters separately for easy merging later
        lora_path = f"{CONFIG['output_dir']}/lora_adapters"
        model.save_pretrained(lora_path)
        print(f"✅ LoRA adapters saved to: {lora_path}")
        
        # Training complete
        elapsed = time.time() - start_time
        hours, remainder = divmod(elapsed, 3600)
        minutes, seconds = divmod(remainder, 60)
        
        print("\n" + "=" * 70)
        print("🎉 TRAINING COMPLETE!")
        print("=" * 70)
        print(f"⏱️ Total time: {int(hours)}h {int(minutes)}m {int(seconds)}s")
        print(f"📊 Final loss: {train_result.training_loss:.4f}")
        print(f"📁 Output: {CONFIG['output_dir']}")
        
        # Save training info
        info = {
            "model": CONFIG['model_name'],
            "dataset": CONFIG['dataset_path'],
            "examples": len(dataset),
            "epochs": CONFIG['num_epochs'],
            "final_loss": train_result.training_loss,
            "training_time_seconds": elapsed,
            "completed": datetime.now().isoformat(),
        }
        with open(f"{CONFIG['output_dir']}/training_info.json", 'w') as f:
            json.dump(info, f, indent=2)
        
        return train_result
        
    except KeyboardInterrupt:
        print("\n⚠️ Training interrupted by user")
        emergency_save("keyboard_interrupt")
        raise
    except Exception as e:
        print(f"\n❌ Training error: {e}")
        emergency_save(f"error_{type(e).__name__}")
        raise

# ============================================================================
# ENTRY POINT
# ============================================================================

if __name__ == "__main__":
    print("""
╔══════════════════════════════════════════════════════════════════════════════╗
║   ███████╗██╗   ██╗ ██████╗ ███╗   ██╗██╗   ██╗                              ║
║   ██╔════╝██║   ██║██╔═══██╗████╗  ██║╚██╗ ██╔╝                              ║
║   █████╗  ██║   ██║██║   ██║██╔██╗ ██║ ╚████╔╝                               ║
║   ██╔══╝  ╚██╗ ██╔╝██║   ██║██║╚██╗██║  ╚██╔╝                                ║
║   ███████╗ ╚████╔╝ ╚██████╔╝██║ ╚████║   ██║                                 ║
║   ╚══════╝  ╚═══╝   ╚═════╝ ╚═╝  ╚═══╝   ╚═╝                                 ║
║                                                                              ║
║   UNSLOTH TRAINING - B200 GPU OPTIMIZED                                      ║
║   Model: huihui-ai/Huihui-Qwen3-4B-Instruct-2507-abliterated                 ║
╚══════════════════════════════════════════════════════════════════════════════╝
    """)
    
    train()
