#!/usr/bin/env python3
"""
AI-Powered Multi-City Glitch Optimizer
======================================
Paste your PerCity_TroopCollector output to get exact optimization commands.

Features:
- Parses per-city troop data
- Calculates ALL glitches for ALL cities
- Identifies EVEN glitches (not generating)
- Recommends MOVE or UNTRAIN based on amount
- Generates executable commands per city
"""

import re
from dataclasses import dataclass, field
from typing import Dict, List, Optional
from collections import defaultdict

# Constants
INT32_MAX = 2_147_483_647
FOOD_PER_GLITCH = INT32_MAX

@dataclass
class TroopType:
    name: str
    abbr: str
    food_cost: int
    city_threshold: int

TROOP_TYPES = [
    TroopType("Workers", "wo", 1, 2_147_483_648),
    TroopType("Warriors", "w", 1, 2_147_483_648),
    TroopType("Scouts", "s", 2, 1_073_741_824),
    TroopType("Pikemen", "p", 3, 715_827_883),
    TroopType("Swordsmen", "sw", 3, 715_827_883),
    TroopType("Archers", "a", 4, 536_870_912),
    TroopType("Cavalry", "c", 9, 238_609_295),
    TroopType("Cataphracts", "cata", 17, 126_322_568),
    TroopType("Transporters", "t", 5, 429_496_730),
    TroopType("Ballista", "b", 25, 85_899_346),
    TroopType("Battering Rams", "r", 50, 42_949_673),
    TroopType("Catapults", "cp", 125, 17_179_870),
]

ABBR_TO_NAME = {t.abbr: t.name for t in TROOP_TYPES}
NAME_TO_TROOP = {t.name: t for t in TROOP_TYPES}


def parse_collector_output(text: str) -> Dict[str, Dict[str, int]]:
    """Parse the PerCity_TroopCollector output"""
    cities = {}
    current_city = None
    
    for line in text.strip().split('\n'):
        line = line.strip()
        if line.startswith("CITY:"):
            current_city = line.replace("CITY:", "").strip()
            cities[current_city] = {}
        elif ":" in line and current_city:
            parts = line.split(":")
            if len(parts) == 2:
                abbr = parts[0].strip()
                try:
                    count = int(parts[1].strip().replace(",", ""))
                    if abbr in ABBR_TO_NAME:
                        cities[current_city][ABBR_TO_NAME[abbr]] = count
                except ValueError:
                    pass
    
    return cities


def calculate_glitches(count: int, threshold: int) -> tuple:
    """Calculate glitches, remaining, and if odd"""
    glitches = count // threshold
    remaining = count % threshold
    is_odd = glitches % 2 == 1
    return glitches, remaining, is_odd


def analyze_all_cities(cities: Dict[str, Dict[str, int]]) -> Dict:
    """Analyze all cities and return comprehensive data"""
    results = {
        "cities": {},
        "totals": defaultdict(int),
        "even_glitches": [],
        "odd_glitches": [],
        "total_food_generated": 0,
        "total_food_consumed": 0,
        "summary": {}
    }
    
    for city_name, troops in cities.items():
        city_data = {
            "troops": troops,
            "glitches": {},
            "food_generated": 0,
            "food_consumed": 0,
            "generating": [],
            "not_generating": [],
            "no_glitches": []
        }
        
        for troop in TROOP_TYPES:
            count = troops.get(troop.name, 0)
            glitches, remaining, is_odd = calculate_glitches(count, troop.city_threshold)
            food_cost = count * troop.food_cost
            
            results["totals"][troop.name] += count
            city_data["food_consumed"] += food_cost
            
            city_data["glitches"][troop.name] = {
                "count": count,
                "glitches": glitches,
                "remaining": remaining,
                "is_odd": is_odd,
                "food_cost": food_cost,
                "fix_amount": remaining + 1 if glitches > 0 and not is_odd else 0
            }
            
            if glitches == 0:
                city_data["no_glitches"].append(troop.name)
            elif is_odd:
                city_data["generating"].append(troop.name)
                city_data["food_generated"] += FOOD_PER_GLITCH
                results["odd_glitches"].append({
                    "city": city_name,
                    "troop": troop.name,
                    "glitches": glitches
                })
            else:
                city_data["not_generating"].append(troop.name)
                results["even_glitches"].append({
                    "city": city_name,
                    "troop": troop.name,
                    "glitches": glitches,
                    "remaining": remaining,
                    "fix_amount": remaining + 1
                })
        
        city_data["net_food"] = city_data["food_generated"] - city_data["food_consumed"]
        results["total_food_generated"] += city_data["food_generated"]
        results["total_food_consumed"] += city_data["food_consumed"]
        results["cities"][city_name] = city_data
    
    results["net_food"] = results["total_food_generated"] - results["total_food_consumed"]
    return results


