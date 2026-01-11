#!/usr/bin/env python3
"""
Advanced Training Data Generator
================================
Generate additional high-quality training examples
"""

import json
import re
from pathlib import Path
from datetime import datetime

BASE_DIR = Path(__file__).parent
SOURCE_DIR = BASE_DIR / "Evony_Training_Dataset" / "source_code"
OUTPUT_DIR = BASE_DIR / "Evony_Training_Dataset" / "game_data"
TRAINING_DIR = BASE_DIR / "Evony_Training_Data"


def generate_conversation_pairs():
    """Generate multi-turn conversation examples"""
    print("Generating conversation pairs...")
    
    conversations = [
        # Combat scenario
        [
            {"role": "user", "content": "I want to attack an NPC in Evony. What troops should I use?"},
            {"role": "assistant", "content": "For NPC attacks, use a balanced army. Archers are essential for range damage. Against low level NPCs (1-5), 10k archers with a good attack hero work well. For higher NPCs, add cavalry to protect archers and siege for fortifications."},
            {"role": "user", "content": "What hero stats matter most for attacks?"},
            {"role": "assistant", "content": "Attack stat is most important - each point adds ~1% bonus damage. Intelligence affects stratagem effectiveness. For pure combat: prioritize Attack > Politics > Intelligence. A 100 attack hero gives 100% bonus damage."}
        ],
        # Building scenario
        [
            {"role": "user", "content": "What should I build first in a new Evony city?"},
            {"role": "assistant", "content": "Priority order: 1) Town Hall to level 4 (unlocks key buildings), 2) Cottages for population, 3) Resource buildings (farms, sawmills, etc.), 4) Barracks + Rally Spot for troops, 5) Academy for research."},
            {"role": "user", "content": "When should I build walls?"},
            {"role": "assistant", "content": "Build walls early if you're in a hostile area. Each wall level adds 10% defense bonus (level 10 = 100% bonus). Also build fortifications: traps for infantry, abatis for cavalry. Prioritize walls before expanding outside buildings."}
        ],
        # Scripting scenario
        [
            {"role": "user", "content": "How do I make an AutoEvony script to train troops automatically?"},
            {"role": "assistant", "content": "Use the train command in a loop. Example:\n```\nlabel start\ntrain a:1000\nsleep 60000\ngoto start\n```\nThis trains 1000 archers every minute. Use %variables% for dynamic values."},
            {"role": "user", "content": "How do I check resources before training?"},
            {"role": "assistant", "content": "Use if conditions with city data:\n```\nif $c.resource.food$ > 100000 train a:1000\n```\nAccess city data with $c.property$ syntax. Check resources, troops, buildings before actions."}
        ],
    ]
    
    examples = []
    for conv in conversations:
        # First turn
        examples.append({
            "instruction": conv[0]["content"],
            "input": "",
            "output": conv[1]["content"]
        })
        # Follow-up if exists
        if len(conv) > 2:
            examples.append({
                "instruction": conv[2]["content"],
                "input": f"Context: User previously asked about {conv[0]['content'][:50]}...",
                "output": conv[3]["content"]
            })
    
    print(f"  Generated {len(examples)} conversation examples")
    return examples


