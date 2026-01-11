#!/usr/bin/env python3
"""
Borg Account Data to Excel Exporter
Parses JSON dump and creates formatted Excel spreadsheet
"""

import json
import os
from datetime import datetime

try:
    from openpyxl import Workbook
    from openpyxl.styles import Font, Fill, PatternFill, Alignment, Border, Side
    from openpyxl.utils import get_column_letter
except ImportError:
    print("Installing openpyxl...")
    import subprocess
    subprocess.check_call(['pip', 'install', 'openpyxl'])
    from openpyxl import Workbook
    from openpyxl.styles import Font, Fill, PatternFill, Alignment, Border, Side
    from openpyxl.utils import get_column_letter

# Glitch calculation constants
GLITCH_THRESHOLD = 2147483647
FOOD_PER_TROOP = {
    'peasants': 1, 'militia': 1, 'scouter': 2, 'pikemen': 3,
    'swordsmen': 3, 'archer': 4, 'lightCavalry': 9, 'heavyCavalry': 17,
    'carriage': 5, 'ballista': 25, 'batteringRam': 50, 'catapult': 125
}

TROOP_DISPLAY = {
    'peasants': 'Workers', 'militia': 'Warriors', 'scouter': 'Scouts',
    'pikemen': 'Pikemen', 'swordsmen': 'Swordsmen', 'archer': 'Archers',
    'lightCavalry': 'Cavalry', 'heavyCavalry': 'Cataphracts',
    'carriage': 'Transporters', 'ballista': 'Ballista',
    'batteringRam': 'BattRams', 'catapult': 'Catapults'
}

TROOP_SHORT = {
    'peasants': 'wo', 'militia': 'w', 'scouter': 's', 'pikemen': 'p',
    'swordsmen': 'sw', 'archer': 'a', 'lightCavalry': 'c', 'heavyCavalry': 'cata',
    'carriage': 't', 'ballista': 'b', 'batteringRam': 'r', 'catapult': 'cp'
}