def find_best_destination(cities_data: Dict, source_city: str, troop_name: str, 
                          amount: int) -> Optional[str]:
    """Find best city to receive troops without breaking glitches"""
    troop = NAME_TO_TROOP[troop_name]
    best_dest = None
    best_score = -999
    
    for city_name, city_data in cities_data.items():
        if city_name == source_city:
            continue
        
        current_glitches = city_data["glitches"][troop_name]["glitches"]
        current_count = city_data["glitches"][troop_name]["count"]
        current_is_odd = city_data["glitches"][troop_name]["is_odd"]
        
        # Calculate new state
        new_count = current_count + amount
        new_glitches = new_count // troop.city_threshold
        new_is_odd = new_glitches % 2 == 1
        
        # Score destinations
        score = 0
        if current_glitches == 0:
            # No glitches - check if receiving creates ODD
            if new_is_odd:
                score = 100  # Creates new ODD glitch - great!
            else:
                score = 50  # Creates EVEN - okay but not ideal
        elif current_is_odd:
            if new_is_odd:
                score = 80  # Stays ODD - good
            else:
                score = -100  # Would break ODD - bad!
        else:  # Currently EVEN
            if new_is_odd:
                score = 95  # Fixes EVEN to ODD - excellent!
            else:
                score = 20  # Stays EVEN - no improvement
        
        if score > best_score:
            best_score = score
            best_dest = city_name
    
    return best_dest if best_score > 0 else None


def generate_optimization_plan(analysis: Dict) -> List[Dict]:
    """Generate optimization commands"""
    commands = []
    
    # Sort EVEN glitches by fix amount (easiest first)
    even_sorted = sorted(analysis["even_glitches"], key=lambda x: x["fix_amount"])
    
    for eg in even_sorted:
        fix_amount = eg["fix_amount"]
        city = eg["city"]
        troop = eg["troop"]
        
        if fix_amount >= 1_000_000:
            # Large amount - try to MOVE
            dest = find_best_destination(analysis["cities"], city, troop, fix_amount)
            if dest:
                commands.append({
                    "action": "move",
                    "city": city,
                    "dest": dest,
                    "troop": troop,
                    "abbr": NAME_TO_TROOP[troop].abbr,
                    "amount": fix_amount,
                    "reason": f"Fix EVEN ({eg['glitches']} → {eg['glitches']-1} ODD)"
                })
            else:
                commands.append({
                    "action": "untrain",
                    "city": city,
                    "troop": troop,
                    "abbr": NAME_TO_TROOP[troop].abbr,
                    "amount": fix_amount,
                    "reason": f"Fix EVEN (no safe dest)"
                })
        else:
            # Small amount - UNTRAIN
            commands.append({
                "action": "untrain",
                "city": city,
                "troop": troop,
                "abbr": NAME_TO_TROOP[troop].abbr,
                "amount": fix_amount,
                "reason": f"Fix EVEN ({eg['glitches']} → {eg['glitches']-1} ODD)"
            })
    
    return commands


def print_analysis(analysis: Dict):
    """Print comprehensive analysis"""
    print("\n" + "═"*80)
    print("  MULTI-CITY GLITCH ANALYSIS")
    print("═"*80)
    
    total_troops = sum(analysis["totals"].values())
    print(f"\n  Total Cities: {len(analysis['cities'])}")
    print(f"  Total Troops: {total_troops:,}")
    print(f"  Food Generated: +{analysis['total_food_generated']:,}/hr")
    print(f"  Food Consumed: -{analysis['total_food_consumed']:,}/hr")
    
    net = analysis['net_food']
    sign = "+" if net > 0 else ""
    print(f"  NET FOOD: {sign}{net:,}/hr")
    
    print(f"\n  ODD glitches (generating): {len(analysis['odd_glitches'])}")
    print(f"  EVEN glitches (to fix): {len(analysis['even_glitches'])}")
    
    # Per-city breakdown
    print("\n" + "─"*80)
    print("  PER-CITY BREAKDOWN")
    print("─"*80)
    
    for city_name, city_data in analysis["cities"].items():
        gen_count = len(city_data["generating"])
        not_gen_count = len(city_data["not_generating"])
        net = city_data["net_food"]
        sign = "+" if net > 0 else ""
        
        print(f"\n  {city_name}")
        print(f"    Generating: {gen_count} types | Not Generating: {not_gen_count} types")
        print(f"    Food: +{city_data['food_generated']:,} gen, -{city_data['food_consumed']:,} consumed")
        print(f"    Net: {sign}{net:,}/hr")
        
        if city_data["not_generating"]:
            print(f"    EVEN (fix): ", end="")
            for troop in city_data["not_generating"]:
                g = city_data["glitches"][troop]
                print(f"{troop}({g['glitches']}) ", end="")
            print()