def generate_code_examples():
    """Generate code-based training examples"""
    print("Generating code examples...")
    
    examples = []
    
    # ActionScript examples
    as3_examples = [
        {
            "instruction": "Show me the ActionScript code for sending an army in Evony",
            "output": """```actionscript
// ArmyCommands.as
public function newArmy(cityId:int, heroId:int, troops:Object, targetX:int, targetY:int, missionType:int):void {
    var params:Object = {
        cityId: cityId,
        heroId: heroId,
        troops: troops,
        targetX: targetX,
        targetY: targetY,
        missionType: missionType
    };
    Sender.instance.send("army.newArmy", params);
}
```
Parameters: cityId (source city), heroId (hero to lead), troops (Object like {archer:1000, cavalry:500}), targetX/targetY (coordinates), missionType (1=transport, 2=reinforce, 5=attack)"""
        },
        {
            "instruction": "Show me how Evony handles server responses",
            "output": """```actionscript
// ResponseDispatcher.as
public function ResponseDispatcher() {
    respMap["army.newArmy"] = onNewArmyResponse;
    respMap["troop.produceTroop"] = onProduceTroopResponse;
    respMap["server.ArmyUpdate"] = onArmyUpdate;
}

private function onNewArmyResponse(data:Object):void {
    if (data.ok == 1) {
        // Army created successfully
        dispatchEvent(new ResponseEvent(ARMY_NEW_ARMY, data));
    } else {
        // Handle error - check data.errorCode
        dispatchEvent(new ErrorEvent(data.errorCode));
    }
}
```
The ResponseDispatcher maps server responses to handler functions and dispatches events for UI updates."""
        },
        {
            "instruction": "How does Evony calculate troop training cost?",
            "output": """```actionscript
// TrainTroopHelper.as
public static function getMaxTrainCount(troopType:int, castle:CastleBean):int {
    var troopCost:Object = TFConstants.getTroopCost(troopType);
    var resources:CastleResourceBean = castle.resource;
    
    var maxCount:int = int.MAX_VALUE;
    
    if (troopCost.food > 0) {
        maxCount = Math.min(maxCount, resources.food.amount / troopCost.food);
    }
    if (troopCost.wood > 0) {
        maxCount = Math.min(maxCount, resources.wood.amount / troopCost.wood);
    }
    // ... similar for stone, iron
    
    return Math.floor(maxCount);
}
```
WARNING: This calculation can overflow if maxCount * cost > INT32_MAX (2,147,483,647)."""
        },
    ]
    
    for ex in as3_examples:
        examples.append({
            "instruction": ex["instruction"],
            "input": "",
            "output": ex["output"]
        })
    
    # Python examples
    python_examples = [
        {
            "instruction": "Show me Python code to generate an Evony signature",
            "output": """```python
import hashlib
import json

ACTION_KEY = "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"

def generate_signature(command: str, params: dict) -> str:
    \"\"\"Generate MD5 signature for Evony protocol command\"\"\"
    param_str = json.dumps(params, separators=(',', ':'))
    combined = command + param_str + ACTION_KEY
    return hashlib.md5(combined.encode()).hexdigest()

# Example usage
sig = generate_signature("army.newArmy", {"cityId": 123, "targetX": 100, "targetY": 200})
print(f"Signature: {sig}")
```
This signature must be included in all protocol requests for authentication."""
        },
        {
            "instruction": "Show me Python code to decrypt Evony XOR-encrypted data",
            "output": """```python
XOR_KEY = 0xAA  # 170 decimal

def xor_decrypt(data: bytes) -> bytes:
    \"\"\"XOR decrypt/encrypt Evony packet data\"\"\"
    return bytes(b ^ XOR_KEY for b in data)

# XOR is symmetric - same function for encrypt/decrypt
def xor_encrypt(data: bytes) -> bytes:
    return xor_decrypt(data)

# Example
encrypted = bytes([0xE5, 0xC5, 0xD8, 0xD8, 0xDF])  # "Hello" XOR 0xAA
decrypted = xor_decrypt(encrypted)
print(decrypted.decode())  # "Hello"
```
Evony uses XOR with key 0xAA for basic packet obfuscation."""
        },
        {
            "instruction": "Show me Python code to parse Evony building data",
            "output": """```python
def parse_castle_buildings(castle_data: dict) -> dict:
    \"\"\"Parse building data from castle response\"\"\"
    buildings = {}
    
    for building in castle_data.get("buildings", []):
        type_id = building.get("typeId")
        position = building.get("positionId")
        level = building.get("level", 0)
        status = building.get("status", 0)  # 0=idle, 1=upgrading
        
        buildings[position] = {
            "type": BUILDING_TYPES.get(type_id, f"Unknown({type_id})"),
            "level": level,
            "status": "upgrading" if status == 1 else "idle",
            "end_time": building.get("endTime", 0)
        }
    
    return buildings

BUILDING_TYPES = {
    1: "Town Hall", 2: "Barracks", 3: "Cottage",
    4: "Sawmill", 5: "Quarry", 6: "Ironmine", 7: "Farm",
    20: "Stable", 21: "Inn", 22: "Forge", 25: "Academy",
    26: "Workshop", 27: "Feasting Hall", 31: "Walls"
}
```"""
        },
    ]
    
    for ex in python_examples:
        examples.append({
            "instruction": ex["instruction"],
            "input": "",
            "output": ex["output"]
        })
    
    print(f"  Generated {len(examples)} code examples")
    return examples


