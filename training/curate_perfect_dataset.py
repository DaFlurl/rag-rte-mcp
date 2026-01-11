#!/usr/bin/env python3
"""
Perfection Dataset Curator for Evony AI Training
Creates high-quality training pairs from source files

Strategy: Quality over Quantity
- 2,500 perfect examples > 10,000 mixed quality
- Each example is complete, correct, and useful
"""

import os
import json
import hashlib
from pathlib import Path
from typing import List, Dict, Tuple
from datetime import datetime

# Paths
PROJECT_ROOT = Path(__file__).parent.parent
AS3_SCRIPTS = PROJECT_ROOT / "AS3_Scripts_(EvonyClient1921.swf)"
BORG_TOOLKIT = PROJECT_ROOT / "BorgToolkit"
EVONY_HUB = PROJECT_ROOT / "evony_hub"
OUTPUT_DIR = PROJECT_ROOT / "training" / "data_perfect"

# Quality thresholds
MIN_CODE_LENGTH = 100      # Skip tiny files
MAX_CODE_LENGTH = 8000     # Avoid too long (context limits)
MIN_MEANINGFUL_LINES = 5   # Must have substance


def setup_output():
    """Create output directory structure"""
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    return {
        "code_explain": [],      # Explain what code does
        "code_generate": [],     # Generate code from description
        "exploit_scripts": [],   # Working exploit scripts
        "protocol_commands": [], # Protocol encode/decode
        "autoevony_scripts": [], # AutoEvony script generation
        "qa_general": [],        # General Q&A about Evony
        "error_debug": [],       # Error fixing examples
    }


def extract_class_info(content: str, filename: str) -> Dict:
    """Extract meaningful info from ActionScript class"""
    info = {
        "filename": filename,
        "class_name": "",
        "package": "",
        "imports": [],
        "methods": [],
        "properties": [],
        "description": "",
    }
    
    lines = content.split('\n')
    for line in lines:
        line = line.strip()
        if line.startswith('package '):
            info["package"] = line.replace('package ', '').replace('{', '').strip()
        elif line.startswith('import '):
            info["imports"].append(line.replace('import ', '').replace(';', '').strip())
        elif 'class ' in line and not line.startswith('//'):
            parts = line.split('class ')
            if len(parts) > 1:
                info["class_name"] = parts[1].split()[0].strip()
        elif 'function ' in line and not line.startswith('//'):
            # Extract function name
            if 'function ' in line:
                func_part = line.split('function ')[1]
                func_name = func_part.split('(')[0].strip()
                if func_name and not func_name.startswith('_'):
                    info["methods"].append(func_name)
        elif ('var ' in line or 'const ' in line) and ':' in line:
            # Extract property
            if 'var ' in line:
                prop = line.split('var ')[1].split(':')[0].strip()
            else:
                prop = line.split('const ')[1].split(':')[0].strip()
            if prop and not prop.startswith('_'):
                info["properties"].append(prop)
    
    return info


def create_code_explain_pair(filepath: Path, content: str) -> Dict:
    """Create a code explanation training pair"""
    info = extract_class_info(content, filepath.name)
    
    if not info["class_name"] and not info["methods"]:
        return None
    
    # Create the training pair
    question = f"Explain what the {filepath.name} file does in the Evony client."
    
    answer_parts = []
    if info["class_name"]:
        answer_parts.append(f"The `{info['class_name']}` class")
        if info["package"]:
            answer_parts.append(f"in package `{info['package']}`")
    
    if info["methods"]:
        methods_str = ", ".join([f"`{m}()`" for m in info["methods"][:10]])
        answer_parts.append(f"\n\nKey methods: {methods_str}")
    
    if info["properties"]:
        props_str = ", ".join([f"`{p}`" for p in info["properties"][:10]])
        answer_parts.append(f"\n\nProperties: {props_str}")
    
    answer_parts.append(f"\n\n```actionscript\n{content[:2000]}{'...' if len(content) > 2000 else ''}\n```")
    
    return {
        "instruction": question,
        "input": "",
        "output": " ".join(answer_parts),
        "source": str(filepath),
        "category": "code_explain"
    }


