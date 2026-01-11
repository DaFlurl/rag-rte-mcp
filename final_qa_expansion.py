#!/usr/bin/env python3
"""
Final Q&A Expansion - Push to 5000+ examples
"""

import json
from pathlib import Path
from datetime import datetime
import re

BASE_DIR = Path(__file__).parent
SOURCE_DIR = BASE_DIR / "Evony_Training_Dataset" / "source_code"
OUTPUT_DIR = BASE_DIR / "Evony_Training_Dataset" / "game_data"
TRAINING_DIR = BASE_DIR / "Evony_Training_Data"


def generate_from_protocol_commands():
    """Generate Q&A from all protocol commands JSON"""
    print("Generating from protocol commands...")
    examples = []
    
    cmd_file = OUTPUT_DIR / "all_protocol_commands.json"
    if cmd_file.exists():
        with open(cmd_file) as f:
            data = json.load(f)
        
        for cmd_name, cmd_data in data.get("commands", {}).items():
            params = cmd_data.get("parameters", [])
            cat = cmd_data.get("category", "unknown")
            
            # Different question formats
            examples.append({
                "instruction": f"Explain the {cmd_name} command",
                "input": "",
                "output": f"The {cmd_name} command is in the {cat} category. " +
                         (f"Parameters: {', '.join([p['name'] + ':' + p['type'] for p in params])}" if params else "No parameters required.")
            })
            
            if params:
                param_names = [p['name'] for p in params]
                examples.append({
                    "instruction": f"What parameters does {cmd_name} need?",
                    "input": "",
                    "output": f"Required parameters for {cmd_name}: {', '.join(param_names)}"
                })
    
    print(f"  Generated {len(examples)} from protocol commands")
    return examples


def generate_from_beans():
    """Generate Q&A from all beans JSON"""
    print("Generating from bean classes...")
    examples = []
    
    bean_file = OUTPUT_DIR / "all_bean_classes.json"
    if bean_file.exists():
        with open(bean_file) as f:
            data = json.load(f)
        
        for bean_name, bean_data in data.get("beans", {}).items():
            fields = bean_data.get("fields", [])
            
            # Field count question
            examples.append({
                "instruction": f"How many fields does {bean_name} have?",
                "input": "",
                "output": f"{bean_name} has {len(fields)} fields defined."
            })
            
            # List public fields
            public_fields = [f for f in fields if f.get("access") == "public"]
            if public_fields:
                examples.append({
                    "instruction": f"List the public fields of {bean_name}",
                    "input": "",
                    "output": f"Public fields: {', '.join([f['name'] for f in public_fields[:15]])}"
                })
    
    print(f"  Generated {len(examples)} from beans")
    return examples


def generate_from_constants():
    """Generate Q&A from constants"""
    print("Generating from constants...")
    examples = []
    
    const_file = OUTPUT_DIR / "all_extracted_constants.json"
    if const_file.exists():
        with open(const_file) as f:
            data = json.load(f)
        
        for class_name, const_data in data.get("constants", {}).items():
            # Int constants
            int_consts = const_data.get("int_constants", {})
            if int_consts:
                examples.append({
                    "instruction": f"What integer constants are in {class_name}?",
                    "input": "",
                    "output": f"Integer constants in {class_name}: " + 
                             ", ".join([f"{k}={v}" for k, v in list(int_consts.items())[:10]])
                })
            
            # String constants
            str_consts = const_data.get("string_constants", {})
            if str_consts:
                examples.append({
                    "instruction": f"What string constants are in {class_name}?",
                    "input": "",
                    "output": f"String constants in {class_name}: " +
                             ", ".join([f'{k}="{v}"' for k, v in list(str_consts.items())[:10]])
                })
    
    print(f"  Generated {len(examples)} from constants")
    return examples


def generate_from_handlers():
    """Generate Q&A from response handlers"""
    print("Generating from response handlers...")
    examples = []
    
    handler_file = OUTPUT_DIR / "response_handlers.json"
    if handler_file.exists():
        with open(handler_file) as f:
            data = json.load(f)
        
        for key, handler_data in data.get("handlers", {}).items():
            handler = handler_data.get("handler", "")
            const = handler_data.get("constant", "")
            
            examples.append({
                "instruction": f"What handles the {key} response?",
                "input": "",
                "output": f"The {key} response is handled by {handler if handler else 'unknown handler'}." +
                         (f" Constant: {const}" if const else "")
            })
    
    print(f"  Generated {len(examples)} from handlers")
    return examples


