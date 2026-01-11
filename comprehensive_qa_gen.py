#!/usr/bin/env python3
"""
Comprehensive Q&A Generator
============================
Generate 500+ additional high-quality training examples
"""

import json
from pathlib import Path
from datetime import datetime

BASE_DIR = Path(__file__).parent
OUTPUT_DIR = BASE_DIR / "Evony_Training_Dataset" / "game_data"
TRAINING_DIR = BASE_DIR / "Evony_Training_Data"


def generate_all_building_qa():
    """Generate Q&A for every building type"""
    print("Generating building Q&A...")
    examples = []
    
    buildings = {
        "Town Hall": {"id": 1, "effect": "Unlocks other buildings, determines max cities", "position": "inside", "unlocks": "Most buildings require Town Hall level"},
        "Barracks": {"id": 2, "effect": "Train infantry troops: Worker, Warrior, Scout, Pikeman, Swordsman", "position": "inside", "unlocks": "Higher levels unlock more troop types"},
        "Cottage": {"id": 3, "effect": "Increases population capacity", "position": "inside", "unlocks": "Population needed for troops and tax"},
        "Sawmill": {"id": 4, "effect": "Produces wood resource", "position": "outside", "unlocks": "Wood for building and training"},
        "Quarry": {"id": 5, "effect": "Produces stone resource", "position": "outside", "unlocks": "Stone for advanced buildings"},
        "Ironmine": {"id": 6, "effect": "Produces iron resource", "position": "outside", "unlocks": "Iron for advanced troops"},
        "Farm": {"id": 7, "effect": "Produces food resource", "position": "outside", "unlocks": "Food for troops (upkeep)"},
        "Warehouse": {"id": 8, "effect": "Protects resources from plunder", "position": "inside", "unlocks": "90% of capacity is protected"},
        "Granary": {"id": 9, "effect": "Increases food storage capacity", "position": "inside", "unlocks": "Store more food"},
        "Stable": {"id": 20, "effect": "Train cavalry: Cavalry, Cataphract", "position": "inside", "unlocks": "Requires Barracks level 4"},
        "Inn": {"id": 21, "effect": "Recruit heroes", "position": "inside", "unlocks": "Refresh to see new heroes"},
        "Forge": {"id": 22, "effect": "Craft and enhance equipment, build fortifications", "position": "inside", "unlocks": "Equipment for heroes"},
        "Marketplace": {"id": 23, "effect": "Trade resources with other players", "position": "inside", "unlocks": "Buy/sell resources"},
        "Relief Station": {"id": 24, "effect": "Increases transport speed", "position": "inside", "unlocks": "Faster resource transport"},
        "Academy": {"id": 25, "effect": "Research technologies", "position": "inside", "unlocks": "Tech bonuses for all aspects"},
        "Workshop": {"id": 26, "effect": "Train siege: Transporter, Ballista, Ram, Catapult", "position": "inside", "unlocks": "Requires Barracks level 4"},
        "Feasting Hall": {"id": 27, "effect": "Increases hero capacity", "position": "inside", "unlocks": "Max heroes = level"},
        "Embassy": {"id": 28, "effect": "Allows alliance reinforcements", "position": "inside", "unlocks": "Receive allied troops"},
        "Rally Spot": {"id": 29, "effect": "Controls army size and concurrent marches", "position": "inside", "unlocks": "Level determines max armies"},
        "Beacon Tower": {"id": 30, "effect": "Provides warning of incoming attacks", "position": "inside", "unlocks": "Earlier warnings with level"},
        "Walls": {"id": 31, "effect": "Defense bonus and fortification placement", "position": "wall", "unlocks": "10% defense per level"},
    }
    
    for name, data in buildings.items():
        examples.append({
            "instruction": f"What does the {name} do in Evony?",
            "input": "",
            "output": f"The {name} (building ID {data['id']}) is a {data['position']} building. Effect: {data['effect']}. {data['unlocks']}."
        })
        
        examples.append({
            "instruction": f"Where is the {name} located in Evony?",
            "input": "",
            "output": f"The {name} is located {data['position']} the city walls. Building ID: {data['id']}."
        })
    
    print(f"  Generated {len(examples)} building examples")
    return examples


