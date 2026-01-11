#!/usr/bin/env python3
"""
🎬 EVONY PHASE 3 TRAINING TV
Live dashboard with real-time metrics for RunPod H200

Features:
- Live loss curve (ASCII)
- Speed guardrails with warnings
- ETA and budget tracking
- Checkpoint notifications
"""

import os
import sys
import json
import time
import torch
from pathlib import Path
from datetime import datetime, timedelta
from threading import Thread
from queue import Queue

# Rich for beautiful terminal UI
try:
    from rich.console import Console
    from rich.live import Live
    from rich.table import Table
    from rich.panel import Panel
    from rich.progress import Progress, SpinnerColumn, TextColumn, BarColumn, TaskProgressColumn, TimeElapsedColumn
    from rich.layout import Layout
    from rich.text import Text
    RICH_AVAILABLE = True
except ImportError:
    RICH_AVAILABLE = False
    print("Installing rich for Training TV...")
    os.system("pip install rich")
    from rich.console import Console
    from rich.live import Live
    from rich.table import Table
    from rich.panel import Panel
    from rich.progress import Progress, SpinnerColumn, TextColumn, BarColumn, TaskProgressColumn, TimeElapsedColumn
    from rich.layout import Layout
    from rich.text import Text

console = Console()

# ============================================================
# CONFIGURATION
# ============================================================

CONFIG = {
    "base_model": "Qwen/Qwen2.5-VL-7B-Instruct",
    "output_dir": "./evony_phase3_output",
    "train_file": "train_final.jsonl",
    
    # LoRA
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
    "lr_scheduler_type": "cosine",
    
    # Checkpoints
    "save_steps": 500,
    "save_total_limit": 5,
    "logging_steps": 10,
    
    # Performance
    "bf16": True,
    "packing": False,
    
    # Budget
    "hourly_rate": 3.59,
    "budget_hours": 3.0,
}

# ============================================================
# TRAINING TV DASHBOARD
# ============================================================

