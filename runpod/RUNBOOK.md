# RunPod Training Runbook - H200 SXM QLoRA 7B VL

> **Goal**: Spend 6-8 total GPU hours efficiently using 2-hour blocks with guardrails

---

## Non-Negotiable Safety Rules

- ✅ Training **LoRA/QLoRA adapters only** - base model unchanged
- ✅ Stopping early is **completely safe** - last checkpoint is valid
- ✅ Running out of credits causes **no damage**
- ❌ The only "waste" risk is paying for slow steps/sec

---

## Training Stages

### Stage 0 — Smoke Test (15 min) ⚠️ CRITICAL

**Purpose**: Confirm training speed is worth paying for

**Actions**:
1. Start training with Stage 1 config
2. Wait for guardrail logs to appear
3. Read: `steps/sec` and `projected steps`

**Decision Rules (HARD RULES)**:

| Speed | Status | Action |
|-------|--------|--------|
| >= 0.6 steps/sec | ✅ GOOD | Continue to Stage 1 |
| 0.3-0.6 steps/sec | ⚠️ BORDERLINE | Adjust config, retest |
| < 0.25 steps/sec | ❌ TOO SLOW | **STOP IMMEDIATELY** |

---

### Stage 1 — Core Learning (2 hours)

**Purpose**: Lock in behavior changes

**Required Settings**:
```python
max_seq_length = 8192
micro_batch_size = 2
gradient_accumulation_steps = 8
image_size = 336
packing = False  # OFF for VL
save_steps = 500
save_total_limit = 5
```

**Expected Outcomes**:
- ~4,000-6,000 steps
- Major improvement in:
  - Format obedience
  - Citations
  - RAG query quality
  - Structured outputs

---

### Stage 2 — Evaluate (10-15 min)

**Purpose**: Verify adapter beats baseline

**Compare**:
```
Base Model + RAG  vs  Adapter Checkpoint + RAG
```

**Decision**:
- ✅ Better → Continue to Stage 3
- ❌ Not better → **STOP TRAINING**, fix dataset/config

---

### Stage 3 — Polish (2 hours)

**Purpose**: Improve consistency and reduce failures

**Actions**:
- Resume from best checkpoint
- Same settings as Stage 1
- Target: ~7,000-10,000 total steps

---

### Stage 4 — Optional Final Block (2 hours)

**Only run if ALL are true**:
- [ ] Eval metrics still improving
- [ ] Loss trending down
- [ ] Outputs cleaner (fewer missing citations/schema errors)

**If plateau → STOP and save credits**

---

## Guardrail Thresholds

### Primary Metric: steps/sec → projected steps

**Speed Thresholds**:
| Speed | Status | Action |
|-------|--------|--------|
| >= 0.6 steps/sec | ✅ GOOD | Continue |
| 0.3-0.6 steps/sec | ⚠️ BORDERLINE | Adjust & retry |
| < 0.25 steps/sec | ❌ TOO SLOW | **AUTO-STOP** |

**Projected Steps (in 3 hours)**:
| Steps | Verdict |
|-------|---------|
| < 3,000 | ❌ Not worth it |
| 4,000-6,000 | ⚠️ Marginal |
| 6,000-10,000 | ✅ GOOD |
| 10,000+ | 🔥 EXCELLENT |

### Rule
> If after 5-10 minutes warmup you don't see >= 0.6 steps/sec, **don't commit to a 2-hour block**.

---

## Checkpoint Rules

```yaml
save_steps: 500
save_total_limit: 5
always_export:
  - best_checkpoint_adapter
  - final_adapter
```

**If training ends unexpectedly**:
- Last saved checkpoint is usable
- Adapter is valid
- Resume later from checkpoint

---

## Fix Playbook (if steps/sec too low)

If `steps/sec < 0.25`:

1. **Drop context**: 8192 → 6144 → 4096
2. **Drop image size**: 336 → 288
3. **Reduce batch**: 2 → 1 (keep grad_accum to maintain effective batch)
4. **Increase dataloader workers** (if GPU idle)
5. **Ensure packing = OFF** for VL

Then re-run smoke test.

---

## Operational Commands

### On Pod After Upload
```bash
cd /workspace
unzip -o evony_training_package.zip
pip install -r requirements.txt
```

### Start Training
```bash
python train_runpod.py
```

### Evaluate
```bash
python evaluate.py
```

### Export Locations
```
outputs/checkpoint-*/     # LoRA adapter checkpoints
outputs/final/            # Final exported adapter
outputs/merged/           # Merged model (optional)
```

---

## Budget Planning

**H200 SXM @ ~$3.59/hr** with $30 budget:

| Runs | Hours | Cost |
|------|-------|------|
| 3 × 2h | 6h | ~$21.50 |
| 4 × 2h | 8h | ~$28.70 |

**Recommended Schedule**:
```
1. Smoke test (15 min)
2. 2h block → Evaluate
3. 2h block → Evaluate
4. 2h block (if improving)
5. Stop when gains flatten
```

---

## Quick Reference Card

```
┌─────────────────────────────────────────────────────────────┐
│  RUNPOD H200 TRAINING CHECKLIST                             │
├─────────────────────────────────────────────────────────────┤
│  [ ] .env has RUNPOD_API_KEY                                │
│  [ ] Run smoke test (15 min)                                │
│  [ ] Verify steps/sec >= 0.6                                │
│  [ ] Run 2h block                                           │
│  [ ] Evaluate adapter vs base                               │
│  [ ] If better: continue; If not: fix data                  │
│  [ ] Repeat until 6-8h or plateau                           │
│  [ ] Download best + final adapters                         │
│  [ ] Terminate pod                                          │
└─────────────────────────────────────────────────────────────┘
```

---

## Safety Reminders

1. **You cannot "ruin" a LoRA run by stopping**
2. **Base model is never modified**
3. **All checkpoints are valid and usable**
4. **Stopping early saves money**
5. **Resume anytime from checkpoint**

---

*Last Updated: 2026-01-05*
