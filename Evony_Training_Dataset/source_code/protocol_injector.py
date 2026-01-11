#!/usr/bin/env python3
"""
Protocol Injector - AMF Packet Manipulation
============================================

Create and inject AMF packets for Evony protocol manipulation.
"""

import hashlib
import struct
import time
from typing import Any, Dict, List, Optional

# Encryption keys from source
KEYS = {
    'ACTION_KEY': "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}",
    'API_KEY': "9f758e2deccbe6244f734371b9642eda",
    'USER_INFO_KEY': "IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}",
    'XOR_KEY': 0xAA,
    'LOGIN_SALT': "evony",
}


def generate_signature(data: str, key_type: str = 'ACTION_KEY') -> str:
    """Generate MD5 signature for packet"""
    key = KEYS.get(key_type, KEYS['ACTION_KEY'])
    combined = data + key
    return hashlib.md5(combined.encode()).hexdigest()


def xor_encrypt(data: bytes) -> bytes:
    """XOR encrypt/decrypt data"""
    return bytes(b ^ KEYS['XOR_KEY'] for b in data)


def create_login_hash(username: str, password: str) -> str:
    """Create login password hash"""
    # Hash: md5(md5(password) + salt)
    pass_hash = hashlib.md5(password.encode()).hexdigest()
    final_hash = hashlib.md5((pass_hash + KEYS['LOGIN_SALT']).encode()).hexdigest()
    return final_hash


def create_action_hash(action: str, params: Dict) -> str:
    """Create action verification hash"""
    # Serialize params
    param_str = "&".join(f"{k}={v}" for k, v in sorted(params.items()))
    data = f"{action}?{param_str}"
    return generate_signature(data)


class AMFPacket:
    """Simple AMF packet builder"""
    
    def __init__(self, command: str):
        self.command = command
        self.params = {}
        self.timestamp = int(time.time() * 1000)
    
    def add_param(self, key: str, value: Any) -> 'AMFPacket':
        self.params[key] = value
        return self
    
    def to_dict(self) -> Dict:
        return {
            'command': self.command,
            'params': self.params,
            'timestamp': self.timestamp,
            'signature': self.get_signature(),
        }
    
    def get_signature(self) -> str:
        return create_action_hash(self.command, self.params)
    
    def __repr__(self) -> str:
        return f"AMFPacket({self.command}, {self.params})"


class PacketBuilder:
    """Build common Evony packets"""
    
    @staticmethod
    def login(username: str, password: str) -> AMFPacket:
        """Build login packet"""
        return AMFPacket('gameClient.login') \
            .add_param('user', username) \
            .add_param('pwd', create_login_hash(username, password))
    
    @staticmethod
    def produce_troop(troop_type: int, count: int, city_id: int = 0) -> AMFPacket:
        """Build troop production packet"""
        return AMFPacket('troop.produceTroop') \
            .add_param('troopType', troop_type) \
            .add_param('num', count) \
            .add_param('cityId', city_id)
    
    @staticmethod
    def cancel_troop_queue(city_id: int = 0) -> AMFPacket:
        """Build cancel troop queue packet"""
        return AMFPacket('troop.cancelAllTroopProduce') \
            .add_param('cityId', city_id)
    
    @staticmethod
    def use_item(item_id: str, count: int = 1) -> AMFPacket:
        """Build item use packet"""
        return AMFPacket('shop.useGoods') \
            .add_param('itemId', item_id) \
            .add_param('num', count)
    
    @staticmethod
    def tax_levy(city_id: int = 0) -> AMFPacket:
        """Build tax levy packet"""
        return AMFPacket('interior.taxLevy') \
            .add_param('cityId', city_id)
    
    @staticmethod
    def get_package(rule_id: int, serial: str = '') -> AMFPacket:
        """Build get package packet"""
        return AMFPacket('common.getPackage') \
            .add_param('ruleId', rule_id) \
            .add_param('serial', serial)
    
    @staticmethod
    def attack(x: int, y: int, hero_name: str, troops: Dict) -> AMFPacket:
        """Build attack packet"""
        return AMFPacket('army.newArmy') \
            .add_param('targetX', x) \
            .add_param('targetY', y) \
            .add_param('heroName', hero_name) \
            .add_param('troops', troops) \
            .add_param('missionType', 1)  # Attack
    
    @staticmethod
    def reinforce(x: int, y: int, hero_name: str, troops: Dict) -> AMFPacket:
        """Build reinforce packet"""
        return AMFPacket('army.newArmy') \
            .add_param('targetX', x) \
            .add_param('targetY', y) \
            .add_param('heroName', hero_name) \
            .add_param('troops', troops) \
            .add_param('missionType', 2)  # Reinforce


# Troop type mappings
TROOP_TYPES = {
    'worker': 1, 'wo': 1,
    'warrior': 2, 'wa': 2,
    'scout': 3, 'sc': 3,
    'pikeman': 4, 'pi': 4,
    'swordsman': 5, 'sw': 5,
    'archer': 6, 'a': 6,
    'cavalry': 7, 'cav': 7,
    'cataphract': 8, 'cata': 8,
    'transporter': 9, 'tr': 9,
    'ballista': 10, 'ba': 10,
    'ram': 11, 'r': 11,
    'catapult': 12, 'c': 12,
}


def parse_troop_spec(spec: str) -> Optional[tuple]:
    """Parse troop specification like 'a:6135037' or 'archer:1000'"""
    if ':' in spec:
        parts = spec.split(':')
        troop_name = parts[0].lower()
        count = int(parts[1])
        
        troop_type = TROOP_TYPES.get(troop_name)
        if troop_type:
            return (troop_type, count)
    return None


if __name__ == "__main__":
    print("=" * 50)
    print("  Protocol Injector - Evony Master Suite")
    print("=" * 50)
    
    # Demo
    print("\nExample packets:")
    print("-" * 50)
    
    # Overflow packet
    packet = PacketBuilder.produce_troop(6, 6135037)
    print(f"Overflow: {packet.to_dict()}")
    
    # Tax levy
    packet = PacketBuilder.tax_levy()
    print(f"Tax: {packet.to_dict()}")
    
    # Item use
    packet = PacketBuilder.use_item('player.item.speed.1hr')
    print(f"Item: {packet.to_dict()}")
    
    print("\nSignature generation:")
    print(f"  Key: ACTION_KEY")
    print(f"  Hash: {generate_signature('test')}")
