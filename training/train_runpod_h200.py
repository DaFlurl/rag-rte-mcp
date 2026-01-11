#!/usr/bin/env python3
"""
RunPod H200 SXM Training Script - 3 Milestone Approach
Budget: ~3 hours @ $3.59/hr ≈ $11

Based on ChatGPT-corrected Phase 3 strategy:
- Milestone 1: Foundation (Enums + Protocol + Grounding)
- Milestone 2: Application (GUI + Scripting + Multi-turn)  
- Milestone 3: Security (CVE defensive + Cross-domain)

Optimal H200 Settings:
- max_seq_length = 8192
- micro_batch_size = 2
- grad_accum = 8
- Target: 6,000-10,000 steps in 3 hours
"""

import os
import json
import torch
from pathlib import Path
from datetime import datetime

# ============================================================
# CONFIGURATION
# ============================================================

CONFIG = {
    # Model
    "base_model": "Qwen/Qwen2.5-VL-7B-Instruct",  # Or your Phase 2 merged model
    "output_dir": "./evony_phase3_checkpoints",
    
    # LoRA (ChatGPT + Claude agreed)
    "lora_r": 32,
    "lora_alpha": 64,
    "lora_dropout": 0.05,
    "target_modules": ["q_proj", "k_proj", "v_proj", "o_proj", 
                       "gate_proj", "up_proj", "down_proj"],
    
    # Training (H200 optimized)
    "max_seq_length": 8192,
    "micro_batch_size": 2,
    "gradient_accumulation_steps": 8,
    "num_epochs": 4,
    "learning_rate": 1e-5,
    "warmup_ratio": 0.1,
    "weight_decay": 0.01,
    "lr_scheduler_type": "cosine",
    
    # Checkpoints
    "save_steps": 500,
    "save_total_limit": 5,
    "logging_steps": 10,
    
    # Performance
    "use_flash_attention": True,
    "gradient_checkpointing": True,
    "bf16": True,
    "packing": False,  # OFF for VL models
    
    # Data
    "train_file": "train_final.jsonl",
    "val_split": 0.05,
}

# ============================================================
# SPEED GUARDRAILS (from RunPod Runbook)
# ============================================================

GUARDRAILS = {
    "min_steps_per_sec": 0.25,  # STOP if below this
    "good_steps_per_sec": 0.6,  # Continue if above this
    "target_steps_3hr": 6000,   # Minimum acceptable
    "excellent_steps_3hr": 10000,
}

def check_speed(steps, elapsed_seconds):
    """Check if training speed is acceptable"""
    if elapsed_seconds < 60:
        return "WARMUP"
    
    steps_per_sec = steps / elapsed_seconds
    
    if steps_per_sec < GUARDRAILS["min_steps_per_sec"]:
        return f"TOO_SLOW ({steps_per_sec:.3f} steps/sec) - STOP IMMEDIATELY"
    elif steps_per_sec >= GUARDRAILS["good_steps_per_sec"]:
        return f"GOOD ({steps_per_sec:.3f} steps/sec)"
    else:
        return f"BORDERLINE ({steps_per_sec:.3f} steps/sec) - Consider adjusting"

# ============================================================
# DATA LOADING
# ============================================================

def load_dataset(filepath):
    """Load JSONL dataset, handle both ChatML and Alpaca formats"""
    examples = []
    with open(filepath, 'r', encoding='utf-8') as f:
        for line in f:
            if line.strip():
                try:
                    ex = json.loads(line)
                    examples.append(ex)
                except:
                    pass
    return examples

def format_example(ex, tokenizer):
    """Format example for training"""
    if 'messages' in ex:
        # ChatML format
        text = tokenizer.apply_chat_template(ex['messages'], tokenize=False)
    else:
        # Alpaca format - convert to ChatML
        messages = [
            {"role": "user", "content": ex.get('instruction', '')},
            {"role": "assistant", "content": ex.get('output', '')}
        ]
        if ex.get('input'):
            messages[0]["content"] += f"\n\nContext: {ex['input']}"
        text = tokenizer.apply_chat_template(messages, tokenize=False)
    return text

# ============================================================
# MAIN TRAINING FUNCTION
# ============================================================

