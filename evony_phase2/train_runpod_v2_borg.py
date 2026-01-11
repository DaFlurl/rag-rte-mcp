#!/usr/bin/env python3
"""
RunPod Training Script - Phase 2 with TRAINING TV Display
==========================================================
Qwen2.5-Coder-7B QLoRA SFT - Evony Specialization

SVONY STUDIO BORG EDITION
- Full Training TV broadcast experience
- 3D ASCII art transitions
- Borg green/black themes
- Live metrics dashboard
- Sparkline graphs

Phase 2 Settings (Claude-approved conservative):
- Context: 4096 (was 8192)
- Batch: 4 (conservative)
- Epochs: +2 (test before adding more)
- LR: 1e-5 (refinement)
"""

import os
import json
import torch
import time
from pathlib import Path
from datetime import datetime

# Paths
WORKSPACE = Path("/workspace")
DATA_DIR = WORKSPACE / "data"
OUTPUT_DIR = WORKSPACE / "output_phase2"

# ============================================================
# PHASE 2 CONFIG (Claude-approved conservative settings)
# ============================================================
CONFIG = {
    "model_name": "huihui-ai/Qwen2.5-Coder-7B-Instruct-abliterated",
    
    # SPEED OPTIMIZATIONS
    "max_seq_length": 4096,     # Was 8192 - BIGGEST SPEEDUP
    "batch_size": 4,            # Keep at 4 (safer, test before increasing)
    "gradient_accumulation": 4,  # Effective batch = 16
    
    # REFINEMENT SETTINGS
    "learning_rate": 1e-5,      # Was 2e-5 - lower for Phase 2
    "num_epochs": 2,            # +2 epochs first, TEST, then decide
    "warmup_ratio": 0.03,
    
    # LoRA (same as Phase 1)
    "load_in_4bit": True,
    "lora_r": 32,
    "lora_alpha": 64,
    "lora_dropout": 0.0,
    
    # Packing
    "packing": True,
}

GUARDRAILS = {
    "min_steps_per_sec": 0.3,
    "good_steps_per_sec": 0.5,
    "borderline_steps_per_sec": 0.4,
    "warmup_minutes": 3,
    "check_after_minutes": 8,
    "session_hours": 3.0,
    "cost_per_hour": 3.59,
    "save_steps": 400,
    "save_total_limit": 3,
}

# Try to import Training TV
try:
    from training_tv import TrainingTV, TrainingState
    TRAINING_TV = True
except ImportError:
    TRAINING_TV = False
    print("[INFO] Training TV not available - basic display mode")

# Try Rich for fallback
try:
    from rich.console import Console
    console = Console()
except ImportError:
    console = None


def print_status(msg: str, style: str = "green4"):
    """Print with styling if available"""
    if console:
        console.print(f"[{style}]{msg}[/]")
    else:
        print(msg)


def setup_environment():
    """Setup training environment"""
    print_status("Setting up environment...", "cyan3")
    OUTPUT_DIR.mkdir(exist_ok=True)
    
    if torch.cuda.is_available():
        gpu = torch.cuda.get_device_name(0)
        mem = torch.cuda.get_device_properties(0).total_memory / 1024**3
        print_status(f"GPU: {gpu} ({mem:.1f}GB)", "green4")
        
        if "H100" in gpu or "H200" in gpu:
            print_status("H100/H200 detected - Phase 2 optimized settings", "spring_green3")
        elif "A100" in gpu:
            CONFIG["batch_size"] = 4
            print_status("A100 detected - using batch size 4", "cyan3")
        else:
            CONFIG["batch_size"] = 2
            CONFIG["max_seq_length"] = 2048
            print_status("Unknown GPU - conservative settings", "orange3")
    else:
        print_status("ERROR: No GPU detected!", "red3")
        return False
    
    return True


def load_dataset():
    """Load training data"""
    print_status("\nLoading dataset...", "cyan3")
    
    train_file = DATA_DIR / "train_complete_source.jsonl"
    val_file = DATA_DIR / "val_normalized.jsonl"
    
    if not train_file.exists():
        train_file = DATA_DIR / "train_perfect_messages.jsonl"
    if not val_file.exists():
        val_file = DATA_DIR / "val_multitask.jsonl"
    
    if not train_file.exists():
        print_status(f"ERROR: Training data not found!", "red3")
        return None, None
    
    from datasets import load_dataset
    
    dataset = load_dataset("json", data_files={
        "train": str(train_file),
        "validation": str(val_file) if val_file.exists() else str(train_file),
    })
    
    print_status(f"Train: {len(dataset['train'])} examples", "green4")
    print_status(f"Val: {len(dataset['validation'])} examples", "green4")
    
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


