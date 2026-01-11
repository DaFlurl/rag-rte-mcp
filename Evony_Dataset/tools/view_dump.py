"""
Evony Dump Viewer - Per-City Resources & Troops Breakdown
Based on AutoEvony script display format (Troop_&_RSS_Counter, FoodGlitchCounter)
Usage: python view_dump.py [dump_file.json]
"""

import json
import sys
from datetime import datetime
from pathlib import Path

# Food consumption per troop per hour (from FoodGlitchCounterV1.2)
FOOD_PER_TROOP = {
    'peasants': 1,      # Workers
    'militia': 1,       # Warriors  
    'scouter': 2,       # Scouts
    'pikemen': 3,       # Pikemen
    'swordsmen': 3,     # Swordsmen
    'archer': 4,        # Archers
    'lightCavalry': 9,  # Cavalry
    'heavyCavalry': 17, # Cataphracts
    'carriage': 5,      # Transporters
    'ballista': 25,     # Ballista
    'batteringRam': 50, # Battering Rams
    'catapult': 125,    # Catapults
}

TROOP_NAMES = {
    'peasants': 'Workers',
    'militia': 'Warriors',
    'scouter': 'Scouts',
    'pikemen': 'Pikemen',
    'swordsmen': 'Swordsmen',
    'archer': 'Archers',
    'lightCavalry': 'Cavalry',
    'heavyCavalry': 'Cataphracts',
    'carriage': 'Transporters',
    'ballista': 'Ballista',
    'batteringRam': 'Battering Rams',
    'catapult': 'Catapults',
}

TROOP_ORDER = ['peasants', 'militia', 'scouter', 'pikemen', 'swordsmen', 'archer',
               'lightCavalry', 'heavyCavalry', 'carriage', 'ballista', 'batteringRam', 'catapult']

def fmt(n):
    """Format large numbers with commas"""
    try:
        return f"{float(n):,.0f}"
    except:
        return str(n)

def get_resource_amount(res_obj):
    """Extract amount from resource object (can be dict or number)"""
    if isinstance(res_obj, dict):
        return res_obj.get('amount', 0)
    return res_obj or 0

def calc_food_consumption(troop_dict):
    """Calculate total food consumption per hour"""
    total = 0
    for troop_type, count in troop_dict.items():
        count = int(count or 0)
        food_rate = FOOD_PER_TROOP.get(troop_type, 0)
        total += count * food_rate
    return total