def generate_all_troop_qa():
    """Generate detailed Q&A for every troop type"""
    print("Generating troop Q&A...")
    examples = []
    
    troops = {
        "Worker": {"id": 2, "tier": 1, "type": "Support", "attack": 5, "defense": 5, "life": 50, "speed": 180, "load": 200, "cost": 50, "building": "Barracks 1"},
        "Warrior": {"id": 3, "tier": 1, "type": "Infantry", "attack": 10, "defense": 10, "life": 100, "speed": 200, "load": 20, "cost": 100, "building": "Barracks 1"},
        "Scout": {"id": 4, "tier": 1, "type": "Cavalry", "attack": 5, "defense": 5, "life": 50, "speed": 3000, "load": 5, "cost": 150, "building": "Barracks 2"},
        "Pikeman": {"id": 5, "tier": 2, "type": "Infantry", "attack": 25, "defense": 30, "life": 150, "speed": 200, "load": 30, "cost": 200, "building": "Barracks 3"},
        "Swordsman": {"id": 6, "tier": 3, "type": "Infantry", "attack": 50, "defense": 50, "life": 250, "speed": 220, "load": 35, "cost": 250, "building": "Barracks 5"},
        "Archer": {"id": 7, "tier": 2, "type": "Ranged", "attack": 35, "defense": 15, "life": 100, "speed": 250, "load": 25, "cost": 350, "building": "Barracks 4 + Archery 1"},
        "Cavalry": {"id": 8, "tier": 3, "type": "Cavalry", "attack": 75, "defense": 50, "life": 350, "speed": 1000, "load": 50, "cost": 500, "building": "Stable 2"},
        "Cataphract": {"id": 9, "tier": 4, "type": "Cavalry", "attack": 100, "defense": 100, "life": 500, "speed": 750, "load": 70, "cost": 700, "building": "Stable 5"},
        "Transporter": {"id": 10, "tier": 1, "type": "Support", "attack": 5, "defense": 5, "life": 50, "speed": 150, "load": 5000, "cost": 500, "building": "Workshop 1"},
        "Ballista": {"id": 11, "tier": 3, "type": "Siege", "attack": 200, "defense": 50, "life": 600, "speed": 100, "load": 100, "cost": 2500, "building": "Workshop 4"},
        "Battering Ram": {"id": 12, "tier": 3, "type": "Siege", "attack": 150, "defense": 100, "life": 800, "speed": 120, "load": 150, "cost": 5000, "building": "Workshop 5"},
        "Catapult": {"id": 13, "tier": 4, "type": "Siege", "attack": 450, "defense": 30, "life": 400, "speed": 80, "load": 200, "cost": 30000, "building": "Workshop 9"},
    }
    
    for name, data in troops.items():
        examples.append({
            "instruction": f"What are the stats of {name} in Evony?",
            "input": "",
            "output": f"{name} (ID {data['id']}, Tier {data['tier']} {data['type']}): Attack {data['attack']}, Defense {data['defense']}, Life {data['life']}, Speed {data['speed']}, Load {data['load']}. Food cost: {data['cost']}. Requires: {data['building']}."
        })
        
        examples.append({
            "instruction": f"How do I train {name} in Evony?",
            "input": "",
            "output": f"To train {name}, you need {data['building']}. Each {name} costs {data['cost']} food. Use troop.produceTroop with troopType={data['id']}."
        })
        
        examples.append({
            "instruction": f"What type of unit is {name}?",
            "input": "",
            "output": f"{name} is a Tier {data['tier']} {data['type']} unit. Speed: {data['speed']}, Load capacity: {data['load']}."
        })
    
    print(f"  Generated {len(examples)} troop examples")
    return examples


