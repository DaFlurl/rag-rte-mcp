# Evony AI Training Guide

## Overview

This guide covers fine-tuning a local LLM on Evony knowledge using Unsloth + LoRA.

**When to fine-tune:**
- After RAG is working well
- When you need consistent Evony vocabulary
- For faster responses without retrieval
- To embed common knowledge directly in the model

## Hardware Requirements

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| GPU | RTX 3080 (10GB) | RTX 3090/4090 (24GB) |
| RAM | 16GB | 32GB |
| Disk | 20GB free | 50GB free |

**Current Setup:** RTX 3090 Ti (24GB VRAM)

## Training Data

### Location
```
c:\Users\Admin\Downloads\Evony_Decrypted\Evony_Training_Data\
```

### Format (Alpaca)
```json
{
  "instruction": "What parameters does the army.newArmy command accept?",
  "input": "",
  "output": "The army.newArmy command accepts the following parameters:\n- cityId: The ID of the city...",
  "category": "protocol"
}
```

### Statistics
- **Total Examples**: 36,370
- **Categories**: code, protocol, keys, scripts, exploits
- **Average Length**: ~500 tokens per example

## Setup

### 1. Install Dependencies

Run the setup script:
```batch
SETUP_EVONY_AI.bat
```

Or manually:
```bash
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124
pip install "unsloth[colab-new] @ git+https://github.com/unslothai/unsloth.git"
pip install transformers trl peft bitsandbytes datasets accelerate
```

### 2. Verify Installation

```python
import torch
print(f"CUDA available: {torch.cuda.is_available()}")
print(f"GPU: {torch.cuda.get_device_name(0)}")

from unsloth import FastLanguageModel
print("Unsloth loaded successfully")
```

## Training Configuration

### Model Settings

```python
# Base model
model_name = "unsloth/Qwen2.5-3B-Instruct"

# Quantization
load_in_4bit = True

# LoRA configuration
lora_config = {
    "r": 64,                    # Rank
    "lora_alpha": 16,           # Scaling
    "lora_dropout": 0,          # No dropout
    "target_modules": [
        "q_proj", "k_proj", "v_proj", "o_proj",
        "gate_proj", "up_proj", "down_proj"
    ],
}
```

### Training Parameters

```python
training_args = {
    "per_device_train_batch_size": 4,
    "gradient_accumulation_steps": 4,  # Effective batch = 16
    "learning_rate": 2e-4,
    "num_train_epochs": 3,
    "max_seq_length": 2048,
    "warmup_steps": 100,
    "weight_decay": 0.01,
    "optim": "adamw_8bit",
    "fp16": True,
    "logging_steps": 10,
    "save_steps": 500,
}
```

### Memory Optimization

For 24GB VRAM:
- 4-bit quantization: Saves ~75% memory
- Gradient checkpointing: Trades compute for memory
- 8-bit optimizer: Reduces optimizer state size

## Running Training

### Start Training

```batch
TRAIN_EVONY_AI.bat
```

Or manually:
```bash
cd c:\Users\Admin\Downloads\Evony_Decrypted
python evony_ai/train_unsloth.py
```

### Expected Output

```
Loading model...
Model loaded in 4-bit mode
Applying LoRA adapters...
Loading training data...
Found 36,370 examples
Starting training...
Epoch 1/3: 100%|████████| 2273/2273 [45:00<00:00]
  Loss: 1.234
Epoch 2/3: 100%|████████| 2273/2273 [45:00<00:00]
  Loss: 0.567
Epoch 3/3: 100%|████████| 2273/2273 [45:00<00:00]
  Loss: 0.345
Training complete!
Saving adapter to evony_ai/evony_lora_adapter/
```

### Training Time Estimates

| GPU | Time (3 epochs) |
|-----|-----------------|
| RTX 3090 Ti | 2-3 hours |
| RTX 4090 | 1.5-2 hours |
| RTX 3080 | 3-4 hours |

## Output Files

```
evony_ai/
├── evony_lora_adapter/       # LoRA weights (~100MB)
│   ├── adapter_config.json
│   ├── adapter_model.safetensors
│   └── tokenizer/
├── evony_merged/             # Full merged model (optional)
└── training_logs/            # TensorBoard logs
```

## Testing the Model

### Interactive Chat

```batch
CHAT_EVONY_AI.bat
```

### Example Session

```
[You]: What is ACTION_KEY used for?

[Evony AI]: ACTION_KEY is a critical encryption key used for signing 
AMF requests to the Evony server. It's defined as:
"TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"

The key is used in the request signing process to prevent tampering...

[You]: How do I calculate overflow thresholds?

[Evony AI]: Overflow thresholds are calculated using INT32_MAX divided 
by the resource cost plus one:

threshold = (2^31 - 1) / cost + 1

For example, for Archers (cost = 350):
threshold = 2147483647 / 350 + 1 = 6,135,037
```

## Exporting to GGUF

For LM Studio deployment:

```python
from unsloth import FastLanguageModel

# Load trained model
model, tokenizer = FastLanguageModel.from_pretrained(
    "evony_ai/evony_lora_adapter",
    load_in_4bit=True,
)

# Merge LoRA weights
model = model.merge_and_unload()

# Export to GGUF
model.save_pretrained_gguf(
    "evony_ai/evony_gguf",
    tokenizer,
    quantization_method="q4_k_m"
)
```

### GGUF Quantization Options

| Method | Size | Quality |
|--------|------|---------|
| q4_k_m | ~2GB | Good balance |
| q5_k_m | ~2.5GB | Better quality |
| q8_0 | ~3.5GB | Best quality |

## Using in LM Studio

1. Copy GGUF file to: `C:\Users\Admin\.lmstudio\models\evony-ai\`
2. Restart LM Studio
3. Load the model from the models list
4. Set context length to 4096+

## Combining with RAG

Best approach: RAG + Fine-tuned model

1. RAG provides context and citations
2. Fine-tuned model understands Evony vocabulary
3. Combined: Accurate answers with source references

```python
# In api_v2.py, update LM Studio endpoint to use fine-tuned model
LMSTUDIO_URL = "http://localhost:1234/v1"
# Load your fine-tuned evony model in LM Studio
```

## Troubleshooting

### Out of Memory

```python
# Reduce batch size
per_device_train_batch_size = 2
gradient_accumulation_steps = 8  # Keep effective batch = 16

# Enable gradient checkpointing
model.gradient_checkpointing_enable()
```

### Slow Training

```python
# Increase batch size if VRAM allows
per_device_train_batch_size = 8

# Use bf16 instead of fp16 on Ampere+ GPUs
bf16 = True
fp16 = False
```

### Poor Quality Output

- Increase epochs (3 → 5)
- Increase LoRA rank (64 → 128)
- Check training data quality
- Lower learning rate (2e-4 → 1e-4)

## Next Steps

After training:
1. Test with CHAT_EVONY_AI.bat
2. Export to GGUF if deploying to LM Studio
3. Update RAG to use fine-tuned model
4. Compare RAG-only vs RAG+fine-tuned responses