def generate_exploit_qa():
    """Generate exploit-related Q&A"""
    print("Generating exploit Q&A...")
    examples = []
    
    exploits = [
        ("integer overflow in troop training", 
         "Training troops with count > INT32_MAX / food_cost causes overflow. Example: 6,135,037 archers (cost 350 food each) overflows. Result: potentially free troops or negative cost.",
         "Validate count * cost < INT32_MAX before training. Server-side validation required."),
        
        ("duplicate error code -52",
         "Error code -52 is assigned to both ALLIANCE_NOT_FOUND and SUPPORT_NOT_ZERO. This is a bug in ErrorCode.as causing ambiguous error handling.",
         "Check command context to determine meaning. Alliance commands = not found, army commands = support present."),
        
        ("XOR encryption weakness",
         "Evony uses simple XOR with key 0xAA for packet obfuscation. This is trivially reversible and provides no real security.",
         "XOR is symmetric - encrypt and decrypt are same operation. Packet sniffing reveals all data."),
        
        ("signature bypass",
         "If ACTION_KEY is known, any command can be signed. MD5(command + params + ACTION_KEY) allows forging requests.",
         "Keep ACTION_KEY secret. Server should validate signatures match expected format."),
        
        ("race condition in army commands",
         "Sending multiple army commands rapidly can cause race conditions - troops may be duplicated or lost.",
         "Add delays between army commands. Server should implement proper locking."),
        
        ("food consumption bypass",
         "Troops in marching armies don't consume food. Keeping troops perpetually marching avoids food costs.",
         "Keep armies moving with transport missions. Recall before arrival, send again."),
    ]
    
    for name, desc, mitigation in exploits:
        examples.append({
            "instruction": f"What is the {name} exploit in Evony?",
            "input": "",
            "output": desc
        })
        examples.append({
            "instruction": f"How do I prevent {name}?",
            "input": "",
            "output": mitigation
        })
    
    print(f"  Generated {len(examples)} exploit examples")
    return examples


def generate_comparison_qa():
    """Generate comparison Q&A"""
    print("Generating comparison Q&A...")
    examples = []
    
    comparisons = [
        ("archer vs cavalry", "Archers have range advantage but cavalry closes fast. Archers win if protected, cavalry wins if they reach archers."),
        ("pikeman vs cavalry", "Pikemen are specifically anti-cavalry. They deal 3x damage to mounted units. Always use pikemen to counter cavalry."),
        ("swordsman vs warrior", "Swordsmen are tier 3 with better stats than tier 1 warriors. 5x the cost but more than 5x effective."),
        ("ballista vs catapult", "Ballistas are faster and cheaper, catapults deal more damage. Use ballistas for mobility, catapults for siege."),
        ("farm vs sawmill", "Both produce resources but farms more critical - troops eat food. Build more farms than other resource buildings."),
        ("cottage vs warehouse", "Cottages for population (troops, tax), warehouses for protection. Balance based on playstyle."),
        ("attack vs defense hero", "Attack heroes for offense, defense/politics for mayors. High attack hero leading army = more damage."),
        ("inside vs outside buildings", "Inside buildings provide capabilities (barracks, academy), outside produce resources. Need both."),
    ]
    
    for comp, answer in comparisons:
        examples.append({
            "instruction": f"In Evony, which is better: {comp}?",
            "input": "",
            "output": answer
        })
    
    print(f"  Generated {len(examples)} comparison examples")
    return examples


