#!/usr/bin/env python3
"""
Balanced Dataset Sampler
Based on ChatGPT's critical feedback for Phase 3

Purpose: Enforce sampling ratios to prevent CVE domination
- 55-65% Core Evony (source/protocol/enums)
- 20-30% CVE/Security (defensive framing only)
- 10-15% Multi-turn/Cross-domain/Error recovery
"""

import json
import random
from pathlib import Path
from typing import Dict, List, Tuple
from collections import defaultdict

# ============================================================
# SAMPLING CONFIGURATION (ChatGPT Recommended)
# ============================================================

SAMPLING_RATIOS = {
    'core_evony': 0.60,      # source/protocol/enums/constants
    'application': 0.15,     # GUI/scripting/effects/sounds/logs
    'security': 0.15,        # CVE (defensive only, capped)
    'meta': 0.10,            # multi-turn/cross-domain/grounding/error-recovery
}

# Category mappings for file classification
FILE_CATEGORIES = {
    'core_evony': [
        'train_combined_all.jsonl',
        'train_enums.jsonl',
        'train_enum_exact.jsonl',
        'train_protocol.jsonl',
        'train_constants.jsonl',
    ],
    'application': [
        'train_gui.jsonl',
        'train_scripting.jsonl',
        'train_effects.jsonl',
        'train_sounds.jsonl',
        'train_logs.jsonl',
        'train_loading.jsonl',
    ],
    'security': [
        'train_cve_all.jsonl',
        'train_cve_defensive.jsonl',
        'train_security.jsonl',
    ],
    'meta': [
        'train_multiturn.jsonl',
        'train_crossdomain.jsonl',
        'train_grounding.jsonl',
        'train_error_recovery.jsonl',
        'train_refusal.jsonl',
    ],
}

