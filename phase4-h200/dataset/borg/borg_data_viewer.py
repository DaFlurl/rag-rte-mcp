#!/usr/bin/env python3
"""
Borg Account Data Viewer - Comprehensive Excel Export
Creates multi-sheet Excel with ALL account data organized like the game
"""

import json
import os
from datetime import datetime

try:
    from openpyxl import Workbook
    from openpyxl.styles import Font, PatternFill, Alignment, Border, Side
    from openpyxl.utils import get_column_letter
except ImportError:
    import subprocess
    subprocess.check_call(['pip', 'install', 'openpyxl'])
    from openpyxl import Workbook
    from openpyxl.styles import Font, PatternFill, Alignment, Border, Side
    from openpyxl.utils import get_column_letter

# Styles
HEADER_FONT = Font(bold=True, size=11, color="FFFFFF")
HEADER_FILL = PatternFill(start_color="0066CC", end_color="0066CC", fill_type="solid")
CITY_FILL = PatternFill(start_color="CC2EFA", end_color="CC2EFA", fill_type="solid")
ODD_FILL = PatternFill(start_color="90EE90", end_color="90EE90", fill_type="solid")
EVEN_FILL = PatternFill(start_color="FFB6C1", end_color="FFB6C1", fill_type="solid")
ALT_FILL = PatternFill(start_color="F0F0F0", end_color="F0F0F0", fill_type="solid")
BORDER = Border(left=Side(style='thin'), right=Side(style='thin'),
                top=Side(style='thin'), bottom=Side(style='thin'))

GLITCH_THRESHOLD = 2147483647
FOOD_PER_TROOP = {'peasants': 1, 'militia': 1, 'scouter': 2, 'pikemen': 3,
                  'swordsmen': 3, 'archer': 4, 'lightCavalry': 9, 'heavyCavalry': 17,
                  'carriage': 5, 'ballista': 25, 'batteringRam': 50, 'catapult': 125}

TROOP_NAMES = {'peasants': 'Workers', 'militia': 'Warriors', 'scouter': 'Scouts',
               'pikemen': 'Pikemen', 'swordsmen': 'Swordsmen', 'archer': 'Archers',
               'lightCavalry': 'Cavalry', 'heavyCavalry': 'Cataphracts',
               'carriage': 'Transporters', 'ballista': 'Ballista',
               'batteringRam': 'BattRams', 'catapult': 'Catapults'}

def style_header(ws, row, headers):
    for col, h in enumerate(headers, 1):
        cell = ws.cell(row=row, column=col, value=h)
        cell.font = HEADER_FONT
        cell.fill = HEADER_FILL
        cell.alignment = Alignment(horizontal='center')
        cell.border = BORDER

def auto_width(ws, cols):
    for col in range(1, cols + 1):
        ws.column_dimensions[get_column_letter(col)].width = 15

def create_overview_sheet(wb, data):
    """Sheet 1: Account Overview"""
    ws = wb.active
    ws.title = "Overview"
    
    player = data.get('login_data', {}).get('player', {})
    player_info = player.get('playerInfo', {})
    city_signs = player.get('castleSignBean', [])
    
    ws['A1'] = "BORG ACCOUNT DATA VIEWER"
    ws['A1'].font = Font(bold=True, size=16, color="CC2EFA")
    
    ws['A3'] = "Account Info"
    ws['A3'].font = Font(bold=True, size=12)
    ws['A4'] = "Email:"
    ws['B4'] = data.get('email', 'Unknown')
    ws['A5'] = "Server:"
    ws['B5'] = data.get('server', 'Unknown')
    ws['A6'] = "Extracted:"
    ws['B6'] = data.get('extracted_at', 'Unknown')
    ws['A7'] = "Player Name:"
    ws['B7'] = player_info.get('userName', 'Unknown')
    ws['A8'] = "Alliance:"
    ws['B8'] = player_info.get('allianceName', 'None')
    ws['A9'] = "Prestige:"
    ws['B9'] = player_info.get('honor', 0)
    ws['A10'] = "Title:"
    ws['B10'] = player_info.get('titleId', 'Unknown')
    
    ws['A12'] = "Cities"
    ws['A12'].font = Font(bold=True, size=12)
    style_header(ws, 13, ['#', 'City Name', 'X', 'Y', 'ID'])
    
    for i, city in enumerate(city_signs):
        row = 14 + i
        ws.cell(row=row, column=1, value=i+1).border = BORDER
        ws.cell(row=row, column=2, value=city.get('name', f'City_{i}')).border = BORDER
        ws.cell(row=row, column=3, value=city.get('x', 0)).border = BORDER
        ws.cell(row=row, column=4, value=city.get('y', 0)).border = BORDER
        ws.cell(row=row, column=5, value=city.get('id', 0)).border = BORDER
    
    auto_width(ws, 5)
    ws.column_dimensions['B'].width = 25

