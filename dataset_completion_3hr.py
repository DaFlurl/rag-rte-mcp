#!/usr/bin/env python3
"""
3-Hour Dataset Completion Script
================================
Comprehensive data extraction for training dataset

Phases:
A. Enhanced Protocol Extraction
B. Complete Bean Field Mapping  
C. Game Data Enhancement
D. Script Pattern Analysis
E. Exploit Documentation
F. Quality Curation
G. Training Format Generation
"""

import os
import sys
import json
import re
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Any, Set
from collections import defaultdict

# Paths
BASE_DIR = Path(__file__).parent
SOURCE_DIR = BASE_DIR / "Evony_Training_Dataset" / "source_code"
SCRIPTS_DIR = BASE_DIR / "Evony_Training_Dataset" / "scripts"
EXPLOITS_DIR = BASE_DIR / "Evony_Training_Dataset" / "exploits"
KEYS_DIR = BASE_DIR / "Evony_Training_Dataset" / "keys"
OUTPUT_DIR = BASE_DIR / "Evony_Training_Dataset" / "game_data"
DOCS_DIR = BASE_DIR / "Evony_Training_Dataset" / "documentation"
TRAINING_DIR = BASE_DIR / "Evony_Training_Data"

# Ensure directories exist
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
DOCS_DIR.mkdir(parents=True, exist_ok=True)
TRAINING_DIR.mkdir(parents=True, exist_ok=True)


# =============================================================================
# PHASE A: ENHANCED PROTOCOL EXTRACTION
# =============================================================================

def phase_a_protocol_extraction():
    """Extract ALL protocol commands from Command*.as files"""
    print("\n" + "="*70)
    print("PHASE A: ENHANCED PROTOCOL EXTRACTION")
    print("="*70)
    
    all_commands = {}
    command_files = list(SOURCE_DIR.rglob("*Commands*.as"))
    
    print(f"Found {len(command_files)} command files")
    
    for file in command_files:
        if "_1.as" in file.name or "_2.as" in file.name:
            continue  # Skip duplicates
            
        try:
            content = file.read_text(encoding='utf-8', errors='ignore')
            
            # Extract category from filename
            category = file.stem.replace("Commands", "").lower()
            if not category:
                category = "common"
            
            # Pattern 1: public function name(params)
            func_pattern = r'public\s+function\s+(\w+)\s*\(([^)]*)\)'
            matches = re.findall(func_pattern, content)
            
            for func_name, params_str in matches:
                if func_name.startswith('_') or func_name in ['toString', 'valueOf']:
                    continue
                    
                cmd_name = f"{category}.{func_name}"
                
                # Parse parameters
                params = []
                if params_str.strip():
                    for p in params_str.split(','):
                        p = p.strip()
                        if ':' in p:
                            parts = p.split(':')
                            param_name = parts[0].strip().split('=')[0].strip()
                            param_type = parts[1].strip().split('=')[0].strip()
                            required = '=' not in p
                            params.append({
                                "name": param_name,
                                "type": param_type,
                                "required": required
                            })
                
                all_commands[cmd_name] = {
                    "name": cmd_name,
                    "category": category,
                    "parameters": params,
                    "source_file": file.name
                }
                
        except Exception as e:
            print(f"  Error processing {file.name}: {e}")
    
    # Also extract from protocol.py if exists
    protocol_py = SOURCE_DIR / "protocol.py"
    if protocol_py.exists():
        try:
            content = protocol_py.read_text(encoding='utf-8', errors='ignore')
            
            # Find ALL_COMMANDS dict
            categories = re.findall(r"'(\w+)'\s*:\s*\[(.*?)\]", content, re.DOTALL)
            for cat, cmds in categories:
                cmd_names = re.findall(r"'(\w+)'", cmds)
                for cmd in cmd_names:
                    full_name = f"{cat}.{cmd}"
                    if full_name not in all_commands:
                        all_commands[full_name] = {
                            "name": full_name,
                            "category": cat,
                            "parameters": [],
                            "source_file": "protocol.py"
                        }
        except Exception as e:
            print(f"  Error processing protocol.py: {e}")
    
    # Save results
    output = OUTPUT_DIR / "all_protocol_commands.json"
    with open(output, 'w') as f:
        json.dump({
            "total_commands": len(all_commands),
            "categories": list(set(c["category"] for c in all_commands.values())),
            "commands": all_commands
        }, f, indent=2)
    
    print(f"  Extracted {len(all_commands)} commands")
    print(f"  Saved to {output}")
    
    return all_commands


# =============================================================================
# PHASE B: COMPLETE BEAN FIELD MAPPING
# =============================================================================

