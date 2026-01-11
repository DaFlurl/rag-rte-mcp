#!/usr/bin/env python3
"""Process round3 CVEs and create diverse training examples"""
import json
from pathlib import Path

print('🏃 Processing round3 + creating MORE examples...')

# Process round3
raw = json.loads(Path('CVE_Research/nvd_round3.json').read_text())
examples = []

for item in raw:
    cve = item.get('cve', {})
    cve_id = cve.get('id', '')
    desc = ''
    for d in cve.get('descriptions', []):
        if d.get('lang') == 'en':
            desc = d.get('value', '')
            break
    if not desc:
        continue
    
    cvss = 0.0
    metrics = cve.get('metrics', {})
    for ver in ['cvssMetricV31', 'cvssMetricV30', 'cvssMetricV2']:
        if ver in metrics:
            cvss = metrics[ver][0].get('cvssData', {}).get('baseScore', 0)
            break
    
    examples.append({
        'messages': [
            {'role': 'user', 'content': f'Describe {cve_id} vulnerability.'},
            {'role': 'assistant', 'content': f'{cve_id} (CVSS {cvss})\n\n{desc[:350]}\n\nThis affects Flash Player versions including those used by Evony client.'}
        ]
    })

# Create APSB bulletin examples
apsb_bulletins = [
    ('APSB09-01', '2009-02', ['CVE-2009-0519', 'CVE-2009-0520', 'CVE-2009-0521', 'CVE-2009-0522']),
    ('APSB09-10', '2009-07', ['CVE-2009-1862', 'CVE-2009-1863', 'CVE-2009-1864', 'CVE-2009-1865']),
    ('APSB09-19', '2009-12', ['CVE-2009-3793', 'CVE-2009-3794', 'CVE-2009-3796', 'CVE-2009-3797', 'CVE-2009-3798', 'CVE-2009-3799', 'CVE-2009-3800', 'CVE-2009-3951']),
    ('APSB10-06', '2010-02', ['CVE-2010-0186', 'CVE-2010-0187']),
    ('APSB10-14', '2010-06', ['CVE-2010-1297']),
    ('APSB10-16', '2010-06', ['CVE-2010-2160', 'CVE-2010-2161', 'CVE-2010-2162', 'CVE-2010-2163', 'CVE-2010-2164', 'CVE-2010-2165', 'CVE-2010-2166', 'CVE-2010-2167', 'CVE-2010-2169', 'CVE-2010-2170', 'CVE-2010-2171', 'CVE-2010-2172', 'CVE-2010-2173', 'CVE-2010-2174', 'CVE-2010-2175', 'CVE-2010-2176', 'CVE-2010-2177', 'CVE-2010-2178', 'CVE-2010-2179', 'CVE-2010-2180', 'CVE-2010-2181', 'CVE-2010-2182', 'CVE-2010-2183', 'CVE-2010-2184', 'CVE-2010-2185', 'CVE-2010-2186', 'CVE-2010-2187', 'CVE-2010-2188', 'CVE-2010-2189']),
    ('APSB10-22', '2010-09', ['CVE-2010-2884']),
    ('APSB10-26', '2010-11', ['CVE-2010-3636', 'CVE-2010-3637', 'CVE-2010-3638', 'CVE-2010-3639', 'CVE-2010-3640', 'CVE-2010-3641', 'CVE-2010-3642', 'CVE-2010-3643', 'CVE-2010-3644', 'CVE-2010-3645', 'CVE-2010-3646', 'CVE-2010-3647', 'CVE-2010-3648', 'CVE-2010-3649', 'CVE-2010-3650', 'CVE-2010-3652', 'CVE-2010-3654']),
    ('APSB11-02', '2011-02', ['CVE-2011-0558', 'CVE-2011-0559', 'CVE-2011-0560', 'CVE-2011-0561', 'CVE-2011-0571', 'CVE-2011-0572', 'CVE-2011-0573', 'CVE-2011-0574', 'CVE-2011-0575', 'CVE-2011-0577', 'CVE-2011-0578', 'CVE-2011-0607', 'CVE-2011-0608']),
    ('APSB11-07', '2011-04', ['CVE-2011-0611']),
    ('APSB15-16', '2015-07', ['CVE-2015-5119', 'CVE-2015-5122', 'CVE-2015-5123']),
]