def train():
    """Main training function for RunPod H200"""
    
    print("=" * 60)
    print("EVONY PHASE 3 TRAINING - RUNPOD H200")
    print("=" * 60)
    print(f"Started: {datetime.now()}")
    print(f"Config: {json.dumps(CONFIG, indent=2)}")
    
    # Check GPU
    if torch.cuda.is_available():
        gpu_name = torch.cuda.get_device_name(0)
        gpu_mem = torch.cuda.get_device_properties(0).total_memory / 1e9
        print(f"\nGPU: {gpu_name} ({gpu_mem:.1f} GB)")
    else:
        print("\n⚠️ No GPU detected!")
        return
    
    # Import training libraries
    try:
        from unsloth import FastLanguageModel
        from trl import SFTTrainer
        from transformers import TrainingArguments
        from datasets import Dataset
        print("✅ Unsloth + TRL loaded")
    except ImportError as e:
        print(f"❌ Import error: {e}")
        print("Run: pip install unsloth trl datasets")
        return
    
    # Load model
    print(f"\n[1/5] Loading model: {CONFIG['base_model']}")
    model, tokenizer = FastLanguageModel.from_pretrained(
        model_name=CONFIG['base_model'],
        max_seq_length=CONFIG['max_seq_length'],
        dtype=torch.bfloat16 if CONFIG['bf16'] else torch.float16,
        load_in_4bit=False,
    )
    
    # Add LoRA adapters
    print(f"\n[2/5] Adding LoRA adapters (r={CONFIG['lora_r']}, α={CONFIG['lora_alpha']})")
    model = FastLanguageModel.get_peft_model(
        model,
        r=CONFIG['lora_r'],
        lora_alpha=CONFIG['lora_alpha'],
        lora_dropout=CONFIG['lora_dropout'],
        target_modules=CONFIG['target_modules'],
        use_gradient_checkpointing=CONFIG['gradient_checkpointing'],
    )
    
    # Load dataset
    print(f"\n[3/5] Loading dataset: {CONFIG['train_file']}")
    raw_data = load_dataset(CONFIG['train_file'])
    print(f"Loaded {len(raw_data)} examples")
    
    # Format for training
    formatted = []
    for ex in raw_data:
        try:
            text = format_example(ex, tokenizer)
            formatted.append({"text": text})
        except:
            pass
    
    print(f"Formatted {len(formatted)} examples")
    
    # Create dataset
    dataset = Dataset.from_list(formatted)
    
    # Split train/val
    if CONFIG['val_split'] > 0:
        split = dataset.train_test_split(test_size=CONFIG['val_split'], seed=42)
        train_dataset = split['train']
        val_dataset = split['test']
        print(f"Train: {len(train_dataset)}, Val: {len(val_dataset)}")
    else:
        train_dataset = dataset
        val_dataset = None
    
    # Training arguments
    print(f"\n[4/5] Setting up training...")
    training_args = TrainingArguments(
        output_dir=CONFIG['output_dir'],
        num_train_epochs=CONFIG['num_epochs'],
        per_device_train_batch_size=CONFIG['micro_batch_size'],
        gradient_accumulation_steps=CONFIG['gradient_accumulation_steps'],
        learning_rate=CONFIG['learning_rate'],
        warmup_ratio=CONFIG['warmup_ratio'],
        weight_decay=CONFIG['weight_decay'],
        lr_scheduler_type=CONFIG['lr_scheduler_type'],
        save_steps=CONFIG['save_steps'],
        save_total_limit=CONFIG['save_total_limit'],
        logging_steps=CONFIG['logging_steps'],
        bf16=CONFIG['bf16'],
        optim="adamw_8bit",
        seed=42,
        report_to="none",
    )
    
    # Create trainer
    trainer = SFTTrainer(
        model=model,
        tokenizer=tokenizer,
        train_dataset=train_dataset,
        eval_dataset=val_dataset,
        args=training_args,
        dataset_text_field="text",
        max_seq_length=CONFIG['max_seq_length'],
        packing=CONFIG['packing'],
    )
    
    # Train!
    print(f"\n[5/5] Starting training...")
    print("=" * 60)
    
    start_time = datetime.now()
    trainer.train()
    end_time = datetime.now()
    
    elapsed = (end_time - start_time).total_seconds()
    print(f"\n✅ Training complete!")
    print(f"Duration: {elapsed/3600:.2f} hours")
    print(f"Speed: {check_speed(trainer.state.global_step, elapsed)}")
    
    # Save final model
    print(f"\n[SAVE] Saving final model...")
    model.save_pretrained(f"{CONFIG['output_dir']}/final_lora")
    tokenizer.save_pretrained(f"{CONFIG['output_dir']}/final_lora")
    
    # Merge and save F16
    print(f"\n[MERGE] Merging to F16...")
    merged_model = model.merge_and_unload()
    merged_model.save_pretrained(f"{CONFIG['output_dir']}/merged_f16")
    tokenizer.save_pretrained(f"{CONFIG['output_dir']}/merged_f16")
    
    print(f"\n✅ All done!")
    print(f"LoRA adapter: {CONFIG['output_dir']}/final_lora")
    print(f"Merged F16: {CONFIG['output_dir']}/merged_f16")

# ============================================================
# GGUF CONVERSION
# ============================================================

def convert_to_gguf():
    """Convert merged model to GGUF format"""
    import subprocess
    
    merged_path = f"{CONFIG['output_dir']}/merged_f16"
    gguf_path = f"{CONFIG['output_dir']}/evony-expert-v3-f16.gguf"
    
    print(f"\n[GGUF] Converting to GGUF...")
    
    # Use llama.cpp convert script
    cmd = [
        "python", "-m", "llama_cpp.convert",
        merged_path,
        "--outfile", gguf_path,
        "--outtype", "f16"
    ]
    
    try:
        subprocess.run(cmd, check=True)
        print(f"✅ GGUF saved to: {gguf_path}")
    except Exception as e:
        print(f"❌ GGUF conversion failed: {e}")
        print("Try manually with llama.cpp convert.py")

# ============================================================
# ENTRY POINT
# ============================================================

if __name__ == "__main__":
    import sys
    
    if len(sys.argv) > 1 and sys.argv[1] == "--gguf":
        convert_to_gguf()
    else:
        train()
