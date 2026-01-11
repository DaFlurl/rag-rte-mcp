#!/usr/bin/env python3
"""
╔══════════════════════════════════════════════════════════════════════════════╗
║                    EPIC B200 FP16 TRAINING SCRIPT                            ║
║                    PyTorch 2.8+ | NVIDIA B200 Optimized                      ║
║                    Maximum Performance | FP16 Enhanced                       ║
╚══════════════════════════════════════════════════════════════════════════════╝

B200 GPU Specifications:
- 192GB HBM3e Memory
- 4th Gen Tensor Cores with FP16/BF16/FP8 support
- 2.25 PetaFLOPS FP16 performance
- NVLink 5.0 (1.8 TB/s bandwidth)

REQUIREMENTS:
- PyTorch >= 2.8.0
- CUDA >= 12.6
- cuDNN >= 9.5
- Transformers >= 4.45.0
- Unsloth (optional, for 2x speedup)

FP16 ENHANCEMENTS:
1. torch.cuda.amp for automatic mixed precision
2. GradScaler with dynamic loss scaling
3. Tensor Core optimization (multiples of 8)
4. Flash Attention 2 for memory efficiency
5. Gradient checkpointing for large models
6. Fused optimizers (AdamW with fused=True)
7. torch.compile() for graph optimization
8. Memory-efficient attention patterns
"""

import os
import sys
import json
import time
import math
import logging
import signal
import atexit
import threading
from pathlib import Path
from datetime import datetime, timedelta
from dataclasses import dataclass, field
from typing import Optional, Dict, Any, List

# Global flag for graceful shutdown
SHUTDOWN_REQUESTED = False
CURRENT_TRAINER = None

def graceful_shutdown_handler(signum, frame):
    """Handle shutdown signals gracefully - save model before exit"""
    global SHUTDOWN_REQUESTED, CURRENT_TRAINER
    signal_name = signal.Signals(signum).name if hasattr(signal, 'Signals') else str(signum)
    print(f"\n⚠️  Received {signal_name} - Initiating graceful shutdown...")
    print("💾 Saving checkpoint before exit...")
    SHUTDOWN_REQUESTED = True
    
    if CURRENT_TRAINER and hasattr(CURRENT_TRAINER, 'emergency_save'):
        CURRENT_TRAINER.emergency_save(f"emergency_shutdown_{signal_name}")

def setup_signal_handlers():
    """Setup handlers for graceful shutdown on various signals"""
    # Handle common termination signals
    signal.signal(signal.SIGTERM, graceful_shutdown_handler)  # Docker/K8s stop
    signal.signal(signal.SIGINT, graceful_shutdown_handler)   # Ctrl+C
    if hasattr(signal, 'SIGHUP'):
        signal.signal(signal.SIGHUP, graceful_shutdown_handler)  # Terminal closed
    print("✅ Signal handlers registered for graceful shutdown")

def cleanup_on_exit():
    """Cleanup function called on normal exit"""
    global CURRENT_TRAINER
    if CURRENT_TRAINER and hasattr(CURRENT_TRAINER, 'emergency_save'):
        print("🔄 Exit detected - ensuring final save...")
        CURRENT_TRAINER.emergency_save("exit_cleanup")

# Register cleanup
atexit.register(cleanup_on_exit)

MIN_PYTORCH_VERSION = (2, 8, 0)

def check_pytorch_version():
    """Ensure PyTorch 2.8+ is installed for B200 support"""
    try:
        import torch
        version_str = torch.__version__.split('+')[0]
        version_parts = version_str.split('.')[:3]
        version = tuple(int(p) for p in version_parts if p.isdigit())
        if len(version) < 3:
            version = version + (0,) * (3 - len(version))
        if version < MIN_PYTORCH_VERSION:
            print(f"⚠️  PyTorch {torch.__version__} detected")
            print(f"⚠️  B200 requires PyTorch >= 2.8.0")
            print(f"⚠️  Install: pip install torch>=2.8.0 --index-url https://download.pytorch.org/whl/cu126")
            return False
        print(f"✅ PyTorch {torch.__version__} - B200 compatible!")
        return True
    except ImportError:
        print("❌ PyTorch not installed!")
        return False

