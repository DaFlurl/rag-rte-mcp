#!/usr/bin/env python3
"""
🎮 EVONY PHASE 3 TRAINING - FAST VERSION
Optimized for quick startup on Windows
"""

import os
import sys
import json
import torch
from datetime import datetime

print("=" * 60)
print("🎮 EVONY PHASE 3 TRAINING - FAST")
print("=" * 60)

# Check GPU
if torch.cuda.is_available():
    print(f"✅ GPU: {torch.cuda.get_device_name(0)}")
else:
    print("❌ No GPU!")
    sys.exit(1)

# Config - reduced for faster startup
CONFIG = {
    "base_model": "./",
    "output_dir": "./phase3_output",
    "train_file": "../training/train_final.jsonl",
    "lora_r": 16,  # Smaller for speed
    "lora_alpha": 32,
    "max_seq_length": 1024,  # Shorter for speed
    "batch_size": 1,
    "gradient_accumulation_steps": 8,
    "num_epochs": 2,
    "learning_rate": 2e-5,
    "save_steps": 500,
    "logging_steps": 10,
    "max_examples": 5000,  # Limit examples for faster training
}

print("\n[1/4] Loading libraries...")
from transformers import AutoModelForCausalLM, AutoTokenizer, TrainingArguments, Trainer
from peft import LoraConfig, get_peft_model, prepare_model_for_kbit_training
from transformers import BitsAndBytesConfig

print(f"\n[2/4] Loading model from: {CONFIG['base_model']}")
tokenizer = AutoTokenizer.from_pretrained(CONFIG['base_model'])
if tokenizer.pad_token is None:
    tokenizer.pad_token = tokenizer.eos_token

bnb_config = BitsAndBytesConfig(
    load_in_4bit=True,
    bnb_4bit_quant_type="nf4",
    bnb_4bit_compute_dtype=torch.float16,
)

model = AutoModelForCausalLM.from_pretrained(
    CONFIG['base_model'],
    quantization_config=bnb_config,
    device_map="auto",
    trust_remote_code=True,
)

model = prepare_model_for_kbit_training(model)
lora_config = LoraConfig(
    r=CONFIG['lora_r'],
    lora_alpha=CONFIG['lora_alpha'],
    lora_dropout=0.05,
    target_modules=["q_proj", "k_proj", "v_proj", "o_proj"],
    bias="none",
    task_type="CAUSAL_LM",
)
model = get_peft_model(model, lora_config)
model.print_trainable_parameters()

print(f"\n[3/4] Loading data (max {CONFIG['max_examples']} examples)...")

# Load and format inline - no separate tokenization step
examples = []
with open(CONFIG['train_file'], 'r', encoding='utf-8') as f:
    for i, line in enumerate(f):
        if i >= CONFIG['max_examples']:
            break
        if line.strip():
            try:
                ex = json.loads(line)
                if 'messages' in ex:
                    text = tokenizer.apply_chat_template(ex['messages'], tokenize=False)
                else:
                    messages = [
                        {"role": "user", "content": ex.get('instruction', '')},
                        {"role": "assistant", "content": ex.get('output', '')}
                    ]
                    text = tokenizer.apply_chat_template(messages, tokenize=False)
                
                # Tokenize immediately
                tokens = tokenizer(text, truncation=True, max_length=CONFIG['max_seq_length'], 
                                   padding=False, return_tensors=None)
                tokens['labels'] = tokens['input_ids'].copy()
                examples.append(tokens)
            except:
                pass

print(f"  ✅ {len(examples)} examples ready")

# Simple dataset
from torch.utils.data import Dataset as TorchDataset

class SimpleDataset(TorchDataset):
    def __init__(self, examples):
        self.examples = examples
    def __len__(self):
        return len(self.examples)
    def __getitem__(self, idx):
        return {k: torch.tensor(v) for k, v in self.examples[idx].items()}

train_size = int(len(examples) * 0.95)
train_data = SimpleDataset(examples[:train_size])
val_data = SimpleDataset(examples[train_size:])

print(f"  📊 {len(train_data)} train, {len(val_data)} val")

# Collator with dynamic padding
from transformers import DataCollatorForSeq2Seq
collator = DataCollatorForSeq2Seq(tokenizer, padding=True, return_tensors="pt")

print("\n[4/4] 🚀 Starting training...")

training_args = TrainingArguments(
    output_dir=CONFIG['output_dir'],
    num_train_epochs=CONFIG['num_epochs'],
    per_device_train_batch_size=CONFIG['batch_size'],
    gradient_accumulation_steps=CONFIG['gradient_accumulation_steps'],
    learning_rate=CONFIG['learning_rate'],
    warmup_ratio=0.1,
    save_steps=CONFIG['save_steps'],
    logging_steps=CONFIG['logging_steps'],
    fp16=True,
    optim="paged_adamw_8bit",
    report_to="none",
    dataloader_num_workers=0,  # Faster on Windows
)

trainer = Trainer(
    model=model,
    args=training_args,
    train_dataset=train_data,
    eval_dataset=val_data,
    data_collator=collator,
)

start = datetime.now()
trainer.train()
elapsed = datetime.now() - start

print(f"\n✅ Training complete! Duration: {elapsed}")
print("💾 Saving model...")
model.save_pretrained(f"{CONFIG['output_dir']}/lora")
tokenizer.save_pretrained(f"{CONFIG['output_dir']}/lora")
print(f"Saved to: {CONFIG['output_dir']}/lora")
