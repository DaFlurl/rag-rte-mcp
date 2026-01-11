#!/usr/bin/env python3
"""Fix Claude's corrupted JSON and convert to training format"""
import json
import re
from pathlib import Path

print("Fixing Claude's evony_verified_cves.json...")

cve_dir = Path('CVE_Research')
input_file = cve_dir / 'evony_verified_cves.json'
output_file = cve_dir / 'train_claude_verified.jsonl'

# Read raw content
content = input_file.read_text(encoding='utf-8')

# Extract all CVE entries using regex
cve_pattern = r'\{"cve_id":\s*"(CVE-\d{4}-\d+)"[^}]+\}'
matches = re.findall(cve_pattern, content)

# Also extract full JSON objects
full_pattern = r'\{"cve_id":\s*"CVE-\d{4}-\d+"[^}]+\}'
cve_objects = re.findall(full_pattern, content)

print(f"Found {len(cve_objects)} CVE entries")

# Convert to training examples
examples = []
seen_cves = set()

for obj_str in cve_objects:
    try:
        # Fix any trailing issues
        obj_str = obj_str.rstrip(',')
        cve = json.loads(obj_str)
        
        cve_id = cve.get('cve_id', '')
        if cve_id in seen_cves:
            continue
        seen_cves.add(cve_id)
        
        # Build training Q&A
        q = f"What is {cve_id} and how does it affect Flash applications like Evony?"
        
        severity = cve.get('severity', 'CRITICAL')
        cvss = cve.get('cvss', 10.0)
        name = cve.get('name', 'Memory Corruption')
        affected = cve.get('affected', 'Flash Player')
        surface = cve.get('surface', 'Memory')
        confidence = cve.get('confidence', 'HIGH')
        bulletin = cve.get('bulletin', '')
        exploited = cve.get('exploited_in_wild', False)
        code_loc = cve.get('code_location', '')
        metasploit = cve.get('metasploit', '')
        
        a = f"""{cve_id}: {name}

**Severity**: {severity} (CVSS {cvss})
**Affected Versions**: {affected}
**Attack Surface**: {surface}
**Bulletin**: {bulletin if bulletin else 'N/A'}

**Evony Relevance**: {'CONFIRMED - ' + code_loc if code_loc else 'Applies to Flash 10.0.x used by Evony client'}
**Exploited in Wild**: {'YES - Active exploitation documented' if exploited else 'No known wild exploitation'}
{'**Metasploit Module**: ' + metasploit if metasploit else ''}

This vulnerability affects the {surface} subsystem in Flash Player. Evony's client (built with Flex SDK 3.5, targeting Flash 10.0.x) uses these APIs extensively, making it vulnerable to this CVE.

**Confidence**: {confidence}"""

        examples.append({
            'messages': [
                {'role': 'user', 'content': q},
                {'role': 'assistant', 'content': a.strip()}
            ]
        })
    except json.JSONDecodeError:
        continue

# Write output
with open(output_file, 'w', encoding='utf-8') as f:
    for ex in examples:
        f.write(json.dumps(ex) + '\n')

print(f"✅ Extracted {len(examples)} unique CVEs")
print(f"💾 Saved to: {output_file}")
