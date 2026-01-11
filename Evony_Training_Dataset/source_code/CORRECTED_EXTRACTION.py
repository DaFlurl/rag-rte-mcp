"""
CORRECTED ACCOUNT EXTRACTION v2.0
Based on source code analysis of RoboEvony .as files and JSON structure

ISSUES FIXED:
1. Troop field names: militia (not warriors), scouter (not scouts), peasants (not workers)
2. Item ID mapping from RoboEvony source: player.trick.tblj = Thunder Raid, etc.
3. Proper summing across ALL cities per account
4. Correct JSON structure: player.castles[].troop.{field}

CORRECT TROOP FIELD NAMES (from Troop__RSS_Counter.txt):
  peasants      - Workers
  militia       - Warriors  
  scouter       - Scouts
  pikemen       - Pikemen
  swordsmen     - Swordsmen
  archer        - Archers
  lightCavalry  - Cavalry
  heavyCavalry  - Cataphracts
  carriage      - Transporters
  batteringRam  - Battering Rams
  ballista      - Ballista
  catapult      - Catapults

CORRECT ITEM IDs (from RoboEvony scripts):
  player.trick.tblj                      - Thunder Raid
  player.trick.qlbx                      - Recall Amulet
  player.trick.zc                        - Truce Agreement
  player.item.stygandrsbannerofthehorde  - Stygandr's Banner
  hero.gen.npc2                          - Legendary Ring
  player.item.gildedhorn                 - Gilded Horn
  player.truce.dream                     - Truce (Dream)
"""
import json
from pathlib import Path
from datetime import datetime
from collections import defaultdict

# Paths
JSON_DIR = Path(r'D:\EvonyToolKit\scripts\khan_Accounts_556\accounts')
OUTPUT_DIR = Path(r'G:\Evony_UI\account_explorer\v2\data')

# Correct troop field names from source code analysis
TROOP_FIELDS = {
    'peasants': 'Workers',
    'militia': 'Warriors',
    'scouter': 'Scouts',
    'pikemen': 'Pikemen',
    'swordsmen': 'Swordsmen',
    'archer': 'Archers',
    'lightCavalry': 'Cavalry',
    'heavyCavalry': 'Cataphracts',
    'carriage': 'Transporters',
    'batteringRam': 'Battering Rams',
    'ballista': 'Ballista',
    'catapult': 'Catapults',
}

# Correct item IDs from RoboEvony source code
ITEM_IDS = {
    'player.trick.tblj': 'Thunder Raid',
    'player.trick.qlbx': 'Recall Amulet',
    'player.trick.zc': 'Truce Agreement',
    'player.item.stygandrsbannerofthehorde': "Stygandr's Banner",
    'hero.gen.npc2': 'Legendary Ring',
    'player.item.gildedhorn': 'Gilded Horn',
    'player.truce.dream': 'Truce (Dream)',
    'player.trick.smmf': 'Scout Marker',
    'player.trick.pzyy': 'Scout Report',
    'player.trick.jbqy': 'War Declaration',
    'hero.item.Tea': 'Tea',
    'hero.item.Lugui_Wine': 'Lugui Wine',
    'hero.item.Panax_ginseng': 'Panax Ginseng',
}

# Food consumption per troop (from source)
FOOD_PER_TROOP = {
    'peasants': 1,
    'militia': 1,
    'scouter': 2,
    'pikemen': 3,
    'swordsmen': 3,
    'archer': 4,
    'lightCavalry': 9,
    'heavyCavalry': 17,
    'carriage': 5,
    'batteringRam': 50,
    'ballista': 25,
    'catapult': 125,
}

def fix_overflow(val):
    """Fix uint32 overflow values"""
    if isinstance(val, (int, float)):
        if val < 0:
            return val + 4_294_967_296
        return int(val)
    return 0


def format_number(n):
    """Format large numbers with B/M/K suffix"""
    n = abs(n)
    if n >= 1_000_000_000:
        return f"{n/1_000_000_000:.1f}B"
    elif n >= 1_000_000:
        return f"{n/1_000_000:.1f}M"
    elif n >= 1_000:
        return f"{n/1_000:.1f}K"
    return str(int(n))


