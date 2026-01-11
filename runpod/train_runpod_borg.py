#!/usr/bin/env python3
"""
RunPod Training Script - Qwen2.5-Coder-7B QLoRA SFT
SVONY STUDIO BORG EDITION - Fancy Terminal Display

Features:
- Dynamic ASCII art transitions during training
- Color gradients based on progress
- Live dashboard with Rich library
- Guardrails with visual alerts
"""

import os
import sys
import json
import torch
import time
from pathlib import Path
from datetime import datetime
from typing import Optional, Tuple

# Paths
WORKSPACE = Path("/workspace")
DATA_DIR = WORKSPACE / "data"
OUTPUT_DIR = WORKSPACE / "output"

# H200 SXM RUNBOOK CONFIG
CONFIG = {
    "model_name": "huihui-ai/Qwen2.5-Coder-7B-Instruct-abliterated",
    "max_seq_length": 8192,
    "load_in_4bit": True,
    "lora_r": 32,
    "lora_alpha": 64,
    "lora_dropout": 0.0,
    "num_epochs": 3,
    "batch_size": 2,
    "gradient_accumulation": 8,
    "learning_rate": 2e-5,
    "warmup_ratio": 0.1,
    "packing": True,
}

GUARDRAILS = {
    "min_steps_per_sec": 0.25,
    "good_steps_per_sec": 0.6,
    "borderline_steps_per_sec": 0.3,
    "warmup_minutes": 5,
    "check_after_minutes": 10,
    "session_hours": 3.0,
    "cost_per_hour": 3.59,
    "save_steps": 500,
    "save_total_limit": 5,
}

# Try to import Borg display
try:
    from borg_display import (
        BorgDisplay, get_display, show_banner, show_loading,
        update_metrics, show_completion, show_error
    )
    from borg_theme import get_progress_color, get_loss_color
    BORG_DISPLAY = True
except ImportError:
    BORG_DISPLAY = False
    print("Borg display not available - using basic output")

# Try Rich for live display
try:
    from rich.console import Console
    from rich.live import Live
    from rich.panel import Panel
    from rich.text import Text
    RICH_AVAILABLE = True
    console = Console()
except ImportError:
    RICH_AVAILABLE = False
    console = None


def print_borg(message: str, style: str = "green4"):
    """Print with Borg styling if available"""
    if RICH_AVAILABLE and console:
        console.print(f"[{style}]{message}[/]")
    else:
        print(message)


def show_startup_banner():
    """Display the startup banner"""
    if BORG_DISPLAY:
        show_banner("svony_main")
    else:
        print("=" * 60)
        print("SVONY STUDIO BORG - NEURAL TRAINING SYSTEM")
        print("=" * 60)
    
    print_borg(f"Started: {datetime.now()}", "grey37")
    print()


def setup_environment():
    """Setup training environment with GPU detection"""
    if BORG_DISPLAY:
        show_loading("DETECTING HARDWARE...")
    else:
        print("Setting up environment...")
    
    OUTPUT_DIR.mkdir(exist_ok=True)
    
    if torch.cuda.is_available():
        gpu = torch.cuda.get_device_name(0)
        mem = torch.cuda.get_device_properties(0).total_memory / 1024**3
        print_borg(f"◈ GPU: {gpu} ({mem:.1f}GB)", "green4")
        
        if "H100" in gpu or "H200" in gpu:
            CONFIG["batch_size"] = 4
            CONFIG["max_seq_length"] = 8192
            print_borg("◈ H100/H200 detected - OPTIMAL settings", "green3")
        elif "A100" in gpu:
            CONFIG["batch_size"] = 2
            CONFIG["max_seq_length"] = 8192
            print_borg("◈ A100 detected - SAFE settings", "dark_cyan")
        else:
            CONFIG["batch_size"] = 1
            CONFIG["max_seq_length"] = 4096
            print_borg("◈ Unknown GPU - CONSERVATIVE settings", "dark_orange3")
    else:
        if BORG_DISPLAY:
            show_error("NO GPU DETECTED", "Training requires CUDA GPU")
        else:
            print("ERROR: No GPU detected!")
        return False
    
    return True