def view_dump(dump_path: str):
    """Display dump contents with per-city breakdown"""
    print(f"\n{'='*80}")
    print("EVONY ACCOUNT DATA VIEWER - Per-City Breakdown")
    print(f"{'='*80}")
    print(f"File: {dump_path}\n")
    
    with open(dump_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    login_data = data.get('login_data', {})
    player = login_data.get('player', {})
    player_info = player.get('playerInfo', {})
    castles = player.get('castles', [])
    items = player.get('items', [])
    equipments = player.get('equipments', [])
    buffs = player.get('buffs', [])
    
    # Player Info
    print(f"{'─'*80}")
    print("PLAYER INFO")
    print(f"{'─'*80}")
    print(f"  Name: {player_info.get('userName', 'Unknown')}")
    print(f"  ID: {player_info.get('id', 'Unknown')}")
    
    create_time = player_info.get('createrTime', 0)
    if create_time:
        create_date = datetime.fromtimestamp(create_time / 1000)
        days = (datetime.now() - create_date).days
        print(f"  Account Created: {create_date.strftime('%Y-%m-%d')} ({days} days ago)")
    
    print(f"  Honor: {fmt(player_info.get('honor', 0))}")
    print(f"  Prestige: {fmt(player_info.get('prestige', 0))}")
    print(f"  Ranking: #{player_info.get('ranking', 'N/A')}")
    print(f"  Alliance: {player_info.get('alliance', 'None')}")
    
    # ═══════════════════════════════════════════════════════════════════
    # PER-CITY BREAKDOWN (like scripts display)
    # ═══════════════════════════════════════════════════════════════════
    print(f"\n{'═'*80}")
    print("PER-CITY RESOURCES & TROOPS")
    print(f"{'═'*80}")
    
    total_troops = {}
    total_resources = {'gold': 0, 'food': 0, 'wood': 0, 'stone': 0, 'iron': 0}
    total_food_consumption = 0
    
    for i, castle in enumerate(castles):
        name = castle.get('name', f'City {i+1}')
        cid = castle.get('id', 0)
        heroes = castle.get('heros', [])
        troop = castle.get('troop', {})
        res = castle.get('resource', {})
        
        print(f"\n{'─'*80}")
        print(f"CITY: {name} (ID: {cid})")
        print(f"{'─'*80}")
        
        # Resources
        gold = get_resource_amount(res.get('gold', 0))
        food = get_resource_amount(res.get('food', 0))
        wood = get_resource_amount(res.get('wood', 0))
        stone = get_resource_amount(res.get('stone', 0))
        iron = get_resource_amount(res.get('iron', 0))
        
        total_resources['gold'] += gold
        total_resources['food'] += food
        total_resources['wood'] += wood
        total_resources['stone'] += stone
        total_resources['iron'] += iron
        
        print(f"  RESOURCES:")
        print(f"    Gold:  {fmt(gold):>20}")
        print(f"    Food:  {fmt(food):>20}")
        print(f"    Wood:  {fmt(wood):>20}")
        print(f"    Stone: {fmt(stone):>20}")
        print(f"    Iron:  {fmt(iron):>20}")
        
        # Troops per city
        print(f"\n  TROOPS:")
        city_troop_total = 0
        city_food_consumption = 0
        
        for troop_type in TROOP_ORDER:
            count = int(troop.get(troop_type, 0) or 0)
            if count > 0:
                food_cost = count * FOOD_PER_TROOP.get(troop_type, 0)
                city_food_consumption += food_cost
                total_troops[troop_type] = total_troops.get(troop_type, 0) + count
                city_troop_total += count
                print(f"    {TROOP_NAMES.get(troop_type, troop_type):>15}: {fmt(count):>20}  (Food/hr: -{fmt(food_cost)})")
        
        total_food_consumption += city_food_consumption
        print(f"    {'─'*50}")
        print(f"    {'CITY TOTAL':>15}: {fmt(city_troop_total):>20}")
        print(f"    {'Food Consumption':>15}: -{fmt(city_food_consumption):>19}/hr")
        
        # Heroes
        if heroes:
            print(f"\n  HEROES ({len(heroes)}):")
            for hero in heroes[:5]:
                hname = hero.get('name', 'Unknown')
                hlevel = hero.get('level', 0)
                hatk = hero.get('attack', 0)
                hdef = hero.get('defence', 0)
                hpol = hero.get('politics', 0)
                hint = hero.get('intelligence', 0)
                print(f"    {hname} Lv.{hlevel} | ATK:{fmt(hatk)} DEF:{hdef} POL:{fmt(hpol)} INT:{fmt(hint)}")
            if len(heroes) > 5:
                print(f"    ... and {len(heroes) - 5} more heroes")
    
    # ═══════════════════════════════════════════════════════════════════
    # TOTALS (like Troop_&_RSS_Counter script)
    # ═══════════════════════════════════════════════════════════════════
    print(f"\n{'═'*80}")
    print("ACCOUNT TOTALS (All Cities Combined)")
    print(f"{'═'*80}")
    
    print(f"\n  TOTAL RESOURCES:")
    print(f"    Gold:  {fmt(total_resources['gold']):>25}")
    print(f"    Food:  {fmt(total_resources['food']):>25}")
    print(f"    Wood:  {fmt(total_resources['wood']):>25}")
    print(f"    Stone: {fmt(total_resources['stone']):>25}")
    print(f"    Iron:  {fmt(total_resources['iron']):>25}")
    
    print(f"\n  TOTAL TROOPS:")
    grand_total = 0
    total_food_by_type = {}
    
    # Foot troops
    foot_count = 0
    foot_food = 0
    for tt in ['militia', 'scouter', 'pikemen', 'swordsmen', 'archer']:
        count = total_troops.get(tt, 0)
        food = count * FOOD_PER_TROOP.get(tt, 0)
        foot_count += count
        foot_food += food
        grand_total += count
        if count > 0:
            print(f"    {TROOP_NAMES.get(tt, tt):>15}: {fmt(count):>20}  (Food/hr: -{fmt(food)})")
    
    # Mounted
    horse_count = 0
    horse_food = 0
    for tt in ['lightCavalry', 'heavyCavalry']:
        count = total_troops.get(tt, 0)
        food = count * FOOD_PER_TROOP.get(tt, 0)
        horse_count += count
        horse_food += food
        grand_total += count
        if count > 0:
            print(f"    {TROOP_NAMES.get(tt, tt):>15}: {fmt(count):>20}  (Food/hr: -{fmt(food)})")
    
    # Mech
    mech_count = 0
    mech_food = 0
    for tt in ['ballista', 'batteringRam', 'catapult']:
        count = total_troops.get(tt, 0)
        food = count * FOOD_PER_TROOP.get(tt, 0)
        mech_count += count
        mech_food += food
        grand_total += count
        if count > 0:
            print(f"    {TROOP_NAMES.get(tt, tt):>15}: {fmt(count):>20}  (Food/hr: -{fmt(food)})")
    
    # Support
    support_count = 0
    support_food = 0
    for tt in ['peasants', 'carriage']:
        count = total_troops.get(tt, 0)
        food = count * FOOD_PER_TROOP.get(tt, 0)
        support_count += count
        support_food += food
        grand_total += count
        if count > 0:
            print(f"    {TROOP_NAMES.get(tt, tt):>15}: {fmt(count):>20}  (Food/hr: -{fmt(food)})")
    
    print(f"    {'─'*55}")
    print(f"    {'GRAND TOTAL':>15}: {fmt(grand_total):>20}")
    print(f"    {'Total Food/hr':>15}: -{fmt(total_food_consumption):>19}")
    
    # Category breakdown
    print(f"\n  TROOP CATEGORIES:")
    print(f"    Foot Troops:      {fmt(foot_count):>15}  (Food/hr: -{fmt(foot_food)})")
    print(f"    Mounted Troops:   {fmt(horse_count):>15}  (Food/hr: -{fmt(horse_food)})")
    print(f"    Mechanized:       {fmt(mech_count):>15}  (Food/hr: -{fmt(mech_food)})")
    print(f"    Support:          {fmt(support_count):>15}  (Food/hr: -{fmt(support_food)})")
    
    # Items Summary
    print(f"\n{'═'*80}")
    print(f"ITEMS ({len(items)} unique types)")
    print(f"{'═'*80}")
    
    total_qty = sum(i.get('count', 0) for i in items)
    print(f"  Total Quantity: {fmt(total_qty)}")
    
    sorted_items = sorted(items, key=lambda x: x.get('count', 0), reverse=True)
    print(f"\n  Top 15 Items:")
    for item in sorted_items[:15]:
        print(f"    {item.get('id', 'unknown'):40}: {fmt(item.get('count', 0)):>15}")
    
    # Equipment
    if equipments:
        print(f"\n{'─'*80}")
        print(f"EQUIPMENT ({len(equipments)} items)")
        print(f"{'─'*80}")
        for eq in equipments[:5]:
            print(f"  Tech ID: {eq.get('equipmenttechid', '?')}, Level: {eq.get('lv', 0)}")
        if len(equipments) > 5:
            print(f"  ... and {len(equipments) - 5} more")
    
    # Buffs
    if buffs:
        print(f"\n{'─'*80}")
        print(f"BUFFS ({len(buffs)} active)")
        print(f"{'─'*80}")
        for buff in buffs[:5]:
            print(f"  Type: {buff.get('typeId', 'unknown')}")
    
    print(f"\n{'='*80}")
    print("END OF REPORT")
    print(f"{'='*80}\n")

def list_dumps(dump_dir: str = "data/dumps"):
    """List available dump files"""
    dump_path = Path(dump_dir)
    if not dump_path.exists():
        print(f"No dumps directory found at {dump_dir}")
        return []
    
    dumps = list(dump_path.glob("*.json"))
    print(f"\nAvailable dumps in {dump_dir}:")
    for i, d in enumerate(dumps, 1):
        size = d.stat().st_size / 1024
        print(f"  {i}. {d.name} ({size:.1f} KB)")
    return dumps

if __name__ == "__main__":
    if len(sys.argv) > 1:
        dump_file = sys.argv[1]
    else:
        # List and pick latest
        dumps = list_dumps()
        if dumps:
            dump_file = str(sorted(dumps, key=lambda x: x.stat().st_mtime, reverse=True)[0])
            print(f"\nViewing latest: {dump_file}")
        else:
            print("No dump files found. Run extraction first.")
            sys.exit(1)
    
    view_dump(dump_file)
