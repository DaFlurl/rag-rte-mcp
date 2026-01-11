#!/usr/bin/env python3
"""
🎮 EVONY PHASE 3 TRAINING - Simple (No Unsloth)
Uses standard transformers + PEFT for Windows compatibility
"""

import os
import sys
import json
import torch
from datetime import datetime
from pathlib import Path

print("=" * 60)
print("🎮 EVONY PHASE 3 TRAINING - RTX 3090")
print("=" * 60)

# Check GPU
if torch.cuda.is_available():
    gpu_name = torch.cuda.get_device_name(0)
    gpu_mem = torch.cuda.get_device_properties(0).total_memory / 1e9
    print(f"✅ GPU: {gpu_name} ({gpu_mem:.1f} GB)")
else:
    print("❌ No GPU!")
    sys.exit(1)

# ============================================================
# CONFIGURATION
# ============================================================

CONFIG = {
    "base_model": "./",  # Phase 2 model
    "output_dir": "./phase3_output",
    "train_file": "../training/train_final.jsonl",
    
    # LoRA
    "lora_r": 32,
    "lora_alpha": 64,
    "lora_dropout": 0.05,
    
    # Training (3090 optimized)
    "max_seq_length": 2048,  # Reduced for memory
    "batch_size": 1,
    "gradient_accumulation_steps": 16,
    "num_epochs": 3,
    "learning_rate": 1e-5,
    "warmup_ratio": 0.1,
    
    # Checkpoints
    "save_steps": 500,
    "logging_steps": 10,
}

# ============================================================
# DATA LOADING
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
    print("\n[1/6] Loading libraries...")
    from transformers import (
        AutoModelForCausalLM, 
        AutoTokenizer, 
        TrainingArguments,
        Trainer,
        DataCollatorForLanguageModeling,
    )
    from peft import LoraConfig, get_peft_model, prepare_model_for_kbit_training
    from datasets import Dataset
    
    print(f"\n[2/6] Loading Phase 2 model from: {CONFIG['base_model']}")
    
    # Load tokenizer
    tokenizer = AutoTokenizer.from_pretrained(CONFIG['base_model'])
    if tokenizer.pad_token is None:
        tokenizer.pad_token = tokenizer.eos_token
    
    # Load model with 4-bit quantization for 3090
    print("  Loading with 4-bit quantization...")
    from transformers import BitsAndBytesConfig
    
    bnb_config = BitsAndBytesConfig(
        load_in_4bit=True,
        bnb_4bit_quant_type="nf4",
        bnb_4bit_compute_dtype=torch.float16,
        bnb_4bit_use_double_quant=True,
    )
    
    model = AutoModelForCausalLM.from_pretrained(
        CONFIG['base_model'],
        quantization_config=bnb_config,
        device_map="auto",
        trust_remote_code=True,
    )
    
    print("\n[3/6] Adding LoRA adapter...")
    model = prepare_model_for_kbit_training(model)
    
    lora_config = LoraConfig(
        r=CONFIG['lora_r'],
        lora_alpha=CONFIG['lora_alpha'],
        lora_dropout=CONFIG['lora_dropout'],
        target_modules=["q_proj", "k_proj", "v_proj", "o_proj", 
                       "gate_proj", "up_proj", "down_proj"],
        bias="none",
        task_type="CAUSAL_LM",
    )
    
    model = get_peft_model(model, lora_config)
    model.print_trainable_parameters()
    
    print(f"\n[4/6] Loading training data: {CONFIG['train_file']}")
    raw_data = load_dataset(CONFIG['train_file'])
    print(f"  ✅ Loaded {len(raw_data):,} examples")
    
    # Format and tokenize
    formatted = []
    for ex in raw_data:
        try:
            text = format_example(ex, tokenizer)
            formatted.append({"text": text})
        except:
            pass
    
    print(f"  📊 Formatted {len(formatted):,} examples")
    
    # Tokenize
    def tokenize_function(examples):
        return tokenizer(
            examples["text"],
            truncation=True,
            max_length=CONFIG['max_seq_length'],
            padding="max_length",
        )
    
    dataset = Dataset.from_list(formatted)
    tokenized = dataset.map(tokenize_function, batched=True, remove_columns=["text"])
    split = tokenized.train_test_split(test_size=0.05, seed=42)
    
    print(f"  📊 {len(split['train']):,} train, {len(split['test']):,} val")
    
    # Calculate steps
    steps_per_epoch = len(split['train']) // (CONFIG['batch_size'] * CONFIG['gradient_accumulation_steps'])
    total_steps = steps_per_epoch * CONFIG['num_epochs']
    print(f"  📊 {total_steps:,} total steps")
    
    print("\n[5/6] Setting up trainer...")
    
    training_args = TrainingArguments(
        output_dir=CONFIG['output_dir'],
        num_train_epochs=CONFIG['num_epochs'],
        per_device_train_batch_size=CONFIG['batch_size'],
        gradient_accumulation_steps=CONFIG['gradient_accumulation_steps'],
        learning_rate=CONFIG['learning_rate'],
        warmup_ratio=CONFIG['warmup_ratio'],
        lr_scheduler_type="cosine",
        save_steps=CONFIG['save_steps'],
        save_total_limit=3,
        logging_steps=CONFIG['logging_steps'],
        fp16=True,
        optim="paged_adamw_8bit",
        gradient_checkpointing=True,
        report_to="none",
        remove_unused_columns=False,
    )
    
    data_collator = DataCollatorForLanguageModeling(tokenizer=tokenizer, mlm=False)
    
    trainer = Trainer(
        model=model,
        args=training_args,
        train_dataset=split['train'],
        eval_dataset=split['test'],
        data_collator=data_collator,
    )
    
    print("\n[6/6] 🚀 Starting training...")
    start_time = datetime.now()
    
    # Check for existing checkpoint to resume from
    import glob
    checkpoints = glob.glob(f"{CONFIG['output_dir']}/checkpoint-*")
    resume_from = None
    if checkpoints:
        resume_from = max(checkpoints, key=lambda x: int(x.split('-')[-1]))
        print(f"  📂 Resuming from: {resume_from}")
    
    trainer.train(resume_from_checkpoint=resume_from)
    
    elapsed = datetime.now() - start_time
    
    # Save
    print("\n💾 Saving LoRA adapter...")
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
    print(f"  - {CONFIG['output_dir']}/final_lora/")
    print(f"  - {CONFIG['output_dir']}/merged/")

if __name__ == "__main__":
    train()
