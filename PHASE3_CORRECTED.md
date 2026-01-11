# 🔧 PHASE 3 CORRECTED STRATEGY
## Incorporating ChatGPT's Critical Feedback

**Created:** 2026-01-06 08:05 UTC  
**Status:** MANDATORY CORRECTIONS BEFORE TRAINING  
**Source:** ChatGPT analysis of Windsurf + Claude plans

---

# 🚨 CRITICAL ISSUES IDENTIFIED

## ~~Issue 1: Flash Version Mismatch~~ ❌ INVALID - ChatGPT Was Wrong

**ChatGPT's Claim:** Training assumes Flash 10.x but runtime may be Flash 32.0.0.363

**REALITY (Clarified by User):**
- The Flash 32 file (`pepflashplayer64.dll`) is in the **Electron browser** folder
- The Electron browser is a **separate modded tool** for running Flash content
- **Evony client itself IS Flash 10.0.x** (build 091103_11 = November 2009)
- Flash 32 was released ~2019, **10 years after Evony**!

**CONCLUSION:** No "runtime context" tagging needed. Evony = Flash 10.x, period.

**DO NOT ADD:**
- ❌ "Runtime context" tags on CVE examples
- ❌ "Compiled target vs executed binary" dual answers
- ❌ Version-conditional CVE responses

## Issue 2: CVE Over-Inclusion (MANDATORY FIX)
**Problem:** "489 validated for Flash 10.x" is likely garbage

**Fix:** CPE-based matching required:
```
VALID CPE: cpe:2.3:a:adobe:flash_player:10.*
MUST PARSE: version ranges like "< 10.1.53.64"
SEPARATE BUCKET: "version unclear" at low sampling rate
```

**New CVE Categories:**
| Category | Criteria | Training Weight |
|----------|----------|-----------------|
| HIGH CONFIDENCE | CPE exact match + Evony code surface | 100% |
| MEDIUM CONFIDENCE | CPE range match, no code surface | 50% |
| LOW CONFIDENCE | Keyword match only, version unclear | 10% |

## Issue 3: Unsafe Exploitation Prompts (MANDATORY FIX)
**Problem:** Category D contains offense-enabling prompts

**OLD (REMOVE):**
```
"How would you exploit Evony's protocol?"
"Describe a heap spray attack on Flash 10"
"What's the JIT spray technique?"
```

**NEW (DEFENSIVE FRAMING):**
```
"What defensive controls reduce heap-spray risk in legacy Flash?"
"What indicators should be logged to detect malformed AMF?"
"How should uncompress() inputs be validated and bounded?"
"What memory-safe alternatives exist for ByteArray operations?"
"How to detect compression bomb attacks in AMF parsing?"
```

## Issue 4: Hallucination Signals (MANDATORY FIX)
**Problem:** Model confabulates structure (fake header sizes, encryption details)

**Fix - Add Grounding Contract Training:**
```json
{
  "instruction": "What is the exact header format for Evony packets?",
  "output": "I cannot state the exact header format without examining the source code. Based on GameClient.as, packets use AMF3 serialization, but I don't have evidence of specific byte-level header structure.\n\n**What I CAN confirm from source:**\n- Uses Socket class for TCP\n- AMF3 readObject() for deserialization\n- ByteArray.uncompress() for decompression\n\n**What I CANNOT confirm:**\n- Exact header byte count\n- Magic bytes or version fields\n- Specific encryption implementation details\n\nWould you like me to analyze a specific file for packet structure?"
}
```

**Add "Refusal to Guess" Examples:**
```json
{
  "instruction": "What encryption key does Evony use?",
  "output": "I cannot provide a specific encryption key without direct evidence from the source code. While I know Evony uses encryption (CommMgr.as handles this), the actual key values require examination of:\n\n1. CommMgr.as encryption setup\n2. Any hardcoded keys or key derivation\n3. Server communication initialization\n\n**I will not guess key values** as this leads to incorrect security analysis."
}
```

## Issue 5: Data Leakage & Overfitting (MANDATORY FIX)
**Problem:** 5x augmentation + no dedup = overfit

**Fix - Dedup Strategy:**
```python
# REQUIRED BEFORE TRAINING
1. Exact dedup: hash(normalize(instruction + output))
2. Near-dup: SimHash with threshold 0.85
3. Train/val isolation: No CVE IDs in val that appear in train
4. Two eval sets:
   - seen_cves.jsonl (memorization check)
   - unseen_cves.jsonl (generalization check)
```

**Fix - Reduce Augmentation:**
| Tier | OLD (Claude) | NEW (ChatGPT Corrected) |
|------|--------------|-------------------------|
| S (Wild) | 5x | 2x max |
| A (Evony match) | 4x | 2x max |
| B (Flash 10.x) | 3x | 1x only if new evidence |
| C (General) | 2x | 0x (no augmentation) |

## Issue 6: No Weighting Plan (MANDATORY FIX)
**Problem:** CVE data could drown domain knowledge

