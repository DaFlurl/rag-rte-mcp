# Evony Coder Phase 2 Training Package

## What This Is

Phase 2 training for your Evony-specialized Qwen2.5-Coder-7B model.

**Phase 1 Results:**
- 3 epochs trained
- Eval loss: 0.326 (still dropping = more training helps!)
- Speed: 0.445 steps/sec
- Cost: ~$2.59

**Phase 2 Goals (Claude-approved conservative approach):**
- +2 epochs first (total 5), TEST, then decide
- Target eval loss: ~0.28-0.30
- Expected cost: ~$1.50

## Settings (Claude-Reviewed)

| Setting | Phase 1 | Phase 2 | Rationale |
|---------|---------|---------|-----------|
| Context | 8192 | **4096** | 1.5-2x faster |
| Batch | 4 | **4** | Conservative (test before increasing) |
| Grad Accum | 8 | **4** | Effective batch = 16 |
| LR | 2e-5 | **1e-5** | Lower for refinement |
| Epochs | 3 | **+2** | Small increment, test after |

Expected speed: **0.7-0.9 steps/sec** (was 0.45)

## Quick Start

### On RunPod:

```bash
# 1. Upload evony_phase2.zip to /workspace/

# 2. Extract and setup
cd /workspace
unzip evony_phase2.zip
bash setup_phase2.sh

# 3. Start training
python train_runpod_v2.py
```

### Data Requirement

Your data should already be in `/workspace/data/` from Phase 1:
- `train_complete_source.jsonl` (12,304 examples)
- `val_normalized.jsonl` (1,003 examples)

If not, upload `data.zip` and extract.

## Files Included

```
evony_phase2/
├── train_runpod_v2.py    # Main training script (optimized)
├── setup_phase2.sh       # Setup helper
├── test_model.py         # Model evaluation script
└── README.md             # This file
```

## Expected Results

| Metric | Phase 1 | Phase 2 Expected |
|--------|---------|------------------|
| Epochs | 3 | 10 (total) |
| Eval Loss | 0.326 | ~0.20 |
| Speed | 0.45 s/s | 0.7-0.9 s/s |
| Time | 43 min | ~90 min |
| Cost | $2.59 | ~$5-6 |

## After Training

### 1. Test the model
```bash
python test_model.py /workspace/output_phase2/merged
```

### 2. Save your model
```bash
cd /workspace
zip -r evony_coder_10epoch.zip output_phase2/merged/
```

### 3. Download
Use RunPod file browser or:
```bash
# Upload to HuggingFace (free)
pip install huggingface_hub
huggingface-cli login
huggingface-cli upload YOUR_USERNAME/evony-coder-10epoch /workspace/output_phase2/merged
```

## Troubleshooting

### "Speed too slow" error
- Reduce batch_size from 8 to 4
- Or reduce context from 4096 to 2048

### Out of memory
- Set `load_in_4bit: True` (already enabled)
- Reduce batch_size

### Eval loss going UP
- Stop training (overfitting)
- Use the checkpoint with lowest eval loss

## Budget Tracking

| Phase | Epochs | Cost | Total |
|-------|--------|------|-------|
| 1 | 3 | $2.59 | $2.59 |
| 2 | +7 | ~$5.50 | ~$8 |
| Remaining | | | ~$50 |

## Next Phases (Optional)

If eval loss is still dropping after Phase 2:

**Phase 3:** +10 epochs with LR 5e-6
**Phase 4:** +10 epochs with LR 2e-6

Or stop when eval loss plateaus!
