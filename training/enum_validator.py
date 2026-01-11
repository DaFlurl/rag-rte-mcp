#!/usr/bin/env python3
"""
Enum Unit Test Harness
Based on ChatGPT's critical feedback for Phase 3

Purpose: Mechanical verification of enum accuracy
- Tests exact enum values
- Generates corrective examples for failures
- Tracks accuracy over time
"""

import json
from pathlib import Path
from typing import Dict, List, Tuple, Optional

# ============================================================
# ENUM TEST CASES - Exact values from source code
# ============================================================

ENUM_TESTS = {
    # TFConstants - Troop Types
    "TFConstants.T_WORKER": "0",
    "TFConstants.T_WARRIOR": "1", 
    "TFConstants.T_SCOUT": "2",
    "TFConstants.T_PIKEMAN": "3",
    "TFConstants.T_SWORDSMAN": "4",
    "TFConstants.T_ARCHER": "5",
    "TFConstants.T_CAVALRY": "6",
    "TFConstants.T_CATAPHRACT": "8",
    "TFConstants.T_TRANSPORTER": "9",
    "TFConstants.T_BALLISTA": "10",
    "TFConstants.T_RAM": "11",
    "TFConstants.T_CATAPULT": "12",
    
    # TFConstants - Building Types
    "TFConstants.B_COTTAGE": "1",
    "TFConstants.B_BARRACKS": "2",
    "TFConstants.B_WAREHOUSE": "3",
    "TFConstants.B_SAWMILL": "4",
    "TFConstants.B_STONEMINE": "5",
    "TFConstants.B_IRONMINE": "6",
    "TFConstants.B_FARM": "7",
    "TFConstants.B_EMBASSY": "10",
    "TFConstants.B_WORKSHOP": "11",
    "TFConstants.B_ACADEMY": "12",
    "TFConstants.B_STABLE": "20",
    "TFConstants.B_FORGE": "22",
    "TFConstants.B_MARKETPLACE": "13",
    "TFConstants.B_INN": "14",
    "TFConstants.B_FEASTING_HALL": "15",
    "TFConstants.B_RALLY_SPOT": "16",
    "TFConstants.B_BEACON_TOWER": "17",
    "TFConstants.B_TOWNHALL": "18",
    "TFConstants.B_WALLS": "19",
    "TFConstants.B_RELIEF_STATION": "23",
    
    # TFConstants - Resource Types
    "TFConstants.R_GOLD": "0",
    "TFConstants.R_FOOD": "1",
    "TFConstants.R_WOOD": "2",
    "TFConstants.R_STONE": "3",
    "TFConstants.R_IRON": "4",
    
    # ErrorCode - Common Errors
    "ErrorCode.OK": "0",
    "ErrorCode.CYCLOPEAN_BARRIER": "-48",
    "ErrorCode.CASTLE_UNDER_PROTECTION": "-52",
    "ErrorCode.INSUFFICIENT_RESOURCE": "-99",
    "ErrorCode.HERO_NOT_AVAILABLE": "-1401",
    "ErrorCode.CITY_NOT_FOUND": "-1101",
    "ErrorCode.TROOP_NOT_ENOUGH": "-1301",
    "ErrorCode.RESEARCH_NOT_AVAILABLE": "-1501",
    "ErrorCode.BUILDING_UPGRADING": "-1201",
    "ErrorCode.QUEUE_FULL": "-1202",
    
    # HeroConstants
    "HeroConstants.HERO_STATUS_IDLE": "0",
    "HeroConstants.HERO_STATUS_MAYOR": "1",
    "HeroConstants.HERO_STATUS_MARCHING": "2",
    "HeroConstants.HERO_STATUS_DEFENDING": "3",
    
    # FieldConstants
    "FieldConstants.FIELD_FLAT": "1",
    "FieldConstants.FIELD_FOREST": "2",
    "FieldConstants.FIELD_DESERT": "3",
    "FieldConstants.FIELD_HILL": "4",
    "FieldConstants.FIELD_SWAMP": "5",
    "FieldConstants.FIELD_GRASSLAND": "6",
    "FieldConstants.FIELD_LAKE": "7",
    "FieldConstants.FIELD_NPC": "10",
    "FieldConstants.FIELD_NPC_1": "11",
    "FieldConstants.FIELD_NPC_2": "12",
    "FieldConstants.FIELD_NPC_3": "13",
    "FieldConstants.FIELD_NPC_4": "14",
    "FieldConstants.FIELD_NPC_5": "15",
    
    # ObjConstants
    "ObjConstants.OBJ_CITY": "1",
    "ObjConstants.OBJ_NPC": "2",
    "ObjConstants.OBJ_FIELD": "3",
    
    # ArmyConstants - Mission Types
    "ArmyConstants.MISSION_TRANSPORT": "1",
    "ArmyConstants.MISSION_REINFORCE": "2",
    "ArmyConstants.MISSION_SCOUT": "3",
    "ArmyConstants.MISSION_ATTACK": "4",
    "ArmyConstants.MISSION_OCCUPY": "5",
    
    # CommonConstants
    "CommonConstants.MAX_CITY_COUNT": "10",
    "CommonConstants.MAX_HERO_COUNT": "10",
    "CommonConstants.MAX_ARMY_COUNT": "10",
}