def generate_all_research_qa():
    """Generate Q&A for all research techs"""
    print("Generating research Q&A...")
    examples = []
    
    research = {
        "Military Science": {"category": "Military", "effect": "+2% troop attack per level", "requirements": "Academy 1"},
        "Military Tradition": {"category": "Military", "effect": "+2% troop defense per level", "requirements": "Academy 1, Military Science 1"},
        "Iron Working": {"category": "Military", "effect": "+2% troop life per level", "requirements": "Academy 2"},
        "Archery": {"category": "Military", "effect": "+5% archer attack per level", "requirements": "Academy 3, Military Science 2"},
        "Horseback Riding": {"category": "Military", "effect": "+5% cavalry speed per level", "requirements": "Academy 4, Military Science 3"},
        "Compass": {"category": "Military", "effect": "+3% march speed per level", "requirements": "Academy 2"},
        "Medicine": {"category": "Military", "effect": "+5% wounded recovery per level", "requirements": "Academy 4"},
        "Construction": {"category": "Military", "effect": "+5% construction speed per level", "requirements": "Academy 2"},
        "Engineering": {"category": "Military", "effect": "Unlocks and improves siege units", "requirements": "Academy 5"},
        "Logistics": {"category": "Military", "effect": "+10% army load capacity per level", "requirements": "Academy 3"},
        "Agriculture": {"category": "Economic", "effect": "+5% food production per level", "requirements": "Academy 1"},
        "Lumbering": {"category": "Economic", "effect": "+5% wood production per level", "requirements": "Academy 1"},
        "Masonry": {"category": "Economic", "effect": "+5% stone production per level", "requirements": "Academy 2"},
        "Mining": {"category": "Economic", "effect": "+5% iron production per level", "requirements": "Academy 3"},
        "Metal Casting": {"category": "Economic", "effect": "+5% equipment quality per level", "requirements": "Academy 4"},
        "Informatics": {"category": "Economic", "effect": "+5% scout effectiveness per level", "requirements": "Academy 2"},
        "Stockpile": {"category": "Economic", "effect": "+10% warehouse capacity per level", "requirements": "Academy 3"},
        "Privateering": {"category": "Economic", "effect": "+5% plunder amount per level", "requirements": "Academy 4"},
    }
    
    for name, data in research.items():
        examples.append({
            "instruction": f"What does {name} research do in Evony?",
            "input": "",
            "output": f"{name} is a {data['category']} technology. Effect: {data['effect']}. Requirements: {data['requirements']}."
        })
        
        examples.append({
            "instruction": f"How do I research {name} in Evony?",
            "input": "",
            "output": f"To research {name}, you need {data['requirements']}. Start research with tech.research command. Each level provides: {data['effect']}."
        })
    
    print(f"  Generated {len(examples)} research examples")
    return examples


def generate_error_code_qa():
    """Generate Q&A for all known error codes"""
    print("Generating error code Q&A...")
    examples = []
    
    error_codes = {
        -1: ("GENERAL_ERROR", "Generic server error"),
        -2: ("INVALID_PARAMS", "Invalid or missing parameters"),
        -3: ("RESOURCE_NOT_ENOUGH", "Insufficient resources"),
        -4: ("TROOP_NOT_ENOUGH", "Insufficient troops"),
        -5: ("HERO_NOT_FOUND", "Hero doesn't exist"),
        -6: ("HERO_BUSY", "Hero is already on mission"),
        -7: ("BUILDING_NOT_FOUND", "Building doesn't exist"),
        -8: ("BUILDING_BUSY", "Building is already upgrading"),
        -9: ("QUEUE_FULL", "Build/research queue is full"),
        -10: ("LEVEL_MAX", "Already at maximum level"),
        -11: ("REQUIREMENT_NOT_MET", "Prerequisites not met"),
        -12: ("POSITION_OCCUPIED", "Position already has a building"),
        -13: ("POSITION_INVALID", "Invalid building position"),
        -20: ("ARMY_NOT_FOUND", "Army doesn't exist"),
        -21: ("ARMY_BUSY", "Army is already on mission"),
        -22: ("INVALID_TARGET", "Invalid target coordinates"),
        -23: ("TARGET_TOO_FAR", "Target is out of range"),
        -30: ("ALLIANCE_NOT_EXIST", "Alliance doesn't exist"),
        -31: ("ALREADY_IN_ALLIANCE", "Already a member of an alliance"),
        -32: ("NOT_IN_ALLIANCE", "Not a member of any alliance"),
        -33: ("PERMISSION_DENIED", "Insufficient alliance rank"),
        -45: ("INVALID_BUILDING_STATUS", "Building is in invalid state"),
        -46: ("INVALID_BUILDING_TYPE", "Unknown building type"),
        -47: ("ITEM_NOT_ENOUGH", "Insufficient items"),
        -48: ("TOWNHALL_LEVEL_UNSUPPORT", "Town Hall level too low"),
        -49: ("UPDATE_LEVEL_OUT_OF_RANGE", "Invalid upgrade level"),
        -50: ("INVALID_PASSWORD", "Wrong password"),
        -51: ("PLAYER_NOT_FOUND", "Player doesn't exist"),
        -52: ("ALLIANCE_NOT_FOUND / SUPPORT_NOT_ZERO", "Alliance not found OR support troops present (bug: duplicate code)"),
        -53: ("NOBILITY_NOT_ENOUGH", "Insufficient nobility rank"),
        -57: ("BUILDING_REACH_MAX_LEVEL", "Building at max level"),
        -58: ("ALREADY_UPGRADING_RESEARCH_IN_ACADEMY", "Research already in progress"),
        -134: ("INVALID_HERO_LEVEL", "Hero level invalid"),
        -200: ("NEED_SECURITY_CODE", "Signature validation failed"),
        -201: ("BUILDING_QUEUE_ERROR", "Building queue error"),
    }
    
    for code, (name, desc) in error_codes.items():
        examples.append({
            "instruction": f"What is Evony error code {code}?",
            "input": "",
            "output": f"Error code {code} is {name}: {desc}"
        })
        
        examples.append({
            "instruction": f"What does {name} error mean in Evony?",
            "input": "",
            "output": f"{name} (error {code}): {desc}"
        })
    
    print(f"  Generated {len(examples)} error code examples")
    return examples


