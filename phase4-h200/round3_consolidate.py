#!/usr/bin/env python3
"""
Round 3: Dataset Consolidation, Deduplication & Verification
Claude Opus 4.5 - 2026-01-07
"""

import json
import os
import hashlib
from pathlib import Path
from collections import defaultdict
from datetime import datetime
import random

# Configuration
DATASET_DIR = Path(r"C:\Users\Admin\Downloads\Evony_Decrypted\phase4-h200\dataset")
TRAINING_DIR = DATASET_DIR / "training_jsonl"
OUTPUT_DIR = DATASET_DIR / "final_training"
TRAIN_SPLIT = 0.9  # 90% train, 10% val

def compute_content_hash(entry):
    """Create a hash of the entry content for deduplication."""
    # Normalize the entry to a consistent string representation
    if isinstance(entry, dict):
        # Handle different formats
        if 'messages' in entry:
            content = json.dumps(entry['messages'], sort_keys=True)
        elif 'instruction' in entry:
            content = f"{entry.get('instruction', '')}{entry.get('input', '')}{entry.get('output', '')}"
        elif 'prompt' in entry:
            content = f"{entry.get('prompt', '')}{entry.get('response', '')}"
        elif 'text' in entry:
            content = entry['text']
        elif 'question' in entry:
            content = f"{entry.get('question', '')}{entry.get('answer', '')}"
        else:
            content = json.dumps(entry, sort_keys=True)
    else:
        content = str(entry)
    
    return hashlib.md5(content.encode('utf-8')).hexdigest()

def normalize_entry(entry, source_file):
    """Normalize entry to standard ChatML format."""
    if not isinstance(entry, dict):
        return None
    
    # Already in messages format
    if 'messages' in entry and isinstance(entry['messages'], list):
        return {'messages': entry['messages'], '_source': source_file}
    
    # Alpaca/instruction format
    if 'instruction' in entry:
        messages = []
        user_content = entry.get('instruction', '')
        if entry.get('input'):
            user_content += f"\n\n{entry['input']}"
        messages.append({'role': 'user', 'content': user_content})
        if entry.get('output'):
            messages.append({'role': 'assistant', 'content': entry['output']})
        return {'messages': messages, '_source': source_file}
    
    # Prompt/response format
    if 'prompt' in entry:
        messages = [{'role': 'user', 'content': entry['prompt']}]
        if entry.get('response'):
            messages.append({'role': 'assistant', 'content': entry['response']})
        elif entry.get('completion'):
            messages.append({'role': 'assistant', 'content': entry['completion']})
        return {'messages': messages, '_source': source_file}
    
    # Question/answer format
    if 'question' in entry:
        messages = [{'role': 'user', 'content': entry['question']}]
        if entry.get('answer'):
            messages.append({'role': 'assistant', 'content': entry['answer']})
        return {'messages': messages, '_source': source_file}
    
    # Text only format (for completion training)
    if 'text' in entry:
        return {'messages': [{'role': 'assistant', 'content': entry['text']}], '_source': source_file}
    
    # Conversation format
    if 'conversation' in entry:
        return {'messages': entry['conversation'], '_source': source_file}
    
    return None

def validate_entry(entry):
    """Validate entry format and content quality."""
    issues = []
    
    if not entry or not isinstance(entry, dict):
        return False, ['Invalid entry type']
    
    messages = entry.get('messages', [])
    if not messages:
        return False, ['No messages']
    
    if not isinstance(messages, list):
        return False, ['Messages is not a list']
    
    for i, msg in enumerate(messages):
        if not isinstance(msg, dict):
            issues.append(f'Message {i} is not a dict')
            continue
        if 'role' not in msg:
            issues.append(f'Message {i} missing role')
        if 'content' not in msg:
            issues.append(f'Message {i} missing content')
        elif not msg['content'] or not msg['content'].strip():
            issues.append(f'Message {i} has empty content')
    
    # Check for minimum content quality
    total_content = ''.join(m.get('content', '') for m in messages if isinstance(m, dict))
    if len(total_content) < 20:
        issues.append('Total content too short (<20 chars)')
    
    return len(issues) == 0, issues

def load_file(filepath):
    """Load entries from JSON or JSONL file."""
    entries = []
    filepath = Path(filepath)
    
    try:
        with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read().strip()
            
        if not content:
            return entries
            
        # Try JSONL first (one JSON object per line)
        if filepath.suffix == '.jsonl' or '\n{' in content:
            for line_num, line in enumerate(content.split('\n'), 1):
                line = line.strip()
                if not line:
                    continue
                try:
                    entry = json.loads(line)
                    if entry:
                        entries.append(entry)
                except json.JSONDecodeError:
                    pass
        else:
            # Try as single JSON (array or object)
            try:
                data = json.loads(content)
                if isinstance(data, list):
                    entries.extend(data)
                elif isinstance(data, dict):
                    # Could be a single entry or a wrapper
                    if 'data' in data:
                        entries.extend(data['data'] if isinstance(data['data'], list) else [data['data']])
                    elif 'entries' in data:
                        entries.extend(data['entries'])
                    elif 'messages' in data or 'instruction' in data:
                        entries.append(data)
            except json.JSONDecodeError:
                pass
                
    except Exception as e:
        print(f"  Error reading {filepath.name}: {e}")
    
    return entries

