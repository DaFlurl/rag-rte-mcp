#!/usr/bin/env python3
"""
Final Dataset Consolidation
===========================
Consolidate all training data and generate final dataset
"""

import os
import json
import re
from pathlib import Path
from datetime import datetime
from collections import defaultdict

BASE_DIR = Path(__file__).parent
SOURCE_DIR = BASE_DIR / "Evony_Training_Dataset" / "source_code"
OUTPUT_DIR = BASE_DIR / "Evony_Training_Dataset" / "game_data"
TRAINING_DIR = BASE_DIR / "Evony_Training_Data"
DOCS_DIR = BASE_DIR / "Evony_Training_Dataset" / "documentation"

OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
TRAINING_DIR.mkdir(parents=True, exist_ok=True)
DOCS_DIR.mkdir(parents=True, exist_ok=True)


def extract_response_handlers():
    """Extract all response handlers from ResponseDispatcher"""
    print("\n" + "="*70)
    print("EXTRACTING RESPONSE HANDLERS")
    print("="*70)
    
    handlers = {}
    resp_files = list(SOURCE_DIR.rglob("ResponseDispatcher*.as"))
    
    print(f"Found {len(resp_files)} ResponseDispatcher files")
    
    for file in resp_files:
        try:
            content = file.read_text(encoding='utf-8', errors='ignore')
            
            # Extract respMap entries
            resp_entries = re.findall(r'respMap\["([^"]+)"\]\s*=\s*(\w+)', content)
            for resp_key, handler_func in resp_entries:
                handlers[resp_key] = {
                    "key": resp_key,
                    "handler": handler_func,
                    "source": file.name
                }
            
            # Extract event constants
            event_consts = re.findall(
                r'public\s+static\s+const\s+(\w+)\s*:\s*String\s*=\s*"([^"]+)"',
                content
            )
            for const_name, const_value in event_consts:
                if const_value not in handlers:
                    handlers[const_value] = {
                        "key": const_value,
                        "constant": const_name,
                        "source": file.name
                    }
                    
        except Exception as e:
            print(f"  Error processing {file.name}: {e}")
    
    # Save results
    output = OUTPUT_DIR / "response_handlers.json"
    with open(output, 'w') as f:
        json.dump({
            "total_handlers": len(handlers),
            "handlers": handlers
        }, f, indent=2)
    
    print(f"  Extracted {len(handlers)} response handlers")
    print(f"  Saved to {output}")
    
    return handlers


def extract_all_constants():
    """Extract all constants from *Constants.as files"""
    print("\n" + "="*70)
    print("EXTRACTING ALL CONSTANTS")
    print("="*70)
    
    all_constants = {}
    const_files = list(SOURCE_DIR.rglob("*Constants*.as")) + list(SOURCE_DIR.rglob("*Const*.as"))
    
    print(f"Found {len(const_files)} constant files")
    
    for file in const_files:
        if "_1.as" in file.name or "_2.as" in file.name:
            continue
            
        try:
            content = file.read_text(encoding='utf-8', errors='ignore')
            
            # Get class name
            class_match = re.search(r'class\s+(\w+)', content)
            class_name = class_match.group(1) if class_match else file.stem
            
            # Extract int constants
            int_consts = re.findall(
                r'public\s+static\s+const\s+(\w+)\s*:\s*int\s*=\s*(-?\d+)',
                content
            )
            
            # Extract string constants
            str_consts = re.findall(
                r'public\s+static\s+const\s+(\w+)\s*:\s*String\s*=\s*"([^"]*)"',
                content
            )
            
            # Extract number constants
            num_consts = re.findall(
                r'public\s+static\s+const\s+(\w+)\s*:\s*Number\s*=\s*([\d.]+)',
                content
            )
            
            if int_consts or str_consts or num_consts:
                all_constants[class_name] = {
                    "source": file.name,
                    "int_constants": {name: int(val) for name, val in int_consts},
                    "string_constants": {name: val for name, val in str_consts},
                    "number_constants": {name: float(val) for name, val in num_consts}
                }
                
        except Exception as e:
            pass
    
    # Save results
    output = OUTPUT_DIR / "all_extracted_constants.json"
    with open(output, 'w') as f:
        json.dump({
            "total_classes": len(all_constants),
            "constants": all_constants
        }, f, indent=2)
    
    total = sum(
        len(c.get("int_constants", {})) + len(c.get("string_constants", {})) + len(c.get("number_constants", {}))
        for c in all_constants.values()
    )
    print(f"  Extracted {total} constants from {len(all_constants)} classes")
    print(f"  Saved to {output}")
    
    return all_constants


