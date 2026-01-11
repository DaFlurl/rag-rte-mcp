"""
AMF Command Sender - Direct Game Commands Using Extracted Keys

Sends game commands directly to Evony servers using AMF protocol
and extracted encryption keys. Full game control without Flash client.
"""

import logging
import struct
import hashlib
import time
import socket
import ssl
from dataclasses import dataclass, field
from enum import IntEnum
from typing import Dict, Optional, List, Any, Tuple, Callable
import threading
from queue import Queue

logger = logging.getLogger(__name__)


class GameCommand(IntEnum):
    """Evony game command IDs (from Commands.as)"""
    # Login/Session
    LOGIN = 0x1001
    LOGOUT = 0x1002
    HEARTBEAT = 0x1003
    GET_PLAYER_INFO = 0x1010
    
    # City Management
    GET_CITY_INFO = 0x2001
    GET_ALL_CITIES = 0x2002
    SET_CITY_NAME = 0x2010
    MOVE_CITY = 0x2020
    
    # Building
    BUILD = 0x3001
    UPGRADE = 0x3002
    DEMOLISH = 0x3003
    CANCEL_BUILD = 0x3004
    SPEED_UP_BUILD = 0x3005
    
    # Troops
    TRAIN = 0x4001
    CANCEL_TRAIN = 0x4002
    SPEED_UP_TRAIN = 0x4003
    DISBAND = 0x4004
    HEAL = 0x4005
    
    # Army/March
    MARCH = 0x5001
    RECALL = 0x5002
    SPEED_UP_MARCH = 0x5003
    GET_MARCHES = 0x5010
    
    # Attack Types
    ATTACK_NPC = 0x5101
    ATTACK_PLAYER = 0x5102
    SCOUT = 0x5103
    TRANSPORT = 0x5104
    REINFORCE = 0x5105
    
    # Resources
    COLLECT = 0x6001
    TRADE = 0x6002
    USE_ITEM = 0x6003
    SELL_ITEM = 0x6004
    
    # Heroes
    HIRE_HERO = 0x7001
    FIRE_HERO = 0x7002
    TRAIN_HERO = 0x7003
    EQUIP_HERO = 0x7004
    ASSIGN_HERO = 0x7005
    GET_HEROES = 0x7010
    
    # Research
    RESEARCH = 0x8001
    CANCEL_RESEARCH = 0x8002
    SPEED_UP_RESEARCH = 0x8003
    
    # Alliance
    GET_ALLIANCE = 0x9001
    JOIN_ALLIANCE = 0x9002
    LEAVE_ALLIANCE = 0x9003
    DONATE = 0x9004
    
    # Chat
    CHAT = 0xA001
    MAIL_SEND = 0xA002
    MAIL_READ = 0xA003
    MAIL_DELETE = 0xA004
    
    # Map
    GET_MAP = 0xB001
    SCAN_MAP = 0xB002
    GET_MAP_TILE = 0xB003
    
    # Quest
    GET_QUESTS = 0xC001
    ACCEPT_QUEST = 0xC002
    COMPLETE_QUEST = 0xC003
    CLAIM_REWARD = 0xC004
    
    # Events
    WHEEL_SPIN = 0xD001
    OPEN_BOX = 0xD002
    CLAIM_EVENT = 0xD003


@dataclass
class CommandResult:
    """Result of a command execution"""
    success: bool
    command_id: int
    response_code: int = 0
    data: Dict = field(default_factory=dict)
    error: Optional[str] = None
    latency_ms: float = 0.0


@dataclass
class ServerConfig:
    """Server connection configuration"""
    host: str
    port: int = 443
    server_id: str = ""
    use_ssl: bool = True


