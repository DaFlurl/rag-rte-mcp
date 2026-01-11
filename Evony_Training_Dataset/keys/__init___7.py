"""
Svony Studio Real-Time Reverse Engineering Module
==================================================

Real-time packet interception, decryption, recording, and injection:
- Key Vault for managing encryption keys from client/bot
- Crypto Engine for bidirectional encrypt/decrypt
- Packet Interceptor (MITM proxy)
- Packet Type Detector for protocol analysis
- Action Recorder for UI interactions
- Injection System for command crafting
"""

from .key_vault import (
    KeyVault,
    CryptoKey,
    KeyType,
    KeySource,
    KeyStatus,
    get_key_vault,
)
from .crypto_engine import (
    CryptoEngine,
    CipherType,
    CryptoResult,
    get_crypto_engine,
)
from .action_recorder import (
    ActionRecorder,
    RecordedAction,
    RecordingSession,
    ActionType,
    RecordingState,
    get_action_recorder,
)
from .packet_type_detector import (
    PacketTypeDetector,
    PacketInfo,
    PacketHeader,
    PacketDirection,
    PacketCategory,
    CommandID,
    get_packet_type_detector,
)
from .packet_interceptor import (
    PacketInterceptor,
    CapturedPacket,
    ConnectionInfo,
    ProxyState,
    get_packet_interceptor,
)
from .auth_manager import (
    AuthManager,
    AuthSession,
    AuthToken,
    AuthState,
    TokenType,
    LoginCredentials,
    get_auth_manager,
)
from .anti_cheat import (
    AntiCheatManager,
    DetectionRisk,
    RateLimitConfig,
    BehaviorProfile,
    ClientFingerprint,
    get_anti_cheat_manager,
)
from .amf_codec import (
    ProtocolCodec,
    AMFDecoder,
    AMFEncoder,
    AMFPacket,
    AMFMessage,
    JSONCodec,
    XMLCodec,
    get_protocol_codec,
)

__all__ = [
    # Key Vault
    "KeyVault",
    "CryptoKey",
    "KeyType",
    "KeySource",
    "KeyStatus",
    "get_key_vault",
    # Crypto Engine
    "CryptoEngine",
    "CipherType",
    "CryptoResult",
    "get_crypto_engine",
    # Action Recorder
    "ActionRecorder",
    "RecordedAction",
    "RecordingSession",
    "ActionType",
    "RecordingState",
    "get_action_recorder",
    # Packet Type Detector
    "PacketTypeDetector",
    "PacketInfo",
    "PacketHeader",
    "PacketDirection",
    "PacketCategory",
    "CommandID",
    "get_packet_type_detector",
    # Packet Interceptor
    "PacketInterceptor",
    "CapturedPacket",
    "ConnectionInfo",
    "ProxyState",
    "get_packet_interceptor",
    # Auth Manager
    "AuthManager",
    "AuthSession",
    "AuthToken",
    "AuthState",
    "TokenType",
    "LoginCredentials",
    "get_auth_manager",
    # Anti-Cheat
    "AntiCheatManager",
    "DetectionRisk",
    "RateLimitConfig",
    "BehaviorProfile",
    "ClientFingerprint",
    "get_anti_cheat_manager",
    # AMF Codec
    "ProtocolCodec",
    "AMFDecoder",
    "AMFEncoder",
    "AMFPacket",
    "AMFMessage",
    "JSONCodec",
    "XMLCodec",
    "get_protocol_codec",
]
