#!/usr/bin/env python3
"""
BORG TOOLKIT EPIC 2026 - Account Data Extractor
================================================

REAL connection to Evony servers for complete account data extraction.

Features:
- Direct login to cc2.evony.com (or any server)
- 1:1 complete account data dump
- All sections: Cities, Heroes, Troops, Resources, Items, Buildings, Research, etc.
- Multi-account support with Tor/proxy rotation
- Export to CSV and JSON formats
- Detailed logging and error handling

Server Connection:
    1. Resolve server IP from config.xml
    2. Connect via TCP port 443
    3. Handshake with AMF protocol
    4. Login with hashed credentials
    5. Request all account data
    6. Parse and export

Usage:
    from account_extractor import AccountExtractor
    
    extractor = AccountExtractor()
    extractor.add_account("email@example.com", "password", "cc2")
    extractor.extract_all()
    extractor.export_json("accounts_dump.json")
    extractor.export_csv("accounts_dump.csv")
"""

import socket
import struct
import hashlib
import json
import csv
import time
import threading
import queue
import urllib.request
import xml.etree.ElementTree as ET
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Any, Optional, Tuple
from dataclasses import dataclass, field, asdict
from concurrent.futures import ThreadPoolExecutor, as_completed
import ssl

# Try to import optional dependencies
try:
    import pyamf
    from pyamf import remoting
    PYAMF_AVAILABLE = True
except ImportError:
    PYAMF_AVAILABLE = False
    print("[!] pyamf not installed. Run: pip install pyamf")

try:
    import socks
    SOCKS_AVAILABLE = True
except ImportError:
    SOCKS_AVAILABLE = False
    print("[!] PySocks not installed. Run: pip install pysocks")

# =============================================================================
# ENCRYPTION KEYS (Extracted from EvonyClient)
# =============================================================================

EVONY_KEYS = {
    'ACTION_KEY': "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}",
    'API_KEY': "9f758e2deccbe6244f734371b9642eda",
    'USER_INFO_KEY': "IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}",
    'XOR_KEY': 0xAA,
    'LOGIN_SALT': "evony",
}

# Server mappings
SERVER_DOMAINS = {
    'cc1': 'cc1.evony.com', 'cc2': 'cc2.evony.com', 'cc3': 'cc3.evony.com',
    'na1': 'na1.evony.com', 'na2': 'na2.evony.com', 'na3': 'na3.evony.com',
    'ss1': 'ss1.evony.com', 'ss2': 'ss2.evony.com', 'ss3': 'ss3.evony.com',
}

# =============================================================================
# DATA STRUCTURES - Complete Account Model
# =============================================================================

@dataclass
class HeroData:
    """Complete hero data"""
    id: int = 0
    name: str = ""
    level: int = 0
    experience: int = 0
    attack: int = 0
    defense: int = 0
    politics: int = 0
    intelligence: int = 0
    leadership: int = 0
    is_historic: bool = False
    status: str = ""  # idle, marching, defending, etc.
    city_id: int = 0
    items: List[Dict] = field(default_factory=list)

@dataclass
class TroopData:
    """Troop counts by type"""
    workers: int = 0
    warriors: int = 0
    scouts: int = 0
    pikemen: int = 0
    swordsmen: int = 0
    archers: int = 0
    cavalry: int = 0
    cataphracts: int = 0
    transporters: int = 0
    ballistas: int = 0
    rams: int = 0
    catapults: int = 0
    
    def total(self) -> int:
        return sum(asdict(self).values())
    
    def to_short_string(self) -> str:
        """Format like khan CSV: wo:1000,a:5000,etc"""
        abbrev = {
            'workers': 'wo', 'warriors': 'wa', 'scouts': 'sc', 'pikemen': 'p',
            'swordsmen': 'sw', 'archers': 'a', 'cavalry': 'cav', 'cataphracts': 'cp',
            'transporters': 't', 'ballistas': 'b', 'rams': 'r', 'catapults': 'c'
        }
        parts = []
        for name, val in asdict(self).items():
            if val > 0:
                parts.append(f"{abbrev.get(name, name[0])}:{val}")
        return ",".join(parts) if parts else "none"

