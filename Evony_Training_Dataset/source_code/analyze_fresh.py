#!/usr/bin/env python3
"""Analyze fresh extraction data quality"""
import json
from pathlib import Path
from collections import Counter

FRESH_DIR = Path(r'D:\EvonyToolKit\scripts\khan_Accounts_556\accounts_fresh')

def analyze():
    files = list(FRESH_DIR.glob('*.json'))
    print(f"Fresh files: {len(files)}")
    
    accounts = []
    total_troops = 0
    total_banners = 0
    total_thunder = 0
    
    for f in files:
        try:
            data = json.load(open(f, encoding='utf-8'))
            player = data.get('player', {})
            cities = player.get('castles', [])
            name = player.get('playerInfo', {}).get('userName', f.stem)
            
            # Count troops from all cities
            troops = {}
            for city in cities:
                for k, v in city.get('troop', {}).items():
                    troops[k] = troops.get(k, 0) + v
            
            troop_total = sum(troops.values())
            
            # Count items
            items = {i.get('id'): i.get('count', 0) for i in player.get('items', []) if isinstance(i, dict)}
            banners = items.get('player.item.stygandrsbannerofthehorde', 0)
            thunder = items.get('player.trick.tblj', 0)
            recall = items.get('player.trick.qlbx', 0)
            
            accounts.append({
                'name': name,
                'email': f.stem,
                'cities': len(cities),
                'troops': troops,
                'troop_total': troop_total,
                'banners': banners,
                'thunder': thunder,
                'recall': recall,
                'items': items
            })
            
            total_troops += troop_total
            total_banners += banners
            total_thunder += thunder
            
        except Exception as e:
            print(f"Error {f.name}: {e}")
    
    # Sort by troops
    accounts.sort(key=lambda x: -x['troop_total'])
    
    print(f"\n=== TOP 10 BY TROOPS ===")
    for acc in accounts[:10]:
        print(f"  {acc['name']:20} {acc['cities']} cities  {acc['troop_total']/1e9:.1f}B troops  {acc['banners']} banners")
    
    print(f"\n=== TOTALS ===")
    print(f"  Accounts: {len(accounts)}")
    print(f"  Total Troops: {total_troops/1e9:.1f}B")
    print(f"  Total Banners: {total_banners:,}")
    print(f"  Total Thunder: {total_thunder:,}")
    
    return accounts

if __name__ == '__main__':
    analyze()