def main():
    print("=" * 70)
    print("ROUND 3: DATASET CONSOLIDATION, DEDUPLICATION & VERIFICATION")
    print("=" * 70)
    print(f"Started: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print()
    
    # Create output directory
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    
    # Phase 1: Load all entries from all files
    print("PHASE 1: Loading all training files...")
    print("-" * 50)
    
    all_entries = []
    file_stats = {}
    
    for filepath in sorted(TRAINING_DIR.glob('*')):
        if filepath.suffix not in ['.json', '.jsonl']:
            continue
        
        entries = load_file(filepath)
        file_stats[filepath.name] = len(entries)
        
        for entry in entries:
            normalized = normalize_entry(entry, filepath.name)
            if normalized:
                all_entries.append(normalized)
        
        print(f"  {filepath.name}: {len(entries)} entries")
    
    print(f"\nTotal raw entries loaded: {len(all_entries)}")
    
    # Phase 2: Deduplication
    print("\nPHASE 2: Deduplicating entries...")
    print("-" * 50)
    
    seen_hashes = {}
    unique_entries = []
    duplicate_count = 0
    duplicate_sources = defaultdict(int)
    
    for entry in all_entries:
        content_hash = compute_content_hash(entry)
        
        if content_hash not in seen_hashes:
            seen_hashes[content_hash] = entry['_source']
            unique_entries.append(entry)
        else:
            duplicate_count += 1
            duplicate_sources[entry['_source']] += 1
    
    print(f"  Unique entries: {len(unique_entries)}")
    print(f"  Duplicates removed: {duplicate_count}")
    
    if duplicate_sources:
        print("\n  Top duplicate sources:")
        for source, count in sorted(duplicate_sources.items(), key=lambda x: -x[1])[:10]:
            print(f"    {source}: {count} duplicates")
    
    # Phase 3: Validation
    print("\nPHASE 3: Validating entries...")
    print("-" * 50)
    
    valid_entries = []
    invalid_count = 0
    issue_counts = defaultdict(int)
    
    for entry in unique_entries:
        is_valid, issues = validate_entry(entry)
        if is_valid:
            # Remove internal _source field for final output
            clean_entry = {'messages': entry['messages']}
            valid_entries.append(clean_entry)
        else:
            invalid_count += 1
            for issue in issues:
                issue_counts[issue] += 1
    
    print(f"  Valid entries: {len(valid_entries)}")
    print(f"  Invalid entries removed: {invalid_count}")
    
    if issue_counts:
        print("\n  Validation issues found:")
        for issue, count in sorted(issue_counts.items(), key=lambda x: -x[1]):
            print(f"    {issue}: {count}")
    
    # Phase 4: Train/Val Split
    print("\nPHASE 4: Creating train/val split...")
    print("-" * 50)
    
    random.seed(42)  # Reproducible split
    random.shuffle(valid_entries)
    
    split_idx = int(len(valid_entries) * TRAIN_SPLIT)
    train_entries = valid_entries[:split_idx]
    val_entries = valid_entries[split_idx:]
    
    print(f"  Training set: {len(train_entries)} entries ({TRAIN_SPLIT*100:.0f}%)")
    print(f"  Validation set: {len(val_entries)} entries ({(1-TRAIN_SPLIT)*100:.0f}%)")
    
    # Phase 5: Write output files
    print("\nPHASE 5: Writing consolidated files...")
    print("-" * 50)
    
    # Master file with all entries
    master_path = OUTPUT_DIR / "MASTER_TRAINING.jsonl"
    with open(master_path, 'w', encoding='utf-8') as f:
        for entry in valid_entries:
            f.write(json.dumps(entry, ensure_ascii=False) + '\n')
    print(f"  Created: MASTER_TRAINING.jsonl ({len(valid_entries)} entries)")
    
    # Train split
    train_path = OUTPUT_DIR / "train.jsonl"
    with open(train_path, 'w', encoding='utf-8') as f:
        for entry in train_entries:
            f.write(json.dumps(entry, ensure_ascii=False) + '\n')
    print(f"  Created: train.jsonl ({len(train_entries)} entries)")
    
    # Validation split
    val_path = OUTPUT_DIR / "val.jsonl"
    with open(val_path, 'w', encoding='utf-8') as f:
        for entry in val_entries:
            f.write(json.dumps(entry, ensure_ascii=False) + '\n')
    print(f"  Created: val.jsonl ({len(val_entries)} entries)")
    
    # Phase 6: Generate statistics
    print("\nPHASE 6: Generating statistics...")
    print("-" * 50)
    
    # Compute content stats
    total_messages = sum(len(e['messages']) for e in valid_entries)
    total_chars = sum(
        sum(len(m.get('content', '')) for m in e['messages'])
        for e in valid_entries
    )
    avg_messages = total_messages / len(valid_entries) if valid_entries else 0
    avg_chars = total_chars / len(valid_entries) if valid_entries else 0
    
    # Role distribution
    role_counts = defaultdict(int)
    for entry in valid_entries:
        for msg in entry['messages']:
            role_counts[msg.get('role', 'unknown')] += 1
    
    stats = {
        'generated': datetime.now().isoformat(),
        'source_files': len(file_stats),
        'raw_entries_loaded': len(all_entries),
        'duplicates_removed': duplicate_count,
        'invalid_removed': invalid_count,
        'final_entries': len(valid_entries),
        'train_entries': len(train_entries),
        'val_entries': len(val_entries),
        'train_split_ratio': TRAIN_SPLIT,
        'total_messages': total_messages,
        'total_characters': total_chars,
        'avg_messages_per_entry': round(avg_messages, 2),
        'avg_chars_per_entry': round(avg_chars, 2),
        'role_distribution': dict(role_counts),
        'source_file_counts': file_stats
    }
    
    stats_path = OUTPUT_DIR / "dataset_stats.json"
    with open(stats_path, 'w', encoding='utf-8') as f:
        json.dump(stats, f, indent=2, ensure_ascii=False)
    print(f"  Created: dataset_stats.json")
    
    # Phase 7: Create README
    print("\nPHASE 7: Creating documentation...")
    print("-" * 50)
    
    readme_content = f"""# Evony Training Dataset (Phase 4 - H200 Ready)

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
| **Total Entries** | {len(valid_entries):,} |
| **Training Set** | {len(train_entries):,} ({TRAIN_SPLIT*100:.0f}%) |
| **Validation Set** | {len(val_entries):,} ({(1-TRAIN_SPLIT)*100:.0f}%) |
| **Total Messages** | {total_messages:,} |
| **Total Characters** | {total_chars:,} |
| **Avg Messages/Entry** | {avg_messages:.2f} |
| **Avg Chars/Entry** | {avg_chars:.0f} |

## Files

| File | Description | Entries |
|------|-------------|---------|
| `MASTER_TRAINING.jsonl` | All validated entries | {len(valid_entries):,} |
| `train.jsonl` | Training split | {len(train_entries):,} |
| `val.jsonl` | Validation split | {len(val_entries):,} |
| `dataset_stats.json` | Detailed statistics | - |

## Format

All files use ChatML/messages format:

```json
{{"messages": [
    {{"role": "user", "content": "How do I optimize troop training in Evony?"}},
    {{"role": "assistant", "content": "To optimize troop training in Evony..."}}
]}}
```

## Data Sources

This dataset was consolidated from {len(file_stats)} source files covering:
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
- {duplicate_count:,} duplicate entries removed
- Content hashing used for exact match detection

### Validation
- {invalid_count:,} invalid/malformed entries removed
- Verified message structure and content quality

## Usage

### For Hugging Face Transformers
```python
from datasets import load_dataset
dataset = load_dataset('json', data_files={{'train': 'train.jsonl', 'val': 'val.jsonl'}})
```

### For LM Studio / Ollama
Use `MASTER_TRAINING.jsonl` directly with your preferred training script.

## Role Distribution

| Role | Count |
|------|-------|
"""
    for role, count in sorted(role_counts.items()):
        readme_content += f"| {role} | {count:,} |\n"
    
    readme_content += f"""
---

*Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}*  
*Dataset Version: Phase 4 H200*
"""
    
    readme_path = OUTPUT_DIR / "README.md"
    with open(readme_path, 'w', encoding='utf-8') as f:
        f.write(readme_content)
    print(f"  Created: README.md")
    
    # Final Summary
    print("\n" + "=" * 70)
    print("ROUND 3 COMPLETE - SUMMARY")
    print("=" * 70)
    print(f"""
Source Files Processed:  {len(file_stats)}
Raw Entries Loaded:      {len(all_entries):,}
Duplicates Removed:      {duplicate_count:,}
Invalid Entries Removed: {invalid_count:,}
Final Valid Entries:     {len(valid_entries):,}

Output Files Created in: {OUTPUT_DIR}
  - MASTER_TRAINING.jsonl  ({len(valid_entries):,} entries)
  - train.jsonl            ({len(train_entries):,} entries)
  - val.jsonl              ({len(val_entries):,} entries)
  - dataset_stats.json
  - README.md
""")
    
    return stats

if __name__ == "__main__":
    main()
