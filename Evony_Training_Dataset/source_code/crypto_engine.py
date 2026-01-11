"""
Real-Time Crypto Engine

Bidirectional encryption/decryption for live packet interception.
Supports XOR, AES, Blowfish, and RSA with automatic key selection.
"""

import logging
import hashlib
import os
from dataclasses import dataclass
from enum import Enum
from typing import Optional, Tuple, Dict, Any, Callable
import threading

logger = logging.getLogger(__name__)

# Try to import crypto libraries
try:
    from Crypto.Cipher import AES, Blowfish
    from Crypto.PublicKey import RSA
    from Crypto.Cipher import PKCS1_OAEP
    from Crypto.Util.Padding import pad, unpad
    HAS_PYCRYPTO = True
except ImportError:
    try:
        from Cryptodome.Cipher import AES, Blowfish
        from Cryptodome.PublicKey import RSA
        from Cryptodome.Cipher import PKCS1_OAEP
        from Cryptodome.Util.Padding import pad, unpad
        HAS_PYCRYPTO = True
    except ImportError:
        HAS_PYCRYPTO = False
        logger.warning("PyCryptodome not installed - limited crypto support")


class CipherType(Enum):
    """Supported cipher types"""
    XOR = "xor"
    AES_128_CBC = "aes_128_cbc"
    AES_256_CBC = "aes_256_cbc"
    AES_128_ECB = "aes_128_ecb"
    AES_256_ECB = "aes_256_ecb"
    BLOWFISH_CBC = "blowfish_cbc"
    BLOWFISH_ECB = "blowfish_ecb"
    RSA_OAEP = "rsa_oaep"
    SHA1 = "sha1"
    SHA256 = "sha256"
    MD5 = "md5"


@dataclass
class CryptoResult:
    """Result of a crypto operation"""
    success: bool
    data: bytes
    cipher_type: CipherType
    error: str = ""
    metadata: Dict[str, Any] = None
    
    def __post_init__(self):
        if self.metadata is None:
            self.metadata = {}