@dataclass
class ResourceData:
    """Resource amounts"""
    gold: int = 0
    food: int = 0
    wood: int = 0
    stone: int = 0
    iron: int = 0
    population: int = 0
    max_population: int = 0
    
    # Production rates
    gold_rate: int = 0
    food_rate: int = 0
    wood_rate: int = 0
    stone_rate: int = 0
    iron_rate: int = 0

@dataclass
class BuildingData:
    """Building in city"""
    id: int = 0
    type_id: int = 0
    name: str = ""
    level: int = 0
    position: int = 0
    status: str = ""  # idle, upgrading, etc.
    upgrade_end_time: int = 0

@dataclass
class ResearchData:
    """Research/Technology"""
    id: int = 0
    name: str = ""
    level: int = 0
    max_level: int = 10
    status: str = ""
    research_end_time: int = 0

@dataclass
class ItemData:
    """Inventory item"""
    id: str = ""
    name: str = ""
    count: int = 0
    category: str = ""

@dataclass
class ArmyData:
    """Army/March data"""
    id: int = 0
    hero_name: str = ""
    mission_type: str = ""  # attack, reinforce, transport, scout
    target_coords: str = ""
    troops: TroopData = field(default_factory=TroopData)
    arrival_time: int = 0
    return_time: int = 0

@dataclass 
class CityData:
    """Complete city data"""
    id: int = 0
    name: str = ""
    coords: str = ""
    level: int = 0
    is_main: bool = False
    
    resources: ResourceData = field(default_factory=ResourceData)
    troops: TroopData = field(default_factory=TroopData)
    heroes: List[HeroData] = field(default_factory=list)
    buildings: List[BuildingData] = field(default_factory=list)
    research: List[ResearchData] = field(default_factory=list)
    armies: List[ArmyData] = field(default_factory=list)
    
    fortifications: Dict = field(default_factory=dict)
    buffs: List[Dict] = field(default_factory=list)

@dataclass
class AccountData:
    """Complete account data - 1:1 dump"""
    # Account info
    email: str = ""
    password: str = ""  # Stored for re-extraction
    server: str = ""
    
    # Player info
    player_id: int = 0
    player_name: str = ""
    prestige: int = 0
    honor: int = 0
    title: str = ""
    alliance_name: str = ""
    alliance_rank: str = ""
    
    # Account timestamps
    created_at: str = ""
    last_login: str = ""
    extraction_time: str = ""
    
    # Game data
    cities: List[CityData] = field(default_factory=list)
    items: List[ItemData] = field(default_factory=list)
    mail: List[Dict] = field(default_factory=list)
    reports: List[Dict] = field(default_factory=list)
    quests: List[Dict] = field(default_factory=list)
    
    # Statistics
    total_troops: int = 0
    total_heroes: int = 0
    historic_heroes: int = 0
    total_cities: int = 0
    
    # Extraction status
    extraction_success: bool = False
    extraction_error: str = ""


# =============================================================================
# EVONY PROTOCOL COMMANDS
# =============================================================================

EXTRACTION_COMMANDS = {
    # Login and player info
    'login': 'login.login',
    'player_info': 'gameClient.playerInfo',
    
    # Castle/City data
    'castle_list': 'castle.getCastleFieldInfo',
    'castle_detail': 'castle.getAvailableBuildingListInside',
    'castle_outside': 'castle.getAvailableBuildingListOutside',
    
    # Troops
    'troop_list': 'troop.getTroopProduce',
    'fortification': 'fortifications.getFortificationsProduceList',
    
    # Heroes
    'hero_list': 'hero.getHerosListFromTavern',
    'hero_detail': 'hero.getHeroByID',
    
    # Resources & Economy
    'resource_info': 'castle.getResourceInfo',
    'trade_list': 'trade.getTransingTradeList',
    
    # Research
    'tech_list': 'tech.getResearchList',
    
    # Items
    'item_list': 'shop.getItemList',
    'package_list': 'shop.getPackageList',
    
    # Military
    'army_list': 'army.getArmyByCity',
    'army_detail': 'army.getArmyByArmyId',
    
    # Social
    'alliance_info': 'alliance.getAllianceInfo',
    'mail_list': 'mail.getMailList',
    'report_list': 'report.getReportList',
    
    # Quests
    'quest_list': 'quest.getQuestList',
    'quest_type': 'quest.getQuestType',
}


