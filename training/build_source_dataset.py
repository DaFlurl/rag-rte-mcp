#!/usr/bin/env python3
"""
Build training dataset with FULL 1:1 source code inclusion
Includes ALL AS3 files from both EvonyClient and AutoEvony
"""

import json
from pathlib import Path
from datetime import datetime

PROJECT_ROOT = Path(__file__).parent.parent
OUTPUT_DIR = PROJECT_ROOT / "training" / "data"

# Source directories
SOURCES = {
    "evony_client": PROJECT_ROOT / "AS3_Scripts_(EvonyClient1921.swf)",
    "autoevony": PROJECT_ROOT / "AS3_Scripts_(AutoEvony2_NEW.swf)",
}

SYSTEM_PROMPT = """You are an expert in Evony game internals, ActionScript 3 programming, and the AutoEvony bot framework. You have complete knowledge of:
- The decompiled Evony client source code (AS3)
- The AutoEvony bot source code and scripting system
- Game protocol, encryption, and network communication
- Exploits including integer overflows, race conditions, and packet manipulation
- All 301+ protocol commands and their parameters

Provide accurate, technical responses. When showing code, use the exact source from your training."""

def get_class_info(filepath: Path, content: str) -> dict:
    """Extract class/package info from AS3 file"""
    info = {"package": "", "class_name": "", "type": "unknown"}
    
    for line in content.split('\n')[:50]:  # Check first 50 lines
        line = line.strip()
        if line.startswith('package '):
            info["package"] = line.replace('package ', '').replace('{', '').strip()
        elif 'class ' in line and not line.startswith('//'):
            parts = line.split('class ')
            if len(parts) > 1:
                class_part = parts[1].split()[0].strip()
                info["class_name"] = class_part.split('extends')[0].split('implements')[0].strip()
                info["type"] = "class"
        elif 'interface ' in line and not line.startswith('//'):
            parts = line.split('interface ')
            if len(parts) > 1:
                info["class_name"] = parts[1].split()[0].strip()
                info["type"] = "interface"
    
    return info


def create_source_example(filepath: Path, content: str, source_name: str) -> dict:
    """Create a training example from source file - FULL 1:1 inclusion"""
    
    info = get_class_info(filepath, content)
    relative_path = filepath.name
    
    # Determine the best question based on content
    if info["class_name"]:
        if source_name == "autoevony":
            question = f"Show me the AutoEvony source code for the {info['class_name']} class."
        else:
            question = f"Show me the Evony client source code for the {info['class_name']} class."
    else:
        question = f"Show me the source code from {relative_path}"
    
    # Build full response with source
    if info["package"]:
        intro = f"Here is the complete source code for `{info['class_name']}` from package `{info['package']}`:"
    elif info["class_name"]:
        intro = f"Here is the complete source code for `{info['class_name']}`:"
    else:
        intro = f"Here is the source code from `{relative_path}`:"
    
    response = f"{intro}\n\n```actionscript\n{content}\n```"
    
    # Only return messages field for consistent schema
    return {
        "messages": [
            {"role": "system", "content": SYSTEM_PROMPT},
            {"role": "user", "content": question},
            {"role": "assistant", "content": response}
        ]
    }


def process_source_directory(source_dir: Path, source_name: str) -> list:
    """Process all AS3 files in a directory"""
    examples = []
    
    if not source_dir.exists():
        print(f"  ⚠️ Directory not found: {source_dir}")
        return examples
    
    as_files = list(source_dir.rglob("*.as"))
    print(f"  Found {len(as_files)} .as files")
    
    skipped = 0
    for filepath in as_files:
        try:
            content = filepath.read_text(encoding='utf-8', errors='ignore')
            
            # Skip very small files (< 50 chars) or empty
            if len(content.strip()) < 50:
                skipped += 1
                continue
            
            # Skip files that are too large (> 32KB) - split later if needed
            if len(content) > 32000:
                # Truncate with note
                content = content[:30000] + "\n\n// [TRUNCATED - file exceeds 32KB]"
            
            example = create_source_example(filepath, content, source_name)
            examples.append(example)
            
        except Exception as e:
            skipped += 1
            continue
    
    print(f"  ✅ Created {len(examples)} examples (skipped {skipped} tiny/broken files)")
    return examples


def load_existing_dataset() -> list:
    """Load existing multitask training data - normalize to messages only"""
    existing = []
    
    multitask_file = OUTPUT_DIR / "train_multitask.jsonl"
    if multitask_file.exists():
        print(f"\n📂 Loading existing dataset: {multitask_file.name}")
        with open(multitask_file, 'r', encoding='utf-8') as f:
            for line in f:
                try:
                    data = json.loads(line)
                    # Only keep messages field for consistency
                    if "messages" in data:
                        existing.append({"messages": data["messages"]})
                except:
                    continue
        print(f"  ✅ Loaded {len(existing)} existing examples")
    
    return existing


def load_cve_security_data() -> list:
    """Load CVE security training data"""
    cve_examples = []
    
    cve_file = PROJECT_ROOT / "training" / "train_cve_all.jsonl"
    if cve_file.exists():
        print(f"\n🔒 Loading CVE security dataset: {cve_file.name}")
        with open(cve_file, 'r', encoding='utf-8') as f:
            for line in f:
                try:
                    data = json.loads(line)
                    if "messages" in data:
                        cve_examples.append({"messages": data["messages"]})
                except:
                    continue
        print(f"  ✅ Loaded {len(cve_examples)} CVE security examples")
    
    return cve_examples


def build_combined_dataset():
    """Build the complete training dataset"""
    print("=" * 60)
    print("BUILDING COMPLETE SOURCE DATASET")
    print(f"Started: {datetime.now()}")
    print("=" * 60)
    
    all_examples = []
    
    # Process each source directory
    for source_name, source_dir in SOURCES.items():
        print(f"\n📂 Processing {source_name}: {source_dir.name}")
        examples = process_source_directory(source_dir, source_name)
        all_examples.extend(examples)
    
    # Load and include existing multitask data
    existing = load_existing_dataset()
    all_examples.extend(existing)
    
    # Load CVE security training data
    cve_data = load_cve_security_data()
    all_examples.extend(cve_data)
    
    # Save combined dataset
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    output_file = OUTPUT_DIR / "train_complete_source.jsonl"
    
    print(f"\n💾 Saving to {output_file.name}...")
    with open(output_file, 'w', encoding='utf-8') as f:
        for ex in all_examples:
            f.write(json.dumps(ex, ensure_ascii=False) + '\n')
    
    # Stats
    print("\n" + "=" * 60)
    print("DATASET COMPLETE")
    print("=" * 60)
    print(f"  📁 Source Code:        {len(all_examples) - len(existing) - len(cve_data):,} examples")
    print(f"  📁 Existing Multitask: {len(existing):,} examples")
    print(f"  � CVE Security:       {len(cve_data):,} examples")
    print(f"  ━━━━━━━━━━━━━━━━━━━━━━")
    print(f"  📊 TOTAL:              {len(all_examples):,} examples")
    print(f"\n  Output: {output_file}")
    
    return len(all_examples)


if __name__ == "__main__":
    build_combined_dataset()
