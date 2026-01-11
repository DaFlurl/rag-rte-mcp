#!/usr/bin/env python3
"""Decode AMF3 hex to understand the structure"""

# Sample hex from server.ResourceUpdate
hex_str = "0a230107636d640964617461062b7365727665722e5265736f757263655570646174650a430111636173746c654964056f6b"

data = bytes.fromhex(hex_str)
print(f"Raw bytes ({len(data)} bytes):")
print(data)
print()

# Try PyAMF
try:
    import pyamf
    from pyamf import amf3
    from io import BytesIO
    
    buf = BytesIO(data)
    decoder = amf3.Decoder(buf)
    result = decoder.readElement()
    print("PyAMF decoded:")
    print(f"Type: {type(result)}")
    print(f"Value: {result}")
    
    # Try to convert to dict
    if hasattr(result, 'keys'):
        d = dict(result)
        print(f"As dict: {d}")
        if 'data' in d:
            print(f"data type: {type(d['data'])}")
            if hasattr(d['data'], 'keys'):
                print(f"data as dict: {dict(d['data'])}")
except Exception as e:
    print(f"PyAMF error: {e}")

print()

# Manual decode
print("Manual AMF3 decode:")
pos = 0

def read_u29(data, pos):
    """Read AMF3 variable-length integer"""
    result = 0
    for i in range(4):
        b = data[pos]
        pos += 1
        if i < 3:
            result = (result << 7) | (b & 0x7f)
            if not (b & 0x80):
                break
        else:
            result = (result << 8) | b
    return result, pos

def read_string(data, pos):
    """Read AMF3 string"""
    ref, pos = read_u29(data, pos)
    if ref & 1:  # inline string
        length = ref >> 1
        s = data[pos:pos+length].decode('utf-8')
        return s, pos + length
    return f"[ref:{ref>>1}]", pos

# Type marker
type_marker = data[0]
print(f"Type marker: 0x{type_marker:02x}")

if type_marker == 0x0a:  # Object
    pos = 1
    traits_ref, pos = read_u29(data, pos)
    print(f"Traits ref: 0x{traits_ref:02x}")
    
    if traits_ref & 1:  # inline traits
        is_dynamic = bool(traits_ref & 0x08)
        count = traits_ref >> 4
        print(f"Dynamic: {is_dynamic}, Static props: {count}")
        
        # Class name
        class_name, pos = read_string(data, pos)
        print(f"Class name: '{class_name}'")
        
        # Property names
        for i in range(count):
            prop_name, pos = read_string(data, pos)
            print(f"Property {i}: {prop_name}")
        
        # Try to read values
        print(f"\nRemaining bytes from pos {pos}:")
        remaining = data[pos:]
        print(f"Hex: {remaining.hex()}")
        print(f"Bytes: {list(remaining)}")
