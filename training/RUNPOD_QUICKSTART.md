# 🚀 RunPod H200 Quick Start - Evony Phase 3 Training

## Budget: ~$11 for 3 hours @ $3.59/hr

---

## Step 1: Launch H200 Pod

1. Go to [RunPod.io](https://runpod.io)
2. Select **H200 SXM** (141GB VRAM)
3. Choose template: `runpod/pytorch:2.1.0-py3.10-cuda12.1.0-devel`
4. Storage: 100GB minimum

---

## Step 2: Upload Training Files

Upload these files to `/workspace/`:
```
train_final.jsonl          (21,132 examples)
train_runpod_h200.py       (training script)
validation_prompts_v2.json (80 prompts - optional)
```

**Quick upload command:**
```bash
# From your local machine
scp train_final.jsonl train_runpod_h200.py root@<POD_IP>:/workspace/
```

---

## Step 3: Install Dependencies

```bash
# SSH into pod
ssh root@<POD_IP>

# Install Unsloth (fast)
pip install unsloth trl datasets transformers accelerate

# Or full install
pip install "unsloth[colab-new] @ git+https://github.com/unslothai/unsloth.git"
```

---

## Step 4: Run Training

```bash
cd /workspace
python train_runpod_h200.py
```

### Expected Output:
```
============================================================
EVONY PHASE 3 TRAINING - RUNPOD H200
============================================================
GPU: NVIDIA H200 (141.0 GB)
✅ Unsloth + TRL loaded

[1/5] Loading model: Qwen/Qwen2.5-VL-7B-Instruct
[2/5] Adding LoRA adapters (r=32, α=64)
[3/5] Loading dataset: train_final.jsonl
      Loaded 21132 examples
[4/5] Setting up training...
[5/5] Starting training...
```

---

## Speed Guardrails

| Speed | Status | Action |
|-------|--------|--------|
| >= 0.6 steps/sec | ✅ GOOD | Continue |
| 0.3-0.6 steps/sec | ⚠️ BORDERLINE | Monitor |
| < 0.25 steps/sec | ❌ TOO SLOW | STOP immediately |

### If Too Slow:
1. Reduce `max_seq_length`: 8192 → 4096
2. Reduce `micro_batch_size`: 2 → 1
3. Check for memory issues

---

## Step 5: Download Results

After training completes:
```bash
# From local machine
scp -r root@<POD_IP>:/workspace/evony_phase3_checkpoints ./
```

### Output Files:
```
evony_phase3_checkpoints/
├── final_lora/           # LoRA adapter
├── merged_f16/           # Merged F16 model
├── checkpoint-500/       # Intermediate checkpoints
├── checkpoint-1000/
└── ...
```

---

## Step 6: Convert to GGUF (Optional)

```bash
# On pod or locally
python train_runpod_h200.py --gguf
```

Or use llama.cpp:
```bash
python convert.py evony_phase3_checkpoints/merged_f16 \
    --outfile evony-expert-v3-f16.gguf \
    --outtype f16
```

---

## Training Parameters

| Parameter | Value | Notes |
|-----------|-------|-------|
| Base Model | Qwen2.5-VL-7B-Instruct | Or Phase 2 merged |
| LoRA r | 32 | ChatGPT recommended |
| LoRA α | 64 | ChatGPT recommended |
| Epochs | 4 | Full coverage |
| Learning Rate | 1e-5 | Fine-tuning rate |
| Batch Size | 2 | H200 optimized |
| Grad Accum | 8 | Effective batch 16 |
| Max Seq Length | 8192 | Full context |

---

## Projected Results (3 hours)

| Steps | Verdict |
|-------|---------|
| < 3,000 | ❌ Not worth it |
| 4,000-6,000 | ⚠️ Marginal |
| 6,000-10,000 | ✅ GOOD |
| 10,000+ | 🎉 EXCELLENT |

---

## Troubleshooting

### OOM (Out of Memory)
```python
# Reduce in train_runpod_h200.py:
"max_seq_length": 4096,  # Was 8192
"micro_batch_size": 1,   # Was 2
```

### Slow Training
```python
# Check packing is OFF for VL models:
"packing": False,
```

### Import Errors
```bash
pip install --upgrade unsloth transformers accelerate
```

---

## Safety Notes

- LoRA adapters only - base model unchanged
- Stopping early is safe - checkpoint still valid
- No damage can occur from stopping
- Save checkpoints every 500 steps

---

*Created for Evony Phase 3 Epic Training*
*Budget: $11 | Time: 3 hours | Target: 6,000+ steps*