for apsb, date, cves in apsb_bulletins:
    examples.append({
        'messages': [
            {'role': 'user', 'content': f'What vulnerabilities are in Adobe Security Bulletin {apsb}?'},
            {'role': 'assistant', 'content': f'''# {apsb} ({date})

This Adobe Security Bulletin addresses {len(cves)} vulnerabilities in Flash Player:

**CVEs:** {', '.join(cves[:10])}{f' and {len(cves)-10} more' if len(cves) > 10 else ''}

**Impact:** Most are critical severity allowing arbitrary code execution.

**Evony Relevance:** Evony client (Flash 10.0.x, November 2009) predates this patch and is vulnerable to all listed CVEs if running on unpatched Flash runtime.

**Recommendation:** Use Ruffle emulator or ensure Flash Player is updated.'''}
        ]
    })

# Vulnerability type examples
vuln_types = [
    ('Use-After-Free', 'UAF vulnerabilities occur when code references memory after it has been freed. In Flash, this commonly happens with ByteArray, DisplayObject, and event handlers.', ['CVE-2015-5119', 'CVE-2015-0311', 'CVE-2015-0313']),
    ('Integer Overflow', 'Integer overflow happens when arithmetic operations exceed the maximum value of an integer type, causing wraparound. Flash is vulnerable in ByteArray length calculations and array indexing.', ['CVE-2015-0359', 'CVE-2009-3799', 'CVE-2010-2187']),
    ('Type Confusion', 'Type confusion occurs when code treats an object as a different type than intended, allowing memory corruption. AVM2 (ActionScript Virtual Machine 2) is susceptible.', ['CVE-2015-3077', 'CVE-2015-3078']),
    ('Buffer Overflow', 'Buffer overflow vulnerabilities allow writing beyond allocated memory. Flash has had numerous buffer overflows in image parsing, SWF handling, and data decompression.', ['CVE-2009-0519', 'CVE-2009-0520']),
    ('Heap Corruption', 'Heap corruption vulnerabilities allow manipulation of heap memory structures. Flash heap management has been targeted by many exploits.', ['CVE-2010-1297', 'CVE-2010-2884']),
]

for vtype, desc, cves in vuln_types:
    examples.append({
        'messages': [
            {'role': 'user', 'content': f'Explain {vtype} vulnerabilities in Flash Player.'},
            {'role': 'assistant', 'content': f'''# {vtype} in Flash Player

## Description
{desc}

## Notable CVEs
{chr(10).join([f'- **{c}**' for c in cves])}

## Evony Impact
The Evony client uses Flash Player 10.0.x and contains code patterns vulnerable to {vtype}:
- ByteArray operations in GameClient.as
- Object serialization/deserialization
- Network packet handling

## Detection
Look for patterns involving memory allocation, type casting, and arithmetic operations in ActionScript code.'''}
        ]
    })

# Attack surface examples
surfaces = [
    ('ByteArray', 'GameClient.as lines 7, 20-21, 87', 'Used for network packet serialization', ['uncompress()', 'readBytes()', 'writeBytes()', 'readObject()']),
    ('Socket', 'GameClient.as lines 8, 24', 'Used for server communication', ['connect()', 'readBytes()', 'writeBytes()', 'flush()']),
    ('ExternalInterface', 'EvonyClient.as line 32', 'Used for JavaScript communication', ['call()', 'addCallback()']),
    ('SharedObject', 'EvonyClient.as line 55', 'Used for local storage', ['getLocal()', 'flush()', '.data']),
    ('Loader', 'Various UI components', 'Used for loading external content', ['load()', 'loadBytes()', 'contentLoaderInfo']),
    ('XML', 'Configuration and data parsing', 'Used for game data', ['XML()', 'XMLList', 'parseXML()']),
]

for surf, location, usage, methods in surfaces:
    examples.append({
        'messages': [
            {'role': 'user', 'content': f'What security risks does {surf} pose in Flash applications like Evony?'},
            {'role': 'assistant', 'content': f'''# {surf} Security Analysis

## Location in Evony
**File:** `{location}`
**Usage:** {usage}

## Vulnerable Methods
{chr(10).join([f'- `{m}`' for m in methods])}

## Historical CVEs
Multiple CVEs have targeted {surf}:
- Memory corruption during operations
- Type confusion in method calls
- Integer overflow in size calculations

## Mitigation
1. Validate all input data before processing
2. Use try-catch around {surf} operations
3. Implement size limits and bounds checking
4. Consider using Ruffle instead of native Flash'''}
        ]
    })

# Save all examples
out_file = Path('CVE_Research/train_round3_comprehensive.jsonl')
with open(out_file, 'w', encoding='utf-8') as f:
    for ex in examples:
        f.write(json.dumps(ex, ensure_ascii=False) + '\n')

print(f'✅ Created {len(examples)} comprehensive examples!')
print(f'💾 Saved to {out_file}')
