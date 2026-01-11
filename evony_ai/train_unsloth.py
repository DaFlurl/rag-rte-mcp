"""
Evony AI - Unsloth Training Script
===================================
Optimized for RTX 3090 Ti (24GB VRAM)
Uses Unsloth for 2x faster training with 60% less memory.
"""

import os
import json
import torch
from pathlib import Path
from datetime import datetime

# Unsloth imports
from unsloth import FastLanguageModel
from unsloth import is_bfloat16_supported
from trl import SFTTrainer
from transformers import TrainingArguments
from datasets import load_dataset

# Configuration
class Config:
    # Paths
    DATA_PATH = Path("c:/Users/Admin/Downloads/Evony_Decrypted/Evony_Training_Data")
    OUTPUT_DIR = Path("c:/Users/Admin/Downloads/Evony_Decrypted/evony_ai/output")
    
    # Model - Best 3B models for instruction following
    MODEL_OPTIONS = {
        "qwen2.5-3b": "unsloth/Qwen2.5-3B-Instruct",
        "llama3.2-3b": "unsloth/Llama-3.2-3B-Instruct", 
        "phi3.5-mini": "unsloth/Phi-3.5-mini-instruct",
    }
    MODEL_NAME = MODEL_OPTIONS["qwen2.5-3b"]  # Best for code understanding
    
    # Training parameters optimized for RTX 3090 Ti
    MAX_SEQ_LENGTH = 2048
    LOAD_IN_4BIT = True
    
    # LoRA parameters
    LORA_R = 64
    LORA_ALPHA = 128
    LORA_DROPOUT = 0.05
    TARGET_MODULES = [
        "q_proj", "k_proj", "v_proj", "o_proj",
        "gate_proj", "up_proj", "down_proj",
    ]
    
    # Training hyperparameters
    BATCH_SIZE = 4
    GRADIENT_ACCUMULATION = 4  # Effective batch size = 16
    LEARNING_RATE = 2e-4
    NUM_EPOCHS = 3
    WARMUP_RATIO = 0.1
    WEIGHT_DECAY = 0.01
    
    # Optimization
    USE_GRADIENT_CHECKPOINTING = True
    OPTIMIZER = "adamw_8bit"


def format_prompt(example):
    """Format example into Alpaca-style prompt."""
    instruction = example.get("instruction", "")
    input_text = example.get("input", "")
    output = example.get("output", "")
    
    if input_text:
        prompt = f"""### Instruction:
{instruction}

### Input:
{input_text}

### Response:
{output}"""
    else:
        prompt = f"""### Instruction:
{instruction}

### Response:
{output}"""
    
    return {"text": prompt}


def load_model():
    """Load model with Unsloth optimizations."""
    print(f"\n{'='*60}")
    print("LOADING MODEL: {Config.MODEL_NAME}")
    print(f"{'='*60}")
    
    model, tokenizer = FastLanguageModel.from_pretrained(
        model_name=Config.MODEL_NAME,
        max_seq_length=Config.MAX_SEQ_LENGTH,
        dtype=None,  # Auto-detect
        load_in_4bit=Config.LOAD_IN_4BIT,
    )
    
    # Add LoRA adapters
    model = FastLanguageModel.get_peft_model(
        model,
        r=Config.LORA_R,
        target_modules=Config.TARGET_MODULES,
        lora_alpha=Config.LORA_ALPHA,
        lora_dropout=Config.LORA_DROPOUT,
        bias="none",
        use_gradient_checkpointing=Config.USE_GRADIENT_CHECKPOINTING,
        random_state=42,
    )
    
    print(f"Model loaded with LoRA (r={Config.LORA_R})")
    return model, tokenizer


