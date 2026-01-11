#!/usr/bin/env python3
"""Analyze JSON dump structure"""
import json

with open('data/dumps/Tarasdbe_at_yahoo_com_20260104_031808.json') as f:
    d = json.load(f)

p = d['login_data']['player']

print("=== ACTUAL CASTLES (Your Cities) ===")
for i, c in enumerate(p['castles']):
    print(f"  {i}: {c.get('name')} | id={c.get('id')} | fieldId={c.get('fieldId')}")

print(f"\nTotal castles: {len(p['castles'])}")

print("\n=== CASTLE SIGN BEANS (Map markers - includes colonies) ===")
for i, s in enumerate(p['castleSignBean']):
    name = s.get('name', 'NO NAME')
    print(f"  {i}: {name:15} | id={s.get('id')} | ({s.get('x')},{s.get('y')})")

print(f"\nTotal signs: {len(p['castleSignBean'])}")

# Check if castle IDs match any signs
print("\n=== MATCHING CASTLE IDs TO SIGNS ===")
castle_ids = {c.get('id'): c.get('name') for c in p['castles']}
sign_ids = {s.get('id'): s.get('name', 'NO NAME') for s in p['castleSignBean']}

for cid, cname in castle_ids.items():
    if cid in sign_ids:
        print(f"  MATCH: Castle '{cname}' id={cid} -> Sign '{sign_ids[cid]}'")
    else:
        print(f"  NO MATCH: Castle '{cname}' id={cid}")

# Check items structure
print("\n=== ITEMS SAMPLE ===")
items = p.get('items', [])
print(f"Total items: {len(items)}")
for item in items[:5]:
    print(f"  {item}")

# Check heroes structure in first castle
print("\n=== HEROES IN FIRST CASTLE ===")
heroes = p['castles'][0].get('heros', [])
print(f"Total heroes in castle 0: {len(heroes)}")
for h in heroes[:3]:
    print(f"  {h.get('name')} - level {h.get('level')}")
