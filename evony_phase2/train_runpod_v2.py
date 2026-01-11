#!/usr/bin/env python3
"""
RunPod Training Script - Phase 2 (Optimized Speed)
Qwen2.5-Coder-7B QLoRA SFT - Evony Specialization

PHASE 2 OPTIMIZATIONS (based on Phase 1 results + ChatGPT 5.2 analysis):
- Context: 8192 → 4096 (1.5-2x speedup)
- Batch: 8 x 4 = 32 effective (same quality, faster)
- LR: 2e-5 → 1e-5 (refinement phase)
- Guardrail target: 0.6 → 0.5 (realistic for this config)

Phase 1 Results:
- 3 epochs, eval_loss 0.326 (still dropping = more training helps)
- 0.445 steps/sec average
- No overfitting detected
"""

import os
import json
import torch
from pathlib import Path
from datetime import datetime

# Paths
WORKSPACE = Path("/workspace")
DATA_DIR = WORKSPACE / "data"
OUTPUT_DIR = WORKSPACE / "output_phase2"

# ============================================================
# PHASE 2 OPTIMIZED CONFIG
# ============================================================
CONFIG = {
    # Model (same as Phase 1)
    "model_name": "huihui-ai/Qwen2.5-Coder-7B-Instruct-abliterated",
    
    # SPEED OPTIMIZATIONS (Claude-approved conservative settings)
    "max_seq_length": 4096,     # Was 8192 - BIGGEST SPEEDUP
    "batch_size": 4,            # Keep at 4 (safer, test before increasing)
    "gradient_accumulation": 4,  # Effective batch = 16 (fine for refinement)
    
    # REFINEMENT SETTINGS
    "learning_rate": 1e-5,      # Was 2e-5 - lower for Phase 2
    "num_epochs": 2,            # +2 epochs first, TEST, then decide
    "warmup_ratio": 0.03,       # Lower warmup for continuation
    
    # LoRA (same as Phase 1 - worked well)
    "load_in_4bit": True,
    "lora_r": 32,
    "lora_alpha": 64,
    "lora_dropout": 0.0,        # Fast path
    
    # Packing
    "packing": True,            # ON for text-only
}

# UPDATED GUARDRAILS - Realistic for 4k context
GUARDRAILS = {
    "min_steps_per_sec": 0.3,        # STOP threshold (was 0.25)
    "good_steps_per_sec": 0.5,       # Target (was 0.6 - unrealistic)
    "borderline_steps_per_sec": 0.4, # Warning zone
    "warmup_minutes": 3,              # Shorter warmup (model already compiled)
    "check_after_minutes": 8,         # Earlier check
    "session_hours": 3.0,             # Max session
    "cost_per_hour": 3.59,            # H200 SXM rate
    "save_steps": 400,                # More frequent saves
    "save_total_limit": 3,            # Keep last 3
}


def setup_environment():
    """Setup training environment"""
    print("Setting up environment...")
    OUTPUT_DIR.mkdir(exist_ok=True)
    
    if torch.cuda.is_available():
        gpu = torch.cuda.get_device_name(0)
        mem = torch.cuda.get_device_properties(0).total_memory / 1024**3
        print(f"GPU: {gpu} ({mem:.1f}GB)")
        
        if "H100" in gpu or "H200" in gpu:
            print("H100/H200 detected - Phase 2 optimized settings")
        elif "A100" in gpu:
            CONFIG["batch_size"] = 4  # Slightly lower for A100
            print("A100 detected - adjusted batch size")
        else:
            CONFIG["batch_size"] = 2
            CONFIG["max_seq_length"] = 2048
            print("Unknown GPU - conservative settings")
    else:
        print("ERROR: No GPU detected!")
        return False
    
    return True


def load_dataset():
    """Load training data"""
    print("\nLoading dataset...")
    
    # Use complete source (12,304 examples)
    train_file = DATA_DIR / "train_complete_source.jsonl"
    val_file = DATA_DIR / "val_normalized.jsonl"
    
    if not train_file.exists():
        train_file = DATA_DIR / "train_perfect_messages.jsonl"
    if not val_file.exists():
        val_file = DATA_DIR / "val_multitask.jsonl"
    
    if not train_file.exists():
        print(f"ERROR: Training data not found!")
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
    
    return {"text": text}


