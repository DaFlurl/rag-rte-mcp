"""
ETK SOL Manager - Direct Evony API Client
Connects to Evony servers using AMF protocol for account data extraction
"""

import socket
import struct
import time
import json
import hashlib
import zlib
from typing import Dict, Any, Optional, Tuple, List
from dataclasses import dataclass, field
from datetime import datetime
from pathlib import Path

try:
    import pyamf
    from pyamf import remoting
    from pyamf.flex import messaging
    AMF_AVAILABLE = True
except ImportError:
    AMF_AVAILABLE = False
    print("PyAMF not available - install with: pip install pyamf")

import urllib.request
import urllib.error


# Evony server configuration
EVONY_SERVERS = {
    "cc2": {
        "name": "Parapet", 
        "host": "cc2.evony.com",
        "ip": "216.66.17.35",
        "gateway": "/gateway.php",
        "port": 80
    }
}


@dataclass
class EvonyAccount:
    """Extracted account data"""
    email: str = ""
    password: str = ""
    player_name: str = ""
    player_id: int = 0
    prestige: int = 0
    honor: int = 0
    title: str = ""
    alliance_name: str = ""
    alliance_id: int = 0
    server: str = "cc2"
    cities: List[Dict] = field(default_factory=list)
    heroes: List[Dict] = field(default_factory=list)
    items: List[Dict] = field(default_factory=list)
    logged_in: bool = False
    error: str = ""
    raw_data: Dict = field(default_factory=dict)


class EvonyAPI:
    """
    Direct API client for Evony servers.
    Uses AMF protocol over HTTP to communicate with game servers.
    """
    
    def __init__(self, server: str = "cc2"):
        self.server = server
        self.config = EVONY_SERVERS.get(server, EVONY_SERVERS["cc2"])
        self.session_key: str = ""
        self.player_id: int = 0
        self.logged_in: bool = False
        self.account_data: Dict = {}
        
        # Build gateway URL
        self.gateway_url = f"http://{self.config['host']}{self.config['gateway']}"
    
    def _create_amf_request(self, service: str, method: str, *args) -> bytes:
        """Create AMF request envelope"""
        if not AMF_AVAILABLE:
            raise RuntimeError("PyAMF not installed")
        
        # Create AMF envelope
        envelope = remoting.Envelope(amfVersion=3)
        
        # Create request
        request = remoting.Request(
            target=f"{service}.{method}",
            body=list(args)
        )
        
        envelope['/1'] = request
        
        # Encode to bytes
        stream = remoting.encode(envelope)
        return stream.getvalue()
    
    def _send_amf_request(self, data: bytes) -> Optional[Dict]:
        """Send AMF request and parse response"""
        try:
            req = urllib.request.Request(
                self.gateway_url,
                data=data,
                headers={
                    'Content-Type': 'application/x-amf',
                    'User-Agent': 'Mozilla/5.0'
                }
            )
            
            with urllib.request.urlopen(req, timeout=30) as response:
                response_data = response.read()
                
                # Decode AMF response
                envelope = remoting.decode(response_data)
                
                # Extract response body
                for key, value in envelope.items():
                    if hasattr(value, 'body'):
                        return value.body
                
                return None
                
        except urllib.error.URLError as e:
            print(f"URL Error: {e}")
            return None
        except Exception as e:
            print(f"Request error: {e}")
            return None
    
    def login(self, email: str, password: str) -> Tuple[bool, str]:
        """
        Login to Evony server.
        
        Returns:
            Tuple of (success, error_message)
        """
        if not AMF_AVAILABLE:
            return False, "PyAMF not installed"
        
        try:
            # Evony login request
            # Service: evony.UserService
            # Method: login
            login_data = self._create_amf_request(
                "evony.UserService",
                "login",
                email,
                password,
                self.server
            )
            
            response = self._send_amf_request(login_data)
            
            if response is None:
                return False, "No response from server"
            
            # Parse login response
            if isinstance(response, dict):
                if response.get('ok') == 1 or response.get('success'):
                    self.logged_in = True
                    self.session_key = response.get('sessionKey', '')
                    self.player_id = response.get('playerId', 0)
                    self.account_data = response
                    return True, ""
                else:
                    error = response.get('errorMsg', response.get('msg', 'Login failed'))
                    return False, error
            
            return False, "Invalid response format"
            
        except Exception as e:
            return False, str(e)
    
    def get_player_info(self) -> Dict:
        """Get player information after login"""
        if not self.logged_in:
            return {}
        
        try:
            request_data = self._create_amf_request(
                "evony.PlayerService", 
                "getPlayerInfo",
                self.session_key
            )
            
            response = self._send_amf_request(request_data)
            return response if response else {}
            
        except Exception as e:
            print(f"Error getting player info: {e}")
            return {}
    
    def get_cities(self) -> List[Dict]:
        """Get all cities"""
        if not self.logged_in:
            return []
        
        try:
            request_data = self._create_amf_request(
                "evony.CastleService",
                "getCastles", 
                self.session_key
            )
            
            response = self._send_amf_request(request_data)
            
            if isinstance(response, dict) and 'castles' in response:
                return response['castles']
            elif isinstance(response, list):
                return response
            
            return []
            
        except Exception as e:
            print(f"Error getting cities: {e}")
            return []
    
    def get_heroes(self) -> List[Dict]:
        """Get all heroes"""
        if not self.logged_in:
            return []
        
        try:
            request_data = self._create_amf_request(
                "evony.HeroService",
                "getHeroes",
                self.session_key
            )
            
            response = self._send_amf_request(request_data)
            
            if isinstance(response, dict) and 'heroes' in response:
                return response['heroes']
            elif isinstance(response, list):
                return response
            
            return []
            
        except Exception as e:
            print(f"Error getting heroes: {e}")
            return []
    
    def get_items(self) -> List[Dict]:
        """Get all items"""
        if not self.logged_in:
            return []
        
        try:
            request_data = self._create_amf_request(
                "evony.ItemService",
                "getItems",
                self.session_key
            )
            
            response = self._send_amf_request(request_data)
            
            if isinstance(response, dict) and 'items' in response:
                return response['items']
            elif isinstance(response, list):
                return response
            
            return []
            
        except Exception as e:
            print(f"Error getting items: {e}")
            return []
    
    def extract_full_account(self, email: str, password: str) -> EvonyAccount:
        """
        Login and extract all account data.
        
        Returns:
            EvonyAccount with all extracted data
        """
        account = EvonyAccount(email=email, password=password, server=self.server)
        
        # Login
        success, error = self.login(email, password)
        if not success:
            account.error = error
            return account
        
        account.logged_in = True
        
        # Get player info
        player_info = self.get_player_info()
        if player_info:
            account.player_name = player_info.get('userName', '')
            account.player_id = player_info.get('id', 0)
            account.prestige = player_info.get('prestige', 0)
            account.honor = player_info.get('honor', 0)
            account.title = player_info.get('title', '')
            account.alliance_name = player_info.get('allianceName', '')
            account.alliance_id = player_info.get('allianceId', 0)
            account.raw_data['player'] = player_info
        
        # Get cities
        account.cities = self.get_cities()
        account.raw_data['cities'] = account.cities
        
        # Get heroes  
        account.heroes = self.get_heroes()
        account.raw_data['heroes'] = account.heroes
        
        # Get items
        account.items = self.get_items()
        account.raw_data['items'] = account.items
        
        return account


