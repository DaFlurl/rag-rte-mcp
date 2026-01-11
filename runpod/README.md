# RunPod H200 SXM Training - Evony Model

> **Strategy**: 2-hour training blocks with guardrails  
> **Budget**: $30 @ $3.59/hr = ~8 hours  
> **See**: [RUNBOOK.md](RUNBOOK.md) for complete protocol

---

## Quick Start

### Option 1: Staged Training (Recommended)
```bash
python staged_training.py
```

### Option 2: Direct Training
```bash
python train_runpod.py
```

### Option 3: Full Orchestration
```bash
python runpod_orchestrator.py
```

This fully automates:
1. ✅ Spin up H100 80GB pod via RunPod API
2. ✅ SSH in and install dependencies
3. ✅ Upload training dataset
4. ✅ Run QLoRA SFT training (1-2 hours)
5. ✅ Evaluate vs base model
6. ✅ Download trained adapters
7. ✅ Terminate pod (stop billing)

---

## Requirements

### 1. RunPod Account
- Sign up: https://runpod.io
- Add $30-50 credits

### 2. API Key
- Go to: https://runpod.io/console/user/settings
- Create API key
- Save to `runpod/.env`:
```
RUNPOD_API_KEY=your_key_here
```

### 3. SSH Key (Optional, for manual access)
- Generate if needed: `ssh-keygen -t ed25519`
- Add public key to RunPod settings

---

## GPU Options & Pricing

| GPU | VRAM | $/hr | Training Time | Total Cost |
|-----|------|------|---------------|------------|
| **H100 80GB** | 80GB | ~$2.50 | ~1 hour | ~$3 |
| **H200** | 141GB | ~$3.50 | ~45 min | ~$3 |
| **A100 80GB** | 80GB | ~$1.90 | ~1.5 hours | ~$3 |
| **4× RTX 4090** | 96GB | ~$1.50 | ~2 hours | ~$3 |

**Recommended**: H100 80GB - best speed/cost ratio

---

## Training Stages (RUNBOOK Protocol)

### Stage 0: Smoke Test (15 min)
- Validate speed before committing GPU hours
- **STOP** if < 0.25 steps/sec
- **CONTINUE** if >= 0.6 steps/sec

### Stage 1: Core Learning (2 hours)
- Target: 4,000-6,000 steps
- Lock in behavior changes

### Stage 2: Evaluate (10-15 min)
- Compare adapter vs base model
- **STOP** if not better

### Stage 3: Polish (2 hours)
- Target: 7,000-10,000 total steps

### Stage 4: Optional (2 hours)
- Only if still improving

---

## GUARDRAILS (Money Protection)

### Steps Per Second Thresholds
| Speed | Status | Action |
|-------|--------|--------|
| >= 0.6 steps/sec | ✅ GOOD | Keep training |
| 0.3 - 0.6 steps/sec | ⚠️ BORDERLINE | Adjust config |
| < 0.25 steps/sec | ❌ TOO SLOW | **AUTO-STOP** |

### Projected Steps (3 hours)
| Steps | Verdict |
|-------|---------|
| < 3,000 | ❌ Not worth it |
| 4,000 - 6,000 | ⚠️ Marginal |
| 6,000 - 10,000 | ✅ GOOD |
| 10,000+ | 🔥 EXCELLENT |

### Fix Playbook (if too slow)
1. Drop context: 8192 → 6144 → 4096
2. Drop image size: 336 → 288
3. Reduce batch: 2 → 1 (keep grad_accum)
4. Increase dataloader workers
5. Ensure packing = OFF for VL

---

## What Gets Trained

- **Model**: Qwen2.5-VL-7B-Instruct
- **Method**: QLoRA (4-bit quantization + LoRA adapters)
- **Dataset**: 10,029 RAG-native examples
- **Tasks**: GUI analysis, evidence citing, patch planning, query synthesis

---

## Output Files

After training completes, downloaded to `runpod/output/`:
```
output/
├── adapter_model.safetensors  # LoRA weights
├── adapter_config.json        # LoRA config
├── tokenizer.json             # Tokenizer
├── eval_results.json          # Evaluation metrics
└── training_log.txt           # Training logs
```

---

## Manual Steps (If Automation Fails)

### 1. Create Pod Manually
- Go to: https://runpod.io/console/pods
- Select: PyTorch 2.1 template
- GPU: 1x H100 80GB
- Volume: 50GB

### 2. SSH In
```bash
ssh root@<pod-ip> -p <port>
```

### 3. Run Training
```bash
# Clone/upload files
cd /workspace
git clone <your-repo> || upload files

# Install deps
pip install unsloth transformers datasets peft trl

# Train
python train_runpod.py
```

### 4. Download Results
```bash
scp -P <port> root@<pod-ip>:/workspace/output/* ./output/
```

### 5. Stop Pod
- RunPod console → Stop pod