def create_troops_sheet(wb, data):
    """Sheet 2: Troops by City"""
    ws = wb.create_sheet("Troops")
    
    player = data.get('login_data', {}).get('player', {})
    castles = player.get('castles', [])
    city_signs = player.get('castleSignBean', [])
    
    troop_order = ['peasants', 'militia', 'scouter', 'pikemen', 'swordsmen', 'archer',
                   'lightCavalry', 'heavyCavalry', 'carriage', 'ballista', 'batteringRam', 'catapult']
    
    headers = ['City', 'X', 'Y'] + [TROOP_NAMES[t] for t in troop_order] + ['TOTAL', 'Food/hr']
    style_header(ws, 1, headers)
    
    totals = {t: 0 for t in troop_order}
    total_food = 0
    
    for i, castle in enumerate(castles):
        city_name = city_signs[i].get('name', f'City_{i}') if i < len(city_signs) else f'City_{i}'
        city_x = city_signs[i].get('x', 0) if i < len(city_signs) else 0
        city_y = city_signs[i].get('y', 0) if i < len(city_signs) else 0
        
        troop = castle.get('troop', {})
        resource = castle.get('resource', {})
        food_cost = int(float(resource.get('troopCostFood', 0)))
        total_food += food_cost
        
        row = i + 2
        ws.cell(row=row, column=1, value=city_name).border = BORDER
        ws.cell(row=row, column=2, value=city_x).border = BORDER
        ws.cell(row=row, column=3, value=city_y).border = BORDER
        
        city_total = 0
        for col, t in enumerate(troop_order, 4):
            count = int(float(troop.get(t, 0)))
            ws.cell(row=row, column=col, value=count).border = BORDER
            city_total += count
            totals[t] += count
        
        ws.cell(row=row, column=16, value=city_total).border = BORDER
        ws.cell(row=row, column=17, value=food_cost).border = BORDER
        
        if i % 2 == 1:
            for col in range(1, 18):
                ws.cell(row=row, column=col).fill = ALT_FILL
    
    # Totals row
    row = len(castles) + 2
    ws.cell(row=row, column=1, value="TOTAL").font = Font(bold=True)
    grand_total = 0
    for col, t in enumerate(troop_order, 4):
        ws.cell(row=row, column=col, value=totals[t]).font = Font(bold=True)
        grand_total += totals[t]
    ws.cell(row=row, column=16, value=grand_total).font = Font(bold=True)
    ws.cell(row=row, column=17, value=total_food).font = Font(bold=True)
    
    auto_width(ws, 17)
    ws.column_dimensions['A'].width = 18

