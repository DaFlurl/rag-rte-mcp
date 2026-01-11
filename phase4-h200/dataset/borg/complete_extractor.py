"""
Complete Evony Account Extractor - 1:1 NAND-style Dump
Extracts ALL available data from an Evony account

Based on decompiled AutoEvony source files:
- CastleCommands.as, ArmyCommands.as, CommonCommands.as
- MailCommands.as, ReportCommands.as, AllianceCommands.as
- TroopCommands.as, QuestCommands.as, FriendCommands.as
- EquipmentCommands.as, TradeCommands.as, etc.
"""

import socket
import struct
import time
import json
import logging
from pathlib import Path
from datetime import datetime
from typing import Dict, Optional, Any, List
from dataclasses import dataclass, asdict

import pyamf
from pyamf.util import BufferedByteStream

logger = logging.getLogger(__name__)

# Server configurations
SERVERS = {
    'cc2': {'host': '216.66.17.168', 'port': 443, 'name': 'Parapet'},
    'cc1': {'host': '216.66.17.167', 'port': 443, 'name': 'CC1'},
    'cc3': {'host': '216.66.17.169', 'port': 443, 'name': 'CC3'},
}

GAME_VERSION = "4.274"

# All known extraction commands from AS3 source
EXTRACTION_COMMANDS = {
    # Castle/City Data
    'castle.getCastleFieldInfo': {},
    'castle.getAvailableBuildingListInside': {'castleId': None},
    'castle.getAvailableBuildingListOutside': {'castleId': None},
    
    # Army/Troops
    'army.getStayAllianceArmys': {'castleId': None},
    'army.getInjuredTroop': {'castleId': None},
    'army.getFleeTroop': {'castleId': None},
    'army.getTroopParam': {'castleId': None},
    
    # Heroes
    'hero.getHerosListFromTavern': {'castleId': None},
    'hero.tryGetSeizedHero': {'castleId': None},
    'hero.getHeroListOnTheft': {'theftId': None},
    
    # Tech/Research
    'tech.getResearchList': {'castleId': None},
    'tech.getCoinsNeed': {'castleId': None, 'techId': None},
    
    # Interior (Tax, Resources)
    'interior.getResourceProduceData': {'castleId': None},
    'interior.modifyCommenceRate': {'castleId': None},
    
    # Fortifications
    'fortifications.getFortificationsProduceList': {'castleId': None},
    'fortifications.getProduceQueue': {'castleId': None},
    
    # Trade
    'trade.searchTrades': {},
    'trade.getMyTradeList': {},
    
    # Mail
    'mail.receiveMailList': {'pageNo': 1, 'pageSize': 100, 'mailType': 0},
    'mail.getAllTVMsg': {},
    
    # Reports  
    'report.receiveReportList': {'pageNo': 1, 'pageSize': 100, 'reportType': 0},
    
    # Alliance
    'alliance.getAllianceMembers': {},
    'alliance.getMilitarySituationList': {'pageNo': 1, 'pageSize': 100},
    'alliance.getAllianceEventList': {'pageNo': 1},
    
    # Quests
    'quest.getQuestList': {},
    'quest.getQuestType': {},
    
    # Friends
    'friend.getFriendList': {},
    'friend.getBlackList': {},
    
    # Shop/Items
    'shop.getBuyResourceInfo': {'castleId': None},
    'shop.getStoreList': {},
    
    # Equipment
    'equipment.getEquipmentsByPlayerId': {},
    
    # Common/Player
    'common.getPackageList': {},
    'common.getPackageNumber': {},
    'common.getTroopConfig': {},
    
    # Rank
    'rank.getRankPlayer': {'rankType': 0, 'pageNo': 1, 'pageSize': 10},
    
    # Furlough
    'furlough.getFurloughInfo': {},
    
    # Colony
    'colony.getColonyList': {'castleId': None},
}