def verify_tokenizer(merged_dir: Path):
    """Verify and fix tokenizer files (Claude fix)"""
    print_status("\n[VERIFY] Checking tokenizer files...", "cyan3")
    
    required_files = ["tokenizer.json", "tokenizer_config.json", "special_tokens_map.json"]
    optional_files = ["vocab.json", "merges.txt", "tokenizer.model"]
    
    missing_required = []
    for f in required_files:
        if not (merged_dir / f).exists():
            missing_required.append(f)
    
    if missing_required:
        print_status(f"[WARNING] Missing tokenizer files: {missing_required}", "orange3")
        print_status("[FIX] Copying from base model cache...", "cyan3")
        
        import shutil
        cache_dir = Path.home() / ".cache/huggingface/hub"
        
        for pattern in cache_dir.glob("models--huihui-ai--Qwen2.5-Coder*"):
            for snapshot in (pattern / "snapshots").glob("*"):
                for f in missing_required:
                    src = snapshot / f
                    if src.exists():
                        shutil.copy(src, merged_dir / f)
                        print_status(f"  Copied {f}", "green4")
    
    # Final verification
    print_status("[VERIFY] Final tokenizer check:", "cyan3")
    all_good = True
    for f in required_files + optional_files:
        exists = (merged_dir / f).exists()
        status = "✓" if exists else "✗"
        color = "green4" if exists else "grey50"
        print_status(f"  {status} {f}", color)
        if f in required_files and not exists:
            all_good = False
    
    return all_good


