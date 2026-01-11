#!/usr/bin/env python3
"""
🎮 EVONY PHASE 3 TRAINING - RTX 3090 (24GB)
Continues from Phase 2 model with Phase 3 data
"""

import os
import sys
import json
import torch
from pathlib import Path
from datetime import datetime

# ============================================================
# 3090 OPTIMIZED CONFIGURATION
# ============================================================

CONFIG = {
    # Use Phase 2 as base (local folder)
    "base_model": "./",  # Current folder contains Phase 2 model
    "output_dir": "./phase3_output",
    "train_file": "../training/train_final.jsonl",  # Phase 3 data
    
    # LoRA settings
    "lora_r": 32,
    "lora_alpha": 64,
    "lora_dropout": 0.05,
    "target_modules": ["q_proj", "k_proj", "v_proj", "o_proj", 
                       "gate_proj", "up_proj", "down_proj"],
    
    # 3090 optimized (24GB VRAM)
    "max_seq_length": 4096,  # Reduced from 8192 for 3090
    "micro_batch_size": 1,   # Small batch for 3090
    "gradient_accumulation_steps": 16,  # Effective batch = 16
    "num_epochs": 3,
    "learning_rate": 1e-5,
    "warmup_ratio": 0.1,
    "lr_scheduler_type": "cosine",
    
    # Checkpoints
    "save_steps": 500,
    "save_total_limit": 3,
    "logging_steps": 10,
    
    # Memory optimization
    "load_in_4bit": True,  # 4-bit quantization for 3090
    "bf16": False,  # 3090 uses fp16 not bf16
    "fp16": True,
    "packing": False,
}

print("=" * 60)
print("🎮 EVONY PHASE 3 TRAINING - RTX 3090")
print("=" * 60)

# Check GPU
if torch.cuda.is_available():
    gpu_name = torch.cuda.get_device_name(0)
    gpu_mem = torch.cuda.get_device_properties(0).total_memory / 1e9
    print(f"✅ GPU: {gpu_name} ({gpu_mem:.1f} GB)")
else:
    print("❌ No GPU detected!")
    sys.exit(1)

# ============================================================
# LOAD DATA
# ============================================================

def load_dataset(filepath):
    """Load JSONL dataset"""
    examples = []
    with open(filepath, 'r', encoding='utf-8') as f:
        for line in f:
            if line.strip():
                try:
                    examples.append(json.loads(line))
                except:
                    pass
    return examples

def format_example(ex, tokenizer):
    """Format for training"""
    if 'messages' in ex:
        return tokenizer.apply_chat_template(ex['messages'], tokenize=False)
    else:
        messages = [
            {"role": "user", "content": ex.get('instruction', '')},
            {"role": "assistant", "content": ex.get('output', '')}
        ]
        if ex.get('input'):
            messages[0]["content"] += f"\n\nContext: {ex['input']}"
        return tokenizer.apply_chat_template(messages, tokenize=False)

# ============================================================
# MAIN TRAINING
# ============================================================

def train():
    print("\n[1/5] Installing dependencies...")
    os.system("pip install -q unsloth trl datasets transformers accelerate bitsandbytes")
    
    print("\n[2/5] Loading Unsloth...")
    from unsloth import FastLanguageModel
    from trl import SFTTrainer
    from transformers import TrainingArguments
    from datasets import Dataset
    
    print(f"\n[3/5] Loading Phase 2 model from: {CONFIG['base_model']}")
    model, tokenizer = FastLanguageModel.from_pretrained(
        model_name=CONFIG['base_model'],
        max_seq_length=CONFIG['max_seq_length'],
        dtype=torch.float16,
        load_in_4bit=CONFIG['load_in_4bit'],
    )
    
    print(f"  Adding LoRA (r={CONFIG['lora_r']}, α={CONFIG['lora_alpha']})")
    model = FastLanguageModel.get_peft_model(
        model,
        r=CONFIG['lora_r'],
        lora_alpha=CONFIG['lora_alpha'],
        lora_dropout=CONFIG['lora_dropout'],
        target_modules=CONFIG['target_modules'],
        use_gradient_checkpointing="unsloth",
    )
    
    print(f"\n[4/5] Loading training data: {CONFIG['train_file']}")
    raw_data = load_dataset(CONFIG['train_file'])
    print(f"  ✅ Loaded {len(raw_data):,} examples")
    
    # Format
    formatted = []
    for ex in raw_data:
        try:
            formatted.append({"text": format_example(ex, tokenizer)})
        except:
            pass
    
    dataset = Dataset.from_list(formatted)
    split = dataset.train_test_split(test_size=0.05, seed=42)
    print(f"  📊 {len(split['train']):,} train, {len(split['test']):,} val")
    
    # Calculate steps
    steps_per_epoch = len(split['train']) // (CONFIG['micro_batch_size'] * CONFIG['gradient_accumulation_steps'])
    total_steps = steps_per_epoch * CONFIG['num_epochs']
    print(f"  📊 {total_steps:,} total steps ({steps_per_epoch:,}/epoch × {CONFIG['num_epochs']} epochs)")
    
    # Training args (3090 optimized)
    training_args = TrainingArguments(
        output_dir=CONFIG['output_dir'],
        num_train_epochs=CONFIG['num_epochs'],
        per_device_train_batch_size=CONFIG['micro_batch_size'],
        gradient_accumulation_steps=CONFIG['gradient_accumulation_steps'],
        learning_rate=CONFIG['learning_rate'],
        warmup_ratio=CONFIG['warmup_ratio'],
        lr_scheduler_type=CONFIG['lr_scheduler_type'],
        save_steps=CONFIG['save_steps'],
        save_total_limit=CONFIG['save_total_limit'],
        logging_steps=CONFIG['logging_steps'],
        fp16=CONFIG['fp16'],
        bf16=CONFIG['bf16'],
        optim="adamw_8bit",
        seed=42,
        report_to="none",
        gradient_checkpointing=True,
    )
    
    # Trainer
    trainer = SFTTrainer(
        model=model,
        tokenizer=tokenizer,
        train_dataset=split['train'],
        eval_dataset=split['test'],
        args=training_args,
        dataset_text_field="text",
        max_seq_length=CONFIG['max_seq_length'],
        packing=CONFIG['packing'],
    )
    
    print("\n[5/5] 🚀 Starting training...")
    print(f"  Output: {CONFIG['output_dir']}")
    start_time = datetime.now()
    
    trainer.train()
    
    elapsed = datetime.now() - start_time
    print(f"\n✅ Training complete! Duration: {elapsed}")
    
    # Save
    print("\n💾 Saving model...")
    model.save_pretrained(f"{CONFIG['output_dir']}/final_lora")
    tokenizer.save_pretrained(f"{CONFIG['output_dir']}/final_lora")
    
    # Merge
    print("🔄 Merging to full model...")
    merged = model.merge_and_unload()
    merged.save_pretrained(f"{CONFIG['output_dir']}/merged")
    tokenizer.save_pretrained(f"{CONFIG['output_dir']}/merged")
    
    print("\n" + "=" * 60)
    print("✅ PHASE 3 TRAINING COMPLETE!")
    print("=" * 60)
    print(f"Duration: {elapsed}")
    print(f"\nOutput:")
    print(f"  - {CONFIG['output_dir']}/final_lora/ (LoRA adapter)")
    print(f"  - {CONFIG['output_dir']}/merged/ (Full model)")

if __name__ == "__main__":
    train()
