#!/usr/bin/env python3
"""
Analyze FULL JSON dump structure to find ALL data
"""
import json
import os

def count_keys(obj, prefix="", depth=0, max_depth=4):
    """Recursively count all keys and their types"""
    results = []
    
    if depth > max_depth:
        return results
    
    if isinstance(obj, dict):
        for key, val in obj.items():
            full_key = f"{prefix}.{key}" if prefix else key
            val_type = type(val).__name__
            
            if isinstance(val, list):
                results.append((full_key, f"list[{len(val)}]"))
                if val and len(val) > 0:
                    results.extend(count_keys(val[0], f"{full_key}[0]", depth+1, max_depth))
            elif isinstance(val, dict):
                results.append((full_key, f"dict[{len(val)} keys]"))
                results.extend(count_keys(val, full_key, depth+1, max_depth))
            else:
                results.append((full_key, val_type))
    
    return results

def main():
    dumps_dir = os.path.join(os.path.dirname(__file__), 'data', 'dumps')
    json_files = sorted([f for f in os.listdir(dumps_dir) if f.endswith('.json')])
    latest_file = json_files[-1]
    json_path = os.path.join(dumps_dir, latest_file)
    
    print(f"Analyzing: {latest_file}")
    print(f"File size: {os.path.getsize(json_path):,} bytes")
    print()
    
    with open(json_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    # Get all top-level keys
    print("=" * 60)
    print("TOP LEVEL KEYS")
    print("=" * 60)
    for key in sorted(data.keys()):
        val = data[key]
        if val is None:
            print(f"  {key}: NULL")
        elif isinstance(val, list):
            print(f"  {key}: list[{len(val)}]")
        elif isinstance(val, dict):
            print(f"  {key}: dict[{len(val)} keys]")
        else:
            print(f"  {key}: {type(val).__name__}")
    
    # Analyze login_data.player structure
    player = data.get('login_data', {}).get('player', {})
    
    print()
    print("=" * 60)
    print("PLAYER OBJECT KEYS (login_data.player)")
    print("=" * 60)
    for key in sorted(player.keys()):
        val = player[key]
        if val is None:
            print(f"  {key}: NULL")
        elif isinstance(val, list):
            print(f"  {key}: list[{len(val)}]")
        elif isinstance(val, dict):
            print(f"  {key}: dict[{len(val)} keys]")
        else:
            print(f"  {key}: {type(val).__name__} = {str(val)[:50]}")
    
    # Analyze castle structure
    castles = player.get('castles', [])
    if castles:
        print()
        print("=" * 60)
        print("CASTLE[0] STRUCTURE")
        print("=" * 60)
        castle = castles[0]
        for key in sorted(castle.keys()):
            val = castle[key]
            if val is None:
                print(f"  {key}: NULL")
            elif isinstance(val, list):
                print(f"  {key}: list[{len(val)}]")
            elif isinstance(val, dict):
                print(f"  {key}: dict[{len(val)} keys]")
            else:
                print(f"  {key}: {type(val).__name__}")
    
    # Analyze hero structure
    heroes = castles[0].get('heros', []) if castles else []
    if heroes:
        print()
        print("=" * 60)
        print("HERO[0] STRUCTURE")
        print("=" * 60)
        hero = heroes[0]
        for key in sorted(hero.keys()):
            val = hero[key]
            print(f"  {key}: {type(val).__name__} = {str(val)[:50]}")
    
    # Count total data
    print()
    print("=" * 60)
    print("DATA COUNTS")
    print("=" * 60)
    
    counts = {
        'castles': len(player.get('castles', [])),
        'items': len(player.get('items', [])),
        'buffs': len(player.get('buffs', [])),
        'equipments': len(player.get('equipments', [])),
        'friendBeans': len(player.get('friendBeans', [])),
        'selfArmys': len(player.get('selfArmys', [])),
        'friendArmys': len(player.get('friendArmys', [])),
        'enemyArmys': len(player.get('enemyArmys', [])),
        'castleSignBean': len(player.get('castleSignBean', [])),
        'saleItemBeans': len(player.get('saleItemBeans', [])),
        'saleTypeBeans': len(player.get('saleTypeBeans', [])),
        'troopConfigBeans': len(player.get('troopConfigBeans', [])),
        'randomEvents': len(player.get('randomEvents', [])),
        'declaredWarBeans': len(player.get('declaredWarBeans', [])),
    }
    
    total_heroes = 0
    total_buildings = 0
    total_colonies = 0
    for castle in player.get('castles', []):
        total_heroes += len(castle.get('heros', []))
        total_buildings += len(castle.get('buildings', []))
        total_colonies += len(castle.get('colonyBeans', []))
    
    counts['total_heroes'] = total_heroes
    counts['total_buildings'] = total_buildings
    counts['total_colonies'] = total_colonies
    
    for key, val in sorted(counts.items()):
        print(f"  {key}: {val}")
    
    # Estimate total extraction work
    print()
    print("=" * 60)
    print("EXTRACTION STAGES NEEDED")
    print("=" * 60)
    stages = [
        ("Stage 1", "Basic IDs (troops, buildings, items)", "DONE"),
        ("Stage 2", f"Heroes ({total_heroes} heroes, all properties)", "TODO"),
        ("Stage 3", f"Armies ({counts['selfArmys']} self, {counts['friendArmys']} friend, {counts['enemyArmys']} enemy)", "TODO"),
        ("Stage 4", f"Colonies ({total_colonies} total)", "TODO"),
        ("Stage 5", f"Shop/Sale ({counts['saleItemBeans']} items, {counts['saleTypeBeans']} types)", "TODO"),
        ("Stage 6", f"Friends ({counts['friendBeans']} friends)", "TODO"),
        ("Stage 7", f"Map markers ({counts['castleSignBean']} signs)", "TODO"),
        ("Stage 8", f"Troop configs ({counts['troopConfigBeans']} configs)", "TODO"),
        ("Stage 9", "Player info, alliance, remaining data", "TODO"),
    ]
    
    for stage, desc, status in stages:
        print(f"  {stage}: {desc} [{status}]")

if __name__ == "__main__":
    main()