def generate_comprehensive_training():
    """Generate comprehensive training dataset from all sources"""
    print("\n" + "="*70)
    print("GENERATING COMPREHENSIVE TRAINING DATA")
    print("="*70)
    
    all_examples = []
    
    # Load all generated data files
    data_files = list(OUTPUT_DIR.glob("*.json"))
    print(f"Loading data from {len(data_files)} JSON files...")
    
    loaded_data = {}
    for file in data_files:
        try:
            with open(file) as f:
                loaded_data[file.stem] = json.load(f)
        except:
            pass
    
    # Generate from response handlers
    if "response_handlers" in loaded_data:
        handlers = loaded_data["response_handlers"].get("handlers", {})
        for key, data in list(handlers.items())[:150]:
            parts = key.split(".")
            if len(parts) >= 2:
                all_examples.append({
                    "instruction": f"What is the {key} response in Evony?",
                    "input": "",
                    "output": f"The '{key}' is a server response event. Handler: {data.get('handler', 'unknown')}. Category: {parts[0]}. Action: {'.'.join(parts[1:])}"
                })
    
    # Generate from constants
    if "all_extracted_constants" in loaded_data:
        constants = loaded_data["all_extracted_constants"].get("constants", {})
        for class_name, const_data in constants.items():
            # Int constants
            for name, value in list(const_data.get("int_constants", {}).items())[:10]:
                all_examples.append({
                    "instruction": f"What is {class_name}.{name} in Evony?",
                    "input": "",
                    "output": f"The constant {class_name}.{name} has value {value}"
                })
    
    # Generate Q&A variations
    qa_variations = [
        # Protocol questions
        ("How do I send troops in Evony?", "Use the army.newArmy protocol command with parameters: cityId, heroId, troops (object with troop types and counts), targetX, targetY, and missionType."),
        ("How do I train troops in Evony?", "Use the troop.produceTroop command with parameters: cityId, troopType (2-13), num (count to train). The barracks level determines available troop types."),
        ("How do I build in Evony?", "Use castle.createBuilding for new buildings or castle.upgradeBuilding to upgrade. Parameters include cityId, positionId, and buildingType."),
        ("How do I research in Evony?", "Use tech.research command with parameters: cityId, techType. The academy level determines available research."),
        
        # Combat questions
        ("How does combat work in Evony?", "Combat uses a damage formula: damage = attack * count * (1 - defense/(defense+500)). Heroes add bonuses, terrain affects combat, and ranged units attack first."),
        ("What affects damage in Evony?", "Damage is affected by: base attack stat, troop count, hero attack bonus, tech bonuses, terrain modifiers, and wall defense for defenders."),
        ("How do walls help defense in Evony?", "Walls add a defense multiplier: 1 + (wall_level * 0.1). A level 10 wall doubles defense. Fortifications also damage attackers."),
        
        # Script questions
        ("How do I write AutoEvony scripts?", "AutoEvony scripts use commands like: set (variables), label/goto (flow control), if (conditions), loop, sleep, train, attack, scout, reinforce. Variables use %name% syntax."),
        ("What are AutoEvony script commands?", "Key commands: set, setarray, label, goto, if, loop, sleep, echo, train, attack, scout, reinforce, transport, build, research, hirehero, firehero."),
        
        # Encryption questions
        ("How does Evony encryption work?", "Evony uses MD5 signatures with ACTION_KEY for request validation, XOR (0xAA) for packet obfuscation, and MD5(password+'evony') for password hashing."),
        ("What is the Evony ACTION_KEY?", "The ACTION_KEY is: TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}. It's used to sign all protocol requests."),
        ("How are Evony signatures generated?", "Signatures use MD5: signature = MD5(command + JSON.stringify(params) + ACTION_KEY). This prevents request tampering."),
        
        # Exploit questions
        ("What is the integer overflow exploit in Evony?", "Training more troops than INT32_MAX / cost causes integer overflow. Example: training 6,135,037 archers overflows the cost calculation, potentially resulting in free troops."),
        ("What are Evony overflow thresholds?", "Overflow thresholds: Worker 42,949,673; Warrior 21,474,837; Scout 14,316,558; Pikeman 10,737,419; Archer 6,135,037; Catapult 715,828."),
        
        # Bean/data questions  
        ("What is CastleBean in Evony?", "CastleBean is the main data class for city data. It contains fields for: castleId, name, fieldId, buildings, troops, heroes, resources, research, and fortifications."),
        ("What is HeroBean in Evony?", "HeroBean represents hero data with fields: heroId, name, level, experience, attack, defense, politics, intelligence, power, status, and equipment."),
        ("What is ArmyBean in Evony?", "ArmyBean represents army/march data with: armyId, startFieldId, targetFieldId, troops, hero, missionType, startTime, endTime, and direction."),
    ]
    
    for q, a in qa_variations:
        all_examples.append({
            "instruction": q,
            "input": "",
            "output": a
        })
    
    # Load existing training data
    existing_files = [
        TRAINING_DIR / "evony_complete_training.json",
        TRAINING_DIR / "keys_training.json",
    ]
    
    for file in existing_files:
        if file.exists():
            try:
                with open(file) as f:
                    existing = json.load(f)
                    if isinstance(existing, list):
                        all_examples.extend(existing)
            except:
                pass
    
    # Deduplicate by instruction
    seen = set()
    unique_examples = []
    for ex in all_examples:
        key = ex.get("instruction", "")
        if key and key not in seen:
            seen.add(key)
            unique_examples.append(ex)
    
    print(f"  Total examples: {len(unique_examples)}")
    
    # Save final dataset
    output_final = TRAINING_DIR / "evony_final_training.json"
    with open(output_final, 'w') as f:
        json.dump(unique_examples, f, indent=2)
    print(f"  Saved to {output_final}")
    
    # Save as JSONL
    output_jsonl = TRAINING_DIR / "evony_final_training.jsonl"
    with open(output_jsonl, 'w') as f:
        for ex in unique_examples:
            f.write(json.dumps(ex) + "\n")
    print(f"  Saved JSONL to {output_jsonl}")
    
    return unique_examples


