#!/usr/bin/env python3
"""
Extended Training Data Generator
================================
Generate 1000+ training examples from all extracted data
"""

import os
import json
import re
from pathlib import Path
from typing import Dict, List, Any
from datetime import datetime

BASE_DIR = Path(__file__).parent
SOURCE_DIR = BASE_DIR / "Evony_Training_Dataset" / "source_code"
KEYS_DIR = BASE_DIR / "Evony_Training_Dataset" / "keys"
SCRIPTS_DIR = BASE_DIR / "Evony_Training_Dataset" / "scripts"
OUTPUT_DIR = BASE_DIR / "Evony_Training_Dataset" / "game_data"
TRAINING_DIR = BASE_DIR / "Evony_Training_Data"

TRAINING_DIR.mkdir(parents=True, exist_ok=True)


def load_json(path):
    """Load JSON file safely"""
    if path.exists():
        with open(path) as f:
            return json.load(f)
    return {}


def generate_protocol_qa():
    """Generate Q&A for all protocol commands"""
    print("Generating protocol command Q&A...")
    examples = []
    
    data = load_json(OUTPUT_DIR / "all_protocol_commands.json")
    commands = data.get("commands", {})
    
    for cmd_name, cmd_data in commands.items():
        # Basic command question
        params = cmd_data.get("parameters", [])
        params_str = ", ".join([f"{p['name']}: {p['type']}" for p in params]) if params else "none"
        
        examples.append({
            "instruction": f"What is the Evony protocol command {cmd_name}?",
            "input": "",
            "output": f"The command '{cmd_name}' belongs to the '{cmd_data['category']}' category. Parameters: {params_str}. Source: {cmd_data.get('source_file', 'unknown')}"
        })
        
        # Parameter-specific questions
        if params:
            examples.append({
                "instruction": f"What parameters does {cmd_name} require?",
                "input": "",
                "output": f"The {cmd_name} command requires these parameters: " + "; ".join([f"{p['name']} ({p['type']}, {'required' if p.get('required') else 'optional'})" for p in params])
            })
        
        # Category questions
        examples.append({
            "instruction": f"How do I use the {cmd_name.split('.')[-1]} function in Evony?",
            "input": "",
            "output": f"To use {cmd_name.split('.')[-1]}, call the protocol command '{cmd_name}' with parameters: {params_str}"
        })
    
    print(f"  Generated {len(examples)} protocol examples")
    return examples


def generate_bean_qa():
    """Generate Q&A for all bean classes"""
    print("Generating bean class Q&A...")
    examples = []
    
    data = load_json(OUTPUT_DIR / "all_bean_classes.json")
    beans = data.get("beans", {})
    
    for bean_name, bean_data in beans.items():
        fields = bean_data.get("fields", [])
        
        # Overview question
        examples.append({
            "instruction": f"What is the {bean_name} class in Evony?",
            "input": "",
            "output": f"The {bean_name} class is a data structure with {len(fields)} fields. Source file: {bean_data.get('source_file', 'unknown')}"
        })
        
        # Fields question
        if fields:
            field_list = "; ".join([f"{f['name']}: {f['type']}" for f in fields[:15]])
            examples.append({
                "instruction": f"What fields does {bean_name} have?",
                "input": "",
                "output": f"The {bean_name} class has these fields: {field_list}"
            })
        
        # Specific field questions
        for field in fields[:5]:
            examples.append({
                "instruction": f"What is the {field['name']} field in {bean_name}?",
                "input": "",
                "output": f"The {field['name']} field in {bean_name} is of type {field['type']} ({field.get('access', 'public')} access)"
            })
        
        # Methods question
        methods = bean_data.get("methods", [])
        if methods:
            examples.append({
                "instruction": f"What methods does {bean_name} have?",
                "input": "",
                "output": f"The {bean_name} class has methods: {', '.join(methods[:10])}"
            })
    
    print(f"  Generated {len(examples)} bean examples")
    return examples