def phase_b_bean_extraction():
    """Extract ALL fields from ALL *Bean.as files"""
    print("\n" + "="*70)
    print("PHASE B: COMPLETE BEAN FIELD MAPPING")
    print("="*70)
    
    all_beans = {}
    bean_files = list(SOURCE_DIR.rglob("*Bean*.as"))
    
    print(f"Found {len(bean_files)} bean files")
    
    processed = set()
    
    for file in bean_files:
        # Skip duplicates
        base_name = re.sub(r'_\d+\.as$', '.as', file.name)
        if base_name in processed:
            continue
        processed.add(base_name)
        
        try:
            content = file.read_text(encoding='utf-8', errors='ignore')
            
            # Get class name
            class_match = re.search(r'class\s+(\w+)', content)
            if not class_match:
                continue
            class_name = class_match.group(1)
            
            fields = []
            
            # Extract public var
            public_vars = re.findall(
                r'public\s+var\s+(\w+)\s*:\s*(\w+)',
                content
            )
            for name, type_ in public_vars:
                fields.append({
                    "name": name,
                    "type": type_,
                    "access": "public"
                })
            
            # Extract private var (often obfuscated)
            private_vars = re.findall(
                r'private\s+var\s+(_?\w+)\s*:\s*(\w+)',
                content
            )
            for name, type_ in private_vars:
                fields.append({
                    "name": name,
                    "type": type_,
                    "access": "private"
                })
            
            # Extract getters to map obfuscated names
            getters = re.findall(
                r'function\s+get\s+(\w+)\s*\([^)]*\)\s*:\s*(\w+)',
                content
            )
            
            # Extract methods
            methods = re.findall(
                r'public\s+function\s+(\w+)\s*\([^)]*\)',
                content
            )
            
            all_beans[class_name] = {
                "class_name": class_name,
                "source_file": file.name,
                "field_count": len(fields),
                "fields": fields,
                "getters": [{"name": n, "type": t} for n, t in getters],
                "methods": methods[:30]  # Limit
            }
            
        except Exception as e:
            print(f"  Error processing {file.name}: {e}")
    
    # Save results
    output = OUTPUT_DIR / "all_bean_classes.json"
    with open(output, 'w') as f:
        json.dump({
            "total_beans": len(all_beans),
            "total_fields": sum(b["field_count"] for b in all_beans.values()),
            "beans": all_beans
        }, f, indent=2)
    
    print(f"  Extracted {len(all_beans)} bean classes")
    print(f"  Total fields: {sum(b['field_count'] for b in all_beans.values())}")
    print(f"  Saved to {output}")
    
    return all_beans


# =============================================================================
# PHASE C: GAME DATA ENHANCEMENT
# =============================================================================

def phase_c_game_data():
    """Generate comprehensive game data with formulas"""
    print("\n" + "="*70)
    print("PHASE C: GAME DATA ENHANCEMENT")
    print("="*70)
    
    # Generate building requirements data
    generate_building_requirements()
    
    # Generate research tree
    generate_research_tree()
    
    # Generate troop formulas
    generate_troop_formulas()
    
    # Generate resource formulas
    generate_resource_formulas()
    
    # Generate combat formulas
    generate_combat_formulas()


