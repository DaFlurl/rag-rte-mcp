"""
Sectioned Evony Account Data Extractor
Stays logged in and extracts ALL data in sections to separate files.
Handles 100k+ items, all cities, troops, resources, heroes, etc.
"""

import socket
import struct
import json
import os
import time
from datetime import datetime
from typing import Dict, Any, Optional, List
from pathlib import Path

import pyamf
from pyamf import amf3
from pyamf.util import BufferedByteStream


class SectionedExtractor:
    """Extracts ALL account data in sections, staying logged in throughout."""
    
    SERVERS = {
        'cc1': '216.66.17.167',
        'cc2': '216.66.17.168',
        'cc3': '216.66.17.169',
    }
    
    # All extraction commands organized by section
    SECTIONS = {
        'login': [],  # Login response contains base data
        'packages': [
            ('common.getPackageList', {}),
            ('common.getPackageNumber', {}),
        ],
        'items': [
            ('common.getItemDefXml', {}),  # Item definitions
        ],
        'tech': [
            ('tech.getResearchList', {'castleId': None}),  # Per castle
        ],
        'interior': [
            ('interior.getResourceProduceData', {'castleId': None}),  # Per castle
        ],
        'army': [
            ('army.getStayAllianceArmys', {'castleId': None}),
            ('army.getInjuredTroop', {'castleId': None}),
            ('army.getFleeTroop', {'castleId': None}),
            ('army.getTroopParam', {'castleId': None}),
        ],
        'hero': [
            ('hero.getHerosListFromTavern', {'castleId': None}),
            ('hero.tryGetSeizedHero', {'castleId': None}),
        ],
        'fortifications': [
            ('fortifications.getFortificationsProduceList', {'castleId': None}),
            ('fortifications.getProduceQueue', {'castleId': None}),
        ],
        'trade': [
            ('trade.searchTrades', {}),
            ('trade.getMyTradeList', {}),
        ],
        'mail': [
            # Paginated - will fetch all pages
            ('mail.receiveMailList', {'pageNo': 1, 'pageSize': 100, 'mailType': 0}),
            ('mail.receiveMailList', {'pageNo': 1, 'pageSize': 100, 'mailType': 1}),
        ],
        'reports': [
            # Paginated - will fetch all pages  
            ('report.receiveReportList', {'pageNo': 1, 'pageSize': 100, 'reportType': 0}),
            ('report.receiveReportList', {'pageNo': 1, 'pageSize': 100, 'reportType': 1}),
            ('report.receiveReportList', {'pageNo': 1, 'pageSize': 100, 'reportType': 2}),
        ],
        'alliance': [
            ('alliance.getAllianceMembers', {}),
            ('alliance.getMilitarySituationList', {'pageNo': 1, 'pageSize': 100}),
            ('alliance.getAllianceEventList', {'pageNo': 1}),
            ('alliance.isHasAlliance', {}),
        ],
        'quest': [
            ('quest.getQuestList', {}),
            ('quest.getQuestType', {}),
        ],
        'friend': [
            ('friend.getFriendList', {}),
            ('friend.getBlackList', {}),
        ],
        'shop': [
            ('shop.getBuyResourceInfo', {'castleId': None}),
        ],
        'colony': [
            ('colony.getColonyList', {'castleId': None}),
        ],
        'furlough': [
            ('furlough.getFurloughInfo', {}),
        ],
        'rank': [
            ('rank.getRankPlayer', {'rankType': 0, 'pageNo': 1, 'pageSize': 100}),
            ('rank.getRankPlayer', {'rankType': 1, 'pageNo': 1, 'pageSize': 100}),
            ('rank.getRankPlayer', {'rankType': 2, 'pageNo': 1, 'pageSize': 100}),
        ],
        'zone': [
            ('common.zoneInfo', {}),
        ],
    }
    
    def __init__(self, email: str, password: str, server: str = 'cc2'):
        self.email = email
        self.password = password
        self.server = server
        self.server_ip = self.SERVERS.get(server, server)
        self.socket: Optional[socket.socket] = None
        self.connected = False
        self.logged_in = False
        self.login_data: Dict[str, Any] = {}
        self.castle_ids: List[int] = []
        self.player_name = ""
        self.extraction_data: Dict[str, Any] = {}
        
    def connect(self) -> bool:
        """Establish connection to server."""
        try:
            self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self.socket.settimeout(30)
            self.socket.connect((self.server_ip, 443))
            self.connected = True
            print(f"[+] Connected to {self.server} ({self.server_ip}:443)")
            
            # Send version handshake
            self._send_command("gameClient.version", {"version": "4.274"})
            response = self._receive_response()
            if response:
                print(f"[+] Version handshake successful")
                return True
            return False
        except Exception as e:
            print(f"[-] Connection failed: {e}")
            return False
    
    def login(self) -> bool:
        """Login to account."""
        try:
            self._send_command("login.login", {
                "user": self.email,
                "password": self.password
            })
            response = self._receive_response()
            
            if response and response.get('ok') == 1:
                self.login_data = response
                self.logged_in = True
                
                # Extract castle IDs and player info
                player = response.get('player', {})
                self.player_name = player.get('playerInfo', {}).get('userName', self.email)
                castles = player.get('castles', [])
                self.castle_ids = [c.get('id') for c in castles if c.get('id')]
                
                print(f"[+] Logged in as {self.player_name}")
                print(f"[+] Found {len(self.castle_ids)} castles")
                return True
            else:
                error = response.get('errorMsg', 'Unknown error') if response else 'No response'
                print(f"[-] Login failed: {error}")
                return False
        except Exception as e:
            print(f"[-] Login error: {e}")
            return False
    
    def _send_command(self, cmd: str, data: Dict) -> None:
        """Send AMF command to server."""
        stream = BufferedByteStream()
        encoder = amf3.Encoder(stream)
        encoder.writeElement({"cmd": cmd, "data": data})
        amf_data = stream.getvalue()
        
        packet = struct.pack(">I", len(amf_data)) + amf_data
        self.socket.sendall(packet)
    
    def _receive_response(self, timeout: float = 10.0) -> Optional[Dict]:
        """Receive and decode AMF response."""
        try:
            self.socket.settimeout(timeout)
            
            # Read length prefix (4 bytes)
            length_data = b''
            while len(length_data) < 4:
                chunk = self.socket.recv(4 - len(length_data))
                if not chunk:
                    return None
                length_data += chunk
            
            length = struct.unpack(">I", length_data)[0]
            
            # Read AMF data
            amf_data = b''
            while len(amf_data) < length:
                chunk = self.socket.recv(min(8192, length - len(amf_data)))
                if not chunk:
                    break
                amf_data += chunk
            
            # Decode AMF
            stream = BufferedByteStream(amf_data)
            decoder = amf3.Decoder(stream)
            return self._to_dict(decoder.readElement())
        except socket.timeout:
            return None
        except Exception as e:
            print(f"[-] Receive error: {e}")
            return None
    
    def _to_dict(self, obj: Any) -> Any:
        """Convert AMF objects to dictionaries recursively."""
        if isinstance(obj, dict):
            return {k: self._to_dict(v) for k, v in obj.items()}
        elif isinstance(obj, (list, tuple)):
            return [self._to_dict(item) for item in obj]
        elif hasattr(obj, '__dict__'):
            return {k: self._to_dict(v) for k, v in obj.__dict__.items() 
                    if not k.startswith('_')}
        else:
            return obj
    
    def _send_and_receive(self, cmd: str, data: Dict, timeout: float = 10.0) -> Optional[Dict]:
        """Send command and get response."""
        try:
            self._send_command(cmd, data)
            time.sleep(0.3)  # Rate limiting
            return self._receive_response(timeout)
        except Exception as e:
            print(f"[-] Command {cmd} failed: {e}")
            return None
    
    def extract_section(self, section_name: str) -> Dict[str, Any]:
        """Extract a single section of data."""
        print(f"\n[*] Extracting section: {section_name}")
        section_data = {}
        
        if section_name == 'login':
            # Login data already captured
            section_data = self.login_data
            return section_data
        
        commands = self.SECTIONS.get(section_name, [])
        
        for cmd, params in commands:
            if params.get('castleId') is None and 'castleId' in params:
                # Per-castle command - iterate all castles
                section_data[cmd] = {}
                for castle_id in self.castle_ids:
                    params_copy = params.copy()
                    params_copy['castleId'] = castle_id
                    print(f"  [>] {cmd} (castle {castle_id})")
                    response = self._send_and_receive(cmd, params_copy)
                    section_data[cmd][castle_id] = response
            elif 'pageNo' in params:
                # Paginated command - fetch all pages
                all_pages = []
                page = 1
                while True:
                    params_copy = params.copy()
                    params_copy['pageNo'] = page
                    print(f"  [>] {cmd} (page {page})")
                    response = self._send_and_receive(cmd, params_copy)
                    if not response:
                        break
                    all_pages.append(response)
                    
                    # Check if more pages
                    total_pages = response.get('totalPage', 1)
                    if page >= total_pages:
                        break
                    page += 1
                    if page > 100:  # Safety limit
                        break
                
                section_data[cmd] = all_pages
            else:
                # Simple command
                print(f"  [>] {cmd}")
                response = self._send_and_receive(cmd, params)
                section_data[cmd] = response
        
        return section_data
    
    def extract_all_sections(self) -> Dict[str, Any]:
        """Extract ALL sections of data."""
        print("\n" + "="*60)
        print("EXTRACTING ALL ACCOUNT DATA")
        print("="*60)
        
        all_data = {
            'email': self.email,
            'server': self.server,
            'player_name': self.player_name,
            'castle_ids': self.castle_ids,
            'extracted_at': datetime.now().isoformat(),
            'sections': {}
        }
        
        for section_name in self.SECTIONS.keys():
            try:
                section_data = self.extract_section(section_name)
                all_data['sections'][section_name] = section_data
                print(f"  [✓] {section_name} complete")
            except Exception as e:
                print(f"  [✗] {section_name} failed: {e}")
                all_data['sections'][section_name] = {'error': str(e)}
        
        self.extraction_data = all_data
        return all_data
    
    def save_to_files(self, output_dir: str = "data/extractions") -> str:
        """Save each section to separate files."""
        # Create account folder
        safe_email = self.email.replace('@', '_at_').replace('.', '_')
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        account_dir = Path(output_dir) / f"{safe_email}_{timestamp}"
        account_dir.mkdir(parents=True, exist_ok=True)
        
        print(f"\n[*] Saving to: {account_dir}")
        
        # Save metadata
        metadata = {
            'email': self.email,
            'server': self.server,
            'player_name': self.player_name,
            'castle_ids': self.castle_ids,
            'extracted_at': self.extraction_data.get('extracted_at'),
            'sections_extracted': list(self.extraction_data.get('sections', {}).keys())
        }
        with open(account_dir / "metadata.json", 'w') as f:
            json.dump(metadata, f, indent=2, default=str)
        
        # Save each section to separate file
        for section_name, section_data in self.extraction_data.get('sections', {}).items():
            filename = f"{section_name}.json"
            with open(account_dir / filename, 'w') as f:
                json.dump(section_data, f, indent=2, default=str)
            print(f"  [✓] Saved {filename}")
        
        # Save combined file too
        with open(account_dir / "complete_dump.json", 'w') as f:
            json.dump(self.extraction_data, f, indent=2, default=str)
        print(f"  [✓] Saved complete_dump.json")
        
        # Generate summary
        self._generate_summary(account_dir)
        
        return str(account_dir)
    
    def _generate_summary(self, output_dir: Path) -> None:
        """Generate a human-readable summary file."""
        summary_lines = []
        summary_lines.append("="*60)
        summary_lines.append("EVONY ACCOUNT EXTRACTION SUMMARY")
        summary_lines.append("="*60)
        summary_lines.append(f"Email: {self.email}")
        summary_lines.append(f"Player Name: {self.player_name}")
        summary_lines.append(f"Server: {self.server}")
        summary_lines.append(f"Extracted: {self.extraction_data.get('extracted_at')}")
        summary_lines.append("")
        
        # Player info from login
        login_data = self.extraction_data.get('sections', {}).get('login', {})
        player = login_data.get('player', {})
        player_info = player.get('playerInfo', {})
        
        if player_info:
            summary_lines.append("-"*40)
            summary_lines.append("PLAYER STATS")
            summary_lines.append("-"*40)
            
            # Convert createrTime to readable date
            create_time = player_info.get('createrTime', 0)
            if create_time:
                from datetime import datetime
                create_date = datetime.fromtimestamp(create_time / 1000)
                days_played = (datetime.now() - create_date).days
                summary_lines.append(f"Account Created: {create_date.strftime('%Y-%m-%d')} ({days_played} days ago)")
            
            summary_lines.append(f"Honor: {player_info.get('honor', 0):,}")
            summary_lines.append(f"Prestige: {player_info.get('prestige', 0):,}")
            summary_lines.append(f"Ranking: #{player_info.get('ranking', 'N/A')}")
            summary_lines.append(f"Alliance: {player_info.get('alliance', 'None')}")
            summary_lines.append(f"Title: {player_info.get('titleId', 0)}")
            summary_lines.append(f"Population: {player_info.get('population', 0):,}")
            summary_lines.append("")
        
        # Castles summary
        castles = player.get('castles', [])
        if castles:
            summary_lines.append("-"*40)
            summary_lines.append(f"CITIES ({len(castles)} total)")
            summary_lines.append("-"*40)
            
            total_troops = {}
            total_resources = {'gold': 0, 'food': 0, 'wood': 0, 'stone': 0, 'iron': 0}
            
            for castle in castles:
                name = castle.get('name', 'Unknown')
                castle_id = castle.get('id', 0)
                
                # Troops
                troop = castle.get('troop', {})
                for troop_type, count in troop.items():
                    total_troops[troop_type] = total_troops.get(troop_type, 0) + int(count or 0)
                
                # Resources
                resource = castle.get('resource', {})
                total_resources['gold'] += resource.get('gold', 0)
                
                for res_type in ['food', 'wood', 'stone', 'iron']:
                    res_data = resource.get(res_type, {})
                    if isinstance(res_data, dict):
                        total_resources[res_type] += res_data.get('amount', 0)
                    else:
                        total_resources[res_type] += res_data or 0
                
                # Heroes count
                heroes = castle.get('heros', [])
                summary_lines.append(f"  {name} (ID: {castle_id}): {len(heroes)} heroes")
            
            summary_lines.append("")
            summary_lines.append("-"*40)
            summary_lines.append("TOTAL TROOPS (All Cities)")
            summary_lines.append("-"*40)
            for troop_type, count in sorted(total_troops.items()):
                if count > 0:
                    summary_lines.append(f"  {troop_type}: {count:,.0f}")
            
            summary_lines.append("")
            summary_lines.append("-"*40)
            summary_lines.append("TOTAL RESOURCES (All Cities)")
            summary_lines.append("-"*40)
            for res_type, amount in total_resources.items():
                summary_lines.append(f"  {res_type}: {amount:,.0f}")
        
        # Items count
        items = player.get('items', [])
        summary_lines.append("")
        summary_lines.append("-"*40)
        summary_lines.append(f"ITEMS: {len(items)} unique types")
        summary_lines.append("-"*40)
        
        # Write summary
        with open(output_dir / "SUMMARY.txt", 'w') as f:
            f.write('\n'.join(summary_lines))
        print(f"  [✓] Saved SUMMARY.txt")
    
    def disconnect(self) -> None:
        """Close connection."""
        if self.socket:
            try:
                self.socket.close()
            except:
                pass
        self.connected = False
        self.logged_in = False
        print("[*] Disconnected")
    
    def full_extraction(self) -> str:
        """Complete extraction workflow."""
        try:
            if not self.connect():
                raise Exception("Connection failed")
            
            if not self.login():
                raise Exception("Login failed")
            
            self.extract_all_sections()
            output_path = self.save_to_files()
            
            return output_path
        finally:
            self.disconnect()


def extract_account(email: str, password: str, server: str = 'cc2') -> str:
    """Helper function to extract a single account."""
    extractor = SectionedExtractor(email, password, server)
    return extractor.full_extraction()


if __name__ == "__main__":
    # Test with Borg account
    email = "Tarasdbe@yahoo.com"
    password = "bojangles5"
    
    print("="*60)
    print("EVONY SECTIONED DATA EXTRACTOR")
    print("="*60)
    
    output = extract_account(email, password, 'cc2')
    print(f"\n[✓] Extraction complete!")
    print(f"[✓] Output saved to: {output}")
