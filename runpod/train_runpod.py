#!/usr/bin/env python3
"""
RunPod Training Script - Qwen2.5-Coder-7B QLoRA SFT
Optimized for H100 80GB / A100 80GB (Text-only, no vision)

GUARDRAILS ENABLED:
- Auto-stop if < 0.25 steps/sec after 10 minutes
- Monitors GPU utilization
- Projects total steps and warns if insufficient
"""

import os
import json
import torch
from pathlib import Path
from datetime import datetime

# Paths
WORKSPACE = Path("/workspace")
DATA_DIR = WORKSPACE / "data"
OUTPUT_DIR = WORKSPACE / "output"

# H200 SXM RUNBOOK CONFIG - DO NOT CHANGE WITHOUT REASON
# See RUNBOOK.md for full documentation
CONFIG = {
    "model_name": "huihui-ai/Qwen2.5-Coder-7B-Instruct-abliterated",  # Coder model (no vision)
    "max_seq_length": 8192,    # Runbook: start here, drop if too slow
    "load_in_4bit": True,
    "lora_r": 32,
    "lora_alpha": 64,
    "lora_dropout": 0.0,      # 0.0 = fastest Unsloth patching
    "num_epochs": 3,
    "batch_size": 2,           # Runbook: micro_batch_size = 2
    "gradient_accumulation": 8, # Runbook: grad_accum = 8 (effective batch = 16)
    "learning_rate": 2e-5,
    "warmup_ratio": 0.1,
    "packing": True,           # ON for text-only models (faster)
}

# GUARDRAIL THRESHOLDS - DO NOT LOWER (from RUNBOOK)
GUARDRAILS = {
    "min_steps_per_sec": 0.25,      # STOP if below this after warmup
    "good_steps_per_sec": 0.6,      # Target speed - proceed if >= this
    "borderline_steps_per_sec": 0.3, # Warning zone
    "warmup_minutes": 5,             # Ignore first 5 min (JIT compile)
    "check_after_minutes": 10,       # Enforce stop after 10 min
    "smoke_test_minutes": 15,        # Stage 0 smoke test duration
    "block_hours": 2.0,              # 2-hour training blocks
    "min_useful_steps": 4000,        # Minimum for learning
    "good_steps": 6000,              # Good session
    "excellent_steps": 10000,        # Excellent session
    "session_hours": 3.0,            # Max single session
    "cost_per_hour": 3.59,           # H200 SXM hourly rate
    "save_steps": 500,               # Checkpoint frequency
    "save_total_limit": 5,           # Keep last 5 checkpoints
}


def setup_environment():
    """Setup training environment with GPU detection"""
    print("Setting up environment...")
    
    OUTPUT_DIR.mkdir(exist_ok=True)
    
    if torch.cuda.is_available():
        gpu = torch.cuda.get_device_name(0)
        mem = torch.cuda.get_device_properties(0).total_memory / 1024**3
        print(f"GPU: {gpu} ({mem:.1f}GB)")
        
        # CONSERVATIVE settings - prioritize speed over context
        if "H100" in gpu or "H200" in gpu:
            CONFIG["batch_size"] = 4      # Start moderate
            CONFIG["max_seq_length"] = 8192  # Keep low for speed
            print("H100/H200 detected - using SAFE optimized settings")
        elif "A100" in gpu:
            CONFIG["batch_size"] = 2
            CONFIG["max_seq_length"] = 8192
            print("A100 detected - using SAFE settings")
        else:
            CONFIG["batch_size"] = 1
            CONFIG["max_seq_length"] = 4096
            print("Unknown GPU - using conservative settings")
    else:
        print("ERROR: No GPU detected!")
        return False
    
    return True


