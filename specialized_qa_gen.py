#!/usr/bin/env python3
"""
Specialized Q&A Generator - Target 5000+ examples
"""

import json
from pathlib import Path
from datetime import datetime

TRAINING_DIR = Path(__file__).parent / "Evony_Training_Data"


def generate_combat_scenarios():
    """Generate combat scenario Q&A"""
    examples = []
    
    scenarios = [
        ("attack NPC level 1", "Use 2k archers with any attack hero. Send scout first, then attack."),
        ("attack NPC level 3", "Use 10k archers with 50+ attack hero. Expect minimal losses."),
        ("attack NPC level 5", "Use 50k archers, 5k cavalry with 80+ attack hero. Scout first."),
        ("attack NPC level 7", "Use 100k+ archers, 10k cavalry, 5k cataphracts. Need strong hero 100+ attack."),
        ("attack NPC level 10", "Need 500k+ archers, 50k cavalry, 20k cataphracts, siege. Elite hero required."),
        ("defend city", "Build walls to level 10, max fortifications, garrison archers. Mayor with high politics."),
        ("scout enemy", "Send scouts equal to enemy beacon tower level * 1000. More scouts = more detail."),
        ("reinforce ally", "Use cavalry for fast reinforcement, archers for combat power. Check embassy capacity."),
        ("capture valley", "Match valley level with army strength. Level 1-3: infantry ok. Level 5+: archers needed."),
        ("farm resources", "Attack flat/forest NPCs for resources. Lower level = faster clear. Use transporters."),
    ]
    
    for scenario, strategy in scenarios:
        examples.append({
            "instruction": f"How do I {scenario} in Evony?",
            "input": "",
            "output": strategy
        })
        examples.append({
            "instruction": f"What's the best strategy to {scenario}?",
            "input": "",
            "output": strategy
        })
    
    return examples


def generate_optimization_qa():
    """Generate optimization Q&A"""
    examples = []
    
    optimizations = [
        ("maximize resource production", "Build all 40 outside slots with resource buildings. Research Agriculture/Lumbering/Masonry/Mining. Assign high politics hero as mayor. Capture valleys for bonuses."),
        ("level up hero fast", "Attack NPCs repeatedly. Higher NPC = more XP. Use medal boxes for instant XP. Research medicine to heal faster."),
        ("train troops efficiently", "Build multiple barracks. Queue training. Use speedup items. Higher barracks = faster training."),
        ("build city fast", "Focus resources on construction. Research Construction tech. Use build speedups. Upgrade Town Hall priority."),
        ("grow prestige", "Train troops, upgrade buildings, research tech, capture valleys. Each action adds prestige."),
        ("increase population", "Build more cottages. Keep loyalty high (80+). Lower tax rate temporarily. Comfort population."),
        ("protect resources", "Upgrade warehouse. Keep resources below protection cap. Spend excess before logout. Use resource boxes."),
        ("manage multiple cities", "Script automation for all cities. Set different roles: resource city, troop city, research city."),
    ]
    
    for topic, advice in optimizations:
        examples.append({
            "instruction": f"How do I {topic} in Evony?",
            "input": "",
            "output": advice
        })
    
    return examples


def generate_bean_field_qa():
    """Generate detailed bean field Q&A"""
    examples = []
    
    bean_fields = {
        "CastleBean": [
            ("id", "int", "Unique castle identifier"),
            ("name", "String", "Castle name set by player"),
            ("fieldId", "int", "Map field ID where castle is located"),
            ("status", "int", "Castle status (0=normal, 1=burning, etc)"),
            ("resource", "CastleResourceBean", "Current resource amounts"),
            ("buildings", "Array", "List of all buildings in castle"),
            ("fortification", "FortificationsBean", "Wall defenses"),
            ("troops", "Object", "In-city troops by type"),
        ],
        "HeroBean": [
            ("id", "int", "Unique hero identifier"),
            ("name", "String", "Hero name"),
            ("level", "int", "Current level"),
            ("experience", "Number", "Current XP"),
            ("attack", "int", "Attack stat (combat damage)"),
            ("defense", "int", "Defense stat (damage reduction)"),
            ("politics", "int", "Politics stat (resource production)"),
            ("intelligence", "int", "Intelligence stat (stratagems)"),
            ("power", "int", "Calculated power rating"),
            ("status", "int", "0=free, 1=mayor, 2=defending, 3=marching"),
        ],
        "ArmyBean": [
            ("id", "int", "Unique army identifier"),
            ("startFieldId", "int", "Origin field ID"),
            ("targetFieldId", "int", "Destination field ID"),
            ("startTime", "Number", "March start timestamp"),
            ("endTime", "Number", "Expected arrival timestamp"),
            ("missionType", "int", "1=transport, 2=reinforce, 5=attack"),
            ("hero", "HeroBean", "Leading hero"),
            ("troops", "Object", "Troops by type"),
            ("direction", "int", "0=outbound, 1=returning"),
        ],
    }
    
    for bean, fields in bean_fields.items():
        for fname, ftype, fdesc in fields:
            examples.append({
                "instruction": f"What is {bean}.{fname} in Evony?",
                "input": "",
                "output": f"The {fname} field in {bean} is type {ftype}. It stores: {fdesc}"
            })
    
    return examples


