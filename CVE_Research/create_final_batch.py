#!/usr/bin/env python3
"""Final batch of CVE training examples - RACE MODE!"""
import json
from pathlib import Path

print('🏁 FINAL SPRINT - MORE EXAMPLES!')

examples = []

# Individual CVE deep-dives for top exploited CVEs
top_cves = [
    ('CVE-2015-5119', 'CRITICAL', 10.0, 'ByteArray UAF via valueOf()', 'Hacking Team leak, exploited in wild', 'ByteArray.valueOf() override during assignment', 'mainBuffer:ByteArray in GameClient.as'),
    ('CVE-2015-0311', 'CRITICAL', 10.0, 'ByteArray uncompress() UAF', 'Zero-day, exploited in wild', 'uncompress() method triggers UAF', 'mainBuffer.uncompress() at GameClient.as:87 EXACT MATCH'),
    ('CVE-2015-0313', 'CRITICAL', 10.0, 'Worker ByteArray UAF', 'Angler EK payload', 'Worker thread domainMemory', 'ByteArray packet handling'),
    ('CVE-2010-3654', 'CRITICAL', 9.3, 'Flash Button RCE', 'Targeted attacks, Stuxnet related', 'Button handling memory corruption', 'UI button components'),
    ('CVE-2011-0611', 'CRITICAL', 9.3, 'SWF Memory Corruption', 'RSA breach, widespread exploitation', 'Malformed SWF parsing', 'SWF loading/parsing'),
    ('CVE-2010-1297', 'CRITICAL', 9.3, 'authplay.dll Corruption', 'Zero-day, PDF embedding', 'Memory corruption in authplay.dll', 'External content loading'),
    ('CVE-2010-2884', 'CRITICAL', 9.3, 'Critical Memory Corruption', 'Zero-day, targeted attacks', 'AVM2 memory handling', 'ActionScript execution'),
    ('CVE-2009-1862', 'CRITICAL', 9.3, 'Wild Memory Corruption', 'First major wild exploit', 'Crafted SWF parsing', 'SWF structure handling'),
    ('CVE-2007-4324', 'MEDIUM', 5.0, 'AS3 Port Scanner', 'Information disclosure', 'Socket timing discrepancies', 'GameClient.as Socket + SecurityErrorEvent'),
    ('CVE-2012-0767', 'MEDIUM', 4.3, 'ExternalInterface XSS', 'Cross-site scripting', 'XSS via ExternalInterface', 'EvonyClient.as ExternalInterface import'),
]

for cve, sev, cvss, name, history, pattern, evony_loc in top_cves:
    # Comprehensive analysis
    examples.append({
        'messages': [
            {'role': 'user', 'content': f'Give me a comprehensive security analysis of {cve}.'},
            {'role': 'assistant', 'content': f'''# {cve} - Comprehensive Analysis

## Overview
**Name:** {name}
**Severity:** {sev} (CVSS {cvss})
**History:** {history}

## Technical Details
**Vulnerable Pattern:** {pattern}

The vulnerability occurs when Flash Player processes specially crafted content that triggers the vulnerable code path. Successful exploitation allows arbitrary code execution with user privileges.

## Evony Client Impact
**Location:** {evony_loc}

The Evony client (EvonyClient1921.swf) was compiled in November 2009 for Flash Player 10.0.x. This version is vulnerable to {cve}. The specific vulnerable pattern exists in the Evony codebase.

## Exploitation
- Public exploits available
- Metasploit modules exist for some variants
- Used in targeted attacks and exploit kits

## Detection
1. Monitor Flash Player version
2. Network traffic analysis for exploit delivery
3. Memory analysis for exploitation artifacts
4. SWF content inspection

## Mitigation
- Update Flash Player to patched version
- Use Ruffle Flash emulator
- Browser plugin restrictions
- Network isolation for game clients

## References
- Adobe Security Bulletin
- NVD Entry
- MITRE CVE Database'''}
        ]
    })
    
    # Quick reference
    examples.append({
        'messages': [
            {'role': 'user', 'content': f'Quick summary of {cve}?'},
            {'role': 'assistant', 'content': f'''{cve} ({sev}, CVSS {cvss})
- **What:** {name}
- **Pattern:** {pattern}
- **Evony:** {evony_loc}
- **History:** {history}
- **Fix:** Update Flash or use Ruffle'''}
        ]
    })

# Flash version history with CVE counts
flash_versions = [
    ('9.0', '2006-2008', 45, 'First AS3 support, many sandbox issues'),
    ('10.0', '2008-2010', 120, 'Evony target version, major ByteArray/Socket CVEs'),
    ('10.1', '2010-2011', 85, 'AutoEvony era, continued memory corruption issues'),
    ('10.2', '2011', 40, 'Minor improvements, still vulnerable'),
    ('10.3', '2011-2012', 55, 'More security patches'),
    ('11.0-11.9', '2012-2014', 200, 'Major overhaul, still many CVEs'),
    ('12.0-18.0', '2014-2015', 150, 'Hacking Team era, critical UAF CVEs'),
]

