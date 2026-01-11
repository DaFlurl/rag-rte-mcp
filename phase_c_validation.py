#!/usr/bin/env python3
"""
Phase C: Quality Validation
Score, filter, and generate quality report
"""

import json
import re
from pathlib import Path
from datetime import datetime
from collections import defaultdict

TRAINING_DIR = Path(__file__).parent / "Evony_Training_Data"


def score_example(example):
    """Score a training example 0-100"""
    score = 50  # Base score
    
    instruction = example.get("instruction", "")
    output = example.get("output", "")
    
    # Length checks
    if len(instruction) < 10:
        score -= 20
    elif len(instruction) > 30:
        score += 10
    
    if len(output) < 20:
        score -= 15
    elif len(output) > 100:
        score += 15
    elif len(output) > 200:
        score += 20
    
    # Content quality
    if "?" in instruction:
        score += 5  # Proper question format
    
    # Technical content indicators
    technical_terms = ["command", "parameter", "field", "type", "error", "bean", "protocol", "function", "API", "JSON"]
    for term in technical_terms:
        if term.lower() in output.lower():
            score += 2
    
    # Code indicators
    if "```" in output or ".as" in output or ".json" in output:
        score += 10
    
    # Specific value indicators
    if re.search(r'\d+', output):
        score += 5  # Contains numbers
    
    # Penalty for generic responses
    generic_phrases = ["see the", "check the", "refer to", "consult"]
    for phrase in generic_phrases:
        if phrase in output.lower():
            score -= 5
    
    return min(100, max(0, score))


def categorize_example(example):
    """Categorize example by topic"""
    instruction = example.get("instruction", "").lower()
    output = example.get("output", "").lower()
    
    if any(w in instruction for w in ["command", "protocol", "army.", "troop.", "castle.", "hero."]):
        return "protocol"
    elif any(w in instruction for w in ["bean", "field", "class"]):
        return "data_model"
    elif any(w in instruction for w in ["building", "barracks", "cottage", "farm", "academy"]):
        return "buildings"
    elif any(w in instruction for w in ["troop", "archer", "cavalry", "warrior", "scout"]):
        return "troops"
    elif any(w in instruction for w in ["research", "tech"]):
        return "research"
    elif any(w in instruction for w in ["error", "code -"]):
        return "errors"
    elif any(w in instruction for w in ["script", "autoevony", "set ", "goto", "loop"]):
        return "scripting"
    elif any(w in instruction for w in ["encrypt", "key", "signature", "security"]):
        return "security"
    elif any(w in instruction for w in ["attack", "damage", "combat", "defend"]):
        return "combat"
    else:
        return "other"


def validate_json_structure(example):
    """Validate example has required structure"""
    required = ["instruction", "output"]
    return all(k in example and example[k] for k in required)


def main():
    print("="*60)
    print("PHASE C: QUALITY VALIDATION")
    print(f"Started: {datetime.now()}")
    print("="*60)
    
    # Load dataset
    dataset_path = TRAINING_DIR / "evony_augmented_10k.json"
    with open(dataset_path) as f:
        data = json.load(f)
    
    print(f"\nLoaded: {len(data)} examples")
    
    # Validate and score
    scores = []
    categories = defaultdict(list)
    invalid = []
    
    for i, example in enumerate(data):
        # Structure validation
        if not validate_json_structure(example):
            invalid.append(i)
            continue
        
        # Score
        score = score_example(example)
        scores.append(score)
        
        # Categorize
        cat = categorize_example(example)
        categories[cat].append(score)
    
    # Calculate statistics
    avg_score = sum(scores) / len(scores) if scores else 0
    high_quality = len([s for s in scores if s >= 70])
    medium_quality = len([s for s in scores if 40 <= s < 70])
    low_quality = len([s for s in scores if s < 40])
    
    print(f"\n--- QUALITY METRICS ---")
    print(f"Total examples: {len(data)}")
    print(f"Valid examples: {len(scores)}")
    print(f"Invalid examples: {len(invalid)}")
    print(f"Average score: {avg_score:.1f}/100")
    print(f"High quality (70+): {high_quality} ({100*high_quality/len(scores):.1f}%)")
    print(f"Medium quality (40-69): {medium_quality} ({100*medium_quality/len(scores):.1f}%)")
    print(f"Low quality (<40): {low_quality} ({100*low_quality/len(scores):.1f}%)")
    
    print(f"\n--- CATEGORY DISTRIBUTION ---")
    for cat, cat_scores in sorted(categories.items(), key=lambda x: -len(x[1])):
        avg = sum(cat_scores) / len(cat_scores) if cat_scores else 0
        print(f"  {cat}: {len(cat_scores)} examples (avg: {avg:.1f})")
    
    # Generate quality report
    report = {
        "generated_at": datetime.now().isoformat(),
        "total_examples": len(data),
        "valid_examples": len(scores),
        "invalid_examples": len(invalid),
        "average_score": round(avg_score, 2),
        "quality_distribution": {
            "high_70plus": high_quality,
            "medium_40to69": medium_quality,
            "low_below40": low_quality
        },
        "category_stats": {
            cat: {
                "count": len(cat_scores),
                "avg_score": round(sum(cat_scores)/len(cat_scores), 2) if cat_scores else 0
            }
            for cat, cat_scores in categories.items()
        }
    }
    
    # Save report
    report_path = TRAINING_DIR / "quality_report.json"
    with open(report_path, "w") as f:
        json.dump(report, f, indent=2)
    print(f"\nSaved report to {report_path}")
    
    # Filter to high-quality only
    high_quality_data = [
        ex for ex, score in zip(data, scores + [0]*len(invalid))
        if score >= 50  # Keep medium and high
    ]
    
    filtered_path = TRAINING_DIR / "evony_filtered_quality.json"
    with open(filtered_path, "w") as f:
        json.dump(high_quality_data, f, indent=2)
    
    filtered_jsonl = TRAINING_DIR / "evony_filtered_quality.jsonl"
    with open(filtered_jsonl, "w") as f:
        for ex in high_quality_data:
            f.write(json.dumps(ex) + "\n")
    
    print(f"Saved {len(high_quality_data)} filtered examples to {filtered_path}")
    
    print(f"\n✅ PHASE C COMPLETE")
    print(f"Completed: {datetime.now()}")


if __name__ == "__main__":
    main()
