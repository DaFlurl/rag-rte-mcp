"""
Robust Evony Account Data Extractor
Uses proper AMF3 codec from Svony Studio
Stays logged in and extracts ALL data in sections
"""

import socket
import struct
import json
import os
import time
from datetime import datetime
from typing import Dict, Any, Optional, List
from pathlib import Path

from .amf_codec import AMF3Encoder, AMF3Decoder


class RobustExtractor:
    """Robust extractor with proper AMF handling from Svony Studio"""
    
    SERVERS = {
        'cc1': '216.66.17.167',
        'cc2': '216.66.17.168', 
        'cc3': '216.66.17.169',
    }
    
    def __init__(self, email: str, password: str, server: str = 'cc2'):
        self.email = email
        self.password = password
        self.server = server
        self.server_ip = self.SERVERS.get(server, server)
        self.socket: Optional[socket.socket] = None
        self.encoder = AMF3Encoder()
        self.decoder = AMF3Decoder()
        self.connected = False
        self.logged_in = False
        self.login_data: Dict[str, Any] = {}
        self.castle_ids: List[int] = []
        self.player_name = ""
        
    def connect(self) -> bool:
        """Connect to Evony server"""
        try:
            self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self.socket.settimeout(30)
            print(f"[*] Connecting to {self.server} ({self.server_ip}:443)...")
            self.socket.connect((self.server_ip, 443))
            self.connected = True
            print(f"[+] Connected!")
            
            # Send version handshake
            print("[*] Sending version handshake...")
            self._send_command("gameClient.version", {"version": "4.274"})
            
            # Wait for response
            response = self._receive_response(timeout=15)
            if response:
                print(f"[+] Version handshake OK: {response.get('msg', 'success')}")
                return True
            else:
                print("[-] No handshake response, trying to continue...")
                return True  # Some servers don't respond to version
                
        except Exception as e:
            print(f"[-] Connection failed: {e}")
            self.connected = False
            return False
    
    def login(self) -> bool:
        """Login to account"""
        if not self.connected:
            print("[-] Not connected")
            return False
            
        try:
            print(f"[*] Logging in as {self.email}...")
            self._send_command("login.login", {
                "user": self.email,
                "password": self.password  # Plain password
            })
            
            response = self._receive_response(timeout=30)
            
            if not response:
                print("[-] No login response")
                return False
                
            if response.get('ok') == 1:
                self.login_data = response
                self.logged_in = True
                
                # Extract player info
                player = response.get('player', {})
                player_info = player.get('playerInfo', {})
                self.player_name = player_info.get('userName', self.email)
                
                # Extract castle IDs
                castles = player.get('castles', [])
                self.castle_ids = [c.get('id') for c in castles if c.get('id')]
                
                print(f"[+] Logged in as: {self.player_name}")
                print(f"[+] Castles: {len(self.castle_ids)}")
                print(f"[+] Items: {len(player.get('items', []))}")
                return True
            else:
                error = response.get('errorMsg', 'Unknown error')
                print(f"[-] Login failed: {error}")
                return False
                
        except Exception as e:
            print(f"[-] Login error: {e}")
            import traceback
            traceback.print_exc()
            return False
    
    def _send_command(self, cmd: str, data: Dict) -> None:
        """Send AMF3 command"""
        payload = {"cmd": cmd, "data": data}
        amf_data = self.encoder.encode(payload)
        
        # Packet format: 4-byte length + AMF data
        packet = struct.pack(">I", len(amf_data)) + amf_data
        self.socket.sendall(packet)
        
    def _receive_response(self, timeout: float = 10.0) -> Optional[Dict]:
        """Receive and decode AMF3 response"""
        try:
            self.socket.settimeout(timeout)
            
            # Read 4-byte length prefix
            length_data = self._recv_exact(4)
            if not length_data:
                return None
                
            length = struct.unpack(">I", length_data)[0]
            
            if length > 10 * 1024 * 1024:  # 10MB sanity check
                print(f"[-] Response too large: {length}")
                return None
                
            # Read AMF data
            amf_data = self._recv_exact(length)
            if not amf_data:
                return None
                
            # Decode AMF3
            result = self.decoder.decode(amf_data)
            return self._to_serializable(result)
            
        except socket.timeout:
            return None
        except Exception as e:
            print(f"[-] Receive error: {e}")
            import traceback
            traceback.print_exc()
            return None
            
    def _recv_exact(self, size: int) -> Optional[bytes]:
        """Receive exact number of bytes"""
        data = b''
        while len(data) < size:
            try:
                chunk = self.socket.recv(min(8192, size - len(data)))
                if not chunk:
                    return None
                data += chunk
            except socket.timeout:
                if data:
                    continue
                return None
        return data
        
    def _to_serializable(self, obj: Any) -> Any:
        """Convert to JSON-serializable format"""
        if isinstance(obj, dict):
            return {k: self._to_serializable(v) for k, v in obj.items()}
        elif isinstance(obj, (list, tuple)):
            return [self._to_serializable(item) for item in obj]
        elif isinstance(obj, bytes):
            return obj.hex()
        elif hasattr(obj, '__dict__'):
            return {k: self._to_serializable(v) for k, v in obj.__dict__.items()}
        else:
            return obj
            
    def extract_additional_data(self) -> Dict[str, Any]:
        """Extract additional data beyond login response"""
        additional = {}
        
        # Get packages
        print("[*] Getting packages...")
        self._send_command("common.getPackageList", {})
        time.sleep(0.5)
        resp = self._receive_response(5)
        if resp:
            additional['packages'] = resp
            
        # Get package count
        self._send_command("common.getPackageNumber", {})
        time.sleep(0.5)
        resp = self._receive_response(5)
        if resp:
            additional['package_count'] = resp
            
        # Get zone info
        print("[*] Getting zone info...")
        self._send_command("common.zoneInfo", {})
        time.sleep(0.5)
        resp = self._receive_response(5)
        if resp:
            additional['zone_info'] = resp
            
        # Per-castle data
        for castle_id in self.castle_ids[:3]:  # Limit to first 3 for speed
            print(f"[*] Getting data for castle {castle_id}...")
            
            # Resource production
            self._send_command("interior.getResourceProduceData", {"castleId": castle_id})
            time.sleep(0.3)
            resp = self._receive_response(5)
            if resp:
                additional[f'resource_production_{castle_id}'] = resp
                
            # Injured troops
            self._send_command("army.getInjuredTroop", {"castleId": castle_id})
            time.sleep(0.3)
            resp = self._receive_response(5)
            if resp:
                additional[f'injured_troops_{castle_id}'] = resp
                
        return additional
    
    def save_dump(self, output_dir: str = "data/extractions") -> str:
        """Save extraction to files"""
        safe_email = self.email.replace('@', '_at_').replace('.', '_')
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        account_dir = Path(output_dir) / f"{safe_email}_{timestamp}"
        account_dir.mkdir(parents=True, exist_ok=True)
        
        print(f"\n[*] Saving to: {account_dir}")
        
        # Save login data (main dump)
        with open(account_dir / "login_data.json", 'w') as f:
            json.dump(self.login_data, f, indent=2, default=str)
        print("[+] Saved login_data.json")
        
        # Extract and save additional data
        additional = self.extract_additional_data()
        with open(account_dir / "additional_data.json", 'w') as f:
            json.dump(additional, f, indent=2, default=str)
        print("[+] Saved additional_data.json")
        
        # Generate summary
        self._generate_summary(account_dir)
        
        return str(account_dir)
        
    def _generate_summary(self, output_dir: Path):
        """Generate summary file"""
        player = self.login_data.get('player', {})
        player_info = player.get('playerInfo', {})
        castles = player.get('castles', [])
        items = player.get('items', [])
        
        lines = [
            "="*60,
            "EVONY ACCOUNT EXTRACTION SUMMARY",
            "="*60,
            f"Email: {self.email}",
            f"Player Name: {self.player_name}",
            f"Server: {self.server}",
            f"Extracted: {datetime.now().isoformat()}",
            "",
        ]
        
        # Account age
        create_time = player_info.get('createrTime', 0)
        if create_time:
            create_date = datetime.fromtimestamp(create_time / 1000)
            days = (datetime.now() - create_date).days
            lines.append(f"Account Created: {create_date.strftime('%Y-%m-%d')} ({days} days ago)")
            
        lines.extend([
            f"Honor: {player_info.get('honor', 0):,}",
            f"Prestige: {player_info.get('prestige', 0):,}",
            f"Ranking: #{player_info.get('ranking', 'N/A')}",
            f"Alliance: {player_info.get('alliance', 'None')} ({player_info.get('allianceLevel', '')})",
            "",
            f"CITIES: {len(castles)}",
            f"ITEMS: {len(items)} unique types",
            "",
        ])
        
        # Calculate totals
        total_troops = {}
        for castle in castles:
            troop = castle.get('troop', {})
            for t, c in troop.items():
                total_troops[t] = total_troops.get(t, 0) + int(c or 0)
                
        lines.append("TOTAL TROOPS:")
        for t, c in sorted(total_troops.items()):
            if c > 0:
                lines.append(f"  {t}: {c:,.0f}")
                
        with open(output_dir / "SUMMARY.txt", 'w') as f:
            f.write('\n'.join(lines))
        print("[+] Saved SUMMARY.txt")
        
    def disconnect(self):
        """Disconnect from server"""
        if self.socket:
            try:
                self.socket.close()
            except:
                pass
        self.connected = False
        self.logged_in = False
        print("[*] Disconnected")
        
    def full_extraction(self) -> Optional[str]:
        """Complete extraction workflow"""
        try:
            if not self.connect():
                return None
                
            if not self.login():
                return None
                
            return self.save_dump()
            
        finally:
            self.disconnect()


def test_extraction():
    """Test with Borg account"""
    email = "Tarasdbe@yahoo.com"
    password = "bojangles5"
    
    print("="*60)
    print("ROBUST EVONY DATA EXTRACTOR")
    print("="*60)
    
    extractor = RobustExtractor(email, password, 'cc2')
    output = extractor.full_extraction()
    
    if output:
        print(f"\n[SUCCESS] Extraction complete!")
        print(f"[SUCCESS] Output: {output}")
    else:
        print("\n[FAILED] Extraction failed")
        
    return output


if __name__ == "__main__":
    test_extraction()
