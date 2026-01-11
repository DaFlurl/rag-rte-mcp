"""
Security Parameter Extractor - Extract Keys, Salts, and Tokens

Extracts security parameters from traffic and SWF files:
- Encryption keys (XOR, AES, Blowfish)
- Password hashing salts
- Session tokens
- Key rotation patterns
- Authentication flows
"""

import logging
import time
import json
import hashlib
import re
from dataclasses import dataclass, field
from enum import Enum
from typing import Dict, Optional, List, Any, Tuple, Set
from collections import defaultdict
import threading

logger = logging.getLogger(__name__)


class KeyRotationType(Enum):
    """Types of key rotation"""
    NONE = "none"
    TIME_BASED = "time_based"
    PACKET_COUNT = "packet_count"
    SERVER_INITIATED = "server_initiated"
    SESSION_BASED = "session_based"


class AuthFlowStep(Enum):
    """Steps in authentication flow"""
    INITIAL_REQUEST = "initial_request"
    CHALLENGE_RECEIVED = "challenge_received"
    RESPONSE_SENT = "response_sent"
    TOKEN_RECEIVED = "token_received"
    SESSION_ESTABLISHED = "session_established"


@dataclass
class KeyRotationEvent:
    """A key rotation event"""
    event_id: str
    timestamp: float
    old_key_id: str
    new_key_id: str
    rotation_type: KeyRotationType
    trigger: str = ""  # What triggered the rotation
    packets_since_last: int = 0
    time_since_last: float = 0.0
    
    def to_dict(self) -> Dict:
        return {
            "event_id": self.event_id,
            "timestamp": self.timestamp,
            "old_key_id": self.old_key_id,
            "new_key_id": self.new_key_id,
            "rotation_type": self.rotation_type.value,
            "trigger": self.trigger,
            "packets_since_last": self.packets_since_last,
            "time_since_last": self.time_since_last,
        }


@dataclass
class SecurityParams:
    """Security parameters for a session"""
    session_id: str
    
    # Keys
    xor_key: Optional[bytes] = None
    aes_key: Optional[bytes] = None
    blowfish_key: Optional[bytes] = None
    rsa_public: Optional[bytes] = None
    session_token: Optional[str] = None
    
    # Salts
    client_salt: Optional[bytes] = None
    server_salt: Optional[bytes] = None
    password_salt: Optional[bytes] = None
    
    # Hash algorithms
    hash_algorithm: str = "sha1"
    hash_iterations: int = 1
    
    # Rotation info
    key_rotation_type: KeyRotationType = KeyRotationType.NONE
    rotation_interval_packets: int = 0
    rotation_interval_seconds: float = 0.0
    last_rotation: float = 0.0
    rotation_events: List[KeyRotationEvent] = field(default_factory=list)
    
    # Timestamps
    extracted_at: float = field(default_factory=time.time)
    last_updated: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict:
        return {
            "session_id": self.session_id,
            "keys": {
                "xor": self.xor_key.hex() if self.xor_key else None,
                "aes": self.aes_key.hex() if self.aes_key else None,
                "blowfish": self.blowfish_key.hex() if self.blowfish_key else None,
                "rsa_public": self.rsa_public.hex() if self.rsa_public else None,
                "session_token": self.session_token,
            },
            "salts": {
                "client": self.client_salt.hex() if self.client_salt else None,
                "server": self.server_salt.hex() if self.server_salt else None,
                "password": self.password_salt.hex() if self.password_salt else None,
            },
            "hash": {
                "algorithm": self.hash_algorithm,
                "iterations": self.hash_iterations,
            },
            "rotation": {
                "type": self.key_rotation_type.value,
                "interval_packets": self.rotation_interval_packets,
                "interval_seconds": self.rotation_interval_seconds,
                "last_rotation": self.last_rotation,
                "events_count": len(self.rotation_events),
            },
            "timestamps": {
                "extracted_at": self.extracted_at,
                "last_updated": self.last_updated,
            },
        }


@dataclass
class AuthFlowCapture:
    """Captured authentication flow"""
    flow_id: str
    started_at: float
    steps: List[Dict] = field(default_factory=list)
    completed: bool = False
    success: bool = False
    
    # Extracted data
    client_hello: Optional[bytes] = None
    server_challenge: Optional[bytes] = None
    client_response: Optional[bytes] = None
    session_token: Optional[str] = None
    
    def add_step(self, step: AuthFlowStep, data: Dict):
        self.steps.append({
            "step": step.value,
            "timestamp": time.time(),
            "data": data,
        })
        
    def to_dict(self) -> Dict:
        return {
            "flow_id": self.flow_id,
            "started_at": self.started_at,
            "steps": self.steps,
            "completed": self.completed,
            "success": self.success,
        }


