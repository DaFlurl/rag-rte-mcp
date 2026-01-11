"""
ETK SOL Manager - JSON Importer
Imports JSON exports from RoboEvony into SQLite database
"""

import json
import os
from pathlib import Path
from datetime import datetime
from typing import Dict, Any, List, Optional

from .database import AccountDatabase


class JSONImporter:
    """
    Imports account data from RoboEvony JSON exports.
    
    RoboEvony exports go to: D:\\EvonyToolKit\\data\\exports\\
    This importer reads those files and stores in SQLite.
    """
    
    EXPORTS_PATH = Path(r"D:\EvonyToolKit\data\exports")
    
    def __init__(self, db: AccountDatabase = None):
        self.db = db or AccountDatabase()
        self.errors: List[str] = []
        
        # Ensure exports directory exists
        self.EXPORTS_PATH.mkdir(parents=True, exist_ok=True)
    
    def import_json_file(self, json_path: Path) -> Dict[str, Any]:
        """Import a single JSON export file"""
        try:
            with open(json_path, 'r', encoding='utf-8') as f:
                data = json.load(f)
            
            email = data.get('email', '')
            if not email:
                return {'success': False, 'error': 'No email in JSON'}
            
            # Prepare account data
            account_data = {
                'email': email,
                'player_name': data.get('player_name', ''),
                'server': data.get('server', 'cc2'),
                'prestige': data.get('prestige', 0),
                'honor': data.get('honor', 0),
                'alliance_name': data.get('alliance', ''),
                'is_valid': True,
                'raw_data': data
            }
            
            # Insert account
            account_id = self.db.upsert_account(email, account_data)
            
            # Import cities
            cities_imported = 0
            for city_data in data.get('cities', []):
                city_id = self._import_city(account_id, city_data)
                if city_id:
                    cities_imported += 1
            
            # Import heroes
            heroes_imported = 0
            for hero_data in data.get('heroes', []):
                self._import_hero(account_id, hero_data)
                heroes_imported += 1
            
            # Import items
            items_imported = 0
            for item_data in data.get('items', []):
                self._import_item(account_id, item_data)
                items_imported += 1
            
            return {
                'success': True,
                'email': email,
                'player_name': data.get('player_name', ''),
                'cities': cities_imported,
                'heroes': heroes_imported,
                'items': items_imported
            }
            
        except json.JSONDecodeError as e:
            self.errors.append(f"Invalid JSON in {json_path}: {e}")
            return {'success': False, 'error': f'Invalid JSON: {e}'}
        except Exception as e:
            self.errors.append(f"Error importing {json_path}: {e}")
            return {'success': False, 'error': str(e)}
    
    def _import_city(self, account_id: int, city_data: Dict) -> Optional[int]:
        """Import a city"""
        try:
            x = city_data.get('x', 0)
            y = city_data.get('y', 0)
            field_id = y * 800 + x
            
            city = {
                'name': city_data.get('name', f'City_{field_id}'),
                'field_id': field_id,
                'x': x,
                'y': y,
                'state': city_data.get('state', ''),
                'population': city_data.get('population', 0)
            }
            
            city_id = self.db.upsert_city(account_id, city)
            
            # Resources
            resources = {
                'gold': city_data.get('gold', 0),
                'food': city_data.get('food', 0),
                'lumber': city_data.get('lumber', 0),
                'stone': city_data.get('stone', 0),
                'iron': city_data.get('iron', 0)
            }
            self.db.upsert_resources(city_id, resources)
            
            # Troops
            troops = {
                'workers': city_data.get('workers', 0),
                'warriors': city_data.get('warriors', 0),
                'scouts': city_data.get('scouts', 0),
                'pikemen': city_data.get('pikemen', 0),
                'swordsmen': city_data.get('swordsmen', 0),
                'archers': city_data.get('archers', 0),
                'cavalry': city_data.get('cavalry', 0),
                'cataphracts': city_data.get('cataphracts', 0),
                'transporters': city_data.get('transporters', 0),
                'ballistas': city_data.get('ballistas', 0),
                'battering_rams': city_data.get('rams', 0),
                'catapults': city_data.get('catapults', 0)
            }
            self.db.upsert_troops(city_id, troops)
            
            return city_id
        except Exception as e:
            self.errors.append(f"Error importing city: {e}")
            return None
    
    def _import_hero(self, account_id: int, hero_data: Dict):
        """Import a hero"""
        try:
            hero = {
                'hero_id': hash(hero_data.get('name', '')),  # Generate ID from name
                'name': hero_data.get('name', ''),
                'level': hero_data.get('level', 1),
                'attack': hero_data.get('attack', 0),
                'politics': hero_data.get('politics', 0),
                'intelligence': hero_data.get('intelligence', 0)
            }
            self.db.upsert_hero(account_id, None, hero)
        except Exception as e:
            self.errors.append(f"Error importing hero: {e}")
    
    def _import_item(self, account_id: int, item_data: Dict):
        """Import an item"""
        try:
            item = {
                'item_id': hash(item_data.get('name', '')),
                'name': item_data.get('name', ''),
                'count': item_data.get('count', 0)
            }
            self.db.upsert_item(account_id, item)
        except Exception as e:
            self.errors.append(f"Error importing item: {e}")
    
    def import_all_exports(self, progress_callback=None) -> Dict[str, Any]:
        """Import all JSON files from exports directory"""
        json_files = list(self.EXPORTS_PATH.glob("*.json"))
        
        results = {
            'total': len(json_files),
            'imported': 0,
            'failed': 0,
            'accounts': []
        }
        
        for i, json_path in enumerate(json_files):
            if progress_callback:
                progress_callback(i + 1, len(json_files), json_path.name)
            
            result = self.import_json_file(json_path)
            results['accounts'].append(result)
            
            if result.get('success'):
                results['imported'] += 1
            else:
                results['failed'] += 1
        
        return results
    
    def list_exports(self) -> List[Dict[str, Any]]:
        """List all available JSON exports"""
        exports = []
        
        for json_path in self.EXPORTS_PATH.glob("*.json"):
            try:
                stat = json_path.stat()
                exports.append({
                    'filename': json_path.name,
                    'path': str(json_path),
                    'size': stat.st_size,
                    'modified': datetime.fromtimestamp(stat.st_mtime).isoformat()
                })
            except Exception:
                pass
        
        return exports


def import_roboevony_exports():
    """CLI function to import all RoboEvony exports"""
    print("=" * 60)
    print("RoboEvony JSON Importer")
    print("=" * 60)
    
    importer = JSONImporter()
    
    # List available exports
    exports = importer.list_exports()
    print(f"\nFound {len(exports)} JSON export files")
    
    if not exports:
        print("\nNo exports found in D:\\EvonyToolKit\\data\\exports\\")
        print("\nTo export data from RoboEvony:")
        print("1. Login to an account in RoboEvony")
        print("2. Load script: scripts/extraction/export_to_json.txt")
        print("3. Run the script")
        print("4. JSON file will be saved to data/exports/")
        return
    
    # Import all
    print("\nImporting...")
    
    def progress(current, total, name):
        print(f"  [{current}/{total}] {name}")
    
    results = importer.import_all_exports(progress)
    
    print(f"\nImport complete:")
    print(f"  Total files: {results['total']}")
    print(f"  Imported: {results['imported']}")
    print(f"  Failed: {results['failed']}")
    
    if importer.errors:
        print(f"\nErrors ({len(importer.errors)}):")
        for err in importer.errors[:5]:
            print(f"  - {err}")


if __name__ == '__main__':
    import_roboevony_exports()