def print_commands(commands: List[Dict]):
    """Print optimization commands"""
    print("\n" + "═"*80)
    print("  OPTIMIZATION COMMANDS")
    print("═"*80)
    
    # Group by city
    by_city = defaultdict(list)
    for cmd in commands:
        by_city[cmd["city"]].append(cmd)
    
    for city, cmds in by_city.items():
        print(f"\n  === {city} ===")
        for cmd in cmds:
            if cmd["action"] == "untrain":
                print(f"  untrain {cmd['abbr']}:{cmd['amount']}")
                print(f"    # {cmd['reason']}")
            else:
                print(f"  reinforce {cmd['dest']} none {cmd['abbr']}:{cmd['amount']}")
                print(f"    # {cmd['reason']} → {cmd['dest']}")


def generate_script(commands: List[Dict]) -> str:
    """Generate AutoEvony script"""
    lines = [
        "#" + "="*70,
        "# AI-GENERATED GLITCH FIX COMMANDS",
        "# Generated by Glitch Optimizer AI",
        "#" + "="*70,
        "",
        "setsilence true",
        ""
    ]
    
    by_city = defaultdict(list)
    for cmd in commands:
        by_city[cmd["city"]].append(cmd)
    
    for city, cmds in by_city.items():
        lines.append(f"# ═══ {city} ═══")
        lines.append(f"# Switch to {city} first!")
        lines.append("")
        
        for cmd in cmds:
            lines.append(f"# {cmd['reason']}")
            if cmd["action"] == "untrain":
                lines.append(f"untrain {cmd['abbr']}:{cmd['amount']}")
            else:
                lines.append(f"reinforce {cmd['dest']} none {cmd['abbr']}:{cmd['amount']}")
            lines.append("")
        lines.append("")
    
    lines.append("setsilence false")
    lines.append("echo 'Glitch fixes complete!'")
    
    return "\n".join(lines)


def main():
    print("\n" + "█"*80)
    print("█" + " "*78 + "█")
    print("█" + "  AI GLITCH OPTIMIZER - MULTI-CITY ANALYZER".center(78) + "█")
    print("█" + " "*78 + "█")
    print("█"*80)
    
    print("\n  Paste your PerCity_TroopCollector output below.")
    print("  Include everything between START_DATA and END_DATA.")
    print("  When done, press Enter twice (empty line):\n")
    
    lines = []
    empty_count = 0
    while True:
        try:
            line = input()
            if line.strip() == "":
                empty_count += 1
                if empty_count >= 2:
                    break
            else:
                empty_count = 0
                lines.append(line)
        except EOFError:
            break
    
    text = "\n".join(lines)
    
    if "CITY:" not in text:
        print("\n  ERROR: No city data found!")
        print("  Make sure you ran PerCity_TroopCollector.txt in-game")
        print("  and copied the output between START_DATA and END_DATA")
        return
    
    # Parse the data
    print("\n  Parsing city data...")
    cities = parse_collector_output(text)
    print(f"  Found {len(cities)} cities")
    
    # Analyze
    print("  Analyzing glitches...")
    analysis = analyze_all_cities(cities)
    
    # Print analysis
    print_analysis(analysis)
    
    # Generate commands
    print("\n  Generating optimization plan...")
    commands = generate_optimization_plan(analysis)
    
    if commands:
        print_commands(commands)
        
        # Generate script
        script = generate_script(commands)
        script_path = "evony_scripts/AI_GlitchFix_Commands.txt"
        with open(script_path, "w") as f:
            f.write(script)
        print(f"\n  Script saved to: {script_path}")
        
        # Summary
        untrain_total = sum(c["amount"] for c in commands if c["action"] == "untrain")
        move_total = sum(c["amount"] for c in commands if c["action"] == "move")
        fixes = len(commands)
        
        print("\n" + "═"*80)
        print("  OPTIMIZATION SUMMARY")
        print("═"*80)
        print(f"\n  Total EVEN glitches to fix: {fixes}")
        print(f"  Troops to untrain: {untrain_total:,}")
        print(f"  Troops to move: {move_total:,}")
        print(f"\n  Expected additional food: +{fixes * FOOD_PER_GLITCH:,}/hr")
        print(f"  New total generated: +{analysis['total_food_generated'] + fixes * FOOD_PER_GLITCH:,}/hr")
    else:
        print("\n  ✓ All glitches are already ODD! No fixes needed.")


if __name__ == "__main__":
    main()