def generate_script_command_qa():
    """Generate Q&A for all script commands"""
    print("Generating script command Q&A...")
    examples = []
    
    commands = {
        "set": {"syntax": "set <varname> <value>", "desc": "Set a variable to a value", "example": "set myVar 100"},
        "setarray": {"syntax": "setarray <name> <v1> <v2> ...", "desc": "Set an array variable", "example": "setarray troops 1000 500 200"},
        "setarr": {"syntax": "setarr <name> <values>", "desc": "Shorthand for setarray", "example": "setarr coords 100 200"},
        "label": {"syntax": "label <name>", "desc": "Define a jump target", "example": "label start"},
        "goto": {"syntax": "goto <label>", "desc": "Jump to a label", "example": "goto start"},
        "if": {"syntax": "if <cond> <cmd>", "desc": "Conditional execution", "example": "if %gold% > 1000 echo Rich!"},
        "iferror": {"syntax": "iferror <cmd>", "desc": "Execute if previous command errored", "example": "iferror goto retry"},
        "loop": {"syntax": "loop <count> <cmd>", "desc": "Repeat command N times", "example": "loop 10 train a:100"},
        "sleep": {"syntax": "sleep <ms>", "desc": "Pause execution in milliseconds", "example": "sleep 5000"},
        "echo": {"syntax": "echo <message>", "desc": "Print message to log", "example": "echo Starting attack..."},
        "train": {"syntax": "train <type>:<count>", "desc": "Train troops", "example": "train a:1000"},
        "attack": {"syntax": "attack <x> <y>", "desc": "Send attack army", "example": "attack 100 200"},
        "scout": {"syntax": "scout <x> <y>", "desc": "Scout a location", "example": "scout 100 200"},
        "reinforce": {"syntax": "reinforce <x> <y>", "desc": "Send reinforcements", "example": "reinforce 100 200"},
        "transport": {"syntax": "transport <x> <y> <res>", "desc": "Transport resources", "example": "transport 100 200 food:10000"},
        "include": {"syntax": "include <script>", "desc": "Include another script file", "example": "include Buildings"},
        "build": {"syntax": "build <type> <pos>", "desc": "Build or upgrade building", "example": "build barracks 1001"},
        "research": {"syntax": "research <tech>", "desc": "Start research", "example": "research agriculture"},
        "hirehero": {"syntax": "hirehero", "desc": "Hire available hero from inn", "example": "hirehero"},
        "firehero": {"syntax": "firehero <id>", "desc": "Fire a hero", "example": "firehero 12345"},
        "comfort": {"syntax": "comfort <type>", "desc": "Comfort population", "example": "comfort praying"},
        "levy": {"syntax": "levy", "desc": "Collect resources", "example": "levy"},
        "useitem": {"syntax": "useitem <id> [count]", "desc": "Use an item", "example": "useitem 12345"},
    }
    
    for cmd, data in commands.items():
        examples.append({
            "instruction": f"What is the {cmd} command in AutoEvony?",
            "input": "",
            "output": f"The {cmd} command: {data['desc']}. Syntax: {data['syntax']}. Example: {data['example']}"
        })
        
        examples.append({
            "instruction": f"How do I use {cmd} in AutoEvony scripts?",
            "input": "",
            "output": f"Use {data['syntax']}. {data['desc']}. Example: {data['example']}"
        })
    
    print(f"  Generated {len(examples)} script command examples")
    return examples