**Fix - Sampling Ratios Per Epoch:**
```
55-65%  Core Evony (source/protocol/enums)
20-30%  CVE/Security (defensive framing only)
10-15%  Multi-turn/Cross-domain/Error recovery
```

## Issue 7: Enum Accuracy Needs Mechanism (MANDATORY FIX)
**Problem:** "100% accuracy" is a wish, not a mechanism

**Fix - Enum Unit Test Harness:**
```python
# enum_validator.py
ENUM_TESTS = [
    ("What is TFConstants.T_CATAPHRACT?", "8"),
    ("What is ErrorCode.CYCLOPEAN_BARRIER?", "-48"),
    ("What is TFConstants.T_BALLISTA?", "6"),
    # ... 100+ exact value tests
]

def validate_enum_accuracy(model):
    failures = []
    for prompt, expected in ENUM_TESTS:
        response = model.generate(prompt)
        if expected not in response:
            failures.append((prompt, expected, response))
    
    if failures:
        # Feed failures into corrective micro-run
        generate_corrective_examples(failures)
    
    return len(failures) == 0
```

---

# ✅ CORRECTED 3-MILESTONE STRATEGY

## Milestone 1: FOUNDATION (Days 1-2)
**Focus:** Deterministic correctness, reduced hallucination

### Data
| Category | Examples | Notes |
|----------|----------|-------|
| Enums | 950 | Exact values, all bugs documented |
| Protocol | 750 | 301 commands, AMF structure |
| Grounding Contract | 200 | "I cannot confirm without evidence" |
| Refusal to Guess | 100 | Explicit uncertainty training |
| **TOTAL** | **2,000** | |

### Success Criteria
- [ ] Enum unit test harness passes 100%
- [ ] No hallucinated header sizes
- [ ] Model says "I cannot confirm" when appropriate
- [ ] 95%+ on 40 Foundation validation prompts

### Checkpoint
`foundation_checkpoint.gguf`

---

## Milestone 2: APPLICATION (Days 3-5)
**Focus:** Practical usage, cross-domain coherence

### Data
| Category | Examples | Notes |
|----------|----------|-------|
| GUI | 700 | UI components, windows |
| Scripting | 450 | AutoEvony scripts |
| Effects/Sounds/Logs | 570 | Animations, audio, logging |
| Cross-Domain | 250 | Protocol + Enum + GUI combined |
| Multi-Turn | 150 | Grounded, tool-like conversations |
| Error Recovery | 150 | Graceful mistake handling |
| **TOTAL** | **2,270** | |

### Success Criteria
- [ ] Model writes working AutoEvony scripts
- [ ] Cross-domain questions answered coherently
- [ ] Multi-turn maintains context
- [ ] 85%+ on 60 Application validation prompts

### Checkpoint
`application_checkpoint.gguf`

---

## Milestone 3: SECURITY (Days 6-7)
**Focus:** Defensive CVE knowledge, version-aware

### Data (After CPE Filtering + Dedup)
| Category | Examples | Weight |
|----------|----------|--------|
| HIGH CONFIDENCE CVEs | ~150 | 100% |
| MEDIUM CONFIDENCE | ~100 | 50% sampling |
| Defensive Prompts | 200 | Mitigation focus |
| Detection/Monitoring | 100 | Log analysis |
| Version-Tagged Examples | 200 | Flash 10 vs 32 distinction |
| **TOTAL** | **~750** | Capped at 30% per epoch |

### Success Criteria
- [ ] CVE answers include runtime context
- [ ] No offense-enabling responses
- [ ] Correct version applicability
- [ ] 85%+ on 70 Security validation prompts (defensive)
- [ ] 0% hallucinated CVE details

### Final Output
`evony-expert-v3-f16.gguf`

---

# 📊 CORRECTED EXAMPLE COUNTS

| Category | Original Plan | ChatGPT Corrected | Change |
|----------|---------------|-------------------|--------|
| Base Source | 15,104 | 15,104 | - |
| CVE (augmented) | 4,300 | ~750 | -83% (quality > quantity) |
| Enums | 950 | 950 | - |
| Protocol | 750 | 750 | - |
| GUI | 700 | 700 | - |
| Scripting | 450 | 450 | - |
| Effects/Sounds/Logs | 570 | 570 | - |
| Multi-Turn | 200 | 150 | -25% (quality focus) |
| Cross-Domain | 500 | 250 | -50% (realistic scope) |
| Error Recovery | 200 | 150 | -25% |
| **Grounding Contract** | 0 | **200** | **NEW** |
| **Refusal to Guess** | 0 | **100** | **NEW** |
| **Version-Tagged** | 0 | **200** | **NEW** |
| **CORRECTED TOTAL** | 23,974 | **~20,324** | -15% |

---

# 🔧 NEW REQUIRED COMPONENTS

## 1. Dataset Admission Gate
Every CVE example must include:
```json
{
  "cve_id": "CVE-2015-0311",
  "affected_versions_evidence": "cpe:2.3:a:adobe:flash_player:*:*:*:*:*:*:*:* < 16.0.0.287",
  "runtime_context": {
    "compiled_target": "flash10-era",
    "executed_binary": "flash32.0.0.363"
  },
  "evony_surface_hit": "GameClient.as:87 - ByteArray.uncompress()",
  "confidence": "HIGH"
}
```