def generate_mission_type_qa():
    """Generate mission type Q&A"""
    examples = []
    
    missions = {
        1: ("TRANSPORT", "Send resources to another city or ally"),
        2: ("REINFORCE", "Send troops to defend another location"),
        3: ("OCCUPY", "Capture and hold a valley or flat"),
        4: ("SCOUT", "Gather intelligence on target"),
        5: ("ATTACK", "Attack to destroy troops and plunder"),
        6: ("COLONIZE", "Establish a new city"),
    }
    
    for mid, (name, desc) in missions.items():
        examples.append({
            "instruction": f"What is mission type {mid} in Evony?",
            "input": "",
            "output": f"Mission type {mid} is {name}: {desc}"
        })
        examples.append({
            "instruction": f"How do I send a {name.lower()} mission in Evony?",
            "input": "",
            "output": f"Use army.newArmy with missionType={mid}. This will {desc.lower()}."
        })
    
    return examples


def generate_position_qa():
    """Generate building position Q&A"""
    examples = []
    
    examples.append({
        "instruction": "What are the building position IDs in Evony?",
        "input": "",
        "output": "Position IDs: 1000-1039 inside city, 2000-2039 outside fields, -1 for wall. Town Hall is always position 1000."
    })
    
    examples.append({
        "instruction": "How many buildings can I have inside the city?",
        "input": "",
        "output": "40 building slots inside (positions 1000-1039). Town Hall at 1000 is required. Other slots can be any building type."
    })
    
    examples.append({
        "instruction": "How many resource buildings can I have?",
        "input": "",
        "output": "40 outside slots (positions 2000-2039) for resource buildings: Farms, Sawmills, Quarries, Ironmines."
    })
    
    return examples


def generate_timing_qa():
    """Generate timing and calculation Q&A"""
    examples = []
    
    timing = [
        ("calculate travel time", "time = distance / speed. Distance = sqrt((x2-x1)² + (y2-y1)²). Speed = slowest unit in army."),
        ("calculate building time", "Base time * (1 - construction_bonus). Construction research reduces time 5% per level."),
        ("calculate training time", "base_time * num_troops / (1 + tech_bonus). Each troop has base training time."),
        ("calculate resource production", "base_rate * building_level * (1 + tech_bonus) * (1 + valley_bonus) * (1 + hero_politics/100)"),
        ("calculate damage", "attack * count * (1 - defense/(defense+500)) * hero_bonus * tech_bonus * terrain"),
        ("calculate food consumption", "troops_count * food_per_troop_per_hour. Each troop type has hourly food cost."),
    ]
    
    for topic, formula in timing:
        examples.append({
            "instruction": f"How do I {topic} in Evony?",
            "input": "",
            "output": formula
        })
    
    return examples


def generate_item_qa():
    """Generate item Q&A"""
    examples = []
    
    items = [
        ("speed up items", "Reduce timers: 5min, 15min, 30min, 1hr, 8hr. Use with item.useItem on building/research/army."),
        ("resource boxes", "Instant resources when opened. Food/Wood/Stone/Iron packs in various sizes."),
        ("hero medals", "Used to level up heroes. Bronze/Silver/Gold/Platinum medals give increasing XP."),
        ("teleport items", "Move city to new location. Random teleport (anywhere) or targeted teleport (specific coords)."),
        ("shield items", "Protect city from attack for duration. 8hr/24hr/3day shields available."),
        ("buff items", "Temporary bonuses: attack boost, defense boost, production boost. Duration varies."),
    ]
    
    for item_type, desc in items:
        examples.append({
            "instruction": f"What are {item_type} in Evony?",
            "input": "",
            "output": desc
        })
    
    return examples