@dataclass
class AccountDump:
    """Complete account data structure"""
    # Metadata
    email: str
    server: str
    extracted_at: str
    extraction_version: str = "1.0"
    
    # Login response data (most data comes here)
    login_data: Dict = None
    
    # Player info
    player: Dict = None
    
    # Cities/Castles
    castles: List[Dict] = None
    castle_details: Dict = None  # Per-castle details
    
    # Army data
    armies: List[Dict] = None
    injured_troops: Dict = None
    flee_troops: Dict = None
    
    # Heroes
    heroes: List[Dict] = None
    tavern_heroes: Dict = None
    
    # Resources
    resources: Dict = None
    production: Dict = None
    
    # Buildings
    buildings: Dict = None
    
    # Research/Tech
    research: Dict = None
    
    # Troops
    troops: Dict = None
    troop_params: Dict = None
    
    # Fortifications
    fortifications: Dict = None
    
    # Items/Inventory
    items: List[Dict] = None
    packages: Dict = None
    
    # Equipment
    equipment: List[Dict] = None
    
    # Alliance
    alliance: Dict = None
    alliance_members: List[Dict] = None
    alliance_events: List[Dict] = None
    military_situation: List[Dict] = None
    
    # Mail
    mail: List[Dict] = None
    
    # Reports
    reports: List[Dict] = None
    
    # Quests
    quests: List[Dict] = None
    
    # Trade
    trades: List[Dict] = None
    my_trades: List[Dict] = None
    
    # Friends
    friends: List[Dict] = None
    blacklist: List[Dict] = None
    
    # Colonies
    colonies: List[Dict] = None
    
    # Furlough
    furlough: Dict = None
    
    # Shop
    shop: Dict = None
    
    # Buffs/Boosts
    buffs: List[Dict] = None
    
    # Settings
    settings: Dict = None
    
    # Raw responses (for debugging)
    raw_responses: Dict = None


