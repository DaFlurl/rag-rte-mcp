#!/usr/bin/env python3
"""
Evony Model Training Script
Fine-tune Qwen2.5-VL-7B-Instruct with QLoRA on RTX 3090 Ti
"""

import os
import sys
import json
import torch
from pathlib import Path
from datetime import datetime

# Paths
SCRIPT_DIR = Path(__file__).parent
MODEL_DIR = SCRIPT_DIR / "models" / "qwen2.5-vl-7b"
DATA_DIR = SCRIPT_DIR / "data"
OUTPUT_DIR = SCRIPT_DIR / "output"

# Training config for RTX 3090 Ti (24GB VRAM)
CONFIG = {
    "model_name": str(MODEL_DIR),
    "output_dir": str(OUTPUT_DIR),
    "num_epochs": 3,
    "batch_size": 1,
    "gradient_accumulation": 16,
    "learning_rate": 2e-5,
    "max_length": 2048,
    "lora_r": 16,
    "lora_alpha": 32,
    "lora_dropout": 0.05,
}


def check_requirements():
    """Check all requirements are met"""
    print("Checking requirements...")
    
    # Check CUDA
    if not torch.cuda.is_available():
        print("ERROR: CUDA not available!")
        return False
    
    gpu_name = torch.cuda.get_device_name(0)
    gpu_mem = torch.cuda.get_device_properties(0).total_memory / 1024**3
    print(f"  GPU: {gpu_name} ({gpu_mem:.1f}GB)")
    
    # Check model
    if not MODEL_DIR.exists():
        print(f"ERROR: Model not found at {MODEL_DIR}")
        print("Run: python download_model.py")
        return False
    print(f"  Model: {MODEL_DIR}")
    
    # Check data
    train_file = DATA_DIR / "train_qwen.jsonl"
    if not train_file.exists():
        print(f"ERROR: Training data not found at {train_file}")
        print("Run: python prepare_data.py")
        return False
    print(f"  Data: {train_file}")
    
    return True


def load_model_and_tokenizer():
    """Load model with QLoRA quantization"""
    from transformers import AutoModelForCausalLM, AutoTokenizer, BitsAndBytesConfig
    from peft import LoraConfig, get_peft_model, prepare_model_for_kbit_training
    
    print("\nLoading model with 4-bit quantization...")
    
    # Quantization config
    bnb_config = BitsAndBytesConfig(
        load_in_4bit=True,
        bnb_4bit_quant_type="nf4",
        bnb_4bit_compute_dtype=torch.bfloat16,
        bnb_4bit_use_double_quant=True,
    )
    
    # Load tokenizer
    tokenizer = AutoTokenizer.from_pretrained(
        CONFIG["model_name"],
        trust_remote_code=True,
    )
    
    if tokenizer.pad_token is None:
        tokenizer.pad_token = tokenizer.eos_token
    
    # Load model
    model = AutoModelForCausalLM.from_pretrained(
        CONFIG["model_name"],
        quantization_config=bnb_config,
        device_map="auto",
        trust_remote_code=True,
        torch_dtype=torch.bfloat16,
    )
    
    # Prepare for k-bit training
    model = prepare_model_for_kbit_training(model)
    
    # LoRA config
    lora_config = LoraConfig(
        r=CONFIG["lora_r"],
        lora_alpha=CONFIG["lora_alpha"],
        lora_dropout=CONFIG["lora_dropout"],
        target_modules=["q_proj", "k_proj", "v_proj", "o_proj", "gate_proj", "up_proj", "down_proj"],
        bias="none",
        task_type="CAUSAL_LM",
    )
    
    # Apply LoRA
    model = get_peft_model(model, lora_config)
    
    trainable, total = model.get_nb_trainable_parameters()
    print(f"  Trainable: {trainable:,} / {total:,} ({100*trainable/total:.2f}%)")
    
    return model, tokenizer


def load_dataset(tokenizer):
    """Load and tokenize dataset"""
    from datasets import load_dataset
    
    print("\nLoading dataset...")
    
    train_file = str(DATA_DIR / "train_qwen.jsonl")
    val_file = str(DATA_DIR / "val_qwen.jsonl")
    
    dataset = load_dataset("json", data_files={
        "train": train_file,
        "validation": val_file,
    })
    
    print(f"  Train: {len(dataset['train'])} examples")
    print(f"  Val: {len(dataset['validation'])} examples")
    
    def format_example(example):
        """Format messages into text"""
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
    
    dataset = dataset.map(format_example)
    
    def tokenize(example):
        return tokenizer(
            example["text"],
            truncation=True,
            max_length=CONFIG["max_length"],
            padding="max_length",
        )
    
    tokenized = dataset.map(tokenize, remove_columns=dataset["train"].column_names)
    
    return tokenized


def train(model, tokenizer, dataset):
    """Run training"""
    from transformers import TrainingArguments, Trainer, DataCollatorForLanguageModeling
    
    print("\nStarting training...")
    print(f"  Epochs: {CONFIG['num_epochs']}")
    print(f"  Batch size: {CONFIG['batch_size']}")
    print(f"  Gradient accumulation: {CONFIG['gradient_accumulation']}")
    print(f"  Effective batch: {CONFIG['batch_size'] * CONFIG['gradient_accumulation']}")
    
    OUTPUT_DIR.mkdir(exist_ok=True)
    
    training_args = TrainingArguments(
        output_dir=str(OUTPUT_DIR),
        num_train_epochs=CONFIG["num_epochs"],
        per_device_train_batch_size=CONFIG["batch_size"],
        per_device_eval_batch_size=CONFIG["batch_size"],
        gradient_accumulation_steps=CONFIG["gradient_accumulation"],
        learning_rate=CONFIG["learning_rate"],
        lr_scheduler_type="cosine",
        warmup_ratio=0.1,
        weight_decay=0.01,
        logging_steps=10,
        eval_strategy="steps",
        eval_steps=100,
        save_strategy="steps",
        save_steps=100,
        save_total_limit=3,
        bf16=True,
        gradient_checkpointing=True,
        optim="adamw_torch",
        report_to="tensorboard",
        load_best_model_at_end=True,
        metric_for_best_model="eval_loss",
    )
    
    data_collator = DataCollatorForLanguageModeling(
        tokenizer=tokenizer,
        mlm=False,
    )
    
    trainer = Trainer(
        model=model,
        args=training_args,
        train_dataset=dataset["train"],
        eval_dataset=dataset["validation"],
        data_collator=data_collator,
    )
    
    # Train
    print("\n" + "="*60)
    print("TRAINING STARTED")
    print("="*60)
    
    trainer.train()
    
    # Save
    print("\nSaving model...")
    trainer.save_model(str(OUTPUT_DIR / "final"))
    tokenizer.save_pretrained(str(OUTPUT_DIR / "final"))
    
    print(f"\n✅ TRAINING COMPLETE")
    print(f"Model saved to: {OUTPUT_DIR / 'final'}")


def main():
    print("="*60)
    print("EVONY MODEL TRAINING")
    print(f"Started: {datetime.now()}")
    print("="*60)
    
    if not check_requirements():
        sys.exit(1)
    
    model, tokenizer = load_model_and_tokenizer()
    dataset = load_dataset(tokenizer)
    train(model, tokenizer, dataset)
    
    print(f"\nCompleted: {datetime.now()}")


if __name__ == "__main__":
    main()