def create_glitch_sheet(wb, data):
    """Sheet 3: Glitch Analysis"""
    ws = wb.create_sheet("Glitches")
    
    player = data.get('login_data', {}).get('player', {})
    castles = player.get('castles', [])
    city_signs = player.get('castleSignBean', [])
    
    troop_order = ['peasants', 'militia', 'scouter', 'pikemen', 'swordsmen', 'archer',
                   'lightCavalry', 'heavyCavalry', 'carriage', 'ballista', 'batteringRam', 'catapult']
    short_names = {'peasants': 'wo', 'militia': 'w', 'scouter': 's', 'pikemen': 'p',
                   'swordsmen': 'sw', 'archer': 'a', 'lightCavalry': 'c', 'heavyCavalry': 'cata',
                   'carriage': 't', 'ballista': 'b', 'batteringRam': 'r', 'catapult': 'cp'}
    
    headers = ['City', 'Troop', 'Count', 'Glitches', 'Status', 'Untrain Cmd', 'Food Gain/hr']
    style_header(ws, 1, headers)
    
    row = 2
    for i, castle in enumerate(castles):
        city_name = city_signs[i].get('name', f'City_{i}') if i < len(city_signs) else f'City_{i}'
        troop = castle.get('troop', {})
        
        for t in troop_order:
            count = int(float(troop.get(t, 0)))
            if count > 0:
                food_cost = FOOD_PER_TROOP.get(t, 1)
                troops_per_glitch = (GLITCH_THRESHOLD // food_cost) + 1
                glitch_count = count // troops_per_glitch
                
                if glitch_count > 0:
                    is_odd = glitch_count % 2 == 1
                    remainder = count - (troops_per_glitch * glitch_count)
                    untrain_amt = remainder + 1
                    
                    ws.cell(row=row, column=1, value=city_name).border = BORDER
                    ws.cell(row=row, column=2, value=TROOP_NAMES[t]).border = BORDER
                    ws.cell(row=row, column=3, value=count).border = BORDER
                    ws.cell(row=row, column=4, value=glitch_count).border = BORDER
                    
                    status_cell = ws.cell(row=row, column=5, value="ODD ✓" if is_odd else "EVEN ✗")
                    status_cell.border = BORDER
                    status_cell.fill = ODD_FILL if is_odd else EVEN_FILL
                    status_cell.font = Font(bold=True)
                    
                    ws.cell(row=row, column=6, value=f"untrain {short_names[t]}:{untrain_amt}").border = BORDER
                    ws.cell(row=row, column=7, value=GLITCH_THRESHOLD if not is_odd else 0).border = BORDER
                    
                    row += 1
    
    auto_width(ws, 7)
    ws.column_dimensions['A'].width = 18
    ws.column_dimensions['F'].width = 25

def create_items_sheet(wb, data):
    """Sheet 4: Items Inventory"""
    ws = wb.create_sheet("Items")
    
    player = data.get('login_data', {}).get('player', {})
    items = player.get('items', [])
    
    headers = ['#', 'Item Name', 'Item ID', 'Count', 'Max Count']
    style_header(ws, 1, headers)
    
    for i, item in enumerate(items):
        row = i + 2
        ws.cell(row=row, column=1, value=i+1).border = BORDER
        ws.cell(row=row, column=2, value=item.get('name', 'Unknown')).border = BORDER
        ws.cell(row=row, column=3, value=item.get('id', 0)).border = BORDER
        ws.cell(row=row, column=4, value=item.get('count', 0)).border = BORDER
        ws.cell(row=row, column=5, value=item.get('maxCount', 0)).border = BORDER
        
        if i % 2 == 1:
            for col in range(1, 6):
                ws.cell(row=row, column=col).fill = ALT_FILL
    
    auto_width(ws, 5)
    ws.column_dimensions['B'].width = 35

def create_heroes_sheet(wb, data):
    """Sheet 5: Heroes by City"""
    ws = wb.create_sheet("Heroes")
    
    player = data.get('login_data', {}).get('player', {})
    castles = player.get('castles', [])
    city_signs = player.get('castleSignBean', [])
    
    headers = ['City', 'Hero Name', 'Level', 'Politics', 'Attack', 'Intelligence', 'Status', 'Experience']
    style_header(ws, 1, headers)
    
    row = 2
    for i, castle in enumerate(castles):
        city_name = city_signs[i].get('name', f'City_{i}') if i < len(city_signs) else f'City_{i}'
        heroes = castle.get('heros', [])
        
        for hero in heroes:
            ws.cell(row=row, column=1, value=city_name).border = BORDER
            ws.cell(row=row, column=2, value=hero.get('name', 'Unknown')).border = BORDER
            ws.cell(row=row, column=3, value=hero.get('level', 0)).border = BORDER
            ws.cell(row=row, column=4, value=hero.get('power', 0)).border = BORDER
            ws.cell(row=row, column=5, value=hero.get('management', 0)).border = BORDER
            ws.cell(row=row, column=6, value=hero.get('stratagem', 0)).border = BORDER
            ws.cell(row=row, column=7, value=hero.get('status', 'Unknown')).border = BORDER
            ws.cell(row=row, column=8, value=hero.get('experience', 0)).border = BORDER
            row += 1
    
    auto_width(ws, 8)
    ws.column_dimensions['A'].width = 18
    ws.column_dimensions['B'].width = 20

def create_buildings_sheet(wb, data):
    """Sheet 6: Buildings by City"""
    ws = wb.create_sheet("Buildings")
    
    player = data.get('login_data', {}).get('player', {})
    castles = player.get('castles', [])
    city_signs = player.get('castleSignBean', [])
    
    headers = ['City', 'Building Name', 'Level', 'Position ID', 'Type ID', 'Status']
    style_header(ws, 1, headers)
    
    row = 2
    for i, castle in enumerate(castles):
        city_name = city_signs[i].get('name', f'City_{i}') if i < len(city_signs) else f'City_{i}'
        buildings = castle.get('buildings', [])
        
        for bldg in buildings:
            ws.cell(row=row, column=1, value=city_name).border = BORDER
            ws.cell(row=row, column=2, value=bldg.get('name', 'Unknown')).border = BORDER
            ws.cell(row=row, column=3, value=bldg.get('level', 0)).border = BORDER
            ws.cell(row=row, column=4, value=bldg.get('positionId', 0)).border = BORDER
            ws.cell(row=row, column=5, value=bldg.get('typeId', 0)).border = BORDER
            ws.cell(row=row, column=6, value=bldg.get('status', 0)).border = BORDER
            
            if row % 2 == 0:
                for col in range(1, 7):
                    ws.cell(row=row, column=col).fill = ALT_FILL
            row += 1
    
    auto_width(ws, 6)
    ws.column_dimensions['A'].width = 18
    ws.column_dimensions['B'].width = 20

def get_resource_amount(res, key):
    """Safely get resource amount from various formats"""
    val = res.get(key, 0)
    if isinstance(val, dict):
        return int(float(val.get('amount', 0)))
    return int(float(val)) if val else 0

def create_resources_sheet(wb, data):
    """Sheet 7: Resources by City"""
    ws = wb.create_sheet("Resources")
    
    player = data.get('login_data', {}).get('player', {})
    castles = player.get('castles', [])
    city_signs = player.get('castleSignBean', [])
    
    headers = ['City', 'Gold', 'Food', 'Wood', 'Stone', 'Iron', 'Population', 'Food/hr']
    style_header(ws, 1, headers)
    
    for i, castle in enumerate(castles):
        city_name = city_signs[i].get('name', f'City_{i}') if i < len(city_signs) else f'City_{i}'
        res = castle.get('resource', {})
        
        row = i + 2
        ws.cell(row=row, column=1, value=city_name).border = BORDER
        ws.cell(row=row, column=2, value=get_resource_amount(res, 'gold')).border = BORDER
        ws.cell(row=row, column=3, value=get_resource_amount(res, 'food')).border = BORDER
        ws.cell(row=row, column=4, value=get_resource_amount(res, 'wood')).border = BORDER
        ws.cell(row=row, column=5, value=get_resource_amount(res, 'stone')).border = BORDER
        ws.cell(row=row, column=6, value=get_resource_amount(res, 'iron')).border = BORDER
        ws.cell(row=row, column=7, value=int(float(res.get('curPopulation', 0)))).border = BORDER
        ws.cell(row=row, column=8, value=int(float(res.get('troopCostFood', 0)))).border = BORDER
    
    auto_width(ws, 8)
    ws.column_dimensions['A'].width = 18

def create_equipment_sheet(wb, data):
    """Sheet 8: Equipment"""
    ws = wb.create_sheet("Equipment")
    
    player = data.get('login_data', {}).get('player', {})
    equipment = player.get('equipments', [])
    
    headers = ['#', 'Equipment Name', 'Level', 'Type', 'Hero']
    style_header(ws, 1, headers)
    
    for i, eq in enumerate(equipment):
        row = i + 2
        ws.cell(row=row, column=1, value=i+1).border = BORDER
        ws.cell(row=row, column=2, value=eq.get('name', 'Unknown')).border = BORDER
        ws.cell(row=row, column=3, value=eq.get('level', 0)).border = BORDER
        ws.cell(row=row, column=4, value=eq.get('type', 'Unknown')).border = BORDER
        ws.cell(row=row, column=5, value=eq.get('heroName', 'Unequipped')).border = BORDER
    
    auto_width(ws, 5)
    ws.column_dimensions['B'].width = 30

def create_buffs_sheet(wb, data):
    """Sheet 9: Active Buffs"""
    ws = wb.create_sheet("Buffs")
    
    player = data.get('login_data', {}).get('player', {})
    buffs = player.get('buffs', [])
    
    headers = ['#', 'Buff Type', 'Description', 'End Time']
    style_header(ws, 1, headers)
    
    for i, buff in enumerate(buffs):
        row = i + 2
        ws.cell(row=row, column=1, value=i+1).border = BORDER
        ws.cell(row=row, column=2, value=buff.get('typeId', 'Unknown')).border = BORDER
        ws.cell(row=row, column=3, value=buff.get('descName', '')).border = BORDER
        ws.cell(row=row, column=4, value=buff.get('endTime', 0)).border = BORDER
    
    auto_width(ws, 4)
    ws.column_dimensions['B'].width = 30
    ws.column_dimensions['C'].width = 50

def create_colonies_sheet(wb, data):
    """Sheet 10: Colonies by City"""
    ws = wb.create_sheet("Colonies")
    
    player = data.get('login_data', {}).get('player', {})
    castles = player.get('castles', [])
    city_signs = player.get('castleSignBean', [])
    
    headers = ['Owner City', 'Colony Name', 'Lord Name', 'Alliance', 'Position', 'Can Levy']
    style_header(ws, 1, headers)
    
    row = 2
    for i, castle in enumerate(castles):
        city_name = city_signs[i].get('name', f'City_{i}') if i < len(city_signs) else f'City_{i}'
        colonies = castle.get('colonyBeans', [])
        
        for col in colonies:
            ws.cell(row=row, column=1, value=city_name).border = BORDER
            ws.cell(row=row, column=2, value=col.get('cityName', 'Unknown')).border = BORDER
            ws.cell(row=row, column=3, value=col.get('lordName', 'Unknown')).border = BORDER
            ws.cell(row=row, column=4, value=col.get('allianceName', '')).border = BORDER
            ws.cell(row=row, column=5, value=col.get('position', '')).border = BORDER
            ws.cell(row=row, column=6, value="Yes" if col.get('isCanLevy') else "No").border = BORDER
            row += 1
    
    auto_width(ws, 6)
    ws.column_dimensions['A'].width = 18
    ws.column_dimensions['B'].width = 20

def main():
    dumps_dir = os.path.join(os.path.dirname(__file__), 'data', 'dumps')
    json_files = sorted([f for f in os.listdir(dumps_dir) if f.endswith('.json')])
    
    if not json_files:
        print("No JSON dump files found")
        return
    
    latest_file = json_files[-1]
    json_path = os.path.join(dumps_dir, latest_file)
    
    print(f"Loading: {latest_file}")
    with open(json_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    print("Creating Excel workbook...")
    wb = Workbook()
    
    create_overview_sheet(wb, data)
    create_troops_sheet(wb, data)
    create_glitch_sheet(wb, data)
    create_items_sheet(wb, data)
    create_heroes_sheet(wb, data)
    create_buildings_sheet(wb, data)
    create_resources_sheet(wb, data)
    create_equipment_sheet(wb, data)
    create_buffs_sheet(wb, data)
    create_colonies_sheet(wb, data)
    
    output_dir = os.path.join(os.path.dirname(__file__), 'data', 'exports')
    os.makedirs(output_dir, exist_ok=True)
    
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    output_file = os.path.join(output_dir, f"borg_full_data_{timestamp}.xlsx")
    
    wb.save(output_file)
    print(f"\nSaved: {output_file}")
    print("\nSheets created:")
    print("  1. Overview - Account info & city locations")
    print("  2. Troops - All troops by city with totals")
    print("  3. Glitches - ODD/EVEN analysis with untrain cmds")
    print("  4. Items - Full inventory (196 items)")
    print("  5. Heroes - All heroes by city")
    print("  6. Buildings - All buildings by city")
    print("  7. Resources - Gold/Food/Wood/Stone/Iron per city")
    print("  8. Equipment - Equipment items")
    print("  9. Buffs - Active buffs")
    print(" 10. Colonies - All colonies by city")

if __name__ == "__main__":
    main()