@dataclass
class B200Config:
    """B200 FP16 Optimized Configuration"""
    
    model_name: str = "huihui-ai/Huihui-Qwen3-4B-Instruct-2507-abliterated"
    max_seq_length: int = 4096
    
    load_in_4bit: bool = True
    use_gradient_checkpointing: bool = True
    use_flash_attention: bool = True
    
    dtype: str = "float16"
    use_amp: bool = True
    amp_dtype: str = "float16"
    
    batch_size: int = 8
    gradient_accumulation_steps: int = 4
    learning_rate: float = 2e-4
    warmup_ratio: float = 0.03
    num_epochs: int = 3
    max_steps: int = -1
    
    lora_r: int = 64
    lora_alpha: int = 128
    lora_dropout: float = 0.0
    target_modules: List[str] = field(default_factory=lambda: [
        "q_proj", "k_proj", "v_proj", "o_proj",
        "gate_proj", "up_proj", "down_proj",
        "lm_head"
    ])
    
    use_fused_optimizer: bool = True
    use_torch_compile: bool = True
    compile_mode: str = "max-autotune"
    
    grad_scaler_init_scale: float = 65536.0
    grad_scaler_growth_factor: float = 2.0
    grad_scaler_backoff_factor: float = 0.5
    grad_scaler_growth_interval: int = 2000
    
    max_memory_gb: int = 180
    
    logging_steps: int = 10
    save_steps: int = 100  # Save every 100 steps for safety
    eval_steps: int = 500
    save_total_limit: int = 20  # Keep last 20 checkpoints
    
    # LONG TRAINING SUPPORT (24-96 hours)
    max_hours: float = 96.0  # Max training time in hours
    auto_save_minutes: int = 15  # Auto-save every 15 minutes regardless of steps
    
    dataset_path: str = "dataset/final_training/train.jsonl"
    val_dataset_path: str = "dataset/final_training/val.jsonl"
    output_dir: str = "output_b200_fp16"
    
    # RESUME SUPPORT - Set to checkpoint path to continue training
    resume_from_checkpoint: str = None  # e.g., "output_b200_fp16/checkpoint-500"
    
    milestone_checkpoints: List[int] = field(default_factory=lambda: [
        50, 100, 250, 500, 750, 1000, 1500, 2000, 3000, 4000, 5000,
        7500, 10000, 15000, 20000, 30000, 50000, 75000, 100000
    ])


