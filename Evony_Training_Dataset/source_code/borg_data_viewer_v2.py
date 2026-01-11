#!/usr/bin/env python3
"""
Borg Account Data Viewer v2 - CORRECTED
Uses proper data structure - castles have their own names, fieldId for coords
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
CITY_FONT = Font(bold=True, size=11, color="CC2EFA")
ODD_FILL = PatternFill(start_color="90EE90", end_color="90EE90", fill_type="solid")
EVEN_FILL = PatternFill(start_color="FFB6C1", end_color="FFB6C1", fill_type="solid")
ALT_FILL = PatternFill(start_color="F5F5F5", end_color="F5F5F5", fill_type="solid")
BORDER = Border(left=Side(style='thin'), right=Side(style='thin'),
                top=Side(style='thin'), bottom=Side(style='thin'))

MAP_WIDTH = 800  # Evony map width for fieldId conversion

GLITCH_THRESHOLD = 2147483647
FOOD_PER_TROOP = {'peasants': 1, 'militia': 1, 'scouter': 2, 'pikemen': 3,
                  'swordsmen': 3, 'archer': 4, 'lightCavalry': 9, 'heavyCavalry': 17,
                  'carriage': 5, 'ballista': 25, 'batteringRam': 50, 'catapult': 125}

TROOP_NAMES = {'peasants': 'Workers', 'militia': 'Warriors', 'scouter': 'Scouts',
               'pikemen': 'Pikemen', 'swordsmen': 'Swordsmen', 'archer': 'Archers',
               'lightCavalry': 'Cavalry', 'heavyCavalry': 'Cataphracts',
               'carriage': 'Transporters', 'ballista': 'Ballista',
               'batteringRam': 'BattRams', 'catapult': 'Catapults'}

TROOP_SHORT = {'peasants': 'wo', 'militia': 'w', 'scouter': 's', 'pikemen': 'p',
               'swordsmen': 'sw', 'archer': 'a', 'lightCavalry': 'c', 'heavyCavalry': 'cata',
               'carriage': 't', 'ballista': 'b', 'batteringRam': 'r', 'catapult': 'cp'}

TROOP_ORDER = ['peasants', 'militia', 'scouter', 'pikemen', 'swordsmen', 'archer',
               'lightCavalry', 'heavyCavalry', 'carriage', 'ballista', 'batteringRam', 'catapult']

def fieldid_to_coords(field_id):
    """Convert fieldId to (x, y) coordinates"""
    if not field_id:
        return (0, 0)
    return (field_id % MAP_WIDTH, field_id // MAP_WIDTH)

def style_header(ws, row, headers):
    for col, h in enumerate(headers, 1):
        cell = ws.cell(row=row, column=col, value=h)
        cell.font = HEADER_FONT
        cell.fill = HEADER_FILL
        cell.alignment = Alignment(horizontal='center')
        cell.border = BORDER

def auto_width(ws, cols, min_width=12):
    for col in range(1, cols + 1):
        ws.column_dimensions[get_column_letter(col)].width = min_width

def get_safe_int(val):
    """Safely convert to int"""
    try:
        return int(float(val)) if val else 0
    except:
        return 0

def get_resource_amount(res, key):
    """Get resource amount from nested or flat structure"""
    val = res.get(key, 0)
    if isinstance(val, dict):
        return get_safe_int(val.get('amount', 0))
    return get_safe_int(val)

# ============================================================
# SHEET 1: OVERVIEW
# ============================================================
def create_overview_sheet(wb, data):
    ws = wb.active
    ws.title = "Overview"
    
    player = data.get('login_data', {}).get('player', {})
    player_info = player.get('playerInfo', {})
    castles = player.get('castles', [])
    
    ws['A1'] = "BORG ACCOUNT DATA"
    ws['A1'].font = Font(bold=True, size=18, color="CC2EFA")
    
    ws['A3'] = "Account"
    ws['A3'].font = Font(bold=True, size=14)
    ws['A4'] = "Email:"
    ws['B4'] = data.get('email', '')
    ws['A5'] = "Server:"
    ws['B5'] = data.get('server', '')
    ws['A6'] = "Player:"
    ws['B6'] = player_info.get('userName', '')
    ws['A7'] = "Alliance:"
    ws['B7'] = player_info.get('allianceName', '')
    ws['A8'] = "Prestige:"
    ws['B8'] = get_safe_int(player_info.get('honor', 0))
    
    ws['A10'] = "YOUR CITIES"
    ws['A10'].font = Font(bold=True, size=14)
    
    style_header(ws, 11, ['#', 'City Name', 'X', 'Y', 'ID', 'Power Level'])
    
    for i, castle in enumerate(castles):
        row = 12 + i
        x, y = fieldid_to_coords(castle.get('fieldId', 0))
        
        ws.cell(row=row, column=1, value=i+1).border = BORDER
        ws.cell(row=row, column=2, value=castle.get('name', f'City_{i}')).border = BORDER
        ws.cell(row=row, column=2).font = Font(bold=True)
        ws.cell(row=row, column=3, value=x).border = BORDER
        ws.cell(row=row, column=4, value=y).border = BORDER
        ws.cell(row=row, column=5, value=castle.get('id', 0)).border = BORDER
        ws.cell(row=row, column=6, value=castle.get('powerlevel', 0)).border = BORDER
    
    auto_width(ws, 6)
    ws.column_dimensions['B'].width = 20

# ============================================================
# SHEET 2: TROOPS BY CITY
# ============================================================
def create_troops_sheet(wb, data):
    ws = wb.create_sheet("Troops")
    
    player = data.get('login_data', {}).get('player', {})
    castles = player.get('castles', [])
    
    headers = ['City', 'X', 'Y'] + [TROOP_NAMES[t] for t in TROOP_ORDER] + ['TOTAL', 'Food/hr']
    style_header(ws, 1, headers)
    
    totals = {t: 0 for t in TROOP_ORDER}
    total_food = 0
    
    for i, castle in enumerate(castles):
        city_name = castle.get('name', f'City_{i}')
        x, y = fieldid_to_coords(castle.get('fieldId', 0))
        troop = castle.get('troop', {})
        resource = castle.get('resource', {})
        food_cost = get_safe_int(resource.get('troopCostFood', 0))
        total_food += food_cost
        
        row = i + 2
        ws.cell(row=row, column=1, value=city_name).border = BORDER
        ws.cell(row=row, column=1).font = Font(bold=True)
        ws.cell(row=row, column=2, value=x).border = BORDER
        ws.cell(row=row, column=3, value=y).border = BORDER
        
        city_total = 0
        for col, t in enumerate(TROOP_ORDER, 4):
            count = get_safe_int(troop.get(t, 0))
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
    ws.cell(row=row, column=1, value="TOTAL").font = Font(bold=True, size=12)
    grand_total = sum(totals.values())
    for col, t in enumerate(TROOP_ORDER, 4):
        ws.cell(row=row, column=col, value=totals[t]).font = Font(bold=True)
    ws.cell(row=row, column=16, value=grand_total).font = Font(bold=True)
    ws.cell(row=row, column=17, value=total_food).font = Font(bold=True)
    
    auto_width(ws, 17, 11)
    ws.column_dimensions['A'].width = 15

# ============================================================
# SHEET 3: GLITCH ANALYSIS
# ============================================================
def create_glitch_sheet(wb, data):
    ws = wb.create_sheet("Glitches")
    
    player = data.get('login_data', {}).get('player', {})
    castles = player.get('castles', [])
    
    headers = ['City', 'X,Y', 'Troop', 'Count', 'Glitches', 'Status', 'Untrain Cmd', 'Food Gain']
    style_header(ws, 1, headers)
    
    row = 2
    for castle in castles:
        city_name = castle.get('name', 'Unknown')
        x, y = fieldid_to_coords(castle.get('fieldId', 0))
        troop = castle.get('troop', {})
        
        for t in TROOP_ORDER:
            count = get_safe_int(troop.get(t, 0))
            if count > 0:
                food_cost = FOOD_PER_TROOP.get(t, 1)
                troops_per_glitch = (GLITCH_THRESHOLD // food_cost) + 1
                glitch_count = count // troops_per_glitch
                
                if glitch_count > 0:
                    is_odd = glitch_count % 2 == 1
                    remainder = count - (troops_per_glitch * glitch_count)
                    untrain_amt = remainder + 1
                    
                    ws.cell(row=row, column=1, value=city_name).border = BORDER
                    ws.cell(row=row, column=1).font = Font(bold=True)
                    ws.cell(row=row, column=2, value=f"{x},{y}").border = BORDER
                    ws.cell(row=row, column=3, value=TROOP_NAMES[t]).border = BORDER
                    ws.cell(row=row, column=4, value=count).border = BORDER
                    ws.cell(row=row, column=5, value=glitch_count).border = BORDER
                    
                    status_cell = ws.cell(row=row, column=6, value="ODD ✓" if is_odd else "EVEN ✗")
                    status_cell.border = BORDER
                    status_cell.fill = ODD_FILL if is_odd else EVEN_FILL
                    status_cell.font = Font(bold=True)
                    
                    cmd = f"untrain {TROOP_SHORT[t]}:{untrain_amt}"
                    ws.cell(row=row, column=7, value=cmd).border = BORDER
                    ws.cell(row=row, column=7).font = Font(bold=True)
                    ws.cell(row=row, column=8, value=GLITCH_THRESHOLD if not is_odd else 0).border = BORDER
                    
                    row += 1
    
    auto_width(ws, 8, 14)
    ws.column_dimensions['A'].width = 15
    ws.column_dimensions['G'].width = 22

# ============================================================
# SHEET 4: RESOURCES BY CITY
# ============================================================
def create_resources_sheet(wb, data):
    ws = wb.create_sheet("Resources")
    
    player = data.get('login_data', {}).get('player', {})
    castles = player.get('castles', [])
    
    headers = ['City', 'X,Y', 'Gold', 'Food', 'Wood', 'Stone', 'Iron', 'Population', 'Food Cost/hr']
    style_header(ws, 1, headers)
    
    for i, castle in enumerate(castles):
        city_name = castle.get('name', f'City_{i}')
        x, y = fieldid_to_coords(castle.get('fieldId', 0))
        res = castle.get('resource', {})
        
        row = i + 2
        ws.cell(row=row, column=1, value=city_name).border = BORDER
        ws.cell(row=row, column=1).font = Font(bold=True)
        ws.cell(row=row, column=2, value=f"{x},{y}").border = BORDER
        ws.cell(row=row, column=3, value=get_resource_amount(res, 'gold')).border = BORDER
        ws.cell(row=row, column=4, value=get_resource_amount(res, 'food')).border = BORDER
        ws.cell(row=row, column=5, value=get_resource_amount(res, 'wood')).border = BORDER
        ws.cell(row=row, column=6, value=get_resource_amount(res, 'stone')).border = BORDER
        ws.cell(row=row, column=7, value=get_resource_amount(res, 'iron')).border = BORDER
        ws.cell(row=row, column=8, value=get_safe_int(res.get('curPopulation', 0))).border = BORDER
        ws.cell(row=row, column=9, value=get_safe_int(res.get('troopCostFood', 0))).border = BORDER
        
        if i % 2 == 1:
            for col in range(1, 10):
                ws.cell(row=row, column=col).fill = ALT_FILL
    
    auto_width(ws, 9, 15)
    ws.column_dimensions['A'].width = 15

# ============================================================
# SHEET 5: HEROES BY CITY
# ============================================================
def create_heroes_sheet(wb, data):
    ws = wb.create_sheet("Heroes")
    
    player = data.get('login_data', {}).get('player', {})
    castles = player.get('castles', [])
    
    headers = ['City', 'Hero Name', 'Level', 'Politics', 'Attack', 'Intel', 'Status', 'Experience']
    style_header(ws, 1, headers)
    
    row = 2
    for castle in castles:
        city_name = castle.get('name', 'Unknown')
        heroes = castle.get('heros', [])
        
        for hero in heroes:
            ws.cell(row=row, column=1, value=city_name).border = BORDER
            ws.cell(row=row, column=1).font = Font(bold=True)
            ws.cell(row=row, column=2, value=hero.get('name', 'Unknown')).border = BORDER
            ws.cell(row=row, column=3, value=get_safe_int(hero.get('level', 0))).border = BORDER
            ws.cell(row=row, column=4, value=get_safe_int(hero.get('power', 0))).border = BORDER
            ws.cell(row=row, column=5, value=get_safe_int(hero.get('management', 0))).border = BORDER
            ws.cell(row=row, column=6, value=get_safe_int(hero.get('stratagem', 0))).border = BORDER
            ws.cell(row=row, column=7, value=hero.get('status', '')).border = BORDER
            ws.cell(row=row, column=8, value=get_safe_int(hero.get('experience', 0))).border = BORDER
            
            if row % 2 == 0:
                for col in range(1, 9):
                    ws.cell(row=row, column=col).fill = ALT_FILL
            row += 1
    
    auto_width(ws, 8, 12)
    ws.column_dimensions['A'].width = 15
    ws.column_dimensions['B'].width = 18

# ============================================================
# SHEET 6: ITEMS INVENTORY
# ============================================================
def create_items_sheet(wb, data):
    ws = wb.create_sheet("Items")
    
    player = data.get('login_data', {}).get('player', {})
    items = player.get('items', [])
    
    headers = ['#', 'Item ID', 'Count']
    style_header(ws, 1, headers)
    
    # Sort by count descending
    sorted_items = sorted(items, key=lambda x: get_safe_int(x.get('count', 0)), reverse=True)
    
    for i, item in enumerate(sorted_items):
        row = i + 2
        ws.cell(row=row, column=1, value=i+1).border = BORDER
        ws.cell(row=row, column=2, value=item.get('id', 'Unknown')).border = BORDER
        ws.cell(row=row, column=3, value=get_safe_int(item.get('count', 0))).border = BORDER
        
        if i % 2 == 1:
            for col in range(1, 4):
                ws.cell(row=row, column=col).fill = ALT_FILL
    
    auto_width(ws, 3, 12)
    ws.column_dimensions['B'].width = 40

# ============================================================
# SHEET 7: BUILDINGS BY CITY
# ============================================================
def create_buildings_sheet(wb, data):
    ws = wb.create_sheet("Buildings")
    
    player = data.get('login_data', {}).get('player', {})
    castles = player.get('castles', [])
    
    headers = ['City', 'Building', 'Level', 'Position', 'Status']
    style_header(ws, 1, headers)
    
    row = 2
    for castle in castles:
        city_name = castle.get('name', 'Unknown')
        buildings = castle.get('buildings', [])
        
        # Sort buildings by level descending
        sorted_bldgs = sorted(buildings, key=lambda x: get_safe_int(x.get('level', 0)), reverse=True)
        
        for bldg in sorted_bldgs:
            ws.cell(row=row, column=1, value=city_name).border = BORDER
            ws.cell(row=row, column=1).font = Font(bold=True)
            ws.cell(row=row, column=2, value=bldg.get('name', 'Unknown')).border = BORDER
            ws.cell(row=row, column=3, value=get_safe_int(bldg.get('level', 0))).border = BORDER
            ws.cell(row=row, column=4, value=bldg.get('positionId', 0)).border = BORDER
            ws.cell(row=row, column=5, value=bldg.get('status', 0)).border = BORDER
            
            if row % 2 == 0:
                for col in range(1, 6):
                    ws.cell(row=row, column=col).fill = ALT_FILL
            row += 1
    
    auto_width(ws, 5, 12)
    ws.column_dimensions['A'].width = 15
    ws.column_dimensions['B'].width = 18

# ============================================================
# SHEET 8: COLONIES
# ============================================================
def create_colonies_sheet(wb, data):
    ws = wb.create_sheet("Colonies")
    
    player = data.get('login_data', {}).get('player', {})
    castles = player.get('castles', [])
    
    headers = ['Your City', 'Colony Name', 'Lord', 'Alliance', 'Colony ID', 'Can Levy']
    style_header(ws, 1, headers)
    
    row = 2
    for castle in castles:
        city_name = castle.get('name', 'Unknown')
        colonies = castle.get('colonyBeans', [])
        
        for col_data in colonies:
            ws.cell(row=row, column=1, value=city_name).border = BORDER
            ws.cell(row=row, column=1).font = Font(bold=True)
            ws.cell(row=row, column=2, value=col_data.get('cityName', 'Unknown')).border = BORDER
            ws.cell(row=row, column=3, value=col_data.get('lordName', '')).border = BORDER
            ws.cell(row=row, column=4, value=col_data.get('allianceName', '')).border = BORDER
            ws.cell(row=row, column=5, value=col_data.get('castleId', 0)).border = BORDER
            ws.cell(row=row, column=6, value="Yes" if col_data.get('isCanLevy') else "No").border = BORDER
            
            if row % 2 == 0:
                for c in range(1, 7):
                    ws.cell(row=row, column=c).fill = ALT_FILL
            row += 1
    
    auto_width(ws, 6, 12)
    ws.column_dimensions['A'].width = 15
    ws.column_dimensions['B'].width = 18

# ============================================================
# SHEET 9: BUFFS
# ============================================================
def create_buffs_sheet(wb, data):
    ws = wb.create_sheet("Buffs")
    
    player = data.get('login_data', {}).get('player', {})
    buffs = player.get('buffs', [])
    
    headers = ['#', 'Buff Type', 'Description']
    style_header(ws, 1, headers)
    
    for i, buff in enumerate(buffs):
        row = i + 2
        ws.cell(row=row, column=1, value=i+1).border = BORDER
        ws.cell(row=row, column=2, value=buff.get('typeId', 'Unknown')).border = BORDER
        ws.cell(row=row, column=3, value=buff.get('descName', '')).border = BORDER
    
    auto_width(ws, 3, 12)
    ws.column_dimensions['B'].width = 30
    ws.column_dimensions['C'].width = 50

# ============================================================
# SHEET 10: EQUIPMENT
# ============================================================
def create_equipment_sheet(wb, data):
    ws = wb.create_sheet("Equipment")
    
    player = data.get('login_data', {}).get('player', {})
    equipment = player.get('equipments', [])
    
    headers = ['#', 'Equipment ID', 'Details']
    style_header(ws, 1, headers)
    
    for i, eq in enumerate(equipment):
        row = i + 2
        ws.cell(row=row, column=1, value=i+1).border = BORDER
        ws.cell(row=row, column=2, value=str(eq.get('id', eq))).border = BORDER
        ws.cell(row=row, column=3, value=str(eq)[:100]).border = BORDER
    
    auto_width(ws, 3, 12)
    ws.column_dimensions['B'].width = 30
    ws.column_dimensions['C'].width = 60

# ============================================================
# MAIN
# ============================================================
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
    
    print("Creating Excel...")
    wb = Workbook()
    
    create_overview_sheet(wb, data)
    create_troops_sheet(wb, data)
    create_glitch_sheet(wb, data)
    create_resources_sheet(wb, data)
    create_heroes_sheet(wb, data)
    create_items_sheet(wb, data)
    create_buildings_sheet(wb, data)
    create_colonies_sheet(wb, data)
    create_buffs_sheet(wb, data)
    create_equipment_sheet(wb, data)
    
    output_dir = os.path.join(os.path.dirname(__file__), 'data', 'exports')
    os.makedirs(output_dir, exist_ok=True)
    
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    output_file = os.path.join(output_dir, f"borg_data_v2_{timestamp}.xlsx")
    
    wb.save(output_file)
    
    # Print summary
    player = data.get('login_data', {}).get('player', {})
    castles = player.get('castles', [])
    
    print(f"\nSaved: {output_file}")
    print(f"\nData Summary:")
    print(f"  Cities: {len(castles)}")
    for c in castles:
        x, y = fieldid_to_coords(c.get('fieldId', 0))
        print(f"    - {c.get('name')} ({x},{y})")
    print(f"  Items: {len(player.get('items', []))}")
    print(f"  Total Heroes: {sum(len(c.get('heros', [])) for c in castles)}")
    print(f"  Total Buildings: {sum(len(c.get('buildings', [])) for c in castles)}")

if __name__ == "__main__":
    main()
