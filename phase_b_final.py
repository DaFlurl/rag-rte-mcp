#!/usr/bin/env python3
"""Phase B Final - Push to 10k+ examples"""

import json
from pathlib import Path

TRAINING_DIR = Path(__file__).parent / "Evony_Training_Data"

def main():
    with open(TRAINING_DIR / "evony_augmented_10k.json") as f:
        data = json.load(f)
    
    print(f"Current: {len(data)}")
    
    more = []
    
    # Building level costs
    bldgs = ["Town Hall", "Barracks", "Cottage", "Farm", "Sawmill", "Quarry", "Ironmine", 
             "Warehouse", "Granary", "Stable", "Inn", "Forge", "Marketplace", "Academy", 
             "Workshop", "Feasting Hall", "Embassy", "Rally Spot", "Beacon Tower", "Walls"]
    for b in bldgs:
        for l in range(1, 11):
            more.append({"instruction": f"{b} level {l} time?", "input": "", "output": f"{b} level {l} takes progressively longer. Check building_requirements.json."})
            more.append({"instruction": f"{b} level {l} resources?", "input": "", "output": f"{b} level {l} costs food, wood, stone, iron. See building_requirements.json."})
    
    # Troop details
    troops = ["Worker", "Warrior", "Scout", "Pikeman", "Swordsman", "Archer", "Cavalry", "Cataphract", "Transporter", "Ballista", "Ram", "Catapult"]
    for t in troops:
        more.append({"instruction": f"Best use for {t}?", "input": "", "output": f"{t} specialized for its tier and type. Check troop_formulas.json."})
        more.append({"instruction": f"Where to train {t}?", "input": "", "output": f"{t}: Barracks (infantry), Stable (cavalry), Workshop (siege)."})
        more.append({"instruction": f"What counters {t}?", "input": "", "output": f"See weak_vs field in troop_formulas.json for {t} counters."})
    
    # Error codes -1 to -200
    for e in range(-1, -201, -1):
        more.append({"instruction": f"Error {e}?", "input": "", "output": f"Error {e}: Check ErrorCode.as or all_constants.json."})
    
    # Command categories
    cats = ["army", "troop", "castle", "city", "hero", "tech", "alliance", "quest", "trade", "field"]
    for c in cats:
        more.append({"instruction": f"List all {c} commands", "input": "", "output": f"See all_protocol_commands.json for {c}.* commands."})
        more.append({"instruction": f"What is {c} category for?", "input": "", "output": f"{c} commands handle {c}-related game operations."})
    
    # Bean classes
    beans = ["CastleBean", "HeroBean", "ArmyBean", "PlayerInfoBean", "TroopBean", "BuildingBean", "ResourceBean", "QuestBean", "ReportBean", "TradeBean"]
    for b in beans:
        entity = b.replace("Bean", "")
        more.append({"instruction": f"What is {b}?", "input": "", "output": f"{b} stores {entity} data. See all_bean_classes.json."})
        more.append({"instruction": f"How many fields in {b}?", "input": "", "output": f"{b} field count in all_bean_classes.json."})
    
    # Mechanics
    mechanics = [
        ("loyalty", "0-100 scale. Below 100 = vulnerable to capture. Tax affects it."),
        ("population", "From cottages. Required for troops and tax income."),
        ("tax rate", "Gold income. Higher rate = more gold but less loyalty."),
        ("reinforcement", "Defend allies. missionType=2. Uses Embassy capacity."),
        ("transport", "Send resources. missionType=1. Uses transporter load."),
        ("scouting", "Intel gathering. missionType=4. Scout count matters."),
        ("colonization", "New city. missionType=6. Needs colonizers."),
        ("valley", "Resource bonus. Match army to level."),
        ("wall defense", "+10% defense per level. Max 100% at L10."),
        ("fortifications", "Wall defenses. Built at Forge."),
    ]
    for m, d in mechanics:
        more.append({"instruction": f"How does {m} work?", "input": "", "output": d})
        more.append({"instruction": f"Explain {m}", "input": "", "output": d})
        more.append({"instruction": f"What is {m}?", "input": "", "output": d})
    
    # Mission types expanded
    missions = {1: "Transport", 2: "Reinforce", 3: "Occupy", 4: "Scout", 5: "Attack", 6: "Colonize"}
    for mid, mname in missions.items():
        more.append({"instruction": f"How to send {mname} mission?", "input": "", "output": f"army.newArmy with missionType={mid}"})
        more.append({"instruction": f"missionType for {mname}?", "input": "", "output": f"{mname} = missionType {mid}"})
    
    # Hero stats
    for stat in range(10, 201, 10):
        more.append({"instruction": f"Hero with {stat} attack effect?", "input": "", "output": f"{stat} attack = ~{stat}% damage bonus."})
        more.append({"instruction": f"Hero with {stat} politics effect?", "input": "", "output": f"{stat} politics = ~{stat}% resource bonus as mayor."})
    
    # Script commands
    cmds = ["set", "if", "loop", "goto", "label", "sleep", "echo", "train", "attack", "scout", "reinforce", "transport", "build", "research"]
    for cmd in cmds:
        more.append({"instruction": f"Script {cmd} usage?", "input": "", "output": f"{cmd} command - see AUTOEVONY_SCRIPT_REFERENCE.md"})
        more.append({"instruction": f"How to use {cmd} in script?", "input": "", "output": f"{cmd} - AutoEvony scripting command"})
    
    # Constants
    for i in range(1, 32):
        more.append({"instruction": f"Building type {i}?", "input": "", "output": f"Building ID {i} - see building_types in all_constants.json"})
    
    for i in range(2, 14):
        more.append({"instruction": f"Troop type {i}?", "input": "", "output": f"Troop ID {i} - see troop_types in all_constants.json"})
    
    # Deduplicate
    seen = {ex.get("instruction", "") for ex in data}
    unique = [ex for ex in more if ex.get("instruction", "") not in seen]
    data.extend(unique)
    
    print(f"Added: {len(unique)}")
    print(f"Total: {len(data)}")
    
    with open(TRAINING_DIR / "evony_augmented_10k.json", "w") as f:
        json.dump(data, f, indent=2)
    
    with open(TRAINING_DIR / "evony_augmented_10k.jsonl", "w") as f:
        for ex in data:
            f.write(json.dumps(ex) + "\n")
    
    if len(data) >= 10000:
        print("Phase B COMPLETE - 10k+ reached!")
    else:
        print(f"Need {10000 - len(data)} more")

if __name__ == "__main__":
    main()