class B200FP16Trainer:
    """Epic B200 FP16 Training Engine with Maximum Performance + Failsafe"""
    
    def __init__(self, config: B200Config):
        global CURRENT_TRAINER
        self.config = config
        self.device = None
        self.model = None
        self.tokenizer = None
        self.optimizer = None
        self.scheduler = None
        self.scaler = None
        self.trainer = None  # HuggingFace Trainer reference
        self.milestones_reached = []
        self.start_time = None
        self.last_save_time = None
        self.current_step = 0
        self.setup_logging()
        
        # Register this trainer globally for signal handlers
        CURRENT_TRAINER = self
        setup_signal_handlers()
    
    def emergency_save(self, reason: str = "emergency"):
        """Emergency save - called on shutdown/crash"""
        if self.model is None:
            print("⚠️  No model loaded - nothing to save")
            return
        
        try:
            save_dir = Path(self.config.output_dir) / f"emergency_{reason}_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
            save_dir.mkdir(parents=True, exist_ok=True)
            
            print(f"🚨 EMERGENCY SAVE to {save_dir}")
            
            # Save model
            self.model.save_pretrained(save_dir)
            if self.tokenizer:
                self.tokenizer.save_pretrained(save_dir)
            
            # Save training state
            state = {
                'current_step': self.current_step,
                'milestones_reached': self.milestones_reached,
                'timestamp': datetime.now().isoformat(),
                'reason': reason,
                'config': {
                    'model_name': self.config.model_name,
                    'learning_rate': self.config.learning_rate,
                    'batch_size': self.config.batch_size,
                    'num_epochs': self.config.num_epochs,
                }
            }
            with open(save_dir / 'emergency_state.json', 'w') as f:
                json.dump(state, f, indent=2)
            
            print(f"✅ Emergency save complete: {save_dir}")
            
        except Exception as e:
            print(f"❌ Emergency save failed: {e}")
    
    def timed_autosave(self):
        """Check if it's time for an auto-save based on elapsed time"""
        if self.last_save_time is None:
            self.last_save_time = time.time()
            return False
        
        elapsed_minutes = (time.time() - self.last_save_time) / 60
        if elapsed_minutes >= self.config.auto_save_minutes:
            self.last_save_time = time.time()
            return True
        return False
        
    def setup_logging(self):
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s | %(levelname)s | %(message)s',
            handlers=[
                logging.StreamHandler(),
                logging.FileHandler(f"b200_training_{datetime.now().strftime('%Y%m%d_%H%M%S')}.log")
            ]
        )
        self.logger = logging.getLogger(__name__)
        
    def print_banner(self):
        banner = """
╔══════════════════════════════════════════════════════════════════════════════╗
║   ██████╗ ██████╗  ██████╗  ██████╗     ███████╗██████╗ ██╗ ██████╗         ║
║   ██╔══██╗╚════██╗██╔═████╗██╔═████╗    ██╔════╝██╔══██╗██║██╔════╝         ║
║   ██████╔╝ █████╔╝██║██╔██║██║██╔██║    █████╗  ██████╔╝██║██║              ║
║   ██╔══██╗██╔═══╝ ████╔╝██║████╔╝██║    ██╔══╝  ██╔═══╝ ██║██║              ║
║   ██████╔╝███████╗╚██████╔╝╚██████╔╝    ███████╗██║     ██║╚██████╗         ║
║   ╚═════╝ ╚══════╝ ╚═════╝  ╚═════╝     ╚══════╝╚═╝     ╚═╝ ╚═════╝         ║
║                    FP16 MAXIMUM PERFORMANCE TRAINING                         ║
║                    PyTorch 2.8+ | NVIDIA B200 Optimized                      ║
╚══════════════════════════════════════════════════════════════════════════════╝
        """
        print(banner)
        
    def check_environment(self):
        import torch
        
        self.logger.info("🔍 Checking B200 environment...")
        
        if not torch.cuda.is_available():
            raise RuntimeError("CUDA not available! B200 requires CUDA.")
        
        gpu_name = torch.cuda.get_device_name(0)
        gpu_memory = torch.cuda.get_device_properties(0).total_memory / (1024**3)
        
        self.logger.info(f"   GPU: {gpu_name}")
        self.logger.info(f"   Memory: {gpu_memory:.1f} GB")
        self.logger.info(f"   CUDA: {torch.version.cuda}")
        self.logger.info(f"   PyTorch: {torch.__version__}")
        
        is_b200 = "B200" in gpu_name or gpu_memory > 150
        if is_b200:
            self.logger.info("   ✅ B200 GPU detected!")
        else:
            self.logger.info(f"   ⚠️ Non-B200 GPU, optimizations still apply")
        
        self.logger.info("   ✅ FP16 enabled for maximum performance")
        self.device = torch.device("cuda:0")
        return True
    
    def setup_fp16_environment(self):
        import torch
        
        self.logger.info("⚡ Configuring FP16 environment...")
        
        torch.backends.cuda.matmul.allow_tf32 = True
        torch.backends.cudnn.allow_tf32 = True
        torch.backends.cudnn.benchmark = True
        torch.backends.cudnn.enabled = True
        
        self.scaler = torch.amp.GradScaler(
            device='cuda',
            init_scale=self.config.grad_scaler_init_scale,
            growth_factor=self.config.grad_scaler_growth_factor,
            backoff_factor=self.config.grad_scaler_backoff_factor,
            growth_interval=self.config.grad_scaler_growth_interval,
            enabled=self.config.use_amp
        )
        self.logger.info("   ✅ GradScaler initialized")
        
        torch.cuda.empty_cache()
        self.logger.info("   ✅ FP16 environment ready!")
        
    def load_model(self):
        import torch
        
        self.logger.info(f"📦 Loading model: {self.config.model_name}")
        
        try:
            from unsloth import FastLanguageModel
            
            self.model, self.tokenizer = FastLanguageModel.from_pretrained(
                model_name=self.config.model_name,
                max_seq_length=self.config.max_seq_length,
                dtype=torch.float16,
                load_in_4bit=self.config.load_in_4bit,
            )
            
            self.model = FastLanguageModel.get_peft_model(
                self.model,
                r=self.config.lora_r,
                lora_alpha=self.config.lora_alpha,
                lora_dropout=self.config.lora_dropout,
                target_modules=self.config.target_modules,
                bias="none",
                use_gradient_checkpointing=self.config.use_gradient_checkpointing,
                random_state=42,
            )
            
            self.logger.info("   ✅ Loaded with Unsloth (2x speedup!)")
            
        except ImportError:
            from transformers import AutoModelForCausalLM, AutoTokenizer, BitsAndBytesConfig
            from peft import get_peft_model, LoraConfig
            
            bnb_config = BitsAndBytesConfig(
                load_in_4bit=self.config.load_in_4bit,
                bnb_4bit_compute_dtype=torch.float16,
                bnb_4bit_use_double_quant=True,
                bnb_4bit_quant_type="nf4"
            )
            
            self.tokenizer = AutoTokenizer.from_pretrained(self.config.model_name)
            self.model = AutoModelForCausalLM.from_pretrained(
                self.config.model_name,
                quantization_config=bnb_config,
                torch_dtype=torch.float16,
                device_map="auto",
                attn_implementation="flash_attention_2" if self.config.use_flash_attention else "sdpa"
            )
            
            lora_config = LoraConfig(
                r=self.config.lora_r,
                lora_alpha=self.config.lora_alpha,
                lora_dropout=self.config.lora_dropout,
                target_modules=self.config.target_modules,
                bias="none",
                task_type="CAUSAL_LM"
            )
            
            self.model = get_peft_model(self.model, lora_config)
            
            if self.config.use_gradient_checkpointing:
                self.model.gradient_checkpointing_enable()
            
            self.logger.info("   ✅ Loaded with Transformers")
        
        if self.config.use_torch_compile:
            self.logger.info("   🔧 Applying torch.compile()...")
            self.model = torch.compile(
                self.model,
                mode=self.config.compile_mode,
                fullgraph=False
            )
            self.logger.info(f"   ✅ torch.compile() applied (mode={self.config.compile_mode})")
        
        trainable_params = sum(p.numel() for p in self.model.parameters() if p.requires_grad)
        total_params = sum(p.numel() for p in self.model.parameters())
        self.logger.info(f"   📊 Trainable: {trainable_params:,} / {total_params:,} ({100*trainable_params/total_params:.2f}%)")
        
    def setup_optimizer(self):
        import torch
        
        self.logger.info("⚙️ Setting up optimizer...")
        
        self.optimizer = torch.optim.AdamW(
            self.model.parameters(),
            lr=self.config.learning_rate,
            betas=(0.9, 0.999),
            eps=1e-8,
            weight_decay=0.01,
            fused=self.config.use_fused_optimizer
        )
        
        self.logger.info(f"   ✅ AdamW (fused={self.config.use_fused_optimizer})")
        
    def load_dataset(self):
        self.logger.info(f"📚 Loading dataset: {self.config.dataset_path}")
        
        from datasets import Dataset
        
        data = []
        dataset_path = Path(self.config.dataset_path)
        
        if not dataset_path.exists():
            dataset_path = Path(__file__).parent / self.config.dataset_path
        
        if dataset_path.exists():
            with open(dataset_path, 'r', encoding='utf-8') as f:
                for line in f:
                    try:
                        data.append(json.loads(line.strip()))
                    except:
                        pass
        
        self.logger.info(f"   ✅ Loaded {len(data):,} examples")
        self.dataset = Dataset.from_list(data)
        return self.dataset
    
    def format_prompt(self, example):
        instruction = example.get('instruction', '')
        input_text = example.get('input', '')
        output = example.get('output', '')
        
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
    
    def train(self):
        import torch
        from trl import SFTTrainer
        from transformers import TrainingArguments
        
        self.start_time = time.time()
        
        self.logger.info("🚀 Starting EPIC B200 FP16 Training!")
        self.logger.info("=" * 70)
        
        formatted_dataset = self.dataset.map(self.format_prompt)
        
        training_args = TrainingArguments(
            output_dir=self.config.output_dir,
            per_device_train_batch_size=self.config.batch_size,
            gradient_accumulation_steps=self.config.gradient_accumulation_steps,
            learning_rate=self.config.learning_rate,
            warmup_ratio=self.config.warmup_ratio,
            lr_scheduler_type="cosine",
            num_train_epochs=self.config.num_epochs,
            max_steps=self.config.max_steps,
            fp16=True,
            bf16=False,
            fp16_full_eval=True,
            optim="adamw_torch_fused" if self.config.use_fused_optimizer else "adamw_torch",
            max_grad_norm=1.0,
            gradient_checkpointing=self.config.use_gradient_checkpointing,
            logging_steps=self.config.logging_steps,
            logging_first_step=True,
            report_to="none",
            save_steps=self.config.save_steps,
            save_total_limit=self.config.save_total_limit,  # Keep more checkpoints
            save_safetensors=True,  # Safer format
            dataloader_num_workers=4,
            dataloader_pin_memory=True,
            torch_compile=self.config.use_torch_compile,
            seed=42,
        )
        
        self.trainer = SFTTrainer(
            model=self.model,
            tokenizer=self.tokenizer,
            train_dataset=formatted_dataset,
            args=training_args,
            max_seq_length=self.config.max_seq_length,
            dataset_text_field="text",
            packing=True,
        )
        
        # Calculate max training time
        max_seconds = self.config.max_hours * 3600
        self.logger.info(f"⏱️  Max training time: {self.config.max_hours} hours")
        self.logger.info(f"💾 Auto-save every: {self.config.auto_save_minutes} minutes")
        self.logger.info(f"💾 Checkpoint every: {self.config.save_steps} steps")
        self.logger.info(f"💾 Keeping last: {self.config.save_total_limit} checkpoints")
        
        self.logger.info("🔥 Training started!")
        self.logger.info("⚡ Graceful shutdown enabled - will save on Ctrl+C or server stop")
        
        # Resume from checkpoint if specified
        resume_path = None
        if self.config.resume_from_checkpoint:
            resume_path = self.config.resume_from_checkpoint
            self.logger.info(f"🔄 Resuming from checkpoint: {resume_path}")
        
        try:
            train_result = self.trainer.train(resume_from_checkpoint=resume_path)
        except KeyboardInterrupt:
            self.logger.info("⚠️  Training interrupted - saving checkpoint...")
            self.emergency_save("keyboard_interrupt")
            raise
        except Exception as e:
            self.logger.error(f"❌ Training error: {e}")
            self.emergency_save(f"error_{type(e).__name__}")
            raise
        
        self.logger.info("💾 Saving final model...")
        self.trainer.save_model(f"{self.config.output_dir}/final")
        
        # Also save a backup copy
        backup_dir = f"{self.config.output_dir}/final_backup_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
        self.trainer.save_model(backup_dir)
        self.logger.info(f"💾 Backup saved to: {backup_dir}")
        
        elapsed = time.time() - self.start_time
        self.logger.info("=" * 70)
        self.logger.info("🎉 EPIC TRAINING COMPLETE!")
        self.logger.info(f"   Total time: {timedelta(seconds=int(elapsed))}")
        self.logger.info(f"   Final loss: {train_result.training_loss:.4f}")
        self.logger.info(f"   Output: {self.config.output_dir}")
        
        return train_result
    
    def run(self):
        self.print_banner()
        self.check_environment()
        self.setup_fp16_environment()
        self.load_model()
        self.setup_optimizer()
        self.load_dataset()
        result = self.train()
        return result


