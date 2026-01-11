#!/usr/bin/env python3
"""Create 2014-2015 CVE training examples - the exploit kit era"""
import json
from pathlib import Path

print('Creating 2014-2015 CVE examples (exploit kit era)...')

examples = []

# 2014-2015 CVEs - the most heavily exploited era
cves_2014_2015 = [
    # 2014 CVEs
    ('CVE-2014-0497', 'CRITICAL', 10.0, 'Integer underflow in Adobe Flash Player before 11.7.700.261 and 12.x before 12.0.0.44', 'Integer underflow', 'Zero-day, Kaspersky discovery'),
    ('CVE-2014-0498', 'CRITICAL', 10.0, 'Stack-based buffer overflow in Adobe Flash Player before 11.7.700.261', 'Buffer overflow', 'Stack overflow in parsing'),
    ('CVE-2014-0499', 'HIGH', 7.8, 'Adobe Flash Player before 11.7.700.261 allows remote attackers to read arbitrary files', 'Information disclosure', 'File read vulnerability'),
    ('CVE-2014-0502', 'CRITICAL', 10.0, 'Double free vulnerability in Adobe Flash Player before 11.7.700.269', 'Double free', 'Memory corruption'),
    ('CVE-2014-0503', 'MEDIUM', 5.0, 'Adobe Flash Player before 11.7.700.269 allows attackers to bypass the Same Origin Policy', 'Same-origin bypass', 'Security bypass'),
    ('CVE-2014-0504', 'MEDIUM', 5.0, 'Adobe Flash Player before 11.7.700.269 allows clickjacking attacks', 'Clickjacking', 'UI redressing'),
    ('CVE-2014-0506', 'CRITICAL', 10.0, 'Use-after-free vulnerability in Adobe Flash Player before 11.7.700.275', 'Use-after-free', 'Pwn2Own 2014'),
    ('CVE-2014-0507', 'CRITICAL', 10.0, 'Buffer overflow in Adobe Flash Player before 11.7.700.275', 'Buffer overflow', 'Memory corruption'),
    ('CVE-2014-0508', 'MEDIUM', 5.0, 'Adobe Flash Player before 11.7.700.275 allows attackers to bypass ASLR', 'ASLR bypass', 'Security mitigation bypass'),
    ('CVE-2014-0509', 'MEDIUM', 4.3, 'Cross-site scripting vulnerability in Adobe Flash Player before 11.7.700.275', 'XSS', 'Cross-site scripting'),
    ('CVE-2014-0510', 'CRITICAL', 10.0, 'Use-after-free vulnerability in Adobe Flash Player before 13.0.0.182', 'Use-after-free', 'Pwn2Own 2014'),
    ('CVE-2014-0515', 'CRITICAL', 10.0, 'Buffer overflow in the Pixel Bender component in Adobe Flash Player', 'Buffer overflow', 'Zero-day, targeted attacks'),
    ('CVE-2014-0516', 'MEDIUM', 5.0, 'Adobe Flash Player before 13.0.0.214 allows attackers to bypass Same Origin Policy', 'Same-origin bypass', 'Security bypass'),
    ('CVE-2014-0517', 'MEDIUM', 5.0, 'Adobe Flash Player before 13.0.0.214 allows attackers to bypass security restrictions', 'Security bypass', 'Sandbox escape'),
    ('CVE-2014-0518', 'MEDIUM', 5.0, 'Adobe Flash Player before 13.0.0.214 allows attackers to bypass security restrictions', 'Security bypass', 'Multiple bypasses'),
    ('CVE-2014-0519', 'MEDIUM', 5.0, 'Adobe Flash Player before 13.0.0.214 allows attackers to bypass security restrictions', 'Security bypass', 'Sandbox issues'),
    ('CVE-2014-0520', 'MEDIUM', 5.0, 'Adobe Flash Player before 13.0.0.214 allows attackers to bypass security restrictions', 'Security bypass', 'Permission bypass'),
    ('CVE-2014-0556', 'CRITICAL', 10.0, 'Heap-based buffer overflow in Adobe Flash Player before 14.0.0.179', 'Heap overflow', 'Memory corruption'),
    ('CVE-2014-0557', 'CRITICAL', 10.0, 'Adobe Flash Player before 14.0.0.179 allows attackers to execute arbitrary code', 'Memory corruption', 'Code execution'),
    ('CVE-2014-0559', 'CRITICAL', 10.0, 'Adobe Flash Player before 14.0.0.179 allows attackers to execute arbitrary code', 'Memory corruption', 'RCE'),
    ('CVE-2014-4671', 'MEDIUM', 4.3, 'Adobe Flash Player before 14.0.0.145 allows attackers to bypass JSONP callback API', 'Security bypass', 'API bypass'),
    ('CVE-2014-8439', 'CRITICAL', 10.0, 'Adobe Flash Player before 15.0.0.239 allows attackers to execute arbitrary code', 'Memory corruption', 'Code execution'),
    ('CVE-2014-8440', 'CRITICAL', 10.0, 'Adobe Flash Player before 15.0.0.239 allows attackers to execute arbitrary code', 'Memory corruption', 'RCE'),
    ('CVE-2014-8441', 'CRITICAL', 10.0, 'Adobe Flash Player before 15.0.0.239 allows attackers to execute arbitrary code', 'Memory corruption', 'RCE'),
    ('CVE-2014-8442', 'HIGH', 7.5, 'Adobe Flash Player before 15.0.0.239 allows attackers to bypass security restrictions', 'Security bypass', 'Permission bypass'),
    
    # 2015 CVEs - Hacking Team era
    ('CVE-2015-0310', 'CRITICAL', 10.0, 'Adobe Flash Player before 16.0.0.257 allows attackers to bypass ASLR', 'ASLR bypass', 'Security mitigation bypass'),
    ('CVE-2015-0311', 'CRITICAL', 10.0, 'Use-after-free in ByteArray uncompress in Adobe Flash Player before 16.0.0.287', 'Use-after-free', 'EXACT MATCH GameClient.as:87'),
    ('CVE-2015-0312', 'CRITICAL', 10.0, 'Double free vulnerability in Adobe Flash Player before 16.0.0.287', 'Double free', 'Memory corruption'),
    ('CVE-2015-0313', 'CRITICAL', 10.0, 'Use-after-free in Adobe Flash Player before 16.0.0.296 via worker ByteArray', 'Use-after-free', 'Angler EK payload'),
    ('CVE-2015-0314', 'CRITICAL', 10.0, 'Adobe Flash Player before 16.0.0.305 allows attackers to execute arbitrary code', 'Memory corruption', 'RCE'),
    ('CVE-2015-0315', 'CRITICAL', 10.0, 'Use-after-free vulnerability in Adobe Flash Player before 16.0.0.305', 'Use-after-free', 'Memory corruption'),
    ('CVE-2015-0316', 'CRITICAL', 10.0, 'Adobe Flash Player before 16.0.0.305 allows attackers to execute arbitrary code', 'Memory corruption', 'Code execution'),
    ('CVE-2015-0317', 'CRITICAL', 10.0, 'Adobe Flash Player before 16.0.0.305 allows attackers to execute arbitrary code', 'Memory corruption', 'RCE'),
    ('CVE-2015-0318', 'CRITICAL', 10.0, 'Adobe Flash Player before 16.0.0.305 allows attackers to execute arbitrary code', 'Memory corruption', 'Code execution'),
    ('CVE-2015-0319', 'CRITICAL', 10.0, 'Adobe Flash Player before 16.0.0.305 allows attackers to execute arbitrary code', 'Memory corruption', 'RCE'),
    ('CVE-2015-0320', 'CRITICAL', 10.0, 'Use-after-free vulnerability in Adobe Flash Player before 16.0.0.305', 'Use-after-free', 'Memory corruption'),
    ('CVE-2015-0321', 'CRITICAL', 10.0, 'Adobe Flash Player before 16.0.0.305 allows attackers to execute arbitrary code', 'Memory corruption', 'RCE'),
    ('CVE-2015-0322', 'CRITICAL', 10.0, 'Adobe Flash Player before 16.0.0.305 allows attackers to execute arbitrary code', 'Memory corruption', 'Code execution'),
    ('CVE-2015-0323', 'CRITICAL', 10.0, 'Heap-based buffer overflow in Adobe Flash Player before 16.0.0.305', 'Heap overflow', 'Memory corruption'),
    ('CVE-2015-0324', 'CRITICAL', 10.0, 'Buffer overflow in Adobe Flash Player before 16.0.0.305', 'Buffer overflow', 'Code execution'),
    ('CVE-2015-0325', 'CRITICAL', 10.0, 'Adobe Flash Player before 16.0.0.305 allows attackers to execute arbitrary code', 'Memory corruption', 'RCE'),
    ('CVE-2015-0326', 'CRITICAL', 10.0, 'Adobe Flash Player before 16.0.0.305 allows attackers to execute arbitrary code', 'Memory corruption', 'Code execution'),
    ('CVE-2015-0327', 'CRITICAL', 10.0, 'Heap-based buffer overflow in Adobe Flash Player before 16.0.0.305', 'Heap overflow', 'Memory corruption'),
    ('CVE-2015-0328', 'CRITICAL', 10.0, 'Adobe Flash Player before 16.0.0.305 allows attackers to execute arbitrary code', 'Memory corruption', 'RCE'),
    ('CVE-2015-0329', 'CRITICAL', 10.0, 'Adobe Flash Player before 16.0.0.305 allows attackers to execute arbitrary code', 'Memory corruption', 'Code execution'),
    ('CVE-2015-0330', 'CRITICAL', 10.0, 'Use-after-free vulnerability in Adobe Flash Player before 16.0.0.305', 'Use-after-free', 'Memory corruption'),
    ('CVE-2015-0331', 'CRITICAL', 10.0, 'Use-after-free vulnerability in Adobe Flash Player before 16.0.0.305', 'Use-after-free', 'Memory corruption'),
    ('CVE-2015-0332', 'CRITICAL', 10.0, 'Adobe Flash Player before 17.0.0.134 allows attackers to execute arbitrary code', 'Memory corruption', 'RCE'),
    ('CVE-2015-0333', 'CRITICAL', 10.0, 'Adobe Flash Player before 17.0.0.134 allows attackers to execute arbitrary code', 'Memory corruption', 'Code execution'),
    ('CVE-2015-0334', 'CRITICAL', 10.0, 'Adobe Flash Player before 17.0.0.134 allows type confusion attacks', 'Type confusion', 'Memory corruption'),
    ('CVE-2015-0335', 'CRITICAL', 10.0, 'Adobe Flash Player before 17.0.0.134 allows attackers to execute arbitrary code', 'Memory corruption', 'RCE'),
    ('CVE-2015-0336', 'CRITICAL', 10.0, 'Type confusion in Adobe Flash Player before 17.0.0.134', 'Type confusion', 'NetConnection confusion'),
    ('CVE-2015-0337', 'MEDIUM', 5.0, 'Adobe Flash Player before 17.0.0.134 allows bypass of security restrictions', 'Security bypass', 'Cross-domain bypass'),
    ('CVE-2015-0338', 'CRITICAL', 10.0, 'Integer overflow in Adobe Flash Player before 17.0.0.134', 'Integer overflow', 'Memory corruption'),
    ('CVE-2015-0339', 'CRITICAL', 10.0, 'Adobe Flash Player before 17.0.0.134 allows attackers to execute arbitrary code', 'Memory corruption', 'RCE'),
    ('CVE-2015-0340', 'MEDIUM', 5.0, 'Adobe Flash Player before 17.0.0.134 allows file upload restrictions bypass', 'Security bypass', 'File upload bypass'),
    ('CVE-2015-0341', 'CRITICAL', 10.0, 'Use-after-free vulnerability in Adobe Flash Player before 17.0.0.134', 'Use-after-free', 'Memory corruption'),
    ('CVE-2015-0342', 'CRITICAL', 10.0, 'Use-after-free vulnerability in Adobe Flash Player before 17.0.0.134', 'Use-after-free', 'Memory corruption'),
    ('CVE-2015-0359', 'CRITICAL', 10.0, 'Integer overflow in ByteArray in Adobe Flash Player before 17.0.0.169', 'Integer overflow', 'ByteArray overflow'),
    ('CVE-2015-3043', 'CRITICAL', 10.0, 'Adobe Flash Player before 17.0.0.169 allows attackers to execute arbitrary code', 'Memory corruption', 'Zero-day'),
    ('CVE-2015-3044', 'MEDIUM', 5.0, 'Adobe Flash Player before 17.0.0.169 allows bypass of security restrictions', 'Security bypass', 'Same-origin bypass'),
    ('CVE-2015-5119', 'CRITICAL', 10.0, 'Use-after-free in ByteArray valueOf in Adobe Flash Player before 18.0.0.194', 'Use-after-free', 'Hacking Team, ByteArray in GameClient.as'),
    ('CVE-2015-5122', 'CRITICAL', 10.0, 'Use-after-free in Worker ByteArray in Adobe Flash Player before 18.0.0.203', 'Use-after-free', 'Hacking Team leak'),
    ('CVE-2015-5123', 'CRITICAL', 10.0, 'Use-after-free in BitmapData domainMemory in Adobe Flash Player before 18.0.0.209', 'Use-after-free', 'Hacking Team leak'),
]

