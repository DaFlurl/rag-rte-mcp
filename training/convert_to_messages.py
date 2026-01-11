#!/usr/bin/env python3
"""Convert instruction/output format to messages format for training"""

import json
from pathlib import Path

INPUT_FILE = Path(__file__).parent / "data_perfect" / "train_perfect.jsonl"
OUTPUT_FILE = Path(__file__).parent / "data" / "train_perfect_messages.jsonl"

SYSTEM_PROMPT = """You are Evony AI, an expert assistant specialized in Evony game mechanics, ActionScript code analysis, protocol reverse engineering, and exploit development. You have deep knowledge of:
- Evony client source code (ActionScript 3)
- Game protocol commands and encryption
- Integer overflow exploits and race conditions
- AutoEvony scripting
- Resource management and optimization

Provide accurate, technical responses with code examples when relevant."""

def convert():
    print(f"Converting {INPUT_FILE} to messages format...")
    
    converted = []
    with open(INPUT_FILE, 'r', encoding='utf-8') as f:
        for line in f:
            ex = json.loads(line)
            
            # Build messages format
            messages = [
                {"role": "system", "content": SYSTEM_PROMPT},
                {"role": "user", "content": ex["instruction"]},
                {"role": "assistant", "content": ex["output"]}
            ]
            
            converted.append({"messages": messages})
    
    # Ensure output dir exists
    OUTPUT_FILE.parent.mkdir(parents=True, exist_ok=True)
    
    with open(OUTPUT_FILE, 'w', encoding='utf-8') as f:
        for ex in converted:
            f.write(json.dumps(ex, ensure_ascii=False) + '\n')
    
    print(f"✅ Converted {len(converted)} examples to {OUTPUT_FILE}")
    return len(converted)

if __name__ == "__main__":
    convert()
