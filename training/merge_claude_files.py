#!/usr/bin/env python3
"""
Merge Claude's Phase 3 Files into Training Pipeline
Combines all Claude's deliverables with existing training data
"""

import json
import shutil
from pathlib import Path
from typing import List, Dict

def load_jsonl(filepath: Path) -> List[Dict]:
    """Load JSONL file"""
    examples = []
    if not filepath.exists():
        print(f"  ⚠️ File not found: {filepath}")
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

def load_json(filepath: Path) -> Dict:
    """Load JSON file"""
    if not filepath.exists():
        print(f"  ⚠️ File not found: {filepath}")
        return {}
    with open(filepath, 'r', encoding='utf-8') as f:
        return json.load(f)

def save_jsonl(examples: List[Dict], filepath: Path):
    """Save examples to JSONL file"""
    with open(filepath, 'w', encoding='utf-8') as f:
        for ex in examples:
            f.write(json.dumps(ex, ensure_ascii=False) + '\n')

def convert_multiturn_to_alpaca(conversations: List[Dict]) -> List[Dict]:
    """Convert multi-turn conversations to Alpaca format"""
    examples = []
    for conv in conversations:
        messages = conv.get('messages', [])
        if len(messages) >= 2:
            # Take first user message as instruction, full conversation as output
            instruction = messages[0].get('content', '') if messages[0].get('role') == 'user' else ''
            
            # Build conversation output
            output_parts = []
            for msg in messages[1:]:
                role = msg.get('role', 'assistant')
                content = msg.get('content', '')
                if role == 'assistant':
                    output_parts.append(content)
                else:
                    output_parts.append(f"\n[User follow-up: {content}]\n")
            
            examples.append({
                'instruction': instruction,
                'input': '',
                'output': ''.join(output_parts)
            })
    return examples

def generate_cve_training_from_tiers(tiers: Dict) -> List[Dict]:
    """Generate training examples from CVE confidence tiers"""
    examples = []
    
    for tier_name, tier_data in tiers.items():
        tier_info = tier_data if isinstance(tier_data, dict) else {}
        cves = tier_info.get('cves', [])
        weight = tier_info.get('weight', '100%')
        
        for cve in cves:
            cve_id = cve.get('id', cve) if isinstance(cve, dict) else cve
            surface = cve.get('surface', 'Flash runtime') if isinstance(cve, dict) else 'Flash runtime'
            
            examples.append({
                'instruction': f"What is {cve_id} and how does it affect Evony?",
                'input': '',
                'output': f"{cve_id} is a Flash Player vulnerability that affects Evony's {surface}. This CVE is classified as {tier_name} confidence for Evony impact. Confidence tier: {tier_name} ({weight} training weight)."
            })
    
    return examples

def main():
    """Main merge pipeline"""
    training_dir = Path(__file__).parent
    cve_research_dir = training_dir.parent / "CVE_Research"
    
    print("=" * 60)
    print("MERGE CLAUDE'S FILES INTO TRAINING PIPELINE")
    print("=" * 60)
    
    all_new_examples = []
    
    # 1. Grounding examples
    print("\n[1] Loading grounding_examples.jsonl...")
    grounding = load_jsonl(cve_research_dir / "grounding_examples.jsonl")
    print(f"    Loaded {len(grounding)} grounding examples")
    all_new_examples.extend(grounding)
    
    # 2. Refusal to guess examples
    print("\n[2] Loading refusal_to_guess.jsonl...")
    refusal = load_jsonl(cve_research_dir / "refusal_to_guess.jsonl")
    print(f"    Loaded {len(refusal)} refusal examples")
    all_new_examples.extend(refusal)
    
    # 3. Multi-turn examples
    print("\n[3] Loading multiturn_examples.jsonl...")
    multiturn_raw = load_jsonl(cve_research_dir / "multiturn_examples.jsonl")
    multiturn = convert_multiturn_to_alpaca(multiturn_raw)
    print(f"    Converted {len(multiturn)} multi-turn conversations")
    all_new_examples.extend(multiturn)
    
    # 4. Cross-domain examples
    print("\n[4] Loading crossdomain_examples.jsonl...")
    crossdomain = load_jsonl(cve_research_dir / "crossdomain_examples.jsonl")
    print(f"    Loaded {len(crossdomain)} cross-domain examples")
    all_new_examples.extend(crossdomain)
    
    # 5. CVE confidence tiers
    print("\n[5] Loading cve_confidence_tiers.json...")
    tiers = load_json(cve_research_dir / "cve_confidence_tiers.json")
    if tiers:
        cve_examples = generate_cve_training_from_tiers(tiers)
        print(f"    Generated {len(cve_examples)} CVE tier examples")
        all_new_examples.extend(cve_examples)
    
    # Save merged Claude examples
    claude_output = training_dir / "train_claude_phase3.jsonl"
    save_jsonl(all_new_examples, claude_output)
    print(f"\n[Output] Saved {len(all_new_examples)} Claude examples to {claude_output}")
    
    # Copy validation prompts
    print("\n[6] Copying validation prompts...")
    val_src = cve_research_dir / "validation_prompts_v2_defensive.json"
    val_dst = training_dir / "validation_prompts_v2.json"
    if val_src.exists():
        shutil.copy(val_src, val_dst)
        print(f"    Copied to {val_dst}")
    
    # Summary
    print("\n" + "=" * 60)
    print("MERGE COMPLETE")
    print("=" * 60)
    print(f"""
Files created:
  - {claude_output} ({len(all_new_examples)} examples)
  - {val_dst} (80 validation prompts)

Claude's contributions:
  - Grounding examples: {len(grounding)}
  - Refusal examples: {len(refusal)}
  - Multi-turn: {len(multiturn)}
  - Cross-domain: {len(crossdomain)}
  - CVE tiers: {len(cve_examples) if tiers else 0}

Next steps:
  1. Run: python dedup_dataset.py
  2. Run: python balanced_sampler.py
  3. Run training with 3-milestone approach
""")

if __name__ == "__main__":
    main()