def generate_troubleshooting_qa():
    """Generate troubleshooting Q&A"""
    print("Generating troubleshooting Q&A...")
    
    qa = [
        ("Why is my Evony bot getting disconnected?", 
         "Common causes: 1) Rate limiting - add delays between commands (1-3 seconds), 2) Invalid signature - check ACTION_KEY is correct, 3) Session expired - implement token refresh, 4) Anti-cheat detection - randomize timing and patterns."),
        
        ("Why am I getting error code -3 in Evony?",
         "Error -3 is RESOURCE_NOT_ENOUGH. The action requires more resources than available. Check food/wood/stone/iron/gold before the action."),
        
        ("Why am I getting error code -4 in Evony?",
         "Error -4 is TROOP_NOT_ENOUGH. You're trying to send more troops than available. Check troop counts before army commands."),
        
        ("Why am I getting error code -52 in Evony?",
         "Error -52 has two meanings (bug): ALLIANCE_NOT_FOUND or SUPPORT_NOT_ZERO. Context determines which - alliance commands vs army commands."),
        
        ("Why am I getting error code -200 in Evony?",
         "Error -200 is NEED_SECURITY_CODE. The command requires a valid signature. Ensure you're generating MD5(command + params + ACTION_KEY) correctly."),
        
        ("My AutoEvony script won't run. What's wrong?",
         "Check: 1) Syntax errors - verify label/goto names match, 2) Variable scope - use %var% for substitution, 3) Infinite loops - add sleep commands, 4) City selection - ensure correct city is active."),
        
        ("Why are my troops not training?",
         "Check: 1) Barracks level for troop type, 2) Sufficient resources, 3) Population capacity, 4) No other training in progress (queue full), 5) Required research (archery for archers, etc)."),
        
        ("Why did my attack fail?",
         "Check: 1) Hero assigned, 2) Rally Spot level (determines army count), 3) Target coordinates valid, 4) Troops available, 5) No existing march to same target. Error codes indicate specific issues."),
        
        ("How do I fix integer overflow exploits?",
         "Validate troop counts before training: if count > overflow_threshold, reject. Thresholds: Worker 42.9M, Archer 6.1M, Catapult 71.5K. Server-side validation required."),
        
        ("Why is my signature being rejected?",
         "Ensure: 1) Exact ACTION_KEY match, 2) JSON params sorted and compact (no spaces), 3) MD5 hex lowercase, 4) No extra characters. Test: MD5('test' + ACTION_KEY) should be consistent."),
    ]
    
    examples = []
    for q, a in qa:
        examples.append({
            "instruction": q,
            "input": "",
            "output": a
        })
    
    print(f"  Generated {len(examples)} troubleshooting examples")
    return examples


def generate_advanced_mechanics():
    """Generate advanced game mechanics Q&A"""
    print("Generating advanced mechanics Q&A...")
    
    qa = [
        ("How does the Evony loyalty system work?",
         "Loyalty ranges 0-100. At 100, city is secure. Below 100, cities can be captured. Tax rate >20% decreases loyalty 1/hour. Comforting increases loyalty. At 0 loyalty with enemy troops present, city is captured."),
        
        ("How do valleys work in Evony?",
         "Valleys provide resource bonuses: Forest +10% wood, Lake +10% food, Hill +10% stone/5% iron, Swamp +10% iron, Grassland +5% food, Desert +5% stone. Capture by defeating NPC defenders. Max valleys = Town Hall level."),
        
        ("How does the hero system work?",
         "Heroes have 4 stats: Attack (combat damage), Politics (resource production), Intelligence (stratagem effectiveness). Each point = ~1% bonus. Heroes gain XP from combat. Level cap = Feasting Hall level * 5."),
        
        ("How do fortifications work?",
         "Traps: effective vs infantry (3x). Abatis: effective vs cavalry (3x). Archer Towers: balanced (2x all). Rolling Logs: infantry/cavalry (2x/1x). Trebuchets: best vs all (3x). Built at Forge, placed on walls."),
        
        ("How does the alliance system work?",
         "Alliances allow: reinforcements between members, shared alliance chat, coordinated attacks, embassy reinforcement capacity. Host can set ranks: Leader, Vice Leader, Presbyter, Officer, Member."),
        
        ("How does scouting work?",
         "Scout reports reveal: troop counts, resource amounts, hero info, building levels. Scout survival based on attacker scouts vs defender scout count + Beacon Tower level. Instant reports with enough scouts."),
        
        ("How do marches and travel time work?",
         "Travel time = distance / slowest_unit_speed. Distance calculated as Euclidean (sqrt(dx² + dy²)). Compass research reduces time. Rally Spot level determines max concurrent marches."),
        
        ("How does the war report system work?",
         "Reports contain: attacker/defender troops before/after, hero gains, resource captured, loyalty change. Reports auto-delete after 7 days. Detailed reports show per-round combat."),
        
        ("How does resource protection work?",
         "Warehouse protects resources from plunder. Protection = warehouse_capacity * 0.9. Resources above protection can be taken. Gold cannot be plundered. Upgrading warehouse increases protection."),
        
        ("How do item effects work?",
         "Items have: speedups (reduce timers), resource packs (instant resources), buffs (temporary bonuses), teleports (relocate city), shields (prevent attacks). Use via item.useItem command."),
    ]
    
    examples = []
    for q, a in qa:
        examples.append({
            "instruction": q,
            "input": "",
            "output": a
        })
    
    print(f"  Generated {len(examples)} advanced mechanics examples")
    return examples


