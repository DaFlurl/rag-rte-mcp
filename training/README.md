# Evony Model Training - Complete Guide

## Quick Start (One Command)

```batch
RUN_ALL.bat
```

This single command handles everything:
1. ✅ Sets up Python environment
2. ✅ Downloads Qwen2.5-VL-7B-Instruct
3. ✅ Prepares 10,000+ training examples
4. ✅ Fine-tunes with QLoRA (2-4 hours)
5. ✅ Tests the trained model

---

## Requirements

- **GPU**: RTX 3090 Ti (24GB VRAM) or better
- **RAM**: 32GB+ recommended
- **Storage**: 50GB free space
- **OS**: Windows 10/11
- **Python**: 3.10+

---

## Manual Steps (If Needed)

### Step 1: Setup
```batch
setup.bat
```

### Step 2: Download Model
```batch
download_model.bat
```

### Step 3: Prepare Data
```batch
call venv\Scripts\activate.bat
python prepare_data.py
```

### Step 4: Train
```batch
train.bat
```

### Step 5: Test
```batch
test.bat
```

---

## Interactive Chat

After training, chat with your model:

```batch
call venv\Scripts\activate.bat
python test.py --interactive
```

---

## File Structure

```
training/
├── RUN_ALL.bat          # One-click full pipeline
├── setup.bat            # Install dependencies
├── download_model.bat   # Download base model
├── train.bat            # Run training
├── test.bat             # Test model
├── download_model.py    # Model download script
├── prepare_data.py      # Data converter
├── train.py             # Training script
├── test.py              # Inference script
├── models/              # Downloaded models
│   └── qwen2.5-vl-7b/
├── data/                # Prepared training data
│   ├── train_qwen.jsonl
│   └── val_qwen.jsonl
└── output/              # Trained model output
    └── final/           # Final LoRA weights
```

---

## Training Configuration

| Setting | Value |
|---------|-------|
| Base Model | Qwen2.5-VL-7B-Instruct |
| Method | QLoRA (4-bit) |
| LoRA Rank | 16 |
| LoRA Alpha | 32 |
| Learning Rate | 2e-5 |
| Epochs | 3 |
| Batch Size | 1 |
| Gradient Accum | 16 |
| Max Length | 2048 |
| VRAM Usage | ~20GB |

---

## Troubleshooting

### CUDA Out of Memory
- Reduce `batch_size` to 1 in `train.py`
- Increase `gradient_accumulation` to 32
- Reduce `max_length` to 1024

### Model Download Fails
- Check internet connection
- Run: `huggingface-cli login`
- Try manual download from HuggingFace

### Training Crashes
- Check GPU temperature
- Ensure 50GB+ free disk space
- Update NVIDIA drivers

---

## Dataset Info

- **Total Examples**: 10,000+
- **Format**: Qwen chat messages
- **Topics**: Protocol, beans, combat, scripting, security
- **Quality Score**: 76% high quality

---

## Output Model Usage

```python
from transformers import AutoModelForCausalLM, AutoTokenizer
from peft import PeftModel

# Load base + LoRA
base = AutoModelForCausalLM.from_pretrained("Qwen/Qwen2.5-VL-7B-Instruct")
model = PeftModel.from_pretrained(base, "./output/final")
tokenizer = AutoTokenizer.from_pretrained("./output/final")

# Generate
prompt = "What is army.newArmy in Evony?"
inputs = tokenizer(prompt, return_tensors="pt")
outputs = model.generate(**inputs, max_new_tokens=256)
print(tokenizer.decode(outputs[0]))
```