def load_jsonl(filepath: Path) -> List[Dict]:
    """Load JSONL file"""
    examples = []
    if not filepath.exists():
        return examples
    with open(filepath, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if line:
                try:
                    examples.append(json.loads(line))
                except json.JSONDecodeError:
                    continue
    return examples

def save_jsonl(examples: List[Dict], filepath: Path):
    """Save examples to JSONL file"""
    with open(filepath, 'w', encoding='utf-8') as f:
        for ex in examples:
            f.write(json.dumps(ex, ensure_ascii=False) + '\n')

def classify_examples(training_dir: Path) -> Dict[str, List[Dict]]:
    """Load and classify all examples by category"""
    categorized = defaultdict(list)
    
    for category, files in FILE_CATEGORIES.items():
        for filename in files:
            filepath = training_dir / filename
            if filepath.exists():
                examples = load_jsonl(filepath)
                categorized[category].extend(examples)
                print(f"  {category}: +{len(examples)} from {filename}")
    
    return dict(categorized)

def create_balanced_dataset(categorized: Dict[str, List[Dict]], 
                            target_size: int = 20000) -> List[Dict]:
    """
    Create a balanced dataset according to sampling ratios
    
    Args:
        categorized: Dict mapping category to list of examples
        target_size: Target total number of examples
        
    Returns:
        Balanced list of examples
    """
    balanced = []
    
    print(f"\nTarget size: {target_size}")
    print("Sampling ratios:")
    
    for category, ratio in SAMPLING_RATIOS.items():
        target_count = int(target_size * ratio)
        available = categorized.get(category, [])
        
        if len(available) == 0:
            # Skip empty categories
            print(f"  {category}: {ratio*100:.0f}% = 0/0 (EMPTY - skipped)")
            continue
        elif len(available) >= target_count:
            # Sample without replacement
            sampled = random.sample(available, target_count)
        else:
            # Use all available (may need to oversample)
            sampled = available.copy()
            if len(sampled) < target_count and len(available) > 0:
                # Oversample with replacement
                additional = random.choices(available, k=target_count - len(sampled))
                sampled.extend(additional)
        
        balanced.extend(sampled)
        print(f"  {category}: {ratio*100:.0f}% = {len(sampled)}/{target_count} (available: {len(available)})")
    
    # Shuffle the final dataset
    random.shuffle(balanced)
    
    return balanced

def create_epoch_batches(balanced: List[Dict], 
                         batch_size: int = 4,
                         num_epochs: int = 4) -> List[List[Dict]]:
    """
    Create epoch batches ensuring category distribution within each epoch
    """
    batches = []
    examples_per_epoch = len(balanced)
    
    for epoch in range(num_epochs):
        # Shuffle for each epoch
        epoch_data = balanced.copy()
        random.shuffle(epoch_data)
        
        # Create batches
        epoch_batches = []
        for i in range(0, len(epoch_data), batch_size):
            batch = epoch_data[i:i+batch_size]
            epoch_batches.append(batch)
        
        batches.extend(epoch_batches)
    
    return batches

def analyze_distribution(examples: List[Dict], 
                         categorized: Dict[str, List[Dict]]) -> Dict:
    """Analyze the distribution of a dataset"""
    # Create reverse lookup
    example_to_category = {}
    for category, cat_examples in categorized.items():
        for ex in cat_examples:
            key = (ex.get('instruction', ''), ex.get('output', ''))
            example_to_category[key] = category
    
    # Count categories in final dataset
    category_counts = defaultdict(int)
    for ex in examples:
        key = (ex.get('instruction', ''), ex.get('output', ''))
        category = example_to_category.get(key, 'unknown')
        category_counts[category] += 1
    
    total = len(examples)
    distribution = {}
    for category, count in category_counts.items():
        distribution[category] = {
            'count': count,
            'percentage': count / total * 100 if total > 0 else 0
        }
    
    return distribution

def main():
    """Main balanced sampling pipeline"""
    training_dir = Path(__file__).parent
    
    print("=" * 60)
    print("BALANCED DATASET SAMPLER")
    print("Based on ChatGPT Critical Feedback")
    print("=" * 60)
    print("\nTarget Ratios:")
    for cat, ratio in SAMPLING_RATIOS.items():
        print(f"  {cat}: {ratio*100:.0f}%")
    
    # Load and classify examples
    print("\n[Step 1] Loading and classifying examples...")
    categorized = classify_examples(training_dir)
    
    total_available = sum(len(v) for v in categorized.values())
    print(f"\nTotal available examples: {total_available}")
    
    if total_available == 0:
        print("No training data found! Create training files first.")
        return
    
    # Determine target size
    target_size = min(total_available, 20000)  # Cap at 20k or available
    
    # Create balanced dataset
    print("\n[Step 2] Creating balanced dataset...")
    balanced = create_balanced_dataset(categorized, target_size)
    print(f"\nFinal balanced dataset: {len(balanced)} examples")
    
    # Analyze distribution
    print("\n[Step 3] Analyzing distribution...")
    distribution = analyze_distribution(balanced, categorized)
    
    print("\nFinal Distribution:")
    for category, stats in sorted(distribution.items()):
        target = SAMPLING_RATIOS.get(category, 0) * 100
        actual = stats['percentage']
        diff = actual - target
        status = "✓" if abs(diff) < 5 else "⚠"
        print(f"  {status} {category}: {stats['count']} ({actual:.1f}%, target: {target:.0f}%)")
    
    # Save balanced dataset
    output_path = training_dir / "train_balanced.jsonl"
    save_jsonl(balanced, output_path)
    print(f"\n[Output] Saved balanced dataset to {output_path}")
    
    # Create config file
    config = {
        'total_examples': len(balanced),
        'target_ratios': SAMPLING_RATIOS,
        'actual_distribution': distribution,
        'source_files': {cat: len(exs) for cat, exs in categorized.items()},
    }
    
    config_path = training_dir / "balanced_config.json"
    with open(config_path, 'w') as f:
        json.dump(config, f, indent=2)
    print(f"Saved config to {config_path}")
    
    print("\n" + "=" * 60)
    print("SAMPLING COMPLETE")
    print("=" * 60)
    print(f"""
Key Points (from ChatGPT):
- Core Evony (enums/protocol) at 60% prevents CVE domination
- Security capped at 15% with defensive framing only
- Meta (grounding/error-recovery) at 10% reduces hallucination
- Shuffle per epoch maintains distribution

Next: Use train_balanced.jsonl for training
""")

if __name__ == "__main__":
    main()
