#!/usr/bin/env python3
"""
AutoIt EA06 Decompiler for ETK.exe
Extracts and decodes AutoIt3 compiled scripts
"""
import struct
import zlib
import os
from pathlib import Path

# AutoIt EA06 constants
EA06_MAGIC = b'AU3!EA06'
SCRIPT_MARKER = b'>>>AUTOIT SCRIPT<<<'

def decode_au3_string(data: bytes, key: int = 0) -> str:
    """Decode XOR-encrypted AutoIt string"""
    result = []
    for i, b in enumerate(data):
        decoded = b ^ ((key + i) & 0xFF)
        if decoded == 0:
            break
        result.append(chr(decoded))
    return ''.join(result)

def decompress_lzss(data: bytes, decompressed_size: int) -> bytes:
    """LZSS decompression used by AutoIt"""
    result = bytearray()
    src_pos = 0
    
    while len(result) < decompressed_size and src_pos < len(data):
        flags = data[src_pos]
        src_pos += 1
        
        for bit in range(8):
            if len(result) >= decompressed_size:
                break
            
            if flags & (1 << bit):
                # Literal byte
                if src_pos < len(data):
                    result.append(data[src_pos])
                    src_pos += 1
            else:
                # Back reference
                if src_pos + 1 < len(data):
                    ref = struct.unpack('<H', data[src_pos:src_pos+2])[0]
                    src_pos += 2
                    
                    offset = (ref >> 4) + 1
                    length = (ref & 0x0F) + 3
                    
                    for _ in range(length):
                        if len(result) >= decompressed_size:
                            break
                        if offset <= len(result):
                            result.append(result[-offset])
                        else:
                            result.append(0)
    
    return bytes(result)