def generate_beginner_qa():
    """Generate beginner-focused Q&A"""
    print("Generating beginner Q&A...")
    examples = []
    
    beginner = [
        ("start playing Evony", "1. Complete tutorial quests. 2. Build Town Hall to level 4. 3. Build resource buildings. 4. Join an alliance. 5. Follow quest line for rewards."),
        ("protect myself as beginner", "Use beginner protection (first 7 days). Stay in alliance territory. Don't provoke stronger players. Keep resources low."),
        ("get more heroes", "Build Inn and Feasting Hall. Refresh Inn to see new heroes. Hire heroes with high attack stat for combat."),
        ("make gold in Evony", "Tax your population. Higher population = more gold. Keep loyalty above 80. Trade excess resources in marketplace."),
        ("expand to more cities", "Town Hall level determines max cities. Build colonizer armies to claim new city spots on map."),
        ("understand the map", "Map shows: cities, valleys, flats, NPCs, alliance territory. Green = allied, Red = enemy, Gray = neutral."),
        ("what to research first", "Military Science and Agriculture first. Then Construction for faster building. Balance military and economic."),
        ("build my first army", "Train archers as main damage. Add cavalry for speed. Include scouts for intel. Build in barracks."),
    ]
    
    for topic, answer in beginner:
        examples.append({
            "instruction": f"How do I {topic}?",
            "input": "",
            "output": answer
        })
        examples.append({
            "instruction": f"Tips for {topic}",
            "input": "",
            "output": answer
        })
    
    print(f"  Generated {len(examples)} beginner examples")
    return examples


def generate_advanced_qa():
    """Generate advanced Q&A"""
    print("Generating advanced Q&A...")
    examples = []
    
    advanced = [
        ("optimize troop composition", "Counter enemy composition. Archers as base, pikemen for cavalry defense, cavalry for flanking. Adjust ratio based on intel."),
        ("calculate perfect attack", "Scout target first. Match troop types to defenders. Bring 3x troops minimum. Use attack hero. Time for reinforcement gaps."),
        ("manage multiple accounts", "Use scripting for automation. Different cities serve different purposes. Coordinate attacks across accounts."),
        ("win alliance wars", "Coordinate timing. Target weak points. Cut reinforcement routes. Control valleys for resources. Use spies."),
        ("maximize prestige per hour", "Constant training, building, researching. Higher tier activities give more prestige. Never idle."),
        ("efficient NPC farming", "Script repetitive NPC attacks. Use minimum troops needed. Target NPCs matching your strength. Maximize resources/losses."),
        ("setup bot scripts", "Define goals: resources, troops, NPCs. Set conditions for each action. Add error handling. Test incrementally."),
        ("reverse engineer protocol", "Capture packets with proxy. Decode AMF3 format. Map commands to ResponseDispatcher. Test with modified requests."),
    ]
    
    for topic, answer in advanced:
        examples.append({
            "instruction": f"How do I {topic} in Evony?",
            "input": "",
            "output": answer
        })
    
    print(f"  Generated {len(examples)} advanced examples")
    return examples


def main():
    print("="*70)
    print("FINAL Q&A EXPANSION")
    print(f"Started: {datetime.now()}")
    print("="*70)
    
    all_examples = []
    
    all_examples.extend(generate_from_protocol_commands())
    all_examples.extend(generate_from_beans())
    all_examples.extend(generate_from_constants())
    all_examples.extend(generate_from_handlers())
    all_examples.extend(generate_exploit_qa())
    all_examples.extend(generate_comparison_qa())
    all_examples.extend(generate_beginner_qa())
    all_examples.extend(generate_advanced_qa())
    
    print(f"\nNew examples: {len(all_examples)}")
    
    # Combine with existing
    ultimate = TRAINING_DIR / "evony_ultimate_dataset.json"
    if ultimate.exists():
        with open(ultimate) as f:
            existing = json.load(f)
        
        seen = {ex.get("instruction", "") for ex in existing}
        new_unique = [ex for ex in all_examples if ex.get("instruction", "") not in seen]
        
        combined = existing + new_unique
        print(f"Added {len(new_unique)} unique")
        print(f"TOTAL: {len(combined)} examples")
        
        # Save final
        output = TRAINING_DIR / "evony_5k_dataset.json"
        with open(output, 'w') as f:
            json.dump(combined, f, indent=2)
        
        output_jsonl = TRAINING_DIR / "evony_5k_dataset.jsonl"
        with open(output_jsonl, 'w') as f:
            for ex in combined:
                f.write(json.dumps(ex) + "\n")
        
        print(f"Saved to {output}")
    
    print(f"Completed: {datetime.now()}")


if __name__ == "__main__":
    main()
