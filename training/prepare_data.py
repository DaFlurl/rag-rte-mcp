#!/usr/bin/env python3
"""
Prepare training data in Qwen2.5-VL format
Converts Alpaca format to Qwen chat format
"""

import json
from pathlib import Path
from datetime import datetime

TRAINING_DIR = Path(__file__).parent.parent / "Evony_Training_Data"
OUTPUT_DIR = Path(__file__).parent / "data"

def convert_to_qwen_format(examples):
    """Convert Alpaca format to Qwen chat format"""
    qwen_data = []
    
    for ex in examples:
        instruction = ex.get("instruction", "")
        input_text = ex.get("input", "")
        output = ex.get("output", "")
        
        # Build user message
        if input_text:
            user_content = f"{instruction}\n\nInput: {input_text}"
        else:
            user_content = instruction
        
        # Qwen format
        qwen_example = {
            "messages": [
                {
                    "role": "system",
                    "content": "You are an expert on the Evony game, specializing in protocol commands, data structures, game mechanics, scripting, and security. Provide accurate, detailed technical responses."
                },
                {
                    "role": "user", 
                    "content": user_content
                },
                {
                    "role": "assistant",
                    "content": output
                }
            ]
        }
        qwen_data.append(qwen_example)
    
    return qwen_data


def convert_to_chatml_format(examples):
    """Convert to ChatML format (alternative)"""
    chatml_data = []
    
    system_prompt = "You are an expert on the Evony game, specializing in protocol commands, data structures, game mechanics, scripting, and security."
    
    for ex in examples:
        instruction = ex.get("instruction", "")
        input_text = ex.get("input", "")
        output = ex.get("output", "")
        
        if input_text:
            user_msg = f"{instruction}\n\nInput: {input_text}"
        else:
            user_msg = instruction
        
        # ChatML format
        text = f"""<|im_start|>system
{system_prompt}<|im_end|>
<|im_start|>user
{user_msg}<|im_end|>
<|im_start|>assistant
{output}<|im_end|>"""
        
        chatml_data.append({"text": text})
    
    return chatml_data


def main():
    print("="*60)
    print("PREPARING TRAINING DATA FOR QWEN2.5-VL")
    print(f"Started: {datetime.now()}")
    print("="*60)
    
    OUTPUT_DIR.mkdir(exist_ok=True)
    
    # Find best dataset
    datasets = [
        "evony_filtered_quality.json",
        "evony_augmented_10k.json",
        "evony_final_5k.json",
    ]
    
    data = None
    for ds in datasets:
        path = TRAINING_DIR / ds
        if path.exists():
            print(f"\nLoading: {ds}")
            with open(path) as f:
                data = json.load(f)
            print(f"Loaded {len(data)} examples")
            break
    
    if not data:
        print("ERROR: No training data found!")
        return
    
    # Split train/val
    split_idx = int(len(data) * 0.9)
    train_data = data[:split_idx]
    val_data = data[split_idx:]
    
    print(f"\nTrain: {len(train_data)} examples")
    print(f"Val: {len(val_data)} examples")
    
    # Convert to Qwen format
    print("\nConverting to Qwen format...")
    train_qwen = convert_to_qwen_format(train_data)
    val_qwen = convert_to_qwen_format(val_data)
    
    # Save Qwen format
    with open(OUTPUT_DIR / "train_qwen.json", "w") as f:
        json.dump(train_qwen, f, indent=2)
    
    with open(OUTPUT_DIR / "val_qwen.json", "w") as f:
        json.dump(val_qwen, f, indent=2)
    
    # Save as JSONL
    with open(OUTPUT_DIR / "train_qwen.jsonl", "w") as f:
        for ex in train_qwen:
            f.write(json.dumps(ex) + "\n")
    
    with open(OUTPUT_DIR / "val_qwen.jsonl", "w") as f:
        for ex in val_qwen:
            f.write(json.dumps(ex) + "\n")
    
    # Convert to ChatML format
    print("Converting to ChatML format...")
    train_chatml = convert_to_chatml_format(train_data)
    val_chatml = convert_to_chatml_format(val_data)
    
    with open(OUTPUT_DIR / "train_chatml.jsonl", "w") as f:
        for ex in train_chatml:
            f.write(json.dumps(ex) + "\n")
    
    with open(OUTPUT_DIR / "val_chatml.jsonl", "w") as f:
        for ex in val_chatml:
            f.write(json.dumps(ex) + "\n")
    
    print(f"\n✅ DATA PREPARATION COMPLETE")
    print(f"Output directory: {OUTPUT_DIR}")
    print(f"Files created:")
    print(f"  - train_qwen.json ({len(train_qwen)} examples)")
    print(f"  - val_qwen.json ({len(val_qwen)} examples)")
    print(f"  - train_qwen.jsonl")
    print(f"  - val_qwen.jsonl")
    print(f"  - train_chatml.jsonl")
    print(f"  - val_chatml.jsonl")


if __name__ == "__main__":
    main()