class TrainingTV:
    def __init__(self):
        self.start_time = None
        self.current_step = 0
        self.total_steps = 0
        self.current_loss = 0.0
        self.losses = []
        self.steps_per_sec = 0.0
        self.checkpoints_saved = 0
        self.status = "INITIALIZING"
        self.gpu_name = "Unknown"
        self.gpu_mem = 0
        self.warnings = []
        
    def start(self):
        self.start_time = datetime.now()
        
    def update(self, step, loss, total_steps):
        self.current_step = step
        self.current_loss = loss
        self.total_steps = total_steps
        self.losses.append(loss)
        
        if self.start_time:
            elapsed = (datetime.now() - self.start_time).total_seconds()
            if elapsed > 60:
                self.steps_per_sec = step / elapsed
                
                # Speed guardrails
                if self.steps_per_sec < 0.25:
                    self.status = "⚠️ TOO SLOW - STOP!"
                    if "TOO_SLOW" not in [w[0] for w in self.warnings]:
                        self.warnings.append(("TOO_SLOW", f"Speed {self.steps_per_sec:.3f} < 0.25 steps/sec"))
                elif self.steps_per_sec < 0.6:
                    self.status = "⚡ BORDERLINE"
                else:
                    self.status = "✅ GOOD"
    
    def checkpoint_saved(self, path):
        self.checkpoints_saved += 1
        
    def get_eta(self):
        if self.steps_per_sec > 0 and self.total_steps > 0:
            remaining = self.total_steps - self.current_step
            seconds = remaining / self.steps_per_sec
            return str(timedelta(seconds=int(seconds)))
        return "Calculating..."
    
    def get_elapsed(self):
        if self.start_time:
            return str(timedelta(seconds=int((datetime.now() - self.start_time).total_seconds())))
        return "00:00:00"
    
    def get_cost(self):
        if self.start_time:
            hours = (datetime.now() - self.start_time).total_seconds() / 3600
            return hours * CONFIG["hourly_rate"]
        return 0.0
    
    def get_loss_chart(self, width=40, height=8):
        """ASCII loss chart"""
        if len(self.losses) < 2:
            return "Collecting data..."
        
        # Get last N losses
        recent = self.losses[-width:] if len(self.losses) > width else self.losses
        
        if not recent:
            return "No data"
            
        min_loss = min(recent)
        max_loss = max(recent)
        range_loss = max_loss - min_loss if max_loss > min_loss else 1
        
        chart = []
        for row in range(height):
            threshold = max_loss - (row / height) * range_loss
            line = ""
            for loss in recent:
                if loss >= threshold:
                    line += "█"
                else:
                    line += " "
            chart.append(f"{threshold:.3f} │{line}│")
        
        chart.append(" " * 7 + "└" + "─" * len(recent) + "┘")
        return "\n".join(chart)
    
    def render(self):
        """Render the dashboard"""
        layout = Layout()
        
        # Header
        header = Panel(
            Text("🎬 EVONY PHASE 3 TRAINING TV", style="bold cyan", justify="center"),
            style="cyan"
        )
        
        # Stats table
        stats = Table(show_header=False, box=None, padding=(0, 2))
        stats.add_column("Key", style="dim")
        stats.add_column("Value", style="bold")
        
        stats.add_row("Status", self.status)
        stats.add_row("Step", f"{self.current_step:,} / {self.total_steps:,}")
        stats.add_row("Loss", f"{self.current_loss:.4f}")
        stats.add_row("Speed", f"{self.steps_per_sec:.3f} steps/sec")
        stats.add_row("Elapsed", self.get_elapsed())
        stats.add_row("ETA", self.get_eta())
        stats.add_row("Cost", f"${self.get_cost():.2f}")
        stats.add_row("Checkpoints", str(self.checkpoints_saved))
        stats.add_row("GPU", f"{self.gpu_name} ({self.gpu_mem:.0f}GB)")
        
        stats_panel = Panel(stats, title="📊 Metrics", border_style="green")
        
        # Loss chart
        chart_panel = Panel(
            self.get_loss_chart(),
            title="📉 Loss Curve",
            border_style="blue"
        )
        
        # Warnings
        if self.warnings:
            warning_text = "\n".join([f"⚠️ {w[0]}: {w[1]}" for w in self.warnings[-5:]])
        else:
            warning_text = "✅ No warnings"
        warnings_panel = Panel(warning_text, title="⚠️ Alerts", border_style="yellow")
        
        # Progress bar
        progress = f"[{'█' * int(self.current_step / max(self.total_steps, 1) * 30)}{' ' * (30 - int(self.current_step / max(self.total_steps, 1) * 30))}] {self.current_step/max(self.total_steps,1)*100:.1f}%"
        progress_panel = Panel(progress, title="Progress", border_style="magenta")
        
        # Combine
        layout.split_column(
            Layout(header, size=3),
            Layout(name="main"),
            Layout(progress_panel, size=3),
        )
        
        layout["main"].split_row(
            Layout(stats_panel),
            Layout(name="right"),
        )
        
        layout["right"].split_column(
            Layout(chart_panel),
            Layout(warnings_panel, size=6),
        )
        
        return layout

tv = TrainingTV()

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
# CUSTOM CALLBACK
# ============================================================

class TVCallback:
    """Callback to update Training TV"""
    
    def __init__(self, tv_instance, total_steps):
        self.tv = tv_instance
        self.total_steps = total_steps
        
    def on_log(self, args, state, control, logs=None, **kwargs):
        if logs and 'loss' in logs:
            self.tv.update(state.global_step, logs['loss'], self.total_steps)
            
    def on_save(self, args, state, control, **kwargs):
        self.tv.checkpoint_saved(args.output_dir)

# ============================================================
# MAIN TRAINING
# ============================================================