def generate_protocol_command_qa():
    """Generate Q&A for major protocol commands"""
    print("Generating protocol command Q&A...")
    examples = []
    
    commands = {
        "army.newArmy": {"params": "cityId, heroId, troops, targetX, targetY, missionType", "desc": "Create a new army march"},
        "army.callBackArmy": {"params": "armyId", "desc": "Recall an army"},
        "army.speedUpArmy": {"params": "armyId, itemId", "desc": "Speed up an army with item"},
        "troop.produceTroop": {"params": "cityId, troopType, num", "desc": "Train troops"},
        "troop.cancelTroopProduce": {"params": "cityId, queueId", "desc": "Cancel troop training"},
        "castle.createBuilding": {"params": "cityId, positionId, buildingType", "desc": "Build new building"},
        "castle.upgradeBuilding": {"params": "cityId, positionId", "desc": "Upgrade existing building"},
        "castle.demolishBuilding": {"params": "cityId, positionId", "desc": "Demolish a building"},
        "tech.research": {"params": "cityId, techType", "desc": "Start research"},
        "tech.cancelResearch": {"params": "cityId", "desc": "Cancel research"},
        "hero.hireHero": {"params": "cityId, heroId", "desc": "Hire hero from inn"},
        "hero.fireHero": {"params": "heroId", "desc": "Dismiss a hero"},
        "hero.levelUpHero": {"params": "heroId", "desc": "Train hero"},
        "hero.usePoint": {"params": "heroId, type, count", "desc": "Assign stat points"},
        "alliance.createAlliance": {"params": "name, intro", "desc": "Create new alliance"},
        "alliance.joinAlliance": {"params": "allianceId", "desc": "Request to join"},
        "alliance.exitAlliance": {"params": "", "desc": "Leave current alliance"},
        "fortifications.produceFortifications": {"params": "cityId, type, num", "desc": "Build fortifications"},
        "trade.createTrade": {"params": "cityId, type, amount, price", "desc": "List trade offer"},
        "trade.buyTrade": {"params": "tradeId, cityId", "desc": "Purchase from market"},
        "field.getFieldInfo": {"params": "fieldId", "desc": "Get map tile info"},
        "quest.finishQuest": {"params": "questId", "desc": "Complete and claim quest"},
        "item.useItem": {"params": "itemId, [targetId]", "desc": "Use an item"},
        "interior.taxation": {"params": "cityId, rate", "desc": "Set tax rate"},
        "interior.comfort": {"params": "cityId, type", "desc": "Comfort population"},
    }
    
    for cmd, data in commands.items():
        examples.append({
            "instruction": f"What is the {cmd} protocol command?",
            "input": "",
            "output": f"The {cmd} command: {data['desc']}. Parameters: {data['params']}."
        })
        
        examples.append({
            "instruction": f"How do I call {cmd}?",
            "input": "",
            "output": f"Call {cmd} with parameters: {data['params']}. This {data['desc'].lower()}."
        })
    
    print(f"  Generated {len(examples)} protocol command examples")
    return examples


def main():
    print("="*70)
    print("COMPREHENSIVE Q&A GENERATION")
    print(f"Started: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("="*70)
    
    all_examples = []
    
    all_examples.extend(generate_all_building_qa())
    all_examples.extend(generate_all_troop_qa())
    all_examples.extend(generate_all_research_qa())
    all_examples.extend(generate_error_code_qa())
    all_examples.extend(generate_script_command_qa())
    all_examples.extend(generate_protocol_command_qa())
    
    print(f"\nNew examples generated: {len(all_examples)}")
    
    # Load existing and combine
    existing_file = TRAINING_DIR / "evony_complete_dataset.json"
    if existing_file.exists():
        with open(existing_file) as f:
            existing = json.load(f)
        
        # Deduplicate
        seen = {ex.get("instruction", "") for ex in existing}
        new_unique = [ex for ex in all_examples if ex.get("instruction", "") not in seen]
        
        combined = existing + new_unique
        print(f"Added {len(new_unique)} new unique examples")
        print(f"Total: {len(combined)} examples")
        
        # Save
        output = TRAINING_DIR / "evony_master_dataset.json"
        with open(output, 'w') as f:
            json.dump(combined, f, indent=2)
        print(f"Saved to {output}")
        
        # JSONL
        output_jsonl = TRAINING_DIR / "evony_master_dataset.jsonl"
        with open(output_jsonl, 'w') as f:
            for ex in combined:
                f.write(json.dumps(ex) + "\n")
        print(f"Saved JSONL to {output_jsonl}")
    
    print(f"\nCompleted: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")


if __name__ == "__main__":
    main()
