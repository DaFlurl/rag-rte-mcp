"""
Authentication Manager - Token Validation and Session Management

Handles all authentication/authorization for game connections:
- Login flow with password hashing
- Token generation and validation
- Session management and refresh
- Multi-account authentication
- Token persistence and rotation
"""

import logging
import hashlib
import hmac
import time
import json
import secrets
import base64
from dataclasses import dataclass, field
from enum import Enum
from typing import Dict, Optional, List, Any, Tuple, Callable
from pathlib import Path
import threading

logger = logging.getLogger(__name__)


class AuthState(Enum):
    """Authentication state"""
    DISCONNECTED = "disconnected"
    CONNECTING = "connecting"
    AUTHENTICATING = "authenticating"
    AUTHENTICATED = "authenticated"
    REFRESHING = "refreshing"
    EXPIRED = "expired"
    FAILED = "failed"


class TokenType(Enum):
    """Types of authentication tokens"""
    SESSION = "session"
    REFRESH = "refresh"
    API = "api"
    GAME = "game"
    ALLIANCE = "alliance"


@dataclass
class AuthToken:
    """Authentication token with metadata"""
    token_id: str
    token_type: TokenType
    token_value: str
    player_id: int
    server_id: int
    created_at: float
    expires_at: float
    refresh_token: Optional[str] = None
    metadata: Dict[str, Any] = field(default_factory=dict)
    
    @property
    def is_expired(self) -> bool:
        return time.time() > self.expires_at
        
    @property
    def time_remaining(self) -> float:
        return max(0, self.expires_at - time.time())
        
    def to_dict(self) -> Dict:
        return {
            "token_id": self.token_id,
            "token_type": self.token_type.value,
            "token_value": self.token_value[:8] + "...",  # Partial for security
            "player_id": self.player_id,
            "server_id": self.server_id,
            "created_at": self.created_at,
            "expires_at": self.expires_at,
            "is_expired": self.is_expired,
            "time_remaining": self.time_remaining,
        }


@dataclass
class AuthSession:
    """Active authentication session"""
    session_id: str
    player_id: int
    server_id: int
    username: str
    state: AuthState
    tokens: Dict[TokenType, AuthToken] = field(default_factory=dict)
    login_time: float = 0.0
    last_activity: float = 0.0
    request_count: int = 0
    metadata: Dict[str, Any] = field(default_factory=dict)
    
    def to_dict(self) -> Dict:
        return {
            "session_id": self.session_id,
            "player_id": self.player_id,
            "server_id": self.server_id,
            "username": self.username,
            "state": self.state.value,
            "tokens": {k.value: v.to_dict() for k, v in self.tokens.items()},
            "login_time": self.login_time,
            "last_activity": self.last_activity,
            "request_count": self.request_count,
        }


@dataclass
class LoginCredentials:
    """Login credentials for an account"""
    username: str
    password: str
    server_id: int
    remember: bool = True
    two_factor_code: Optional[str] = None


