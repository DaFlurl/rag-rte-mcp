# Continue Phase 2 Training

## Quick Start

### 1. Upload to Google Drive
Upload `evony_phase2.zip` to Google Drive for faster transfer to RunPod.

### 2. On RunPod
```bash
# Download from Google Drive (use gdown or wget)
pip install gdown
gdown "YOUR_GOOGLE_DRIVE_LINK"

# Extract
unzip evony_phase2.zip
cd evony_phase2

# Check for existing checkpoints
ls -la output_phase2/checkpoint-*

# Continue training
python train_continue_phase2.py
```

### 3. What It Does
- **Finds latest checkpoint** automatically
- **Loads Phase 2 state** (model, optimizer, scheduler)
- **Continues training** with same settings
- **Saves new checkpoints** as continuation
- **Updates training info** with continuation data

## Files Added

```
evony_phase2/
├── train_continue_phase2.py    # NEW: Continue training script
├── README_CONTINUE.md           # NEW: These instructions
├── train_runpod_v2.py          # Original Phase 2 script
├── setup_phase2.sh             # Setup helper
├── test_model.py               # Model evaluation
└── README.md                   # Original README
```

## Expected Results

| Metric | Phase 2 Original | Phase 2 Continued |
|--------|------------------|-------------------|
| Additional Epochs | 2 | 3 (configurable) |
| Total Epochs | 5 | 8 |
| Expected Time | 90 min | 135 min |
| Expected Cost | $5.39 | $8.09 |
| Expected Eval Loss | ~0.28 | ~0.22 |

## Checkpoint Detection

The script automatically:
1. Scans `output_phase2/checkpoint-*` directories
2. Finds the highest numbered checkpoint
3. Verifies required files exist
4. Resumes from that exact state

## Configuration

You can modify `train_continue_phase2.py`:

```python
# Number of additional epochs to train
"num_epochs": 3,            # Change as needed

# Learning rate (keep same for continuity)
"learning_rate": 1e-5,      # Or reduce for fine refinement

# Save frequency
"save_steps": 200,          # More frequent saves
```

## After Continuation

### Test the Continued Model
```bash
python test_model.py /workspace/output_phase2/continued
```

### Save the Final Model
```bash
cd /workspace
zip -r evony_coder_8epoch.zip output_phase2/continued/
```

### Download
Use RunPod file browser or upload to HuggingFace:
```bash
pip install huggingface_hub
huggingface-cli login
huggingface-cli upload YOUR_USERNAME/evony-coder-8epoch /workspace/output_phase2/continued
```

## Troubleshooting

### "No checkpoints found"
- Make sure Phase 2 training completed successfully
- Check that `output_phase2/checkpoint-*` directories exist
- Verify checkpoint contains `adapter_model.safetensors`

### "Checkpoint missing files"
- The checkpoint may be corrupted
- Try using an earlier checkpoint
- Re-run Phase 2 if needed

### Training is slower than expected
- H200 should maintain 0.5-0.9 steps/sec
- Check GPU utilization with `nvidia-smi`
- Reduce batch size if memory issues

## Cost Estimate

For 3 additional epochs on H200:
- **Time**: ~45 minutes
- **Cost**: ~$2.70
- **Total with Phase 2**: ~$8.09 for 8 epochs

This is still excellent value compared to:
- **B200**: ~$13.45 (1.66x more)
- **RTX 3090 Ti**: ~$67.20 (8.3x more, 3+ days!)

## Next Steps

After continuation:
1. **Test the model** thoroughly
2. **Compare performance** vs Phase 2
3. **Decide on Phase 3** if still improving
4. **Save the final model** for deployment

The continued model should show significant improvement in Evony-specific tasks while maintaining the base model's capabilities.