# =============================================================================
# EVONY CONNECTION CLASS
# =============================================================================

class EvonyDirectConnection:
    """
    Direct connection to Evony server with full data extraction.
    """
    
    def __init__(self, server: str = 'cc2', 
                 proxy_host: str = None, proxy_port: int = None,
                 proxy_type: str = 'SOCKS5', timeout: int = 30):
        self.server = server
        self.proxy_host = proxy_host
        self.proxy_port = proxy_port
        self.proxy_type = proxy_type
        self.timeout = timeout
        
        self.socket = None
        self.server_ip = None
        self.connected = False
        self.logged_in = False
        
        self.player_data = {}
        self.response_queue = queue.Queue()
        self.listener_thread = None
        self.running = False
        
        self._log_callback = None
    
    def set_log_callback(self, callback):
        """Set callback for logging"""
        self._log_callback = callback
    
    def _log(self, msg: str, level: str = "INFO"):
        """Log message"""
        formatted = f"[{datetime.now().strftime('%H:%M:%S')}] [{level}] {msg}"
        if self._log_callback:
            self._log_callback(formatted)
        print(formatted)
    
    def _resolve_server(self) -> str:
        """Resolve server IP from config.xml"""
        domain = SERVER_DOMAINS.get(self.server, f"{self.server}.evony.com")
        
        try:
            # Fetch config.xml
            url = f"http://{domain}/config.xml"
            self._log(f"Fetching config from {url}")
            
            with urllib.request.urlopen(url, timeout=10) as resp:
                xml_data = resp.read().decode('utf-8')
            
            root = ET.fromstring(xml_data)
            
            # Try different config formats
            server_elem = root.find('.//host') or root.find('.//server') or root.find('.//ip')
            if server_elem is not None and server_elem.text:
                self._log(f"Resolved server IP: {server_elem.text}")
                return server_elem.text
            
            # Fallback to socket resolution
            import socket as sock_module
            ip = sock_module.gethostbyname(domain)
            self._log(f"DNS resolved to: {ip}")
            return ip
            
        except Exception as e:
            self._log(f"Config fetch failed: {e}, trying DNS", "WARN")
            try:
                import socket as sock_module
                return sock_module.gethostbyname(domain)
            except:
                return domain
    
    def connect(self) -> bool:
        """Connect to Evony server"""
        if not PYAMF_AVAILABLE:
            self._log("pyamf not available - cannot connect", "ERROR")
            return False
        
        try:
            self.server_ip = self._resolve_server()
            self._log(f"Connecting to {self.server} ({self.server_ip}:443)...")
            
            # Create socket with proxy if configured
            if self.proxy_host and SOCKS_AVAILABLE:
                self.socket = socks.socksocket(socket.AF_INET, socket.SOCK_STREAM)
                proxy_types = {
                    'SOCKS4': socks.SOCKS4,
                    'SOCKS5': socks.SOCKS5,
                    'HTTP': socks.HTTP
                }
                ptype = proxy_types.get(self.proxy_type.upper(), socks.SOCKS5)
                self.socket.set_proxy(ptype, self.proxy_host, self.proxy_port)
                self._log(f"Using proxy: {self.proxy_type}://{self.proxy_host}:{self.proxy_port}")
            else:
                self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            
            self.socket.settimeout(self.timeout)
            self.socket.connect((self.server_ip, int(443)))
            
            # Send version handshake
            self._send_packet('gameClient.version', '091103_11')
            
            # Start listener thread
            self.running = True
            self.listener_thread = threading.Thread(target=self._listen_loop, daemon=True)
            self.listener_thread.start()
            
            self.connected = True
            self._log("Connected successfully!", "SUCCESS")
            return True
            
        except Exception as e:
            self._log(f"Connection failed: {e}", "ERROR")
            return False
    
    def _send_packet(self, command: str, data: Any) -> bool:
        """Send AMF packet"""
        try:
            # Create AMF message
            msg = {'cmd': command, 'data': data}
            
            # Encode with pyamf
            from io import BytesIO
            stream = BytesIO()
            encoder = pyamf.get_encoder(pyamf.AMF3, stream)
            encoder.writeElement(msg)
            encoded = stream.getvalue()
            
            # Add length header
            packet = struct.pack('>I', len(encoded)) + encoded
            
            self.socket.sendall(packet)
            self._log(f">> {command}", "SEND")
            return True
            
        except Exception as e:
            self._log(f"Send failed: {e}", "ERROR")
            return False
    
    def _receive_packet(self) -> Optional[Dict]:
        """Receive AMF packet"""
        try:
            # Read length header (4 bytes)
            header = b''
            while len(header) < 4:
                chunk = self.socket.recv(4 - len(header))
                if not chunk:
                    return None
                header += chunk
            
            length = struct.unpack('>I', header)[0]
            
            if length > 10000000:  # Sanity check
                self._log(f"Invalid packet length: {length}", "ERROR")
                return None
            
            # Read body
            body = b''
            while len(body) < length:
                chunk = self.socket.recv(min(8192, length - len(body)))
                if not chunk:
                    return None
                body += chunk
            
            # Decode AMF
            from io import BytesIO
            stream = BytesIO(body)
            decoder = pyamf.get_decoder(pyamf.AMF3, stream)
            result = decoder.readElement()
            
            return result
            
        except socket.timeout:
            return None
        except Exception as e:
            self._log(f"Receive error: {e}", "ERROR")
            return None
    
    def _listen_loop(self):
        """Background listener thread"""
        while self.running:
            try:
                self.socket.settimeout(1)
                packet = self._receive_packet()
                if packet:
                    cmd = packet.get('cmd', 'unknown')
                    self._log(f"<< {cmd}", "RECV")
                    self.response_queue.put(packet)
            except:
                pass
    
    def _wait_response(self, expected_cmd: str, timeout: int = 30) -> Optional[Dict]:
        """Wait for specific response"""
        start = time.time()
        while time.time() - start < timeout:
            try:
                packet = self.response_queue.get(timeout=1)
                if packet.get('cmd') == expected_cmd:
                    return packet.get('data', {})
                # Put back if not matching
                self.response_queue.put(packet)
            except queue.Empty:
                pass
        return None
    
    def login(self, email: str, password: str) -> bool:
        """Login to account"""
        if not self.connected:
            self._log("Not connected", "ERROR")
            return False
        
        self._log(f"Logging in as {email}...")
        
        # Hash password
        pwd_hash = hashlib.md5((password + EVONY_KEYS['LOGIN_SALT']).encode()).hexdigest()
        
        login_data = {
            'user': email,
            'pwd': pwd_hash,
            'platform': 'web'
        }
        
        self._send_packet('login.login', login_data)
        
        # Wait for response
        response = self._wait_response('login.login', timeout=30)
        
        if response and response.get('ok') == 1:
            self.logged_in = True
            self.player_data = response.get('player', {})
            player_name = self.player_data.get('userName', 'Unknown')
            self._log(f"Logged in as: {player_name}", "SUCCESS")
            return True
        else:
            error = response.get('errorMsg', 'Unknown error') if response else 'No response'
            self._log(f"Login failed: {error}", "ERROR")
            return False
    
    def send_command(self, command: str, params: Any = {}) -> Optional[Dict]:
        """Send command and get response"""
        self._send_packet(command, params)
        return self._wait_response(command, timeout=30)
    
    def close(self):
        """Close connection"""
        self.running = False
        if self.socket:
            try:
                self.socket.close()
            except:
                pass
        self.connected = False
        self.logged_in = False


