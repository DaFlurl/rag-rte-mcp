#!/usr/bin/env python3
"""
Quick Account Export Script
Exports all imported accounts to multiple formats without login validation
"""

import json
import csv
from pathlib import Path
from datetime import datetime

def main():
    print("=" * 60)
    print("  BORG TOOLKIT - Account Exporter")
    print("=" * 60)
    
    master_file = Path('data/accounts/master_accounts.json')
    
    if not master_file.exists():
        print("[!] No accounts found. Run import first.")
        return
    
    # Load accounts
    data = json.loads(master_file.read_text(encoding='utf-8'))
    print(f"\nLoaded {len(data)} accounts")
    
    # Reset all to pending (clear failed login attempts)
    for acc in data:
        acc['status'] = 'pending'
        acc['login_attempts'] = 0
        acc['fail_reason'] = None
    
    # Save updated master
    master_file.write_text(json.dumps(data, indent=2), encoding='utf-8')
    print("Reset all accounts to pending status")
    
    # Create exports directory
    exports = Path('data/exports')
    exports.mkdir(parents=True, exist_ok=True)
    
    ts = datetime.now().strftime('%Y%m%d_%H%M%S')
    
    # Export 1: Master CSV
    csv_file = exports / f'all_accounts_{ts}.csv'
    with open(csv_file, 'w', newline='', encoding='utf-8') as f:
        w = csv.writer(f)
        w.writerow(['email', 'password', 'server', 'source_file'])
        for acc in data:
            w.writerow([acc['email'], acc['password'], acc['server'], acc.get('source_file', '')])
    print(f"Created: {csv_file}")
    
    # Export 2: Simple user:pass format
    txt_file = exports / f'accounts_userpass_{ts}.txt'
    with open(txt_file, 'w', encoding='utf-8') as f:
        for acc in data:
            f.write(f"{acc['email']}:{acc['password']}\n")
    print(f"Created: {txt_file}")
    
    # Export 3: JSON
    json_file = exports / f'accounts_{ts}.json'
    with open(json_file, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2)
    print(f"Created: {json_file}")
    
    # Export 4: By source file
    by_source = {}
    for acc in data:
        src = acc.get('source_file', 'unknown')
        if src not in by_source:
            by_source[src] = []
        by_source[src].append(acc)
    
    sources_dir = exports / 'by_source'
    sources_dir.mkdir(exist_ok=True)
    for src, accs in by_source.items():
        safe_name = src.replace('.', '_').replace(' ', '_')[:50]
        src_file = sources_dir / f'{safe_name}.txt'
        with open(src_file, 'w', encoding='utf-8') as f:
            for acc in accs:
                f.write(f"{acc['email']}:{acc['password']}\n")
    print(f"Created {len(by_source)} source files in {sources_dir}")
    
    print(f"\n{'=' * 60}")
    print(f"Total accounts exported: {len(data)}")
    print(f"Exports saved to: {exports.absolute()}")
    print("=" * 60)

if __name__ == '__main__':
    main()
