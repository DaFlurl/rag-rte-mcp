#!/usr/bin/env python3
"""
Dataset Deduplication Script
Based on ChatGPT's critical feedback for Phase 3

Features:
1. Exact dedup via hash
2. Near-dup detection via n-gram similarity
3. Train/val isolation check
4. Creates seen/unseen CVE eval sets
"""

import json
import hashlib
import re
from pathlib import Path
from collections import defaultdict
from typing import List, Dict, Set, Tuple

def normalize_text(text: str) -> str:
    """Normalize text for comparison"""
    text = text.lower()
    text = re.sub(r'\s+', ' ', text)
    text = re.sub(r'[^\w\s]', '', text)
    return text.strip()

def get_hash(example: Dict) -> str:
    """Get hash of instruction + output"""
    content = example.get('instruction', '') + example.get('output', '')
    normalized = normalize_text(content)
    return hashlib.sha256(normalized.encode()).hexdigest()

def get_ngrams(text: str, n: int = 3) -> Set[str]:
    """Get character n-grams from text"""
    text = normalize_text(text)
    return set(text[i:i+n] for i in range(len(text) - n + 1))

def jaccard_similarity(set1: Set, set2: Set) -> float:
    """Calculate Jaccard similarity between two sets"""
    if not set1 or not set2:
        return 0.0
    intersection = len(set1 & set2)
    union = len(set1 | set2)
    return intersection / union if union > 0 else 0.0

def exact_dedup(examples: List[Dict]) -> Tuple[List[Dict], int]:
    """Remove exact duplicates based on hash"""
    seen_hashes = set()
    unique = []
    duplicates = 0
    
    for ex in examples:
        h = get_hash(ex)
        if h not in seen_hashes:
            seen_hashes.add(h)
            unique.append(ex)
        else:
            duplicates += 1
    
    return unique, duplicates

def near_dedup(examples: List[Dict], threshold: float = 0.85) -> Tuple[List[Dict], int]:
    """Remove near-duplicates using n-gram similarity"""
    unique = []
    removed = 0
    
    # Pre-compute n-grams for efficiency
    example_ngrams = []
    for ex in examples:
        content = ex.get('instruction', '') + ex.get('output', '')
        ngrams = get_ngrams(content)
        example_ngrams.append((ex, ngrams))
    
    for i, (ex, ngrams) in enumerate(example_ngrams):
        is_duplicate = False
        
        # Compare with already accepted examples
        for accepted_ex, accepted_ngrams in [(unique[j], example_ngrams[j][1]) 
                                              for j in range(len(unique))]:
            similarity = jaccard_similarity(ngrams, accepted_ngrams)
            if similarity >= threshold:
                is_duplicate = True
                removed += 1
                break
        
        if not is_duplicate:
            unique.append(ex)
    
    return unique, removed

def extract_cve_ids(text: str) -> Set[str]:
    """Extract CVE IDs from text"""
    pattern = r'CVE-\d{4}-\d{4,7}'
    return set(re.findall(pattern, text, re.IGNORECASE))

def check_train_val_isolation(train_examples: List[Dict], 
                               val_examples: List[Dict]) -> Dict:
    """Check for CVE ID leakage between train and val sets"""
    train_cves = set()
    val_cves = set()
    
    for ex in train_examples:
        content = ex.get('instruction', '') + ex.get('output', '')
        train_cves.update(extract_cve_ids(content))
    
    for ex in val_examples:
        content = ex.get('instruction', '') + ex.get('output', '')
        val_cves.update(extract_cve_ids(content))
    
    leaked = train_cves & val_cves
    
    return {
        'train_cves': len(train_cves),
        'val_cves': len(val_cves),
        'leaked_cves': len(leaked),
        'leaked_ids': sorted(leaked),
        'isolation_clean': len(leaked) == 0
    }

def create_eval_sets(examples: List[Dict], 
                     known_cves: Set[str]) -> Tuple[List[Dict], List[Dict]]:
    """
    Split examples into seen (memorization check) and unseen (generalization check)
    based on whether their CVE IDs appear in the training set
    """
    seen_set = []
    unseen_set = []
    
    for ex in examples:
        content = ex.get('instruction', '') + ex.get('output', '')
        example_cves = extract_cve_ids(content)
        
        if example_cves & known_cves:
            seen_set.append(ex)
        else:
            unseen_set.append(ex)
    
    return seen_set, unseen_set

def load_jsonl(filepath: Path) -> List[Dict]:
    """Load JSONL file"""
    examples = []
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

def main():
    """Main dedup pipeline"""
    training_dir = Path(__file__).parent
    
    print("=" * 60)
    print("DATASET DEDUPLICATION PIPELINE")
    print("Based on ChatGPT Critical Feedback")
    print("=" * 60)
    
    # Find all training JSONL files
    jsonl_files = list(training_dir.glob("train_*.jsonl"))
    
    if not jsonl_files:
        print("No training files found!")
        return
    
    print(f"\nFound {len(jsonl_files)} training files")
    
    all_examples = []
    file_stats = {}
    
    # Load all files
    for filepath in jsonl_files:
        examples = load_jsonl(filepath)
        file_stats[filepath.name] = len(examples)
        all_examples.extend(examples)
        print(f"  {filepath.name}: {len(examples)} examples")
    
    print(f"\nTotal examples before dedup: {len(all_examples)}")
    
    # Step 1: Exact dedup
    print("\n[Step 1] Exact deduplication...")
    deduped, exact_removed = exact_dedup(all_examples)
    print(f"  Removed {exact_removed} exact duplicates")
    print(f"  Remaining: {len(deduped)}")
    
    # Step 2: Near-dup detection
    print("\n[Step 2] Near-duplicate detection (threshold=0.85)...")
    deduped, near_removed = near_dedup(deduped, threshold=0.85)
    print(f"  Removed {near_removed} near-duplicates")
    print(f"  Remaining: {len(deduped)}")
    
    # Step 3: Extract all CVE IDs from training data
    print("\n[Step 3] Extracting CVE IDs from training data...")
    all_train_cves = set()
    for ex in deduped:
        content = ex.get('instruction', '') + ex.get('output', '')
        all_train_cves.update(extract_cve_ids(content))
    print(f"  Found {len(all_train_cves)} unique CVE IDs in training data")
    
    # Save deduplicated dataset
    output_path = training_dir / "train_deduped.jsonl"
    save_jsonl(deduped, output_path)
    print(f"\n[Output] Saved deduplicated dataset to {output_path}")
    
    # Summary
    print("\n" + "=" * 60)
    print("DEDUPLICATION SUMMARY")
    print("=" * 60)
    print(f"Original examples:    {len(all_examples)}")
    print(f"Exact duplicates:     {exact_removed}")
    print(f"Near duplicates:      {near_removed}")
    print(f"Final examples:       {len(deduped)}")
    print(f"Reduction:            {len(all_examples) - len(deduped)} ({100*(len(all_examples)-len(deduped))/len(all_examples):.1f}%)")
    print(f"Unique CVE IDs:       {len(all_train_cves)}")
    
    # Save CVE list for train/val isolation
    cve_list_path = training_dir / "train_cve_ids.txt"
    with open(cve_list_path, 'w') as f:
        for cve in sorted(all_train_cves):
            f.write(cve + '\n')
    print(f"\nSaved CVE ID list to {cve_list_path}")

if __name__ == "__main__":
    main()
