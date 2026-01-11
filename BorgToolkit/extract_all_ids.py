#!/usr/bin/env python3
"""
Extract ALL IDs from Evony game dump for reverse engineering index
"""

import json
import os
from collections import defaultdict

def extract_all_ids(json_path):
    with open(json_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    player = data.get('login_data', {}).get('player', {})
    castles = player.get('castles', [])
    
    ids = {
        'items': set(),
        'buildings': {},  # typeId -> name
        'troops': set(),
        'buffs': set(),
        'hero_status': set(),
        'building_positions': set(),
        'fortifications': {},
        'quest_types': set(),
        'equipment': set(),
    }
    
    # ITEMS - Extract all item IDs
    for item in player.get('items', []):
        ids['items'].add(item.get('id', ''))
    
    # BUFFS
    for buff in player.get('buffs', []):
        ids['buffs'].add(buff.get('typeId', ''))
    
    # EQUIPMENT
    for eq in player.get('equipments', []):
        if isinstance(eq, dict):
            ids['equipment'].add(str(eq))
    
    # Per-castle data
    for castle in castles:
        # BUILDINGS
        for bldg in castle.get('buildings', []):
            type_id = bldg.get('typeId', 0)
            name = bldg.get('name', 'Unknown')
            ids['buildings'][type_id] = name
            ids['building_positions'].add(bldg.get('positionId', 0))
        
        # FORTIFICATIONS
        fort = castle.get('fortification', {})
        if isinstance(fort, dict):
            for key in fort.keys():
                ids['fortifications'][key] = fort.get(key, 0)
        
        # TROOPS (keys from troop object)
        troop = castle.get('troop', {})
        for key in troop.keys():
            ids['troops'].add(key)
        
        # HERO STATUS
        for hero in castle.get('heros', []):
            ids['hero_status'].add(hero.get('status', ''))
        
        # CASTLE BUFFS
        for buff in castle.get('buffs', []):
            if isinstance(buff, dict):
                ids['buffs'].add(buff.get('typeId', ''))
    
    return ids, data

def generate_markdown(ids, data):
    player = data.get('login_data', {}).get('player', {})
    castles = player.get('castles', [])
    
    md = []
    md.append("# Evony Game IDs - Reverse Engineering Index")
    md.append(f"\n*Extracted from account data dump*\n")
    md.append("---\n")
    
    # TROOP IDs
    md.append("## Troop Type IDs\n")
    md.append("| Internal Name | Display Name | Food/Troop | Short Code |")
    md.append("|---------------|--------------|------------|------------|")
    troop_info = {
        'peasants': ('Workers', 1, 'wo'),
        'militia': ('Warriors', 1, 'w'),
        'scouter': ('Scouts', 2, 's'),
        'pikemen': ('Pikemen', 3, 'p'),
        'swordsmen': ('Swordsmen', 3, 'sw'),
        'archer': ('Archers', 4, 'a'),
        'lightCavalry': ('Cavalry', 9, 'c'),
        'heavyCavalry': ('Cataphracts', 17, 'cata'),
        'carriage': ('Transporters', 5, 't'),
        'ballista': ('Ballista', 25, 'b'),
        'batteringRam': ('Battering Rams', 50, 'r'),
        'catapult': ('Catapults', 125, 'cp'),
    }
    for tid in sorted(ids['troops']):
        info = troop_info.get(tid, ('Unknown', 0, '?'))
        md.append(f"| `{tid}` | {info[0]} | {info[1]} | `{info[2]}` |")
    
    # BUILDING IDs
    md.append("\n## Building Type IDs\n")
    md.append("| Type ID | Building Name |")
    md.append("|---------|---------------|")
    for type_id in sorted(ids['buildings'].keys()):
        name = ids['buildings'][type_id]
        md.append(f"| `{type_id}` | {name} |")
    
    # BUILDING POSITIONS
    md.append("\n## Building Position IDs\n")
    md.append("| Position ID | Location |")
    md.append("|-------------|----------|")
    positions = sorted(ids['building_positions'])
    pos_map = {
        -2: 'Walls', -1: 'Town Hall',
        0: 'Inside City Slot 0', 1: 'Inside City Slot 1',
    }
    for pos in positions[:30]:  # First 30
        loc = pos_map.get(pos, f'Slot {pos}' if pos < 30 else f'Field Slot {pos-1000}' if pos >= 1000 else f'Unknown')
        md.append(f"| `{pos}` | {loc} |")
    if len(positions) > 30:
        md.append(f"| ... | *{len(positions)-30} more positions* |")
    
    # ITEM IDs
    md.append("\n## Item IDs\n")
    md.append("| Item ID | Count |")
    md.append("|---------|-------|")
    items = player.get('items', [])
    items_sorted = sorted(items, key=lambda x: x.get('count', 0), reverse=True)
    for item in items_sorted:
        item_id = item.get('id', '')
        count = item.get('count', 0)
        md.append(f"| `{item_id}` | {count:,} |")
    
    # BUFF IDs
    md.append("\n## Buff Type IDs\n")
    md.append("| Buff Type ID | Description |")
    md.append("|--------------|-------------|")
    buffs = player.get('buffs', [])
    for buff in buffs:
        md.append(f"| `{buff.get('typeId', '')}` | {buff.get('descName', '')} |")
    
    # FORTIFICATION IDs
    md.append("\n## Fortification IDs\n")
    md.append("| Fortification Key | Sample Value |")
    md.append("|-------------------|--------------|")
    for key in sorted(ids['fortifications'].keys()):
        md.append(f"| `{key}` | {ids['fortifications'][key]} |")
    
    # HERO STATUS
    md.append("\n## Hero Status IDs\n")
    md.append("| Status |")
    md.append("|--------|")
    for status in sorted(ids['hero_status']):
        if status:
            md.append(f"| `{status}` |")
    
    # RESOURCE KEYS
    md.append("\n## Resource Keys\n")
    md.append("| Key | Description |")
    md.append("|-----|-------------|")
    res_keys = ['gold', 'food', 'wood', 'stone', 'iron', 'curPopulation', 
                'maxPopulation', 'workPeople', 'support', 'taxIncome', 
                'texRate', 'troopCostFood']
    for key in res_keys:
        md.append(f"| `{key}` | Resource: {key} |")
    
    # CASTLE KEYS
    md.append("\n## Castle Object Keys\n")
    md.append("| Key | Type |")
    md.append("|-----|------|")
    if castles:
        for key in sorted(castles[0].keys()):
            val = castles[0].get(key)
            type_name = type(val).__name__
            md.append(f"| `{key}` | {type_name} |")
    
    # HERO OBJECT KEYS
    md.append("\n## Hero Object Keys\n")
    md.append("| Key | Description |")
    md.append("|-----|-------------|")
    hero_keys = ['name', 'level', 'power', 'management', 'stratagem', 
                 'experience', 'status', 'loyalty', 'itemId', 'heroId']
    for key in hero_keys:
        md.append(f"| `{key}` | Hero {key} |")
    
    # PLAYER INFO KEYS
    md.append("\n## Player Info Keys\n")
    md.append("| Key | Sample Value |")
    md.append("|-----|--------------|")
    player_info = player.get('playerInfo', {})
    for key in sorted(player_info.keys())[:20]:
        val = player_info.get(key)
        if isinstance(val, (str, int, float, bool)):
            md.append(f"| `{key}` | {val} |")
    
    # GLITCH CONSTANTS
    md.append("\n## Food Glitch Constants\n")
    md.append("| Constant | Value |")
    md.append("|----------|-------|")
    md.append("| `GLITCH_THRESHOLD` | 2,147,483,647 (2^31-1) |")
    md.append("| `MAP_WIDTH` | 800 |")
    md.append("| `fieldId to coords` | x = fieldId % 800, y = fieldId // 800 |")
    
    # TROOP GLITCH THRESHOLDS
    md.append("\n## Troops Per Glitch (Threshold)\n")
    md.append("| Troop | Food/Troop | Troops Per Glitch |")
    md.append("|-------|------------|-------------------|")
    for tid, info in troop_info.items():
        food = info[1]
        threshold = (2147483647 // food) + 1
        md.append(f"| {info[0]} | {food} | {threshold:,} |")
    
    return "\n".join(md)

def main():
    dumps_dir = os.path.join(os.path.dirname(__file__), 'data', 'dumps')
    json_files = sorted([f for f in os.listdir(dumps_dir) if f.endswith('.json')])
    
    if not json_files:
        print("No JSON dump files found")
        return
    
    latest_file = json_files[-1]
    json_path = os.path.join(dumps_dir, latest_file)
    
    print(f"Extracting IDs from: {latest_file}")
    
    ids, data = extract_all_ids(json_path)
    markdown = generate_markdown(ids, data)
    
    # Save markdown
    output_file = os.path.join(os.path.dirname(__file__), 'docs', 'EVONY_GAME_IDS.md')
    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(markdown)
    
    print(f"Saved: {output_file}")
    print(f"\nExtracted:")
    print(f"  Items: {len(ids['items'])}")
    print(f"  Buildings: {len(ids['buildings'])}")
    print(f"  Troops: {len(ids['troops'])}")
    print(f"  Buffs: {len(ids['buffs'])}")
    print(f"  Fortifications: {len(ids['fortifications'])}")

if __name__ == "__main__":
    main()
