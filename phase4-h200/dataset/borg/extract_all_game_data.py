#!/usr/bin/env python3
"""
COMPLETE Evony Game Data Extraction - ALL IDs and Structures
Extracts 100% of data from the 3.2MB JSON dump
"""

import json
import os
from datetime import datetime

def get_safe(val, default=""):
    """Safely get value"""
    if val is None:
        return default
    return val

def main():
    dumps_dir = os.path.join(os.path.dirname(__file__), 'data', 'dumps')
    json_files = sorted([f for f in os.listdir(dumps_dir) if f.endswith('.json')])
    latest_file = json_files[-1]
    json_path = os.path.join(dumps_dir, latest_file)
    
    print(f"Loading: {latest_file} ({os.path.getsize(json_path):,} bytes)")
    
    with open(json_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    player = data.get('login_data', {}).get('player', {})
    castles = player.get('castles', [])
    
    md = []
    md.append("# Evony Game Data - Complete Reverse Engineering Index")
    md.append(f"\n**File:** {latest_file}")
    md.append(f"**Size:** {os.path.getsize(json_path):,} bytes")
    md.append(f"**Extracted:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    md.append("\n---\n")
    
    # ================================================================
    # STAGE 1: TROOP IDs
    # ================================================================
    print("Stage 1: Troop IDs...")
    md.append("# Stage 1: Troop Type IDs\n")
    md.append("| Internal Name | Display Name | Food/Troop | Short Code | Troops/Glitch |")
    md.append("|---------------|--------------|------------|------------|---------------|")
    
    troop_info = [
        ('peasants', 'Workers', 1, 'wo'),
        ('militia', 'Warriors', 1, 'w'),
        ('scouter', 'Scouts', 2, 's'),
        ('pikemen', 'Pikemen', 3, 'p'),
        ('swordsmen', 'Swordsmen', 3, 'sw'),
        ('archer', 'Archers', 4, 'a'),
        ('lightCavalry', 'Cavalry', 9, 'c'),
        ('heavyCavalry', 'Cataphracts', 17, 'cata'),
        ('carriage', 'Transporters', 5, 't'),
        ('ballista', 'Ballista', 25, 'b'),
        ('batteringRam', 'Battering Rams', 50, 'r'),
        ('catapult', 'Catapults', 125, 'cp'),
    ]
    for tid, name, food, short in troop_info:
        threshold = (2147483647 // food) + 1
        md.append(f"| `{tid}` | {name} | {food} | `{short}` | {threshold:,} |")
    
    # ================================================================
    # STAGE 2: BUILDING IDs
    # ================================================================
    print("Stage 2: Building IDs...")
    md.append("\n# Stage 2: Building Type IDs\n")
    md.append("| Type ID | Building Name |")
    md.append("|---------|---------------|")
    
    buildings = {}
    for castle in castles:
        for bldg in castle.get('buildings', []):
            buildings[bldg.get('typeId', 0)] = bldg.get('name', 'Unknown')
    
    for tid in sorted(buildings.keys()):
        md.append(f"| `{tid}` | {buildings[tid]} |")
    
    # ================================================================
    # STAGE 3: ALL ITEM IDs (196 items)
    # ================================================================
    print("Stage 3: Item IDs (196)...")
    md.append("\n# Stage 3: Item IDs (Full Inventory)\n")
    md.append("| Item ID | Count | Category |")
    md.append("|---------|-------|----------|")
    
    items = player.get('items', [])
    items_sorted = sorted(items, key=lambda x: x.get('count', 0), reverse=True)
    
    for item in items_sorted:
        item_id = item.get('id', '')
        count = item.get('count', 0)
        # Categorize
        if item_id.startswith('consume'):
            cat = 'Consumable'
        elif item_id.startswith('player.box'):
            cat = 'Chest/Box'
        elif item_id.startswith('player.trick'):
            cat = 'Stratagem'
        elif item_id.startswith('hero'):
            cat = 'Hero Item'
        elif item_id.startswith('equipment'):
            cat = 'Equipment'
        elif item_id.startswith('player.resinc'):
            cat = 'Resource Boost'
        elif item_id.startswith('player.troop'):
            cat = 'Troop Boost'
        elif item_id.startswith('player.attackinc'):
            cat = 'Attack Boost'
        elif item_id.startswith('player.defendinc'):
            cat = 'Defense Boost'
        elif item_id.startswith('enhanced'):
            cat = 'Enhancement'
        else:
            cat = 'Other'
        md.append(f"| `{item_id}` | {count:,} | {cat} |")
    
    # ================================================================
    # STAGE 4: HERO DATA (98 heroes, 35 properties each)
    # ================================================================
    print("Stage 4: Hero Data (98 heroes)...")
    md.append("\n# Stage 4: Hero Data\n")
    md.append("## Hero Object Properties\n")
    
    if castles and castles[0].get('heros'):
        hero = castles[0]['heros'][0]
        md.append("| Property | Type | Description |")
        md.append("|----------|------|-------------|")
        for key in sorted(hero.keys()):
            val = hero[key]
            md.append(f"| `{key}` | {type(val).__name__} | Hero {key} |")
    
    md.append("\n## All Heroes by City\n")
    md.append("| City | Hero Name | Level | Politics | Attack | Intel | Loyalty | Status |")
    md.append("|------|-----------|-------|----------|--------|-------|---------|--------|")
    
    for castle in castles:
        city = castle.get('name', 'Unknown')
        for hero in castle.get('heros', []):
            md.append(f"| {city} | {hero.get('name','')} | {hero.get('level',0)} | {int(hero.get('politics',0))} | {hero.get('power',0)} | {hero.get('stratagem',0)} | {hero.get('loyalty',0)} | {hero.get('status',0)} |")
    
    # ================================================================
    # STAGE 5: EQUIPMENT DATA
    # ================================================================
    print("Stage 5: Equipment Data (14)...")
    md.append("\n# Stage 5: Equipment Data\n")
    md.append("| # | Equipment Details |")
    md.append("|---|-------------------|")
    
    for i, eq in enumerate(player.get('equipments', [])):
        md.append(f"| {i+1} | `{str(eq)[:100]}...` |")
    
    # Hero equipment
    md.append("\n## Hero Equipment (from heroes)\n")
    md.append("| Hero | Equipment |")
    md.append("|------|-----------|")
    
    for castle in castles:
        for hero in castle.get('heros', []):
            eq = hero.get('equipmentbean', [])
            if eq:
                md.append(f"| {hero.get('name','')} | {len(eq)} items |")
    
    # ================================================================
    # STAGE 6: COLONY DATA (58 colonies)
    # ================================================================
    print("Stage 6: Colony Data (58)...")
    md.append("\n# Stage 6: Colony Data\n")
    md.append("| Owner City | Colony Name | Lord | Alliance | Can Levy |")
    md.append("|------------|-------------|------|----------|----------|")
    
    for castle in castles:
        city = castle.get('name', 'Unknown')
        for col in castle.get('colonyBeans', []):
            md.append(f"| {city} | {col.get('cityName','')} | {col.get('lordName','')} | {col.get('allianceName','')} | {'Yes' if col.get('isCanLevy') else 'No'} |")
    
    # ================================================================
    # STAGE 7: FRIENDS LIST (252)
    # ================================================================
    print("Stage 7: Friends List (252)...")
    md.append("\n# Stage 7: Friends List\n")
    md.append("| # | Friend Data |")
    md.append("|---|-------------|")
    
    friends = player.get('friendBeans', [])
    for i, friend in enumerate(friends[:50]):  # First 50
        md.append(f"| {i+1} | `{str(friend)[:80]}...` |")
    if len(friends) > 50:
        md.append(f"| ... | *{len(friends)-50} more friends* |")
    
    # Friend object structure
    if friends:
        md.append("\n## Friend Object Properties\n")
        md.append("| Property | Type |")
        md.append("|----------|------|")
        for key in sorted(friends[0].keys()):
            md.append(f"| `{key}` | {type(friends[0][key]).__name__} |")
    
    # ================================================================
    # STAGE 8: SHOP/SALE DATA
    # ================================================================
    print("Stage 8: Shop/Sale Data...")
    md.append("\n# Stage 8: Shop/Sale Data\n")
    md.append("## Sale Item Beans (18)\n")
    md.append("| # | Sale Item |")
    md.append("|---|-----------|")
    
    for i, item in enumerate(player.get('saleItemBeans', [])):
        md.append(f"| {i+1} | `{str(item)[:100]}` |")
    
    md.append("\n## Sale Type Beans (6)\n")
    md.append("| # | Sale Type |")
    md.append("|---|-----------|")
    
    for i, item in enumerate(player.get('saleTypeBeans', [])):
        md.append(f"| {i+1} | `{str(item)[:100]}` |")
    
    # ================================================================
    # STAGE 9: ARMY DATA
    # ================================================================
    print("Stage 9: Army Data...")
    md.append("\n# Stage 9: Army Data\n")
    
    self_armies = player.get('selfArmys', [])
    md.append(f"## Self Armies ({len(self_armies)})\n")
    if self_armies:
        md.append("| # | Army Data |")
        md.append("|---|-----------|")
        for i, army in enumerate(self_armies):
            md.append(f"| {i+1} | `{str(army)[:150]}...` |")
        
        # Army object structure
        md.append("\n### Army Object Properties\n")
        md.append("| Property | Type |")
        md.append("|----------|------|")
        for key in sorted(self_armies[0].keys()):
            md.append(f"| `{key}` | {type(self_armies[0][key]).__name__} |")
    
    # ================================================================
    # STAGE 10: TROOP CONFIG BEANS
    # ================================================================
    print("Stage 10: Troop Configs...")
    md.append("\n# Stage 10: Troop Config Beans\n")
    md.append("| # | Config |")
    md.append("|---|--------|")
    
    for i, cfg in enumerate(player.get('troopConfigBeans', [])):
        md.append(f"| {i+1} | `{str(cfg)}` |")
    
    # ================================================================
    # STAGE 11: RANDOM EVENTS (41)
    # ================================================================
    print("Stage 11: Random Events (41)...")
    md.append("\n# Stage 11: Random Events\n")
    md.append("| # | Event |")
    md.append("|---|-------|")
    
    for i, event in enumerate(player.get('randomEvents', [])):
        md.append(f"| {i+1} | `{str(event)[:100]}` |")
    
    # ================================================================
    # STAGE 12: FORTIFICATION DATA
    # ================================================================
    print("Stage 12: Fortification Data...")
    md.append("\n# Stage 12: Fortification Data\n")
    md.append("| City | Abatis | Arrow Tower | Traps | Rolling Logs | Rockfall |")
    md.append("|------|--------|-------------|-------|--------------|----------|")
    
    for castle in castles:
        city = castle.get('name', 'Unknown')
        fort = castle.get('fortification', {})
        md.append(f"| {city} | {fort.get('abatis',0)} | {fort.get('arrowTower',0)} | {fort.get('trap',0)} | {fort.get('rollingLogs',0)} | {fort.get('rockfall',0)} |")
    
    # ================================================================
    # STAGE 13: RESOURCE DATA
    # ================================================================
    print("Stage 13: Resource Data...")
    md.append("\n# Stage 13: Resource Data by City\n")
    md.append("| City | Gold | Food | Wood | Stone | Iron | Population |")
    md.append("|------|------|------|------|-------|------|------------|")
    
    for castle in castles:
        city = castle.get('name', 'Unknown')
        res = castle.get('resource', {})
        
        def get_res(r, key):
            val = r.get(key, 0)
            if isinstance(val, dict):
                return int(float(val.get('amount', 0)))
            return int(float(val)) if val else 0
        
        md.append(f"| {city} | {get_res(res,'gold'):,} | {get_res(res,'food'):,} | {get_res(res,'wood'):,} | {get_res(res,'stone'):,} | {get_res(res,'iron'):,} | {int(float(res.get('curPopulation',0))):,} |")
    
    # Resource object structure
    md.append("\n## Resource Object Properties\n")
    md.append("| Property | Type |")
    md.append("|----------|------|")
    if castles:
        res = castles[0].get('resource', {})
        for key in sorted(res.keys()):
            md.append(f"| `{key}` | {type(res[key]).__name__} |")
    
    # ================================================================
    # STAGE 14: PLAYER INFO
    # ================================================================
    print("Stage 14: Player Info...")
    md.append("\n# Stage 14: Player Info\n")
    md.append("| Property | Value |")
    md.append("|----------|-------|")
    
    player_info = player.get('playerInfo', {})
    for key in sorted(player_info.keys()):
        val = player_info[key]
        if isinstance(val, (str, int, float, bool)):
            md.append(f"| `{key}` | {val} |")
    
    # ================================================================
    # STAGE 15: CASTLE SIGN BEANS (Map Markers)
    # ================================================================
    print("Stage 15: Map Markers...")
    md.append("\n# Stage 15: Castle Sign Beans (Map Markers)\n")
    md.append("| # | Name | X | Y | ID |")
    md.append("|---|------|---|---|-----|")
    
    for i, sign in enumerate(player.get('castleSignBean', [])):
        md.append(f"| {i+1} | {sign.get('name','NO NAME')} | {sign.get('x',0)} | {sign.get('y',0)} | {sign.get('id',0)} |")
    
    # ================================================================
    # STAGE 16: BUFFS
    # ================================================================
    print("Stage 16: Buffs...")
    md.append("\n# Stage 16: Active Buffs\n")
    md.append("| Buff Type | Description |")
    md.append("|-----------|-------------|")
    
    for buff in player.get('buffs', []):
        md.append(f"| `{buff.get('typeId','')}` | {buff.get('descName','')} |")
    
    # ================================================================
    # STAGE 17: CASTLE OBJECT STRUCTURE
    # ================================================================
    print("Stage 17: Castle Structure...")
    md.append("\n# Stage 17: Castle Object Structure\n")
    md.append("| Property | Type | Description |")
    md.append("|----------|------|-------------|")
    
    if castles:
        for key in sorted(castles[0].keys()):
            val = castles[0][key]
            vtype = type(val).__name__
            if isinstance(val, list):
                vtype = f"list[{len(val)}]"
            elif isinstance(val, dict):
                vtype = f"dict[{len(val)} keys]"
            md.append(f"| `{key}` | {vtype} | Castle {key} |")
    
    # ================================================================
    # STAGE 18: FIELDS (Valleys)
    # ================================================================
    print("Stage 18: Fields/Valleys...")
    md.append("\n# Stage 18: Fields (Valleys) by City\n")
    md.append("| City | Field Data |")
    md.append("|------|------------|")
    
    for castle in castles:
        city = castle.get('name', 'Unknown')
        fields = castle.get('fields', [])
        for field in fields:
            md.append(f"| {city} | `{str(field)[:100]}` |")
    
    # ================================================================
    # STAGE 19: CONSTANTS
    # ================================================================
    print("Stage 19: Game Constants...")
    md.append("\n# Stage 19: Game Constants\n")
    md.append("| Constant | Value |")
    md.append("|----------|-------|")
    md.append(f"| `mapSizeX` | {player.get('mapSizeX', 800)} |")
    md.append(f"| `mapSizeY` | {player.get('mapSizeY', 800)} |")
    md.append(f"| `gameSpeed` | {player.get('gameSpeed', 1)} |")
    md.append("| `GLITCH_THRESHOLD` | 2,147,483,647 |")
    md.append("| `fieldId to X` | fieldId % 800 |")
    md.append("| `fieldId to Y` | fieldId // 800 |")
    
    # ================================================================
    # SUMMARY
    # ================================================================
    md.append("\n# Summary\n")
    md.append("| Category | Count |")
    md.append("|----------|-------|")
    md.append(f"| Cities | {len(castles)} |")
    md.append(f"| Items | {len(items)} |")
    md.append(f"| Heroes | {sum(len(c.get('heros',[])) for c in castles)} |")
    md.append(f"| Buildings | {sum(len(c.get('buildings',[])) for c in castles)} |")
    md.append(f"| Colonies | {sum(len(c.get('colonyBeans',[])) for c in castles)} |")
    md.append(f"| Friends | {len(player.get('friendBeans',[]))} |")
    md.append(f"| Equipment | {len(player.get('equipments',[]))} |")
    md.append(f"| Random Events | {len(player.get('randomEvents',[]))} |")
    md.append(f"| Building Types | {len(buildings)} |")
    md.append(f"| Troop Types | 12 |")
    
    # Save
    output_file = os.path.join(os.path.dirname(__file__), 'docs', 'EVONY_COMPLETE_DATA.md')
    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("\n".join(md))
    
    print(f"\nSaved: {output_file}")
    print(f"Total lines: {len(md)}")

if __name__ == "__main__":
    main()