class AMFCommander:
    """
    Direct AMF command sender with encryption support.
    
    Features:
    - Send any game command directly
    - Automatic encryption/decryption
    - Session management
    - Rate limiting
    - Response parsing
    """
    
    # Extracted encryption keys
    KEYS = {
        'api': b'9f758e2deccbe6244f734371b9642eda',
        'token': b'IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}',
        'action': b'TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}',
        'game': b'EvonyGameKey2009',
        'network': b'EvonyNetKey2009',
        'xor': 0xAA,
    }
    
    SALTS = {
        'password': b'evony_salt_2010',
        'session': b'evony_session_2010',
        'game': b'evony_game_2010',
    }
    
    def __init__(self, server_config: Optional[ServerConfig] = None):
        self.server = server_config
        self.socket: Optional[socket.socket] = None
        self.session_id: Optional[str] = None
        self.player_id: Optional[int] = None
        
        # Request tracking
        self._request_id = 0
        self._pending: Dict[int, Queue] = {}
        
        # Rate limiting
        self._last_command_time = 0.0
        self._min_command_interval = 0.5  # seconds
        
        # Callbacks
        self._on_response: Optional[Callable] = None
        self._on_disconnect: Optional[Callable] = None
        
        # Lock
        self._lock = threading.RLock()
        
        # Response handler thread
        self._receiver_thread: Optional[threading.Thread] = None
        self._running = False
        
    def connect(self, server: ServerConfig) -> bool:
        """Connect to game server"""
        self.server = server
        
        try:
            # Create socket
            raw_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            raw_socket.settimeout(30)
            
            if server.use_ssl:
                context = ssl.SSLContext(ssl.PROTOCOL_TLS_CLIENT)
                context.check_hostname = False
                context.verify_mode = ssl.CERT_NONE
                context.minimum_version = ssl.TLSVersion.TLSv1_2
                context.maximum_version = ssl.TLSVersion.TLSv1_2
                self.socket = context.wrap_socket(raw_socket)
            else:
                self.socket = raw_socket
                
            self.socket.connect((server.host, int(server.port)))
            
            # Start receiver thread
            self._running = True
            self._receiver_thread = threading.Thread(
                target=self._receive_loop,
                daemon=True,
            )
            self._receiver_thread.start()
            
            logger.info(f"Connected to {server.host}:{server.port}")
            return True
            
        except Exception as e:
            logger.error(f"Connection failed: {e}")
            return False
            
    def disconnect(self):
        """Disconnect from server"""
        self._running = False
        if self.socket:
            try:
                self.socket.close()
            except:
                pass
        self.socket = None
        self.session_id = None
        
    def login(self, username: str, password: str) -> CommandResult:
        """Login to game server"""
        # Hash password with salt
        password_hash = self._hash_password(password, username)
        
        return self.send_command(GameCommand.LOGIN, {
            "username": username,
            "password": password_hash,
            "server": self.server.server_id if self.server else "",
            "version": "1.0.0",
            "platform": "flash",
        })
        
    def send_command(self, command: GameCommand, params: Dict = None,
                    timeout: float = 10.0) -> CommandResult:
        """Send a command and wait for response"""
        with self._lock:
            # Rate limiting
            elapsed = time.time() - self._last_command_time
            if elapsed < self._min_command_interval:
                time.sleep(self._min_command_interval - elapsed)
                
            self._last_command_time = time.time()
            
            # Generate request ID
            self._request_id += 1
            request_id = self._request_id
            
            # Create response queue
            response_queue = Queue()
            self._pending[request_id] = response_queue
            
            try:
                # Build and send packet
                packet = self._build_packet(request_id, command, params or {})
                start_time = time.time()
                
                self.socket.sendall(packet)
                
                # Wait for response
                try:
                    result = response_queue.get(timeout=timeout)
                    result.latency_ms = (time.time() - start_time) * 1000
                    return result
                except:
                    return CommandResult(
                        success=False,
                        command_id=command,
                        error="Timeout waiting for response",
                    )
                    
            finally:
                del self._pending[request_id]
                
    def send_async(self, command: GameCommand, params: Dict = None,
                  callback: Callable = None):
        """Send command asynchronously"""
        def _async_send():
            result = self.send_command(command, params)
            if callback:
                callback(result)
                
        thread = threading.Thread(target=_async_send, daemon=True)
        thread.start()
        
    # ========== High-Level Commands ==========
    
    def get_city_info(self, city_id: int) -> CommandResult:
        """Get city information"""
        return self.send_command(GameCommand.GET_CITY_INFO, {"cityId": city_id})
        
    def train_troops(self, city_id: int, troop_type: str, count: int) -> CommandResult:
        """Train troops"""
        return self.send_command(GameCommand.TRAIN, {
            "cityId": city_id,
            "troopType": troop_type,
            "count": count,
        })
        
    def attack_npc(self, city_id: int, x: int, y: int, 
                   hero_id: int, troops: Dict[str, int]) -> CommandResult:
        """Attack NPC"""
        return self.send_command(GameCommand.ATTACK_NPC, {
            "cityId": city_id,
            "targetX": x,
            "targetY": y,
            "heroId": hero_id,
            "troops": troops,
        })
        
    def attack_player(self, city_id: int, x: int, y: int,
                      hero_id: int, troops: Dict[str, int]) -> CommandResult:
        """Attack player"""
        return self.send_command(GameCommand.ATTACK_PLAYER, {
            "cityId": city_id,
            "targetX": x,
            "targetY": y,
            "heroId": hero_id,
            "troops": troops,
        })
        
    def scout(self, city_id: int, x: int, y: int, scouts: int = 1) -> CommandResult:
        """Send scouts"""
        return self.send_command(GameCommand.SCOUT, {
            "cityId": city_id,
            "targetX": x,
            "targetY": y,
            "scouts": scouts,
        })
        
    def transport(self, city_id: int, x: int, y: int,
                  resources: Dict[str, int]) -> CommandResult:
        """Send transport"""
        return self.send_command(GameCommand.TRANSPORT, {
            "cityId": city_id,
            "targetX": x,
            "targetY": y,
            "resources": resources,
        })
        
    def collect_resources(self, city_id: int) -> CommandResult:
        """Collect resources"""
        return self.send_command(GameCommand.COLLECT, {"cityId": city_id})
        
    def build(self, city_id: int, building_type: str, position: int) -> CommandResult:
        """Build structure"""
        return self.send_command(GameCommand.BUILD, {
            "cityId": city_id,
            "buildingType": building_type,
            "position": position,
        })
        
    def upgrade(self, city_id: int, building_id: int) -> CommandResult:
        """Upgrade building"""
        return self.send_command(GameCommand.UPGRADE, {
            "cityId": city_id,
            "buildingId": building_id,
        })
        
    def research(self, city_id: int, tech_type: str) -> CommandResult:
        """Research technology"""
        return self.send_command(GameCommand.RESEARCH, {
            "cityId": city_id,
            "techType": tech_type,
        })
        
    def use_item(self, item_id: int, count: int = 1) -> CommandResult:
        """Use item"""
        return self.send_command(GameCommand.USE_ITEM, {
            "itemId": item_id,
            "count": count,
        })
        
    def spin_wheel(self, wheel_type: str = "normal") -> CommandResult:
        """Spin wheel event"""
        return self.send_command(GameCommand.WHEEL_SPIN, {"wheelType": wheel_type})
        
    def open_box(self, box_type: str) -> CommandResult:
        """Open box/chest"""
        return self.send_command(GameCommand.OPEN_BOX, {"boxType": box_type})
        
    def chat(self, channel: str, message: str) -> CommandResult:
        """Send chat message"""
        return self.send_command(GameCommand.CHAT, {
            "channel": channel,
            "message": message,
        })
        
    def scan_map(self, center_x: int, center_y: int, radius: int = 5) -> CommandResult:
        """Scan map area"""
        return self.send_command(GameCommand.SCAN_MAP, {
            "centerX": center_x,
            "centerY": center_y,
            "radius": radius,
        })
        
    def get_quests(self) -> CommandResult:
        """Get available quests"""
        return self.send_command(GameCommand.GET_QUESTS, {})
        
    def complete_quest(self, quest_id: int) -> CommandResult:
        """Complete/claim quest"""
        return self.send_command(GameCommand.COMPLETE_QUEST, {"questId": quest_id})
        
    # ========== Private Methods ==========
    
    def _build_packet(self, request_id: int, command: GameCommand, 
                      params: Dict) -> bytes:
        """Build encrypted packet"""
        # Build payload
        payload = self._encode_amf({
            "requestId": request_id,
            "command": int(command),
            "params": params,
            "session": self.session_id,
            "timestamp": int(time.time() * 1000),
        })
        
        # Encrypt payload
        encrypted = self._encrypt(payload)
        
        # Build packet header
        # Format: [magic(2)] [length(4)] [command(2)] [encrypted_data]
        header = struct.pack(">HI", 0x4556, len(encrypted) + 2)  # 0x4556 = 'EV'
        header += struct.pack(">H", int(command))
        
        return header + encrypted
        
    def _encode_amf(self, data: Any) -> bytes:
        """Encode data to AMF format"""
        # Simplified AMF encoding - use real AMF codec in production
        import json
        json_str = json.dumps(data)
        return json_str.encode('utf-8')
        
    def _decode_amf(self, data: bytes) -> Any:
        """Decode AMF data"""
        import json
        try:
            return json.loads(data.decode('utf-8'))
        except:
            return {}
            
    def _encrypt(self, data: bytes) -> bytes:
        """Encrypt data using XOR"""
        xor_key = self.KEYS['xor']
        return bytes(b ^ xor_key for b in data)
        
    def _decrypt(self, data: bytes) -> bytes:
        """Decrypt data using XOR"""
        return self._encrypt(data)  # XOR is symmetric
        
    def _hash_password(self, password: str, username: str) -> str:
        """Hash password with salt"""
        salt = self.SALTS['password']
        data = salt + password.encode('utf-8') + username.encode('utf-8')
        return hashlib.md5(data).hexdigest()
        
    def _receive_loop(self):
        """Receive responses from server"""
        buffer = b""
        
        while self._running and self.socket:
            try:
                chunk = self.socket.recv(4096)
                if not chunk:
                    break
                    
                buffer += chunk
                
                # Process complete packets
                while len(buffer) >= 8:  # Minimum header size
                    # Parse header
                    magic = struct.unpack(">H", buffer[0:2])[0]
                    if magic != 0x4556:  # 'EV' magic bytes
                        buffer = buffer[1:]  # Skip bad byte
                        continue
                        
                    length = struct.unpack(">I", buffer[2:6])[0]
                    
                    if len(buffer) < 6 + length:
                        break  # Wait for more data
                        
                    # Extract packet
                    packet_data = buffer[6:6+length]
                    buffer = buffer[6+length:]
                    
                    # Process packet
                    self._handle_packet(packet_data)
                    
            except socket.timeout:
                continue
            except Exception as e:
                logger.error(f"Receive error: {e}")
                break
                
        if self._on_disconnect:
            self._on_disconnect()
            
    def _handle_packet(self, data: bytes):
        """Handle received packet"""
        try:
            # Parse command ID
            command_id = struct.unpack(">H", data[0:2])[0]
            
            # Decrypt payload
            encrypted = data[2:]
            decrypted = self._decrypt(encrypted)
            
            # Decode AMF
            response = self._decode_amf(decrypted)
            
            # Get request ID
            request_id = response.get("requestId", 0)
            
            # Build result
            result = CommandResult(
                success=response.get("ok", False),
                command_id=command_id,
                response_code=response.get("code", 0),
                data=response.get("data", {}),
                error=response.get("error"),
            )
            
            # Handle login response
            if command_id == GameCommand.LOGIN and result.success:
                self.session_id = response.get("sessionId")
                self.player_id = response.get("playerId")
                
            # Notify waiting request
            if request_id in self._pending:
                self._pending[request_id].put(result)
                
            # Callback
            if self._on_response:
                self._on_response(result)
                
        except Exception as e:
            logger.error(f"Packet handling error: {e}")
            
    def get_statistics(self) -> Dict:
        """Get commander statistics"""
        return {
            "connected": self.socket is not None,
            "session_id": self.session_id,
            "player_id": self.player_id,
            "pending_requests": len(self._pending),
            "total_requests": self._request_id,
        }


# Singleton
_commander: Optional[AMFCommander] = None

def get_amf_commander() -> AMFCommander:
    """Get singleton AMF commander"""
    global _commander
    if _commander is None:
        _commander = AMFCommander()
    return _commander
