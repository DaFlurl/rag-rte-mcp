#!/usr/bin/env python3
"""Process batch2 CVEs into training examples"""
import json
from pathlib import Path

print('🏃 Processing batch2 CVEs...')

raw = json.loads(Path('CVE_Research/nvd_batch2.json').read_text())
examples = []

for item in raw:
    cve = item.get('cve', {})
    cve_id = cve.get('id', '')
    
    desc = ''
    for d in cve.get('descriptions', []):
        if d.get('lang') == 'en':
            desc = d.get('value', '')
            break
    
    if not desc or 'flash' not in desc.lower():
        continue
    
    # Get CVSS
    cvss = 0.0
    metrics = cve.get('metrics', {})
    for ver in ['cvssMetricV31', 'cvssMetricV30', 'cvssMetricV2']:
        if ver in metrics:
            cvss = metrics[ver][0].get('cvssData', {}).get('baseScore', 0)
            break
    
    q = f'What is {cve_id} and its impact on Flash applications?'
    a = f'''{cve_id} (CVSS {cvss})

{desc[:400]}

**Evony Impact:** This vulnerability affects Flash Player versions used by Evony (Flash 10.0.x). The client may be vulnerable if running on unpatched Flash runtime.

**Mitigation:** Update Flash Player or use Ruffle emulator.'''
    
    examples.append({
        'messages': [
            {'role': 'user', 'content': q},
            {'role': 'assistant', 'content': a}
        ]
    })

out_file = Path('CVE_Research/train_batch2.jsonl')
with open(out_file, 'w', encoding='utf-8') as f:
    for ex in examples:
        f.write(json.dumps(ex, ensure_ascii=False) + '\n')

print(f'✅ Created {len(examples)} examples from batch2!')
