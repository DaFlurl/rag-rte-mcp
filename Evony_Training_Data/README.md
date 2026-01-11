# Evony Training Data

**Generated**: 2026-01-04 20:31:23

## Summary

| Metric | Value |
|--------|-------|
| Total Examples | 36,370 |
| Training Set | 32,733 |
| Validation Set | 3,637 |
| Files Processed | 8,916 |

## Examples by Category

| Category | Examples |
|----------|----------|
| source_code | 35,589 |
| protocol | 640 |
| scripts | 106 |
| exploits | 26 |
| keys | 9 |

## Format

Each example is in Alpaca format:
```json
{
  "instruction": "Question about Evony",
  "input": "",
  "output": "Detailed answer with code examples",
  "category": "source_code"
}
```

## Files

- `train.json` - Training set (90%)
- `val.json` - Validation set (10%)
- `train.jsonl` - JSONL format for some frameworks
- `val.jsonl` - JSONL validation
- `stats.json` - Generation statistics

## Usage

### With Hugging Face Transformers
```python
from datasets import load_dataset
dataset = load_dataset('json', data_files={
    'train': 'train.json',
    'validation': 'val.json'
})
```

### With Axolotl
```yaml
datasets:
  - path: ./Evony_Training_Data/train.json
    type: alpaca
```
