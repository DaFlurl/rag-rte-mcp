#!/usr/bin/env python3
"""
Borg Account Data Web Viewer
Creates a local web server to view all account data in a nice UI
"""

import json
import os
from http.server import HTTPServer, SimpleHTTPRequestHandler
import webbrowser
from datetime import datetime

# Field types
FIELD_TYPES = {
    1: 'Forest', 2: 'Desert', 3: 'Hill', 4: 'Swamp',
    5: 'Grassland', 6: 'Lake', 10: 'Flat', 11: 'NPC'
}

TROOP_NAMES = {
    'peasants': 'Workers', 'militia': 'Warriors', 'scouter': 'Scouts',
    'pikemen': 'Pikemen', 'swordsmen': 'Swordsmen', 'archer': 'Archers',
    'lightCavalry': 'Cavalry', 'heavyCavalry': 'Cataphracts',
    'carriage': 'Transporters', 'ballista': 'Ballista',
    'batteringRam': 'BattRams', 'catapult': 'Catapults'
}

FOOD_PER_TROOP = {
    'peasants': 1, 'militia': 1, 'scouter': 2, 'pikemen': 3,
    'swordsmen': 3, 'archer': 4, 'lightCavalry': 9, 'heavyCavalry': 17,
    'carriage': 5, 'ballista': 25, 'batteringRam': 50, 'catapult': 125
}

