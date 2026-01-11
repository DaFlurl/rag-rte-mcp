#!/usr/bin/env python3
"""
Unsloth Training Script for Qwen2.5-VL-7B
Multi-task SFT + QLoRA - RTX 3090 Ti Optimized
"""

import os
import json
import torch
from pathlib import Path
from datetime import datetime

# Paths
SCRIPT_DIR = Path(__file__).parent
DATA_DIR = SCRIPT_DIR / "data"
OUTPUT_DIR = SCRIPT_DIR / "output"

# Training config optimized for RTX 3090 Ti (24GB)
CONFIG = {
    "model_name": "Qwen/Qwen2.5-VL-7B-Instruct",
    "max_seq_length": 8192,  # Safe for 24GB, can try 16384
    "load_in_4bit": True,
    "lora_r": 16,
    "lora_alpha": 32,
    "lora_dropout": 0.05,
    "num_epochs": 3,
    "batch_size": 1,
    "gradient_accumulation": 16,
    "learning_rate": 2e-5,
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


def load_dataset():
    """Load multi-task training data"""
    train_file = DATA_DIR / "train_multitask.jsonl"
    val_file = DATA_DIR / "val_multitask.jsonl"
    
    if not train_file.exists():
        print("ERROR: Training data not found!")
        print("Run: python prepare_multitask.py")
        return None, None
    
    from datasets import load_dataset
    
    dataset = load_dataset("json", data_files={
        "train": str(train_file),
        "validation": str(val_file) if val_file.exists() else str(train_file),
    })
    
    print(f"Train: {len(dataset['train'])} examples")
    print(f"Val: {len(dataset['validation'])} examples")
    
    return dataset["train"], dataset["validation"]


def format_messages(example):
    """Format messages for training"""
    messages = example.get("messages", [])
    
    # Build conversation string
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
    print("UNSLOTH MULTI-TASK SFT TRAINING")
    print(f"Model: {CONFIG['model_name']}")
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
    
    # Load dataset
    print("\nLoading dataset...")
    train_data, val_data = load_dataset()
    if train_data is None:
        return
    
    # Format for training
    train_data = train_data.map(format_messages)
    val_data = val_data.map(format_messages)
    
    # Load model with Unsloth
    print("\nLoading model with 4-bit quantization...")
    
    model, tokenizer = FastLanguageModel.from_pretrained(
        model_name=CONFIG["model_name"],
        max_seq_length=CONFIG["max_seq_length"],
        load_in_4bit=CONFIG["load_in_4bit"],
        dtype=None,  # Auto-detect
    )
    
    # Add LoRA adapters
    print("\nApplying LoRA adapters...")
    
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
    OUTPUT_DIR.mkdir(exist_ok=True)
    
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
        save_steps=100,
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
    print("TRAINING STARTED")
    print(f"Epochs: {CONFIG['num_epochs']}")
    print(f"Effective batch size: {CONFIG['batch_size'] * CONFIG['gradient_accumulation']}")
    print("="*60 + "\n")
    
    trainer.train()
    
    # Save
    print("\nSaving model...")
    final_dir = OUTPUT_DIR / "final"
    final_dir.mkdir(exist_ok=True)
    
    model.save_pretrained(str(final_dir))
    tokenizer.save_pretrained(str(final_dir))
    
    # Also save as merged (optional, for easier inference)
    print("Saving merged model...")
    merged_dir = OUTPUT_DIR / "merged"
    merged_dir.mkdir(exist_ok=True)
    
    model.save_pretrained_merged(
        str(merged_dir),
        tokenizer,
        save_method="merged_16bit",
    )
    
    print(f"\n✅ TRAINING COMPLETE")
    print(f"LoRA adapter: {final_dir}")
    print(f"Merged model: {merged_dir}")
    print(f"Completed: {datetime.now()}")


if __name__ == "__main__":
    main()