class CompleteExtractor:
    """
    Complete Evony account extractor.
    Extracts ALL available data for 1:1 backup.
    """
    
    def __init__(self, server: str = 'cc2'):
        self.server = server
        self.server_info = SERVERS.get(server, SERVERS['cc2'])
        self.socket: Optional[socket.socket] = None
        self.connected = False
        self.authenticated = False
        
        # Account data
        self.email = ""
        self.player_id = None
        self.castle_ids = []
        
        # Collected data
        self.dump = None
        self.raw_responses = {}
    
    def connect(self) -> bool:
        """Connect to game server"""
        try:
            host = self.server_info['host']
            port = self.server_info['port']
            
            logger.info(f"Connecting to {self.server} ({host}:{port})...")
            
            self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self.socket.settimeout(30)
            self.socket.connect((host, port))
            
            self.connected = True
            
            # Send version handshake
            self._send("gameClient.version", GAME_VERSION)
            
            return True
            
        except Exception as e:
            logger.error(f"Connection failed: {e}")
            return False
    
    def login(self, email: str, password: str) -> bool:
        """Login and capture initial data dump"""
        if not self.connected:
            return False
        
        self.email = email
        
        try:
            logger.info(f"Logging in as {email}...")
            self._send("login", {"user": email, "pwd": password})
            
            response = self._receive(timeout=30)
            
            if response:
                cmd = response.get('cmd', '')
                data = response.get('data', {})
                
                # Store raw login response
                self.raw_responses['login'] = response
                
                # Check for successful login
                if data.get('ok') == 1 or 'player' in str(data):
                    self.authenticated = True
                    
                    # Initialize dump with login data
                    self.dump = AccountDump(
                        email=email,
                        server=self.server,
                        extracted_at=datetime.now().isoformat(),
                        login_data=data
                    )
                    
                    # Parse initial data from login response
                    self._parse_login_data(data)
                    
                    logger.info(f"Login successful! Player ID: {self.player_id}")
                    return True
                else:
                    error = data.get('errorMsg', 'Unknown error')
                    logger.error(f"Login failed: {error}")
                    return False
            
            return False
            
        except Exception as e:
            logger.error(f"Login error: {e}")
            return False
    
    def _parse_login_data(self, data: Dict):
        """Parse the initial login response which contains most data"""
        # Player info
        if 'player' in data:
            self.dump.player = data['player']
            self.player_id = data['player'].get('id')
        
        # Castles
        if 'castles' in data:
            self.dump.castles = data['castles']
            self.castle_ids = [c.get('id') for c in data['castles'] if c.get('id')]
        
        # Heroes
        if 'heroesArray' in data:
            self.dump.heroes = data['heroesArray']
        
        # Items
        if 'items' in data:
            self.dump.items = data['items']
        
        # Armies
        if 'selfArmys' in data:
            self.dump.armies = data['selfArmys']
        
        # Alliance
        if 'alliance' in data:
            self.dump.alliance = data.get('allianceBean', {})
        
        # Buffs
        if 'buffs' in data:
            self.dump.buffs = data['buffs']
        
        # Settings/configs
        if 'troopConfigBeans' in data:
            self.dump.settings = {
                'troop_configs': data['troopConfigBeans'],
                'return_report': data.get('returnReport'),
                'red_count': data.get('redCount'),
            }
        
        # Packages
        if 'packageBeans' in data:
            self.dump.packages = data.get('packageBeans', [])
    
    def extract_all(self) -> AccountDump:
        """Extract ALL available data from the account"""
        if not self.authenticated:
            logger.error("Not authenticated")
            return None
        
        logger.info("Starting complete data extraction...")
        
        # Extract per-castle data
        self._extract_castle_data()
        
        # Extract global data
        self._extract_mail()
        self._extract_reports()
        self._extract_alliance()
        self._extract_quests()
        self._extract_friends()
        self._extract_trade()
        self._extract_equipment()
        self._extract_packages()
        self._extract_furlough()
        
        # Store raw responses
        self.dump.raw_responses = self.raw_responses
        
        logger.info("Extraction complete!")
        return self.dump
    
    def _extract_castle_data(self):
        """Extract data for each castle"""
        self.dump.castle_details = {}
        
        for castle_id in self.castle_ids:
            logger.info(f"Extracting castle {castle_id}...")
            
            castle_data = {}
            
            # Buildings inside
            resp = self._send_and_receive('castle.getAvailableBuildingListInside', 
                                         {'castleId': castle_id})
            if resp:
                castle_data['buildings_inside'] = resp.get('data', {})
                self.raw_responses[f'castle_{castle_id}_buildings_inside'] = resp
            
            # Buildings outside
            resp = self._send_and_receive('castle.getAvailableBuildingListOutside',
                                         {'castleId': castle_id})
            if resp:
                castle_data['buildings_outside'] = resp.get('data', {})
                self.raw_responses[f'castle_{castle_id}_buildings_outside'] = resp
            
            # Injured troops
            resp = self._send_and_receive('army.getInjuredTroop', {'castleId': castle_id})
            if resp:
                castle_data['injured_troops'] = resp.get('data', {})
                self.raw_responses[f'castle_{castle_id}_injured'] = resp
            
            # Flee troops
            resp = self._send_and_receive('army.getFleeTroop', {'castleId': castle_id})
            if resp:
                castle_data['flee_troops'] = resp.get('data', {})
            
            # Troop params
            resp = self._send_and_receive('army.getTroopParam', {'castleId': castle_id})
            if resp:
                castle_data['troop_params'] = resp.get('data', {})
            
            # Heroes in tavern
            resp = self._send_and_receive('hero.getHerosListFromTavern', 
                                         {'castleId': castle_id})
            if resp:
                castle_data['tavern_heroes'] = resp.get('data', {})
            
            # Tech/Research
            resp = self._send_and_receive('tech.getResearchList', {'castleId': castle_id})
            if resp:
                castle_data['research'] = resp.get('data', {})
            
            # Fortifications
            resp = self._send_and_receive('fortifications.getFortificationsProduceList',
                                         {'castleId': castle_id})
            if resp:
                castle_data['fortifications'] = resp.get('data', {})
            
            # Resource production
            resp = self._send_and_receive('interior.getResourceProduceData',
                                         {'castleId': castle_id})
            if resp:
                castle_data['resource_production'] = resp.get('data', {})
            
            # Alliance armies
            resp = self._send_and_receive('army.getStayAllianceArmys', 
                                         {'castleId': castle_id})
            if resp:
                castle_data['alliance_armies'] = resp.get('data', {})
            
            # Colonies
            resp = self._send_and_receive('colony.getColonyList', {'castleId': castle_id})
            if resp:
                castle_data['colonies'] = resp.get('data', {})
            
            self.dump.castle_details[castle_id] = castle_data
            
            time.sleep(0.3)  # Rate limiting
    
    def _extract_mail(self):
        """Extract all mail"""
        logger.info("Extracting mail...")
        
        # Get inbox
        resp = self._send_and_receive('mail.receiveMailList', 
                                     {'pageNo': 1, 'pageSize': 1000, 'mailType': 0})
        if resp:
            self.dump.mail = resp.get('data', {}).get('mails', [])
            self.raw_responses['mail'] = resp
    
    def _extract_reports(self):
        """Extract all battle/scout reports"""
        logger.info("Extracting reports...")
        
        all_reports = []
        
        # Report types: 0=all, 1=military, 2=scout, 3=resource, etc.
        for report_type in [0, 1, 2, 3]:
            resp = self._send_and_receive('report.receiveReportList',
                                         {'pageNo': 1, 'pageSize': 500, 
                                          'reportType': report_type})
            if resp:
                reports = resp.get('data', {}).get('reports', [])
                all_reports.extend(reports)
        
        self.dump.reports = all_reports
        self.raw_responses['reports'] = all_reports
    
    def _extract_alliance(self):
        """Extract alliance data"""
        logger.info("Extracting alliance data...")
        
        # Members
        resp = self._send_and_receive('alliance.getAllianceMembers', {})
        if resp:
            self.dump.alliance_members = resp.get('data', {}).get('members', [])
            self.raw_responses['alliance_members'] = resp
        
        # Events
        resp = self._send_and_receive('alliance.getAllianceEventList', {'pageNo': 1})
        if resp:
            self.dump.alliance_events = resp.get('data', {}).get('events', [])
        
        # Military situation
        resp = self._send_and_receive('alliance.getMilitarySituationList',
                                     {'pageNo': 1, 'pageSize': 100})
        if resp:
            self.dump.military_situation = resp.get('data', {}).get('situations', [])
    
    def _extract_quests(self):
        """Extract quest data"""
        logger.info("Extracting quests...")
        
        resp = self._send_and_receive('quest.getQuestList', {})
        if resp:
            self.dump.quests = resp.get('data', {}).get('quests', [])
            self.raw_responses['quests'] = resp
    
    def _extract_friends(self):
        """Extract friends list"""
        logger.info("Extracting friends...")
        
        resp = self._send_and_receive('friend.getFriendList', {})
        if resp:
            self.dump.friends = resp.get('data', {}).get('friends', [])
        
        resp = self._send_and_receive('friend.getBlackList', {})
        if resp:
            self.dump.blacklist = resp.get('data', {}).get('blacklist', [])
    
    def _extract_trade(self):
        """Extract trade data"""
        logger.info("Extracting trades...")
        
        resp = self._send_and_receive('trade.getMyTradeList', {})
        if resp:
            self.dump.my_trades = resp.get('data', {}).get('trades', [])
    
    def _extract_equipment(self):
        """Extract equipment data"""
        logger.info("Extracting equipment...")
        
        resp = self._send_and_receive('equipment.getEquipmentsByPlayerId', {})
        if resp:
            self.dump.equipment = resp.get('data', {}).get('equipments', [])
            self.raw_responses['equipment'] = resp
    
    def _extract_packages(self):
        """Extract packages/rewards"""
        logger.info("Extracting packages...")
        
        resp = self._send_and_receive('common.getPackageList', {})
        if resp:
            self.dump.packages = resp.get('data', {})
    
    def _extract_furlough(self):
        """Extract furlough/vacation mode info"""
        logger.info("Extracting furlough...")
        
        resp = self._send_and_receive('furlough.getFurloughInfo', {})
        if resp:
            self.dump.furlough = resp.get('data', {})
    
    def _send(self, cmd: str, data: Any):
        """Send command"""
        message = {"cmd": cmd, "data": data}
        
        stream = BufferedByteStream()
        encoder = pyamf.get_encoder(pyamf.AMF3, stream)
        encoder.writeElement(message)
        amf_bytes = stream.getvalue()
        
        packet = struct.pack(">I", len(amf_bytes)) + amf_bytes
        self.socket.sendall(packet)
    
    def _receive(self, timeout: float = 10) -> Optional[Dict]:
        """Receive response"""
        self.socket.settimeout(timeout)
        
        try:
            header = self._recv_exact(4)
            if not header:
                return None
            
            length = struct.unpack(">I", header)[0]
            
            if length <= 0 or length > 0x100000:
                return None
            
            amf_data = self._recv_exact(length)
            if not amf_data:
                return None
            
            stream = BufferedByteStream(amf_data)
            decoder = pyamf.get_decoder(pyamf.AMF3, stream)
            return decoder.readElement()
            
        except socket.timeout:
            return None
        except Exception as e:
            logger.debug(f"Receive error: {e}")
            return None
    
    def _recv_exact(self, n: int) -> Optional[bytes]:
        """Receive exactly n bytes"""
        data = b''
        while len(data) < n:
            chunk = self.socket.recv(n - len(data))
            if not chunk:
                return None
            data += chunk
        return data
    
    def _send_and_receive(self, cmd: str, params: Dict) -> Optional[Dict]:
        """Send command and get response"""
        try:
            self._send(cmd, params)
            time.sleep(0.1)  # Small delay
            return self._receive(timeout=5)
        except Exception as e:
            logger.debug(f"Command {cmd} failed: {e}")
            return None
    
    def disconnect(self):
        """Disconnect"""
        if self.socket:
            try:
                self.socket.close()
            except:
                pass
        self.socket = None
        self.connected = False
    
    def save_dump(self, output_dir: str = "data/dumps") -> Path:
        """Save the complete dump to JSON"""
        if not self.dump:
            return None
        
        output_path = Path(output_dir)
        output_path.mkdir(parents=True, exist_ok=True)
        
        # Create filename
        safe_email = self.email.replace('@', '_at_').replace('.', '_')
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        filename = f"{safe_email}_{timestamp}.json"
        
        filepath = output_path / filename
        
        # Convert to dict and save
        dump_dict = asdict(self.dump)
        
        with open(filepath, 'w', encoding='utf-8') as f:
            json.dump(dump_dict, f, indent=2, default=str)
        
        logger.info(f"Saved dump to {filepath}")
        return filepath


def extract_account(email: str, password: str, server: str = 'cc2',
                   output_dir: str = "data/dumps") -> Optional[Path]:
    """
    Extract complete account data and save to JSON.
    
    Returns path to saved dump file.
    """
    extractor = CompleteExtractor(server)
    
    if not extractor.connect():
        return None
    
    if not extractor.login(email, password):
        extractor.disconnect()
        return None
    
    # Extract everything
    dump = extractor.extract_all()
    
    # Save
    filepath = extractor.save_dump(output_dir)
    
    extractor.disconnect()
    
    return filepath


if __name__ == "__main__":
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s [%(levelname)s] %(message)s'
    )
    
    # Test with Borg account
    filepath = extract_account(
        email="Tarasdbe@yahoo.com",
        password="bojangles5",
        server="cc2"
    )
    
    if filepath:
        print(f"\n✓ Complete dump saved to: {filepath}")
    else:
        print("\n✗ Extraction failed")