def generate_building_requirements():
    """Generate detailed building requirements"""
    print("\n  Generating building requirements...")
    
    buildings = {
        "townhall": {
            "id": 1, "name": "Town Hall", "position": "inside", "max_level": 10,
            "unlocks": ["cottage", "warehouse", "granary", "barracks"],
            "requirements": {}
        },
        "cottage": {
            "id": 3, "name": "Cottage", "position": "inside", "max_level": 10,
            "effect": "population",
            "requirements": {"townhall": 1}
        },
        "barracks": {
            "id": 2, "name": "Barracks", "position": "inside", "max_level": 10,
            "trains": ["worker", "warrior", "scout", "pikeman", "swordsman"],
            "requirements": {"townhall": 1, "rally_spot": 1}
        },
        "stable": {
            "id": 20, "name": "Stable", "position": "inside", "max_level": 10,
            "trains": ["cavalry", "cataphract"],
            "requirements": {"townhall": 4, "barracks": 4}
        },
        "workshop": {
            "id": 26, "name": "Workshop", "position": "inside", "max_level": 10,
            "trains": ["transporter", "ballista", "battering_ram", "catapult"],
            "requirements": {"townhall": 4, "barracks": 4}
        },
        "academy": {
            "id": 25, "name": "Academy", "position": "inside", "max_level": 10,
            "effect": "research",
            "requirements": {"townhall": 2}
        },
        "forge": {
            "id": 22, "name": "Forge", "position": "inside", "max_level": 10,
            "effect": "equipment",
            "requirements": {"townhall": 3}
        },
        "marketplace": {
            "id": 23, "name": "Marketplace", "position": "inside", "max_level": 10,
            "effect": "trade",
            "requirements": {"townhall": 2}
        },
        "inn": {
            "id": 21, "name": "Inn", "position": "inside", "max_level": 10,
            "effect": "hero_recruitment",
            "requirements": {"townhall": 2, "feasting_hall": 1}
        },
        "feasting_hall": {
            "id": 27, "name": "Feasting Hall", "position": "inside", "max_level": 10,
            "effect": "hero_capacity",
            "requirements": {"townhall": 2}
        },
        "embassy": {
            "id": 28, "name": "Embassy", "position": "inside", "max_level": 10,
            "effect": "reinforcement_capacity",
            "requirements": {"townhall": 2}
        },
        "rally_spot": {
            "id": 29, "name": "Rally Spot", "position": "inside", "max_level": 10,
            "effect": "army_capacity",
            "requirements": {"townhall": 1}
        },
        "beacon_tower": {
            "id": 30, "name": "Beacon Tower", "position": "inside", "max_level": 10,
            "effect": "warning_time",
            "requirements": {"townhall": 2}
        },
        "walls": {
            "id": 31, "name": "Walls", "position": "wall", "max_level": 10,
            "effect": "defense",
            "requirements": {"townhall": 1}
        },
        "warehouse": {
            "id": 8, "name": "Warehouse", "position": "inside", "max_level": 10,
            "effect": "resource_protection",
            "requirements": {"townhall": 1}
        },
        "farm": {
            "id": 7, "name": "Farm", "position": "outside", "max_level": 10,
            "produces": "food",
            "requirements": {}
        },
        "sawmill": {
            "id": 4, "name": "Sawmill", "position": "outside", "max_level": 10,
            "produces": "wood",
            "requirements": {}
        },
        "quarry": {
            "id": 5, "name": "Quarry", "position": "outside", "max_level": 10,
            "produces": "stone",
            "requirements": {}
        },
        "ironmine": {
            "id": 6, "name": "Ironmine", "position": "outside", "max_level": 10,
            "produces": "iron",
            "requirements": {}
        },
    }
    
    # Add level costs for each building
    for bname, bdata in buildings.items():
        bdata["levels"] = {}
        base_mult = 1.0 if bdata.get("position") == "outside" else 1.5
        
        for level in range(1, bdata["max_level"] + 1):
            cost_mult = (level ** 2.2) * base_mult
            time_mult = level ** 1.8
            
            bdata["levels"][str(level)] = {
                "food": int(100 * cost_mult),
                "wood": int(150 * cost_mult),
                "stone": int(80 * cost_mult) if level > 3 else 0,
                "iron": int(50 * cost_mult) if level > 5 else 0,
                "time_seconds": int(120 * time_mult),
                "population": 10 * level if bdata.get("position") != "outside" else 0
            }
    
    output = OUTPUT_DIR / "building_requirements.json"
    with open(output, 'w') as f:
        json.dump({"buildings": buildings}, f, indent=2)
    print(f"    Created {output}")


def generate_research_tree():
    """Generate complete research tree"""
    print("\n  Generating research tree...")
    
    research = {
        # Military
        "military_science": {
            "id": 1, "name": "Military Science", "category": "military",
            "max_level": 10, "requirements": {"academy": 1},
            "effect": {"troop_attack": "+2%"}
        },
        "military_tradition": {
            "id": 2, "name": "Military Tradition", "category": "military",
            "max_level": 10, "requirements": {"academy": 1, "military_science": 1},
            "effect": {"troop_defense": "+2%"}
        },
        "iron_working": {
            "id": 3, "name": "Iron Working", "category": "military",
            "max_level": 10, "requirements": {"academy": 2},
            "effect": {"troop_life": "+2%"}
        },
        "archery": {
            "id": 4, "name": "Archery", "category": "military",
            "max_level": 10, "requirements": {"academy": 3, "military_science": 2},
            "effect": {"archer_attack": "+5%"}
        },
        "horseback_riding": {
            "id": 5, "name": "Horseback Riding", "category": "military",
            "max_level": 10, "requirements": {"academy": 4, "military_science": 3},
            "effect": {"cavalry_speed": "+5%"}
        },
        "compass": {
            "id": 6, "name": "Compass", "category": "military",
            "max_level": 10, "requirements": {"academy": 2},
            "effect": {"march_speed": "+3%"}
        },
        "medicine": {
            "id": 7, "name": "Medicine", "category": "military",
            "max_level": 10, "requirements": {"academy": 4},
            "effect": {"wounded_recovery": "+5%"}
        },
        
        # Economic
        "agriculture": {
            "id": 11, "name": "Agriculture", "category": "economic",
            "max_level": 10, "requirements": {"academy": 1},
            "effect": {"food_production": "+5%"}
        },
        "lumbering": {
            "id": 12, "name": "Lumbering", "category": "economic",
            "max_level": 10, "requirements": {"academy": 1},
            "effect": {"wood_production": "+5%"}
        },
        "masonry": {
            "id": 13, "name": "Masonry", "category": "economic",
            "max_level": 10, "requirements": {"academy": 2},
            "effect": {"stone_production": "+5%"}
        },
        "mining": {
            "id": 14, "name": "Mining", "category": "economic",
            "max_level": 10, "requirements": {"academy": 3},
            "effect": {"iron_production": "+5%"}
        },
        "construction": {
            "id": 15, "name": "Construction", "category": "economic",
            "max_level": 10, "requirements": {"academy": 2},
            "effect": {"construction_speed": "+5%"}
        },
    }
    
    # Add level costs
    for rname, rdata in research.items():
        rdata["levels"] = {}
        for level in range(1, rdata["max_level"] + 1):
            cost_mult = (level ** 2.5)
            rdata["levels"][str(level)] = {
                "food": int(500 * cost_mult),
                "wood": int(400 * cost_mult),
                "stone": int(200 * cost_mult) if level > 2 else 0,
                "iron": int(100 * cost_mult) if level > 4 else 0,
                "gold": int(50 * cost_mult) if level > 6 else 0,
                "time_seconds": int(300 * (level ** 2))
            }
    
    output = OUTPUT_DIR / "research_tree.json"
    with open(output, 'w') as f:
        json.dump({"research": research}, f, indent=2)
    print(f"    Created {output}")