class EvonySocketClient:
    """
    Low-level socket client for Evony.
    Uses the binary protocol directly.
    """
    
    def __init__(self, server: str = "cc2"):
        self.server = server
        self.config = EVONY_SERVERS.get(server, EVONY_SERVERS["cc2"])
        self.socket: Optional[socket.socket] = None
        self.connected = False
        
    def connect(self) -> bool:
        """Connect to Evony server"""
        try:
            self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self.socket.settimeout(30)
            self.socket.connect((self.config['ip'], 443))
            self.connected = True
            print(f"Connected to {self.config['name']} ({self.config['ip']})")
            return True
        except Exception as e:
            print(f"Connection failed: {e}")
            return False
    
    def disconnect(self):
        """Disconnect from server"""
        if self.socket:
            try:
                self.socket.close()
            except:
                pass
        self.socket = None
        self.connected = False
    
    def send_policy_request(self) -> str:
        """Send Flash policy file request"""
        if not self.connected:
            return ""
        
        try:
            # Flash policy request
            self.socket.send(b"<policy-file-request/>\x00")
            response = self.socket.recv(4096)
            return response.decode('utf-8', errors='ignore')
        except Exception as e:
            print(f"Policy request failed: {e}")
            return ""


def extract_account_now(email: str, password: str, server: str = "cc2") -> EvonyAccount:
    """
    Quick function to extract account data.
    
    Usage:
        account = extract_account_now("email@example.com", "password")
        print(account.player_name, account.prestige)
    """
    api = EvonyAPI(server)
    return api.extract_full_account(email, password)


def save_account_to_json(account: EvonyAccount, output_dir: str = None) -> str:
    """Save extracted account data to JSON file"""
    if output_dir is None:
        output_dir = Path(r"D:\EvonyToolKit\data\exports")
    else:
        output_dir = Path(output_dir)
    
    output_dir.mkdir(parents=True, exist_ok=True)
    
    # Create filename from email
    safe_email = account.email.replace("@", "_at_").replace(".", "_")
    filename = f"{safe_email}_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
    filepath = output_dir / filename
    
    # Prepare data
    data = {
        'extraction_time': datetime.now().isoformat(),
        'email': account.email,
        'server': account.server,
        'player_name': account.player_name,
        'player_id': account.player_id,
        'prestige': account.prestige,
        'honor': account.honor,
        'title': account.title,
        'alliance_name': account.alliance_name,
        'alliance_id': account.alliance_id,
        'logged_in': account.logged_in,
        'error': account.error,
        'cities': account.cities,
        'heroes': account.heroes,
        'items': account.items
    }
    
    with open(filepath, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2, default=str)
    
    return str(filepath)


if __name__ == '__main__':
    # Test extraction
    print("=" * 60)
    print("Evony Account Extractor")
    print("=" * 60)
    
    # Borg's account
    email = "Tarasdbe@yahoo.com"
    password = "bojangles5"
    
    print(f"\nExtracting: {email}")
    print(f"Server: cc2.evony.com")
    
    account = extract_account_now(email, password)
    
    if account.logged_in:
        print(f"\n✓ Login successful!")
        print(f"  Player: {account.player_name}")
        print(f"  Prestige: {account.prestige:,}")
        print(f"  Honor: {account.honor:,}")
        print(f"  Alliance: {account.alliance_name}")
        print(f"  Cities: {len(account.cities)}")
        print(f"  Heroes: {len(account.heroes)}")
        print(f"  Items: {len(account.items)}")
        
        # Save to JSON
        filepath = save_account_to_json(account)
        print(f"\n  Saved to: {filepath}")
    else:
        print(f"\n✗ Login failed: {account.error}")