def load_training_data():
    """Load training data with visual feedback"""
    if BORG_DISPLAY:
        show_loading("LOADING DATASET...")
    else:
        print("\nLoading dataset...")
    
    # Priority: complete_source > perfect > multitask
    train_file = DATA_DIR / "train_complete_source.jsonl"
    if not train_file.exists():
        train_file = DATA_DIR / "train_perfect_messages.jsonl"
    if not train_file.exists():
        train_file = DATA_DIR / "train_multitask.jsonl"
    
    val_file = DATA_DIR / "val_normalized.jsonl"
    if not val_file.exists():
        val_file = DATA_DIR / "val_multitask.jsonl"
    
    if not train_file.exists():
        if BORG_DISPLAY:
            show_error("DATASET NOT FOUND", f"Missing: {train_file}")
        else:
            print(f"ERROR: {train_file} not found!")
        return None, None
    
    from datasets import load_dataset as hf_load_dataset
    
    dataset = hf_load_dataset("json", data_files={
        "train": str(train_file),
        "validation": str(val_file) if val_file.exists() else str(train_file),
    })
    
    print_borg(f"◈ Train: {len(dataset['train']):,} examples", "green4")
    print_borg(f"◈ Val: {len(dataset['validation']):,} examples", "dark_cyan")
    
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
    
    return {"text": text}


class BorgGuardrailCallback:
    """
    Guardrail callback with Borg visual feedback.
    Monitors training speed and provides dynamic display updates.
    """
    
    def __init__(self, display: Optional[BorgDisplay] = None, total_steps: int = 0):
        self.display = display
        self.total_steps = total_steps
        self.start_time = None
        self.step_times = []
        self.warned = False
        self.start_loss = 0.0
        self.current_loss = 0.0
        
    def on_train_begin(self, args, state, control, **kwargs):
        self.start_time = time.time()
        
        if self.display:
            self.display.update_metrics(
                total_steps=self.total_steps,
                total_epochs=args.num_train_epochs,
            )
        
        if RICH_AVAILABLE and console:
            console.print(Panel(
                "[bold green4]◈ GUARDRAILS ACTIVE ◈[/]\n"
                f"Auto-stop if < {GUARDRAILS['min_steps_per_sec']} steps/sec\n"
                f"Target: >= {GUARDRAILS['good_steps_per_sec']} steps/sec",
                border_style="green4",
                title="[green3]BORG PROTECTION[/]"
            ))
        else:
            print("=" * 60)
            print("GUARDRAILS ACTIVE")
            print("=" * 60)
    
    def on_log(self, args, state, control, logs=None, **kwargs):
        """Called on logging - capture loss"""
        if logs and "loss" in logs:
            self.current_loss = logs["loss"]
            if self.start_loss == 0:
                self.start_loss = self.current_loss
                
            if self.display:
                self.display.update_metrics(
                    loss=self.current_loss,
                    start_loss=self.start_loss,
                )
    
    def on_step_end(self, args, state, control, **kwargs):
        now = time.time()
        self.step_times.append((now, state.global_step))
        
        if len(self.step_times) > 200:
            self.step_times = self.step_times[-200:]
        
        # Update display
        elapsed_min = (now - self.start_time) / 60
        steps_sec = self._get_steps_per_sec()
        cost = (elapsed_min / 60) * GUARDRAILS['cost_per_hour']
        
        if self.display:
            self.display.update_metrics(
                step=state.global_step,
                speed=steps_sec,
                elapsed_minutes=elapsed_min,
                estimated_cost=cost,
                epoch=int(state.epoch) if state.epoch else 0,
            )
        
        # Check every 50 steps
        if state.global_step % 50 == 0 and state.global_step > 0:
            progress = (state.global_step / max(self.total_steps, 1)) * 100
            
            if BORG_DISPLAY:
                color = get_progress_color(progress)
                loss_color = get_loss_color(self.current_loss, self.start_loss)
                
                status_line = (
                    f"[{color}]◈[/] Step {state.global_step:,}/{self.total_steps:,} "
                    f"[{color}]|[/] Loss [{loss_color}]{self.current_loss:.4f}[/] "
                    f"[{color}]|[/] {steps_sec:.2f} s/s "
                    f"[{color}]|[/] ${cost:.2f}"
                )
                if console:
                    console.print(status_line)
            else:
                print(f"[BORG] Step {state.global_step}/{self.total_steps} | "
                      f"Loss {self.current_loss:.4f} | {steps_sec:.2f} s/s | ${cost:.2f}")
            
            # Guardrail checks after warmup
            if elapsed_min >= GUARDRAILS['check_after_minutes']:
                if steps_sec < GUARDRAILS['min_steps_per_sec']:
                    if BORG_DISPLAY:
                        show_error(
                            "GUARDRAIL TRIGGERED",
                            f"Speed: {steps_sec:.3f} s/s < {GUARDRAILS['min_steps_per_sec']}\n"
                            f"Steps: {state.global_step:,}\n"
                            "Try: Reduce max_seq_length or batch_size"
                        )
                    else:
                        print(f"GUARDRAIL TRIGGERED - Speed too slow: {steps_sec:.3f}")
                    control.should_training_stop = True
                    
                elif steps_sec < GUARDRAILS['good_steps_per_sec'] and not self.warned:
                    if BORG_DISPLAY and self.display:
                        self.display.show_guardrail_warning(steps_sec, GUARDRAILS['good_steps_per_sec'])
                    else:
                        print(f"WARNING: Speed borderline ({steps_sec:.3f})")
                    self.warned = True
    
    def on_train_end(self, args, state, control, **kwargs):
        elapsed_min = (time.time() - self.start_time) / 60
        steps_sec = self._get_steps_per_sec()
        cost = (elapsed_min / 60) * GUARDRAILS['cost_per_hour']
        
        final_metrics = {
            "Duration": f"{elapsed_min:.1f} min",
            "Total Steps": f"{state.global_step:,}",
            "Final Loss": f"{self.current_loss:.4f}",
            "Avg Speed": f"{steps_sec:.2f} s/s",
            "Est. Cost": f"${cost:.2f}",
        }
        
        if BORG_DISPLAY:
            show_completion(final_metrics)
        else:
            print("\n" + "=" * 60)
            print("TRAINING COMPLETE")
            for k, v in final_metrics.items():
                print(f"  {k}: {v}")
            print("=" * 60)
    
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