# ============================================================
# Additional enum values with known bugs (from CRITICAL_ENUM_ANALYSIS.md)
# ============================================================

ENUM_BUG_TESTS = {
    # These are the CORRECT values - model should know the bugs
    "TFConstants.T_CATAPHRACT": "8",  # NOT 7 (common mistake)
    "TFConstants.B_STABLE": "20",     # NOT 13 (common mistake)
    "TFConstants.B_FORGE": "22",      # NOT 21 (common mistake)
}

def generate_test_prompt(enum_name: str) -> str:
    """Generate a test prompt for an enum value"""
    return f"What is the value of {enum_name}?"

def check_answer(response: str, expected: str) -> bool:
    """Check if the response contains the expected value"""
    # Look for the exact value in the response
    # Handle various formats: "= 8", "is 8", ": 8", "8", etc.
    import re
    
    # Direct match
    if expected in response:
        return True
    
    # Pattern match for "= X" or "is X" or ": X"
    patterns = [
        rf'=\s*{expected}\b',
        rf'is\s+{expected}\b',
        rf':\s*{expected}\b',
        rf'value\s+{expected}\b',
        rf'equals?\s+{expected}\b',
    ]
    
    for pattern in patterns:
        if re.search(pattern, response, re.IGNORECASE):
            return True
    
    return False

def generate_corrective_example(enum_name: str, expected: str, 
                                 wrong_response: str) -> Dict:
    """Generate a corrective training example for a failed test"""
    return {
        "instruction": f"What is the value of {enum_name}?",
        "input": "",
        "output": f"{enum_name} = {expected}\n\nThis is a constant defined in the Evony source code. The exact value is {expected}."
    }

def run_enum_tests(model_responses: Dict[str, str]) -> Dict:
    """
    Run enum tests against model responses
    
    Args:
        model_responses: Dict mapping enum_name to model's response
        
    Returns:
        Test results including pass/fail, failures, and corrective examples
    """
    results = {
        "total": 0,
        "passed": 0,
        "failed": 0,
        "accuracy": 0.0,
        "failures": [],
        "corrective_examples": []
    }
    
    all_tests = {**ENUM_TESTS, **ENUM_BUG_TESTS}
    
    for enum_name, expected in all_tests.items():
        results["total"] += 1
        
        if enum_name not in model_responses:
            results["failed"] += 1
            results["failures"].append({
                "enum": enum_name,
                "expected": expected,
                "got": "NO RESPONSE"
            })
            results["corrective_examples"].append(
                generate_corrective_example(enum_name, expected, "")
            )
            continue
        
        response = model_responses[enum_name]
        
        if check_answer(response, expected):
            results["passed"] += 1
        else:
            results["failed"] += 1
            results["failures"].append({
                "enum": enum_name,
                "expected": expected,
                "got": response[:200]  # Truncate for display
            })
            results["corrective_examples"].append(
                generate_corrective_example(enum_name, expected, response)
            )
    
    if results["total"] > 0:
        results["accuracy"] = results["passed"] / results["total"] * 100
    
    return results