class CryptoEngine:
    """
    Real-time encryption/decryption engine.
    
    Features:
    - Multiple cipher support (XOR, AES, Blowfish, RSA)
    - Automatic cipher detection from packet patterns
    - Bidirectional operation (encrypt for injection, decrypt for viewing)
    - Integration with KeyVault for key management
    - Zero-copy operations where possible
    """
    
    # Block sizes for different ciphers
    BLOCK_SIZES = {
        CipherType.AES_128_CBC: 16,
        CipherType.AES_256_CBC: 16,
        CipherType.AES_128_ECB: 16,
        CipherType.AES_256_ECB: 16,
        CipherType.BLOWFISH_CBC: 8,
        CipherType.BLOWFISH_ECB: 8,
    }
    
    def __init__(self):
        self._lock = threading.RLock()
        
        # Statistics
        self._encrypt_count = 0
        self._decrypt_count = 0
        self._errors = 0
        
    def encrypt(self, data: bytes, key: bytes, 
                cipher_type: CipherType,
                iv: Optional[bytes] = None) -> CryptoResult:
        """Encrypt data using specified cipher"""
        with self._lock:
            try:
                if cipher_type == CipherType.XOR:
                    result = self._xor_cipher(data, key)
                elif cipher_type in [CipherType.AES_128_CBC, CipherType.AES_256_CBC]:
                    result = self._aes_encrypt(data, key, iv, mode="CBC")
                elif cipher_type in [CipherType.AES_128_ECB, CipherType.AES_256_ECB]:
                    result = self._aes_encrypt(data, key, iv, mode="ECB")
                elif cipher_type in [CipherType.BLOWFISH_CBC, CipherType.BLOWFISH_ECB]:
                    mode = "CBC" if cipher_type == CipherType.BLOWFISH_CBC else "ECB"
                    result = self._blowfish_encrypt(data, key, iv, mode)
                elif cipher_type == CipherType.RSA_OAEP:
                    result = self._rsa_encrypt(data, key)
                else:
                    return CryptoResult(False, b"", cipher_type, f"Unsupported cipher: {cipher_type}")
                    
                self._encrypt_count += 1
                return CryptoResult(True, result, cipher_type)
                
            except Exception as e:
                self._errors += 1
                logger.error(f"Encryption failed: {e}")
                return CryptoResult(False, b"", cipher_type, str(e))
                
    def decrypt(self, data: bytes, key: bytes,
                cipher_type: CipherType,
                iv: Optional[bytes] = None) -> CryptoResult:
        """Decrypt data using specified cipher"""
        with self._lock:
            try:
                if cipher_type == CipherType.XOR:
                    result = self._xor_cipher(data, key)  # XOR is symmetric
                elif cipher_type in [CipherType.AES_128_CBC, CipherType.AES_256_CBC]:
                    result = self._aes_decrypt(data, key, iv, mode="CBC")
                elif cipher_type in [CipherType.AES_128_ECB, CipherType.AES_256_ECB]:
                    result = self._aes_decrypt(data, key, iv, mode="ECB")
                elif cipher_type in [CipherType.BLOWFISH_CBC, CipherType.BLOWFISH_ECB]:
                    mode = "CBC" if cipher_type == CipherType.BLOWFISH_CBC else "ECB"
                    result = self._blowfish_decrypt(data, key, iv, mode)
                elif cipher_type == CipherType.RSA_OAEP:
                    result = self._rsa_decrypt(data, key)
                else:
                    return CryptoResult(False, b"", cipher_type, f"Unsupported cipher: {cipher_type}")
                    
                self._decrypt_count += 1
                return CryptoResult(True, result, cipher_type)
                
            except Exception as e:
                self._errors += 1
                logger.error(f"Decryption failed: {e}")
                return CryptoResult(False, b"", cipher_type, str(e))
                
    def hash(self, data: bytes, hash_type: CipherType,
             salt: Optional[bytes] = None) -> CryptoResult:
        """Generate hash of data"""
        try:
            if salt:
                data = salt + data
                
            if hash_type == CipherType.SHA1:
                result = hashlib.sha1(data).digest()
            elif hash_type == CipherType.SHA256:
                result = hashlib.sha256(data).digest()
            elif hash_type == CipherType.MD5:
                result = hashlib.md5(data).digest()
            else:
                return CryptoResult(False, b"", hash_type, f"Unsupported hash: {hash_type}")
                
            return CryptoResult(True, result, hash_type)
            
        except Exception as e:
            return CryptoResult(False, b"", hash_type, str(e))
            
    def detect_cipher(self, encrypted_data: bytes) -> Optional[CipherType]:
        """Attempt to detect cipher type from encrypted data patterns"""
        if not encrypted_data:
            return None
            
        length = len(encrypted_data)
        
        # Check for RSA (typically 128, 256, 512 bytes)
        if length in [128, 256, 512]:
            return CipherType.RSA_OAEP
            
        # Check for AES (16-byte aligned)
        if length % 16 == 0:
            # Could be AES-128 or AES-256, default to 256
            return CipherType.AES_256_CBC
            
        # Check for Blowfish (8-byte aligned but not 16)
        if length % 8 == 0 and length % 16 != 0:
            return CipherType.BLOWFISH_CBC
            
        # Default to XOR for non-block-aligned data
        return CipherType.XOR
        
    def try_all_ciphers(self, data: bytes, key: bytes,
                        iv: Optional[bytes] = None) -> Dict[CipherType, CryptoResult]:
        """Try decrypting with all supported ciphers"""
        results = {}
        
        for cipher_type in [CipherType.XOR, CipherType.AES_256_CBC, 
                           CipherType.BLOWFISH_CBC]:
            try:
                result = self.decrypt(data, key, cipher_type, iv)
                if result.success:
                    # Check if result looks like valid data
                    if self._is_valid_decryption(result.data):
                        results[cipher_type] = result
            except:
                pass
                
        return results
        
    def generate_iv(self, cipher_type: CipherType) -> bytes:
        """Generate random IV for cipher"""
        block_size = self.BLOCK_SIZES.get(cipher_type, 16)
        return os.urandom(block_size)
        
    def get_statistics(self) -> Dict[str, int]:
        """Get operation statistics"""
        return {
            "encryptions": self._encrypt_count,
            "decryptions": self._decrypt_count,
            "errors": self._errors,
        }
        
    # ========== Private Methods ==========
    
    def _xor_cipher(self, data: bytes, key: bytes) -> bytes:
        """XOR cipher - same operation for encrypt/decrypt"""
        if not key:
            return data
            
        result = bytearray(len(data))
        key_len = len(key)
        
        for i, byte in enumerate(data):
            result[i] = byte ^ key[i % key_len]
            
        return bytes(result)
        
    def _aes_encrypt(self, data: bytes, key: bytes,
                     iv: Optional[bytes], mode: str) -> bytes:
        """AES encryption"""
        if not HAS_PYCRYPTO:
            raise ImportError("PyCryptodome required for AES")
            
        # Ensure key is correct length (16 or 32 bytes)
        if len(key) not in [16, 32]:
            key = hashlib.sha256(key).digest()  # Convert to 32 bytes
            
        if mode == "CBC":
            if not iv:
                iv = os.urandom(16)
            cipher = AES.new(key, AES.MODE_CBC, iv)
            padded = pad(data, AES.block_size)
            return iv + cipher.encrypt(padded)
        else:  # ECB
            cipher = AES.new(key, AES.MODE_ECB)
            padded = pad(data, AES.block_size)
            return cipher.encrypt(padded)
            
    def _aes_decrypt(self, data: bytes, key: bytes,
                     iv: Optional[bytes], mode: str) -> bytes:
        """AES decryption"""
        if not HAS_PYCRYPTO:
            raise ImportError("PyCryptodome required for AES")
            
        if len(key) not in [16, 32]:
            key = hashlib.sha256(key).digest()
            
        if mode == "CBC":
            if not iv:
                # IV is prepended to ciphertext
                iv = data[:16]
                data = data[16:]
            cipher = AES.new(key, AES.MODE_CBC, iv)
            decrypted = cipher.decrypt(data)
            return unpad(decrypted, AES.block_size)
        else:  # ECB
            cipher = AES.new(key, AES.MODE_ECB)
            decrypted = cipher.decrypt(data)
            return unpad(decrypted, AES.block_size)
            
    def _blowfish_encrypt(self, data: bytes, key: bytes,
                          iv: Optional[bytes], mode: str) -> bytes:
        """Blowfish encryption"""
        if not HAS_PYCRYPTO:
            raise ImportError("PyCryptodome required for Blowfish")
            
        # Blowfish key: 4-56 bytes
        if len(key) > 56:
            key = key[:56]
        elif len(key) < 4:
            key = key * (4 // len(key) + 1)
            key = key[:4]
            
        if mode == "CBC":
            if not iv:
                iv = os.urandom(8)
            cipher = Blowfish.new(key, Blowfish.MODE_CBC, iv)
            padded = pad(data, Blowfish.block_size)
            return iv + cipher.encrypt(padded)
        else:  # ECB
            cipher = Blowfish.new(key, Blowfish.MODE_ECB)
            padded = pad(data, Blowfish.block_size)
            return cipher.encrypt(padded)
            
    def _blowfish_decrypt(self, data: bytes, key: bytes,
                          iv: Optional[bytes], mode: str) -> bytes:
        """Blowfish decryption"""
        if not HAS_PYCRYPTO:
            raise ImportError("PyCryptodome required for Blowfish")
            
        if len(key) > 56:
            key = key[:56]
        elif len(key) < 4:
            key = key * (4 // len(key) + 1)
            key = key[:4]
            
        if mode == "CBC":
            if not iv:
                iv = data[:8]
                data = data[8:]
            cipher = Blowfish.new(key, Blowfish.MODE_CBC, iv)
            decrypted = cipher.decrypt(data)
            return unpad(decrypted, Blowfish.block_size)
        else:  # ECB
            cipher = Blowfish.new(key, Blowfish.MODE_ECB)
            decrypted = cipher.decrypt(data)
            return unpad(decrypted, Blowfish.block_size)
            
    def _rsa_encrypt(self, data: bytes, public_key: bytes) -> bytes:
        """RSA encryption with OAEP padding"""
        if not HAS_PYCRYPTO:
            raise ImportError("PyCryptodome required for RSA")
            
        key = RSA.import_key(public_key)
        cipher = PKCS1_OAEP.new(key)
        return cipher.encrypt(data)
        
    def _rsa_decrypt(self, data: bytes, private_key: bytes) -> bytes:
        """RSA decryption with OAEP padding"""
        if not HAS_PYCRYPTO:
            raise ImportError("PyCryptodome required for RSA")
            
        key = RSA.import_key(private_key)
        cipher = PKCS1_OAEP.new(key)
        return cipher.decrypt(data)
        
    def _is_valid_decryption(self, data: bytes) -> bool:
        """Check if decrypted data looks valid"""
        if not data:
            return False
            
        # Check for high proportion of printable/valid bytes
        printable = sum(1 for b in data if 32 <= b <= 126 or b in [9, 10, 13])
        ratio = printable / len(data)
        
        # Also check for common patterns
        # AMF starts with 0x00, JSON with { or [, XML with <
        if data[0] in [0x00, 0x7B, 0x5B, 0x3C]:  # 0x00, {, [, <
            return True
            
        return ratio > 0.7  # At least 70% printable


# Singleton
_engine: Optional[CryptoEngine] = None

def get_crypto_engine() -> CryptoEngine:
    """Get singleton crypto engine instance"""
    global _engine
    if _engine is None:
        _engine = CryptoEngine()
    return _engine