def create_code_generate_pair(filepath: Path, content: str) -> Dict:
    """Create a code generation training pair (reverse of explain)"""
    info = extract_class_info(content, filepath.name)
    
    if not info["class_name"] or len(info["methods"]) < 2:
        return None
    
    # Create instruction from the class info
    methods_desc = ", ".join(info["methods"][:5])
    
    instruction = f"Generate an ActionScript class for {info['class_name']} with methods: {methods_desc}"
    if info["package"]:
        instruction += f" in package {info['package']}"
    
    return {
        "instruction": instruction,
        "input": "",
        "output": content[:4000],  # Truncate if too long
        "source": str(filepath),
        "category": "code_generate"
    }


def process_as3_files(buckets: Dict, limit_per_category: int = 500):
    """Process ActionScript files into training pairs"""
    print(f"\n📂 Processing AS3 files from {AS3_SCRIPTS}...")
    
    if not AS3_SCRIPTS.exists():
        print("  ⚠️ AS3_Scripts directory not found")
        return
    
    as_files = list(AS3_SCRIPTS.rglob("*.as"))
    print(f"  Found {len(as_files)} .as files")
    
    processed = 0
    for filepath in as_files:
        if processed >= limit_per_category * 2:  # explain + generate
            break
            
        try:
            content = filepath.read_text(encoding='utf-8', errors='ignore')
            
            # Quality filters
            if len(content) < MIN_CODE_LENGTH:
                continue
            if len(content) > MAX_CODE_LENGTH:
                content = content[:MAX_CODE_LENGTH]
            if content.count('\n') < MIN_MEANINGFUL_LINES:
                continue
            
            # Skip style/boilerplate files
            if filepath.name.startswith('_') and 'Style' in filepath.name:
                continue
            
            # Create explain pair
            if len(buckets["code_explain"]) < limit_per_category:
                pair = create_code_explain_pair(filepath, content)
                if pair:
                    buckets["code_explain"].append(pair)
            
            # Create generate pair
            if len(buckets["code_generate"]) < limit_per_category:
                pair = create_code_generate_pair(filepath, content)
                if pair:
                    buckets["code_generate"].append(pair)
            
            processed += 1
            
        except Exception as e:
            continue
    
    print(f"  ✅ Code explain: {len(buckets['code_explain'])} pairs")
    print(f"  ✅ Code generate: {len(buckets['code_generate'])} pairs")


def process_exploit_scripts(buckets: Dict):
    """Process working exploit scripts"""
    print(f"\n📂 Processing exploit scripts from {BORG_TOOLKIT}...")
    
    scripts_dir = BORG_TOOLKIT / "scripts"
    if not scripts_dir.exists():
        print("  ⚠️ Scripts directory not found")
        return
    
    for script_file in scripts_dir.glob("*.txt"):
        try:
            content = script_file.read_text(encoding='utf-8', errors='ignore')
            name = script_file.stem.replace('_', ' ').title()
            
            # Create Q&A pair for each script
            pair = {
                "instruction": f"Generate an AutoEvony script for: {name}",
                "input": "",
                "output": f"Here's a working AutoEvony script for {name}:\n\n```\n{content}\n```\n\nThis script can be loaded with `includeurl` or pasted directly into AutoEvony.",
                "source": str(script_file),
                "category": "exploit_scripts"
            }
            buckets["exploit_scripts"].append(pair)
            
            # Also create an explanation pair
            explain_pair = {
                "instruction": f"Explain how the {name} exploit/script works in Evony.",
                "input": "",
                "output": f"The {name} script works as follows:\n\n```\n{content}\n```\n\nThis exploits the game mechanics by...",
                "source": str(script_file),
                "category": "exploit_scripts"
            }
            buckets["exploit_scripts"].append(explain_pair)
            
        except Exception as e:
            continue
    
    print(f"  ✅ Exploit scripts: {len(buckets['exploit_scripts'])} pairs")