def train():
    """Main training function - Phase 2"""
    print("=" * 70)
    print("  ╔═╗╦  ╦╔═╗╔╗╔╦ ╦  ╔═╗╔═╗╔╦╗╔═╗╦═╗  ╔═╗╦ ╦╔═╗╔═╗╔═╗  ╔═╗")
    print("  ║╣ ╚╗╔╝║ ║║║║╚╦╝  ║  ║ ║ ║║║╣ ╠╦╝  ╠═╝╠═╣╠═╣╚═╗║╣   ╔═╝")
    print("  ╚═╝ ╚╝ ╚═╝╝╚╝ ╩   ╚═╝╚═╝═╩╝╚═╝╩╚═  ╩  ╩ ╩╩ ╩╚═╝╚═╝  ╚═╝")
    print("=" * 70)
    print(f"  Started: {datetime.now()}")
    print(f"  Model: {CONFIG['model_name']}")
    print("=" * 70)
    
    if not setup_environment():
        return False
    
    # Import Unsloth
    from unsloth import FastLanguageModel, is_bfloat16_supported
    from trl import SFTTrainer
    from transformers import TrainingArguments, TrainerCallback
    import time
    
    # =================================================================
    # GUARDRAIL CALLBACK - Phase 2 version
    # =================================================================
    class GuardrailCallback(TrainerCallback):
        def __init__(self):
            self.start_time = None
            self.step_times = []
            self.warned = False
            self.phase1_loss = 0.326  # Track improvement from Phase 1
            
        def on_train_begin(self, args, state, control, **kwargs):
            self.start_time = time.time()
            print(f"""
╔══════════════════════════════════════════════════════════════════════╗
║  PHASE 2 GUARDRAILS ACTIVE                                           ║
║  Auto-stop if < {GUARDRAILS['min_steps_per_sec']:.2f} steps/sec after {GUARDRAILS['check_after_minutes']} minutes                      ║
║  Target: >= {GUARDRAILS['good_steps_per_sec']:.2f} steps/sec (realistic for 4k context)                  ║
║  Phase 1 eval_loss: {self.phase1_loss:.3f} - watching for improvement                  ║
╚══════════════════════════════════════════════════════════════════════╝
""")
        
        def on_step_end(self, args, state, control, **kwargs):
            now = time.time()
            self.step_times.append((now, state.global_step))
            
            if len(self.step_times) > 200:
                self.step_times = self.step_times[-200:]
            
            # Check every 50 steps
            if state.global_step % 50 == 0 and state.global_step > 0:
                elapsed_min = (now - self.start_time) / 60
                steps_sec = self._get_steps_per_sec()
                projected = self._project_total_steps(steps_sec, state.global_step)
                
                status = self._get_status(steps_sec)
                
                # Color-coded status
                if status == "EXCELLENT":
                    status_str = f"[EXCELLENT] ★★★"
                elif status == "GOOD":
                    status_str = f"[GOOD] ★★"
                elif status == "OK":
                    status_str = f"[OK] ★"
                else:
                    status_str = f"[{status}]"
                
                print(f"[GUARDRAIL] {elapsed_min:.1f}min | {steps_sec:.3f} s/s | "
                      f"Projected: {projected:,} steps | {status_str}")
                
                # Enforce guardrails after warmup
                if elapsed_min >= GUARDRAILS['check_after_minutes']:
                    if steps_sec < GUARDRAILS['min_steps_per_sec']:
                        print(f"""
╔══════════════════════════════════════════════════════════════════════╗
║  ⛔ GUARDRAIL TRIGGERED - STOPPING                                    ║
║  Speed: {steps_sec:.3f} steps/sec (min: {GUARDRAILS['min_steps_per_sec']})                                ║
║  Reduce batch_size or context further                                ║
╚══════════════════════════════════════════════════════════════════════╝
""")
                        control.should_training_stop = True
                        
                    elif steps_sec < GUARDRAILS['borderline_steps_per_sec'] and not self.warned:
                        print(f"  [WARNING] Speed borderline - monitor closely")
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
        
        def _get_status(self, steps_sec):
            if steps_sec >= 0.8:
                return "EXCELLENT"
            elif steps_sec >= GUARDRAILS['good_steps_per_sec']:
                return "GOOD"
            elif steps_sec >= GUARDRAILS['borderline_steps_per_sec']:
                return "OK"
            elif steps_sec >= GUARDRAILS['min_steps_per_sec']:
                return "BORDERLINE"
            else:
                return "TOO SLOW"
        
        def on_train_end(self, args, state, control, **kwargs):
            elapsed_min = (time.time() - self.start_time) / 60
            steps_sec = self._get_steps_per_sec()
            cost = (elapsed_min / 60) * GUARDRAILS['cost_per_hour']
            
            print(f"""
╔══════════════════════════════════════════════════════════════════════╗
║  ✅ PHASE 2 TRAINING COMPLETE                                        ║
╠══════════════════════════════════════════════════════════════════════╣
║  Duration: {elapsed_min:.1f} minutes                                              ║
║  Total Steps: {state.global_step:,}                                            ║
║  Average Speed: {steps_sec:.3f} steps/sec                                     ║
║  Estimated Cost: ~${cost:.2f}                                            ║
╚══════════════════════════════════════════════════════════════════════╝
""")
    
    # Load data
    train_data, val_data = load_dataset()
    if train_data is None:
        return False
    
    # Format
    train_data = train_data.map(format_messages)
    val_data = val_data.map(format_messages)
    
    # Load model
    print(f"\n[MODEL] Loading {CONFIG['model_name']}...")
    print(f"        Context: {CONFIG['max_seq_length']} tokens (optimized)")
    
    model, tokenizer = FastLanguageModel.from_pretrained(
        model_name=CONFIG["model_name"],
        max_seq_length=CONFIG["max_seq_length"],
        load_in_4bit=CONFIG["load_in_4bit"],
        dtype=None,
    )
    
    # Apply LoRA
    print("[LORA] Applying adapters...")
    
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
    
    # Training args
    effective_batch = CONFIG['batch_size'] * CONFIG['gradient_accumulation']
    estimated_steps = (len(train_data) * CONFIG['num_epochs']) // effective_batch
    expected_time = estimated_steps / 0.7  # Estimate at 0.7 steps/sec
    
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
    
    # Trainer
    guardrail_callback = GuardrailCallback()
    
    trainer = SFTTrainer(
        model=model,
        tokenizer=tokenizer,
        train_dataset=train_data,
        eval_dataset=val_data,
        dataset_text_field="text",
        max_seq_length=CONFIG["max_seq_length"],
        args=training_args,
        callbacks=[guardrail_callback],
    )
    
    # Print config summary
    print(f"""
╔══════════════════════════════════════════════════════════════════════╗
║  PHASE 2 TRAINING CONFIGURATION                                      ║
╠══════════════════════════════════════════════════════════════════════╣
║  Epochs: {CONFIG['num_epochs']} (+7 from Phase 1)                                        ║
║  Dataset: {len(train_data):,} examples                                         ║
║  Batch: {CONFIG['batch_size']} x {CONFIG['gradient_accumulation']} = {effective_batch} effective                                   ║
║  Context: {CONFIG['max_seq_length']} tokens (was 8192)                                  ║
║  Learning Rate: {CONFIG['learning_rate']} (refinement)                              ║
║  Estimated Steps: ~{estimated_steps:,}                                          ║
║  Expected Time: ~{expected_time/60:.0f} minutes                                        ║
╚══════════════════════════════════════════════════════════════════════╝
""")
    
    # Train
    start_time = datetime.now()
    trainer.train()
    train_time = datetime.now() - start_time
    
    # Save
    print("\n[SAVE] Saving model...")
    
    # Save LoRA adapter
    final_dir = OUTPUT_DIR / "final"
    final_dir.mkdir(exist_ok=True)
    model.save_pretrained(str(final_dir))
    tokenizer.save_pretrained(str(final_dir))
    
    # Save merged 16-bit
    print("[SAVE] Merging to 16-bit...")
    merged_dir = OUTPUT_DIR / "merged"
    merged_dir.mkdir(exist_ok=True)
    
    model.save_pretrained_merged(
        str(merged_dir),
        tokenizer,
        save_method="merged_16bit",
    )
    tokenizer.save_pretrained(str(merged_dir))
    
    # TOKENIZER VERIFICATION (Claude fix)
    print("[VERIFY] Checking tokenizer files...")
    required_files = ["tokenizer.json", "tokenizer_config.json", "special_tokens_map.json"]
    optional_files = ["vocab.json", "merges.txt", "tokenizer.model"]
    
    missing_required = []
    for f in required_files:
        if not (merged_dir / f).exists():
            missing_required.append(f)
    
    if missing_required:
        print(f"[ERROR] Missing required tokenizer files: {missing_required}")
        print("[FIX] Copying from base model cache...")
        import shutil
        cache_dir = Path.home() / ".cache/huggingface/hub"
        for pattern in cache_dir.glob("models--huihui-ai--Qwen2.5-Coder*"):
            for snapshot in (pattern / "snapshots").glob("*"):
                for f in missing_required:
                    src = snapshot / f
                    if src.exists():
                        shutil.copy(src, merged_dir / f)
                        print(f"  Copied {f}")
    
    # Final verification
    print("[VERIFY] Final tokenizer check:")
    for f in required_files + optional_files:
        status = "✓" if (merged_dir / f).exists() else "✗"
        print(f"  {status} {f}")
    
    # Save info
    info = {
        "phase": 2,
        "model": CONFIG["model_name"],
        "training_time": str(train_time),
        "epochs": CONFIG["num_epochs"],
        "total_epochs": 5,  # 3 + 2 (test before adding more)
        "examples": len(train_data),
        "context_length": CONFIG["max_seq_length"],
        "learning_rate": CONFIG["learning_rate"],
        "completed": datetime.now().isoformat(),
        "phase1_eval_loss": 0.326,
    }
    
    with open(OUTPUT_DIR / "training_info.json", "w") as f:
        json.dump(info, f, indent=2)
    
    print(f"""
╔══════════════════════════════════════════════════════════════════════╗
║  ✅ PHASE 2 COMPLETE                                                 ║
╠══════════════════════════════════════════════════════════════════════╣
║  Time: {train_time}                                       ║
║  Output: {OUTPUT_DIR}                               ║
║  Total epochs trained: 10 (3 + 7)                                    ║
╚══════════════════════════════════════════════════════════════════════╝
""")
    
    return True


if __name__ == "__main__":
    train()
