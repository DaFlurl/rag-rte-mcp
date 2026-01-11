"""
ETK Batch Account Extractor
Extracts data from all accounts using direct Evony login
"""

import json
import time
import sys
from pathlib import Path
from datetime import datetime
from typing import List, Dict

sys.path.insert(0, str(Path(__file__).parent.parent.parent))

from sol_manager.extractor.evony_client import EvonyClient, save_account_json
from sol_manager.extractor.database import AccountDatabase


def load_accounts() -> List[Dict]:
    """Load accounts from the latest parsed JSON"""
    data_dir = Path(r"D:\EvonyToolKit\data")
    json_files = list(data_dir.glob("accounts_with_seccode_*.json"))
    
    if not json_files:
        print("No account files found!")
        return []
    
    latest = max(json_files, key=lambda f: f.stat().st_mtime)
    
    with open(latest, 'r') as f:
        data = json.load(f)
    
    return data.get('accounts', [])


def extract_all_accounts(accounts: List[Dict], delay: float = 2.0, 
                         max_accounts: int = None) -> Dict:
    """
    Extract data from all accounts.
    
    Args:
        accounts: List of account dicts with email/password
        delay: Seconds between extractions
        max_accounts: Limit number of accounts (None = all)
        
    Returns:
        Results summary
    """
    output_dir = Path(r"D:\EvonyToolKit\data\fresh_exports")
    output_dir.mkdir(parents=True, exist_ok=True)
    
    results = {
        'total': 0,
        'success': 0,
        'failed': 0,
        'accounts': []
    }
    
    if max_accounts:
        accounts = accounts[:max_accounts]
    
    results['total'] = len(accounts)
    
    print(f"\nExtracting {len(accounts)} accounts...")
    print(f"Output: {output_dir}")
    print("=" * 60)
    
    for i, acc in enumerate(accounts):
        email = acc['email']
        password = acc['password']
        
        print(f"\n[{i+1}/{len(accounts)}] {email}")
        
        try:
            client = EvonyClient('cc2', callback=lambda m: None)  # Quiet mode
            
            if client.login(email, password):
                data = client.extract_account()
                client.close()
                
                # Save JSON
                filepath = save_account_json(data, str(output_dir))
                
                cities = len(data.get('cities', []))
                items = len(data.get('items', []))
                
                print(f"  ✓ Success - {cities} cities, {items} items")
                
                results['success'] += 1
                results['accounts'].append({
                    'email': email,
                    'success': True,
                    'cities': cities,
                    'items': items,
                    'file': filepath
                })
            else:
                client.close()
                print(f"  ✗ Login failed")
                results['failed'] += 1
                results['accounts'].append({
                    'email': email,
                    'success': False,
                    'error': 'Login failed'
                })
                
        except Exception as e:
            print(f"  ✗ Error: {e}")
            results['failed'] += 1
            results['accounts'].append({
                'email': email,
                'success': False,
                'error': str(e)
            })
        
        # Delay between accounts
        if i < len(accounts) - 1:
            time.sleep(delay)
    
    return results


def import_to_database(results: Dict):
    """Import successful extractions to database"""
    db = AccountDatabase()
    
    output_dir = Path(r"D:\EvonyToolKit\data\fresh_exports")
    imported = 0
    
    for acc in results['accounts']:
        if not acc.get('success'):
            continue
        
        filepath = acc.get('file')
        if not filepath or not Path(filepath).exists():
            continue
        
        try:
            with open(filepath, 'r') as f:
                data = json.load(f)
            
            # Import account
            email = data.get('email', '')
            player = data.get('raw_player', {})
            
            account_data = {
                'email': email,
                'player_name': player.get('userName', ''),
                'server': 'cc2',
                'prestige': player.get('prestige', 0),
                'honor': player.get('honor', 0),
                'alliance_name': player.get('allianceName', ''),
                'is_valid': True
            }
            
            account_id = db.upsert_account(email, account_data)
            
            # Import cities
            for city in data.get('cities', []):
                fid = city.get('fieldId', 0)
                city_data = {
                    'name': city.get('name', ''),
                    'field_id': fid,
                    'x': fid % 800,
                    'y': fid // 800
                }
                city_id = db.upsert_city(account_id, city_data)
                
                # Troops
                troop = city.get('troop', {})
                if troop:
                    troops = {
                        'workers': int(troop.get('peasants', 0) or 0),
                        'warriors': int(troop.get('militia', 0) or 0),
                        'scouts': int(troop.get('scouter', 0) or 0),
                        'pikemen': int(troop.get('pikemen', 0) or 0),
                        'swordsmen': int(troop.get('swordsmen', 0) or 0),
                        'archers': int(troop.get('archer', 0) or 0),
                        'cavalry': int(troop.get('lightCavalry', 0) or 0),
                        'cataphracts': int(troop.get('heavyCavalry', 0) or 0),
                        'transporters': int(troop.get('carriage', 0) or 0),
                        'ballistas': int(troop.get('ballista', 0) or 0),
                        'battering_rams': int(troop.get('batteringRam', 0) or 0),
                        'catapults': int(troop.get('catapult', 0) or 0)
                    }
                    db.upsert_troops(city_id, troops)
            
            # Import items
            for item in data.get('items', []):
                item_data = {
                    'item_id': str(item.get('id', '')),
                    'name': item.get('name', str(item.get('id', ''))),
                    'count': int(item.get('count', 0) or 0)
                }
                db.upsert_item(account_id, item_data)
            
            imported += 1
            
        except Exception as e:
            print(f"Failed to import {filepath}: {e}")
    
    return imported


def main():
    print("=" * 60)
    print("ETK Batch Account Extractor")
    print("=" * 60)
    
    accounts = load_accounts()
    print(f"\nLoaded {len(accounts)} accounts")
    
    # For testing, start with just a few
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('-n', '--num', type=int, default=5, help='Number of accounts to extract')
    parser.add_argument('-d', '--delay', type=float, default=2.0, help='Delay between accounts')
    parser.add_argument('--all', action='store_true', help='Extract all accounts')
    args = parser.parse_args()
    
    max_accounts = None if args.all else args.num
    
    # Extract
    results = extract_all_accounts(accounts, delay=args.delay, max_accounts=max_accounts)
    
    # Summary
    print("\n" + "=" * 60)
    print("EXTRACTION COMPLETE")
    print("=" * 60)
    print(f"Total: {results['total']}")
    print(f"Success: {results['success']}")
    print(f"Failed: {results['failed']}")
    
    # Import to database
    if results['success'] > 0:
        print("\nImporting to database...")
        imported = import_to_database(results)
        print(f"Imported: {imported} accounts")
    
    # Save results
    results_path = Path(r"D:\EvonyToolKit\data\extraction_results.json")
    with open(results_path, 'w') as f:
        json.dump(results, f, indent=2)
    print(f"\nResults saved to: {results_path}")


if __name__ == '__main__':
    main()