def train():
    """Main training function with Training TV display"""
    
    # Show startup
    print("=" * 70)
    print("  SVONY STUDIO BORG - PHASE 2 TRAINING")
    print("  TRAINING TV BROADCAST EDITION")
    print("=" * 70)
    print(f"  Started: {datetime.now()}")
    print("=" * 70)
    
    if not setup_environment():
        return False
    
    # Import training libraries
    from unsloth import FastLanguageModel, is_bfloat16_supported
    from trl import SFTTrainer
    from transformers import TrainingArguments, TrainerCallback
    
    # Initialize Training TV
    tv = TrainingTV("SVONY PHASE 2") if TRAINING_TV else None
    
    # =================================================================
    # TRAINING TV CALLBACK
    # =================================================================
    class TrainingTVCallback(TrainerCallback):
        def __init__(self, tv_display, total_steps_estimate):
            self.tv = tv_display
            self.start_time = None
            self.step_times = []
            self.total_steps = total_steps_estimate
            self.last_eval_loss = None
            self.phase1_loss = 0.326  # From Phase 1
            
        def on_train_begin(self, args, state, control, **kwargs):
            self.start_time = time.time()
            print_status("\n◈ TRAINING TV BROADCAST STARTED ◈\n", "green4")
            
        def on_log(self, args, state, control, logs=None, **kwargs):
            if logs is None or self.tv is None:
                return
            
            now = time.time()
            self.step_times.append((now, state.global_step))
            
            # Keep last 100 for speed calculation
            if len(self.step_times) > 100:
                self.step_times = self.step_times[-100:]
            
            # Calculate speed
            steps_per_sec = self._get_steps_per_sec()
            
            # Get metrics
            loss = logs.get("loss", 0.0)
            lr = logs.get("learning_rate", 0.0)
            eval_loss = logs.get("eval_loss", self.last_eval_loss)
            if "eval_loss" in logs:
                self.last_eval_loss = eval_loss
            
            # Calculate progress
            pct = (state.global_step / self.total_steps * 100) if self.total_steps > 0 else 0
            epoch = state.epoch if state.epoch else 0
            
            # Calculate ETA
            if steps_per_sec > 0:
                remaining_steps = self.total_steps - state.global_step
                eta_min = remaining_steps / steps_per_sec / 60
            else:
                eta_min = 0
            
            # Guardrail status
            elapsed_min = (now - self.start_time) / 60 if self.start_time else 0
            if elapsed_min < GUARDRAILS['warmup_minutes']:
                guardrail = "WARMUP"
            elif steps_per_sec >= GUARDRAILS['good_steps_per_sec']:
                guardrail = "OK"
            elif steps_per_sec >= GUARDRAILS['borderline_steps_per_sec']:
                guardrail = "BORDERLINE"
            else:
                guardrail = "SLOW"
            
            # Create state and render
            tv_state = TrainingState(
                pct=pct,
                step=state.global_step,
                total_steps=self.total_steps,
                epoch=epoch,
                total_epochs=CONFIG["num_epochs"],
                loss=loss,
                eval_loss=eval_loss,
                lr=lr,
                steps_per_sec=steps_per_sec,
                eta_min=eta_min,
                guardrail=guardrail,
                phase=2,
            )
            
            eval_mode = "eval_loss" in logs
            self.tv.render(tv_state, eval_mode)
            
            # Check guardrails
            if elapsed_min >= GUARDRAILS['check_after_minutes']:
                if steps_per_sec < GUARDRAILS['min_steps_per_sec']:
                    print_status(f"\n⚠️ GUARDRAIL: Speed too slow ({steps_per_sec:.3f} < {GUARDRAILS['min_steps_per_sec']})", "red3")
                    control.should_training_stop = True
        
        def _get_steps_per_sec(self, window_sec=60):
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
        
        def on_train_end(self, args, state, control, **kwargs):
            elapsed_min = (time.time() - self.start_time) / 60 if self.start_time else 0
            cost = elapsed_min / 60 * GUARDRAILS['cost_per_hour']
            
            if self.tv:
                final_state = TrainingState(
                    pct=100.0,
                    step=state.global_step,
                    total_steps=self.total_steps,
                    epoch=CONFIG["num_epochs"],
                    total_epochs=CONFIG["num_epochs"],
                    loss=0.0,
                    eval_loss=self.last_eval_loss,
                    lr=0.0,
                    steps_per_sec=self._get_steps_per_sec(),
                    eta_min=0.0,
                    guardrail="COMPLETE",
                    phase=2,
                )
                self.tv.show_completion(final_state, elapsed_min, cost)
    
    # Load data
    train_data, val_data = load_dataset()
    if train_data is None:
        return False
    
    # Format
    train_data = train_data.map(format_messages)
    val_data = val_data.map(format_messages)
    
    # Load model
    print_status(f"\n[MODEL] Loading {CONFIG['model_name']}...", "cyan3")
    print_status(f"        Context: {CONFIG['max_seq_length']} tokens (optimized)", "grey50")
    
    model, tokenizer = FastLanguageModel.from_pretrained(
        model_name=CONFIG["model_name"],
        max_seq_length=CONFIG["max_seq_length"],
        load_in_4bit=CONFIG["load_in_4bit"],
        dtype=None,
    )
    
    # Apply LoRA
    print_status("[LORA] Applying adapters...", "cyan3")
    
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
    estimated_steps = (len(train_data) * CONFIG['num_epochs']) // effective_batch
    
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
    tv_callback = TrainingTVCallback(tv, estimated_steps)
    
    # Trainer
    trainer = SFTTrainer(
        model=model,
        tokenizer=tokenizer,
        train_dataset=train_data,
        eval_dataset=val_data,
        dataset_text_field="text",
        max_seq_length=CONFIG["max_seq_length"],
        args=training_args,
        callbacks=[tv_callback],
    )
    
    # Print config
    print_status(f"""
╔══════════════════════════════════════════════════════════════════════╗
║  PHASE 2 TRAINING CONFIGURATION                                      ║
╠══════════════════════════════════════════════════════════════════════╣
║  Epochs: {CONFIG['num_epochs']} (total 5 with Phase 1)                                     ║
║  Dataset: {len(train_data):,} examples                                         ║
║  Batch: {CONFIG['batch_size']} x {CONFIG['gradient_accumulation']} = {effective_batch} effective                                   ║
║  Context: {CONFIG['max_seq_length']} tokens (was 8192)                                  ║
║  Learning Rate: {CONFIG['learning_rate']} (refinement)                              ║
║  Estimated Steps: ~{estimated_steps:,}                                          ║
╚══════════════════════════════════════════════════════════════════════╝
""", "green4")
    
    # Train
    start_time = datetime.now()
    trainer.train()
    train_time = datetime.now() - start_time
    
    # Save
    print_status("\n[SAVE] Saving model...", "cyan3")
    
    # Save LoRA adapter
    final_dir = OUTPUT_DIR / "final"
    final_dir.mkdir(exist_ok=True)
    model.save_pretrained(str(final_dir))
    tokenizer.save_pretrained(str(final_dir))
    
    # Save merged 16-bit
    print_status("[SAVE] Merging to 16-bit...", "cyan3")
    merged_dir = OUTPUT_DIR / "merged"
    merged_dir.mkdir(exist_ok=True)
    
    model.save_pretrained_merged(
        str(merged_dir),
        tokenizer,
        save_method="merged_16bit",
    )
    tokenizer.save_pretrained(str(merged_dir))
    
    # Verify tokenizer
    verify_tokenizer(merged_dir)
    
    # Save training info
    info = {
        "phase": 2,
        "model": CONFIG["model_name"],
        "training_time": str(train_time),
        "epochs": CONFIG["num_epochs"],
        "total_epochs": 5,
        "examples": len(train_data),
        "context_length": CONFIG["max_seq_length"],
        "learning_rate": CONFIG["learning_rate"],
        "completed": datetime.now().isoformat(),
        "phase1_eval_loss": 0.326,
    }
    
    with open(OUTPUT_DIR / "training_info.json", "w") as f:
        json.dump(info, f, indent=2)
    
    print_status(f"""
╔══════════════════════════════════════════════════════════════════════╗
║  ✅ PHASE 2 COMPLETE                                                 ║
╠══════════════════════════════════════════════════════════════════════╣
║  Time: {train_time}                                       ║
║  Output: {OUTPUT_DIR}                               ║
║  Total epochs trained: 5 (3 + 2)                                     ║
║  Ready to test with: python test_model.py                            ║
╚══════════════════════════════════════════════════════════════════════╝
""", "green4")
    
    return True


if __name__ == "__main__":
    train()