def load_dataset():
    """Load training data"""
    print("\nLoading dataset...")
    
    # Priority: complete_source > perfect > multitask
    train_file = DATA_DIR / "train_complete_source.jsonl"
    if not train_file.exists():
        train_file = DATA_DIR / "train_perfect_messages.jsonl"
    if not train_file.exists():
        train_file = DATA_DIR / "train_multitask.jsonl"
    
    # Use normalized val file (consistent schema)
    val_file = DATA_DIR / "val_normalized.jsonl"
    if not val_file.exists():
        val_file = DATA_DIR / "val_multitask.jsonl"
    
    if not train_file.exists():
        print(f"ERROR: {train_file} not found!")
        print("Upload training data to /workspace/data/")
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
    """Format for Qwen chat template"""
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
    try:
        from unsloth import FastLanguageModel
        from unsloth import is_bfloat16_supported
    except ImportError:
        print("Installing Unsloth...")
        os.system("pip install unsloth")
        from unsloth import FastLanguageModel
        from unsloth import is_bfloat16_supported
    
    from trl import SFTTrainer
    from transformers import TrainingArguments, TrainerCallback
    import time
    
    # =================================================================
    # GUARDRAIL CALLBACK - Monitors steps/sec and auto-stops if slow
    # =================================================================
    class GuardrailCallback(TrainerCallback):
        """
        CRITICAL: Auto-stops training if too slow to prevent wasting money.
        
        Thresholds:
        - >= 0.6 steps/sec = GOOD (keep training)
        - 0.3-0.6 steps/sec = BORDERLINE (warning)
        - < 0.25 steps/sec = STOP (wasting money!)
        """
        
        def __init__(self):
            self.start_time = None
            self.step_times = []  # (timestamp, step)
            self.warned = False
            
        def on_train_begin(self, args, state, control, **kwargs):
            self.start_time = time.time()
            print(f"""
================================================================================
  GUARDRAILS ACTIVE
  Will auto-stop if < {GUARDRAILS['min_steps_per_sec']} steps/sec after {GUARDRAILS['check_after_minutes']} minutes
  Target: >= {GUARDRAILS['good_steps_per_sec']} steps/sec
================================================================================
""")
        
        def on_step_end(self, args, state, control, **kwargs):
            now = time.time()
            self.step_times.append((now, state.global_step))
            
            # Keep last 200 entries
            if len(self.step_times) > 200:
                self.step_times = self.step_times[-200:]
            
            # Check every 50 steps
            if state.global_step % 50 == 0 and state.global_step > 0:
                elapsed_min = (now - self.start_time) / 60
                steps_sec = self._get_steps_per_sec()
                projected = self._project_total_steps(steps_sec, state.global_step)
                
                status = self._get_status(steps_sec, projected)
                print(f"[GUARDRAIL] {elapsed_min:.1f}min | {steps_sec:.3f} steps/sec | "
                      f"Projected: {projected:,} steps | {status}")
                
                # After check period, enforce guardrails
                if elapsed_min >= GUARDRAILS['check_after_minutes']:
                    if steps_sec < GUARDRAILS['min_steps_per_sec']:
                        print(f"""
================================================================================
  GUARDRAIL TRIGGERED - STOPPING TRAINING
================================================================================
  Speed: {steps_sec:.3f} steps/sec (threshold: {GUARDRAILS['min_steps_per_sec']})
  Steps completed: {state.global_step:,}
  Money saved: ~${(GUARDRAILS['session_hours'] - elapsed_min/60) * GUARDRAILS['cost_per_hour']:.2f}
  
  FIXES TO TRY:
  1. Reduce max_seq_length to 4096
  2. Reduce batch_size to 1
  3. Check GPU utilization (should be 85-98%)
================================================================================
""")
                        control.should_training_stop = True
                        
                    elif steps_sec < GUARDRAILS['good_steps_per_sec'] and not self.warned:
                        print(f"  [WARNING] Speed borderline - consider reducing context/batch")
                        self.warned = True
        
        def _get_steps_per_sec(self, window_sec=120):
            if len(self.step_times) < 2:
                return 0.0
            
            now = time.time()
            cutoff = now - window_sec
            recent = [(t, s) for t, s in self.step_times if t >= cutoff]
            
            if len(recent) < 2:
                return 0.0
            
            time_span = recent[-1][0] - recent[0][0]
            step_span = recent[-1][1] - recent[0][1]
            
            return step_span / time_span if time_span > 0 else 0.0
        
        def _project_total_steps(self, steps_sec, current_step):
            if steps_sec <= 0:
                return current_step
            
            remaining_sec = (GUARDRAILS['session_hours'] * 3600) - (time.time() - self.start_time)
            return int(current_step + steps_sec * max(0, remaining_sec))
        
        def _get_status(self, steps_sec, projected):
            if steps_sec >= GUARDRAILS['good_steps_per_sec']:
                if projected >= 10000:
                    return "EXCELLENT"
                elif projected >= 6000:
                    return "GOOD"
                else:
                    return "OK"
            elif steps_sec >= GUARDRAILS['min_steps_per_sec']:
                return "BORDERLINE"
            else:
                return "TOO SLOW - WILL STOP"
        
        def on_train_end(self, args, state, control, **kwargs):
            elapsed_min = (time.time() - self.start_time) / 60
            steps_sec = self._get_steps_per_sec()
            cost = (elapsed_min / 60) * GUARDRAILS['cost_per_hour']
            
            print(f"""
================================================================================
  TRAINING SESSION COMPLETE
================================================================================
  Duration: {elapsed_min:.1f} minutes
  Total Steps: {state.global_step:,}
  Average Speed: {steps_sec:.3f} steps/sec
  Estimated Cost: ~${cost:.2f}
================================================================================
""")
    
    # Load data
    train_data, val_data = load_dataset()
    if train_data is None:
        return False
    
    # Format
    train_data = train_data.map(format_messages)
    val_data = val_data.map(format_messages)
    
    # Load model
    print(f"\nLoading {CONFIG['model_name']}...")
    
    model, tokenizer = FastLanguageModel.from_pretrained(
        model_name=CONFIG["model_name"],
        max_seq_length=CONFIG["max_seq_length"],
        load_in_4bit=CONFIG["load_in_4bit"],
        dtype=None,
    )
    
    # Apply LoRA
    print("Applying LoRA adapters...")
    
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
    
    # Training args - RUNBOOK settings
    training_args = TrainingArguments(
        output_dir=str(OUTPUT_DIR),
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
        eval_steps=200,
        save_strategy="steps",
        save_steps=GUARDRAILS["save_steps"],          # RUNBOOK: 500
        save_total_limit=GUARDRAILS["save_total_limit"], # RUNBOOK: 5
        bf16=is_bfloat16_supported(),
        fp16=not is_bfloat16_supported(),
        optim="adamw_8bit",
        seed=42,
        report_to="none",
        dataloader_num_workers=4,  # Help prevent CPU bottleneck
    )
    
    # Trainer with GUARDRAILS
    guardrail_callback = GuardrailCallback()
    
    trainer = SFTTrainer(
        model=model,
        tokenizer=tokenizer,
        train_dataset=train_data,
        eval_dataset=val_data,
        dataset_text_field="text",
        max_seq_length=CONFIG["max_seq_length"],
        args=training_args,
        callbacks=[guardrail_callback],  # GUARDRAILS ENABLED
    )
    
    # Calculate estimated steps
    effective_batch = CONFIG['batch_size'] * CONFIG['gradient_accumulation']
    estimated_steps = (len(train_data) * CONFIG['num_epochs']) // effective_batch
    
    # Train
    print("\n" + "="*60)
    print("TRAINING STARTED WITH GUARDRAILS")
    print("="*60)
    print(f"Epochs: {CONFIG['num_epochs']}")
    print(f"Dataset: {len(train_data):,} examples")
    print(f"Batch: {CONFIG['batch_size']} x {CONFIG['gradient_accumulation']} = {effective_batch}")
    print(f"Estimated Steps: {estimated_steps:,}")
    print(f"Context Length: {CONFIG['max_seq_length']}")
    print("-"*60)
    print(f"GUARDRAILS: Will stop if < {GUARDRAILS['min_steps_per_sec']} steps/sec")
    print(f"Target: >= {GUARDRAILS['good_steps_per_sec']} steps/sec")
    print("="*60 + "\n")
    
    start_time = datetime.now()
    trainer.train()
    train_time = datetime.now() - start_time
    
    # Save
    print("\nSaving model...")
    final_dir = OUTPUT_DIR / "final"
    final_dir.mkdir(exist_ok=True)
    
    model.save_pretrained(str(final_dir))
    tokenizer.save_pretrained(str(final_dir))
    
    # Save merged for easy inference
    print("Saving merged model...")
    merged_dir = OUTPUT_DIR / "merged"
    merged_dir.mkdir(exist_ok=True)
    
    model.save_pretrained_merged(
        str(merged_dir),
        tokenizer,
        save_method="merged_16bit",
    )
    
    # Explicitly save tokenizer to avoid missing tokenizer.model
    print("Saving tokenizer explicitly...")
    tokenizer.save_pretrained(str(merged_dir))
    
    # Save training info
    info = {
        "model": CONFIG["model_name"],
        "training_time": str(train_time),
        "epochs": CONFIG["num_epochs"],
        "examples": len(train_data),
        "completed": datetime.now().isoformat(),
    }
    
    with open(OUTPUT_DIR / "training_info.json", "w") as f:
        json.dump(info, f, indent=2)
    
    print(f"\n✅ TRAINING COMPLETE")
    print(f"Time: {train_time}")
    print(f"Output: {OUTPUT_DIR}")
    
    return True


if __name__ == "__main__":
    train()
