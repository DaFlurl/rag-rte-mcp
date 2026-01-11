# Evony Training on RunPod B200

## Quick Start (3 Commands)

```bash
# 1. Install Unsloth
pip install unsloth

# 2. Run training
python train_unsloth_b200.py
```

That's it!

---

## Requirements

- **RunPod Container**: `runpod/pytorch:2.8.0-py3.11-cuda12.8.1-cudnn-devel-ubuntu`
- **GPU**: NVIDIA B200 (or any Blackwell/RTX 50 series)

## What This Does

- Fine-tunes `huihui-ai/Huihui-Qwen3-4B-Instruct-2507-abliterated` on your Evony dataset
- Uses **Unsloth** for 2x faster training and 70% less VRAM
- Uses **LoRA** for efficient fine-tuning (only ~6% of parameters)
- Saves checkpoints every 100 steps
- Graceful shutdown - saves on Ctrl+C or server stop

## Dataset Format

Your dataset uses ChatML messages format (already correct):
```json
{"messages": [{"role": "user", "content": "..."}, {"role": "assistant", "content": "..."}]}
```

SFTTrainer handles this **automatically** - no conversion needed.

## Output

After training:
- `output_evony_unsloth/final/` - Complete fine-tuned model
- `output_evony_unsloth/lora_adapters/` - LoRA adapters only (smaller)
- `output_evony_unsloth/checkpoint-*/` - Intermediate checkpoints

## Download Your Model

```bash
# Zip the final model
zip -r evony_model.zip output_evony_unsloth/final/

# Or just the LoRA adapters (smaller)
zip -r evony_lora.zip output_evony_unsloth/lora_adapters/
```

Then download from RunPod file browser.

## Configuration

Edit `train_unsloth_b200.py` CONFIG section to change:
- `model_name` - Base model to fine-tune
- `num_epochs` - Training epochs (default: 3)
- `batch_size` - Batch size (default: 4)
- `learning_rate` - Learning rate (default: 2e-4)
- `save_steps` - Checkpoint frequency (default: 100)

## Troubleshooting

### Unsloth not found
```bash
pip install unsloth
```

### Out of memory
Reduce `batch_size` to 2 or 1 in the CONFIG.

### Training interrupted
Your checkpoint is saved automatically. Resume by editing CONFIG:
```python
# Add to CONFIG:
"resume_from_checkpoint": "output_evony_unsloth/checkpoint-XXX",
```

---

## References

- [Unsloth GitHub](https://github.com/unslothai/unsloth)
- [Unsloth B200 Guide](https://unsloth.ai/docs/basics/fine-tuning-llms-with-blackwell-rtx-50-series-and-unsloth)
- [HuggingFace SFTTrainer](https://huggingface.co/docs/trl/en/sft_trainer)
- [RunPod PyTorch 2.8 Guide](https://www.runpod.io/articles/guides/pytorch-2-8-cuda-12-8)