def calc_glitch_info(troop_type, count):
    """Calculate glitch count and status"""
    if count == 0:
        return 0, False, 0
    
    food_cost = FOOD_PER_TROOP.get(troop_type, 1)
    troops_per_glitch = (GLITCH_THRESHOLD // food_cost) + 1
    glitch_count = int(count) // troops_per_glitch
    is_odd = glitch_count % 2 == 1
    
    # Calculate untrain amount
    completed_glitches = troops_per_glitch * glitch_count
    remainder = int(count) - completed_glitches
    untrain_amt = remainder + 1
    
    return glitch_count, is_odd, untrain_amt

def create_excel(json_file, output_file):
    """Create formatted Excel from JSON dump"""
    
    with open(json_file, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    wb = Workbook()
    
    # Styles
    header_font = Font(bold=True, size=12, color="FFFFFF")
    header_fill = PatternFill(start_color="0066CC", end_color="0066CC", fill_type="solid")
    odd_fill = PatternFill(start_color="90EE90", end_color="90EE90", fill_type="solid")  # Light green
    even_fill = PatternFill(start_color="FFB6C1", end_color="FFB6C1", fill_type="solid")  # Light red
    city_fill = PatternFill(start_color="E6E6FA", end_color="E6E6FA", fill_type="solid")  # Lavender
    thin_border = Border(
        left=Side(style='thin'), right=Side(style='thin'),
        top=Side(style='thin'), bottom=Side(style='thin')
    )
    
    login_data = data.get('login_data', {})
    player = login_data.get('player', {})
    city_signs = player.get('castleSignBean', [])
    castles = player.get('castles', [])
    
    # ============================================================
    # Sheet 1: Cities Overview
    # ============================================================
    ws1 = wb.active
    ws1.title = "Cities Overview"
    
    headers1 = ['#', 'City Name', 'X', 'Y', 'Total Troops', 'Food Cost/hr', 'ODD Count', 'EVEN Count', 'Status']
    for col, header in enumerate(headers1, 1):
        cell = ws1.cell(row=1, column=col, value=header)
        cell.font = header_font
        cell.fill = header_fill
        cell.alignment = Alignment(horizontal='center')
        cell.border = thin_border
    
    for i, castle in enumerate(castles):
        city_name = city_signs[i].get('name', f'City_{i}') if i < len(city_signs) else f'City_{i}'
        city_x = city_signs[i].get('x', 0) if i < len(city_signs) else 0
        city_y = city_signs[i].get('y', 0) if i < len(city_signs) else 0
        
        resource = castle.get('resource', {})
        food_cost = resource.get('troopCostFood', 0)
        
        troop = castle.get('troop', {})
        total_troops = 0
        odd_count = 0
        even_count = 0
        
        for troop_type in TROOP_DISPLAY.keys():
            count = troop.get(troop_type, 0)
            if count:
                total_troops += int(float(count))
                glitch_count, is_odd, _ = calc_glitch_info(troop_type, float(count))
                if glitch_count > 0:
                    if is_odd:
                        odd_count += 1
                    else:
                        even_count += 1
        
        status = "GOOD" if odd_count > 0 and even_count == 0 else ("NEEDS FIX" if even_count > 0 else "NO GLITCH")
        
        row = i + 2
        ws1.cell(row=row, column=1, value=i+1).border = thin_border
        ws1.cell(row=row, column=2, value=city_name).border = thin_border
        ws1.cell(row=row, column=3, value=city_x).border = thin_border
        ws1.cell(row=row, column=4, value=city_y).border = thin_border
        ws1.cell(row=row, column=5, value=total_troops).border = thin_border
        ws1.cell(row=row, column=6, value=int(float(food_cost)) if food_cost else 0).border = thin_border
        ws1.cell(row=row, column=7, value=odd_count).border = thin_border
        ws1.cell(row=row, column=8, value=even_count).border = thin_border
        
        status_cell = ws1.cell(row=row, column=9, value=status)
        status_cell.border = thin_border
        if status == "GOOD":
            status_cell.fill = odd_fill
        elif status == "NEEDS FIX":
            status_cell.fill = even_fill
    
    # Auto-width columns
    for col in range(1, len(headers1) + 1):
        ws1.column_dimensions[get_column_letter(col)].width = 15
    ws1.column_dimensions['B'].width = 20
    
    # ============================================================
    # Sheet 2: Troops by City
    # ============================================================
    ws2 = wb.create_sheet("Troops by City")
    
    headers2 = ['City', 'X', 'Y', 'Workers', 'Warriors', 'Scouts', 'Pikemen', 'Swordsmen', 
                'Archers', 'Cavalry', 'Cataphracts', 'Transporters', 'Ballista', 'BattRams', 'Catapults', 'TOTAL']
    for col, header in enumerate(headers2, 1):
        cell = ws2.cell(row=1, column=col, value=header)
        cell.font = header_font
        cell.fill = header_fill
        cell.alignment = Alignment(horizontal='center')
        cell.border = thin_border
    
    troop_order = ['peasants', 'militia', 'scouter', 'pikemen', 'swordsmen', 'archer',
                   'lightCavalry', 'heavyCavalry', 'carriage', 'ballista', 'batteringRam', 'catapult']
    
    totals = {t: 0 for t in troop_order}
    
    for i, castle in enumerate(castles):
        city_name = city_signs[i].get('name', f'City_{i}') if i < len(city_signs) else f'City_{i}'
        city_x = city_signs[i].get('x', 0) if i < len(city_signs) else 0
        city_y = city_signs[i].get('y', 0) if i < len(city_signs) else 0
        
        troop = castle.get('troop', {})
        row = i + 2
        
        ws2.cell(row=row, column=1, value=city_name).border = thin_border
        ws2.cell(row=row, column=2, value=city_x).border = thin_border
        ws2.cell(row=row, column=3, value=city_y).border = thin_border
        
        city_total = 0
        for col, troop_type in enumerate(troop_order, 4):
            count = int(float(troop.get(troop_type, 0)))
            ws2.cell(row=row, column=col, value=count).border = thin_border
            city_total += count
            totals[troop_type] += count
        
        ws2.cell(row=row, column=16, value=city_total).border = thin_border
    
    # Totals row
    total_row = len(castles) + 2
    ws2.cell(row=total_row, column=1, value="TOTAL").font = Font(bold=True)
    ws2.cell(row=total_row, column=1).fill = header_fill
    ws2.cell(row=total_row, column=1).font = header_font
    
    grand_total = 0
    for col, troop_type in enumerate(troop_order, 4):
        cell = ws2.cell(row=total_row, column=col, value=totals[troop_type])
        cell.font = Font(bold=True)
        cell.fill = city_fill
        grand_total += totals[troop_type]
    
    ws2.cell(row=total_row, column=16, value=grand_total).font = Font(bold=True)
    ws2.cell(row=total_row, column=16).fill = city_fill
    
    # Auto-width
    for col in range(1, 17):
        ws2.column_dimensions[get_column_letter(col)].width = 14
    ws2.column_dimensions['A'].width = 18
    
    # ============================================================
    # Sheet 3: Glitch Analysis
    # ============================================================
    ws3 = wb.create_sheet("Glitch Analysis")
    
    headers3 = ['City', 'Troop Type', 'Count', 'Glitches', 'Status', 'Untrain Cmd', 'Food Gain']
    for col, header in enumerate(headers3, 1):
        cell = ws3.cell(row=1, column=col, value=header)
        cell.font = header_font
        cell.fill = header_fill
        cell.alignment = Alignment(horizontal='center')
        cell.border = thin_border
    
    row = 2
    for i, castle in enumerate(castles):
        city_name = city_signs[i].get('name', f'City_{i}') if i < len(city_signs) else f'City_{i}'
        troop = castle.get('troop', {})
        
        for troop_type in troop_order:
            count = float(troop.get(troop_type, 0))
            if count > 0:
                glitch_count, is_odd, untrain_amt = calc_glitch_info(troop_type, count)
                
                if glitch_count > 0:
                    status = "ODD ✓" if is_odd else "EVEN ✗"
                    short_name = TROOP_SHORT[troop_type]
                    untrain_cmd = f"untrain {short_name}:{untrain_amt}"
                    food_gain = GLITCH_THRESHOLD if not is_odd else 0
                    
                    ws3.cell(row=row, column=1, value=city_name).border = thin_border
                    ws3.cell(row=row, column=2, value=TROOP_DISPLAY[troop_type]).border = thin_border
                    ws3.cell(row=row, column=3, value=int(count)).border = thin_border
                    ws3.cell(row=row, column=4, value=glitch_count).border = thin_border
                    
                    status_cell = ws3.cell(row=row, column=5, value=status)
                    status_cell.border = thin_border
                    status_cell.fill = odd_fill if is_odd else even_fill
                    status_cell.font = Font(bold=True)
                    
                    ws3.cell(row=row, column=6, value=untrain_cmd).border = thin_border
                    ws3.cell(row=row, column=7, value=food_gain).border = thin_border
                    
                    row += 1
    
    # Auto-width
    for col in range(1, 8):
        ws3.column_dimensions[get_column_letter(col)].width = 18
    ws3.column_dimensions['F'].width = 25
    
    # ============================================================
    # Sheet 4: EVEN Fixes Only
    # ============================================================
    ws4 = wb.create_sheet("EVEN Fixes")
    
    headers4 = ['#', 'City', 'Troop Type', 'Glitches', 'Untrain Command', 'Troops to Lose', 'Food Gain']
    for col, header in enumerate(headers4, 1):
        cell = ws4.cell(row=1, column=col, value=header)
        cell.font = header_font
        cell.fill = PatternFill(start_color="FF0000", end_color="FF0000", fill_type="solid")
        cell.alignment = Alignment(horizontal='center')
        cell.border = thin_border
    
    row = 2
    fix_num = 1
    total_untrain = 0
    total_food_gain = 0
    
    for i, castle in enumerate(castles):
        city_name = city_signs[i].get('name', f'City_{i}') if i < len(city_signs) else f'City_{i}'
        troop = castle.get('troop', {})
        
        for troop_type in troop_order:
            count = float(troop.get(troop_type, 0))
            if count > 0:
                glitch_count, is_odd, untrain_amt = calc_glitch_info(troop_type, count)
                
                if glitch_count > 0 and not is_odd:  # EVEN only
                    short_name = TROOP_SHORT[troop_type]
                    untrain_cmd = f"untrain {short_name}:{untrain_amt}"
                    
                    ws4.cell(row=row, column=1, value=fix_num).border = thin_border
                    ws4.cell(row=row, column=2, value=city_name).border = thin_border
                    ws4.cell(row=row, column=3, value=TROOP_DISPLAY[troop_type]).border = thin_border
                    ws4.cell(row=row, column=4, value=glitch_count).border = thin_border
                    
                    cmd_cell = ws4.cell(row=row, column=5, value=untrain_cmd)
                    cmd_cell.border = thin_border
                    cmd_cell.font = Font(bold=True)
                    
                    ws4.cell(row=row, column=6, value=untrain_amt).border = thin_border
                    ws4.cell(row=row, column=7, value=GLITCH_THRESHOLD).border = thin_border
                    
                    total_untrain += untrain_amt
                    total_food_gain += GLITCH_THRESHOLD
                    fix_num += 1
                    row += 1
    
    # Totals row
    total_row = row
    ws4.cell(row=total_row, column=1, value="TOTAL").font = Font(bold=True)
    ws4.cell(row=total_row, column=5, value=f"{fix_num-1} fixes").font = Font(bold=True)
    ws4.cell(row=total_row, column=6, value=total_untrain).font = Font(bold=True)
    ws4.cell(row=total_row, column=7, value=total_food_gain).font = Font(bold=True)
    
    # Auto-width
    for col in range(1, 8):
        ws4.column_dimensions[get_column_letter(col)].width = 18
    ws4.column_dimensions['E'].width = 25
    
    # Save
    wb.save(output_file)
    print(f"Excel file saved: {output_file}")
    return output_file

def main():
    dumps_dir = os.path.join(os.path.dirname(__file__), 'data', 'dumps')
    
    if not os.path.exists(dumps_dir):
        print(f"Dumps directory not found: {dumps_dir}")
        return
    
    json_files = [f for f in os.listdir(dumps_dir) if f.endswith('.json')]
    
    if not json_files:
        print("No JSON dump files found")
        return
    
    latest_file = sorted(json_files)[-1]
    json_path = os.path.join(dumps_dir, latest_file)
    
    print(f"Parsing: {latest_file}")
    
    output_dir = os.path.join(os.path.dirname(__file__), 'data', 'exports')
    os.makedirs(output_dir, exist_ok=True)
    
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    output_file = os.path.join(output_dir, f"borg_account_{timestamp}.xlsx")
    
    create_excel(json_path, output_file)
    
    print(f"\nSheets created:")
    print("  1. Cities Overview - Summary of all cities")
    print("  2. Troops by City - Detailed troop counts")
    print("  3. Glitch Analysis - All glitches with status")
    print("  4. EVEN Fixes - Copy-paste untrain commands")

if __name__ == "__main__":
    main()