def extract_account(json_path):
    """Extract account data from JSON file using correct field names"""
    try:
        with open(json_path, 'r', encoding='utf-8', errors='ignore') as f:
            data = json.load(f)
    except Exception as e:
        return None
    
    player = data.get('player', {})
    if not player:
        return None
    
    # Player info
    pi = player.get('playerInfo', {})
    result = {
        'source_file': json_path.name,
        'player_name': pi.get('userName', ''),
        'alliance': pi.get('alliance', ''),
        'prestige': fix_overflow(pi.get('prestige', 0)),
        'honor': fix_overflow(pi.get('honor', 0)),
        'gold': fix_overflow(pi.get('gold', 0)),
        'title': pi.get('title', ''),
    }
    
    if not result['player_name']:
        return None
    
    # Sum troops from ALL cities using CORRECT field names
    castles = player.get('castles', [])
    result['city_count'] = len(castles)
    
    troops = defaultdict(int)
    for castle in castles:
        troop_data = castle.get('troop', {})
        for field, display_name in TROOP_FIELDS.items():
            troops[field] += fix_overflow(troop_data.get(field, 0))
    
    # Store troops with both internal and display names
    result['troops_raw'] = dict(troops)
    result['troops'] = {TROOP_FIELDS[k]: v for k, v in troops.items()}
    result['total_troops'] = sum(troops.values())
    
    # Calculate food consumption
    food_per_hour = sum(troops[k] * FOOD_PER_TROOP[k] for k in TROOP_FIELDS.keys())
    result['food_per_hour'] = food_per_hour
    
    # Items with CORRECT IDs
    items = player.get('items', [])
    item_counts = {}
    for item in items:
        if isinstance(item, dict):
            item_id = str(item.get('id', ''))
            count = fix_overflow(item.get('count', 0))
            if item_id and count > 0:
                item_counts[item_id] = count
    
    result['items_raw'] = item_counts
    result['total_items'] = sum(item_counts.values())
    result['unique_items'] = len(item_counts)
    
    # Key items using CORRECT IDs from source
    result['thunder_raids'] = item_counts.get('player.trick.tblj', 0)
    result['recall_amulets'] = item_counts.get('player.trick.qlbx', 0)
    result['truce_agreements'] = item_counts.get('player.trick.zc', 0)
    result['banners'] = item_counts.get('player.item.stygandrsbannerofthehorde', 0)
    result['legendary_rings'] = item_counts.get('hero.gen.npc2', 0)
    result['gilded_horns'] = item_counts.get('player.item.gildedhorn', 0)
    result['truce_dream'] = item_counts.get('player.truce.dream', 0)
    
    # Translate items to readable names
    result['items_translated'] = {}
    for item_id, count in item_counts.items():
        name = ITEM_IDS.get(item_id, item_id)
        result['items_translated'][name] = count
    
    return result


def main():
    print("=" * 70)
    print("CORRECTED ACCOUNT EXTRACTION v2.0")
    print("Based on RoboEvony source code analysis")
    print("=" * 70)
    
    # Find all JSON files
    json_files = list(JSON_DIR.glob('*.json'))
    print(f"\nFound {len(json_files)} JSON files in {JSON_DIR}")
    
    # Extract all accounts
    accounts = []
    for jf in json_files:
        result = extract_account(jf)
        if result:
            accounts.append(result)
    
    print(f"Extracted {len(accounts)} valid accounts")
    
    # Sort by total troops
    accounts.sort(key=lambda x: -x['total_troops'])
    
    # Save output
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    output_file = OUTPUT_DIR / 'accounts_corrected.json'
    
    output_data = {
        'extracted': datetime.now().isoformat(),
        'source': str(JSON_DIR),
        'total_accounts': len(accounts),
        'accounts': accounts,
    }
    
    with open(output_file, 'w') as f:
        json.dump(output_data, f, indent=2)
    
    print(f"\nSaved to: {output_file}")
    
    # Show top 10 accounts
    print("\n" + "=" * 70)
    print("TOP 10 ACCOUNTS BY TROOPS")
    print("=" * 70)
    
    for i, acc in enumerate(accounts[:10], 1):
        print(f"\n{i}. {acc['player_name']} ({acc['city_count']} cities)")
        print(f"   Total Troops: {format_number(acc['total_troops'])}")
        print(f"   Archers: {format_number(acc['troops'].get('Archers', 0))}")
        print(f"   Cataphracts: {format_number(acc['troops'].get('Cataphracts', 0))}")
        print(f"   Banners: {acc['banners']:,}")
        print(f"   Thunder Raids: {acc['thunder_raids']:,}")
        print(f"   Recall Amulets: {acc['recall_amulets']:,}")
    
    # Summary stats
    print("\n" + "=" * 70)
    print("SUMMARY")
    print("=" * 70)
    
    total_troops = sum(a['total_troops'] for a in accounts)
    total_banners = sum(a['banners'] for a in accounts)
    total_thunder = sum(a['thunder_raids'] for a in accounts)
    total_recall = sum(a['recall_amulets'] for a in accounts)
    
    print(f"Total Troops: {format_number(total_troops)}")
    print(f"Total Banners: {total_banners:,}")
    print(f"Total Thunder Raids: {total_thunder:,}")
    print(f"Total Recall Amulets: {total_recall:,}")


if __name__ == '__main__':
    main()