def create_enum_test_prompts() -> List[Dict]:
    """Create test prompts for all enum values"""
    prompts = []
    all_tests = {**ENUM_TESTS, **ENUM_BUG_TESTS}
    
    for enum_name, expected in all_tests.items():
        prompts.append({
            "enum_name": enum_name,
            "prompt": generate_test_prompt(enum_name),
            "expected": expected
        })
    
    return prompts

def save_corrective_examples(examples: List[Dict], filepath: Path):
    """Save corrective examples for micro-fine-tuning"""
    with open(filepath, 'w', encoding='utf-8') as f:
        for ex in examples:
            f.write(json.dumps(ex, ensure_ascii=False) + '\n')

def main():
    """Generate test prompts and save them"""
    training_dir = Path(__file__).parent
    
    print("=" * 60)
    print("ENUM UNIT TEST HARNESS")
    print("Based on ChatGPT Critical Feedback")
    print("=" * 60)
    
    # Generate test prompts
    prompts = create_enum_test_prompts()
    print(f"\nGenerated {len(prompts)} enum test prompts")
    
    # Save test prompts
    prompts_path = training_dir / "enum_test_prompts.json"
    with open(prompts_path, 'w', encoding='utf-8') as f:
        json.dump(prompts, f, indent=2)
    print(f"Saved test prompts to {prompts_path}")
    
    # Generate comprehensive enum training examples
    training_examples = []
    all_tests = {**ENUM_TESTS, **ENUM_BUG_TESTS}
    
    for enum_name, expected in all_tests.items():
        # Basic value question
        training_examples.append({
            "instruction": f"What is the value of {enum_name}?",
            "input": "",
            "output": f"{enum_name} = {expected}"
        })
        
        # Detailed explanation
        parts = enum_name.split('.')
        if len(parts) == 2:
            class_name, const_name = parts
            training_examples.append({
                "instruction": f"Explain the constant {const_name} in {class_name}",
                "input": "",
                "output": f"The constant {const_name} is defined in {class_name} with the value {expected}. This is used in the Evony game client for {get_enum_purpose(class_name, const_name)}."
            })
    
    # Save training examples
    training_path = training_dir / "train_enum_exact.jsonl"
    with open(training_path, 'w', encoding='utf-8') as f:
        for ex in training_examples:
            f.write(json.dumps(ex, ensure_ascii=False) + '\n')
    print(f"Saved {len(training_examples)} enum training examples to {training_path}")
    
    print("\n" + "=" * 60)
    print("USAGE INSTRUCTIONS")
    print("=" * 60)
    print("""
1. Run your model on each prompt in enum_test_prompts.json
2. Collect responses into a dict: {enum_name: response}
3. Call run_enum_tests(responses) to check accuracy
4. If failures exist, corrective examples are generated
5. Run a corrective micro-fine-tune with small LR
6. Repeat until 100% accuracy
""")

def get_enum_purpose(class_name: str, const_name: str) -> str:
    """Get a description of what an enum is used for"""
    purposes = {
        "TFConstants": {
            "T_": "troop type identification in army management",
            "B_": "building type identification in city management",
            "R_": "resource type identification in economy management",
        },
        "ErrorCode": {
            "": "error handling and response validation",
        },
        "HeroConstants": {
            "": "hero status tracking and management",
        },
        "FieldConstants": {
            "FIELD_": "map tile type identification",
        },
        "ObjConstants": {
            "OBJ_": "map object type identification",
        },
        "ArmyConstants": {
            "MISSION_": "army mission type identification",
        },
        "CommonConstants": {
            "MAX_": "game limits and constraints",
        },
    }
    
    class_purposes = purposes.get(class_name, {"": "game logic"})
    
    for prefix, purpose in class_purposes.items():
        if const_name.startswith(prefix):
            return purpose
    
    return "game logic and state management"

if __name__ == "__main__":
    main()