def generate_building_qa():
    """Generate Q&A for buildings"""
    print("Generating building Q&A...")
    examples = []
    
    data = load_json(OUTPUT_DIR / "building_requirements.json")
    buildings = data.get("buildings", {})
    
    for bname, bdata in buildings.items():
        # Basic info
        examples.append({
            "instruction": f"What is the {bdata['name']} building in Evony?",
            "input": "",
            "output": f"The {bdata['name']} (ID: {bdata['id']}) is a {bdata.get('position', 'inside')} building with max level {bdata['max_level']}. " + 
                     (f"It produces: {bdata.get('produces', 'N/A')}. " if bdata.get('produces') else "") +
                     (f"It trains: {', '.join(bdata.get('trains', []))}. " if bdata.get('trains') else "") +
                     (f"Effect: {bdata.get('effect', 'N/A')}" if bdata.get('effect') else "")
        })
        
        # Requirements
        reqs = bdata.get("requirements", {})
        if reqs:
            req_str = ", ".join([f"{k} level {v}" for k, v in reqs.items()])
            examples.append({
                "instruction": f"What are the requirements to build {bdata['name']}?",
                "input": "",
                "output": f"To build {bdata['name']}, you need: {req_str}"
            })
        
        # Level costs
        levels = bdata.get("levels", {})
        for level, costs in list(levels.items())[:3]:
            examples.append({
                "instruction": f"What does it cost to upgrade {bdata['name']} to level {level}?",
                "input": "",
                "output": f"Upgrading {bdata['name']} to level {level} costs: Food {costs['food']}, Wood {costs['wood']}, Stone {costs['stone']}, Iron {costs['iron']}. Time: {costs['time_seconds']} seconds"
            })
    
    print(f"  Generated {len(examples)} building examples")
    return examples


def generate_troop_qa():
    """Generate Q&A for troops"""
    print("Generating troop Q&A...")
    examples = []
    
    data = load_json(OUTPUT_DIR / "troop_formulas.json")
    troops = data.get("troops", {})
    
    for tname, tdata in troops.items():
        stats = tdata.get("stats", {})
        cost = tdata.get("cost", {})
        
        # Overview
        examples.append({
            "instruction": f"What is the {tdata['name']} unit in Evony?",
            "input": "",
            "output": f"The {tdata['name']} (ID: {tdata['id']}) is a tier {tdata['tier']} {tdata['type']} unit. Stats: Attack {stats['attack']}, Defense {stats['defense']}, Life {stats['life']}, Speed {stats['speed']}, Range {stats['range']}, Load {stats['load']}. Population: {tdata['population']}"
        })
        
        # Training
        examples.append({
            "instruction": f"How do I train {tdata['name']} in Evony?",
            "input": "",
            "output": f"To train {tdata['name']}, you need: {', '.join([f'{k} level {v}' for k, v in tdata.get('requirements', {}).items()])}. Training cost: Food {cost['food']}, Wood {cost['wood']}, Stone {cost['stone']}, Iron {cost['iron']}. Train time: {tdata['train_time']} seconds"
        })
        
        # Combat effectiveness
        strong = tdata.get("strong_vs", [])
        weak = tdata.get("weak_vs", [])
        examples.append({
            "instruction": f"What is {tdata['name']} effective against?",
            "input": "",
            "output": f"The {tdata['name']} is strong against: {', '.join(strong) if strong else 'nothing specifically'}. Weak against: {', '.join(weak) if weak else 'nothing specifically'}"
        })
        
        # Overflow exploit
        if tdata.get("overflow_threshold"):
            examples.append({
                "instruction": f"What is the integer overflow threshold for {tdata['name']}?",
                "input": "",
                "output": f"The integer overflow threshold for {tdata['name']} is {tdata['overflow_threshold']:,} units. Training more than this amount can cause integer overflow exploits."
            })
    
    print(f"  Generated {len(examples)} troop examples")
    return examples


def generate_research_qa():
    """Generate Q&A for research"""
    print("Generating research Q&A...")
    examples = []
    
    data = load_json(OUTPUT_DIR / "research_tree.json")
    research = data.get("research", {})
    
    for rname, rdata in research.items():
        # Overview
        examples.append({
            "instruction": f"What is the {rdata['name']} research in Evony?",
            "input": "",
            "output": f"The {rdata['name']} (ID: {rdata['id']}) is a {rdata['category']} research with max level {rdata['max_level']}. Effect: {rdata.get('effect', {})}"
        })
        
        # Requirements
        reqs = rdata.get("requirements", {})
        examples.append({
            "instruction": f"What do I need to research {rdata['name']}?",
            "input": "",
            "output": f"To research {rdata['name']}, you need: {', '.join([f'{k} level {v}' for k, v in reqs.items()])}"
        })
    
    print(f"  Generated {len(examples)} research examples")
    return examples