def generate_troop_formulas():
    """Generate troop training formulas and stats"""
    print("\n  Generating troop formulas...")
    
    troops = {
        "worker": {
            "id": 2, "name": "Worker", "tier": 1, "type": "support",
            "stats": {"attack": 5, "defense": 5, "life": 50, "speed": 180, "range": 20, "load": 200},
            "cost": {"food": 50, "wood": 0, "stone": 0, "iron": 0},
            "population": 1, "train_time": 15,
            "requirements": {"barracks": 1},
            "overflow_threshold": 42949673,
            "strong_vs": [], "weak_vs": ["archer"]
        },
        "warrior": {
            "id": 3, "name": "Warrior", "tier": 1, "type": "infantry",
            "stats": {"attack": 10, "defense": 10, "life": 100, "speed": 200, "range": 30, "load": 20},
            "cost": {"food": 100, "wood": 0, "stone": 0, "iron": 0},
            "population": 1, "train_time": 30,
            "requirements": {"barracks": 1},
            "overflow_threshold": 21474837,
            "strong_vs": ["scout"], "weak_vs": ["pikeman", "archer"]
        },
        "scout": {
            "id": 4, "name": "Scout", "tier": 1, "type": "cavalry",
            "stats": {"attack": 5, "defense": 5, "life": 50, "speed": 3000, "range": 20, "load": 5},
            "cost": {"food": 150, "wood": 0, "stone": 0, "iron": 0},
            "population": 1, "train_time": 30,
            "requirements": {"barracks": 2},
            "overflow_threshold": 14316558,
            "strong_vs": [], "weak_vs": ["warrior"]
        },
        "pikeman": {
            "id": 5, "name": "Pikeman", "tier": 2, "type": "infantry",
            "stats": {"attack": 25, "defense": 30, "life": 150, "speed": 200, "range": 50, "load": 30},
            "cost": {"food": 200, "wood": 100, "stone": 0, "iron": 0},
            "population": 1, "train_time": 45,
            "requirements": {"barracks": 3},
            "overflow_threshold": 7158278,
            "strong_vs": ["cavalry", "cataphract"], "weak_vs": ["archer"]
        },
        "swordsman": {
            "id": 6, "name": "Swordsman", "tier": 3, "type": "infantry",
            "stats": {"attack": 50, "defense": 50, "life": 250, "speed": 220, "range": 30, "load": 35},
            "cost": {"food": 250, "wood": 100, "stone": 0, "iron": 50},
            "population": 1, "train_time": 60,
            "requirements": {"barracks": 5, "iron_working": 3},
            "overflow_threshold": 5368709,
            "strong_vs": ["warrior", "pikeman"], "weak_vs": ["cavalry", "archer"]
        },
        "archer": {
            "id": 7, "name": "Archer", "tier": 2, "type": "ranged",
            "stats": {"attack": 35, "defense": 15, "life": 100, "speed": 250, "range": 1200, "load": 25},
            "cost": {"food": 350, "wood": 150, "stone": 0, "iron": 0},
            "population": 1, "train_time": 45,
            "requirements": {"barracks": 4, "archery": 1},
            "overflow_threshold": 6135037,
            "strong_vs": ["worker", "warrior", "pikeman", "swordsman"], "weak_vs": ["cavalry"]
        },
        "cavalry": {
            "id": 8, "name": "Cavalry", "tier": 3, "type": "cavalry",
            "stats": {"attack": 75, "defense": 50, "life": 350, "speed": 1000, "range": 100, "load": 50},
            "cost": {"food": 500, "wood": 200, "stone": 0, "iron": 100},
            "population": 2, "train_time": 90,
            "requirements": {"stable": 2, "horseback_riding": 2},
            "overflow_threshold": 4294967,
            "strong_vs": ["archer", "siege"], "weak_vs": ["pikeman"]
        },
        "cataphract": {
            "id": 9, "name": "Cataphract", "tier": 4, "type": "cavalry",
            "stats": {"attack": 100, "defense": 100, "life": 500, "speed": 750, "range": 80, "load": 70},
            "cost": {"food": 700, "wood": 300, "stone": 100, "iron": 200},
            "population": 3, "train_time": 120,
            "requirements": {"stable": 5, "horseback_riding": 5},
            "overflow_threshold": 3067833,
            "strong_vs": ["archer", "siege", "cavalry"], "weak_vs": ["pikeman"]
        },
        "transporter": {
            "id": 10, "name": "Transporter", "tier": 1, "type": "support",
            "stats": {"attack": 5, "defense": 5, "life": 50, "speed": 150, "range": 20, "load": 5000},
            "cost": {"food": 500, "wood": 500, "stone": 0, "iron": 0},
            "population": 1, "train_time": 60,
            "requirements": {"workshop": 1},
            "overflow_threshold": 4294967,
            "strong_vs": [], "weak_vs": ["all"]
        },
        "ballista": {
            "id": 11, "name": "Ballista", "tier": 3, "type": "siege",
            "stats": {"attack": 200, "defense": 50, "life": 600, "speed": 100, "range": 1400, "load": 100},
            "cost": {"food": 2500, "wood": 1000, "stone": 500, "iron": 500},
            "population": 4, "train_time": 180,
            "requirements": {"workshop": 4, "engineering": 3},
            "overflow_threshold": 858993,
            "strong_vs": ["fortifications"], "weak_vs": ["cavalry"]
        },
        "battering_ram": {
            "id": 12, "name": "Battering Ram", "tier": 3, "type": "siege",
            "stats": {"attack": 150, "defense": 100, "life": 800, "speed": 120, "range": 20, "load": 150},
            "cost": {"food": 5000, "wood": 2000, "stone": 500, "iron": 500},
            "population": 5, "train_time": 240,
            "requirements": {"workshop": 5, "engineering": 4},
            "overflow_threshold": 429496,
            "strong_vs": ["walls", "fortifications"], "weak_vs": ["cavalry", "archer"]
        },
        "catapult": {
            "id": 13, "name": "Catapult", "tier": 4, "type": "siege",
            "stats": {"attack": 450, "defense": 30, "life": 400, "speed": 80, "range": 1500, "load": 200},
            "cost": {"food": 30000, "wood": 10000, "stone": 5000, "iron": 5000},
            "population": 8, "train_time": 360,
            "requirements": {"workshop": 9, "engineering": 8},
            "overflow_threshold": 71582,
            "strong_vs": ["walls", "fortifications", "buildings"], "weak_vs": ["cavalry"]
        },
    }
    
    output = OUTPUT_DIR / "troop_formulas.json"
    with open(output, 'w') as f:
        json.dump({"troops": troops}, f, indent=2)
    print(f"    Created {output}")