def train():
    """Main training with TV"""
    
    console.print("\n[bold cyan]🎬 EVONY PHASE 3 TRAINING TV[/bold cyan]\n")
    
    # Check GPU
    if torch.cuda.is_available():
        tv.gpu_name = torch.cuda.get_device_name(0)
        tv.gpu_mem = torch.cuda.get_device_properties(0).total_memory / 1e9
        console.print(f"[green]✅ GPU: {tv.gpu_name} ({tv.gpu_mem:.1f} GB)[/green]")
    else:
        console.print("[red]❌ No GPU![/red]")
        return
    
    # Import
    console.print("[dim]Loading Unsloth...[/dim]")
    from unsloth import FastLanguageModel
    from trl import SFTTrainer
    from transformers import TrainingArguments, TrainerCallback
    from datasets import Dataset
    
    # Load model
    console.print(f"[dim]Loading model: {CONFIG['base_model']}[/dim]")
    model, tokenizer = FastLanguageModel.from_pretrained(
        model_name=CONFIG['base_model'],
        max_seq_length=CONFIG['max_seq_length'],
        dtype=torch.bfloat16,
        load_in_4bit=False,
    )
    
    # LoRA
    console.print(f"[dim]Adding LoRA (r={CONFIG['lora_r']}, α={CONFIG['lora_alpha']})[/dim]")
    model = FastLanguageModel.get_peft_model(
        model,
        r=CONFIG['lora_r'],
        lora_alpha=CONFIG['lora_alpha'],
        lora_dropout=CONFIG['lora_dropout'],
        target_modules=CONFIG['target_modules'],
        use_gradient_checkpointing=True,
    )
    
    # Load data
    console.print(f"[dim]Loading: {CONFIG['train_file']}[/dim]")
    raw_data = load_dataset(CONFIG['train_file'])
    console.print(f"[green]✅ Loaded {len(raw_data):,} examples[/green]")
    
    # Format
    formatted = []
    for ex in raw_data:
        try:
            formatted.append({"text": format_example(ex, tokenizer)})
        except:
            pass
    
    dataset = Dataset.from_list(formatted)
    split = dataset.train_test_split(test_size=0.05, seed=42)
    
    # Calculate steps
    steps_per_epoch = len(split['train']) // (CONFIG['micro_batch_size'] * CONFIG['gradient_accumulation_steps'])
    total_steps = steps_per_epoch * CONFIG['num_epochs']
    
    console.print(f"[cyan]📊 {len(split['train']):,} train, {len(split['test']):,} val[/cyan]")
    console.print(f"[cyan]📊 {total_steps:,} total steps ({steps_per_epoch:,}/epoch × {CONFIG['num_epochs']} epochs)[/cyan]")
    
    # Create custom callback
    class RichCallback(TrainerCallback):
        def on_log(self, args, state, control, logs=None, **kwargs):
            if logs and 'loss' in logs:
                tv.update(state.global_step, logs['loss'], total_steps)
        
        def on_save(self, args, state, control, **kwargs):
            tv.checkpoint_saved(args.output_dir)
    
    # Training args
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
        bf16=CONFIG['bf16'],
        optim="adamw_8bit",
        seed=42,
        report_to="none",
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
        callbacks=[RichCallback()],
    )
    
    # Start TV
    tv.start()
    tv.total_steps = total_steps
    tv.status = "🚀 TRAINING"
    
    console.print("\n[bold green]🚀 Starting Training TV...[/bold green]\n")
    
    # Train with live display
    with Live(tv.render(), refresh_per_second=1, console=console) as live:
        def update_display():
            while tv.status not in ["COMPLETE", "ERROR"]:
                live.update(tv.render())
                time.sleep(1)
        
        display_thread = Thread(target=update_display, daemon=True)
        display_thread.start()
        
        try:
            trainer.train()
            tv.status = "✅ COMPLETE"
        except Exception as e:
            tv.status = "❌ ERROR"
            tv.warnings.append(("ERROR", str(e)))
            raise
    
    # Save
    console.print("\n[bold cyan]💾 Saving model...[/bold cyan]")
    model.save_pretrained(f"{CONFIG['output_dir']}/final_lora")
    tokenizer.save_pretrained(f"{CONFIG['output_dir']}/final_lora")
    
    # Merge
    console.print("[dim]Merging to F16...[/dim]")
    merged = model.merge_and_unload()
    merged.save_pretrained(f"{CONFIG['output_dir']}/merged_f16")
    tokenizer.save_pretrained(f"{CONFIG['output_dir']}/merged_f16")
    
    # Summary
    console.print("\n" + "=" * 60)
    console.print("[bold green]✅ TRAINING COMPLETE![/bold green]")
    console.print("=" * 60)
    console.print(f"Duration: {tv.get_elapsed()}")
    console.print(f"Cost: ${tv.get_cost():.2f}")
    console.print(f"Final Loss: {tv.current_loss:.4f}")
    console.print(f"Steps: {tv.current_step:,}")
    console.print(f"Speed: {tv.steps_per_sec:.3f} steps/sec")
    console.print(f"\nOutput: {CONFIG['output_dir']}/")
    console.print("  - final_lora/ (LoRA adapter)")
    console.print("  - merged_f16/ (Merged model)")

if __name__ == "__main__":
    train()