def load_data():
    """Load training data."""
    print(f"\n{'='*60}")
    print("LOADING TRAINING DATA")
    print(f"{'='*60}")
    
    train_path = Config.DATA_PATH / "train.json"
    val_path = Config.DATA_PATH / "val.json"
    
    dataset = load_dataset("json", data_files={
        "train": str(train_path),
        "validation": str(val_path),
    })
    
    # Format prompts
    dataset = dataset.map(format_prompt)
    
    print(f"Train examples: {len(dataset['train'])}")
    print(f"Validation examples: {len(dataset['validation'])}")
    
    return dataset


def train(model, tokenizer, dataset):
    """Run training."""
    print(f"\n{'='*60}")
    print("STARTING TRAINING")
    print(f"{'='*60}")
    
    Config.OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    
    # Training arguments
    training_args = TrainingArguments(
        output_dir=str(Config.OUTPUT_DIR),
        num_train_epochs=Config.NUM_EPOCHS,
        per_device_train_batch_size=Config.BATCH_SIZE,
        gradient_accumulation_steps=Config.GRADIENT_ACCUMULATION,
        learning_rate=Config.LEARNING_RATE,
        warmup_ratio=Config.WARMUP_RATIO,
        weight_decay=Config.WEIGHT_DECAY,
        optim=Config.OPTIMIZER,
        fp16=not is_bfloat16_supported(),
        bf16=is_bfloat16_supported(),
        logging_steps=10,
        save_strategy="steps",
        save_steps=500,
        eval_strategy="steps",
        eval_steps=500,
        save_total_limit=3,
        load_best_model_at_end=True,
        report_to="none",
        seed=42,
    )
    
    # Create trainer
    trainer = SFTTrainer(
        model=model,
        tokenizer=tokenizer,
        train_dataset=dataset["train"],
        eval_dataset=dataset["validation"],
        dataset_text_field="text",
        max_seq_length=Config.MAX_SEQ_LENGTH,
        args=training_args,
    )
    
    # Print training info
    total_steps = len(dataset["train"]) // (Config.BATCH_SIZE * Config.GRADIENT_ACCUMULATION) * Config.NUM_EPOCHS
    print(f"Batch size: {Config.BATCH_SIZE}")
    print(f"Gradient accumulation: {Config.GRADIENT_ACCUMULATION}")
    print(f"Effective batch size: {Config.BATCH_SIZE * Config.GRADIENT_ACCUMULATION}")
    print(f"Total steps: ~{total_steps}")
    print(f"Epochs: {Config.NUM_EPOCHS}")
    
    # Train
    print("\nTraining started...")
    train_result = trainer.train()
    
    # Save final model
    print("\nSaving model...")
    model.save_pretrained(Config.OUTPUT_DIR / "final_model")
    tokenizer.save_pretrained(Config.OUTPUT_DIR / "final_model")
    
    # Save training stats
    stats = {
        "train_loss": train_result.training_loss,
        "train_runtime": train_result.metrics.get("train_runtime"),
        "train_samples_per_second": train_result.metrics.get("train_samples_per_second"),
        "completed": datetime.now().isoformat(),
    }
    
    with open(Config.OUTPUT_DIR / "training_stats.json", "w") as f:
        json.dump(stats, f, indent=2)
    
    print(f"\n{'='*60}")
    print("TRAINING COMPLETE")
    print(f"{'='*60}")
    print(f"Model saved to: {Config.OUTPUT_DIR / 'final_model'}")
    print(f"Training loss: {train_result.training_loss:.4f}")
    
    return trainer


def main():
    """Main training pipeline."""
    print("\n" + "="*60)
    print("EVONY AI - UNSLOTH TRAINING")
    print("="*60)
    print(f"GPU: {torch.cuda.get_device_name(0)}")
    print(f"VRAM: {torch.cuda.get_device_properties(0).total_memory / 1e9:.1f} GB")
    print(f"Model: {Config.MODEL_NAME}")
    
    # Load model
    model, tokenizer = load_model()
    
    # Load data
    dataset = load_data()
    
    # Train
    trainer = train(model, tokenizer, dataset)
    
    print("\nDone! Run inference.py to chat with your trained model.")


if __name__ == "__main__":
    main()
