# 🎮 Evony Phase 3 Training Package

## Quick Start

```bash
# 1. Upload & extract
unzip evony_phase3.zip
cd evony_phase3

# 2. Setup
bash setup_phase3.sh

# 3. Train with TV!
python train_phase3_tv.py
```

## Contents

| File | Description |
|------|-------------|
| `train_final.jsonl` | 21,132 unique training examples |
| `train_phase3_tv.py` | Training script with live dashboard |
| `train_runpod_h200.py` | Alternative training script |
| `validation_prompts_v2.json` | 80 defensive validation prompts |
| `setup_phase3.sh` | Environment setup script |

## Training Data

- **21,132 unique examples** (deduplicated)
- Base: 18,052 ChatML examples
- CVE Security: 2,862 examples  
- Enums/Protocol: 206 examples
- Claude Phase 3: 59 examples (grounding, refusal, multi-turn)

## H200 Settings

| Setting | Value |
|---------|-------|
| LoRA r/α | 32/64 |
| Epochs | 4 |
| Batch | 2 × 8 = 16 effective |
| Max Seq | 8192 |
| LR | 1e-5 |

## Budget

- **$3.59/hr** (H200 SXM)
- **3 hours** = ~$11
- Target: **6,000-10,000 steps**

## Speed Guardrails

| Speed | Status |
|-------|--------|
| >= 0.6 steps/sec | ✅ GOOD |
| 0.3-0.6 | ⚠️ BORDERLINE |
| < 0.25 | ❌ STOP |

## Output

```
evony_phase3_output/
├── final_lora/      # LoRA adapter
├── merged_f16/      # Merged model
└── checkpoint-*/    # Intermediates
```

---
*Evony Phase 3 - ChatGPT Corrected Strategy*
*Windsurf + Claude Collaboration*