def generate_alliance_qa():
    """Generate alliance Q&A"""
    examples = []
    
    alliance_info = [
        ("create alliance", "Use alliance.createAlliance with name and intro. Requires Embassy building."),
        ("join alliance", "Browse alliances with alliance.getAllianceList. Apply with alliance.applyJoinAlliance."),
        ("leave alliance", "Use alliance.exitAlliance. Cannot leave if you're the only leader."),
        ("promote member", "Leaders use alliance.setAllianceRank. Ranks: Leader, Vice Leader, Presbyter, Officer, Member."),
        ("kick member", "Officers+ can use alliance.kickOutMemberfromAlliance to remove members."),
        ("send alliance mail", "Use alliance.messagesForAllianceMember to message all members."),
        ("alliance war", "Coordinate attacks via alliance chat. Share targets, timing, troop compositions."),
    ]
    
    for topic, info in alliance_info:
        examples.append({
            "instruction": f"How do I {topic} in Evony?",
            "input": "",
            "output": info
        })
    
    return examples


def generate_fortification_qa():
    """Generate fortification Q&A"""
    examples = []
    
    forts = {
        "Trap": {"id": 1, "effect": "3x damage vs infantry, 1x vs cavalry", "cost": 100},
        "Abatis": {"id": 2, "effect": "1x damage vs infantry, 3x vs cavalry", "cost": 200},
        "Archer Tower": {"id": 3, "effect": "2x damage vs all types, ranged attack", "cost": 500},
        "Rolling Log": {"id": 4, "effect": "2x vs infantry, 1x vs cavalry, area damage", "cost": 300},
        "Trebuchet": {"id": 5, "effect": "3x vs all, strongest fortification", "cost": 1000},
    }
    
    for name, data in forts.items():
        examples.append({
            "instruction": f"What is {name} fortification in Evony?",
            "input": "",
            "output": f"{name} (ID {data['id']}): {data['effect']}. Food cost: {data['cost']}. Built at Forge."
        })
    
    examples.append({
        "instruction": "What's the best fortification setup in Evony?",
        "input": "",
        "output": "Mix all types: Traps for infantry waves, Abatis for cavalry, Archer Towers for sustained damage, Trebuchets for raw power. Prioritize based on expected attackers."
    })
    
    return examples


def generate_variable_qa():
    """Generate script variable Q&A"""
    examples = []
    
    variables = [
        ("%varname%", "Simple variable substitution"),
        ("%array[index]%", "Array element access"),
        ("$c.property$", "Current city property access"),
        ("$cityname$property$", "Specific city property access"),
        ("%cMaT%", "Current city troop data macro"),
        ("%mcaC%", "Multi-city array current macro"),
        ("{expression}", "Mathematical expression evaluation"),
        ("{{nested}}", "Nested expression evaluation"),
    ]
    
    for var, desc in variables:
        examples.append({
            "instruction": f"What does {var} mean in AutoEvony scripts?",
            "input": "",
            "output": f"{var} is used for {desc}. Example: set result {var}"
        })
    
    return examples


def main():
    print("="*70)
    print("SPECIALIZED Q&A GENERATION")
    print(f"Started: {datetime.now()}")
    print("="*70)
    
    all_examples = []
    
    generators = [
        ("combat scenarios", generate_combat_scenarios),
        ("optimization", generate_optimization_qa),
        ("bean fields", generate_bean_field_qa),
        ("mission types", generate_mission_type_qa),
        ("positions", generate_position_qa),
        ("timing", generate_timing_qa),
        ("items", generate_item_qa),
        ("alliance", generate_alliance_qa),
        ("fortifications", generate_fortification_qa),
        ("variables", generate_variable_qa),
    ]
    
    for name, gen_func in generators:
        examples = gen_func()
        print(f"  {name}: {len(examples)} examples")
        all_examples.extend(examples)
    
    print(f"\nNew examples: {len(all_examples)}")
    
    # Combine with existing
    master = TRAINING_DIR / "evony_master_dataset.json"
    if master.exists():
        with open(master) as f:
            existing = json.load(f)
        
        seen = {ex.get("instruction", "") for ex in existing}
        new_unique = [ex for ex in all_examples if ex.get("instruction", "") not in seen]
        
        combined = existing + new_unique
        print(f"Added {len(new_unique)} unique, total: {len(combined)}")
        
        # Save final
        output = TRAINING_DIR / "evony_ultimate_dataset.json"
        with open(output, 'w') as f:
            json.dump(combined, f, indent=2)
        
        output_jsonl = TRAINING_DIR / "evony_ultimate_dataset.jsonl"
        with open(output_jsonl, 'w') as f:
            for ex in combined:
                f.write(json.dumps(ex) + "\n")
        
        print(f"Saved to {output}")
    
    print(f"Completed: {datetime.now()}")


if __name__ == "__main__":
    main()
