#!/usr/bin/env python3
"""
Keys Directory Analysis
=======================
Analyze 1,230 files in keys/ directory for training data
"""

import os
import json
import re
from pathlib import Path
from datetime import datetime
from collections import defaultdict

BASE_DIR = Path(__file__).parent
KEYS_DIR = BASE_DIR / "Evony_Training_Dataset" / "keys"
OUTPUT_DIR = BASE_DIR / "Evony_Training_Dataset" / "game_data"
TRAINING_DIR = BASE_DIR / "Evony_Training_Data"

OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
TRAINING_DIR.mkdir(parents=True, exist_ok=True)


def analyze_keys_directory():
    """Analyze all files in keys directory"""
    print("="*70)
    print("KEYS DIRECTORY ANALYSIS")
    print(f"Started: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("="*70)
    
    analysis = {
        "total_files": 0,
        "file_types": defaultdict(int),
        "categories": defaultdict(list),
        "json_accounts": [],
        "documentation": [],
        "scripts": [],
        "configs": [],
    }
    
    training_examples = []
    
    if not KEYS_DIR.exists():
        print(f"Keys directory not found: {KEYS_DIR}")
        return
    
    files = list(KEYS_DIR.glob("*"))
    print(f"Found {len(files)} files in keys/")
    
    for file in files:
        if not file.is_file():
            continue
            
        analysis["total_files"] += 1
        ext = file.suffix.lower()
        analysis["file_types"][ext] += 1
        
        try:
            # Analyze by file type
            if ext == ".json":
                analyze_json_file(file, analysis, training_examples)
            elif ext == ".md":
                analyze_markdown_file(file, analysis, training_examples)
            elif ext == ".py":
                analyze_python_file(file, analysis, training_examples)
            elif ext == ".txt":
                analyze_text_file(file, analysis, training_examples)
            elif ext == ".xml":
                analyze_xml_file(file, analysis, training_examples)
                
        except Exception as e:
            pass  # Skip problematic files
    
    # Convert defaultdicts
    analysis["file_types"] = dict(analysis["file_types"])
    analysis["categories"] = dict(analysis["categories"])
    
    # Save analysis
    output = OUTPUT_DIR / "keys_analysis.json"
    with open(output, 'w') as f:
        json.dump(analysis, f, indent=2, default=str)
    print(f"\nSaved analysis to {output}")
    
    # Save training examples
    if training_examples:
        output_training = TRAINING_DIR / "keys_training.json"
        with open(output_training, 'w') as f:
            json.dump(training_examples, f, indent=2)
        print(f"Generated {len(training_examples)} training examples from keys/")
        print(f"Saved to {output_training}")
    
    print(f"\nFile type distribution:")
    for ext, count in sorted(analysis["file_types"].items(), key=lambda x: -x[1]):
        print(f"  {ext or 'no ext'}: {count}")
    
    return analysis, training_examples


def analyze_json_file(file, analysis, training_examples):
    """Analyze JSON files - likely account data"""
    try:
        content = file.read_text(encoding='utf-8', errors='ignore')
        data = json.loads(content)
        
        # Check if it's account data
        if "player" in data or "castles" in data or "msg" in data:
            analysis["json_accounts"].append(file.name)
            
            # Extract useful training data
            if isinstance(data.get("player"), dict):
                player = data["player"]
                
                # Castle count
                castles = player.get("castles", [])
                if castles:
                    training_examples.append({
                        "instruction": "What data does an Evony player account contain?",
                        "input": "",
                        "output": f"An Evony player account contains: castles ({len(castles)} cities), buildings, troops, heroes, resources, research, and more. This data is serialized as JSON in the protocol."
                    })
                
                # Building data
                for castle in castles[:1]:  # First castle only
                    buildings = castle.get("buildings", [])
                    if buildings:
                        building_types = set(b.get("typeId") for b in buildings if "typeId" in b)
                        training_examples.append({
                            "instruction": "What building types are in an Evony city?",
                            "input": "",
                            "output": f"An Evony city contains buildings with type IDs: {sorted(building_types)}. Each building has positionId, status, level, and timing data."
                        })
                        break
        
        # Check if it's configuration
        elif any(k in data for k in ["config", "settings", "keys", "encryption"]):
            analysis["configs"].append(file.name)
            
    except json.JSONDecodeError:
        pass


def analyze_markdown_file(file, analysis, training_examples):
    """Analyze Markdown documentation files"""
    try:
        content = file.read_text(encoding='utf-8', errors='ignore')
        analysis["documentation"].append(file.name)
        
        # Extract key information
        if "BATTLE" in file.name.upper() or "battle" in content.lower()[:500]:
            # Battle mechanics documentation
            training_examples.append({
                "instruction": f"What does {file.name} document?",
                "input": "",
                "output": f"The {file.name} file contains Evony battle mechanics documentation including combat formulas, troop effectiveness, and damage calculations."
            })
        
        elif "KEY" in file.name.upper() or "encrypt" in content.lower()[:500]:
            training_examples.append({
                "instruction": f"What does {file.name} document?",
                "input": "",
                "output": f"The {file.name} file contains Evony encryption key documentation and cryptographic implementation details."
            })
        
        # Extract headers for training
        headers = re.findall(r'^#{1,3}\s+(.+)$', content, re.MULTILINE)
        if headers:
            training_examples.append({
                "instruction": f"What topics are covered in {file.name}?",
                "input": "",
                "output": f"The {file.name} document covers: {', '.join(headers[:10])}"
            })
            
    except Exception:
        pass


def analyze_python_file(file, analysis, training_examples):
    """Analyze Python script files"""
    try:
        content = file.read_text(encoding='utf-8', errors='ignore')
        analysis["scripts"].append(file.name)
        
        # Extract function definitions
        functions = re.findall(r'^def\s+(\w+)\s*\(', content, re.MULTILINE)
        if functions:
            training_examples.append({
                "instruction": f"What functions are in {file.name}?",
                "input": "",
                "output": f"The {file.name} Python file contains functions: {', '.join(functions[:15])}"
            })
        
        # Extract class definitions
        classes = re.findall(r'^class\s+(\w+)', content, re.MULTILINE)
        if classes:
            training_examples.append({
                "instruction": f"What classes are in {file.name}?",
                "input": "",
                "output": f"The {file.name} Python file contains classes: {', '.join(classes[:10])}"
            })
            
    except Exception:
        pass


def analyze_text_file(file, analysis, training_examples):
    """Analyze text files"""
    try:
        content = file.read_text(encoding='utf-8', errors='ignore')
        
        # Check if it's a script
        if any(cmd in content.lower() for cmd in ['set ', 'label ', 'goto ', 'loop ']):
            analysis["scripts"].append(file.name)
        else:
            analysis["documentation"].append(file.name)
            
    except Exception:
        pass


def analyze_xml_file(file, analysis, training_examples):
    """Analyze XML configuration files"""
    try:
        content = file.read_text(encoding='utf-8', errors='ignore')
        analysis["configs"].append(file.name)
        
        # Flash config files
        if "flash" in file.name.lower() or "<flex-config>" in content:
            training_examples.append({
                "instruction": f"What is the {file.name} configuration for?",
                "input": "",
                "output": f"The {file.name} is a Flash/Flex configuration file used to configure the ActionScript compiler and runtime settings for Evony."
            })
            
    except Exception:
        pass


def main():
    analysis, training_examples = analyze_keys_directory()
    
    print("\n" + "="*70)
    print("SUMMARY")
    print("="*70)
    print(f"Total files analyzed: {analysis['total_files']}")
    print(f"JSON account files: {len(analysis['json_accounts'])}")
    print(f"Documentation files: {len(analysis['documentation'])}")
    print(f"Script files: {len(analysis['scripts'])}")
    print(f"Config files: {len(analysis['configs'])}")
    print(f"Training examples generated: {len(training_examples)}")
    print("="*70)


if __name__ == "__main__":
    main()