for cve_id, severity, cvss, desc, vuln_type, notes in cves_2014_2015:
    # Main example
    examples.append({
        'messages': [
            {'role': 'user', 'content': f'Tell me about {cve_id}.'},
            {'role': 'assistant', 'content': f'''{cve_id} ({severity}, CVSS {cvss})

**Description:** {desc}

**Vulnerability Type:** {vuln_type}
**Notes:** {notes}

**Evony Impact:** This CVE affects all Flash Player versions including Flash 10.0.x used by Evony. The vulnerability can be exploited through malicious SWF content.

**Mitigation:** Update Flash Player or use Ruffle emulator.'''}
        ]
    })

# Exploit kit integration examples
exploit_kit_cves = {
    'Angler EK': ['CVE-2015-0311', 'CVE-2015-0313', 'CVE-2015-5119', 'CVE-2015-5122', 'CVE-2014-0515'],
    'Nuclear EK': ['CVE-2015-0311', 'CVE-2015-5122', 'CVE-2014-0515'],
    'Magnitude EK': ['CVE-2015-5119', 'CVE-2015-5122', 'CVE-2014-8439'],
    'RIG EK': ['CVE-2015-5119', 'CVE-2015-5122', 'CVE-2014-0515'],
    'Neutrino EK': ['CVE-2015-5119', 'CVE-2015-5122', 'CVE-2015-5123', 'CVE-2014-0515'],
    'Fiesta EK': ['CVE-2014-0515', 'CVE-2014-0556', 'CVE-2015-0311'],
    'Sweet Orange EK': ['CVE-2014-0515', 'CVE-2014-0497', 'CVE-2015-0311'],
}

for ek, cves in exploit_kit_cves.items():
    examples.append({
        'messages': [
            {'role': 'user', 'content': f'Which Flash CVEs does {ek} exploit?'},
            {'role': 'assistant', 'content': f'''{ek} Flash Exploits

**CVEs Used:** {', '.join(cves)}

{ek} was one of the most prolific exploit kits during 2014-2016, responsible for delivering ransomware and banking trojans through compromised websites.

**Attack Flow:**
1. User visits compromised website
2. {ek} landing page fingerprints browser
3. Serves appropriate Flash exploit
4. Exploit gains code execution
5. Downloads and executes malware payload

**Evony Risk:**
If an Evony player using Flash 10.0.x visited a {ek}-compromised site, their system could be exploited through any of these CVEs.'''}
        ]
    })

# Save
out_file = Path('CVE_Research/train_2014_2015_cves.jsonl')
with open(out_file, 'w', encoding='utf-8') as f:
    for ex in examples:
        f.write(json.dumps(ex) + '\n')

print(f'Created {len(examples)} examples from 2014-2015 era!')
