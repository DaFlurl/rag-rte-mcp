#!/usr/bin/env python3
"""
AutoIt Decompiler for ETK.exe
Extracts the AutoIt script from compiled .exe
"""
import struct
import zlib
import os

def find_au3_script(data):
    """Find and extract AU3 script from compiled AutoIt executable"""
    # Look for AU3! signature
    au3_sig = b'AU3!'
    pos = data.find(au3_sig)
    if pos == -1:
        return None, "AU3! signature not found"
    
    print(f"[+] Found AU3! signature at offset: {pos}")
    
    # AutoIt compiled script structure varies by version
    # Try to find script content after signature
    script_data = data[pos:]
    
    # Save raw AU3 data for analysis
    return script_data, None

def decompress_au3(data):
    """Try to decompress AutoIt script data"""
    results = []
    
    # Try different offsets and compression methods
    for offset in range(0, min(len(data), 1000), 4):
        try:
            # Try zlib decompression
            decompressed = zlib.decompress(data[offset:])
            if len(decompressed) > 100:
                results.append((offset, 'zlib', decompressed))
        except:
            pass
        
        try:
            # Try raw deflate
            decompressed = zlib.decompress(data[offset:], -zlib.MAX_WBITS)
            if len(decompressed) > 100:
                results.append((offset, 'deflate', decompressed))
        except:
            pass
    
    return results

def extract_strings(data):
    """Extract readable strings from binary data"""
    strings = []
    current = b''
    
    for byte in data:
        if 32 <= byte <= 126:  # Printable ASCII
            current += bytes([byte])
        else:
            if len(current) >= 6:  # Minimum string length
                try:
                    s = current.decode('ascii')
                    # Filter for interesting strings
                    if any(kw in s.lower() for kw in ['func', 'tor', 'proxy', 'run', 'exec', 'path', 'file', 'node', 'socks']):
                        strings.append(s)
                except:
                    pass
            current = b''
    
    return strings

def main():
    etk_path = r"D:\EvonyToolKit\ETK.exe"
    output_dir = r"D:\EvonyToolKit\tools\decompiled"
    
    os.makedirs(output_dir, exist_ok=True)
    
    print("=" * 50)
    print("  AutoIt Decompiler for ETK.exe")
    print("=" * 50)
    
    with open(etk_path, 'rb') as f:
        data = f.read()
    
    print(f"[+] File size: {len(data)} bytes")
    
    # Extract AU3 section
    au3_data, error = find_au3_script(data)
    if error:
        print(f"[-] Error: {error}")
        return
    
    # Save raw AU3 data
    au3_path = os.path.join(output_dir, "ETK_au3_section.bin")
    with open(au3_path, 'wb') as f:
        f.write(au3_data)
    print(f"[+] Saved AU3 section to: {au3_path}")
    
    # Try decompression
    print("[*] Attempting decompression...")
    results = decompress_au3(au3_data)
    for i, (offset, method, decompressed) in enumerate(results):
        out_path = os.path.join(output_dir, f"decompressed_{method}_{offset}.bin")
        with open(out_path, 'wb') as f:
            f.write(decompressed)
        print(f"[+] Saved decompressed data: {out_path} ({len(decompressed)} bytes)")
    
    # Extract interesting strings
    print("[*] Extracting strings...")
    strings = extract_strings(data)
    
    strings_path = os.path.join(output_dir, "interesting_strings.txt")
    with open(strings_path, 'w') as f:
        for s in sorted(set(strings)):
            f.write(s + '\n')
    print(f"[+] Found {len(strings)} interesting strings, saved to: {strings_path}")
    
    # Look for Tor-related strings specifically
    print("\n[*] Tor-related strings found:")
    tor_strings = [s for s in strings if 'tor' in s.lower()]
    for s in tor_strings[:20]:
        print(f"    {s}")
    
    print("\n[+] Done! Check the decompiled folder for extracted data.")
    print("[!] For full decompilation, use Exe2Aut GUI tool from:")
    print("    https://github.com/Wikipedia2008/Exe2Aut/releases")

if __name__ == "__main__":
    main()
