# Evony Training Dataset (Phase 4 - H200 Ready)

## Overview

This dataset contains cleaned, deduplicated, and validated training data for fine-tuning LLMs on Evony game knowledge, including:
- Game mechanics and strategies
- Bot automation (AutoEvony, Borg toolkit)
- Protocol analysis (AMF, packets)
- Exploit documentation and CVE research
- Client decompilation knowledge

## Dataset Statistics

| Metric | Value |
|--------|-------|
| **Total Entries** | 84,627 |
| **Training Set** | 76,164 (90%) |
| **Validation Set** | 8,463 (10%) |
| **Total Messages** | 183,842 |
| **Total Characters** | 77,326,075 |
| **Avg Messages/Entry** | 2.17 |
| **Avg Chars/Entry** | 914 |

## Files

| File | Description | Entries |
|------|-------------|---------|
| `MASTER_TRAINING.jsonl` | All validated entries | 84,627 |
| `train.jsonl` | Training split | 76,164 |
| `val.jsonl` | Validation split | 8,463 |
| `dataset_stats.json` | Detailed statistics | - |

## Format

All files use ChatML/messages format:

```json
{"messages": [
    {"role": "user", "content": "How do I optimize troop training in Evony?"},
    {"role": "assistant", "content": "To optimize troop training in Evony..."}
]}
```

## Data Sources

This dataset was consolidated from 57 source files covering:
- AutoEvony bot source code and documentation
- EvonyClient decompiled ActionScript
- Borg toolkit automation scripts
- Protocol/packet analysis documents
- Game mechanics and strategy guides
- CVE/security research

## Cleaning Process

1. **Round 1 (Claude):** Removed 932 junk files (licenses, virus docs, tool configs)
2. **Round 2 (Windsurf):** Deep-cleaned JSONL, removed 7,804 non-Evony entries
3. **Round 3 (Claude):** Deduplicated, validated, normalized, and split dataset

### Deduplication
- 141,118 duplicate entries removed
- Content hashing used for exact match detection

### Validation
- 7 invalid/malformed entries removed
- Verified message structure and content quality

## Usage

### For Hugging Face Transformers
```python
from datasets import load_dataset
dataset = load_dataset('json', data_files={'train': 'train.jsonl', 'val': 'val.jsonl'})
```

### For LM Studio / Ollama
Use `MASTER_TRAINING.jsonl` directly with your preferred training script.

## Role Distribution

| Role | Count |
|------|-------|
| assistant | 84,627 |
| system | 24,553 |
| user | 74,662 |

---

*Generated: 2026-01-07 03:28:19*  
*Dataset Version: Phase 4 H200*
