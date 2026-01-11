#!/usr/bin/env python3
"""Combine all training data into train_combined_all.jsonl"""

import json
from pathlib import Path

def load_jsonl(filepath: Path):
    examples = []
    if not filepath.exists():
        return examples
    with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
        for line in f:
            line = line.strip()
            if line:
                try:
                    examples.append(json.loads(line))
                except:
                    pass
    return examples

def main():
    training_dir = Path(__file__).parent
    data_dir = training_dir / "data"
    
    all_examples = []
    
    # Base training data from data/ folder
    base_files = [
        "train_qwen.jsonl",
        "train_multitask.jsonl",
    ]
    
    for filename in base_files:
        filepath = data_dir / filename
        examples = load_jsonl(filepath)
        print(f"Loaded {len(examples)} from data/{filename}")
        all_examples.extend(examples)
    
    # Phase 3 additions
    phase3_files = [
        "train_cve_all.jsonl",
        "train_enums.jsonl", 
        "train_protocol.jsonl",
        "train_claude_phase3.jsonl",
    ]
    
    for filename in phase3_files:
        filepath = training_dir / filename
        examples = load_jsonl(filepath)
        print(f"Loaded {len(examples)} from {filename}")
        all_examples.extend(examples)
    
    # Save combined
    output_path = training_dir / "train_combined_all.jsonl"
    with open(output_path, 'w', encoding='utf-8') as f:
        for ex in all_examples:
            f.write(json.dumps(ex, ensure_ascii=False) + '\n')
    
    print(f"\nTotal: {len(all_examples)} examples saved to train_combined_all.jsonl")

if __name__ == "__main__":
    main()