def fieldid_to_coords(fid):
    return (fid % 800, fid // 800)

def get_safe_int(val):
    try:
        return int(float(val)) if val else 0
    except:
        return 0

def get_resource(res, key):
    val = res.get(key, 0)
    if isinstance(val, dict):
        return get_safe_int(val.get('amount', 0))
    return get_safe_int(val)

def format_number(n):
    return f"{n:,}"

def generate_html(data):
    player = data.get('login_data', {}).get('player', {})
    castles = player.get('castles', [])
    player_info = player.get('playerInfo', {})
    
    html = """<!DOCTYPE html>
<html>
<head>
    <title>Borg Account Data Viewer</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #1a1a2e; color: #eee; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 20px; text-align: center; }
        .header h1 { font-size: 28px; margin-bottom: 5px; }
        .header p { opacity: 0.8; }
        .tabs { display: flex; background: #16213e; flex-wrap: wrap; }
        .tab { padding: 12px 20px; cursor: pointer; border-bottom: 3px solid transparent; transition: all 0.3s; }
        .tab:hover { background: #1f4068; }
        .tab.active { border-bottom-color: #667eea; background: #1f4068; }
        .content { padding: 20px; max-width: 1400px; margin: 0 auto; }
        .section { display: none; }
        .section.active { display: block; }
        table { width: 100%; border-collapse: collapse; margin: 15px 0; background: #16213e; border-radius: 8px; overflow: hidden; }
        th { background: #667eea; padding: 12px; text-align: left; font-weight: 600; }
        td { padding: 10px 12px; border-bottom: 1px solid #2a2a4a; }
        tr:hover { background: #1f4068; }
        .card { background: #16213e; border-radius: 8px; padding: 20px; margin: 15px 0; }
        .card h3 { color: #667eea; margin-bottom: 15px; border-bottom: 1px solid #2a2a4a; padding-bottom: 10px; }
        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; }
        .stat { background: #1f4068; padding: 15px; border-radius: 6px; }
        .stat-label { font-size: 12px; color: #888; text-transform: uppercase; }
        .stat-value { font-size: 24px; font-weight: bold; color: #667eea; }
        .odd { background: #2ecc71; color: #000; padding: 2px 8px; border-radius: 4px; font-weight: bold; }
        .even { background: #e74c3c; color: #fff; padding: 2px 8px; border-radius: 4px; font-weight: bold; }
        .search { padding: 10px; width: 100%; background: #1f4068; border: none; color: #fff; border-radius: 6px; margin-bottom: 15px; }
        .city-header { background: #764ba2; color: #fff; padding: 10px 15px; margin: 20px 0 10px 0; border-radius: 6px; font-weight: bold; }
        code { background: #2a2a4a; padding: 2px 6px; border-radius: 4px; font-size: 12px; }
        .small { font-size: 11px; color: #888; }
    </style>
</head>
<body>
    <div class="header">
        <h1>🏰 Borg Account Data Viewer</h1>
        <p>""" + f"{data.get('email', '')} | Server: {data.get('server', '')} | {len(castles)} Cities" + """</p>
    </div>
    
    <div class="tabs">
        <div class="tab active" onclick="showTab('overview')">Overview</div>
        <div class="tab" onclick="showTab('cities')">Cities</div>
        <div class="tab" onclick="showTab('troops')">Troops</div>
        <div class="tab" onclick="showTab('glitches')">Glitches</div>
        <div class="tab" onclick="showTab('heroes')">Heroes</div>
        <div class="tab" onclick="showTab('items')">Items</div>
        <div class="tab" onclick="showTab('buildings')">Buildings</div>
        <div class="tab" onclick="showTab('resources')">Resources</div>
        <div class="tab" onclick="showTab('colonies')">Colonies</div>
        <div class="tab" onclick="showTab('fields')">Fields</div>
        <div class="tab" onclick="showTab('friends')">Friends</div>
    </div>
    
    <div class="content">
"""
    
    # OVERVIEW TAB
    html += """<div id="overview" class="section active">
        <div class="grid">
            <div class="stat">
                <div class="stat-label">Player Name</div>
                <div class="stat-value">""" + str(player_info.get('userName', 'Unknown')) + """</div>
            </div>
            <div class="stat">
                <div class="stat-label">Alliance</div>
                <div class="stat-value">""" + str(player_info.get('allianceName', 'None')) + """</div>
            </div>
            <div class="stat">
                <div class="stat-label">Prestige</div>
                <div class="stat-value">""" + format_number(get_safe_int(player_info.get('honor', 0))) + """</div>
            </div>
            <div class="stat">
                <div class="stat-label">Cities</div>
                <div class="stat-value">""" + str(len(castles)) + """</div>
            </div>
        </div>
        
        <div class="card">
            <h3>Your Cities</h3>
            <table>
                <tr><th>#</th><th>City Name</th><th>Coords</th><th>Power Level</th><th>ID</th></tr>
"""
    for i, castle in enumerate(castles):
        x, y = fieldid_to_coords(castle.get('fieldId', 0))
        html += f"<tr><td>{i+1}</td><td><b>{castle.get('name', '')}</b></td><td>({x}, {y})</td><td>{castle.get('powerlevel', 0)}</td><td><code>{castle.get('id', 0)}</code></td></tr>\n"
    
    html += """</table></div></div>"""
    
    # CITIES TAB
    html += """<div id="cities" class="section">"""
    for i, castle in enumerate(castles):
        x, y = fieldid_to_coords(castle.get('fieldId', 0))
        html += f"""<div class="city-header">🏰 [{i+1}] {castle.get('name', '')} ({x}, {y})</div>
        <div class="grid">
            <div class="stat"><div class="stat-label">Power Level</div><div class="stat-value">{castle.get('powerlevel', 0)}</div></div>
            <div class="stat"><div class="stat-label">Heroes</div><div class="stat-value">{len(castle.get('heros', []))}</div></div>
            <div class="stat"><div class="stat-label">Colonies</div><div class="stat-value">{len(castle.get('colonyBeans', []))}</div></div>
            <div class="stat"><div class="stat-label">Buildings</div><div class="stat-value">{len(castle.get('buildings', []))}</div></div>
        </div>"""
    html += """</div>"""
    
    # TROOPS TAB
    html += """<div id="troops" class="section">
        <div class="card"><h3>Troops by City</h3>
        <table><tr><th>City</th><th>Coords</th>"""
    for t in TROOP_NAMES.values():
        html += f"<th>{t}</th>"
    html += "<th>Total</th><th>Food/hr</th></tr>\n"
    
    troop_order = list(TROOP_NAMES.keys())
    totals = {t: 0 for t in troop_order}
    
    for castle in castles:
        x, y = fieldid_to_coords(castle.get('fieldId', 0))
        troop = castle.get('troop', {})
        res = castle.get('resource', {})
        html += f"<tr><td><b>{castle.get('name', '')}</b></td><td>({x},{y})</td>"
        city_total = 0
        for t in troop_order:
            count = get_safe_int(troop.get(t, 0))
            city_total += count
            totals[t] += count
            html += f"<td>{format_number(count)}</td>"
        html += f"<td><b>{format_number(city_total)}</b></td>"
        html += f"<td>{format_number(get_safe_int(res.get('troopCostFood', 0)))}</td></tr>\n"
    
    # Totals row
    html += "<tr style='background:#667eea;'><td><b>TOTAL</b></td><td></td>"
    for t in troop_order:
        html += f"<td><b>{format_number(totals[t])}</b></td>"
    html += f"<td><b>{format_number(sum(totals.values()))}</b></td><td></td></tr>"
    html += "</table></div></div>"
    
    # GLITCHES TAB
    html += """<div id="glitches" class="section">
        <div class="card"><h3>Glitch Analysis</h3>
        <table><tr><th>City</th><th>Coords</th><th>Troop</th><th>Count</th><th>Glitches</th><th>Status</th><th>Untrain Command</th></tr>"""
    
    short_names = {'peasants': 'wo', 'militia': 'w', 'scouter': 's', 'pikemen': 'p',
                   'swordsmen': 'sw', 'archer': 'a', 'lightCavalry': 'c', 'heavyCavalry': 'cata',
                   'carriage': 't', 'ballista': 'b', 'batteringRam': 'r', 'catapult': 'cp'}
    
    for castle in castles:
        x, y = fieldid_to_coords(castle.get('fieldId', 0))
        troop = castle.get('troop', {})
        for t in troop_order:
            count = get_safe_int(troop.get(t, 0))
            if count > 0:
                food = FOOD_PER_TROOP.get(t, 1)
                threshold = (2147483647 // food) + 1
                glitches = count // threshold
                if glitches > 0:
                    is_odd = glitches % 2 == 1
                    remainder = count - (threshold * glitches)
                    untrain = remainder + 1
                    status = '<span class="odd">ODD ✓</span>' if is_odd else '<span class="even">EVEN ✗</span>'
                    html += f"<tr><td><b>{castle.get('name','')}</b></td><td>({x},{y})</td><td>{TROOP_NAMES[t]}</td>"
                    html += f"<td>{format_number(count)}</td><td>{glitches}</td><td>{status}</td>"
                    html += f"<td><code>untrain {short_names[t]}:{untrain}</code></td></tr>\n"
    html += "</table></div></div>"
    
    # HEROES TAB
    html += """<div id="heroes" class="section">
        <input type="text" class="search" placeholder="Search heroes..." onkeyup="filterTable(this, 'heroes-table')">
        <div class="card"><h3>All Heroes (""" + str(sum(len(c.get('heros', [])) for c in castles)) + """)</h3>
        <table id="heroes-table"><tr><th>City</th><th>Hero Name</th><th>Level</th><th>Politics</th><th>Attack</th><th>Intel</th><th>Loyalty</th></tr>"""
    
    for castle in castles:
        for hero in castle.get('heros', []):
            html += f"<tr><td>{castle.get('name','')}</td><td><b>{hero.get('name','')}</b></td>"
            html += f"<td>{hero.get('level',0)}</td><td>{int(float(hero.get('politics',0)))}</td>"
            html += f"<td>{hero.get('power',0)}</td><td>{hero.get('stratagem',0)}</td><td>{hero.get('loyalty',0)}</td></tr>\n"
    html += "</table></div></div>"
    
    # ITEMS TAB
    items = player.get('items', [])
    items_sorted = sorted(items, key=lambda x: x.get('count', 0), reverse=True)
    
    html += """<div id="items" class="section">
        <input type="text" class="search" placeholder="Search items..." onkeyup="filterTable(this, 'items-table')">
        <div class="card"><h3>Inventory (""" + str(len(items)) + """ items)</h3>
        <table id="items-table"><tr><th>#</th><th>Item ID</th><th>Count</th><th>Category</th></tr>"""
    
    for i, item in enumerate(items_sorted):
        item_id = item.get('id', '')
        count = item.get('count', 0)
        if 'consume' in item_id: cat = 'Consumable'
        elif 'box' in item_id: cat = 'Chest'
        elif 'trick' in item_id: cat = 'Stratagem'
        elif 'hero' in item_id: cat = 'Hero'
        elif 'equipment' in item_id: cat = 'Equipment'
        elif 'resinc' in item_id: cat = 'Resource'
        else: cat = 'Other'
        html += f"<tr><td>{i+1}</td><td><code>{item_id}</code></td><td>{format_number(count)}</td><td>{cat}</td></tr>\n"
    html += "</table></div></div>"
    
    # BUILDINGS TAB
    html += """<div id="buildings" class="section">"""
    for castle in castles:
        html += f"""<div class="city-header">🏰 {castle.get('name', '')}</div>
        <table><tr><th>Building</th><th>Level</th><th>Position</th></tr>"""
        buildings = sorted(castle.get('buildings', []), key=lambda x: x.get('level', 0), reverse=True)
        for bldg in buildings:
            html += f"<tr><td>{bldg.get('name','')}</td><td>{bldg.get('level',0)}</td><td>{bldg.get('positionId',0)}</td></tr>\n"
        html += "</table>"
    html += "</div>"
    
    # RESOURCES TAB
    html += """<div id="resources" class="section">
        <div class="card"><h3>Resources by City</h3>
        <table><tr><th>City</th><th>Gold</th><th>Food</th><th>Wood</th><th>Stone</th><th>Iron</th><th>Population</th></tr>"""
    
    for castle in castles:
        res = castle.get('resource', {})
        html += f"<tr><td><b>{castle.get('name','')}</b></td>"
        html += f"<td>{format_number(get_resource(res,'gold'))}</td>"
        html += f"<td>{format_number(get_resource(res,'food'))}</td>"
        html += f"<td>{format_number(get_resource(res,'wood'))}</td>"
        html += f"<td>{format_number(get_resource(res,'stone'))}</td>"
        html += f"<td>{format_number(get_resource(res,'iron'))}</td>"
        html += f"<td>{format_number(get_safe_int(res.get('curPopulation',0)))}</td></tr>\n"
    html += "</table></div></div>"
    
    # COLONIES TAB
    html += """<div id="colonies" class="section">
        <div class="card"><h3>Colonies (""" + str(sum(len(c.get('colonyBeans', [])) for c in castles)) + """)</h3>
        <table><tr><th>Owner City</th><th>Colony Name</th><th>Lord</th><th>Alliance</th><th>Can Levy</th></tr>"""
    
    for castle in castles:
        for col in castle.get('colonyBeans', []):
            html += f"<tr><td><b>{castle.get('name','')}</b></td><td>{col.get('cityName','')}</td>"
            html += f"<td>{col.get('lordName','')}</td><td>{col.get('allianceName','')}</td>"
            html += f"<td>{'✓' if col.get('isCanLevy') else '✗'}</td></tr>\n"
    html += "</table></div></div>"
    
    # FIELDS TAB
    html += """<div id="fields" class="section">
        <div class="card"><h3>Fields (Valleys)</h3>
        <table><tr><th>Owner City</th><th>Field Name</th><th>Type</th><th>Level</th><th>Coords</th><th>Field ID</th></tr>"""
    
    for castle in castles:
        for field in castle.get('fields', []):
            fid = field.get('id', 0)
            x, y = fieldid_to_coords(fid)
            ftype = FIELD_TYPES.get(field.get('type', 0), 'Unknown')
            html += f"<tr><td><b>{castle.get('name','')}</b></td><td>{field.get('name','')}</td>"
            html += f"<td>{ftype}</td><td>{field.get('level',0)}</td><td>({x},{y})</td><td><code>{fid}</code></td></tr>\n"
    html += "</table></div></div>"
    
    # FRIENDS TAB
    friends = player.get('friendBeans', [])
    html += """<div id="friends" class="section">
        <input type="text" class="search" placeholder="Search friends..." onkeyup="filterTable(this, 'friends-table')">
        <div class="card"><h3>Friends (""" + str(len(friends)) + """)</h3>
        <table id="friends-table"><tr><th>#</th><th>Name</th><th>Alliance</th><th>Level</th><th>Prestige</th></tr>"""
    
    for i, friend in enumerate(friends):
        html += f"<tr><td>{i+1}</td><td><b>{friend.get('userName','')}</b></td>"
        html += f"<td>{friend.get('allianceName','')}</td><td>{friend.get('levelId',0)}</td>"
        html += f"<td>{format_number(get_safe_int(friend.get('honor',0)))}</td></tr>\n"
    html += "</table></div></div>"
    
    # JavaScript
    html += """
    </div>
    <script>
        function showTab(tabId) {
            document.querySelectorAll('.section').forEach(s => s.classList.remove('active'));
            document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
            document.getElementById(tabId).classList.add('active');
            event.target.classList.add('active');
        }
        
        function filterTable(input, tableId) {
            const filter = input.value.toLowerCase();
            const table = document.getElementById(tableId);
            const rows = table.getElementsByTagName('tr');
            for (let i = 1; i < rows.length; i++) {
                const text = rows[i].textContent.toLowerCase();
                rows[i].style.display = text.includes(filter) ? '' : 'none';
            }
        }
    </script>
</body>
</html>"""
    
    return html

def main():
    dumps_dir = os.path.join(os.path.dirname(__file__), 'data', 'dumps')
    json_files = sorted([f for f in os.listdir(dumps_dir) if f.endswith('.json')])
    latest_file = json_files[-1]
    json_path = os.path.join(dumps_dir, latest_file)
    
    print(f"Loading: {latest_file}")
    with open(json_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    print("Generating HTML...")
    html = generate_html(data)
    
    # Save HTML
    output_dir = os.path.join(os.path.dirname(__file__), 'data', 'viewer')
    os.makedirs(output_dir, exist_ok=True)
    output_file = os.path.join(output_dir, 'index.html')
    
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(html)
    
    print(f"Saved: {output_file}")
    print(f"\nOpening in browser...")
    webbrowser.open(f'file://{output_file}')

if __name__ == "__main__":
    main()