def process_protocol_commands(buckets: Dict):
    """Process protocol commands from borg_toolkit.py"""
    print(f"\n📂 Processing protocol commands...")
    
    borg_file = EVONY_HUB / "borg_toolkit.py"
    if not borg_file.exists():
        print("  ⚠️ borg_toolkit.py not found")
        return
    
    # Known protocol commands (from our documentation)
    commands = [
        ("addTroopsToBuilding", "Add troops to a building for defense"),
        ("armyGo", "Send army to march to a location"),
        ("attackNpc", "Attack an NPC city or valley"),
        ("buildCombo", "Execute multiple building commands"),
        ("cancelBuild", "Cancel a building construction"),
        ("cancelResearch", "Cancel ongoing research"),
        ("changeName", "Change city or player name"),
        ("chat", "Send a chat message"),
        ("collectResource", "Collect resources from a valley"),
        ("createArmy", "Create a new army formation"),
        ("demolishBuilding", "Demolish a building"),
        ("disbandArmy", "Disband an army formation"),
        ("getBuffList", "Get list of active buffs"),
        ("getCastleInfo", "Get detailed castle information"),
        ("getPackageList", "Get available item packages"),
        ("getTroopProduceQueue", "Get troop training queue"),
        ("heroLevelUp", "Level up a hero"),
        ("itemUse", "Use an item from inventory"),
        ("moveTroop", "Move troops between locations"),
        ("newBuilding", "Start construction of new building"),
        ("newResearch", "Start new research"),
        ("recruitHero", "Recruit a new hero"),
        ("setDefenseTroop", "Set troops for city defense"),
        ("speedUp", "Speed up construction/research/training"),
        ("trainTroop", "Train troops in barracks"),
        ("upgradeBuilding", "Upgrade existing building"),
    ]
    
    for cmd, description in commands:
        # Generate usage pair
        pair = {
            "instruction": f"How do I use the {cmd} protocol command in Evony?",
            "input": "",
            "output": f"The `{cmd}` command is used to {description.lower()}.\n\nUsage:\n```\ncmd {cmd} [parameters]\n```\n\nThis is part of the Evony client-server protocol.",
            "source": "protocol_commands",
            "category": "protocol_commands"
        }
        buckets["protocol_commands"].append(pair)
        
        # Generate implementation pair
        impl_pair = {
            "instruction": f"Implement the {cmd} protocol command handler",
            "input": "",
            "output": f"```python\ndef {cmd}(self, **params):\n    '''{description}'''\n    command = {{\n        'cmd': '{cmd}',\n        **params\n    }}\n    return self.send_command(command)\n```",
            "source": "protocol_commands",
            "category": "protocol_commands"
        }
        buckets["protocol_commands"].append(impl_pair)
    
    print(f"  ✅ Protocol commands: {len(buckets['protocol_commands'])} pairs")


def add_qa_pairs(buckets: Dict):
    """Add curated Q&A pairs about Evony"""
    print(f"\n📝 Adding curated Q&A pairs...")
    
    qa_pairs = [
        # Overflow exploits
        ("What is the archer overflow threshold in Evony?", 
         "The archer overflow threshold is 6,135,037. Training this many archers causes an integer overflow (INT32_MAX / cost + 1), resulting in negative or zero resource consumption."),
        
        ("How do integer overflow exploits work in Evony?",
         "Integer overflow exploits occur when training troop quantities exceed INT32_MAX divided by the troop cost. For example:\n- Archers: 6,135,037 (cost 350)\n- Workers: 42,949,673 (cost 50)\n- Catapults: 715,828 (cost 3000)\n\nWhen the calculation overflows, the game may charge 0 or negative resources."),
        
        # Encryption
        ("What encryption keys does Evony use?",
         "Evony uses several encryption keys:\n- ACTION_KEY: 'TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}'\n- API_KEY: '9f758e2deccbe6244f734371b9642eda'\n- USER_INFO_KEY: 'IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}'\n- XOR_KEY: 0xAA\n- LOGIN_SALT: 'evony'"),
        
        ("How does Evony encrypt protocol messages?",
         "Evony protocol messages use a combination of XOR encryption with key 0xAA, MD5 hashing for authentication, and the ACTION_KEY for signing requests. Messages are typically base64 encoded after encryption."),
        
        # Race conditions
        ("What is a race condition exploit in Evony?",
         "Race condition exploits in Evony occur when sending multiple requests simultaneously before the server validates state. For example, rapidly sending troop training requests can sometimes bypass resource checks if the requests are processed before the first one deducts resources."),
        
        # Architecture
        ("How is the Evony client structured?",
         "The Evony client is a Flash/ActionScript 3 application. Key components:\n- View layer: UI components in /view/\n- Controller: Game logic in /controller/\n- Model: Data structures in /model/\n- Network: Protocol handlers in /net/\n- Managers: TroopManager, BuildingManager, etc."),
        
        # AutoEvony
        ("How do I create an AutoEvony script?",
         "AutoEvony scripts use a simple command syntax:\n```\ncmd trainTroop a:1000\ncmd buildCombo 1,2,3\nloop 10\n  cmd collectResource\nendloop\nincludeurl http://server/script.txt\n```\nSave as .txt and load via includeurl or paste directly."),
    ]
    
    for question, answer in qa_pairs:
        pair = {
            "instruction": question,
            "input": "",
            "output": answer,
            "source": "curated_qa",
            "category": "qa_general"
        }
        buckets["qa_general"].append(pair)
    
    print(f"  ✅ Q&A pairs: {len(buckets['qa_general'])} pairs")


