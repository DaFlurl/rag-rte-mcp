#!/usr/bin/env python3
"""Debug PyAMF decoding"""
import struct

# Sample hex from server.ResourceUpdate
hex_samples = [
    "0a230107636d640964617461062b7365727665722e5265736f757263655570646174650a430111636173746c654964056f6b137061636b6167654964117265736f7572636504d1be59",
]

for hex_str in hex_samples:
    print(f"=== Testing hex ({len(hex_str)//2} bytes) ===")
    data = bytes.fromhex(hex_str)
    print(f"Raw: {data[:50]}...")
    
    # Try PyAMF
    try:
        import pyamf
        from pyamf import amf3
        from io import BytesIO
        
        buf = BytesIO(data)
        decoder = amf3.Decoder(buf)
        result = decoder.readElement()
        print(f"PyAMF type: {type(result)}")
        print(f"PyAMF result: {result}")
        
        if hasattr(result, 'keys'):
            print(f"Keys: {list(result.keys())}")
            for k in result.keys():
                print(f"  {k}: {result[k]} (type: {type(result[k])})")
    except Exception as e:
        print(f"PyAMF error: {e}")
        import traceback
        traceback.print_exc()
    
    # Manual decode
    print("\n--- Manual AMF3 decode ---")
    pos = 0
    marker = data[0]
    print(f"Type marker: 0x{marker:02x}")
    
    if marker == 0x0a:  # Object
        traits = data[1]
        print(f"Traits: 0x{traits:02x}")
        
    print()