# =============================================================================
# ACCOUNT EXTRACTOR - Main Class
# =============================================================================

class AccountExtractor:
    """
    Multi-account data extractor with Tor rotation support.
    
    Usage:
        extractor = AccountExtractor()
        
        # Add accounts
        extractor.add_account("email1@test.com", "pass1", "cc2")
        extractor.add_account("email2@test.com", "pass2", "cc2")
        
        # Set Tor proxies (optional)
        extractor.add_proxy("127.0.0.1", 9050)  # Tor default
        
        # Extract all
        extractor.extract_all()
        
        # Export
        extractor.export_json("dump.json")
        extractor.export_csv("dump.csv")
    """
    
    def __init__(self, output_dir: Path = None):
        self.accounts: List[Dict] = []  # {email, password, server}
        self.extracted_data: List[AccountData] = []
        self.proxies: List[Dict] = []  # {host, port, type}
        self.current_proxy_index = 0
        
        self.output_dir = output_dir or Path(__file__).parent.parent / "data" / "extracts"
        self.output_dir.mkdir(parents=True, exist_ok=True)
        
        self._log_callback = None
    
    def set_log_callback(self, callback):
        self._log_callback = callback
    
    def _log(self, msg: str, level: str = "INFO"):
        formatted = f"[{datetime.now().strftime('%H:%M:%S')}] [{level}] {msg}"
        if self._log_callback:
            self._log_callback(formatted)
        print(formatted)
    
    # =========================================================================
    # Account Management
    # =========================================================================
    
    def add_account(self, email: str, password: str, server: str = "cc2"):
        """Add account for extraction"""
        self.accounts.append({
            'email': email,
            'password': password,
            'server': server
        })
        self._log(f"Added account: {email} @ {server}")
    
    def add_accounts_from_csv(self, csv_path: Path):
        """Load accounts from CSV (email,password,server)"""
        with open(csv_path, 'r') as f:
            reader = csv.reader(f)
            for row in reader:
                if len(row) >= 2:
                    email = row[0].strip()
                    password = row[1].strip()
                    server = row[2].strip() if len(row) > 2 else "cc2"
                    if email and password and '@' in email:
                        self.add_account(email, password, server)
        self._log(f"Loaded {len(self.accounts)} accounts from CSV")
    
    def add_proxy(self, host: str, port: int, proxy_type: str = "SOCKS5"):
        """Add proxy for rotation"""
        self.proxies.append({
            'host': host,
            'port': port,
            'type': proxy_type
        })
        self._log(f"Added proxy: {proxy_type}://{host}:{port}")
    
    def add_tor_proxies(self, base_port: int = 9050, count: int = 10):
        """Add multiple Tor SOCKS proxies"""
        for i in range(count):
            self.add_proxy("127.0.0.1", base_port + i, "SOCKS5")
        self._log(f"Added {count} Tor proxies starting at port {base_port}")
    
    def _get_next_proxy(self) -> Optional[Dict]:
        """Get next proxy in rotation"""
        if not self.proxies:
            return None
        proxy = self.proxies[self.current_proxy_index]
        self.current_proxy_index = (self.current_proxy_index + 1) % len(self.proxies)
        return proxy
    
    # =========================================================================
    # Data Extraction
    # =========================================================================
    
    def extract_account(self, email: str, password: str, server: str) -> AccountData:
        """Extract complete data from one account"""
        account = AccountData(
            email=email,
            password=password,
            server=server,
            extraction_time=datetime.now().isoformat()
        )
        
        # Get proxy
        proxy = self._get_next_proxy()
        
        # Create connection
        conn = EvonyDirectConnection(
            server=server,
            proxy_host=proxy['host'] if proxy else None,
            proxy_port=proxy['port'] if proxy else None,
            proxy_type=proxy['type'] if proxy else None
        )
        conn.set_log_callback(self._log_callback or print)
        
        try:
            # Connect
            if not conn.connect():
                account.extraction_error = "Connection failed"
                return account
            
            # Login
            if not conn.login(email, password):
                account.extraction_error = "Login failed"
                conn.close()
                return account
            
            # Extract player info
            self._extract_player_info(conn, account)
            
            # Extract all cities
            self._extract_cities(conn, account)
            
            # Extract items
            self._extract_items(conn, account)
            
            # Extract quests
            self._extract_quests(conn, account)
            
            # Calculate totals
            account.total_cities = len(account.cities)
            account.total_troops = sum(c.troops.total() for c in account.cities)
            account.total_heroes = sum(len(c.heroes) for c in account.cities)
            account.historic_heroes = sum(
                1 for c in account.cities for h in c.heroes if h.is_historic
            )
            
            account.extraction_success = True
            self._log(f"Extraction complete for {email}", "SUCCESS")
            
        except Exception as e:
            account.extraction_error = str(e)
            self._log(f"Extraction error for {email}: {e}", "ERROR")
        
        finally:
            conn.close()
        
        return account
    
    def _extract_player_info(self, conn: EvonyDirectConnection, account: AccountData):
        """Extract player info"""
        player = conn.player_data
        
        account.player_id = player.get('id', 0)
        account.player_name = player.get('userName', '')
        account.prestige = player.get('prestige', 0)
        account.honor = player.get('honor', 0)
        account.title = player.get('titleName', '')
        
        # Alliance info
        alliance = player.get('alliance', {})
        account.alliance_name = alliance.get('name', '')
        account.alliance_rank = alliance.get('rank', '')
    
    def _extract_cities(self, conn: EvonyDirectConnection, account: AccountData):
        """Extract all cities data"""
        # Get castle list
        castles = conn.player_data.get('castles', [])
        
        for i, castle_info in enumerate(castles):
            city = CityData()
            city.id = castle_info.get('id', 0)
            city.name = castle_info.get('name', f'City {i+1}')
            city.coords = f"{castle_info.get('x', 0)},{castle_info.get('y', 0)}"
            city.is_main = (i == 0)
            
            # Get detailed city data
            detail = conn.send_command('castle.getCastleFieldInfo', {'castleId': city.id})
            if detail:
                self._parse_city_detail(detail, city)
            
            # Get troops
            troops = conn.send_command('troop.getTroopProduce', {'castleId': city.id})
            if troops:
                self._parse_troops(troops, city)
            
            # Get heroes
            heroes = conn.send_command('hero.getHerosListFromTavern', {'castleId': city.id})
            if heroes:
                self._parse_heroes(heroes, city)
            
            # Get research
            tech = conn.send_command('tech.getResearchList', {'castleId': city.id})
            if tech:
                self._parse_research(tech, city)
            
            account.cities.append(city)
            self._log(f"  Extracted city: {city.name} @ {city.coords}")
    
    def _parse_city_detail(self, data: Dict, city: CityData):
        """Parse city detail response"""
        # Resources
        res = data.get('resource', {})
        city.resources = ResourceData(
            gold=res.get('gold', 0),
            food=res.get('food', 0),
            wood=res.get('wood', 0),
            stone=res.get('stone', 0),
            iron=res.get('iron', 0),
            population=res.get('curPop', 0),
            max_population=res.get('maxPop', 0),
            gold_rate=res.get('goldProduction', 0),
            food_rate=res.get('foodProduction', 0),
            wood_rate=res.get('woodProduction', 0),
            stone_rate=res.get('stoneProduction', 0),
            iron_rate=res.get('ironProduction', 0)
        )
        
        # Buildings
        for bld in data.get('buildings', []):
            building = BuildingData(
                id=bld.get('id', 0),
                type_id=bld.get('typeId', 0),
                name=bld.get('name', ''),
                level=bld.get('level', 0),
                position=bld.get('positionId', 0),
                status=bld.get('status', 'idle')
            )
            city.buildings.append(building)
        
        city.level = max((b.level for b in city.buildings if b.type_id == 1), default=1)  # Town Hall
    
    def _parse_troops(self, data: Dict, city: CityData):
        """Parse troops response"""
        troops = data.get('troops', {})
        city.troops = TroopData(
            workers=troops.get('1', 0),
            warriors=troops.get('2', 0),
            scouts=troops.get('3', 0),
            pikemen=troops.get('4', 0),
            swordsmen=troops.get('5', 0),
            archers=troops.get('6', 0),
            cavalry=troops.get('7', 0),
            cataphracts=troops.get('8', 0),
            transporters=troops.get('9', 0),
            ballistas=troops.get('10', 0),
            rams=troops.get('11', 0),
            catapults=troops.get('12', 0)
        )
    
    def _parse_heroes(self, data: Dict, city: CityData):
        """Parse heroes response"""
        for hero_data in data.get('heroes', []):
            hero = HeroData(
                id=hero_data.get('id', 0),
                name=hero_data.get('name', ''),
                level=hero_data.get('level', 0),
                experience=hero_data.get('experience', 0),
                attack=hero_data.get('power', 0),
                defense=hero_data.get('defence', 0),
                politics=hero_data.get('politics', 0),
                intelligence=hero_data.get('wisdom', 0),
                leadership=hero_data.get('management', 0),
                is_historic=hero_data.get('isHistoric', False),
                status=hero_data.get('status', 'idle'),
                city_id=city.id
            )
            city.heroes.append(hero)
    
    def _parse_research(self, data: Dict, city: CityData):
        """Parse research response"""
        for tech_data in data.get('techs', []):
            research = ResearchData(
                id=tech_data.get('id', 0),
                name=tech_data.get('name', ''),
                level=tech_data.get('level', 0),
                max_level=tech_data.get('maxLevel', 10)
            )
            city.research.append(research)
    
    def _extract_items(self, conn: EvonyDirectConnection, account: AccountData):
        """Extract inventory items"""
        items_data = conn.send_command('shop.getItemList', {})
        if items_data:
            for item in items_data.get('items', []):
                account.items.append(ItemData(
                    id=item.get('id', ''),
                    name=item.get('name', ''),
                    count=item.get('count', 0),
                    category=item.get('category', '')
                ))
    
    def _extract_quests(self, conn: EvonyDirectConnection, account: AccountData):
        """Extract quest data"""
        quests = conn.send_command('quest.getQuestList', {})
        if quests:
            account.quests = quests.get('quests', [])
    
    # =========================================================================
    # Batch Extraction
    # =========================================================================
    
    def extract_all(self, max_workers: int = 5, accounts_per_proxy: int = 10):
        """Extract all accounts with parallel workers"""
        self._log(f"Starting extraction of {len(self.accounts)} accounts...")
        
        # Group accounts by proxy (10 per proxy for Tor safety)
        if self.proxies:
            self._log(f"Using {len(self.proxies)} proxies ({accounts_per_proxy} accounts each)")
        
        with ThreadPoolExecutor(max_workers=max_workers) as executor:
            futures = {}
            
            for i, acc in enumerate(self.accounts):
                future = executor.submit(
                    self.extract_account,
                    acc['email'],
                    acc['password'],
                    acc['server']
                )
                futures[future] = acc['email']
            
            for future in as_completed(futures):
                email = futures[future]
                try:
                    result = future.result()
                    self.extracted_data.append(result)
                    status = "SUCCESS" if result.extraction_success else "FAILED"
                    self._log(f"[{len(self.extracted_data)}/{len(self.accounts)}] {email}: {status}")
                except Exception as e:
                    self._log(f"Error extracting {email}: {e}", "ERROR")
        
        self._log(f"Extraction complete: {sum(1 for d in self.extracted_data if d.extraction_success)}/{len(self.accounts)} successful")
    
    # =========================================================================
    # Export Functions
    # =========================================================================
    
    def export_json(self, filename: str = None) -> Path:
        """Export all data to JSON"""
        if filename is None:
            filename = f"account_dump_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
        
        filepath = self.output_dir / filename
        
        data = []
        for account in self.extracted_data:
            acc_dict = {
                'email': account.email,
                'password': account.password,
                'server': account.server,
                'player_id': account.player_id,
                'player_name': account.player_name,
                'prestige': account.prestige,
                'honor': account.honor,
                'title': account.title,
                'alliance_name': account.alliance_name,
                'alliance_rank': account.alliance_rank,
                'extraction_time': account.extraction_time,
                'extraction_success': account.extraction_success,
                'extraction_error': account.extraction_error,
                'total_cities': account.total_cities,
                'total_troops': account.total_troops,
                'total_heroes': account.total_heroes,
                'historic_heroes': account.historic_heroes,
                'cities': [],
                'items': [asdict(i) for i in account.items],
                'quests': account.quests
            }
            
            for city in account.cities:
                city_dict = {
                    'id': city.id,
                    'name': city.name,
                    'coords': city.coords,
                    'level': city.level,
                    'is_main': city.is_main,
                    'resources': asdict(city.resources),
                    'troops': asdict(city.troops),
                    'troops_string': city.troops.to_short_string(),
                    'heroes': [asdict(h) for h in city.heroes],
                    'buildings': [asdict(b) for b in city.buildings],
                    'research': [asdict(r) for r in city.research]
                }
                acc_dict['cities'].append(city_dict)
            
            data.append(acc_dict)
        
        with open(filepath, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=2, ensure_ascii=False)
        
        self._log(f"Exported JSON: {filepath}")
        return filepath
    
    def export_csv(self, filename: str = None) -> Path:
        """Export to CSV (khan format compatible)"""
        if filename is None:
            filename = f"account_dump_{datetime.now().strftime('%Y%m%d_%H%M%S')}.csv"
        
        filepath = self.output_dir / filename
        
        with open(filepath, 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            
            # Header
            writer.writerow([
                'email', 'password', 'server', 'player_name', 'city_name', 
                'coords', 'level', 'troops', 'gold', 'food', 'wood', 'stone', 
                'iron', 'heroes', 'historic_heroes'
            ])
            
            for account in self.extracted_data:
                for city in account.cities:
                    historic_count = sum(1 for h in city.heroes if h.is_historic)
                    hero_names = ", ".join(h.name for h in city.heroes)
                    
                    writer.writerow([
                        account.email,
                        account.password,
                        account.server,
                        account.player_name,
                        city.name,
                        city.coords,
                        city.level,
                        city.troops.to_short_string(),
                        city.resources.gold,
                        city.resources.food,
                        city.resources.wood,
                        city.resources.stone,
                        city.resources.iron,
                        hero_names,
                        historic_count
                    ])
        
        self._log(f"Exported CSV: {filepath}")
        return filepath
    
    def export_khan_format(self, filename: str = None) -> Path:
        """Export in khan-compatible format (email,coords,troops)"""
        if filename is None:
            filename = f"khan_format_{datetime.now().strftime('%Y%m%d_%H%M%S')}.csv"
        
        filepath = self.output_dir / filename
        
        with open(filepath, 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            
            for account in self.extracted_data:
                for city in account.cities:
                    writer.writerow([
                        account.email,
                        f'"{city.coords}"',
                        city.troops.to_short_string()
                    ])
        
        self._log(f"Exported Khan format: {filepath}")
        return filepath


# =============================================================================
# DEMO / TEST
# =============================================================================

def main():
    print("=" * 70)
    print("BORG TOOLKIT - Account Data Extractor")
    print("=" * 70)
    print("\nCapabilities:")
    print(f"  - pyamf available: {PYAMF_AVAILABLE}")
    print(f"  - socks available: {SOCKS_AVAILABLE}")
    print("\nUsage Example:")
    print("""
    from account_extractor import AccountExtractor
    
    extractor = AccountExtractor()
    
    # Add single account
    extractor.add_account("email@test.com", "password", "cc2")
    
    # Or load from CSV
    extractor.add_accounts_from_csv("accounts.csv")
    
    # Add Tor proxies (optional, recommended for many accounts)
    extractor.add_tor_proxies(base_port=9050, count=10)
    
    # Extract all data
    extractor.extract_all()
    
    # Export to files
    extractor.export_json("full_dump.json")
    extractor.export_csv("full_dump.csv")
    extractor.export_khan_format("khan_compatible.csv")
    """)


if __name__ == "__main__":
    main()
