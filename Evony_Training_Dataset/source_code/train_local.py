"""
Evony AI Local Training Script
===============================
Fine-tune a 3B model locally using QLoRA on RTX 3090 Ti.
"""

import os
import json
import torch
from pathlib import Path
from datetime import datetime
from typing import Optional

# Set environment before imports
os.environ["CUDA_VISIBLE_DEVICES"] = "0"
os.environ["TOKENIZERS_PARALLELISM"] = "false"

from transformers import (
    AutoModelForCausalLM,
    AutoTokenizer,
    BitsAndBytesConfig,
    TrainingArguments,
    DataCollatorForSeq2Seq,
)
from peft import LoraConfig, get_peft_model, prepare_model_for_kbit_training
from datasets import load_dataset
from trl import SFTTrainer
from rich.console import Console
from rich.progress import Progress

console = Console()

# Default configuration
DEFAULT_CONFIG = {
    # Model selection - Qwen2.5-3B is excellent for code
    "model_id": "Qwen/Qwen2.5-3B-Instruct",
    
    # Alternative models (uncomment to use):
    # "model_id": "microsoft/Phi-3.5-mini-instruct",  # 3.8B, good for code
    # "model_id": "mistralai/Mistral-7B-Instruct-v0.2",  # 7B, needs more VRAM
    
    # QLoRA settings for RTX 3090 Ti (24GB)
    "load_in_4bit": True,
    "bnb_4bit_compute_dtype": "bfloat16",
    "bnb_4bit_quant_type": "nf4",
    "bnb_4bit_use_double_quant": True,
    
    # LoRA configuration
    "lora_r": 64,
    "lora_alpha": 128,
    "lora_dropout": 0.05,
    "lora_target_modules": ["q_proj", "k_proj", "v_proj", "o_proj", 
                            "gate_proj", "up_proj", "down_proj"],
    
    # Training parameters
    "num_train_epochs": 3,
    "per_device_train_batch_size": 4,
    "per_device_eval_batch_size": 4,
    "gradient_accumulation_steps": 4,
    "learning_rate": 2e-4,
    "weight_decay": 0.01,
    "warmup_ratio": 0.03,
    "lr_scheduler_type": "cosine",
    "max_seq_length": 2048,
    
    # Optimization
    "optim": "paged_adamw_8bit",
    "fp16": False,
    "bf16": True,
    "gradient_checkpointing": True,
    
    # Logging
    "logging_steps": 10,
    "save_steps": 100,
    "eval_steps": 100,
    "save_total_limit": 3,
}


