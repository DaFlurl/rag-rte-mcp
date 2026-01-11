"""
ETK SOL Manager - Account Data Extractor
Extracts complete account data from SOL files and game API
"""

import os
import json
import time
from pathlib import Path
from typing import Dict, Any, List, Optional, Callable
from datetime import datetime
import csv

try:
    import pyamf.sol
    AMF_AVAILABLE = True
except ImportError:
    AMF_AVAILABLE = False

from .database import AccountDatabase


class AccountExtractor:
    """
    Extracts complete account data from multiple sources:
    - SOL files (config.sol, player.sol, castle.sol, etc.)
    - CSV account lists
    - JSON exports from RoboEvony
    
    Stores everything in SQLite database for analysis.
    """
    
    # SOL file paths
    SYSTEM_SOL_PATH = Path(os.environ.get('APPDATA', '')) / "Macromedia" / "Flash Player" / "#SharedObjects"
    PROJECT_SOL_PATH = Path(r"D:\EvonyToolKit\Macromedia\Flash Player\#SharedObjects")
    
    # Troop type mappings
    TROOP_TYPES = {
        'peasants': 'workers',
        'militia': 'warriors', 
        'scouter': 'scouts',
        'pikemen': 'pikemen',
        'swordsmen': 'swordsmen',
        'archer': 'archers',
        'lightCavalry': 'cavalry',
        'heavyCavalry': 'cataphracts',
        'carriage': 'transporters',
        'ballista': 'ballistas',
        'batteringRam': 'battering_rams',
        'catapult': 'catapults'
    }
    
    def __init__(self, db: AccountDatabase = None):
        self.db = db or AccountDatabase()
        self.progress_callback: Optional[Callable] = None
        self.errors: List[str] = []
    
    def extract_from_sol_file(self, sol_path: Path) -> Optional[Dict[str, Any]]:
        """Extract data from a SOL file"""
        if not AMF_AVAILABLE:
            return None
        
        try:
            with open(sol_path, 'rb') as f:
                result = pyamf.sol.decode(f)
            
            if isinstance(result, tuple) and len(result) >= 2:
                return result[1]
            return result
        except Exception as e:
            self.errors.append(f"Error reading {sol_path}: {e}")
            return None
    
    def extract_config_sol(self, sol_path: Path) -> Dict[str, Any]:
        """Extract credentials from config.sol"""
        data = self.extract_from_sol_file(sol_path)
        if not data or 'now' not in data:
            return {}
        
        now = data['now']
        return {
            'email': now.get('username', ''),
            'password': now.get('password', ''),
            'server': now.get('server', 'cc2'),
            'server_ip': now.get('serverIP', ''),
            'server_alias': now.get('strserverAlias', ''),
            'proxy_port': now.get('proxyPort', ''),
            'auto_login': now.get('autoLogin', False)
        }
    
    def extract_player_sol(self, sol_path: Path) -> Dict[str, Any]:
        """Extract player data from player.sol"""
        data = self.extract_from_sol_file(sol_path)
        if not data:
            return {}
        
        player = data.get('player', data)
        
        result = {
            'player_name': player.get('userName', ''),
            'player_id': player.get('id'),
            'prestige': player.get('prestige', 0),
            'honor': player.get('honor', 0),
            'title': player.get('title', ''),
            'level': player.get('level', 1),
            'alliance_id': player.get('allianceId'),
            'alliance_name': player.get('allianceName', ''),
            'cities': [],
            'raw_data': data
        }
        
        # Extract cities (castles)
        castles = player.get('castles', [])
        for castle in castles:
            city = self._extract_city_data(castle)
            result['cities'].append(city)
        
        return result
    
    def _extract_city_data(self, castle: Dict[str, Any]) -> Dict[str, Any]:
        """Extract city data from castle object"""
        field_id = castle.get('fieldId', 0)
        x = field_id % 800
        y = field_id // 800
        
        city = {
            'city_id': castle.get('id'),
            'name': castle.get('name', f'City_{field_id}'),
            'field_id': field_id,
            'x': x,
            'y': y,
            'state': castle.get('state', ''),
            'population': castle.get('population', 0),
            'loyalty': castle.get('loyalty', 100),
            'grievance': castle.get('grievance', 0),
            'tranquility': castle.get('tranquility', 100),
            'is_main_city': castle.get('isMainCity', False),
            'resources': {},
            'troops': {},
            'buildings': [],
            'heroes': []
        }
        
        # Extract resources
        resource = castle.get('resource', {})
        city['resources'] = {
            'gold': resource.get('gold', 0),
            'food': resource.get('food', 0),
            'lumber': resource.get('wood', 0),
            'stone': resource.get('stone', 0),
            'iron': resource.get('iron', 0),
            'gold_capacity': resource.get('goldCapacity', 0),
            'food_capacity': resource.get('foodCapacity', 0),
            'lumber_capacity': resource.get('woodCapacity', 0),
            'stone_capacity': resource.get('stoneCapacity', 0),
            'iron_capacity': resource.get('ironCapacity', 0)
        }
        
        # Extract troops
        troop = castle.get('troop', {})
        for game_name, db_name in self.TROOP_TYPES.items():
            city['troops'][db_name] = troop.get(game_name, 0)
        
        # Extract buildings
        buildings = castle.get('buildings', [])
        for b in buildings:
            city['buildings'].append({
                'type_id': b.get('typeId'),
                'level': b.get('level', 0),
                'position_id': b.get('positionId'),
                'status': b.get('status', '')
            })
        
        # Extract heroes in city
        heroes = castle.get('heroes', [])
        for h in heroes:
            city['heroes'].append(self._extract_hero_data(h))
        
        return city
    
    def _extract_hero_data(self, hero: Dict[str, Any]) -> Dict[str, Any]:
        """Extract hero data"""
        return {
            'hero_id': hero.get('id'),
            'name': hero.get('name', ''),
            'level': hero.get('level', 1),
            'experience': hero.get('experience', 0),
            'loyalty': hero.get('loyalty', 100),
            'politics': hero.get('power', 0),
            'attack': hero.get('stratagem', 0),
            'intelligence': hero.get('management', 0),
            'base_politics': hero.get('basePower', 0),
            'base_attack': hero.get('baseStratagem', 0),
            'base_intelligence': hero.get('baseManagement', 0),
            'status': hero.get('status', ''),
            'is_mayor': hero.get('isMayor', False),
            'is_marshal': hero.get('isMarshal', False),
            'hero_type': hero.get('heroType', ''),
            'grade': hero.get('grade', ''),
            'power': hero.get('fightingForce', 0)
        }
    
    def extract_items_sol(self, sol_path: Path) -> List[Dict[str, Any]]:
        """Extract items from items.sol"""
        data = self.extract_from_sol_file(sol_path)
        if not data:
            return []
        
        items = []
        item_list = data.get('items', data.get('itemList', []))
        
        for item in item_list:
            items.append({
                'item_id': item.get('id'),
                'name': item.get('name', ''),
                'count': item.get('count', 1),
                'category': item.get('category', ''),
                'description': item.get('description', '')
            })
        
        return items
    
    def load_from_csv(self, csv_path: Path) -> List[Dict[str, str]]:
        """Load accounts from CSV file"""
        accounts = []
        
        try:
            with open(csv_path, 'r', encoding='utf-8', errors='ignore') as f:
                reader = csv.reader(f)
                for row in reader:
                    if len(row) >= 2:
                        email = row[0].strip()
                        password = row[1].strip()
                        if '@' in email:
                            accounts.append({'email': email, 'password': password})
        except Exception as e:
            self.errors.append(f"Error reading CSV {csv_path}: {e}")
        
        return accounts
    
    def load_from_json(self, json_path: Path) -> Dict[str, Any]:
        """Load account data from JSON export"""
        try:
            with open(json_path, 'r', encoding='utf-8') as f:
                return json.load(f)
        except Exception as e:
            self.errors.append(f"Error reading JSON {json_path}: {e}")
            return {}
    
    def find_sol_files_for_account(self, email: str) -> Dict[str, Path]:
        """Find all SOL files for an account"""
        sol_files = {}
        
        # Search paths
        search_paths = [self.SYSTEM_SOL_PATH, self.PROJECT_SOL_PATH]
        
        for base_path in search_paths:
            if not base_path.exists():
                continue
            
            # Look for config.sol files
            for config_path in base_path.rglob("config.sol"):
                config_data = self.extract_config_sol(config_path)
                if config_data.get('email', '').lower() == email.lower():
                    sol_dir = config_path.parent
                    
                    sol_files['config'] = config_path
                    
                    # Look for other SOL files in same directory
                    for sol_type in ['player', 'castle', 'items', 'hero', 'quest']:
                        sol_path = sol_dir / f"{sol_type}.sol"
                        if sol_path.exists():
                            sol_files[sol_type] = sol_path
        
        return sol_files
    
    def extract_account(self, email: str, password: str = None) -> Dict[str, Any]:
        """Extract complete account data"""
        start_time = time.time()
        
        result = {
            'email': email,
            'password': password,
            'extracted': False,
            'error': None
        }
        
        # Find SOL files
        sol_files = self.find_sol_files_for_account(email)
        
        if not sol_files:
            result['error'] = "No SOL files found for account"
            return result
        
        # Extract config data
        if 'config' in sol_files:
            config_data = self.extract_config_sol(sol_files['config'])
            result.update(config_data)
            if not password:
                password = config_data.get('password', '')
                result['password'] = password
        
        # Extract player data
        if 'player' in sol_files:
            player_data = self.extract_player_sol(sol_files['player'])
            result.update(player_data)
        
        # Extract items
        if 'items' in sol_files:
            result['items'] = self.extract_items_sol(sol_files['items'])
        
        # Store in database
        try:
            account_id = self.db.upsert_account(email, result)
            
            # Store cities
            for city_data in result.get('cities', []):
                city_id = self.db.upsert_city(account_id, city_data)
                
                # Store resources
                if city_data.get('resources'):
                    self.db.upsert_resources(city_id, city_data['resources'])
                
                # Store troops
                if city_data.get('troops'):
                    self.db.upsert_troops(city_id, city_data['troops'])
                
                # Store heroes
                for hero in city_data.get('heroes', []):
                    self.db.upsert_hero(account_id, city_id, hero)
            
            # Store items
            for item in result.get('items', []):
                self.db.upsert_item(account_id, item)
            
            # Log extraction
            duration = time.time() - start_time
            self.db.log_extraction(account_id, 'full', 'success', 
                                  f"Extracted {len(result.get('cities', []))} cities", duration)
            
            result['extracted'] = True
            result['account_id'] = account_id
            
        except Exception as e:
            result['error'] = str(e)
            self.errors.append(f"Database error for {email}: {e}")
        
        return result
    
    def extract_all_accounts(self, progress_callback: Callable = None) -> Dict[str, Any]:
        """Extract data from all discovered accounts"""
        self.progress_callback = progress_callback
        
        # First, load all accounts from CSV
        csv_path = Path(r"D:\EvonyToolKit\scripts\khan_Accounts_556\khanaccounts.csv")
        csv_accounts = self.load_from_csv(csv_path) if csv_path.exists() else []
        
        # Build account list with passwords
        accounts = {}
        for acc in csv_accounts:
            email = acc['email'].lower()
            if email not in accounts or not accounts[email].get('password'):
                accounts[email] = acc
        
        # Also find accounts from SOL files
        for base_path in [self.SYSTEM_SOL_PATH, self.PROJECT_SOL_PATH]:
            if not base_path.exists():
                continue
            
            for config_path in base_path.rglob("config.sol"):
                config_data = self.extract_config_sol(config_path)
                email = config_data.get('email', '').lower()
                if email and '@' in email:
                    if email not in accounts:
                        accounts[email] = config_data
                    elif not accounts[email].get('password') and config_data.get('password'):
                        accounts[email]['password'] = config_data['password']
        
        # Extract each account
        results = {
            'total': len(accounts),
            'extracted': 0,
            'failed': 0,
            'accounts': []
        }
        
        for i, (email, data) in enumerate(accounts.items()):
            if self.progress_callback:
                self.progress_callback(i + 1, len(accounts), email)
            
            result = self.extract_account(email, data.get('password', ''))
            results['accounts'].append(result)
            
            if result.get('extracted'):
                results['extracted'] += 1
            else:
                results['failed'] += 1
        
        return results
    
    def get_account_report(self, email: str) -> str:
        """Generate a detailed text report for an account"""
        summary = self.db.get_account_summary(email)
        if not summary:
            return f"No data found for {email}"
        
        account = summary['account']
        cities = summary['cities']
        heroes = summary['heroes']
        items = summary['items']
        totals = summary['summary']
        
        lines = []
        lines.append("=" * 70)
        lines.append(f"ACCOUNT REPORT: {account.get('player_name', email)}")
        lines.append("=" * 70)
        lines.append(f"Email: {email}")
        lines.append(f"Server: {account.get('server', 'cc2')} ({account.get('server_alias', 'Unknown')})")
        lines.append(f"Prestige: {account.get('prestige', 0):,}")
        lines.append(f"Honor: {account.get('honor', 0):,}")
        lines.append(f"Alliance: {account.get('alliance_name', 'None')}")
        lines.append(f"Last Extraction: {account.get('last_extraction', 'Never')}")
        lines.append("")
        
        lines.append("-" * 70)
        lines.append("SUMMARY")
        lines.append("-" * 70)
        lines.append(f"Cities: {totals['total_cities']}")
        lines.append(f"Heroes: {totals['total_heroes']}")
        lines.append(f"Items: {totals['total_items']}")
        lines.append(f"Total Troops: {totals['total_troops']:,}")
        lines.append(f"Total Gold: {totals['total_gold']:,}")
        lines.append(f"Total Food: {totals['total_food']:,}")
        lines.append(f"Total Lumber: {totals['total_lumber']:,}")
        lines.append(f"Total Stone: {totals['total_stone']:,}")
        lines.append(f"Total Iron: {totals['total_iron']:,}")
        lines.append("")
        
        lines.append("-" * 70)
        lines.append("CITIES")
        lines.append("-" * 70)
        for city in cities:
            lines.append(f"\n  {city.get('name', 'Unknown')} ({city.get('x', 0)},{city.get('y', 0)})")
            lines.append(f"    Gold: {city.get('gold', 0):,}  Food: {city.get('food', 0):,}")
            lines.append(f"    Lumber: {city.get('lumber', 0):,}  Stone: {city.get('stone', 0):,}  Iron: {city.get('iron', 0):,}")
            lines.append(f"    Troops: {city.get('total_troops', 0):,}")
        
        lines.append("")
        lines.append("-" * 70)
        lines.append("HEROES")
        lines.append("-" * 70)
        for hero in heroes:
            lines.append(f"  {hero.get('name', 'Unknown')} - Lv.{hero.get('level', 1)}")
            lines.append(f"    ATK: {hero.get('attack', 0)}  POL: {hero.get('politics', 0)}  INT: {hero.get('intelligence', 0)}")
        
        if items:
            lines.append("")
            lines.append("-" * 70)
            lines.append("ITEMS")
            lines.append("-" * 70)
            for item in items[:20]:  # First 20 items
                lines.append(f"  {item.get('name', 'Unknown')}: {item.get('count', 0)}")
            if len(items) > 20:
                lines.append(f"  ... and {len(items) - 20} more items")
        
        return "\n".join(lines)