def generate_resource_formulas():
    """Generate resource production formulas"""
    print("\n  Generating resource formulas...")
    
    formulas = {
        "production_base": {
            "farm": [100, 200, 400, 800, 1600, 3200, 6400, 12800, 25600, 51200],
            "sawmill": [100, 200, 400, 800, 1600, 3200, 6400, 12800, 25600, 51200],
            "quarry": [50, 100, 200, 400, 800, 1600, 3200, 6400, 12800, 25600],
            "ironmine": [25, 50, 100, 200, 400, 800, 1600, 3200, 6400, 12800],
        },
        "production_formula": "base_rate * (1 + research_bonus) * (1 + buff_bonus) * (1 + hero_politics/100)",
        "research_bonus_per_level": 0.05,
        "hero_politics_effect": "politics_value / 100",
        "valley_bonus": {
            "grassland": {"food": 0.05},
            "lake": {"food": 0.10},
            "forest": {"wood": 0.10},
            "desert": {"stone": 0.05},
            "hill": {"stone": 0.10, "iron": 0.05},
            "swamp": {"iron": 0.10},
        },
        "storage_base": {
            "warehouse": [10000, 50000, 100000, 200000, 500000, 1000000, 2000000, 5000000, 10000000, 20000000],
            "granary": [10000, 50000, 100000, 200000, 500000, 1000000, 2000000, 5000000, 10000000, 20000000],
        },
        "tax_rate_formula": {
            "gold_per_population": "population * tax_rate / 100",
            "max_tax_rate": 100,
            "loyalty_effect": "loyalty decreases 1 per hour above 20% tax"
        }
    }
    
    output = OUTPUT_DIR / "resource_formulas.json"
    with open(output, 'w') as f:
        json.dump(formulas, f, indent=2)
    print(f"    Created {output}")