def generate_error_code_qa():
    """Generate Q&A for error codes"""
    print("Generating error code Q&A...")
    examples = []
    
    data = load_json(OUTPUT_DIR / "all_constants.json")
    error_codes = data.get("error_codes", {})
    
    for code, name in error_codes.items():
        examples.append({
            "instruction": f"What does Evony error code {code} mean?",
            "input": "",
            "output": f"Error code {code} is '{name}'. This error occurs when the server rejects a command due to this condition."
        })
        
        examples.append({
            "instruction": f"What is the error code for {name} in Evony?",
            "input": "",
            "output": f"The error code for {name} is {code}"
        })
    
    print(f"  Generated {len(examples)} error code examples")
    return examples


def generate_script_qa():
    """Generate Q&A for scripting commands"""
    print("Generating script command Q&A...")
    examples = []
    
    script_commands = {
        "set": "Set a variable value. Syntax: set <varname> <value>",
        "setarray": "Set an array variable. Syntax: setarray <arrname> <values...>",
        "setarr": "Shorthand for setarray. Syntax: setarr <arrname> <values...>",
        "label": "Define a label for goto. Syntax: label <labelname>",
        "goto": "Jump to a label. Syntax: goto <labelname>",
        "if": "Conditional execution. Syntax: if <condition> <command>",
        "loop": "Loop execution. Syntax: loop <count> <command>",
        "sleep": "Pause execution. Syntax: sleep <milliseconds>",
        "echo": "Print message. Syntax: echo <message>",
        "train": "Train troops. Syntax: train <type>:<count>",
        "attack": "Attack target. Syntax: attack <x> <y> [troops]",
        "scout": "Scout target. Syntax: scout <x> <y>",
        "reinforce": "Send reinforcements. Syntax: reinforce <x> <y> [troops]",
        "transport": "Transport resources. Syntax: transport <x> <y> <resources>",
        "include": "Include another script. Syntax: include <scriptname>",
        "build": "Build/upgrade building. Syntax: build <type> <position>",
        "research": "Start research. Syntax: research <techname>",
        "hirehero": "Hire a hero. Syntax: hirehero",
        "firehero": "Fire a hero. Syntax: firehero <heroid>",
    }
    
    for cmd, desc in script_commands.items():
        examples.append({
            "instruction": f"How do I use the {cmd} command in AutoEvony scripts?",
            "input": "",
            "output": desc
        })
        
        examples.append({
            "instruction": f"What does the {cmd} script command do?",
            "input": "",
            "output": f"The {cmd} command: {desc}"
        })
    
    # Variable substitution
    examples.append({
        "instruction": "How do I use variables in AutoEvony scripts?",
        "input": "",
        "output": "Use %varname% to substitute variable values. For arrays: %arrname[index]%. For city data: $cityname$property$ or use %cMaT% for current city troop data."
    })
    
    # Control flow
    examples.append({
        "instruction": "How do I create a loop in AutoEvony?",
        "input": "",
        "output": "Use 'loop <count> <command>' for simple loops, or use 'label start' with 'goto start' for infinite loops with conditions."
    })
    
    print(f"  Generated {len(examples)} script examples")
    return examples


def generate_encryption_qa():
    """Generate Q&A for encryption keys"""
    print("Generating encryption Q&A...")
    examples = []
    
    keys = {
        "ACTION_KEY": "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}",
        "API_KEY": "9f758e2deccbe6244f734371b9642eda",
        "USER_INFO_KEY": "IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}",
        "XOR_KEY": "0xAA (170 decimal)",
        "LOGIN_SALT": "evony",
    }
    
    for key_name, key_value in keys.items():
        examples.append({
            "instruction": f"What is the {key_name} in Evony?",
            "input": "",
            "output": f"The {key_name} is: {key_value}. This key is used for cryptographic operations in the Evony protocol."
        })
    
    examples.append({
        "instruction": "How does Evony signature generation work?",
        "input": "",
        "output": "Evony signatures are generated using MD5: signature = MD5(command + JSON.stringify(params) + ACTION_KEY)"
    })
    
    examples.append({
        "instruction": "How does Evony password hashing work?",
        "input": "",
        "output": "Evony passwords are hashed using MD5: hash = MD5(password + 'evony')"
    })
    
    examples.append({
        "instruction": "What is XOR encryption in Evony?",
        "input": "",
        "output": "Evony uses XOR encryption with key 0xAA (170) for packet obfuscation. To decrypt: decrypted = encrypted XOR 0xAA for each byte."
    })
    
    print(f"  Generated {len(examples)} encryption examples")
    return examples


