#!/usr/bin/env python3
"""Process Claude's CVE batch and merge everything"""
import json
from pathlib import Path

print('Processing Claude batch + final merge...')

cve_dir = Path('CVE_Research')
training_dir = Path('training')

# Process Claude's JSON files
claude_json_files = list(cve_dir.glob('claude_cve*.json'))
claude_examples = []

for cf in claude_json_files:
    try:
        data = json.loads(cf.read_text())
        for cve in data.get('cves', []):
            q = f"What is {cve['cve_id']} and does it affect Evony?"
            a = f"""{cve['cve_id']} ({cve.get('severity', 'CRITICAL')}, CVSS {cve.get('cvss_score', 'N/A')})

{cve.get('description', '')}

Affected Versions: {', '.join(cve.get('affected_versions', []))}
Surfaces: {', '.join(cve.get('surfaces', []))}
Applies to Evony: {'Yes' if cve.get('applies_to_evony') else 'Potentially'}
Confidence: {cve.get('confidence', 'HIGH')}"""
            
            claude_examples.append({
                'messages': [
                    {'role': 'user', 'content': q},
                    {'role': 'assistant', 'content': a}
                ]
            })
        print(f'  {cf.name}: {len(data.get("cves", []))} CVEs')
    except Exception as e:
        print(f'  Error processing {cf.name}: {e}')

# Save Claude's converted examples
if claude_examples:
    out = cve_dir / 'train_claude_json.jsonl'
    with open(out, 'w', encoding='utf-8') as f:
        for ex in claude_examples:
            f.write(json.dumps(ex) + '\n')
    print(f'  Saved {len(claude_examples)} to train_claude_json.jsonl')

# Now do final merge of everything
print('\nFinal merge of all CVE data...')

all_files = [
    cve_dir / 'train_cve_validated.jsonl',
    cve_dir / 'train_exploit_focused.jsonl',
    cve_dir / 'train_batch2.jsonl',
    cve_dir / 'train_round3_comprehensive.jsonl',
    cve_dir / 'train_diverse_extra.jsonl',
    cve_dir / 'train_final_sprint.jsonl',
    cve_dir / 'train_claude_json.jsonl',
    cve_dir / 'evony_cve_expanded_training.jsonl',
    cve_dir / 'evony_cve_training.jsonl',
    training_dir / 'train_cve_security.jsonl',
]

all_ex = []
seen = set()

for f in all_files:
    if f.exists():
        count = 0
        for line in open(f, 'r', encoding='utf-8'):
            try:
                data = json.loads(line.strip())
                # Handle both formats
                if 'messages' in data:
                    q = data['messages'][0].get('content', '')[:100]
                    if q not in seen:
                        seen.add(q)
                        all_ex.append(data)
                        count += 1
                elif 'instruction' in data:
                    q = data.get('instruction', '')[:100]
                    if q not in seen:
                        seen.add(q)
                        all_ex.append({
                            'messages': [
                                {'role': 'user', 'content': data.get('instruction', '')},
                                {'role': 'assistant', 'content': data.get('output', '')}
                            ]
                        })
                        count += 1
            except:
                pass
        print(f'  {f.name}: +{count}')

# Save final merged file
out_file = training_dir / 'train_cve_all.jsonl'
with open(out_file, 'w', encoding='utf-8') as f:
    for ex in all_ex:
        f.write(json.dumps(ex) + '\n')

print(f'\nTOTAL: {len(all_ex)} CVE EXAMPLES!')
print(f'Saved to: {out_file}')