def generate_protocol_deep_dive():
    """Generate deep protocol documentation"""
    print("Generating protocol deep dive...")
    
    examples = []
    
    # Command categories with detailed explanations
    categories = {
        "army": "Army commands control troop movements. Key commands: newArmy (create march), callBackArmy (recall), speedUpArmy (use item), getArmyByCity (list armies). All require cityId and return ArmyBean data.",
        "troop": "Troop commands manage training. Key commands: produceTroop (train), cancelTroopProduce (cancel), getProduceQueue (list training). Training limited by barracks level and resources.",
        "castle": "Castle commands manage buildings. Key commands: createBuilding, upgradeBuilding, demolishBuilding, getAvailableBuildingList. Building positions: 1000-1999 inside, 2000-2999 outside.",
        "tech": "Tech commands control research. Key commands: research (start), cancelResearch (stop), getResearchList (available techs). Academy level gates available research.",
        "hero": "Hero commands manage heroes. Key commands: hireHero (recruit from inn), fireHero (dismiss), levelUpHero (train), usePoint (assign stat points). Feasting Hall level = max heroes.",
        "alliance": "Alliance commands manage guild functions. Key commands: createAlliance, joinAlliance, exitAlliance, setAllianceRank, messageAlliance. Requires Embassy building.",
        "fortifications": "Fortifications commands manage wall defenses. Key commands: produceFortifications (build), cancelFortificationsProduce. Requires Forge building and wall.",
        "trade": "Trade commands control marketplace. Key commands: createTrade (sell), cancelTrade, searchTrade (browse), buyTrade. Requires Marketplace building.",
        "quest": "Quest commands handle missions. Key commands: getQuestList (available), acceptQuest, finishQuest (claim). Quests give resources, items, experience.",
        "field": "Field commands manage map interactions. Key commands: getFieldInfo (tile data), getOtherFieldInfo (scouting), occupyField (capture valley).",
    }
    
    for cat, desc in categories.items():
        examples.append({
            "instruction": f"What are the {cat} commands in Evony protocol?",
            "input": "",
            "output": desc
        })
    
    print(f"  Generated {len(examples)} protocol deep dive examples")
    return examples


def main():
    print("="*70)
    print("ADVANCED TRAINING DATA GENERATION")
    print(f"Started: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("="*70)
    
    all_examples = []
    
    all_examples.extend(generate_conversation_pairs())
    all_examples.extend(generate_code_examples())
    all_examples.extend(generate_troubleshooting_qa())
    all_examples.extend(generate_advanced_mechanics())
    all_examples.extend(generate_protocol_deep_dive())
    
    print(f"\nTotal new examples: {len(all_examples)}")
    
    # Load existing and combine
    existing_file = TRAINING_DIR / "evony_final_training.json"
    if existing_file.exists():
        with open(existing_file) as f:
            existing = json.load(f)
        
        # Deduplicate
        seen = {ex.get("instruction", "") for ex in existing}
        new_unique = [ex for ex in all_examples if ex.get("instruction", "") not in seen]
        
        combined = existing + new_unique
        print(f"Combined with existing: {len(combined)} total")
        
        # Save
        output = TRAINING_DIR / "evony_complete_dataset.json"
        with open(output, 'w') as f:
            json.dump(combined, f, indent=2)
        print(f"Saved to {output}")
        
        # JSONL
        output_jsonl = TRAINING_DIR / "evony_complete_dataset.jsonl"
        with open(output_jsonl, 'w') as f:
            for ex in combined:
                f.write(json.dumps(ex) + "\n")
        print(f"Saved JSONL to {output_jsonl}")
    
    print(f"\nCompleted: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("="*70)


if __name__ == "__main__":
    main()