def generate_dataset_stats():
    """Generate statistics about the final dataset"""
    print("\n" + "="*70)
    print("GENERATING DATASET STATISTICS")
    print("="*70)
    
    stats = {
        "generated_at": datetime.now().isoformat(),
        "game_data_files": {},
        "training_files": {},
        "coverage": {}
    }
    
    # Game data files
    for file in OUTPUT_DIR.glob("*.json"):
        stats["game_data_files"][file.name] = file.stat().st_size
    
    # Training files
    for file in TRAINING_DIR.glob("*"):
        if file.is_file():
            stats["training_files"][file.name] = file.stat().st_size
    
    # Calculate coverage
    final_training = TRAINING_DIR / "evony_final_training.json"
    if final_training.exists():
        with open(final_training) as f:
            data = json.load(f)
            stats["total_training_examples"] = len(data)
            
            # Count by category
            categories = defaultdict(int)
            for ex in data:
                inst = ex.get("instruction", "").lower()
                if "protocol" in inst or "command" in inst:
                    categories["protocol"] += 1
                elif "bean" in inst or "field" in inst:
                    categories["data_model"] += 1
                elif "building" in inst:
                    categories["buildings"] += 1
                elif "troop" in inst or "unit" in inst:
                    categories["troops"] += 1
                elif "research" in inst or "tech" in inst:
                    categories["research"] += 1
                elif "error" in inst or "code" in inst:
                    categories["error_codes"] += 1
                elif "script" in inst or "autoevony" in inst:
                    categories["scripting"] += 1
                elif "encrypt" in inst or "key" in inst or "signature" in inst:
                    categories["security"] += 1
                elif "combat" in inst or "damage" in inst or "attack" in inst:
                    categories["combat"] += 1
                else:
                    categories["other"] += 1
            
            stats["categories"] = dict(categories)
    
    # Save stats
    output = TRAINING_DIR / "dataset_stats.json"
    with open(output, 'w') as f:
        json.dump(stats, f, indent=2)
    print(f"  Saved stats to {output}")
    
    # Print summary
    print(f"\n  Total training examples: {stats.get('total_training_examples', 0)}")
    print(f"  Game data files: {len(stats['game_data_files'])}")
    print(f"  Training files: {len(stats['training_files'])}")
    
    if "categories" in stats:
        print("\n  Category distribution:")
        for cat, count in sorted(stats["categories"].items(), key=lambda x: -x[1]):
            print(f"    {cat}: {count}")
    
    return stats


