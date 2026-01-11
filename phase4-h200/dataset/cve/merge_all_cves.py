#!/usr/bin/env python3
"""Merge ALL CVE training data"""
import json
from pathlib import Path

print('🔥 MERGING ALL CVE DATA!')
print('='*60)

cve_dir = Path('CVE_Research')
training_dir = Path('training')

files_to_merge = [
    cve_dir / 'train_cve_extended.jsonl',
    cve_dir / 'train_cve_validated.jsonl', 
    cve_dir / 'train_exploit_focused.jsonl',
    cve_dir / 'train_batch2.jsonl',
    cve_dir / 'evony_cve_training.jsonl',
    training_dir / 'train_cve_security.jsonl',
]

all_examples = []
seen_questions = set()

for f in files_to_merge:
    if f.exists():
        count = 0
        with open(f, 'r', encoding='utf-8') as fp:
            for line in fp:
                try:
                    data = json.loads(line.strip())
                    if 'messages' in data:
                        # Dedupe by question
                        q = data['messages'][0].get('content', '')[:100]
                        if q not in seen_questions:
                            seen_questions.add(q)
                            all_examples.append(data)
                            count += 1
                except:
                    continue
        print(f'  ✅ {f.name}: {count} examples')
    else:
        print(f'  ❌ {f.name}: NOT FOUND')

# Save merged file
out_file = training_dir / 'train_cve_all.jsonl'
with open(out_file, 'w', encoding='utf-8') as f:
    for ex in all_examples:
        f.write(json.dumps(ex, ensure_ascii=False) + '\n')

print('='*60)
print(f'🏆 TOTAL CVE EXAMPLES: {len(all_examples)}')
print(f'💾 Saved to: {out_file}')
