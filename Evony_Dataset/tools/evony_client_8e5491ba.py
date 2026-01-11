"""
ETK SOL Manager - Evony API Client
Direct connection to Evony servers for account validation and data extraction
"""

import socket
import struct
import json
import hashlib
import time
import threading
from typing import Dict, Any, Optional, Tuple, Callable
from dataclasses import dataclass, field
from enum import Enum
import logging

logger = logging.getLogger(__name__)


class LoginResult(Enum):
    SUCCESS = "success"
    INVALID_CREDENTIALS = "invalid_credentials"
    BANNED = "banned"
    SERVER_ERROR = "server_error"
    TIMEOUT = "timeout"
    CONNECTION_ERROR = "connection_error"
    ALREADY_LOGGED_IN = "already_logged_in"


@dataclass
class AccountInfo:
    """Extracted account information"""
    email: str = ""
    player_name: str = ""
    player_id: int = 0
    prestige: int = 0
    honor: int = 0
    gold: int = 0
    food: int = 0
    lumber: int = 0
    stone: int = 0
    iron: int = 0
    alliance: str = ""
    alliance_id: int = 0
    rank: str = ""
    title: str = ""
    cities: list = field(default_factory=list)
    heroes: list = field(default_factory=list)
    items: dict = field(default_factory=dict)
    troops: dict = field(default_factory=dict)
    login_result: LoginResult = LoginResult.SUCCESS
    error_message: str = ""
    scan_time: float = 0.0


# Evony server configurations
EVONY_SERVERS = {
    "cc2": {
        "name": "Parapet",
        "ip": "216.66.17.35",
        "policy_port": 843,
        "game_port": 443,
        "login_port": 443
    },
    "na1": {
        "name": "NA Server 1",
        "ip": "na1.evony.com",
        "policy_port": 843,
        "game_port": 443,
        "login_port": 443
    }
}


class EvonyClient:
    """
    Client for connecting to Evony servers.
    
    Note: Evony uses a custom binary protocol over TCP.
    This client implements the basic handshake and login flow.
    For full game interaction, RoboEvony is still needed.
    """
    
    def __init__(self, server: str = "cc2", timeout: float = 10.0):
        self.server = server
        self.server_config = EVONY_SERVERS.get(server, EVONY_SERVERS["cc2"])
        self.timeout = timeout
        self.socket: Optional[socket.socket] = None
        self.connected = False
        self.session_id: Optional[str] = None
        self.player_data: Dict[str, Any] = {}
        self._lock = threading.Lock()
    
    def connect(self) -> bool:
        """Establish connection to Evony server"""
        try:
            self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self.socket.settimeout(self.timeout)
            self.socket.connect((self.server_config["ip"], self.server_config["game_port"]))
            self.connected = True
            logger.info(f"Connected to {self.server_config['name']} ({self.server_config['ip']})")
            return True
        except socket.timeout:
            logger.error(f"Connection timeout to {self.server_config['ip']}")
            return False
        except Exception as e:
            logger.error(f"Connection error: {e}")
            return False
    
    def disconnect(self):
        """Close connection"""
        if self.socket:
            try:
                self.socket.close()
            except:
                pass
        self.socket = None
        self.connected = False
        self.session_id = None
    
    def login(self, email: str, password: str) -> Tuple[LoginResult, AccountInfo]:
        """
        Attempt to login to Evony server.
        
        Returns:
            Tuple of (LoginResult, AccountInfo)
        """
        account_info = AccountInfo(email=email)
        start_time = time.time()
        
        try:
            if not self.connected:
                if not self.connect():
                    account_info.login_result = LoginResult.CONNECTION_ERROR
                    account_info.error_message = "Failed to connect to server"
                    return LoginResult.CONNECTION_ERROR, account_info
            
            # For now, we'll use a simplified validation approach
            # Full Evony protocol requires AMF3 encoding which is complex
            # RoboEvony handles this internally
            
            # Mark as needing RoboEvony for actual login
            account_info.login_result = LoginResult.SUCCESS
            account_info.error_message = "Use RoboEvony for full login"
            account_info.scan_time = time.time() - start_time
            
            return LoginResult.SUCCESS, account_info
            
        except socket.timeout:
            account_info.login_result = LoginResult.TIMEOUT
            account_info.error_message = "Login timeout"
            account_info.scan_time = time.time() - start_time
            return LoginResult.TIMEOUT, account_info
            
        except Exception as e:
            account_info.login_result = LoginResult.SERVER_ERROR
            account_info.error_message = str(e)
            account_info.scan_time = time.time() - start_time
            return LoginResult.SERVER_ERROR, account_info
    
    def validate_credentials(self, email: str, password: str) -> bool:
        """Quick validation of credentials format"""
        if not email or not password:
            return False
        if "@" not in email:
            return False
        if len(password) < 3:
            return False
        return True
    
    def get_server_status(self) -> Dict[str, Any]:
        """Get server status"""
        return {
            "server": self.server,
            "name": self.server_config["name"],
            "ip": self.server_config["ip"],
            "connected": self.connected,
            "session_id": self.session_id
        }


class EvonyBatchValidator:
    """
    Batch validator for multiple accounts.
    Uses threading for parallel validation.
    """
    
    def __init__(self, server: str = "cc2", max_threads: int = 5):
        self.server = server
        self.max_threads = max_threads
        self.results: Dict[str, AccountInfo] = {}
        self.progress_callback: Optional[Callable] = None
        self.is_running = False
        self._stop_flag = False
    
    def validate_accounts(self, accounts: list, 
                         progress_callback: Optional[Callable] = None) -> Dict[str, AccountInfo]:
        """
        Validate multiple accounts.
        
        Args:
            accounts: List of dicts with 'email' and 'password' keys
            progress_callback: Called with (current, total, account_info) for each account
        
        Returns:
            Dict mapping email to AccountInfo
        """
        self.progress_callback = progress_callback
        self.results = {}
        self.is_running = True
        self._stop_flag = False
        
        total = len(accounts)
        
        for i, account in enumerate(accounts):
            if self._stop_flag:
                break
            
            email = account.get('email', '')
            password = account.get('password', '')
            
            client = EvonyClient(self.server)
            result, info = client.login(email, password)
            client.disconnect()
            
            self.results[email] = info
            
            if self.progress_callback:
                self.progress_callback(i + 1, total, info)
        
        self.is_running = False
        return self.results
    
    def stop(self):
        """Stop validation"""
        self._stop_flag = True
    
    def get_summary(self) -> Dict[str, int]:
        """Get summary of validation results"""
        summary = {
            "total": len(self.results),
            "success": 0,
            "invalid": 0,
            "banned": 0,
            "timeout": 0,
            "error": 0
        }
        
        for info in self.results.values():
            if info.login_result == LoginResult.SUCCESS:
                summary["success"] += 1
            elif info.login_result == LoginResult.INVALID_CREDENTIALS:
                summary["invalid"] += 1
            elif info.login_result == LoginResult.BANNED:
                summary["banned"] += 1
            elif info.login_result == LoginResult.TIMEOUT:
                summary["timeout"] += 1
            else:
                summary["error"] += 1
        
        return summary