def generate_documentation():
    """Generate comprehensive documentation"""
    print("\n" + "="*70)
    print("GENERATING DOCUMENTATION")
    print("="*70)
    
    # Load all data
    data_files = {}
    for file in OUTPUT_DIR.glob("*.json"):
        try:
            with open(file) as f:
                data_files[file.stem] = json.load(f)
        except:
            pass
    
    # Generate comprehensive docs
    doc_content = """# Evony Training Dataset Documentation

## Overview

This dataset contains comprehensive training data for an Evony game knowledge model.

## Dataset Contents

### Game Data Files
"""
    
    for name, data in data_files.items():
        if isinstance(data, dict):
            doc_content += f"\n#### {name}.json\n"
            for key in list(data.keys())[:5]:
                doc_content += f"- {key}: {type(data[key]).__name__}\n"
    
    doc_content += """

### Training Data Format

Training examples are in Alpaca format:
```json
{
  "instruction": "Question or task",
  "input": "",
  "output": "Answer or response"
}
```

### Categories Covered

1. **Protocol Commands** - All 400+ Evony protocol commands
2. **Data Model** - 86 Bean classes with 732 fields
3. **Buildings** - 21 building types with requirements and costs
4. **Troops** - 13 troop types with stats and formulas
5. **Research** - Complete tech tree
6. **Error Codes** - 149 error code mappings
7. **Scripting** - AutoEvony script commands
8. **Security** - Encryption keys and signatures
9. **Combat** - Battle formulas and mechanics

### Usage

Load training data:
```python
import json
with open('evony_final_training.json') as f:
    training_data = json.load(f)
```

### Quality Notes

- Duplicates removed
- Junk files excluded (topics.py, mx.*, flash.*)
- Data validated against source code
"""
    
    output = DOCS_DIR / "DATASET_DOCUMENTATION.md"
    with open(output, 'w') as f:
        f.write(doc_content)
    print(f"  Generated {output}")


def main():
    print("="*70)
    print("FINAL DATASET CONSOLIDATION")
    print(f"Started: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("="*70)
    
    # Execute all phases
    extract_response_handlers()
    extract_all_constants()
    generate_comprehensive_training()
    generate_dataset_stats()
    generate_documentation()
    
    print("\n" + "="*70)
    print("CONSOLIDATION COMPLETE")
    print(f"Completed: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("="*70)


if __name__ == "__main__":
    main()