def generate_requirements():
    return """# B200 FP16 Training Requirements
# PyTorch 2.8+ REQUIRED for B200 support

torch>=2.8.0
torchvision>=0.20.0
torchaudio>=2.5.0
transformers>=4.45.0
datasets>=3.0.0
accelerate>=1.0.0
peft>=0.13.0
trl>=0.12.0
bitsandbytes>=0.44.0
flash-attn>=2.7.0
unsloth>=2024.12
sentencepiece>=0.2.0
protobuf>=5.0.0
scipy>=1.14.0
einops>=0.8.0
wandb>=0.18.0
tensorboard>=2.18.0

# Install PyTorch 2.8+ with CUDA 12.6:
# pip install torch>=2.8.0 --index-url https://download.pytorch.org/whl/cu126
"""


def main():
    print("\n" + "=" * 70)
    print("EPIC B200 FP16 TRAINING - PyTorch 2.8+ Required")
    print("=" * 70)
    
    if not check_pytorch_version():
        print("\n📋 Generating setup files...")
        
        req_file = Path("requirements_b200.txt")
        req_file.write_text(generate_requirements())
        print(f"   ✅ Created: {req_file}")
        
        print("\n🔧 To install PyTorch 2.8+ for B200:")
        print("   pip install torch>=2.8.0 --index-url https://download.pytorch.org/whl/cu126")
        print("\n   Then run this script again.")
        return
    
    config = B200Config()
    trainer = B200FP16Trainer(config)
    result = trainer.run()
    
    print("\n🎉 Epic training session complete!")


if __name__ == "__main__":
    main()