class AuthManager:
    """
    Manages authentication for game connections.
    
    Features:
    - Password hashing with extracted salts
    - Token generation matching game protocol
    - Session management across accounts
    - Token refresh and rotation
    - Persistence for reconnection
    """
    
    # Default token expiry times (seconds)
    TOKEN_EXPIRY = {
        TokenType.SESSION: 3600,      # 1 hour
        TokenType.REFRESH: 604800,    # 7 days
        TokenType.API: 86400,         # 24 hours
        TokenType.GAME: 7200,         # 2 hours
        TokenType.ALLIANCE: 3600,     # 1 hour
    }
    
    def __init__(self, storage_path: Optional[str] = None):
        self.storage_path = Path(storage_path) if storage_path else Path("data/auth")
        self.storage_path.mkdir(parents=True, exist_ok=True)
        
        # Active sessions
        self._sessions: Dict[str, AuthSession] = {}
        self._by_player: Dict[int, str] = {}  # player_id -> session_id
        
        # Callbacks
        self._on_auth_callbacks: List[Callable[[AuthSession], None]] = []
        self._on_expire_callbacks: List[Callable[[AuthSession], None]] = []
        
        # Lock
        self._lock = threading.RLock()
        
        # Key vault integration
        self._key_vault = None
        
        # Background token refresh
        self._refresh_thread: Optional[threading.Thread] = None
        self._shutdown_event = threading.Event()
        
        # Load persisted sessions
        self._load_sessions()
        
    def login(self, credentials: LoginCredentials) -> Tuple[bool, Optional[AuthSession]]:
        """Authenticate with credentials"""
        with self._lock:
            try:
                # Generate session ID
                session_id = self._generate_session_id(credentials.username, credentials.server_id)
                
                # Check for existing session
                if session_id in self._sessions:
                    session = self._sessions[session_id]
                    if session.state == AuthState.AUTHENTICATED:
                        return True, session
                        
                # Create new session
                session = AuthSession(
                    session_id=session_id,
                    player_id=0,  # Will be set from response
                    server_id=credentials.server_id,
                    username=credentials.username,
                    state=AuthState.CONNECTING,
                )
                
                self._sessions[session_id] = session
                
                # Hash password
                password_hash = self._hash_password(credentials.password, credentials.username)
                
                # Build login request
                login_request = self._build_login_request(credentials, password_hash)
                
                # In real implementation, this would send to server
                # For now, simulate successful login
                session.state = AuthState.AUTHENTICATING
                
                # Generate tokens
                tokens = self._generate_tokens(session, login_request)
                session.tokens = tokens
                
                # Update state
                session.state = AuthState.AUTHENTICATED
                session.login_time = time.time()
                session.last_activity = time.time()
                
                # Store by player ID
                if session.player_id:
                    self._by_player[session.player_id] = session_id
                    
                # Persist if remember
                if credentials.remember:
                    self._save_session(session)
                    
                # Notify callbacks
                for callback in self._on_auth_callbacks:
                    try:
                        callback(session)
                    except Exception as e:
                        logger.error(f"Auth callback error: {e}")
                        
                logger.info(f"Login successful: {credentials.username} on server {credentials.server_id}")
                return True, session
                
            except Exception as e:
                logger.error(f"Login failed: {e}")
                if session_id in self._sessions:
                    self._sessions[session_id].state = AuthState.FAILED
                return False, None
                
    def logout(self, session_id: str) -> bool:
        """Logout and invalidate session"""
        with self._lock:
            if session_id not in self._sessions:
                return False
                
            session = self._sessions[session_id]
            session.state = AuthState.DISCONNECTED
            session.tokens.clear()
            
            # Remove from player map
            if session.player_id in self._by_player:
                del self._by_player[session.player_id]
                
            # Remove persisted session
            self._delete_session(session_id)
            
            del self._sessions[session_id]
            
            logger.info(f"Logout: {session.username}")
            return True
            
    def refresh_token(self, session_id: str, token_type: TokenType = TokenType.SESSION) -> bool:
        """Refresh an expiring token"""
        with self._lock:
            if session_id not in self._sessions:
                return False
                
            session = self._sessions[session_id]
            
            if token_type not in session.tokens:
                return False
                
            old_token = session.tokens[token_type]
            
            # Check if we have a refresh token
            if not old_token.refresh_token:
                return False
                
            session.state = AuthState.REFRESHING
            
            # Generate new token
            new_token = self._generate_single_token(
                token_type,
                session.player_id,
                session.server_id,
            )
            
            session.tokens[token_type] = new_token
            session.state = AuthState.AUTHENTICATED
            session.last_activity = time.time()
            
            # Persist
            self._save_session(session)
            
            logger.info(f"Token refreshed: {token_type.value} for {session.username}")
            return True
            
    def validate_token(self, token_value: str, token_type: TokenType = TokenType.SESSION) -> Optional[AuthSession]:
        """Validate a token and return associated session"""
        with self._lock:
            for session in self._sessions.values():
                if token_type in session.tokens:
                    token = session.tokens[token_type]
                    if token.token_value == token_value and not token.is_expired:
                        session.last_activity = time.time()
                        return session
            return None
            
    def get_session(self, session_id: str) -> Optional[AuthSession]:
        """Get session by ID"""
        return self._sessions.get(session_id)
        
    def get_session_by_player(self, player_id: int) -> Optional[AuthSession]:
        """Get session by player ID"""
        session_id = self._by_player.get(player_id)
        if session_id:
            return self._sessions.get(session_id)
        return None
        
    def get_all_sessions(self) -> List[AuthSession]:
        """Get all active sessions"""
        return list(self._sessions.values())
        
    def get_token(self, session_id: str, token_type: TokenType = TokenType.SESSION) -> Optional[str]:
        """Get token value for a session"""
        session = self.get_session(session_id)
        if session and token_type in session.tokens:
            return session.tokens[token_type].token_value
        return None
        
    def on_authenticated(self, callback: Callable[[AuthSession], None]):
        """Register callback for successful authentication"""
        self._on_auth_callbacks.append(callback)
        
    def on_token_expired(self, callback: Callable[[AuthSession], None]):
        """Register callback for token expiration"""
        self._on_expire_callbacks.append(callback)
        
    def start_auto_refresh(self):
        """Start background token refresh thread"""
        if self._refresh_thread and self._refresh_thread.is_alive():
            return
            
        self._shutdown_event.clear()
        self._refresh_thread = threading.Thread(
            target=self._refresh_loop,
            name="AuthRefresh",
            daemon=True,
        )
        self._refresh_thread.start()
        
    def stop_auto_refresh(self):
        """Stop background token refresh"""
        self._shutdown_event.set()
        if self._refresh_thread:
            self._refresh_thread.join(timeout=2.0)
            
    def get_statistics(self) -> Dict:
        """Get authentication statistics"""
        with self._lock:
            authenticated = sum(1 for s in self._sessions.values() 
                              if s.state == AuthState.AUTHENTICATED)
            expired = sum(1 for s in self._sessions.values()
                        for t in s.tokens.values() if t.is_expired)
                        
            return {
                "total_sessions": len(self._sessions),
                "authenticated": authenticated,
                "expired_tokens": expired,
            }
            
    # ========== Private Methods ==========
    
    def _hash_password(self, password: str, username: str) -> str:
        """Hash password using game's algorithm"""
        # Try to get salt from key vault
        salt = b"evony_default_salt"
        
        if self._key_vault:
            from src.realtime.key_vault import KeyType
            key = self._key_vault.get_key_by_type(KeyType.SHA1_SALT)
            if key:
                salt = key.key_data
                
        # Evony uses SHA1(salt + password + username) typically
        data = salt + password.encode('utf-8') + username.encode('utf-8')
        hash_result = hashlib.sha1(data).hexdigest()
        
        return hash_result
        
    def _build_login_request(self, credentials: LoginCredentials, 
                            password_hash: str) -> Dict:
        """Build login request packet"""
        return {
            "cmd": "login",
            "username": credentials.username,
            "passwordHash": password_hash,
            "serverId": credentials.server_id,
            "clientVersion": "1.0.0",
            "platform": "flash",
            "timestamp": int(time.time() * 1000),
            "nonce": secrets.token_hex(16),
        }
        
    def _generate_tokens(self, session: AuthSession, 
                        login_response: Dict) -> Dict[TokenType, AuthToken]:
        """Generate all tokens for a session"""
        tokens = {}
        
        for token_type in [TokenType.SESSION, TokenType.GAME, TokenType.API]:
            tokens[token_type] = self._generate_single_token(
                token_type,
                session.player_id or 0,
                session.server_id,
            )
            
        return tokens
        
    def _generate_single_token(self, token_type: TokenType,
                               player_id: int, server_id: int) -> AuthToken:
        """Generate a single authentication token"""
        now = time.time()
        expiry = self.TOKEN_EXPIRY.get(token_type, 3600)
        
        # Generate token value
        token_data = f"{player_id}:{server_id}:{now}:{secrets.token_hex(16)}"
        token_value = base64.b64encode(
            hashlib.sha256(token_data.encode()).digest()
        ).decode()
        
        # Generate refresh token
        refresh_token = secrets.token_hex(32) if token_type == TokenType.SESSION else None
        
        return AuthToken(
            token_id=f"tok_{secrets.token_hex(8)}",
            token_type=token_type,
            token_value=token_value,
            player_id=player_id,
            server_id=server_id,
            created_at=now,
            expires_at=now + expiry,
            refresh_token=refresh_token,
        )
        
    def _generate_session_id(self, username: str, server_id: int) -> str:
        """Generate unique session ID"""
        data = f"{username}:{server_id}:{time.time()}"
        return hashlib.md5(data.encode()).hexdigest()[:16]
        
    def _refresh_loop(self):
        """Background loop to refresh expiring tokens"""
        while not self._shutdown_event.is_set():
            try:
                with self._lock:
                    for session in self._sessions.values():
                        if session.state != AuthState.AUTHENTICATED:
                            continue
                            
                        for token_type, token in session.tokens.items():
                            # Refresh if less than 10% time remaining
                            if token.time_remaining < self.TOKEN_EXPIRY[token_type] * 0.1:
                                self.refresh_token(session.session_id, token_type)
                                
                            # Check for expired
                            if token.is_expired:
                                for callback in self._on_expire_callbacks:
                                    try:
                                        callback(session)
                                    except:
                                        pass
                                        
            except Exception as e:
                logger.error(f"Refresh loop error: {e}")
                
            # Check every 60 seconds
            self._shutdown_event.wait(60)
            
    def _save_session(self, session: AuthSession):
        """Persist session to disk"""
        try:
            path = self.storage_path / f"{session.session_id}.json"
            with open(path, "w") as f:
                json.dump(session.to_dict(), f, indent=2)
        except Exception as e:
            logger.error(f"Failed to save session: {e}")
            
    def _delete_session(self, session_id: str):
        """Delete persisted session"""
        try:
            path = self.storage_path / f"{session_id}.json"
            if path.exists():
                path.unlink()
        except Exception as e:
            logger.error(f"Failed to delete session: {e}")
            
    def _load_sessions(self):
        """Load persisted sessions"""
        try:
            for path in self.storage_path.glob("*.json"):
                with open(path, "r") as f:
                    data = json.load(f)
                # Would reconstruct session from data
                # For now, skip as tokens would be expired
        except Exception as e:
            logger.error(f"Failed to load sessions: {e}")


# Singleton
_auth_manager: Optional[AuthManager] = None

def get_auth_manager() -> AuthManager:
    """Get singleton auth manager"""
    global _auth_manager
    if _auth_manager is None:
        _auth_manager = AuthManager()
    return _auth_manager