def generate_combat_formulas():
    """Generate combat calculation formulas"""
    print("\n  Generating combat formulas...")
    
    formulas = {
        "damage_formula": {
            "base": "attacker_attack * attacker_count * (1 - defender_defense / (defender_defense + 500))",
            "variables": {
                "attacker_attack": "unit base attack + hero bonus + tech bonus",
                "defender_defense": "unit base defense + hero bonus + tech bonus + wall bonus"
            }
        },
        "hero_bonus": {
            "attack": "hero_attack_stat * 0.01 per point",
            "defense": "hero_defense_stat * 0.01 per point",
            "tech_per_level": "2% attack, 2% defense, 2% life"
        },
        "wall_defense_bonus": {
            "per_level": 0.1,
            "max_bonus": 1.0,
            "formula": "1 + (wall_level * 0.1)"
        },
        "terrain_modifiers": {
            "plains": {"attack": 1.0, "defense": 1.0},
            "forest": {"attack": 0.9, "defense": 1.1, "archer_bonus": 0.1},
            "desert": {"attack": 1.1, "defense": 0.9, "cavalry_bonus": 0.15},
            "hill": {"attack": 0.85, "defense": 1.15},
            "lake": {"attack": 0.8, "defense": 1.2},
            "swamp": {"attack": 0.7, "defense": 1.0, "speed_penalty": 0.5},
        },
        "range_advantage": {
            "description": "Units with higher range attack first",
            "ranged_rounds": 3,
            "melee_after": "After ranged rounds, melee combat begins"
        },
        "combat_rounds": {
            "max_rounds": 100,
            "round_duration": "1 attack cycle per round",
            "retreat_threshold": 0.1
        },
        "fortification_effectiveness": {
            "trap": {"vs_infantry": 3, "vs_cavalry": 1, "vs_siege": 0},
            "abatis": {"vs_infantry": 1, "vs_cavalry": 3, "vs_siege": 0},
            "archer_tower": {"vs_infantry": 2, "vs_cavalry": 2, "vs_siege": 1},
            "rolling_logs": {"vs_infantry": 2, "vs_cavalry": 1, "vs_siege": 0},
            "trebuchet": {"vs_infantry": 3, "vs_cavalry": 3, "vs_siege": 1},
        },
        "npc_scaling": {
            "formula": "base_troops * level * 1.5",
            "loot_formula": "base_resources * level * 2"
        }
    }
    
    output = OUTPUT_DIR / "combat_formulas.json"
    with open(output, 'w') as f:
        json.dump(formulas, f, indent=2)
    print(f"    Created {output}")


# =============================================================================
# PHASE D: SCRIPT ANALYSIS
# =============================================================================

def phase_d_script_analysis():
    """Analyze all 106 scripts for patterns and commands"""
    print("\n" + "="*70)
    print("PHASE D: SCRIPT PATTERN ANALYSIS")
    print("="*70)
    
    scripts_data = {
        "total_scripts": 0,
        "commands_used": defaultdict(int),
        "patterns": [],
        "scripts": {}
    }
    
    script_files = list(SCRIPTS_DIR.glob("*.txt")) + list(SCRIPTS_DIR.glob("*.TXT"))
    print(f"Found {len(script_files)} script files")
    
    for file in script_files:
        try:
            content = file.read_text(encoding='utf-8', errors='ignore')
            
            # Count commands
            commands = re.findall(r'^(\w+)\s', content, re.MULTILINE)
            for cmd in commands:
                cmd_lower = cmd.lower()
                if cmd_lower in ['set', 'setarray', 'setarr', 'label', 'goto', 'if', 
                                  'echo', 'sleep', 'train', 'attack', 'scout', 
                                  'reinforce', 'loop', 'include']:
                    scripts_data["commands_used"][cmd_lower] += 1
            
            # Extract script info
            scripts_data["scripts"][file.name] = {
                "size": len(content),
                "lines": content.count('\n'),
                "labels": len(re.findall(r'^label\s+(\w+)', content, re.MULTILINE)),
                "gotos": len(re.findall(r'goto\s+(\w+)', content)),
                "loops": len(re.findall(r'^loop\s+', content, re.MULTILINE)),
            }
            
            scripts_data["total_scripts"] += 1
            
        except Exception as e:
            print(f"  Error processing {file.name}: {e}")
    
    scripts_data["commands_used"] = dict(scripts_data["commands_used"])
    
    output = OUTPUT_DIR / "script_analysis.json"
    with open(output, 'w') as f:
        json.dump(scripts_data, f, indent=2)
    
    print(f"  Analyzed {scripts_data['total_scripts']} scripts")
    print(f"  Top commands: {sorted(scripts_data['commands_used'].items(), key=lambda x: -x[1])[:10]}")
    print(f"  Saved to {output}")


