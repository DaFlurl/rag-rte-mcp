#!/usr/bin/env python3
"""
Borg Account Data Parser
Parses the 3MB JSON dump into readable, organized output
"""

import json
import os
from datetime import datetime

def format_number(num):
    """Format large numbers with commas"""
    if num is None:
        return "0"
    try:
        return f"{int(float(num)):,}"
    except:
        return str(num)

def parse_account_dump(json_file):
    """Parse account dump and extract useful data"""
    
    with open(json_file, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    output = []
    output.append("=" * 80)
    output.append(f"BORG ACCOUNT DATA ANALYSIS")
    output.append(f"Source: {os.path.basename(json_file)}")
    output.append(f"Extracted: {data.get('extracted_at', 'Unknown')}")
    output.append(f"Server: {data.get('server', 'Unknown')}")
    output.append(f"Email: {data.get('email', 'Unknown')}")
    output.append("=" * 80)
    
    login_data = data.get('login_data', {})
    player = login_data.get('player', {})
    
    # City Sign Beans - Contains city names and coordinates
    output.append("\n" + "=" * 80)
    output.append("CITY LOCATIONS (castleSignBean)")
    output.append("=" * 80)
    
    city_signs = player.get('castleSignBean', [])
    for i, city in enumerate(city_signs):
        name = city.get('name', f'City_{i}')
        x = city.get('x', '?')
        y = city.get('y', '?')
        city_id = city.get('id', '?')
        output.append(f"  [{i+1}] {name:20} | Coords: ({x}, {y}) | ID: {city_id}")
    
    # Castles - Main city data
    castles = player.get('castles', [])
    
    output.append("\n" + "=" * 80)
    output.append("CITIES DETAILED DATA")
    output.append("=" * 80)
    
    total_troops = {
        'peasants': 0, 'militia': 0, 'scouter': 0, 'pikemen': 0,
        'swordsmen': 0, 'archer': 0, 'lightCavalry': 0, 'heavyCavalry': 0,
        'carriage': 0, 'ballista': 0, 'batteringRam': 0, 'catapult': 0
    }
    total_food_cost = 0
    
    for i, castle in enumerate(castles):
        # Get city name from castleSignBean if available
        city_name = city_signs[i].get('name', f'City_{i}') if i < len(city_signs) else f'City_{i}'
        city_x = city_signs[i].get('x', '?') if i < len(city_signs) else '?'
        city_y = city_signs[i].get('y', '?') if i < len(city_signs) else '?'
        
        output.append(f"\n--- [{i+1}] {city_name} ({city_x}, {city_y}) ---")
        
        # Resources
        resource = castle.get('resource', {})
        food_cost = resource.get('troopCostFood', 0)
        total_food_cost += float(food_cost) if food_cost else 0
        
        output.append(f"  Food Cost/hr: {format_number(food_cost)}")
        
        # Troops
        troop = castle.get('troop', {})
        if troop:
            output.append("  TROOPS:")
            troop_names = {
                'peasants': 'Workers', 'militia': 'Warriors', 'scouter': 'Scouts',
                'pikemen': 'Pikemen', 'swordsmen': 'Swordsmen', 'archer': 'Archers',
                'lightCavalry': 'Cavalry', 'heavyCavalry': 'Cataphracts',
                'carriage': 'Transporters', 'ballista': 'Ballista',
                'batteringRam': 'BattRams', 'catapult': 'Catapults'
            }
            
            city_total = 0
            for key, display_name in troop_names.items():
                count = troop.get(key, 0)
                if count:
                    count_int = int(float(count))
                    city_total += count_int
                    total_troops[key] += count_int
                    
                    # Check glitch status
                    glitch_threshold = 2147483647
                    food_per_troop = {'peasants': 1, 'militia': 1, 'scouter': 2, 'pikemen': 3,
                                     'swordsmen': 3, 'archer': 4, 'lightCavalry': 9, 'heavyCavalry': 17,
                                     'carriage': 5, 'ballista': 25, 'batteringRam': 50, 'catapult': 125}
                    
                    troops_per_glitch = (glitch_threshold // food_per_troop.get(key, 1)) + 1
                    glitch_count = count_int // troops_per_glitch
                    is_odd = glitch_count % 2 == 1
                    status = "ODD ✓" if is_odd and glitch_count > 0 else ("EVEN ✗" if glitch_count > 0 else "-")
                    
                    output.append(f"    {display_name:12}: {format_number(count_int):>15} | Glitches: {glitch_count:3} | {status}")
            
            output.append(f"    {'TOTAL':12}: {format_number(city_total):>15}")
    
    # Grand Totals
    output.append("\n" + "=" * 80)
    output.append("GRAND TOTALS - ALL CITIES")
    output.append("=" * 80)
    
    troop_names = {
        'peasants': 'Workers', 'militia': 'Warriors', 'scouter': 'Scouts',
        'pikemen': 'Pikemen', 'swordsmen': 'Swordsmen', 'archer': 'Archers',
        'lightCavalry': 'Cavalry', 'heavyCavalry': 'Cataphracts',
        'carriage': 'Transporters', 'ballista': 'Ballista',
        'batteringRam': 'BattRams', 'catapult': 'Catapults'
    }
    
    grand_total = 0
    for key, display_name in troop_names.items():
        count = total_troops[key]
        grand_total += count
        output.append(f"  {display_name:12}: {format_number(count):>20}")
    
    output.append(f"\n  {'GRAND TOTAL':12}: {format_number(grand_total):>20}")
    output.append(f"  {'Food Cost/hr':12}: {format_number(total_food_cost):>20}")
    
    # Buffs
    buffs = player.get('buffs', [])
    if buffs:
        output.append("\n" + "=" * 80)
        output.append("ACTIVE BUFFS")
        output.append("=" * 80)
        for buff in buffs[:10]:  # Limit to first 10
            output.append(f"  - {buff.get('typeId', 'Unknown')}: {buff.get('descName', '')}")
    
    output.append("\n" + "=" * 80)
    output.append("END OF REPORT")
    output.append("=" * 80)
    
    return "\n".join(output)

def main():
    # Find the latest dump file
    dumps_dir = os.path.join(os.path.dirname(__file__), 'data', 'dumps')
    
    if not os.path.exists(dumps_dir):
        print(f"Dumps directory not found: {dumps_dir}")
        return
    
    json_files = [f for f in os.listdir(dumps_dir) if f.endswith('.json')]
    
    if not json_files:
        print("No JSON dump files found")
        return
    
    # Use the latest file
    latest_file = sorted(json_files)[-1]
    json_path = os.path.join(dumps_dir, latest_file)
    
    print(f"Parsing: {latest_file}")
    print()
    
    result = parse_account_dump(json_path)
    print(result)
    
    # Save to file
    output_file = os.path.join(os.path.dirname(__file__), 'data', 'borg_account_report.txt')
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(result)
    
    print(f"\nReport saved to: {output_file}")

if __name__ == "__main__":
    main()
