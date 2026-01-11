# Evony Model Training Guide

## Overview

This guide covers training a custom Evony knowledge model using QLoRA on Qwen2.5-VL-7B.

## Training Pipeline

```
Dataset (10k examples)
        │
        ▼
┌───────────────────┐
│  Data Preparation │  ← prepare_multitask.py
│  (RAG-native fmt) │
└───────────────────┘
        │
        ▼
┌───────────────────┐
│   QLoRA Training  │  ← train_runpod.py
│   (H100 80GB)     │
└───────────────────┘
        │
        ▼
┌───────────────────┐
│    Evaluation     │  ← evaluate.py
│   (vs base model) │
└───────────────────┘
        │
        ▼
┌───────────────────┐
│   LoRA Adapter    │  ← output/final/
│   (deployable)    │
└───────────────────┘
```

## Dataset Structure

### Task Buckets (RAG-Native)

| Bucket | Weight | Description |
|--------|--------|-------------|
| `gui_widget_map` | 20% | Screenshot → JSON widget map |
| `gui_action_plan` | 20% | Screenshot → step-by-step actions |
| `evidence_explain` | 15% | Code chunks → explanation + citations |
| `evidence_summarize` | 15% | Retrieved data → summary + citations |
| `patch_plan` | 10% | Evidence → patch plan + diff |
| `patch_validate` | 10% | Patch → validation tests |
| `query_synthesis` | 10% | Uncertainty → retrieval queries |

### Example Format

```json
{
  "messages": [
    {
      "role": "system",
      "content": "You explain code with citations..."
    },
    {
      "role": "user", 
      "content": "[EVIDENCE] Explain army.newArmy"
    },
    {
      "role": "assistant",
      "content": "The `army.newArmy` command... `@source_code/ArmyCommands.as:45-60`"
    }
  ],
  "task": "evidence_explain"
}
```

## Training Configuration

### QLoRA Settings (H100)

```python
CONFIG = {
    "model_name": "Qwen/Qwen2.5-VL-7B-Instruct",
    "max_seq_length": 16384,
    "load_in_4bit": True,
    "lora_r": 32,
    "lora_alpha": 64,
    "batch_size": 4,
    "gradient_accumulation": 4,
    "learning_rate": 2e-5,
    "num_epochs": 3,
}
```

### GPU Requirements

| GPU | VRAM | Time | Cost |
|-----|------|------|------|
| H100 80GB | 80GB | ~1 hr | ~$2.50 |
| A100 80GB | 80GB | ~1.5 hr | ~$3 |
| RTX 3090 | 24GB | ~3 hr | local |

## Running Training

### Option 1: RunPod (Recommended)

```bash
cd runpod
# Add API key to .env
RUN_RUNPOD.bat
```

### Option 2: Local (RTX 3090)

```bash
cd training
RUN_UNSLOTH.bat
```

## Evaluation Metrics

The trained model is evaluated on:

1. **Task Accuracy**: Correct task type responses
2. **Citation Rate**: % of responses with proper citations
3. **Uncertainty Gate**: Correctly refuses without evidence
4. **Code Quality**: Valid code/JSON generation

### Expected Improvements

| Metric | Base | Fine-tuned | Δ |
|--------|------|------------|---|
| Evony Knowledge | 20% | 85% | +65% |
| Citation Format | 5% | 90% | +85% |
| Uncertainty Gate | 10% | 80% | +70% |
| Code Generation | 30% | 75% | +45% |

## Using the Trained Model

### With LoRA Adapter

```python
from transformers import AutoModelForCausalLM
from peft import PeftModel

base = AutoModelForCausalLM.from_pretrained("Qwen/Qwen2.5-VL-7B-Instruct")
model = PeftModel.from_pretrained(base, "./output/final")
```

### Merged Model

```python
model = AutoModelForCausalLM.from_pretrained("./output/merged")
```

---

*Generated: 2026-01-05T10:37:53.978860*