## 2. Corrected Validation Prompts

### Category D REWRITTEN (Defensive)
```json
[
  {"prompt": "What defensive controls reduce heap-spray risk in legacy Flash?",
   "expected_keywords": ["ASLR", "DEP", "memory limits", "sandboxing"]},
  
  {"prompt": "What indicators should be logged to detect malformed AMF?",
   "expected_keywords": ["size validation", "type checking", "anomaly", "bounds"]},
  
  {"prompt": "How should uncompress() inputs be validated?",
   "expected_keywords": ["size limit", "bounds check", "try-catch", "sanitize"]},
  
  {"prompt": "What memory-safe alternatives exist for ByteArray?",
   "expected_keywords": ["validation", "copying", "immutable", "sandboxed"]},
  
  {"prompt": "How to detect compression bomb attacks?",
   "expected_keywords": ["ratio check", "size limit", "timeout", "monitoring"]}
]
```

## 3. Grounding Contract Examples
```json
[
  {
    "instruction": "What is the exact packet header format?",
    "output": "I cannot state the exact header format without examining source code evidence. I can describe what I know from GameClient.as about AMF3 usage, but specific byte-level structure requires direct code analysis."
  },
  {
    "instruction": "What encryption algorithm does Evony use?",
    "output": "Based on source analysis, Evony uses encryption in CommMgr.as, but I cannot confirm the exact algorithm or key without seeing the implementation. Making assumptions about encryption details would be irresponsible."
  }
]
```

## 4. Dedup Script
```python
# training/dedup_dataset.py
import hashlib
from datasketch import MinHash, MinHashLSH

def exact_dedup(examples):
    seen = set()
    unique = []
    for ex in examples:
        h = hashlib.sha256(
            (ex['instruction'] + ex['output']).encode()
        ).hexdigest()
        if h not in seen:
            seen.add(h)
            unique.append(ex)
    return unique

def near_dedup(examples, threshold=0.85):
    lsh = MinHashLSH(threshold=threshold, num_perm=128)
    # ... implementation
    return deduplicated
```

## 5. Sampling Ratio Enforcement
```python
# training/balanced_sampler.py
SAMPLING_RATIOS = {
    'core_evony': 0.60,      # source/protocol/enums
    'application': 0.15,     # GUI/scripting/effects
    'security': 0.15,        # CVE (defensive only)
    'meta': 0.10,            # multi-turn/cross-domain/grounding
}

def create_balanced_epoch(datasets):
    epoch_data = []
    for category, ratio in SAMPLING_RATIOS.items():
        n_samples = int(EPOCH_SIZE * ratio)
        epoch_data.extend(sample(datasets[category], n_samples))
    return shuffle(epoch_data)
```

---

# 📅 CORRECTED TIMELINE

| Day | Task | Owner | Deliverable |
|-----|------|-------|-------------|
| 1 | Enum + Protocol + Grounding generation | Windsurf | 2,000 examples |
| 2 | Dedup, validation prompts, Milestone 1 training | Both | foundation_checkpoint |
| 3 | GUI + Scripting generation | Windsurf | 1,150 examples |
| 4 | Cross-domain + Multi-turn + Error recovery | Claude | 550 examples |
| 5 | Milestone 2 training + validation | Both | application_checkpoint |
| 6 | CPE-filtered CVEs + Defensive prompts | Both | ~750 examples |
| 7 | Milestone 3 training + Final validation | Both | evony-expert-v3-f16 |

---

# ⚠️ RISK MITIGATIONS

| Risk | Mitigation |
|------|------------|
| Version blur (Flash 10 vs 32) | Runtime context in EVERY CVE answer |
| Hallucination | Grounding contract + refusal examples |
| CVE garbage | CPE-based filtering + confidence tiers |
| Overfitting | Dedup + sampling ratios + two eval sets |
| Enum errors | Unit test harness + corrective micro-runs |
| Offense-enabling | Defensive-only security prompts |

---

# ✅ CHATGPT'S FINAL RECOMMENDATIONS APPLIED

1. ✅ **3-milestone hybrid** (not 4)
2. ✅ **Runtime context tagging** (Flash 10 vs 32)
3. ✅ **CPE-based CVE validation** (filter garbage)
4. ✅ **Defensive-only security prompts** (Category D rewritten)
5. ✅ **Grounding contract training** (200 examples)
6. ✅ **Refusal to guess examples** (100 examples)
7. ✅ **Dedup + sampling ratios** (55-65% core)
8. ✅ **Enum unit test harness** (mechanical verification)
9. ✅ **Two eval sets** (seen vs unseen CVEs)
10. ✅ **Reduced augmentation** (2x max, not 5x)

---

*PHASE 3 CORRECTED STRATEGY v1.0*  
*Based on ChatGPT critical analysis*  
*Ready for implementation*