def generate_combat_qa():
    """Generate Q&A for combat mechanics"""
    print("Generating combat Q&A...")
    examples = []
    
    data = load_json(OUTPUT_DIR / "combat_formulas.json")
    
    # Damage formula
    examples.append({
        "instruction": "How is damage calculated in Evony?",
        "input": "",
        "output": "Damage = attacker_attack * attacker_count * (1 - defender_defense / (defender_defense + 500)). Hero bonuses, tech bonuses, and terrain modifiers are applied."
    })
    
    # Terrain
    terrain = data.get("terrain_modifiers", {})
    for t, mods in terrain.items():
        examples.append({
            "instruction": f"What is the {t} terrain modifier in Evony combat?",
            "input": "",
            "output": f"The {t} terrain has attack modifier {mods.get('attack', 1.0)}x and defense modifier {mods.get('defense', 1.0)}x. " +
                     (f"Special: {', '.join([f'{k}: +{v*100}%' for k, v in mods.items() if k not in ['attack', 'defense']])}" if len(mods) > 2 else "")
        })
    
    # Wall defense
    examples.append({
        "instruction": "How does wall level affect defense in Evony?",
        "input": "",
        "output": "Wall defense bonus = 1 + (wall_level * 0.1). A level 10 wall provides 2.0x (100% bonus) to defense."
    })
    
    # Range advantage
    examples.append({
        "instruction": "How does range work in Evony combat?",
        "input": "",
        "output": "Units with higher range attack first in ranged rounds (3 rounds). After ranged rounds, melee combat begins. Archers have range 1200, catapults 1500."
    })
    
    print(f"  Generated {len(examples)} combat examples")
    return examples


def generate_response_handler_qa():
    """Generate Q&A for response handlers"""
    print("Generating response handler Q&A...")
    examples = []
    
    # Extract from ResponseDispatcher files
    resp_files = list(SOURCE_DIR.rglob("ResponseDispatcher*.as"))
    
    handlers = set()
    for file in resp_files[:3]:  # Process first 3
        try:
            content = file.read_text(encoding='utf-8', errors='ignore')
            # Find respMap entries
            matches = re.findall(r'respMap\["([^"]+)"\]', content)
            handlers.update(matches)
            
            # Find event constants
            consts = re.findall(r'public\s+static\s+const\s+(\w+)\s*:\s*String\s*=\s*"([^"]+)"', content)
            for const_name, const_value in consts:
                handlers.add(const_value)
        except:
            pass
    
    for handler in list(handlers)[:100]:
        parts = handler.split(".")
        if len(parts) == 2:
            category, action = parts
            examples.append({
                "instruction": f"What is the {handler} response in Evony?",
                "input": "",
                "output": f"The '{handler}' is a server response in the '{category}' category for the '{action}' action. The client's ResponseDispatcher handles this event."
            })
    
    print(f"  Generated {len(examples)} response handler examples")
    return examples


def main():
    print("="*70)
    print("EXTENDED TRAINING DATA GENERATION")
    print(f"Started: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("="*70)
    
    all_examples = []
    
    # Generate all Q&A categories
    all_examples.extend(generate_protocol_qa())
    all_examples.extend(generate_bean_qa())
    all_examples.extend(generate_building_qa())
    all_examples.extend(generate_troop_qa())
    all_examples.extend(generate_research_qa())
    all_examples.extend(generate_error_code_qa())
    all_examples.extend(generate_script_qa())
    all_examples.extend(generate_encryption_qa())
    all_examples.extend(generate_combat_qa())
    all_examples.extend(generate_response_handler_qa())
    
    print(f"\nTotal examples generated: {len(all_examples)}")
    
    # Save as Alpaca format
    output_alpaca = TRAINING_DIR / "evony_extended_alpaca.json"
    with open(output_alpaca, 'w') as f:
        json.dump(all_examples, f, indent=2)
    print(f"Saved Alpaca format to {output_alpaca}")
    
    # Save as JSONL
    output_jsonl = TRAINING_DIR / "evony_extended.jsonl"
    with open(output_jsonl, 'w') as f:
        for item in all_examples:
            f.write(json.dumps(item) + "\n")
    print(f"Saved JSONL to {output_jsonl}")
    
    # Save combined with previous data
    existing_file = TRAINING_DIR / "evony_training_alpaca.json"
    if existing_file.exists():
        with open(existing_file) as f:
            existing = json.load(f)
        combined = existing + all_examples
        
        output_combined = TRAINING_DIR / "evony_complete_training.json"
        with open(output_combined, 'w') as f:
            json.dump(combined, f, indent=2)
        print(f"Saved combined ({len(combined)} examples) to {output_combined}")
    
    print(f"\nCompleted: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("="*70)


if __name__ == "__main__":
    main()
