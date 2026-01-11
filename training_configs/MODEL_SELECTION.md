# Best Abliterated Models for Evony Training
## RTX 3090 Ti (24GB VRAM) Optimized

---

## 🏆 TOP RECOMMENDATIONS

### #1 BEST OVERALL: Qwen2.5-14B-Instruct-abliterated
```
Model: huihui-ai/Qwen2.5-14B-Instruct-abliterated
Size: 14B parameters
Context: 128K tokens
VRAM: ~20GB with 4-bit quantization
```
**Why:** Best balance of capability, context length, and uncensored output. Qwen2.5 excels at technical/coding tasks.

### #2 RUNNER-UP: Llama-3.1-8B-Instruct-abliterated  
```
Model: mlabonne/Meta-Llama-3.1-8B-Instruct-abliterated
Size: 8B parameters
Context: 128K tokens
VRAM: ~12GB with 4-bit quantization
```
**Why:** Excellent instruction following, fully uncensored, fits easily in 24GB.

### #3 SPEED KING: Qwen2.5-7B-Instruct-abliterated
```
Model: huihui-ai/Qwen2.5-7B-Instruct-abliterated
Size: 7B parameters
Context: 128K tokens
VRAM: ~8GB with 4-bit quantization
```
**Why:** Fastest training, lowest VRAM, still excellent quality.

---

## 📊 DETAILED COMPARISON

| Model | Size | Context | VRAM (4-bit) | Quality | Speed | Uncensored |
|-------|------|---------|--------------|---------|-------|------------|
| **Qwen2.5-14B-abliterated** | 14B | 128K | ~20GB | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ✅ Full |
| **Llama-3.1-8B-abliterated** | 8B | 128K | ~12GB | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ✅ Full |
| **Qwen2.5-7B-abliterated** | 7B | 128K | ~8GB | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ✅ Full |
| Mistral-7B-v0.3-abliterated | 7B | 32K | ~8GB | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ✅ Full |
| Mixtral-8x7B-abliterated | 47B | 32K | ~28GB | ⭐⭐⭐⭐⭐ | ⭐⭐ | ✅ Full |

---

## 🔧 HUGGINGFACE MODEL LINKS

### Qwen2.5 Abliterated (RECOMMENDED)
```bash
# 14B - Best Quality
huggingface-cli download huihui-ai/Qwen2.5-14B-Instruct-abliterated

# 7B - Fastest
huggingface-cli download huihui-ai/Qwen2.5-7B-Instruct-abliterated

# 32B - If you have 48GB+ VRAM
huggingface-cli download huihui-ai/Qwen2.5-32B-Instruct-abliterated
```

### Llama 3.1 Abliterated
```bash
# 8B - Great balance
huggingface-cli download mlabonne/Meta-Llama-3.1-8B-Instruct-abliterated

# 70B - Requires multi-GPU
huggingface-cli download mlabonne/Meta-Llama-3.1-70B-Instruct-abliterated
```

### Mistral Abliterated
```bash
# 7B v0.3
huggingface-cli download failspy/Mistral-7B-Instruct-v0.3-abliterated
```

---

## 💾 DOWNLOAD COMMANDS

### Option 1: HuggingFace CLI (Recommended)
```bash
# Install
pip install huggingface_hub

# Login (for gated models)
huggingface-cli login

# Download Qwen2.5-14B-Instruct-abliterated
huggingface-cli download huihui-ai/Qwen2.5-14B-Instruct-abliterated --local-dir ./models/qwen2.5-14b-abliterated
```

### Option 2: Python
```python
from huggingface_hub import snapshot_download

# Download model
snapshot_download(
    repo_id="huihui-ai/Qwen2.5-14B-Instruct-abliterated",
    local_dir="./models/qwen2.5-14b-abliterated",
    local_dir_use_symlinks=False
)
```

### Option 3: Git LFS
```bash
git lfs install
git clone https://huggingface.co/huihui-ai/Qwen2.5-14B-Instruct-abliterated
```

---

## ⚙️ RTX 3090 Ti OPTIMIZED SETTINGS

### For Qwen2.5-14B (24GB VRAM)
```yaml
# QLoRA 4-bit - Fits in 24GB
quantization:
  load_in_4bit: true
  bnb_4bit_compute_dtype: bfloat16
  bnb_4bit_quant_type: nf4
  bnb_4bit_use_double_quant: true

training:
  per_device_train_batch_size: 1
  gradient_accumulation_steps: 16
  gradient_checkpointing: true
  max_seq_length: 4096  # Can go up to 32K with flash attention
```

### For Qwen2.5-7B (More headroom)
```yaml
# Can use larger batches
training:
  per_device_train_batch_size: 2
  gradient_accumulation_steps: 8
  max_seq_length: 8192
```

---

## 🚀 QUICK START

### 1. Download Model
```bash
pip install huggingface_hub
huggingface-cli download huihui-ai/Qwen2.5-14B-Instruct-abliterated --local-dir ./models/qwen2.5-14b-abliterated
```

### 2. Update Training Config
Edit `training_configs/huggingface_config.yaml`:
```yaml
model:
  name_or_path: "./models/qwen2.5-14b-abliterated"
  # OR use HuggingFace ID directly:
  # name_or_path: "huihui-ai/Qwen2.5-14B-Instruct-abliterated"
```

### 3. Start Training
```bash
python train_huggingface.py
```

---

## ❓ WHY ABLITERATED?

"Abliterated" models have had their refusal/censorship training removed through:
1. **Orthogonalization** - Removing refusal directions from weight space
2. **Fine-tuning** - Training on uncensored data
3. **DPO** - Direct preference optimization against refusals

This means:
- ✅ No "I can't help with that" responses
- ✅ No content filtering
- ✅ Full technical responses about exploits, security, etc.
- ✅ Perfect for Evony reverse engineering knowledge

---

## 📋 FINAL RECOMMENDATION

**For RTX 3090 Ti with 24GB VRAM:**

```
PRIMARY: huihui-ai/Qwen2.5-14B-Instruct-abliterated
- 128K context (perfect for long code/docs)
- Best technical capability
- Fully uncensored
- Fits with 4-bit quantization

FALLBACK: huihui-ai/Qwen2.5-7B-Instruct-abliterated
- If 14B too slow
- Still excellent quality
- More VRAM headroom
```
