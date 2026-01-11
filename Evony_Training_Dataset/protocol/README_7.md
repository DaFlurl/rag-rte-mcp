# Evony AI Training System

## Overview
Train a specialized 3B Vision-Language model on Evony reverse engineering data to create an intelligent assistant for:
- Protocol analysis and command generation
- Exploit discovery and glitch calculation
- Script writing and automation
- Game mechanics understanding

## Dataset Summary
- **108,502 files** (~12.7 GB raw data)
- AS3 source code (3,200+ classes)
- Python tools and scripts (1,500+)
- Protocol documentation
- Encryption keys and signatures
- Exploit databases
- Game mechanics documentation

## Recommended Model Options

### Option 1: Qwen2.5-VL-3B (Recommended)
- **Size**: 3B parameters
- **VRAM**: ~8GB for inference, ~16GB for LoRA training
- **Strengths**: Excellent code understanding, multilingual
- **HuggingFace**: `Qwen/Qwen2.5-VL-3B-Instruct`

### Option 2: Phi-3.5-Vision-Instruct
- **Size**: 4.2B parameters  
- **VRAM**: ~10GB inference, ~20GB training
- **Strengths**: Strong reasoning, good for code
- **HuggingFace**: `microsoft/Phi-3.5-vision-instruct`

### Option 3: LLaVA-1.6-Mistral-7B (If you want larger)
- **Size**: 7B parameters
- **VRAM**: ~16GB inference, ~24GB+ training
- **Strengths**: Best quality, strong reasoning

## Training Strategy

### Phase 1: Local Data Preparation (RTX 3090 Ti)
1. Collect and structure all Evony data
2. Generate Q&A pairs from source code
3. Create instruction-following dataset
4. Validate and clean data

### Phase 2: Local LoRA Training (RTX 3090 Ti - 24GB)
- Use QLoRA (4-bit quantization + LoRA)
- Train on 3B model locally
- ~2-4 hours for initial training
- Iterate and improve

### Phase 3: Cloud Training (Optional - A100/H100)
- If local results are good, scale up on HuggingFace
- A100 40GB: ~$2/hour on HuggingFace
- H100 80GB: ~$4/hour
- Full fine-tune possible in 2-4 hours

## Quick Start

```bash
# Install dependencies
pip install -r requirements.txt

# Collect and process data
python collect_data.py

# Generate training dataset
python generate_dataset.py

# Train locally with QLoRA
python train_local.py

# (Optional) Push to HuggingFace for cloud training
python push_to_hub.py
```

## Hardware Requirements

### Local (RTX 3090 Ti - 24GB)
- QLoRA training: ✅ Supported
- 3B model fine-tune: ✅ Supported
- 7B model fine-tune: ⚠️ Marginal (use 4-bit)

### Cloud (HuggingFace)
- A100 40GB: Full fine-tune 3B-7B
- H100 80GB: Full fine-tune up to 13B

## Dataset Structure

```
evony_ai/
├── data/
│   ├── raw/              # Collected raw data
│   ├── processed/        # Cleaned and structured
│   └── training/         # Final training format
├── scripts/
│   ├── collect_data.py   # Data collection
│   ├── generate_dataset.py # Q&A generation
│   └── train_local.py    # Local training
├── models/
│   └── evony_assistant/  # Trained model output
└── configs/
    └── training_config.yaml
```
