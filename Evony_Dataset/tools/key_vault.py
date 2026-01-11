"""
Key Vault - Secure Storage for Encryption Keys

Manages all cryptographic keys extracted from:
- Evony Client SWF (XOR, AES, SHA1 salt)
- AutoEvony/RoboEvony SWF (Blowfish, Chat cipher, Token secret)
- Login responses (Session token, RSA public)

Keys are used for real-time bidirectional encryption/decryption.
"""

import logging
import json
import hashlib
import base64
import os
import time
from dataclasses import dataclass, field
from enum import Enum
from pathlib import Path
from typing import Dict, Optional, List, Any, Tuple
from collections import defaultdict
import threading

logger = logging.getLogger(__name__)


class KeyType(Enum):
    """Types of cryptographic keys"""
    XOR = "xor"
    AES_128 = "aes_128"
    AES_256 = "aes_256"
    BLOWFISH = "blowfish"
    RSA_PUBLIC = "rsa_public"
    RSA_PRIVATE = "rsa_private"
    SHA1_SALT = "sha1_salt"
    SHA256_SALT = "sha256_salt"
    SESSION_TOKEN = "session_token"
    CHAT_CIPHER = "chat_cipher"
    AMF_KEY = "amf_key"
    CUSTOM = "custom"


class KeySource(Enum):
    """Source of the key"""
    EVONY_CLIENT = "evony_client"
    AUTOEVONY = "autoevony"
    ROBOEVONY = "roboevony"
    LOGIN_RESPONSE = "login_response"
    HANDSHAKE = "handshake"
    CONFIG_FILE = "config_file"
    MANUAL = "manual"
    EXTRACTED = "extracted"


class KeyStatus(Enum):
    """Status of a key"""
    ACTIVE = "active"
    EXPIRED = "expired"
    REVOKED = "revoked"
    PENDING = "pending"
    UNKNOWN = "unknown"


@dataclass
class CryptoKey:
    """A cryptographic key with metadata"""
    key_id: str
    key_type: KeyType
    key_data: bytes
    source: KeySource
    description: str = ""
    status: KeyStatus = KeyStatus.ACTIVE
    created_at: float = field(default_factory=time.time)
    last_used: float = 0.0
    use_count: int = 0
    iv: Optional[bytes] = None  # Initialization vector for block ciphers
    metadata: Dict[str, Any] = field(default_factory=dict)
    
    def to_dict(self) -> Dict:
        return {
            "key_id": self.key_id,
            "key_type": self.key_type.value,
            "key_data": base64.b64encode(self.key_data).decode(),
            "source": self.source.value,
            "description": self.description,
            "status": self.status.value,
            "created_at": self.created_at,
            "last_used": self.last_used,
            "use_count": self.use_count,
            "iv": base64.b64encode(self.iv).decode() if self.iv else None,
            "metadata": self.metadata,
        }
        
    @classmethod
    def from_dict(cls, data: Dict) -> "CryptoKey":
        return cls(
            key_id=data["key_id"],
            key_type=KeyType(data["key_type"]),
            key_data=base64.b64decode(data["key_data"]),
            source=KeySource(data["source"]),
            description=data.get("description", ""),
            status=KeyStatus(data.get("status", "active")),
            created_at=data.get("created_at", time.time()),
            last_used=data.get("last_used", 0.0),
            use_count=data.get("use_count", 0),
            iv=base64.b64decode(data["iv"]) if data.get("iv") else None,
            metadata=data.get("metadata", {}),
        )
        
    def mark_used(self):
        """Mark key as used"""
        self.last_used = time.time()
        self.use_count += 1


