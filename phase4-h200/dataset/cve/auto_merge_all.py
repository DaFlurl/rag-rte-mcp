#!/usr/bin/env python3
"""Auto-merge ALL CVE files including any new Claude batches"""
import json
from pathlib import Path

print('AUTO-MERGE: Scanning for all CVE files...')

cve_dir = Path('CVE_Research')
training_dir = Path('training')

# Find all JSONL training files
jsonl_files = list(cve_dir.glob('train_*.jsonl'))
jsonl_files.extend(list(cve_dir.glob('evony_cve*.jsonl')))
jsonl_files.append(training_dir / 'train_cve_security.jsonl')

# Find all Claude JSON files and convert
claude_json_files = list(cve_dir.glob('claude_cve*.json'))

all_ex = []
seen = set()

# Process JSONL files
for f in jsonl_files:
    if f.exists():
        count = 0
        for line in open(f, 'r', encoding='utf-8'):
            try:
                data = json.loads(line.strip())
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
        if count > 0:
            print(f'  {f.name}: +{count}')

# Process Claude JSON files
for cf in claude_json_files:
    try:
        data = json.loads(cf.read_text())
        count = 0
        for cve in data.get('cves', []):
            q = f"What is {cve['cve_id']} and does it affect Evony?"
            if q[:100] not in seen:
                seen.add(q[:100])
                a = f"{cve['cve_id']} ({cve.get('severity', 'CRITICAL')}, CVSS {cve.get('cvss_score', 'N/A')})\n\n{cve.get('description', '')}\n\nAffected Versions: {', '.join(cve.get('affected_versions', []))}\nSurfaces: {', '.join(cve.get('surfaces', []))}\nApplies to Evony: {'Yes' if cve.get('applies_to_evony') else 'Potentially'}\nConfidence: {cve.get('confidence', 'HIGH')}"
                all_ex.append({
                    'messages': [
                        {'role': 'user', 'content': q},
                        {'role': 'assistant', 'content': a}
                    ]
                })
                count += 1
        if count > 0:
            print(f'  {cf.name}: +{count} (JSON)')
    except Exception as e:
        print(f'  Error {cf.name}: {e}')

# Save merged file
out_file = training_dir / 'train_cve_all.jsonl'
with open(out_file, 'w', encoding='utf-8') as f:
    for ex in all_ex:
        f.write(json.dumps(ex) + '\n')

print(f'\n🏆 TOTAL: {len(all_ex)} CVE EXAMPLES!')
print(f'💾 Saved to: {out_file}')
