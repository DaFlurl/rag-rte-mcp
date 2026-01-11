#!/usr/bin/env python3
"""
Phase 3 Optimized Training - CVE Security Data
Train on merged Phase 2 model with increased LoRA rank for maximum quality
Output: F16 merged model for best inference quality
"""

import os
import json
import torch
from pathlib import Path
from datetime import datetime

# Paths - UPDATE THESE FOR YOUR RUNPOD
SCRIPT_DIR = Path(__file__).parent
DATA_DIR = SCRIPT_DIR / "data"
OUTPUT_DIR = Path("/workspace/output_phase3")  # RunPod path

# Phase 2 model as base (update path for RunPod)
BASE_MODEL = "/workspace/phase2_merged"  # Your Phase 2 merged model

# OPTIMIZED CONFIG for Phase 3
CONFIG = {
    "model_name": BASE_MODEL,
    "max_seq_length": 8192,
    "load_in_4bit": True,
    
    # INCREASED for more capacity
    "lora_r": 32,           # Was 16, now 32
    "lora_alpha": 64,       # Was 32, now 64
    "lora_dropout": 0.05,
    
    # Training params
    "num_epochs": 4,        # Was 3, now 4
    "batch_size": 1,
    "gradient_accumulation": 16,
    "learning_rate": 1e-5,  # Was 2e-5, slower for fine-tuning
    "warmup_ratio": 0.1,
    "output_dir": str(OUTPUT_DIR),
}


def check_gpu():
    """Check GPU availability"""
    if not torch.cuda.is_available():
        print("ERROR: CUDA not available!")
        return False
    
    gpu = torch.cuda.get_device_name(0)
    mem = torch.cuda.get_device_properties(0).total_memory / 1024**3
    print(f"GPU: {gpu} ({mem:.1f}GB)")
    return True


def load_cve_dataset():
    """Load CVE training data"""
    cve_file = SCRIPT_DIR / "train_cve_all.jsonl"
    
    if not cve_file.exists():
        print(f"ERROR: CVE data not found at {cve_file}")
        return None
    
    from datasets import load_dataset
    
    dataset = load_dataset("json", data_files={"train": str(cve_file)})
    
    # Split for validation (5%)
    split = dataset["train"].train_test_split(test_size=0.05, seed=42)
    
    print(f"CVE Train: {len(split['train'])} examples")
    print(f"CVE Val: {len(split['test'])} examples")
    
    return split["train"], split["test"]


def format_messages(example):
    """Format messages for ChatML training"""
    messages = example.get("messages", [])
    
    text = ""
    for msg in messages:
        role = msg.get("role", "")
        content = msg.get("content", "")
        
        if role == "system":
            text += f"<|im_start|>system\n{content}<|im_end|>\n"
        elif role == "user":
            text += f"<|im_start|>user\n{content}<|im_end|>\n"
        elif role == "assistant":
            text += f"<|im_start|>assistant\n{content}<|im_end|>\n"
    
    return {"text": text}


def main():
    print("="*60)
    print("PHASE 3 OPTIMIZED TRAINING - CVE SECURITY")
    print(f"Base Model: {CONFIG['model_name']}")
    print(f"LoRA Rank: {CONFIG['lora_r']} (increased)")
    print(f"Learning Rate: {CONFIG['learning_rate']} (slower)")
    print(f"Epochs: {CONFIG['num_epochs']}")
    print(f"Started: {datetime.now()}")
    print("="*60)
    
    if not check_gpu():
        return
    
    # Import Unsloth
    try:
        from unsloth import FastLanguageModel
        from unsloth import is_bfloat16_supported
    except ImportError:
        print("ERROR: Unsloth not installed!")
        print("Run: pip install unsloth")
        return
    
    from trl import SFTTrainer
    from transformers import TrainingArguments
    
    # Load CVE dataset
    print("\nLoading CVE dataset...")
    train_data, val_data = load_cve_dataset()
    if train_data is None:
        return
    
    # Format for training
    train_data = train_data.map(format_messages)
    val_data = val_data.map(format_messages)
    
    # Load Phase 2 model with Unsloth
    print(f"\nLoading base model: {CONFIG['model_name']}...")
    
    model, tokenizer = FastLanguageModel.from_pretrained(
        model_name=CONFIG["model_name"],
        max_seq_length=CONFIG["max_seq_length"],
        load_in_4bit=CONFIG["load_in_4bit"],
        dtype=None,
    )
    
    # Add LoRA adapters with INCREASED rank
    print(f"\nApplying LoRA adapters (r={CONFIG['lora_r']})...")
    
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
    
    # Training arguments
    OUTPUT_DIR.mkdir(exist_ok=True, parents=True)
    
    training_args = TrainingArguments(
        output_dir=CONFIG["output_dir"],
        num_train_epochs=CONFIG["num_epochs"],
        per_device_train_batch_size=CONFIG["batch_size"],
        per_device_eval_batch_size=CONFIG["batch_size"],
        gradient_accumulation_steps=CONFIG["gradient_accumulation"],
        learning_rate=CONFIG["learning_rate"],
        lr_scheduler_type="cosine",
        warmup_ratio=CONFIG["warmup_ratio"],
        weight_decay=0.01,
        logging_steps=10,
        eval_strategy="steps",
        eval_steps=100,
        save_strategy="steps",
        save_steps=200,
        save_total_limit=3,
        bf16=is_bfloat16_supported(),
        fp16=not is_bfloat16_supported(),
        optim="adamw_8bit",
        seed=42,
        report_to="tensorboard",
    )
    
    # Trainer
    trainer = SFTTrainer(
        model=model,
        tokenizer=tokenizer,
        train_dataset=train_data,
        eval_dataset=val_data,
        dataset_text_field="text",
        max_seq_length=CONFIG["max_seq_length"],
        args=training_args,
    )
    
    # Train
    print("\n" + "="*60)
    print("PHASE 3 TRAINING STARTED")
    print(f"CVE Examples: {len(train_data)}")
    print(f"Epochs: {CONFIG['num_epochs']}")
    print(f"Effective batch size: {CONFIG['batch_size'] * CONFIG['gradient_accumulation']}")
    print("="*60 + "\n")
    
    trainer.train()
    
    # Save LoRA adapter
    print("\nSaving LoRA adapter...")
    final_dir = OUTPUT_DIR / "final"
    final_dir.mkdir(exist_ok=True)
    
    model.save_pretrained(str(final_dir))
    tokenizer.save_pretrained(str(final_dir))
    
    # Save as merged F16 (BEST QUALITY)
    print("Saving merged F16 model (best quality)...")
    merged_dir = OUTPUT_DIR / "merged"
    merged_dir.mkdir(exist_ok=True)
    
    model.save_pretrained_merged(
        str(merged_dir),
        tokenizer,
        save_method="merged_16bit",  # F16 for best quality
    )
    
    print(f"\n{'='*60}")
    print("✅ PHASE 3 TRAINING COMPLETE")
    print(f"LoRA adapter: {final_dir}")
    print(f"Merged F16 model: {merged_dir}")
    print(f"Completed: {datetime.now()}")
    print("="*60)


if __name__ == "__main__":
    main()
