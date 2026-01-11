#!/usr/bin/env python3
"""
BORG TOOLKIT - Output Generator
Generates all output formats: JSON, CSV, HTML, TXT
"""

import json
import csv
import html
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Any
from dataclasses import asdict

from .data_models import CompleteAccountData

class OutputGenerator:
    """Generates all output formats for extracted data"""
    
    def __init__(self, base_dir: Path):
        self.base_dir = base_dir
        self.base_dir.mkdir(parents=True, exist_ok=True)
    
    def generate_all(self, account: CompleteAccountData) -> Dict[str, Path]:
        """Generate all output files for an account"""
        safe_email = account.login_email.replace('@', '_at_').replace('.', '_')
        account_dir = self.base_dir / safe_email
        account_dir.mkdir(exist_ok=True)
        
        paths = {}
        paths['json'] = self._write_json(account_dir, account)
        paths['csv'] = self._write_csvs(account_dir, account)
        paths['html'] = self._write_html(account_dir, account)
        paths['txt'] = self._write_txts(account_dir, account)
        
        return paths
    
    def _to_dict(self, obj: Any) -> Any:
        if hasattr(obj, '__dataclass_fields__'):
            return {k: self._to_dict(v) for k, v in asdict(obj).items()}
        elif isinstance(obj, list):
            return [self._to_dict(i) for i in obj]
        elif isinstance(obj, dict):
            return {k: self._to_dict(v) for k, v in obj.items()}
        return obj
    
    def _write_json(self, dir: Path, account: CompleteAccountData) -> Path:
        filepath = dir / "complete_dump.json"
        data = self._to_dict(account)
        with open(filepath, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=2, ensure_ascii=False, default=str)
        return filepath
    
    def _write_csvs(self, dir: Path, account: CompleteAccountData) -> Dict[str, Path]:
        paths = {}
        csv_dir = dir / "csv"
        csv_dir.mkdir(exist_ok=True)
        
        # Cities
        with open(csv_dir / "cities.csv", 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            writer.writerow(['Name', 'Coords', 'Level', 'Gold', 'Food', 'Wood', 'Stone', 'Iron', 'Troops', 'Heroes'])
            for c in account.cities:
                writer.writerow([c.name, c.coords, c.level, c.resources.gold, c.resources.food,
                               c.resources.wood, c.resources.stone, c.resources.iron, 
                               c.troops.total(), len(c.heroes)])
        paths['cities'] = csv_dir / "cities.csv"
        
        # Troops
        with open(csv_dir / "troops.csv", 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            writer.writerow(['City', 'Workers', 'Warriors', 'Scouts', 'Pikemen', 'Swordsmen', 
                           'Archers', 'Cavalry', 'Cataphracts', 'Transporters', 'Ballistas', 
                           'Rams', 'Catapults', 'Total'])
            for c in account.cities:
                t = c.troops
                writer.writerow([c.name, t.workers, t.warriors, t.scouts, t.pikemen, t.swordsmen,
                               t.archers, t.cavalry, t.cataphracts, t.transporters, t.ballistas,
                               t.rams, t.catapults, t.total()])
        paths['troops'] = csv_dir / "troops.csv"
        
        # Heroes
        with open(csv_dir / "heroes.csv", 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            writer.writerow(['Name', 'Level', 'ATK', 'DEF', 'POL', 'INT', 'City', 'Historic', 'Mayor', 'Marshal'])
            for c in account.cities:
                for h in c.heroes:
                    writer.writerow([h.name, h.level, h.attack, h.defense, h.politics, h.intelligence,
                                   c.name, h.is_historic, h.is_mayor, h.is_marshal])
        paths['heroes'] = csv_dir / "heroes.csv"
        
        # Items
        with open(csv_dir / "items.csv", 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            writer.writerow(['Name', 'Count', 'Category'])
            for item in account.items:
                writer.writerow([item.name, item.count, item.category])
        paths['items'] = csv_dir / "items.csv"
        
        return paths
    
    def _write_html(self, dir: Path, account: CompleteAccountData) -> Path:
        filepath = dir / "viewer.html"
        html_content = self._generate_html(account)
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(html_content)
        return filepath
    
    def _generate_html(self, acc: CompleteAccountData) -> str:
        cities_html = ""
        for c in acc.cities:
            main = " 👑" if c.is_main else ""
            cities_html += f"<tr><td><strong>{html.escape(c.name)}</strong>{main}</td><td>{c.coords}</td><td>{c.level}</td><td>{c.resources.population:,}</td><td>{c.troops.total():,}</td><td>{len(c.heroes)}</td></tr>"
        
        troops_html = ""
        for c in acc.cities:
            troops_html += f'''<div class="card">
                <h3>{html.escape(c.name)} @ {c.coords}</h3>
                <div class="stat"><span>Workers</span><span class="val">{c.troops.workers:,}</span></div>
                <div class="stat"><span>Warriors</span><span class="val">{c.troops.warriors:,}</span></div>
                <div class="stat"><span>Scouts</span><span class="val">{c.troops.scouts:,}</span></div>
                <div class="stat"><span>Pikemen</span><span class="val">{c.troops.pikemen:,}</span></div>
                <div class="stat"><span>Swordsmen</span><span class="val">{c.troops.swordsmen:,}</span></div>
                <div class="stat"><span>Archers</span><span class="val">{c.troops.archers:,}</span></div>
                <div class="stat"><span>Cavalry</span><span class="val">{c.troops.cavalry:,}</span></div>
                <div class="stat"><span>Cataphracts</span><span class="val">{c.troops.cataphracts:,}</span></div>
                <div class="stat"><span>Transporters</span><span class="val">{c.troops.transporters:,}</span></div>
                <div class="stat"><span>Ballistas</span><span class="val">{c.troops.ballistas:,}</span></div>
                <div class="stat"><span>Rams</span><span class="val">{c.troops.rams:,}</span></div>
                <div class="stat"><span>Catapults</span><span class="val">{c.troops.catapults:,}</span></div>
                <div class="stat total"><span>TOTAL</span><span class="val">{c.troops.total():,}</span></div>
            </div>'''
        
        heroes_html = ""
        for c in acc.cities:
            for h in c.heroes:
                badges = ""
                if h.is_historic: badges += '<span class="badge hh">⭐ HH</span>'
                if h.is_mayor: badges += '<span class="badge mayor">Mayor</span>'
                if h.is_marshal: badges += '<span class="badge marshal">Marshal</span>'
                heroes_html += f"<tr><td><strong>{html.escape(h.name)}</strong> {badges}</td><td>{h.level}</td><td>{h.attack}</td><td>{h.defense}</td><td>{h.politics}</td><td>{h.intelligence}</td><td>{html.escape(c.name)}</td></tr>"
        
        resources_html = ""
        for c in acc.cities:
            r = c.resources
            resources_html += f'''<div class="card">
                <h3>{html.escape(c.name)}</h3>
                <div class="stat"><span>🪙 Gold</span><span class="val">{r.gold:,}</span></div>
                <div class="stat"><span>🌾 Food</span><span class="val">{r.food:,}</span></div>
                <div class="stat"><span>🪵 Wood</span><span class="val">{r.wood:,}</span></div>
                <div class="stat"><span>🪨 Stone</span><span class="val">{r.stone:,}</span></div>
                <div class="stat"><span>⚙️ Iron</span><span class="val">{r.iron:,}</span></div>
                <div class="stat"><span>Tax Rate</span><span class="val">{r.tax_rate}%</span></div>
            </div>'''
        
        items_html = ""
        for item in acc.items[:100]:
            items_html += f"<tr><td>{html.escape(item.name)}</td><td>{item.count:,}</td><td>{html.escape(item.category)}</td></tr>"
        
        return f'''<!DOCTYPE html>
<html><head>
<meta charset="UTF-8"><title>{html.escape(acc.player.name)} - Account Data</title>
<style>
*{{margin:0;padding:0;box-sizing:border-box}}
body{{font-family:'Segoe UI',sans-serif;background:linear-gradient(135deg,#1a1a2e,#16213e);color:#eee;min-height:100vh}}
.header{{background:rgba(0,0,0,0.5);padding:30px;text-align:center;border-bottom:3px solid #e94560}}
.header h1{{color:#e94560;font-size:2.5em}}
.container{{max-width:1400px;margin:0 auto;padding:20px}}
.nav{{display:flex;gap:10px;flex-wrap:wrap;margin-bottom:20px;background:rgba(0,0,0,0.3);padding:15px;border-radius:10px}}
.nav a{{padding:10px 20px;background:rgba(233,69,96,0.2);color:#e94560;text-decoration:none;border-radius:5px;border:1px solid #e94560}}
.nav a:hover{{background:#e94560;color:white}}
.section{{background:rgba(255,255,255,0.05);border-radius:15px;padding:25px;margin-bottom:25px;border:1px solid rgba(233,69,96,0.2)}}
.section h2{{color:#e94560;margin-bottom:20px;border-bottom:2px solid rgba(233,69,96,0.3);padding-bottom:10px}}
.grid{{display:grid;grid-template-columns:repeat(auto-fit,minmax(280px,1fr));gap:20px}}
.card{{background:rgba(0,0,0,0.3);border-radius:10px;padding:20px;border:1px solid rgba(255,255,255,0.1)}}
.card h3{{color:#e94560;margin-bottom:15px}}
.stat{{display:flex;justify-content:space-between;padding:8px 0;border-bottom:1px solid rgba(255,255,255,0.05)}}
.stat .val{{color:#4ecca3;font-weight:bold}}
.stat.total{{border-top:2px solid #e94560;margin-top:10px;padding-top:10px}}
.stat.total .val{{color:#e94560}}
table{{width:100%;border-collapse:collapse}}
th,td{{padding:12px;text-align:left;border-bottom:1px solid rgba(255,255,255,0.1)}}
th{{background:rgba(233,69,96,0.2);color:#e94560}}
tr:hover{{background:rgba(255,255,255,0.05)}}
.badge{{display:inline-block;padding:2px 8px;border-radius:10px;font-size:0.75em;margin-left:5px}}
.badge.hh{{background:#ffd700;color:#000}}
.badge.mayor{{background:#4ecca3;color:#000}}
.badge.marshal{{background:#e94560;color:white}}
.totals{{display:grid;grid-template-columns:repeat(auto-fit,minmax(150px,1fr));gap:15px;margin-bottom:20px}}
.total-box{{background:rgba(0,0,0,0.3);padding:20px;border-radius:10px;text-align:center}}
.total-val{{font-size:2em;color:#4ecca3;font-weight:bold}}
.total-label{{color:#888;margin-top:5px}}
footer{{text-align:center;padding:30px;color:#666}}
</style></head>
<body>
<div class="header">
<h1>🏰 {html.escape(acc.player.name)}</h1>
<div style="color:#888">{html.escape(acc.login_email)} @ {html.escape(acc.login_server)} | {acc.extraction_time}</div>
</div>
<div class="container">
<nav class="nav">
<a href="#overview">📊 Overview</a>
<a href="#cities">🏙️ Cities</a>
<a href="#troops">⚔️ Troops</a>
<a href="#heroes">🦸 Heroes</a>
<a href="#resources">💰 Resources</a>
<a href="#items">📦 Items</a>
</nav>

<section class="section" id="overview">
<h2>📊 Account Overview</h2>
<div class="totals">
<div class="total-box"><div class="total-val">{acc.total_cities}</div><div class="total-label">Cities</div></div>
<div class="total-box"><div class="total-val">{acc.total_troops:,}</div><div class="total-label">Total Troops</div></div>
<div class="total-box"><div class="total-val">{acc.total_heroes}</div><div class="total-label">Heroes</div></div>
<div class="total-box"><div class="total-val">{acc.total_historic_heroes}</div><div class="total-label">Historic ⭐</div></div>
<div class="total-box"><div class="total-val">{acc.player.prestige:,}</div><div class="total-label">Prestige</div></div>
<div class="total-box"><div class="total-val">{acc.player.honor:,}</div><div class="total-label">Honor</div></div>
</div>
<div class="grid">
<div class="card"><h3>👤 Player</h3>
<div class="stat"><span>ID</span><span class="val">{acc.player.id}</span></div>
<div class="stat"><span>Title</span><span class="val">{html.escape(acc.player.title or 'None')}</span></div>
<div class="stat"><span>Level</span><span class="val">{acc.player.level}</span></div>
<div class="stat"><span>Coins</span><span class="val">{acc.player.coins:,}</span></div>
</div>
<div class="card"><h3>🛡️ Alliance</h3>
<div class="stat"><span>Name</span><span class="val">{html.escape(acc.alliance.name or 'None')}</span></div>
<div class="stat"><span>Rank</span><span class="val">{html.escape(acc.alliance.rank or '-')}</span></div>
<div class="stat"><span>Members</span><span class="val">{acc.alliance.member_count}</span></div>
</div>
</div>
</section>

<section class="section" id="cities">
<h2>🏙️ Cities ({len(acc.cities)})</h2>
<table><thead><tr><th>Name</th><th>Coords</th><th>Level</th><th>Population</th><th>Troops</th><th>Heroes</th></tr></thead>
<tbody>{cities_html}</tbody></table>
</section>

<section class="section" id="troops">
<h2>⚔️ Troops by City</h2>
<div class="grid">{troops_html}</div>
</section>

<section class="section" id="heroes">
<h2>🦸 Heroes ({acc.total_heroes})</h2>
<table><thead><tr><th>Name</th><th>Level</th><th>ATK</th><th>DEF</th><th>POL</th><th>INT</th><th>City</th></tr></thead>
<tbody>{heroes_html}</tbody></table>
</section>

<section class="section" id="resources">
<h2>💰 Resources by City</h2>
<div class="grid">{resources_html}</div>
</section>

<section class="section" id="items">
<h2>📦 Items ({len(acc.items)})</h2>
<table><thead><tr><th>Name</th><th>Count</th><th>Category</th></tr></thead>
<tbody>{items_html}</tbody></table>
</section>
</div>
<footer>Generated by BORG TOOLKIT EPIC 2026 | {acc.extraction_time}</footer>
</body></html>'''
    
    def _write_txts(self, dir: Path, account: CompleteAccountData) -> Dict[str, Path]:
        paths = {}
        txt_dir = dir / "txt"
        txt_dir.mkdir(exist_ok=True)
        
        # Summary
        with open(txt_dir / "summary.txt", 'w', encoding='utf-8') as f:
            f.write(f"ACCOUNT SUMMARY\n{'='*60}\n")
            f.write(f"Player: {account.player.name}\nEmail: {account.login_email}\n")
            f.write(f"Server: {account.login_server}\nID: {account.player.id}\n")
            f.write(f"Prestige: {account.player.prestige:,}\nHonor: {account.player.honor:,}\n")
            f.write(f"Alliance: {account.alliance.name or 'None'}\n\nSTATISTICS\n{'-'*40}\n")
            f.write(f"Cities: {account.total_cities}\nTroops: {account.total_troops:,}\n")
            f.write(f"Heroes: {account.total_heroes}\nHistoric: {account.total_historic_heroes}\n")
        
        # Troops
        with open(txt_dir / "troops.txt", 'w', encoding='utf-8') as f:
            f.write(f"TROOPS BY CITY\n{'='*80}\n\n")
            for c in account.cities:
                t = c.troops
                f.write(f"{c.name} @ {c.coords}\n{'-'*40}\n")
                f.write(f"  Workers:      {t.workers:>12,}\n  Warriors:     {t.warriors:>12,}\n")
                f.write(f"  Scouts:       {t.scouts:>12,}\n  Pikemen:      {t.pikemen:>12,}\n")
                f.write(f"  Swordsmen:    {t.swordsmen:>12,}\n  Archers:      {t.archers:>12,}\n")
                f.write(f"  Cavalry:      {t.cavalry:>12,}\n  Cataphracts:  {t.cataphracts:>12,}\n")
                f.write(f"  Transporters: {t.transporters:>12,}\n  Ballistas:    {t.ballistas:>12,}\n")
                f.write(f"  Rams:         {t.rams:>12,}\n  Catapults:    {t.catapults:>12,}\n")
                f.write(f"  {'='*28}\n  TOTAL:        {t.total():>12,}\n\n")
        
        # Heroes
        with open(txt_dir / "heroes.txt", 'w', encoding='utf-8') as f:
            f.write(f"ALL HEROES\n{'='*80}\n\n")
            for c in account.cities:
                for h in c.heroes:
                    tags = ""
                    if h.is_historic: tags += " [HISTORIC]"
                    if h.is_mayor: tags += " [MAYOR]"
                    if h.is_marshal: tags += " [MARSHAL]"
                    f.write(f"{h.name}{tags}\n  Level: {h.level}  City: {c.name}\n")
                    f.write(f"  ATK:{h.attack} DEF:{h.defense} POL:{h.politics} INT:{h.intelligence}\n\n")
        
        # Resources
        with open(txt_dir / "resources.txt", 'w', encoding='utf-8') as f:
            f.write(f"RESOURCES BY CITY\n{'='*80}\n\n")
            for c in account.cities:
                r = c.resources
                f.write(f"{c.name} @ {c.coords}\n{'-'*40}\n")
                f.write(f"  Gold:  {r.gold:>15,}\n  Food:  {r.food:>15,}\n  Wood:  {r.wood:>15,}\n")
                f.write(f"  Stone: {r.stone:>15,}\n  Iron:  {r.iron:>15,}\n")
                f.write(f"  Pop:   {r.population:>15,} / {r.max_population:,}\n\n")
        
        # Items
        with open(txt_dir / "items.txt", 'w', encoding='utf-8') as f:
            f.write(f"INVENTORY\n{'='*80}\n\n")
            for item in account.items:
                f.write(f"{item.name}: {item.count:,} ({item.category})\n")
        
        return paths


class MasterFileGenerator:
    """Generate master files for all accounts combined"""
    
    def __init__(self, base_dir: Path):
        self.base_dir = base_dir
        self.base_dir.mkdir(parents=True, exist_ok=True)
    
    def generate(self, accounts: List[CompleteAccountData]) -> Dict[str, Path]:
        paths = {}
        ts = datetime.now().strftime('%Y%m%d_%H%M%S')
        
        # Master JSON
        json_file = self.base_dir / f"master_{ts}.json"
        data = [self._to_dict(acc) for acc in accounts]
        with open(json_file, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=2, default=str)
        paths['json'] = json_file
        
        # Master CSV - Overview
        csv_file = self.base_dir / f"master_overview_{ts}.csv"
        with open(csv_file, 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            writer.writerow(['Email', 'Password', 'Server', 'Player', 'ID', 'Prestige', 
                           'Alliance', 'Cities', 'Troops', 'Heroes', 'HH'])
            for acc in accounts:
                writer.writerow([acc.login_email, acc.login_password, acc.login_server,
                               acc.player.name, acc.player.id, acc.player.prestige,
                               acc.alliance.name, acc.total_cities, acc.total_troops,
                               acc.total_heroes, acc.total_historic_heroes])
        paths['csv'] = csv_file
        
        # Khan format
        khan_file = self.base_dir / f"khan_format_{ts}.csv"
        with open(khan_file, 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            for acc in accounts:
                for c in acc.cities:
                    writer.writerow([acc.login_email, f'"{c.coords}"', c.troops.to_string()])
        paths['khan'] = khan_file
        
        return paths
    
    def _to_dict(self, obj):
        if hasattr(obj, '__dataclass_fields__'):
            return {k: self._to_dict(v) for k, v in asdict(obj).items()}
        elif isinstance(obj, list):
            return [self._to_dict(i) for i in obj]
        elif isinstance(obj, dict):
            return {k: self._to_dict(v) for k, v in obj.items()}
        return obj