class EvonyTrainer:
    def __init__(self, config: dict, data_path: str, output_path: str):
        self.config = config
        self.data_path = Path(data_path)
        self.output_path = Path(output_path)
        self.output_path.mkdir(parents=True, exist_ok=True)
        
        self.model = None
        self.tokenizer = None
        self.dataset = None
    
    def check_gpu(self):
        """Check GPU availability and memory."""
        console.print("\n[bold cyan]Checking GPU...[/]")
        
        if not torch.cuda.is_available():
            console.print("[bold red]ERROR: No CUDA GPU available![/]")
            console.print("QLoRA training requires an NVIDIA GPU.")
            return False
        
        gpu_name = torch.cuda.get_device_name(0)
        gpu_memory = torch.cuda.get_device_properties(0).total_memory / 1e9
        
        console.print(f"GPU: [green]{gpu_name}[/]")
        console.print(f"VRAM: [green]{gpu_memory:.1f} GB[/]")
        
        if gpu_memory < 16:
            console.print("[yellow]Warning: Less than 16GB VRAM. Training may be slow.[/]")
        
        return True
    
    def load_tokenizer(self):
        """Load tokenizer."""
        console.print(f"\n[bold cyan]Loading tokenizer: {self.config['model_id']}[/]")
        
        self.tokenizer = AutoTokenizer.from_pretrained(
            self.config['model_id'],
            trust_remote_code=True,
            padding_side="right"
        )
        
        if self.tokenizer.pad_token is None:
            self.tokenizer.pad_token = self.tokenizer.eos_token
        
        console.print("[green]Tokenizer loaded![/]")
    
    def load_model(self):
        """Load model with QLoRA configuration."""
        console.print(f"\n[bold cyan]Loading model with QLoRA...[/]")
        
        # BitsAndBytes config for 4-bit quantization
        bnb_config = BitsAndBytesConfig(
            load_in_4bit=self.config['load_in_4bit'],
            bnb_4bit_quant_type=self.config['bnb_4bit_quant_type'],
            bnb_4bit_compute_dtype=getattr(torch, self.config['bnb_4bit_compute_dtype']),
            bnb_4bit_use_double_quant=self.config['bnb_4bit_use_double_quant'],
        )
        
        # Load model
        self.model = AutoModelForCausalLM.from_pretrained(
            self.config['model_id'],
            quantization_config=bnb_config,
            device_map="auto",
            trust_remote_code=True,
            torch_dtype=torch.bfloat16,
        )
        
        # Prepare for training
        self.model = prepare_model_for_kbit_training(self.model)
        
        # LoRA config
        lora_config = LoraConfig(
            r=self.config['lora_r'],
            lora_alpha=self.config['lora_alpha'],
            lora_dropout=self.config['lora_dropout'],
            target_modules=self.config['lora_target_modules'],
            bias="none",
            task_type="CAUSAL_LM",
        )
        
        # Apply LoRA
        self.model = get_peft_model(self.model, lora_config)
        
        # Print trainable parameters
        trainable_params = sum(p.numel() for p in self.model.parameters() if p.requires_grad)
        total_params = sum(p.numel() for p in self.model.parameters())
        
        console.print(f"[green]Model loaded![/]")
        console.print(f"Trainable parameters: [cyan]{trainable_params:,}[/] ({100*trainable_params/total_params:.2f}%)")
        console.print(f"Total parameters: [cyan]{total_params:,}[/]")
    
    def load_dataset(self):
        """Load training dataset."""
        console.print(f"\n[bold cyan]Loading dataset...[/]")
        
        train_file = self.data_path / "train.json"
        val_file = self.data_path / "val.json"
        
        if not train_file.exists():
            console.print(f"[bold red]ERROR: Training data not found at {train_file}[/]")
            console.print("Run generate_dataset.py first!")
            return False
        
        # Load dataset
        self.dataset = load_dataset(
            'json',
            data_files={
                'train': str(train_file),
                'validation': str(val_file) if val_file.exists() else str(train_file)
            }
        )
        
        console.print(f"[green]Dataset loaded![/]")
        console.print(f"Training samples: [cyan]{len(self.dataset['train']):,}[/]")
        console.print(f"Validation samples: [cyan]{len(self.dataset['validation']):,}[/]")
        
        return True
    
    def format_prompt(self, sample: dict) -> str:
        """Format sample into training prompt."""
        instruction = sample.get('instruction', '')
        input_text = sample.get('input', '')
        output = sample.get('output', '')
        
        # Alpaca-style format
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
        
        return prompt
    
    def train(self):
        """Run training."""
        console.print(f"\n[bold cyan]Starting training...[/]")
        
        # Training arguments
        training_args = TrainingArguments(
            output_dir=str(self.output_path / "checkpoints"),
            num_train_epochs=self.config['num_train_epochs'],
            per_device_train_batch_size=self.config['per_device_train_batch_size'],
            per_device_eval_batch_size=self.config['per_device_eval_batch_size'],
            gradient_accumulation_steps=self.config['gradient_accumulation_steps'],
            learning_rate=self.config['learning_rate'],
            weight_decay=self.config['weight_decay'],
            warmup_ratio=self.config['warmup_ratio'],
            lr_scheduler_type=self.config['lr_scheduler_type'],
            optim=self.config['optim'],
            fp16=self.config['fp16'],
            bf16=self.config['bf16'],
            gradient_checkpointing=self.config['gradient_checkpointing'],
            logging_steps=self.config['logging_steps'],
            save_steps=self.config['save_steps'],
            eval_strategy="steps",
            eval_steps=self.config['eval_steps'],
            save_total_limit=self.config['save_total_limit'],
            load_best_model_at_end=True,
            report_to="none",
            run_name=f"evony-ai-{datetime.now().strftime('%Y%m%d-%H%M%S')}",
        )
        
        # SFT Trainer
        trainer = SFTTrainer(
            model=self.model,
            tokenizer=self.tokenizer,
            train_dataset=self.dataset['train'],
            eval_dataset=self.dataset['validation'],
            args=training_args,
            max_seq_length=self.config['max_seq_length'],
            formatting_func=self.format_prompt,
            packing=False,
        )
        
        # Train
        console.print("[bold green]Training started![/]")
        console.print("This may take 2-4 hours on RTX 3090 Ti...")
        
        trainer.train()
        
        # Save final model
        final_path = self.output_path / "evony_assistant"
        trainer.save_model(str(final_path))
        self.tokenizer.save_pretrained(str(final_path))
        
        console.print(f"\n[bold green]Training complete![/]")
        console.print(f"Model saved to: [cyan]{final_path}[/]")
    
    def run(self):
        """Run full training pipeline."""
        console.print("\n" + "="*60)
        console.print("[bold magenta]EVONY AI LOCAL TRAINER[/]")
        console.print("="*60)
        
        if not self.check_gpu():
            return
        
        self.load_tokenizer()
        self.load_model()
        
        if not self.load_dataset():
            return
        
        self.train()
        
        console.print("\n" + "="*60)
        console.print("[bold green]TRAINING COMPLETE![/]")
        console.print("="*60)
        console.print(f"\nTo use your model:")
        console.print(f"  python inference.py --model {self.output_path / 'evony_assistant'}")


def main():
    data_path = Path(__file__).parent.parent / "data" / "training"
    output_path = Path(__file__).parent.parent / "models"
    
    trainer = EvonyTrainer(DEFAULT_CONFIG, str(data_path), str(output_path))
    trainer.run()


if __name__ == "__main__":
    main()