class KeyVault:
    """
    Secure vault for managing encryption keys.
    
    Features:
    - Store keys from multiple sources
    - Auto-detect key type from packet patterns
    - Track key usage and rotation
    - Export/import key sets
    - Integration with Borg collective for key sharing
    """
    
    # Known key patterns for auto-detection
    KNOWN_PATTERNS = {
        # Evony client known XOR key pattern
        "evony_xor": bytes([0x5A, 0x3C, 0x7E, 0x1B]),
        # AutoEvony Blowfish header
        "autoevony_bf": bytes([0xAE, 0xBF, 0x01, 0x00]),
    }
    
    def __init__(self, vault_path: Optional[str] = None):
        self.vault_path = Path(vault_path) if vault_path else Path("data/keyvault.json")
        
        # Key storage
        self._keys: Dict[str, CryptoKey] = {}
        self._by_type: Dict[KeyType, List[str]] = defaultdict(list)
        self._by_source: Dict[KeySource, List[str]] = defaultdict(list)
        
        # Session keys (temporary, not persisted)
        self._session_keys: Dict[str, CryptoKey] = {}
        
        # Thread safety
        self._lock = threading.RLock()
        
        # Load persisted keys
        self._load_vault()
        
        # Initialize with known Evony keys if available
        self._init_known_keys()
        
    def add_key(self, key: CryptoKey) -> bool:
        """Add a key to the vault"""
        with self._lock:
            self._keys[key.key_id] = key
            self._by_type[key.key_type].append(key.key_id)
            self._by_source[key.source].append(key.key_id)
            
            logger.info(f"Added key: {key.key_id} ({key.key_type.value})")
            return True
            
    def add_session_key(self, key: CryptoKey) -> bool:
        """Add a session key (not persisted)"""
        with self._lock:
            self._session_keys[key.key_id] = key
            logger.info(f"Added session key: {key.key_id}")
            return True
            
    def get_key(self, key_id: str) -> Optional[CryptoKey]:
        """Get a key by ID"""
        with self._lock:
            # Check session keys first
            if key_id in self._session_keys:
                return self._session_keys[key_id]
            return self._keys.get(key_id)
            
    def get_key_by_type(self, key_type: KeyType, 
                        active_only: bool = True) -> Optional[CryptoKey]:
        """Get the most recently used active key of a type"""
        with self._lock:
            key_ids = self._by_type.get(key_type, [])
            
            candidates = []
            for key_id in key_ids:
                key = self._keys.get(key_id)
                if key and (not active_only or key.status == KeyStatus.ACTIVE):
                    candidates.append(key)
                    
            # Also check session keys
            for key in self._session_keys.values():
                if key.key_type == key_type:
                    if not active_only or key.status == KeyStatus.ACTIVE:
                        candidates.append(key)
                        
            if not candidates:
                return None
                
            # Return most recently used
            return max(candidates, key=lambda k: k.last_used)
            
    def get_keys_by_source(self, source: KeySource) -> List[CryptoKey]:
        """Get all keys from a source"""
        with self._lock:
            key_ids = self._by_source.get(source, [])
            return [self._keys[kid] for kid in key_ids if kid in self._keys]
            
    def get_all_active_keys(self) -> List[CryptoKey]:
        """Get all active keys"""
        with self._lock:
            keys = [k for k in self._keys.values() if k.status == KeyStatus.ACTIVE]
            keys.extend([k for k in self._session_keys.values() if k.status == KeyStatus.ACTIVE])
            return keys
            
    def remove_key(self, key_id: str) -> bool:
        """Remove a key from the vault"""
        with self._lock:
            if key_id in self._keys:
                key = self._keys.pop(key_id)
                self._by_type[key.key_type].remove(key_id)
                self._by_source[key.source].remove(key_id)
                logger.info(f"Removed key: {key_id}")
                return True
            if key_id in self._session_keys:
                del self._session_keys[key_id]
                return True
            return False
            
    def revoke_key(self, key_id: str) -> bool:
        """Revoke a key (mark as unusable)"""
        with self._lock:
            key = self.get_key(key_id)
            if key:
                key.status = KeyStatus.REVOKED
                return True
            return False
            
    def create_key(self, key_type: KeyType, key_bytes: bytes,
                   source: KeySource = KeySource.MANUAL,
                   description: str = "",
                   iv: Optional[bytes] = None) -> CryptoKey:
        """Create and add a new key"""
        # Generate key ID from hash
        key_hash = hashlib.sha256(key_bytes).hexdigest()[:8]
        key_id = f"key_{key_type.value}_{key_hash}"
        
        key = CryptoKey(
            key_id=key_id,
            key_type=key_type,
            key_data=key_bytes,
            source=source,
            description=description,
            iv=iv,
        )
        
        self.add_key(key)
        return key
        
    def extract_from_swf(self, swf_path: str, 
                         source: KeySource = KeySource.EVONY_CLIENT) -> List[CryptoKey]:
        """Extract keys from a SWF file"""
        extracted = []
        
        try:
            swf_data = Path(swf_path).read_bytes()
            
            # Search for known key patterns
            for name, pattern in self.KNOWN_PATTERNS.items():
                pos = swf_data.find(pattern)
                if pos != -1:
                    # Extract key bytes after pattern
                    key_bytes = swf_data[pos:pos + 32]  # Typical key length
                    
                    key_type = KeyType.XOR if "xor" in name else KeyType.BLOWFISH
                    key = self.create_key(
                        key_type=key_type,
                        key_bytes=key_bytes,
                        source=source,
                        description=f"Extracted from {Path(swf_path).name} at offset {pos}",
                    )
                    extracted.append(key)
                    
            # Search for common key lengths in constant pools
            # 16 bytes = AES-128, 32 bytes = AES-256
            for key_len, key_type in [(16, KeyType.AES_128), (32, KeyType.AES_256)]:
                # Look for high-entropy byte sequences
                for i in range(0, len(swf_data) - key_len, 4):
                    candidate = swf_data[i:i + key_len]
                    entropy = self._calculate_entropy(candidate)
                    if entropy > 7.5:  # High entropy suggests key
                        key = self.create_key(
                            key_type=key_type,
                            key_bytes=candidate,
                            source=source,
                            description=f"High-entropy candidate from {Path(swf_path).name}",
                        )
                        key.metadata["entropy"] = entropy
                        key.metadata["offset"] = i
                        extracted.append(key)
                        break  # Only first match per type
                        
            logger.info(f"Extracted {len(extracted)} keys from {swf_path}")
            
        except Exception as e:
            logger.error(f"Failed to extract keys from SWF: {e}")
            
        return extracted
        
    def extract_from_login(self, response_data: bytes) -> List[CryptoKey]:
        """Extract session keys from login response"""
        extracted = []
        
        try:
            # Look for session token pattern
            # Typically a 32-64 byte hex string
            import re
            
            # Convert to string for pattern matching
            try:
                text = response_data.decode('utf-8', errors='ignore')
            except:
                text = str(response_data)
                
            # Session token patterns
            token_patterns = [
                r'sessionId["\s:=]+([a-fA-F0-9]{32,64})',
                r'token["\s:=]+([a-fA-F0-9]{32,64})',
                r'key["\s:=]+([a-fA-F0-9]{16,64})',
            ]
            
            for pattern in token_patterns:
                matches = re.findall(pattern, text)
                for match in matches:
                    key = self.create_key(
                        key_type=KeyType.SESSION_TOKEN,
                        key_bytes=bytes.fromhex(match),
                        source=KeySource.LOGIN_RESPONSE,
                        description="Extracted from login response",
                    )
                    extracted.append(key)
                    
            logger.info(f"Extracted {len(extracted)} session keys from login")
            
        except Exception as e:
            logger.error(f"Failed to extract login keys: {e}")
            
        return extracted
        
    def auto_select_key(self, packet_data: bytes) -> Optional[CryptoKey]:
        """Auto-select the correct key based on packet patterns"""
        with self._lock:
            # Check packet header for encryption type hints
            if len(packet_data) < 4:
                return None
                
            header = packet_data[:4]
            
            # AMF packets typically start with 0x00 0x03
            if header[:2] == bytes([0x00, 0x03]):
                return self.get_key_by_type(KeyType.AMF_KEY)
                
            # Blowfish encrypted blocks are 8-byte aligned
            if len(packet_data) % 8 == 0:
                key = self.get_key_by_type(KeyType.BLOWFISH)
                if key:
                    return key
                    
            # AES-256 blocks are 16-byte aligned
            if len(packet_data) % 16 == 0:
                key = self.get_key_by_type(KeyType.AES_256)
                if key:
                    return key
                    
            # Default to XOR for simple obfuscation
            return self.get_key_by_type(KeyType.XOR)
            
    def get_statistics(self) -> Dict[str, Any]:
        """Get vault statistics"""
        with self._lock:
            by_type = {t.value: len(ids) for t, ids in self._by_type.items() if ids}
            by_source = {s.value: len(ids) for s, ids in self._by_source.items() if ids}
            
            active = sum(1 for k in self._keys.values() if k.status == KeyStatus.ACTIVE)
            
            return {
                "total_keys": len(self._keys),
                "session_keys": len(self._session_keys),
                "active_keys": active,
                "by_type": by_type,
                "by_source": by_source,
            }
            
    def save_vault(self) -> bool:
        """Save vault to disk (excludes session keys)"""
        try:
            self.vault_path.parent.mkdir(parents=True, exist_ok=True)
            
            data = {
                "version": "1.0",
                "keys": [k.to_dict() for k in self._keys.values()],
            }
            
            with open(self.vault_path, "w") as f:
                json.dump(data, f, indent=2)
                
            logger.info(f"Saved {len(self._keys)} keys to vault")
            return True
            
        except Exception as e:
            logger.error(f"Failed to save vault: {e}")
            return False
            
    def _load_vault(self) -> bool:
        """Load vault from disk"""
        if not self.vault_path.exists():
            return False
            
        try:
            with open(self.vault_path, "r") as f:
                data = json.load(f)
                
            for key_data in data.get("keys", []):
                key = CryptoKey.from_dict(key_data)
                self._keys[key.key_id] = key
                self._by_type[key.key_type].append(key.key_id)
                self._by_source[key.source].append(key.key_id)
                
            logger.info(f"Loaded {len(self._keys)} keys from vault")
            return True
            
        except Exception as e:
            logger.error(f"Failed to load vault: {e}")
            return False
            
    def _init_known_keys(self):
        """Initialize with known Evony encryption keys"""
        # These are placeholder examples - actual keys would come from analysis
        known_keys = [
            {
                "type": KeyType.XOR,
                "data": bytes([0x5A, 0x3C, 0x7E, 0x1B, 0x9D, 0x2F, 0x4A, 0x6C]),
                "source": KeySource.EVONY_CLIENT,
                "desc": "Evony client string XOR key",
            },
            {
                "type": KeyType.SHA1_SALT,
                "data": b"evony_password_salt_2024",
                "source": KeySource.EVONY_CLIENT,
                "desc": "Password hash salt",
            },
        ]
        
        for kd in known_keys:
            key_hash = hashlib.sha256(kd["data"]).hexdigest()[:8]
            key_id = f"known_{kd['type'].value}_{key_hash}"
            
            if key_id not in self._keys:
                key = CryptoKey(
                    key_id=key_id,
                    key_type=kd["type"],
                    key_data=kd["data"],
                    source=kd["source"],
                    description=kd["desc"],
                )
                self.add_key(key)
                
    def _calculate_entropy(self, data: bytes) -> float:
        """Calculate Shannon entropy of byte sequence"""
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


# Singleton
_vault: Optional[KeyVault] = None

def get_key_vault() -> KeyVault:
    """Get singleton key vault instance"""
    global _vault
    if _vault is None:
        _vault = KeyVault()
    return _vault