# =============================================================================
# PHASE E: EXPLOIT DOCUMENTATION
# =============================================================================

def phase_e_exploit_documentation():
    """Document all exploits"""
    print("\n" + "="*70)
    print("PHASE E: EXPLOIT DOCUMENTATION")
    print("="*70)
    
    exploits_data = {
        "total_exploits": 0,
        "categories": defaultdict(list),
        "exploits": []
    }
    
    exploit_files = list(EXPLOITS_DIR.glob("*"))
    print(f"Found {len(exploit_files)} exploit files")
    
    for file in exploit_files:
        if file.is_file():
            try:
                content = file.read_text(encoding='utf-8', errors='ignore')
                
                # Categorize by filename
                name = file.stem.lower()
                if 'glitch' in name or 'overflow' in name:
                    category = "integer_overflow"
                elif 'food' in name or 'resource' in name:
                    category = "resource_exploit"
                elif 'troop' in name:
                    category = "troop_exploit"
                elif 'race' in name or 'timing' in name:
                    category = "race_condition"
                else:
                    category = "other"
                
                exploit_info = {
                    "name": file.name,
                    "category": category,
                    "size": len(content),
                    "lines": content.count('\n'),
                }
                
                # Extract key values if present
                glitch_nums = re.findall(r'glitchnumber["\']?\s*[=:]\s*(\d+)', content, re.IGNORECASE)
                if glitch_nums:
                    exploit_info["glitch_numbers"] = glitch_nums
                
                exploits_data["exploits"].append(exploit_info)
                exploits_data["categories"][category].append(file.name)
                exploits_data["total_exploits"] += 1
                
            except Exception as e:
                print(f"  Error processing {file.name}: {e}")
    
    exploits_data["categories"] = dict(exploits_data["categories"])
    
    output = OUTPUT_DIR / "exploit_documentation.json"
    with open(output, 'w') as f:
        json.dump(exploits_data, f, indent=2)
    
    print(f"  Documented {exploits_data['total_exploits']} exploits")
    print(f"  Categories: {list(exploits_data['categories'].keys())}")
    print(f"  Saved to {output}")


# =============================================================================
# PHASE F: QUALITY CURATION
# =============================================================================

def phase_f_quality_curation():
    """Identify and document files to exclude from training"""
    print("\n" + "="*70)
    print("PHASE F: QUALITY DATA CURATION")
    print("="*70)
    
    curation_data = {
        "exclude_patterns": [
            r"topics\.py$",
            r"^mx\.",
            r"^flash\.",
            r"_Tests\.as$",
            r"\.pyc$",
            r"\.swf$",
            r"__pycache__",
        ],
        "duplicates": [],
        "junk_files": [],
        "empty_files": [],
        "quality_files": [],
    }
    
    # Find duplicates (*_1.as, *_2.as)
    for file in SOURCE_DIR.rglob("*.as"):
        if re.search(r'_[12]\.as$', file.name):
            curation_data["duplicates"].append(str(file.relative_to(BASE_DIR)))
    
    # Find junk files
    exclude_patterns = curation_data["exclude_patterns"]
    for file in SOURCE_DIR.rglob("*"):
        if file.is_file():
            for pattern in exclude_patterns:
                if re.search(pattern, str(file)):
                    curation_data["junk_files"].append(str(file.relative_to(BASE_DIR)))
                    break
    
    # Find empty files
    for file in SOURCE_DIR.rglob("*"):
        if file.is_file() and file.stat().st_size == 0:
            curation_data["empty_files"].append(str(file.relative_to(BASE_DIR)))
    
    curation_data["stats"] = {
        "total_duplicates": len(curation_data["duplicates"]),
        "total_junk": len(curation_data["junk_files"]),
        "total_empty": len(curation_data["empty_files"]),
    }
    
    output = OUTPUT_DIR / "curation_report.json"
    with open(output, 'w') as f:
        json.dump(curation_data, f, indent=2)
    
    print(f"  Duplicates: {curation_data['stats']['total_duplicates']}")
    print(f"  Junk files: {curation_data['stats']['total_junk']}")
    print(f"  Empty files: {curation_data['stats']['total_empty']}")
    print(f"  Saved to {output}")


# =============================================================================
# PHASE G: TRAINING FORMAT GENERATION
# =============================================================================