def train():
    """Main training function with Borg display"""
    
    # Startup banner
    show_startup_banner()
    
    # Setup
    if not setup_environment():
        return False
    
    # Load data
    train_data, val_data = load_training_data()
    if train_data is None:
        return False
    
    # Format data
    if BORG_DISPLAY:
        show_loading("FORMATTING DATA...")
    print_borg("◈ Formatting dataset...", "dark_cyan")
    
    train_data = train_data.map(format_messages)
    val_data = val_data.map(format_messages)
    
    # Load model
    if BORG_DISPLAY:
        show_loading("ASSIMILATING MODEL...")
    print_borg(f"◈ Loading {CONFIG['model_name']}...", "green4")
    
    try:
        from unsloth import FastLanguageModel, is_bfloat16_supported
    except ImportError:
        print("Installing Unsloth...")
        os.system("pip install --no-deps unsloth unsloth_zoo")
        from unsloth import FastLanguageModel, is_bfloat16_supported
    
    from trl import SFTTrainer
    from transformers import TrainingArguments, TrainerCallback
    
    model, tokenizer = FastLanguageModel.from_pretrained(
        model_name=CONFIG["model_name"],
        max_seq_length=CONFIG["max_seq_length"],
        load_in_4bit=CONFIG["load_in_4bit"],
        dtype=None,
    )
    
    # Apply LoRA
    if BORG_DISPLAY:
        show_loading("APPLYING LORA...")
    print_borg("◈ Applying LoRA adapters...", "dark_cyan")
    
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
    
    # Calculate steps
    effective_batch = CONFIG['batch_size'] * CONFIG['gradient_accumulation']
    total_steps = (len(train_data) * CONFIG['num_epochs']) // effective_batch
    
    print_borg(f"◈ Estimated steps: {total_steps:,}", "green4")
    
    # Training args
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
        save_steps=GUARDRAILS["save_steps"],
        save_total_limit=GUARDRAILS["save_total_limit"],
        bf16=is_bfloat16_supported(),
        fp16=not is_bfloat16_supported(),
        optim="adamw_8bit",
        seed=42,
        report_to="none",
        dataloader_num_workers=4,
    )
    
    # Create callback
    display = get_display() if BORG_DISPLAY else None
    guardrail_callback = BorgGuardrailCallback(display=display, total_steps=total_steps)
    
    # Wrap callback for Trainer
    class TrainerCallbackWrapper(TrainerCallback):
        def __init__(self, borg_callback):
            self.borg = borg_callback
        
        def on_train_begin(self, args, state, control, **kwargs):
            self.borg.on_train_begin(args, state, control, **kwargs)
        
        def on_log(self, args, state, control, logs=None, **kwargs):
            self.borg.on_log(args, state, control, logs=logs, **kwargs)
        
        def on_step_end(self, args, state, control, **kwargs):
            self.borg.on_step_end(args, state, control, **kwargs)
        
        def on_train_end(self, args, state, control, **kwargs):
            self.borg.on_train_end(args, state, control, **kwargs)
    
    callback_wrapper = TrainerCallbackWrapper(guardrail_callback)
    
    # Create trainer
    trainer = SFTTrainer(
        model=model,
        tokenizer=tokenizer,
        train_dataset=train_data,
        eval_dataset=val_data,
        dataset_text_field="text",
        max_seq_length=CONFIG["max_seq_length"],
        args=training_args,
        callbacks=[callback_wrapper],
    )
    
    # Training banner
    if RICH_AVAILABLE and console:
        console.print(Panel(
            f"[bold green4]◈ NEURAL LINK ESTABLISHED ◈[/]\n\n"
            f"Epochs: {CONFIG['num_epochs']}\n"
            f"Dataset: {len(train_data):,} examples\n"
            f"Batch: {CONFIG['batch_size']} x {CONFIG['gradient_accumulation']} = {effective_batch}\n"
            f"Steps: {total_steps:,}\n"
            f"Context: {CONFIG['max_seq_length']}",
            border_style="green4",
            title="[green3]TRAINING CONFIG[/]"
        ))
    else:
        print("\n" + "=" * 60)
        print("TRAINING STARTED")
        print(f"Epochs: {CONFIG['num_epochs']}")
        print(f"Steps: {total_steps:,}")
        print("=" * 60 + "\n")
    
    # Train!
    start_time = datetime.now()
    trainer.train()
    train_time = datetime.now() - start_time
    
    # Save model
    if BORG_DISPLAY:
        show_loading("SAVING MODEL...")
    print_borg("◈ Saving model...", "green4")
    
    final_dir = OUTPUT_DIR / "final"
    final_dir.mkdir(exist_ok=True)
    model.save_pretrained(str(final_dir))
    tokenizer.save_pretrained(str(final_dir))
    
    # Save merged
    if BORG_DISPLAY:
        show_loading("MERGING WEIGHTS...")
    print_borg("◈ Saving merged model...", "dark_cyan")
    
    merged_dir = OUTPUT_DIR / "merged"
    merged_dir.mkdir(exist_ok=True)
    
    model.save_pretrained_merged(
        str(merged_dir),
        tokenizer,
        save_method="merged_16bit",
    )
    
    # Explicit tokenizer save
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
    
    print_borg(f"\n◈ ASSIMILATION COMPLETE", "green3")
    print_borg(f"◈ Time: {train_time}", "green4")
    print_borg(f"◈ Output: {OUTPUT_DIR}", "dark_cyan")
    
    # Victory sound
    print('\a')
    
    return True


if __name__ == "__main__":
    success = train()
    sys.exit(0 if success else 1)