def extract_au3_script(exe_path: str, output_dir: str) -> dict:
    """Extract AutoIt script from compiled executable"""
    result = {
        'success': False,
        'script': '',
        'resources': [],
        'errors': []
    }
    
    os.makedirs(output_dir, exist_ok=True)
    
    with open(exe_path, 'rb') as f:
        data = f.read()
    
    # Find EA06 signature
    ea06_pos = data.find(EA06_MAGIC)
    if ea06_pos == -1:
        # Try EA05
        ea05_pos = data.find(b'AU3!EA05')
        if ea05_pos != -1:
            result['errors'].append(f'Found EA05 format at {ea05_pos} - older format')
            ea06_pos = ea05_pos
        else:
            result['errors'].append('No AutoIt signature found')
            return result
    
    print(f"[+] Found AutoIt signature at offset: {ea06_pos}")
    
    # Parse header after EA06
    header_start = ea06_pos + 8
    
    # AutoIt EA06 structure:
    # - 8 bytes: "AU3!EA06"
    # - 4 bytes: Script size (compressed)
    # - 4 bytes: Script size (decompressed)  
    # - Compressed script data
    # - Resources/includes
    
    # Try to find script boundaries
    script_sections = []
    
    # Method 1: Look for common AutoIt patterns in the data
    patterns = [
        b'#include',
        b'#AutoIt3Wrapper',
        b'Func ',
        b'EndFunc',
        b'$',  # Variable prefix
        b'Global ',
        b'Local ',
        b'Dim ',
        b'If ',
        b'Then',
        b'EndIf',
        b'While',
        b'WEnd',
        b'For ',
        b'Next',
        b'GUICreate',
        b'Run(',
        b'ProcessExists',
        b'FileExists',
        b'ShellExecute',
        b'IniRead',
        b'IniWrite',
    ]
    
    # Extract all readable strings that look like AutoIt code
    import re
    
    # Find potential script content
    script_content = []
    
    # Look for string table
    pos = ea06_pos
    while pos < len(data) - 100:
        # Look for patterns
        for pattern in patterns:
            idx = data.find(pattern, pos, pos + 10000)
            if idx != -1:
                # Extract surrounding context
                start = max(0, idx - 50)
                end = min(len(data), idx + 200)
                context = data[start:end]
                
                # Try to decode as ASCII
                try:
                    text = context.decode('ascii', errors='ignore')
                    # Clean up
                    text = ''.join(c for c in text if c.isprintable() or c in '\n\r\t')
                    if len(text) > 10:
                        script_content.append((idx, text))
                except:
                    pass
        pos += 5000
    
    # Alternative: Try to decompress sections
    print("[*] Attempting to decompress script sections...")
    
    compressed_sections = []
    search_pos = ea06_pos
    
    while search_pos < len(data) - 8:
        # Look for zlib headers (78 9C, 78 DA, 78 01)
        for zlib_header in [b'\x78\x9C', b'\x78\xDA', b'\x78\x01']:
            idx = data.find(zlib_header, search_pos, search_pos + 50000)
            if idx != -1:
                # Try to decompress
                for end_offset in [1000, 5000, 10000, 50000, 100000]:
                    try:
                        decompressed = zlib.decompress(data[idx:idx+end_offset])
                        if len(decompressed) > 100:
                            compressed_sections.append({
                                'offset': idx,
                                'compressed_size': end_offset,
                                'decompressed_size': len(decompressed),
                                'data': decompressed
                            })
                            
                            # Save decompressed section
                            section_file = os.path.join(output_dir, f'section_{idx}.bin')
                            with open(section_file, 'wb') as f:
                                f.write(decompressed)
                            
                            # Try to decode as text
                            try:
                                text = decompressed.decode('utf-8', errors='ignore')
                                if 'Func' in text or '$' in text:
                                    script_file = os.path.join(output_dir, f'script_{idx}.au3')
                                    with open(script_file, 'w', encoding='utf-8') as f:
                                        f.write(text)
                                    print(f"[+] Found script section at {idx}, saved to {script_file}")
                            except:
                                pass
                            break
                    except:
                        pass
        search_pos += 10000
    
    # Extract all printable strings
    print("[*] Extracting all strings...")
    strings = []
    current = b''
    
    for i, byte in enumerate(data[ea06_pos:]):
        if 32 <= byte <= 126:
            current += bytes([byte])
        else:
            if len(current) >= 8:
                try:
                    s = current.decode('ascii')
                    # Filter for likely AutoIt content
                    if any(kw in s for kw in ['Func', 'End', 'If', 'Then', 'While', 'For', '$', 'Gui', 'Run', 'File', 'Ini', 'tor', 'Tor', 'proxy', 'Proxy', 'node', 'Node', 'bot', 'Bot']):
                        strings.append((ea06_pos + i - len(current), s))
                except:
                    pass
            current = b''
    
    # Save strings
    strings_file = os.path.join(output_dir, 'extracted_strings.txt')
    with open(strings_file, 'w', encoding='utf-8') as f:
        f.write(f"# Extracted strings from {exe_path}\n")
        f.write(f"# EA06 offset: {ea06_pos}\n\n")
        for offset, s in sorted(set(strings)):
            f.write(f"{offset:08X}: {s}\n")
    
    print(f"[+] Extracted {len(strings)} relevant strings to {strings_file}")
    
    # Look for specific ETK-related strings
    etk_strings = [s for _, s in strings if any(kw in s.lower() for kw in ['tor', 'proxy', 'node', 'bot', 'evony', 'account'])]
    
    etk_file = os.path.join(output_dir, 'etk_related_strings.txt')
    with open(etk_file, 'w', encoding='utf-8') as f:
        f.write("# ETK-related strings\n\n")
        for s in sorted(set(etk_strings)):
            f.write(f"{s}\n")
    
    print(f"[+] Found {len(etk_strings)} ETK-related strings")
    
    result['success'] = True
    result['script'] = '\n'.join(s for _, s in strings[:100])
    
    return result


def main():
    print("=" * 60)
    print("  AutoIt EA06 Decompiler")
    print("  ETK.exe Script Extractor")
    print("=" * 60)
    print()
    
    exe_path = r"D:\EvonyToolKit\ETK.exe"
    output_dir = r"D:\EvonyToolKit\tools\decompiled"
    
    result = extract_au3_script(exe_path, output_dir)
    
    if result['success']:
        print(f"\n[+] Decompilation complete!")
        print(f"[+] Output directory: {output_dir}")
    else:
        print(f"\n[-] Errors: {result['errors']}")
    
    print("\n[!] For complete decompilation, use Exe2Aut GUI:")
    print("    Download from: https://github.com/Wikipedia2008/Exe2Aut/releases")
    print("    Or myAutToExe: https://github.com/wiki2008/myAutToExe")


if __name__ == "__main__":
    main()