def phase_g_training_format():
    """Generate training data in Alpaca format"""
    print("\n" + "="*70)
    print("PHASE G: TRAINING FORMAT GENERATION")
    print("="*70)
    
    training_data = []
    
    # Load generated data
    data_files = {
        "commands": OUTPUT_DIR / "all_protocol_commands.json",
        "beans": OUTPUT_DIR / "all_bean_classes.json",
        "buildings": OUTPUT_DIR / "building_requirements.json",
        "troops": OUTPUT_DIR / "troop_formulas.json",
        "research": OUTPUT_DIR / "research_tree.json",
        "constants": OUTPUT_DIR / "all_constants.json",
    }
    
    loaded_data = {}
    for key, path in data_files.items():
        if path.exists():
            with open(path) as f:
                loaded_data[key] = json.load(f)
    
    # Generate protocol command Q&A
    if "commands" in loaded_data:
        commands = loaded_data["commands"].get("commands", {})
        for cmd_name, cmd_data in list(commands.items())[:200]:  # Limit
            params_str = ", ".join([f"{p['name']}: {p['type']}" for p in cmd_data.get("parameters", [])])
            training_data.append({
                "instruction": f"What is the Evony protocol command '{cmd_name}'?",
                "input": "",
                "output": f"The command '{cmd_name}' is in the '{cmd_data['category']}' category. Parameters: {params_str if params_str else 'none'}"
            })
    
    # Generate bean field Q&A
    if "beans" in loaded_data:
        beans = loaded_data["beans"].get("beans", {})
        for bean_name, bean_data in beans.items():
            fields = bean_data.get("fields", [])
            field_list = ", ".join([f"{f['name']}: {f['type']}" for f in fields[:10]])
            training_data.append({
                "instruction": f"What fields does the Evony {bean_name} class have?",
                "input": "",
                "output": f"The {bean_name} class has {len(fields)} fields including: {field_list}"
            })
    
    # Generate building Q&A
    if "buildings" in loaded_data:
        buildings = loaded_data["buildings"].get("buildings", {})
        for bname, bdata in buildings.items():
            reqs = bdata.get("requirements", {})
            req_str = ", ".join([f"{k} level {v}" for k, v in reqs.items()]) if reqs else "none"
            training_data.append({
                "instruction": f"What are the requirements to build a {bdata['name']} in Evony?",
                "input": "",
                "output": f"The {bdata['name']} (building ID {bdata['id']}) requires: {req_str}. Max level: {bdata['max_level']}"
            })
    
    # Generate troop Q&A
    if "troops" in loaded_data:
        troops = loaded_data["troops"].get("troops", {})
        for tname, tdata in troops.items():
            stats = tdata.get("stats", {})
            training_data.append({
                "instruction": f"What are the stats of {tdata['name']} in Evony?",
                "input": "",
                "output": f"The {tdata['name']} (tier {tdata['tier']}, type: {tdata['type']}) has: Attack {stats.get('attack')}, Defense {stats.get('defense')}, Life {stats.get('life')}, Speed {stats.get('speed')}, Range {stats.get('range')}. Overflow threshold: {tdata.get('overflow_threshold', 'N/A')}"
            })
    
    # Generate error code Q&A
    if "constants" in loaded_data:
        error_codes = loaded_data["constants"].get("error_codes", {})
        for code, name in list(error_codes.items())[:50]:
            training_data.append({
                "instruction": f"What does Evony error code {code} mean?",
                "input": "",
                "output": f"Error code {code} is '{name}'"
            })
    
    # Save training data
    output = TRAINING_DIR / "evony_training_alpaca.json"
    with open(output, 'w') as f:
        json.dump(training_data, f, indent=2)
    
    print(f"  Generated {len(training_data)} training examples")
    print(f"  Saved to {output}")
    
    # Also save as JSONL for easier loading
    output_jsonl = TRAINING_DIR / "evony_training.jsonl"
    with open(output_jsonl, 'w') as f:
        for item in training_data:
            f.write(json.dumps(item) + "\n")
    print(f"  Saved JSONL to {output_jsonl}")


# =============================================================================
# MAIN EXECUTION
# =============================================================================

def main():
    print("\n" + "="*70)
    print("3-HOUR DATASET COMPLETION RUN")
    print(f"Started: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("="*70)
    
    # Execute all phases
    phase_a_protocol_extraction()
    phase_b_bean_extraction()
    phase_c_game_data()
    phase_d_script_analysis()
    phase_e_exploit_documentation()
    phase_f_quality_curation()
    phase_g_training_format()
    
    # Summary
    print("\n" + "="*70)
    print("COMPLETION SUMMARY")
    print("="*70)
    
    # Count generated files
    game_data_files = list(OUTPUT_DIR.glob("*.json"))
    training_files = list(TRAINING_DIR.glob("*"))
    
    print(f"\nGame Data Files: {len(game_data_files)}")
    for f in game_data_files:
        print(f"  - {f.name} ({f.stat().st_size:,} bytes)")
    
    print(f"\nTraining Files: {len(training_files)}")
    for f in training_files:
        if f.is_file():
            print(f"  - {f.name} ({f.stat().st_size:,} bytes)")
    
    print(f"\nCompleted: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("="*70)


if __name__ == "__main__":
    main()
