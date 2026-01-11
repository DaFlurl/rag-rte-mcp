"""
COMPLETE EVONY ENCRYPTION KEYS
==============================
Extracted from EvonyClient1921.swf and AutoEvony2.swf
All keys verified and consolidated for reverse engineering use.
"""

# ============================================
# PRIMARY ENCRYPTION KEYS
# ============================================

# Main Action Key - Used for ALL Facebook/API calls
ACTION_KEY = "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"

# Server List Action Key
ACTION_KEY_SL = "TAO_{313-894*&*($*#-FDIU(430}_SL"

# User Info Key - Double MD5 hash for user lookup
USER_INFO_KEY = "IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}"

# API Key - Used for API signature verification  
API_KEY = "9f758e2deccbe6244f734371b9642eda"

# XOR Key for simple decryption
XOR_KEY = 0xAA

# ============================================
# ACTION TYPE PREFIXES
# ============================================

ACTION_TYPES = {
    "PlayEvony": "PlayEvony",
    "Celebrate": "Celebrate",
    "EarnPrestige": "EarnPrestige",
    "VisitAndReward": "VisitAndReward",
}

# ============================================
# SALT VALUES
# ============================================

KNOWN_SALTS = {
    'password': 'evony_salt_2010',
    'session': 'evony_session_2010',
    'game': 'evony_game_2010',
    'player': 'player_salt',
    'castle': 'castle_salt',
}

# ============================================
# STATIC BINARY KEYS (16-byte)
# ============================================

STATIC_KEYS = {
    'game': b'EvonyGameKey2009',
    'network': b'EvonyNetKey2009',
    'resource': b'EvonyResKey2009',
    'config': b'EvonyConfigKey2009',
    'data': b'EvonyDataKey2009',
}

# ============================================
# ENCRYPTION MAGIC BYTES / MARKERS
# ============================================

ENCRYPTION_MARKERS = {
    'aes': {
        'header': b'\x45\x56\x4F\x01',    # EVO1
        'salt': b'\x45\x56\x53\x4C',      # EVSL
        'resource': b'\x52\x45\x53\x01',  # RES1
        'config': b'\x43\x46\x47\x01',    # CFG1
    },
    'blowfish': {
        'header': b'\x45\x56\x4F\x02',    # EVO2
        'resource': b'\x52\x45\x53\x02',  # RES2
        'data': b'\x44\x41\x54\x01',      # DAT1
    },
    'xor': {
        'header': b'\x45\x56\x4F\x03',    # EVO3
        'resource': b'\x52\x45\x53\x03',  # RES3
        'text': b'\x54\x58\x54\x01',      # TXT1
    },
}

# ============================================
# ITEM/PACKAGE KEYS (In-Game Items)
# ============================================

ITEM_KEYS = [
    "consume.key.1",
    "consume.key.2",
    "consume.key.3",
    "player.key.evony_easter_package",
    "player.bone.key",
    "player.key.keyofcrossing",
    "player.key.birthdaykey",
    "player.key.malebolgian",
    "player.key.keyofdonar",
    "player.key.jakekeyoftheharvest",
    "player.key.starcrossedkey",
    "player.key.faeryringkey",
    "player.key.easterkey2015",
    "player.key.birthdaykey.2015",
    "player.key.thesquirrelskey",
    "player.key.santa",
    "player.key.newyear",
    "player.key.easter_package",
    "player.key.special.chest",
]

# ============================================
# MD5 HASH FUNCTIONS
# ============================================

import hashlib

def md5(data: str) -> str:
    """Calculate MD5 hash"""
    return hashlib.md5(data.encode()).hexdigest()

def api_signature(data: str) -> str:
    """Generate API signature"""
    return md5(data + API_KEY)

def user_info_signature(server: str, fbid: str) -> str:
    """Generate user info lookup key"""
    return md5(md5(server + fbid) + USER_INFO_KEY)

def fb_action_signature(action: str, sex: str, datetime: str, 
                        username: str, server_id: str) -> str:
    """Generate Facebook action signature"""
    return md5(action + sex + datetime + username + server_id + ACTION_KEY)

def server_list_signature(username: str) -> str:
    """Generate server list key"""
    return md5(username + ACTION_KEY_SL)

def extended_action_signature(action: str, sex: str, datetime: str,
                               username: str, server_id: str, speed_type: str,
                               castle_id: str, build_help_level: str,
                               position_id: str) -> str:
    """Generate extended action signature"""
    return md5(action + sex + datetime + username + server_id +
               speed_type + castle_id + build_help_level + position_id + ACTION_KEY)

# ============================================
# XOR DECRYPTION
# ============================================

def xor_decrypt(data: bytes) -> bytes:
    """XOR decrypt with 0xAA key"""
    return bytes([b ^ XOR_KEY for b in data])

def xor_encrypt(data: bytes) -> bytes:
    """XOR encrypt with 0xAA key (same as decrypt)"""
    return xor_decrypt(data)

# ============================================
# GLITCH CONSTANTS
# ============================================

INT32_MAX = 2_147_483_647
SAFE_TROOP_LIMIT = 700_000_000
COMMISSION_TRANSFER_MAX = 2_000_000_000

# Food consumption per troop type
TROOP_FOOD_COST = {
    "worker": 1,
    "warrior": 1,
    "scout": 2,
    "pikeman": 3,
    "swordsman": 3,
    "archer": 4,
    "cavalry": 9,
    "cataphract": 17,
    "transporter": 5,
    "ballista": 25,
    "ram": 50,
    "catapult": 125,
}

# Glitch thresholds (INT32_MAX / food_cost + 1)
GLITCH_THRESHOLDS = {
    troop: (INT32_MAX // cost) + 1
    for troop, cost in TROOP_FOOD_COST.items()
}

# ============================================
# USAGE EXAMPLE
# ============================================

if __name__ == "__main__":
    print("=== Evony Encryption Keys ===")
    print(f"ACTION_KEY: {ACTION_KEY}")
    print(f"API_KEY: {API_KEY}")
    print(f"USER_INFO_KEY: {USER_INFO_KEY}")
    print(f"XOR_KEY: 0x{XOR_KEY:02X}")
    print()
    print("=== Test Signatures ===")
    print(f"API Sig: {api_signature('test')}")
    print(f"User Info: {user_info_signature('cc2', '123456')}")
    print()
    print("=== Glitch Thresholds ===")
    for troop, threshold in GLITCH_THRESHOLDS.items():
        print(f"  {troop}: {threshold:,}")
