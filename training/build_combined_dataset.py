#!/usr/bin/env python3
"""
Build Combined Dataset for Maximum Quality Training
Merges all training data: Source + Protocol + CVE
"""

import json
from pathlib import Path

SCRIPT_DIR = Path(__file__).parent
DATA_DIR = SCRIPT_DIR / "data"

print("Building COMBINED dataset for maximum quality training...")
print("="*60)

all_examples = []
seen = set()

# Source files to merge
source_files = [
    DATA_DIR / "train_multitask.jsonl",      # Phase 1+2 data
    DATA_DIR / "train_complete_source.jsonl", # Source code
    SCRIPT_DIR / "train_cve_all.jsonl",       # CVE data
]

for f in source_files:
    if f.exists():
        count = 0
        for line in open(f, 'r', encoding='utf-8'):
            try:
                data = json.loads(line.strip())
                if 'messages' in data and len(data['messages']) >= 2:
                    # Dedupe by first 100 chars of user message
                    key = data['messages'][0].get('content', '')[:100]
                    if key not in seen:
                        seen.add(key)
                        all_examples.append(data)
                        count += 1
            except:
                pass
        print(f"  {f.name}: +{count}")

# Save combined
output_file = SCRIPT_DIR / "train_combined_all.jsonl"
with open(output_file, 'w', encoding='utf-8') as f:
    for ex in all_examples:
        f.write(json.dumps(ex) + '\n')

print("="*60)
print(f"🏆 TOTAL COMBINED: {len(all_examples)} examples")
print(f"💾 Saved to: {output_file}")
print(f"📦 Size: {output_file.stat().st_size / 1024 / 1024:.2f} MB")