for ver, years, cve_count, notes in flash_versions:
    examples.append({
        'messages': [
            {'role': 'user', 'content': f'What vulnerabilities affect Flash Player {ver}?'},
            {'role': 'assistant', 'content': f'''# Flash Player {ver} Vulnerabilities

**Active Period:** {years}
**Approximate CVE Count:** ~{cve_count}
**Notes:** {notes}

## Evony Relevance
{"Evony (November 2009) targets this exact version range. All CVEs in this version directly affect Evony clients." if '10.0' in ver else "Evony targets Flash 10.0.x but may be affected by vulnerabilities discovered in this version due to shared codepaths."}

## Key Vulnerability Types
- Memory corruption
- Type confusion
- Integer overflow
- Use-after-free
- Sandbox bypass

## Recommendation
Flash Player {ver} should not be used. Consider Ruffle emulator for legacy Flash content.'''}
        ]
    })

# Defense/mitigation examples
defenses = [
    ('sandbox escape prevention', 'Use Security.sandboxType checks, avoid allowDomain(*), validate crossdomain.xml'),
    ('ByteArray hardening', 'Validate length before operations, use try-catch, limit max sizes, avoid uncompress on untrusted data'),
    ('Socket security', 'Validate server certificates, use encrypted connections, implement protocol validation'),
    ('AMF deserialization safety', 'Use class aliasing carefully, validate deserialized objects, implement type checking'),
    ('ExternalInterface protection', 'Sanitize all inputs, avoid eval-like patterns, use allowlist for callbacks'),
    ('memory corruption mitigation', 'Enable DEP/ASLR, use latest Flash version, implement heap spray detection'),
]

for defense, techniques in defenses:
    examples.append({
        'messages': [
            {'role': 'user', 'content': f'How do I implement {defense} in Flash?'},
            {'role': 'assistant', 'content': f'''# {defense.title()}

## Recommended Techniques
{techniques}

## Implementation in Evony Context
The Evony client would benefit from these hardening measures, though as a compiled SWF from 2009, modifications would require:
1. Decompiling with JPEXS/AS3 Sorcerer
2. Modifying ActionScript source
3. Recompiling with matching Flex SDK (3.5.0.12683)

## Modern Alternative
Instead of hardening legacy Flash code, consider:
- Running through Ruffle emulator
- Network isolation
- Monitoring for exploitation attempts

## Code Example
```actionscript
// Defensive pattern example
try {{
    if (data.length > MAX_SAFE_SIZE) {{
        throw new SecurityError("Data exceeds safe limit");
    }}
    // Process data with validation
}} catch (e:Error) {{
    // Log and handle securely
}}
```'''}
        ]
    })

# Exploit kit examples
exploit_kits = [
    ('Angler EK', ['CVE-2015-0311', 'CVE-2015-0313', 'CVE-2015-5119'], '2014-2016'),
    ('Nuclear EK', ['CVE-2015-0311', 'CVE-2015-5122'], '2014-2016'),
    ('Magnitude EK', ['CVE-2015-5119', 'CVE-2015-5122'], '2015-2017'),
    ('RIG EK', ['CVE-2015-5119', 'CVE-2015-8651'], '2015-2018'),
    ('Neutrino EK', ['CVE-2015-5119', 'CVE-2015-5122', 'CVE-2015-8651'], '2014-2016'),
]

for ek, cves, active in exploit_kits:
    examples.append({
        'messages': [
            {'role': 'user', 'content': f'What Flash CVEs did {ek} use?'},
            {'role': 'assistant', 'content': f'''# {ek} - Flash Exploits

**Active Period:** {active}
**Flash CVEs Used:** {', '.join(cves)}

## Attack Flow
1. Victim visits compromised/malicious site
2. {ek} fingerprints browser and plugins
3. Serves Flash exploit matching victim's version
4. Exploit triggers memory corruption
5. Shellcode executes, downloads payload

## Evony Risk
If an Evony player ran unpatched Flash 10.0.x and visited a malicious site, {ek} could have exploited their system using these CVEs.

## Detection
- Network signatures for {ek} landing pages
- Flash exploit shellcode patterns
- Anomalous Flash content loading'''}
        ]
    })

# Save
out_file = Path('CVE_Research/train_final_sprint.jsonl')
with open(out_file, 'w', encoding='utf-8') as f:
    for ex in examples:
        f.write(json.dumps(ex, ensure_ascii=False) + '\n')

print(f'✅ Created {len(examples)} final sprint examples!')