class SecurityExtractor:
    """
    Extracts security parameters from traffic.
    
    Features:
    - Key extraction from packets and SWF
    - Salt discovery from login flow
    - Key rotation pattern detection
    - Authentication flow analysis
    - Token extraction and tracking
    """
    
    # Known key patterns in SWF/packets
    KEY_PATTERNS = {
        "xor_header": bytes([0x5A, 0x3C]),
        "aes_header": bytes([0xAE, 0x5B]),
        "blowfish_header": bytes([0xBF, 0x00]),
        "token_pattern": re.compile(r'[a-fA-F0-9]{32,64}'),
    }
    
    # Typical key lengths
    KEY_LENGTHS = {
        "xor": [8, 16],
        "aes_128": [16],
        "aes_256": [32],
        "blowfish": [8, 16, 32, 56],
    }
    
    def __init__(self):
        self._sessions: Dict[str, SecurityParams] = {}
        self._auth_flows: Dict[str, AuthFlowCapture] = {}
        self._lock = threading.RLock()
        
        # Key rotation tracking
        self._packet_counts: Dict[str, int] = defaultdict(int)
        self._last_key_change: Dict[str, float] = {}
        
        # Pattern detection
        self._rotation_samples: List[Dict] = []
        
        # Statistics
        self._stats = defaultdict(int)
        
        # Event counter
        self._event_counter = 0
        
    def extract_from_packet(self, packet_data: bytes, 
                           session_id: str,
                           direction: str = "s2c") -> Optional[Dict]:
        """Extract security parameters from packet"""
        with self._lock:
            # Get or create session params
            if session_id not in self._sessions:
                self._sessions[session_id] = SecurityParams(session_id=session_id)
                
            params = self._sessions[session_id]
            extracted = {}
            
            # Track packet count for rotation detection
            self._packet_counts[session_id] += 1
            
            # Look for key material in packet
            if direction == "s2c":
                # Server responses may contain keys/tokens
                extracted.update(self._extract_from_response(packet_data, params))
                
            # Check for key rotation signals
            rotation = self._detect_key_rotation(packet_data, session_id)
            if rotation:
                extracted["rotation_detected"] = rotation.to_dict()
                params.rotation_events.append(rotation)
                
            params.last_updated = time.time()
            self._stats["packets_scanned"] += 1
            
            return extracted if extracted else None
            
    def extract_from_login(self, request_data: Dict, 
                          response_data: Dict,
                          session_id: str) -> SecurityParams:
        """Extract security parameters from login flow"""
        with self._lock:
            if session_id not in self._sessions:
                self._sessions[session_id] = SecurityParams(session_id=session_id)
                
            params = self._sessions[session_id]
            
            # Extract from request (client-side info)
            if "salt" in request_data:
                params.client_salt = self._to_bytes(request_data["salt"])
            if "hash" in request_data:
                params.hash_algorithm = request_data.get("hashAlg", "sha1")
                
            # Extract from response (server-side info)
            if "serverSalt" in response_data:
                params.server_salt = self._to_bytes(response_data["serverSalt"])
            if "sessionToken" in response_data or "token" in response_data:
                params.session_token = response_data.get("sessionToken") or response_data.get("token")
            if "key" in response_data:
                # Session key from server
                key_data = self._to_bytes(response_data["key"])
                if len(key_data) == 32:
                    params.aes_key = key_data
                elif len(key_data) == 16:
                    params.aes_key = key_data
                elif len(key_data) <= 8:
                    params.xor_key = key_data
                    
            params.last_updated = time.time()
            self._stats["logins_analyzed"] += 1
            
            return params
            
    def extract_from_swf(self, swf_data: bytes, 
                        source: str = "client") -> Dict[str, bytes]:
        """Extract keys from SWF file"""
        extracted = {}
        
        try:
            # Search for XOR key pattern
            xor_pos = swf_data.find(self.KEY_PATTERNS["xor_header"])
            if xor_pos != -1:
                for key_len in self.KEY_LENGTHS["xor"]:
                    candidate = swf_data[xor_pos:xor_pos + key_len]
                    if self._is_valid_key(candidate):
                        extracted["xor_key"] = candidate
                        break
                        
            # Search for AES key pattern
            aes_pos = swf_data.find(self.KEY_PATTERNS["aes_header"])
            if aes_pos != -1:
                for key_len in self.KEY_LENGTHS["aes_256"]:
                    candidate = swf_data[aes_pos:aes_pos + key_len]
                    if self._is_valid_key(candidate):
                        extracted["aes_key"] = candidate
                        break
                        
            # Search for Blowfish key
            bf_pos = swf_data.find(self.KEY_PATTERNS["blowfish_header"])
            if bf_pos != -1:
                for key_len in self.KEY_LENGTHS["blowfish"]:
                    candidate = swf_data[bf_pos:bf_pos + key_len]
                    if self._is_valid_key(candidate):
                        extracted["blowfish_key"] = candidate
                        break
                        
            # Search for high-entropy sequences (potential keys)
            potential_keys = self._find_high_entropy_sequences(swf_data)
            for i, key in enumerate(potential_keys[:5]):  # Top 5 candidates
                extracted[f"potential_key_{i}"] = key
                
            # Search for salt strings
            salt_pattern = re.compile(rb'salt["\s:=]+([a-zA-Z0-9+/=]{16,})')
            salt_matches = salt_pattern.findall(swf_data)
            for i, salt in enumerate(salt_matches[:3]):
                extracted[f"salt_{i}"] = salt
                
            self._stats["swf_analyzed"] += 1
            self._stats["keys_extracted"] += len(extracted)
            
        except Exception as e:
            logger.error(f"SWF extraction error: {e}")
            
        return extracted
        
    def analyze_rotation_pattern(self, session_id: str) -> Dict:
        """Analyze key rotation pattern for a session"""
        with self._lock:
            if session_id not in self._sessions:
                return {}
                
            params = self._sessions[session_id]
            events = params.rotation_events
            
            if len(events) < 2:
                return {"pattern": "insufficient_data", "events": len(events)}
                
            # Analyze time intervals
            time_intervals = []
            packet_intervals = []
            
            for i in range(1, len(events)):
                time_intervals.append(events[i].time_since_last)
                packet_intervals.append(events[i].packets_since_last)
                
            # Determine rotation type
            avg_time = sum(time_intervals) / len(time_intervals)
            avg_packets = sum(packet_intervals) / len(packet_intervals)
            
            time_variance = sum((t - avg_time) ** 2 for t in time_intervals) / len(time_intervals)
            packet_variance = sum((p - avg_packets) ** 2 for p in packet_intervals) / len(packet_intervals)
            
            # Low variance indicates consistent pattern
            if time_variance < avg_time * 0.1:
                rotation_type = KeyRotationType.TIME_BASED
                params.rotation_interval_seconds = avg_time
            elif packet_variance < avg_packets * 0.1:
                rotation_type = KeyRotationType.PACKET_COUNT
                params.rotation_interval_packets = int(avg_packets)
            else:
                rotation_type = KeyRotationType.SERVER_INITIATED
                
            params.key_rotation_type = rotation_type
            
            return {
                "pattern": rotation_type.value,
                "avg_time_interval": avg_time,
                "avg_packet_interval": avg_packets,
                "time_variance": time_variance,
                "packet_variance": packet_variance,
                "total_events": len(events),
            }
            
    def capture_auth_flow(self, flow_id: str) -> AuthFlowCapture:
        """Start capturing an authentication flow"""
        with self._lock:
            flow = AuthFlowCapture(
                flow_id=flow_id,
                started_at=time.time(),
            )
            self._auth_flows[flow_id] = flow
            return flow
            
    def add_auth_step(self, flow_id: str, step: AuthFlowStep, 
                      data: Dict, packet_data: Optional[bytes] = None):
        """Add a step to authentication flow capture"""
        with self._lock:
            if flow_id not in self._auth_flows:
                return
                
            flow = self._auth_flows[flow_id]
            flow.add_step(step, data)
            
            # Store raw packet data
            if packet_data:
                if step == AuthFlowStep.INITIAL_REQUEST:
                    flow.client_hello = packet_data
                elif step == AuthFlowStep.CHALLENGE_RECEIVED:
                    flow.server_challenge = packet_data
                elif step == AuthFlowStep.RESPONSE_SENT:
                    flow.client_response = packet_data
                    
            # Extract token if session established
            if step == AuthFlowStep.TOKEN_RECEIVED:
                flow.session_token = data.get("token")
                
            if step == AuthFlowStep.SESSION_ESTABLISHED:
                flow.completed = True
                flow.success = data.get("success", True)
                
    def get_session_params(self, session_id: str) -> Optional[SecurityParams]:
        """Get security parameters for a session"""
        return self._sessions.get(session_id)
        
    def get_all_sessions(self) -> Dict[str, SecurityParams]:
        """Get all tracked sessions"""
        return dict(self._sessions)
        
    def get_auth_flow(self, flow_id: str) -> Optional[AuthFlowCapture]:
        """Get authentication flow capture"""
        return self._auth_flows.get(flow_id)
        
    def get_statistics(self) -> Dict:
        """Get extractor statistics"""
        return {
            "tracked_sessions": len(self._sessions),
            "auth_flows_captured": len(self._auth_flows),
            **dict(self._stats),
        }
        
    def export_security_data(self, path: str):
        """Export all security data to JSON"""
        with self._lock:
            data = {
                "sessions": {k: v.to_dict() for k, v in self._sessions.items()},
                "auth_flows": {k: v.to_dict() for k, v in self._auth_flows.items()},
                "statistics": self.get_statistics(),
            }
            with open(path, "w") as f:
                json.dump(data, f, indent=2)
                
    # ========== Private Methods ==========
    
    def _extract_from_response(self, packet_data: bytes, 
                               params: SecurityParams) -> Dict:
        """Extract security info from server response"""
        extracted = {}
        
        # Look for token patterns
        try:
            text = packet_data.decode('utf-8', errors='ignore')
            tokens = self.KEY_PATTERNS["token_pattern"].findall(text)
            if tokens:
                extracted["tokens_found"] = tokens[:5]
                if len(tokens[0]) >= 32 and not params.session_token:
                    params.session_token = tokens[0]
        except:
            pass
            
        # Look for key material (high entropy sequences)
        if len(packet_data) > 16:
            for offset in range(0, min(len(packet_data) - 32, 100), 4):
                candidate = packet_data[offset:offset + 32]
                if self._is_valid_key(candidate):
                    extracted["potential_session_key"] = candidate.hex()
                    break
                    
        return extracted
        
    def _detect_key_rotation(self, packet_data: bytes, 
                            session_id: str) -> Optional[KeyRotationEvent]:
        """Detect key rotation from packet"""
        # Look for rotation signal patterns
        rotation_signals = [
            b"KEY_ROTATE",
            b"NEW_KEY",
            b"\xFF\xFE\x00\x01",  # Common rotation header
        ]
        
        for signal in rotation_signals:
            if signal in packet_data:
                self._event_counter += 1
                
                last_time = self._last_key_change.get(session_id, 0)
                current_time = time.time()
                
                event = KeyRotationEvent(
                    event_id=f"rot_{self._event_counter:06d}",
                    timestamp=current_time,
                    old_key_id=f"key_{session_id}_old",
                    new_key_id=f"key_{session_id}_new",
                    rotation_type=KeyRotationType.SERVER_INITIATED,
                    trigger=signal.decode('utf-8', errors='replace'),
                    packets_since_last=self._packet_counts[session_id],
                    time_since_last=current_time - last_time if last_time else 0,
                )
                
                self._last_key_change[session_id] = current_time
                self._packet_counts[session_id] = 0
                self._stats["rotations_detected"] += 1
                
                return event
                
        return None
        
    def _is_valid_key(self, data: bytes) -> bool:
        """Check if data looks like a valid key"""
        if len(data) < 8:
            return False
            
        # Check entropy
        entropy = self._calculate_entropy(data)
        if entropy < 6.0:  # Keys should have high entropy
            return False
            
        # Check for all zeros or all same byte
        if len(set(data)) < 4:
            return False
            
        return True
        
    def _calculate_entropy(self, data: bytes) -> float:
        """Calculate Shannon entropy"""
        if not data:
            return 0.0
            
        from collections import Counter
        import math
        
        counts = Counter(data)
        length = len(data)
        
        entropy = 0.0
        for count in counts.values():
            if count > 0:
                p = count / length
                entropy -= p * math.log2(p)
                
        return entropy
        
    def _find_high_entropy_sequences(self, data: bytes, 
                                     min_len: int = 16,
                                     max_len: int = 64) -> List[bytes]:
        """Find high-entropy byte sequences that might be keys"""
        candidates = []
        
        for length in [16, 32, 64]:
            for i in range(0, len(data) - length, 4):
                seq = data[i:i + length]
                entropy = self._calculate_entropy(seq)
                
                if entropy > 7.0:  # Very high entropy
                    candidates.append((entropy, seq))
                    
        # Sort by entropy and return top candidates
        candidates.sort(key=lambda x: x[0], reverse=True)
        return [seq for _, seq in candidates[:10]]
        
    def _to_bytes(self, value: Any) -> bytes:
        """Convert value to bytes"""
        if isinstance(value, bytes):
            return value
        elif isinstance(value, str):
            # Try hex decode first
            try:
                return bytes.fromhex(value)
            except:
                return value.encode('utf-8')
        elif isinstance(value, list):
            return bytes(value)
        else:
            return str(value).encode('utf-8')


# Singleton
_extractor: Optional[SecurityExtractor] = None

def get_security_extractor() -> SecurityExtractor:
    """Get singleton security extractor"""
    global _extractor
    if _extractor is None:
        _extractor = SecurityExtractor()
    return _extractor