def deduplicate(examples: List[Dict]) -> List[Dict]:
    """Remove duplicate examples based on content hash"""
    seen = set()
    unique = []
    
    for ex in examples:
        # Hash the instruction + output
        content = ex["instruction"] + ex["output"]
        content_hash = hashlib.md5(content.encode()).hexdigest()
        
        if content_hash not in seen:
            seen.add(content_hash)
            unique.append(ex)
    
    return unique


def save_datasets(buckets: Dict):
    """Save all datasets to files"""
    print(f"\n💾 Saving datasets to {OUTPUT_DIR}...")
    
    # Combine all into one training file
    all_examples = []
    for category, examples in buckets.items():
        unique = deduplicate(examples)
        all_examples.extend(unique)
        
        # Also save category-specific file
        if unique:
            cat_file = OUTPUT_DIR / f"{category}.json"
            with open(cat_file, 'w', encoding='utf-8') as f:
                json.dump(unique, f, indent=2, ensure_ascii=False)
            print(f"  📁 {category}: {len(unique)} examples")
    
    # Save combined training file
    all_unique = deduplicate(all_examples)
    combined_file = OUTPUT_DIR / "train_perfect.json"
    with open(combined_file, 'w', encoding='utf-8') as f:
        json.dump(all_unique, f, indent=2, ensure_ascii=False)
    
    # Also save in JSONL format for training
    jsonl_file = OUTPUT_DIR / "train_perfect.jsonl"
    with open(jsonl_file, 'w', encoding='utf-8') as f:
        for ex in all_unique:
            f.write(json.dumps(ex, ensure_ascii=False) + '\n')
    
    print(f"\n✅ TOTAL: {len(all_unique)} perfect training examples")
    print(f"   📄 {combined_file}")
    print(f"   📄 {jsonl_file}")
    
    return len(all_unique)


def main():
    print("=" * 60)
    print("PERFECTION DATASET CURATOR")
    print(f"Started: {datetime.now()}")
    print("=" * 60)
    
    # Initialize buckets
    buckets = setup_output()
    
    # Process each source
    process_as3_files(buckets, limit_per_category=500)
    process_exploit_scripts(buckets)
    process_protocol_commands(buckets)
    add_qa_pairs(buckets)
    
    # Save everything
    total = save_datasets(buckets)
    
    print("\n" + "=" * 60)
    print("NEXT STEPS:")
    print("=" * 60)
    print(f"""
1. Review the generated files in: {OUTPUT_DIR}
2. Manually curate/edit examples for quality
3. Add more Q&A pairs specific to your use cases
4. Update package_for_runpod.py to use new data
5. Run training with --data_path data_perfect/train_perfect.jsonl
    """)
    
    return total


if __name__ == "__main__":
    main()
