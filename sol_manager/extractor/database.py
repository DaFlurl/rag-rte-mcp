"""
ETK SOL Manager - SQLite Database for Account Data
Complete schema for storing all Evony account data
"""

import sqlite3
import json
from pathlib import Path
from datetime import datetime
from typing import Dict, Any, List, Optional
from contextlib import contextmanager


class AccountDatabase:
    """
    SQLite database for storing complete Evony account data.
    
    Tables:
    - accounts: Main account info (email, password, server, player_name)
    - cities: All cities for each account
    - troops: Troop counts per city
    - heroes: All heroes with stats
    - items: Item inventory
    - resources: Resource amounts per city
    - buildings: Building levels per city
    - research: Technology levels
    - quests: Quest progress
    - alliance: Alliance membership info
    - extraction_log: Track when data was extracted
    """
    
    DEFAULT_PATH = Path(r"D:\EvonyToolKit\data\accounts.db")
    
    def __init__(self, db_path: Path = None):
        self.db_path = db_path or self.DEFAULT_PATH
        self.db_path.parent.mkdir(parents=True, exist_ok=True)
        self._init_database()
    
    @contextmanager
    def get_connection(self):
        """Context manager for database connections"""
        conn = sqlite3.connect(self.db_path)
        conn.row_factory = sqlite3.Row
        try:
            yield conn
            conn.commit()
        except Exception:
            conn.rollback()
            raise
        finally:
            conn.close()
    
    def _init_database(self):
        """Initialize database schema"""
        with self.get_connection() as conn:
            cursor = conn.cursor()
            
            # Accounts table
            cursor.execute('''
                CREATE TABLE IF NOT EXISTS accounts (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    email TEXT UNIQUE NOT NULL,
                    password TEXT,
                    server TEXT DEFAULT 'cc2',
                    server_ip TEXT,
                    server_alias TEXT,
                    player_name TEXT,
                    player_id INTEGER,
                    prestige INTEGER DEFAULT 0,
                    honor INTEGER DEFAULT 0,
                    title TEXT,
                    level INTEGER DEFAULT 1,
                    alliance_id INTEGER,
                    alliance_name TEXT,
                    alliance_rank TEXT,
                    last_login TIMESTAMP,
                    last_extraction TIMESTAMP,
                    is_active BOOLEAN DEFAULT 1,
                    is_valid BOOLEAN DEFAULT 1,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    raw_data TEXT
                )
            ''')
            
            # Cities table
            cursor.execute('''
                CREATE TABLE IF NOT EXISTS cities (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    account_id INTEGER NOT NULL,
                    city_id INTEGER,
                    name TEXT,
                    x INTEGER,
                    y INTEGER,
                    field_id INTEGER,
                    state TEXT,
                    population INTEGER DEFAULT 0,
                    loyalty INTEGER DEFAULT 100,
                    grievance INTEGER DEFAULT 0,
                    tranquility INTEGER DEFAULT 100,
                    mayor_id INTEGER,
                    mayor_name TEXT,
                    is_main_city BOOLEAN DEFAULT 0,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (account_id) REFERENCES accounts(id)
                )
            ''')
            
            # Resources table (per city)
            cursor.execute('''
                CREATE TABLE IF NOT EXISTS resources (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    city_id INTEGER NOT NULL,
                    gold INTEGER DEFAULT 0,
                    food INTEGER DEFAULT 0,
                    lumber INTEGER DEFAULT 0,
                    stone INTEGER DEFAULT 0,
                    iron INTEGER DEFAULT 0,
                    gold_capacity INTEGER DEFAULT 0,
                    food_capacity INTEGER DEFAULT 0,
                    lumber_capacity INTEGER DEFAULT 0,
                    stone_capacity INTEGER DEFAULT 0,
                    iron_capacity INTEGER DEFAULT 0,
                    gold_production INTEGER DEFAULT 0,
                    food_production INTEGER DEFAULT 0,
                    lumber_production INTEGER DEFAULT 0,
                    stone_production INTEGER DEFAULT 0,
                    iron_production INTEGER DEFAULT 0,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (city_id) REFERENCES cities(id)
                )
            ''')
            
            # Troops table (per city)
            cursor.execute('''
                CREATE TABLE IF NOT EXISTS troops (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    city_id INTEGER NOT NULL,
                    workers INTEGER DEFAULT 0,
                    warriors INTEGER DEFAULT 0,
                    scouts INTEGER DEFAULT 0,
                    pikemen INTEGER DEFAULT 0,
                    swordsmen INTEGER DEFAULT 0,
                    archers INTEGER DEFAULT 0,
                    cavalry INTEGER DEFAULT 0,
                    cataphracts INTEGER DEFAULT 0,
                    transporters INTEGER DEFAULT 0,
                    ballistas INTEGER DEFAULT 0,
                    battering_rams INTEGER DEFAULT 0,
                    catapults INTEGER DEFAULT 0,
                    total_troops INTEGER DEFAULT 0,
                    food_consumption INTEGER DEFAULT 0,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (city_id) REFERENCES cities(id)
                )
            ''')
            
            # Heroes table
            cursor.execute('''
                CREATE TABLE IF NOT EXISTS heroes (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    account_id INTEGER NOT NULL,
                    city_id INTEGER,
                    hero_id INTEGER,
                    name TEXT,
                    level INTEGER DEFAULT 1,
                    experience INTEGER DEFAULT 0,
                    loyalty INTEGER DEFAULT 100,
                    politics INTEGER DEFAULT 0,
                    attack INTEGER DEFAULT 0,
                    intelligence INTEGER DEFAULT 0,
                    base_politics INTEGER DEFAULT 0,
                    base_attack INTEGER DEFAULT 0,
                    base_intelligence INTEGER DEFAULT 0,
                    status TEXT,
                    is_mayor BOOLEAN DEFAULT 0,
                    is_marshal BOOLEAN DEFAULT 0,
                    hero_type TEXT,
                    grade TEXT,
                    power INTEGER DEFAULT 0,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (account_id) REFERENCES accounts(id),
                    FOREIGN KEY (city_id) REFERENCES cities(id)
                )
            ''')
            
            # Items table
            cursor.execute('''
                CREATE TABLE IF NOT EXISTS items (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    account_id INTEGER NOT NULL,
                    item_id INTEGER,
                    name TEXT,
                    count INTEGER DEFAULT 0,
                    category TEXT,
                    description TEXT,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (account_id) REFERENCES accounts(id)
                )
            ''')
            
            # Buildings table (per city)
            cursor.execute('''
                CREATE TABLE IF NOT EXISTS buildings (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    city_id INTEGER NOT NULL,
                    building_id INTEGER,
                    type_id INTEGER,
                    name TEXT,
                    level INTEGER DEFAULT 0,
                    position_id INTEGER,
                    status TEXT,
                    end_time INTEGER,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (city_id) REFERENCES cities(id)
                )
            ''')
            
            # Research/Technology table
            cursor.execute('''
                CREATE TABLE IF NOT EXISTS research (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    account_id INTEGER NOT NULL,
                    tech_id INTEGER,
                    name TEXT,
                    level INTEGER DEFAULT 0,
                    category TEXT,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (account_id) REFERENCES accounts(id)
                )
            ''')
            
            # Valleys/Colonies table
            cursor.execute('''
                CREATE TABLE IF NOT EXISTS valleys (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    account_id INTEGER NOT NULL,
                    city_id INTEGER,
                    valley_id INTEGER,
                    x INTEGER,
                    y INTEGER,
                    type TEXT,
                    level INTEGER DEFAULT 0,
                    colonized_by TEXT,
                    is_enemy BOOLEAN DEFAULT 0,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (account_id) REFERENCES accounts(id),
                    FOREIGN KEY (city_id) REFERENCES cities(id)
                )
            ''')
            
            # Quests table
            cursor.execute('''
                CREATE TABLE IF NOT EXISTS quests (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    account_id INTEGER NOT NULL,
                    quest_id INTEGER,
                    name TEXT,
                    description TEXT,
                    status TEXT,
                    progress INTEGER DEFAULT 0,
                    target INTEGER DEFAULT 0,
                    reward TEXT,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (account_id) REFERENCES accounts(id)
                )
            ''')
            
            # Extraction log
            cursor.execute('''
                CREATE TABLE IF NOT EXISTS extraction_log (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    account_id INTEGER NOT NULL,
                    extraction_type TEXT,
                    status TEXT,
                    message TEXT,
                    duration_seconds REAL,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (account_id) REFERENCES accounts(id)
                )
            ''')
            
            # Create indexes
            cursor.execute('CREATE INDEX IF NOT EXISTS idx_accounts_email ON accounts(email)')
            cursor.execute('CREATE INDEX IF NOT EXISTS idx_cities_account ON cities(account_id)')
            cursor.execute('CREATE INDEX IF NOT EXISTS idx_troops_city ON troops(city_id)')
            cursor.execute('CREATE INDEX IF NOT EXISTS idx_heroes_account ON heroes(account_id)')
            cursor.execute('CREATE INDEX IF NOT EXISTS idx_items_account ON items(account_id)')
    
    def upsert_account(self, email: str, data: Dict[str, Any]) -> int:
        """Insert or update account data"""
        with self.get_connection() as conn:
            cursor = conn.cursor()
            
            cursor.execute('SELECT id FROM accounts WHERE email = ?', (email,))
            row = cursor.fetchone()
            
            if row:
                account_id = row['id']
                cursor.execute('''
                    UPDATE accounts SET
                        password = COALESCE(?, password),
                        server = COALESCE(?, server),
                        server_ip = COALESCE(?, server_ip),
                        server_alias = COALESCE(?, server_alias),
                        player_name = COALESCE(?, player_name),
                        player_id = COALESCE(?, player_id),
                        prestige = COALESCE(?, prestige),
                        honor = COALESCE(?, honor),
                        title = COALESCE(?, title),
                        level = COALESCE(?, level),
                        alliance_id = COALESCE(?, alliance_id),
                        alliance_name = COALESCE(?, alliance_name),
                        alliance_rank = COALESCE(?, alliance_rank),
                        is_active = COALESCE(?, is_active),
                        is_valid = COALESCE(?, is_valid),
                        last_extraction = CURRENT_TIMESTAMP,
                        updated_at = CURRENT_TIMESTAMP,
                        raw_data = ?
                    WHERE id = ?
                ''', (
                    data.get('password'),
                    data.get('server'),
                    data.get('server_ip'),
                    data.get('server_alias'),
                    data.get('player_name'),
                    data.get('player_id'),
                    data.get('prestige'),
                    data.get('honor'),
                    data.get('title'),
                    data.get('level'),
                    data.get('alliance_id'),
                    data.get('alliance_name'),
                    data.get('alliance_rank'),
                    data.get('is_active'),
                    data.get('is_valid'),
                    json.dumps(data.get('raw_data', {})),
                    account_id
                ))
            else:
                cursor.execute('''
                    INSERT INTO accounts (
                        email, password, server, server_ip, server_alias,
                        player_name, player_id, prestige, honor, title, level,
                        alliance_id, alliance_name, alliance_rank,
                        is_active, is_valid, last_extraction, raw_data
                    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, ?)
                ''', (
                    email,
                    data.get('password'),
                    data.get('server', 'cc2'),
                    data.get('server_ip'),
                    data.get('server_alias'),
                    data.get('player_name'),
                    data.get('player_id'),
                    data.get('prestige', 0),
                    data.get('honor', 0),
                    data.get('title'),
                    data.get('level', 1),
                    data.get('alliance_id'),
                    data.get('alliance_name'),
                    data.get('alliance_rank'),
                    data.get('is_active', True),
                    data.get('is_valid', True),
                    json.dumps(data.get('raw_data', {}))
                ))
                account_id = cursor.lastrowid
            
            return account_id
    
    def upsert_city(self, account_id: int, city_data: Dict[str, Any]) -> int:
        """Insert or update city data"""
        with self.get_connection() as conn:
            cursor = conn.cursor()
            
            field_id = city_data.get('field_id')
            cursor.execute(
                'SELECT id FROM cities WHERE account_id = ? AND field_id = ?',
                (account_id, field_id)
            )
            row = cursor.fetchone()
            
            if row:
                city_id = row['id']
                cursor.execute('''
                    UPDATE cities SET
                        name = ?, x = ?, y = ?, state = ?,
                        population = ?, loyalty = ?, grievance = ?, tranquility = ?,
                        mayor_id = ?, mayor_name = ?, is_main_city = ?,
                        updated_at = CURRENT_TIMESTAMP
                    WHERE id = ?
                ''', (
                    city_data.get('name'),
                    city_data.get('x'),
                    city_data.get('y'),
                    city_data.get('state'),
                    city_data.get('population', 0),
                    city_data.get('loyalty', 100),
                    city_data.get('grievance', 0),
                    city_data.get('tranquility', 100),
                    city_data.get('mayor_id'),
                    city_data.get('mayor_name'),
                    city_data.get('is_main_city', False),
                    city_id
                ))
            else:
                cursor.execute('''
                    INSERT INTO cities (
                        account_id, city_id, name, x, y, field_id, state,
                        population, loyalty, grievance, tranquility,
                        mayor_id, mayor_name, is_main_city
                    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                ''', (
                    account_id,
                    city_data.get('city_id'),
                    city_data.get('name'),
                    city_data.get('x'),
                    city_data.get('y'),
                    field_id,
                    city_data.get('state'),
                    city_data.get('population', 0),
                    city_data.get('loyalty', 100),
                    city_data.get('grievance', 0),
                    city_data.get('tranquility', 100),
                    city_data.get('mayor_id'),
                    city_data.get('mayor_name'),
                    city_data.get('is_main_city', False)
                ))
                city_id = cursor.lastrowid
            
            return city_id
    
    def upsert_troops(self, city_id: int, troops: Dict[str, int]):
        """Insert or update troops for a city"""
        with self.get_connection() as conn:
            cursor = conn.cursor()
            
            cursor.execute('SELECT id FROM troops WHERE city_id = ?', (city_id,))
            row = cursor.fetchone()
            
            total = sum(troops.values())
            
            if row:
                cursor.execute('''
                    UPDATE troops SET
                        workers = ?, warriors = ?, scouts = ?, pikemen = ?,
                        swordsmen = ?, archers = ?, cavalry = ?, cataphracts = ?,
                        transporters = ?, ballistas = ?, battering_rams = ?, catapults = ?,
                        total_troops = ?, updated_at = CURRENT_TIMESTAMP
                    WHERE city_id = ?
                ''', (
                    troops.get('workers', 0), troops.get('warriors', 0),
                    troops.get('scouts', 0), troops.get('pikemen', 0),
                    troops.get('swordsmen', 0), troops.get('archers', 0),
                    troops.get('cavalry', 0), troops.get('cataphracts', 0),
                    troops.get('transporters', 0), troops.get('ballistas', 0),
                    troops.get('battering_rams', 0), troops.get('catapults', 0),
                    total, city_id
                ))
            else:
                cursor.execute('''
                    INSERT INTO troops (
                        city_id, workers, warriors, scouts, pikemen,
                        swordsmen, archers, cavalry, cataphracts,
                        transporters, ballistas, battering_rams, catapults, total_troops
                    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                ''', (
                    city_id,
                    troops.get('workers', 0), troops.get('warriors', 0),
                    troops.get('scouts', 0), troops.get('pikemen', 0),
                    troops.get('swordsmen', 0), troops.get('archers', 0),
                    troops.get('cavalry', 0), troops.get('cataphracts', 0),
                    troops.get('transporters', 0), troops.get('ballistas', 0),
                    troops.get('battering_rams', 0), troops.get('catapults', 0),
                    total
                ))
    
    def upsert_resources(self, city_id: int, resources: Dict[str, int]):
        """Insert or update resources for a city"""
        with self.get_connection() as conn:
            cursor = conn.cursor()
            
            cursor.execute('SELECT id FROM resources WHERE city_id = ?', (city_id,))
            row = cursor.fetchone()
            
            if row:
                cursor.execute('''
                    UPDATE resources SET
                        gold = ?, food = ?, lumber = ?, stone = ?, iron = ?,
                        gold_capacity = ?, food_capacity = ?, lumber_capacity = ?,
                        stone_capacity = ?, iron_capacity = ?,
                        updated_at = CURRENT_TIMESTAMP
                    WHERE city_id = ?
                ''', (
                    resources.get('gold', 0), resources.get('food', 0),
                    resources.get('lumber', 0), resources.get('stone', 0),
                    resources.get('iron', 0),
                    resources.get('gold_capacity', 0), resources.get('food_capacity', 0),
                    resources.get('lumber_capacity', 0), resources.get('stone_capacity', 0),
                    resources.get('iron_capacity', 0),
                    city_id
                ))
            else:
                cursor.execute('''
                    INSERT INTO resources (
                        city_id, gold, food, lumber, stone, iron,
                        gold_capacity, food_capacity, lumber_capacity,
                        stone_capacity, iron_capacity
                    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                ''', (
                    city_id,
                    resources.get('gold', 0), resources.get('food', 0),
                    resources.get('lumber', 0), resources.get('stone', 0),
                    resources.get('iron', 0),
                    resources.get('gold_capacity', 0), resources.get('food_capacity', 0),
                    resources.get('lumber_capacity', 0), resources.get('stone_capacity', 0),
                    resources.get('iron_capacity', 0)
                ))
    
    def upsert_hero(self, account_id: int, city_id: int, hero_data: Dict[str, Any]):
        """Insert or update hero"""
        with self.get_connection() as conn:
            cursor = conn.cursor()
            
            hero_id = hero_data.get('hero_id')
            cursor.execute(
                'SELECT id FROM heroes WHERE account_id = ? AND hero_id = ?',
                (account_id, hero_id)
            )
            row = cursor.fetchone()
            
            if row:
                cursor.execute('''
                    UPDATE heroes SET
                        city_id = ?, name = ?, level = ?, experience = ?,
                        loyalty = ?, politics = ?, attack = ?, intelligence = ?,
                        base_politics = ?, base_attack = ?, base_intelligence = ?,
                        status = ?, is_mayor = ?, is_marshal = ?,
                        hero_type = ?, grade = ?, power = ?,
                        updated_at = CURRENT_TIMESTAMP
                    WHERE id = ?
                ''', (
                    city_id, hero_data.get('name'), hero_data.get('level', 1),
                    hero_data.get('experience', 0), hero_data.get('loyalty', 100),
                    hero_data.get('politics', 0), hero_data.get('attack', 0),
                    hero_data.get('intelligence', 0),
                    hero_data.get('base_politics', 0), hero_data.get('base_attack', 0),
                    hero_data.get('base_intelligence', 0),
                    hero_data.get('status'), hero_data.get('is_mayor', False),
                    hero_data.get('is_marshal', False),
                    hero_data.get('hero_type'), hero_data.get('grade'),
                    hero_data.get('power', 0),
                    row['id']
                ))
            else:
                cursor.execute('''
                    INSERT INTO heroes (
                        account_id, city_id, hero_id, name, level, experience,
                        loyalty, politics, attack, intelligence,
                        base_politics, base_attack, base_intelligence,
                        status, is_mayor, is_marshal, hero_type, grade, power
                    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                ''', (
                    account_id, city_id, hero_id, hero_data.get('name'),
                    hero_data.get('level', 1), hero_data.get('experience', 0),
                    hero_data.get('loyalty', 100), hero_data.get('politics', 0),
                    hero_data.get('attack', 0), hero_data.get('intelligence', 0),
                    hero_data.get('base_politics', 0), hero_data.get('base_attack', 0),
                    hero_data.get('base_intelligence', 0),
                    hero_data.get('status'), hero_data.get('is_mayor', False),
                    hero_data.get('is_marshal', False),
                    hero_data.get('hero_type'), hero_data.get('grade'),
                    hero_data.get('power', 0)
                ))
    
    def upsert_item(self, account_id: int, item_data: Dict[str, Any]):
        """Insert or update item"""
        with self.get_connection() as conn:
            cursor = conn.cursor()
            
            item_id = item_data.get('item_id')
            cursor.execute(
                'SELECT id FROM items WHERE account_id = ? AND item_id = ?',
                (account_id, item_id)
            )
            row = cursor.fetchone()
            
            if row:
                cursor.execute('''
                    UPDATE items SET
                        name = ?, count = ?, category = ?, description = ?,
                        updated_at = CURRENT_TIMESTAMP
                    WHERE id = ?
                ''', (
                    item_data.get('name'), item_data.get('count', 0),
                    item_data.get('category'), item_data.get('description'),
                    row['id']
                ))
            else:
                cursor.execute('''
                    INSERT INTO items (account_id, item_id, name, count, category, description)
                    VALUES (?, ?, ?, ?, ?, ?)
                ''', (
                    account_id, item_id, item_data.get('name'),
                    item_data.get('count', 0), item_data.get('category'),
                    item_data.get('description')
                ))
    
    def log_extraction(self, account_id: int, extraction_type: str, 
                       status: str, message: str, duration: float):
        """Log extraction attempt"""
        with self.get_connection() as conn:
            cursor = conn.cursor()
            cursor.execute('''
                INSERT INTO extraction_log (account_id, extraction_type, status, message, duration_seconds)
                VALUES (?, ?, ?, ?, ?)
            ''', (account_id, extraction_type, status, message, duration))
    
    def get_account(self, email: str) -> Optional[Dict[str, Any]]:
        """Get account data by email"""
        with self.get_connection() as conn:
            cursor = conn.cursor()
            cursor.execute('SELECT * FROM accounts WHERE email = ?', (email,))
            row = cursor.fetchone()
            return dict(row) if row else None
    
    def get_account_cities(self, account_id: int) -> List[Dict[str, Any]]:
        """Get all cities for an account"""
        with self.get_connection() as conn:
            cursor = conn.cursor()
            cursor.execute('SELECT * FROM cities WHERE account_id = ?', (account_id,))
            return [dict(row) for row in cursor.fetchall()]
    
    def get_account_summary(self, email: str) -> Dict[str, Any]:
        """Get complete account summary"""
        with self.get_connection() as conn:
            cursor = conn.cursor()
            
            # Get account
            cursor.execute('SELECT * FROM accounts WHERE email = ?', (email,))
            account = cursor.fetchone()
            if not account:
                return {}
            
            account_id = account['id']
            
            # Get cities with resources and troops
            cursor.execute('''
                SELECT c.*, r.gold, r.food, r.lumber, r.stone, r.iron,
                       t.total_troops, t.workers, t.warriors, t.scouts,
                       t.pikemen, t.swordsmen, t.archers, t.cavalry,
                       t.cataphracts, t.transporters, t.ballistas,
                       t.battering_rams, t.catapults
                FROM cities c
                LEFT JOIN resources r ON c.id = r.city_id
                LEFT JOIN troops t ON c.id = t.city_id
                WHERE c.account_id = ?
            ''', (account_id,))
            cities = [dict(row) for row in cursor.fetchall()]
            
            # Get heroes
            cursor.execute('SELECT * FROM heroes WHERE account_id = ?', (account_id,))
            heroes = [dict(row) for row in cursor.fetchall()]
            
            # Get items
            cursor.execute('SELECT * FROM items WHERE account_id = ?', (account_id,))
            items = [dict(row) for row in cursor.fetchall()]
            
            # Calculate totals
            total_gold = sum(c.get('gold', 0) or 0 for c in cities)
            total_food = sum(c.get('food', 0) or 0 for c in cities)
            total_lumber = sum(c.get('lumber', 0) or 0 for c in cities)
            total_stone = sum(c.get('stone', 0) or 0 for c in cities)
            total_iron = sum(c.get('iron', 0) or 0 for c in cities)
            total_troops = sum(c.get('total_troops', 0) or 0 for c in cities)
            
            return {
                'account': dict(account),
                'cities': cities,
                'heroes': heroes,
                'items': items,
                'summary': {
                    'total_cities': len(cities),
                    'total_heroes': len(heroes),
                    'total_items': len(items),
                    'total_gold': total_gold,
                    'total_food': total_food,
                    'total_lumber': total_lumber,
                    'total_stone': total_stone,
                    'total_iron': total_iron,
                    'total_troops': total_troops
                }
            }
    
    def get_all_accounts(self) -> List[Dict[str, Any]]:
        """Get all accounts"""
        with self.get_connection() as conn:
            cursor = conn.cursor()
            cursor.execute('SELECT * FROM accounts ORDER BY email')
            return [dict(row) for row in cursor.fetchall()]
    
    def get_statistics(self) -> Dict[str, int]:
        """Get database statistics"""
        with self.get_connection() as conn:
            cursor = conn.cursor()
            
            stats = {}
            for table in ['accounts', 'cities', 'troops', 'heroes', 'items', 'resources']:
                cursor.execute(f'SELECT COUNT(*) FROM {table}')
                stats[table] = cursor.fetchone()[0]
            
            return stats
