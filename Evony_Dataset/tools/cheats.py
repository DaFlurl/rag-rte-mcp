# BORG TOOLKIT - Automated Cheat Engine
"""
Enterprise-grade automated cheat engine for Evony.
Combines all exploits into automated, repeatable cheat routines.

CHEAT CATEGORIES:
1. Resource Cheats - Food, Gold, Wood, Stone, Iron
2. Troop Cheats - Add troops, prevent losses
3. Item Cheats - Generate items, duplicate items
4. Speed Cheats - Instant build, instant research
5. Combat Cheats - Win battles, avoid losses
"""

import time
import json
import threading
from pathlib import Path
from typing import Dict, List, Any, Optional, Callable
from dataclasses import dataclass, field
from datetime import datetime
from enum import Enum

# Troop data
TROOP_TYPES = {
    1: 'worker', 2: 'warrior', 3: 'scout', 4: 'pikeman',
    5: 'swordsman', 6: 'archer', 7: 'cavalry', 8: 'cataphract',
    9: 'transporter', 10: 'ballista', 11: 'ram', 12: 'catapult',
}

TROOP_COSTS = {
    'worker': {'food': 50, 'wood': 20, 'stone': 50, 'iron': 10},
    'warrior': {'food': 100, 'wood': 50, 'stone': 80, 'iron': 30},
    'scout': {'food': 200, 'wood': 100, 'stone': 50, 'iron': 50},
    'pikeman': {'food': 500, 'wood': 200, 'stone': 150, 'iron': 100},
    'swordsman': {'food': 1000, 'wood': 200, 'stone': 150, 'iron': 500},
    'archer': {'food': 350, 'wood': 500, 'stone': 100, 'iron': 100},
    'cavalry': {'food': 800, 'wood': 200, 'stone': 100, 'iron': 300},
    'cataphract': {'food': 1500, 'wood': 500, 'stone': 200, 'iron': 800},
    'transporter': {'food': 500, 'wood': 1000, 'stone': 200, 'iron': 100},
    'ballista': {'food': 2500, 'wood': 1500, 'stone': 500, 'iron': 500},
    'ram': {'food': 4000, 'wood': 3000, 'stone': 500, 'iron': 1000},
    'catapult': {'food': 6000, 'wood': 2000, 'stone': 3000, 'iron': 2000},
}

OVERFLOW_THRESHOLDS = {
    'worker': 42949672, 'warrior': 21474836, 'scout': 10737418,
    'pikeman': 4294967, 'swordsman': 2147483, 'archer': 6135036,
    'cavalry': 2684354, 'cataphract': 1431655, 'transporter': 4294967,
    'ballista': 858993, 'ram': 536870, 'catapult': 357913,
}

# Item IDs (extracted from source)
ITEM_IDS = {
    # Speed items
    'speed_5min': 'player.item.speed.5min',
    'speed_15min': 'player.item.speed.15min',
    'speed_1hr': 'player.item.speed.1hr',
    'speed_8hr': 'player.item.speed.8hr',
    'speed_instant': 'player.item.speed.instant',
    
    # Resource items
    'food_1k': 'player.item.food.1k',
    'food_10k': 'player.item.food.10k',
    'food_100k': 'player.item.food.100k',
    'wood_1k': 'player.item.wood.1k',
    'stone_1k': 'player.item.stone.1k',
    'iron_1k': 'player.item.iron.1k',
    
    # Amulets (gambling)
    'amulet_1': 'player.box.gambling.1',
    'amulet_2': 'player.box.gambling.2',
    'amulet_3': 'player.box.gambling.3',
    
    # Chests
    'chest_bronze': 'player.box.1',
    'chest_silver': 'player.box.2',
    'chest_gold': 'player.box.3',
    
    # Keys
    'key_bronze': 'consume.key.1',
    'key_silver': 'consume.key.2',
    'key_gold': 'consume.key.3',
    
    # Special
    'holy_water': 'player.item.holy.water',
    'war_horn': 'player.item.war.horn',
    'truce': 'player.truce.dream',
}


@dataclass 
class CheatAction:
    """Single cheat action"""
    name: str
    command: str
    params: Dict
    delay_after: float = 0.1
    repeat: int = 1
    
    
@dataclass
class CheatSequence:
    """Sequence of cheat actions"""
    name: str
    description: str
    actions: List[CheatAction] = field(default_factory=list)
    total_runs: int = 0
    success_count: int = 0


class ResourceCheats:
    """
    Resource manipulation cheats.
    
    Methods:
    - food_glitch: Generate food via integer overflow
    - resource_transfer_exploit: Transfer resources via overflow
    - colony_farm: Automated colony farming
    """
    
    def __init__(self):
        self.sequences: List[CheatSequence] = []
    
    def food_glitch_sequence(self, castle_id: int, position_id: int = 1,
                              troop_type: str = 'archer') -> CheatSequence:
        """
        FOOD GLITCH - Generate food via troop overflow.
        
        Steps:
        1. Queue troops above overflow threshold
        2. Wait for server to process
        3. Cancel production
        4. Receive "negative refund" = GAIN food
        
        Expected gain per run: ~2 billion food (if overflow works)
        """
        troop_id = list(TROOP_TYPES.keys())[list(TROOP_TYPES.values()).index(troop_type)]
        threshold = OVERFLOW_THRESHOLDS.get(troop_type, 6135036)
        overflow_num = threshold + 1
        
        sequence = CheatSequence(
            name="Food Glitch",
            description=f"Generate food via {troop_type} overflow ({overflow_num:,} troops)",
            actions=[
                CheatAction(
                    name="Queue Overflow Troops",
                    command="troop.produceTroop",
                    params={
                        'castleId': castle_id,
                        'positionId': position_id,
                        'troopType': troop_id,
                        'num': overflow_num,
                        'isShare': False,
                        'toIdle': True,
                    },
                    delay_after=0.5,
                ),
                CheatAction(
                    name="Cancel Production",
                    command="troop.cancelTroopProduce",
                    params={
                        'castleId': castle_id,
                        'positionId': position_id,
                        'queueId': 0,
                    },
                    delay_after=0.1,
                ),
            ]
        )
        
        self.sequences.append(sequence)
        return sequence
    
    def gold_farm_sequence(self, castle_id: int) -> CheatSequence:
        """
        GOLD FARM - Maximize gold income.
        
        Uses tax collection and trade manipulation.
        Not an exploit, but automated optimization.
        """
        sequence = CheatSequence(
            name="Gold Farm",
            description="Automated gold income optimization",
            actions=[
                CheatAction(
                    name="Set Max Tax Rate",
                    command="interior.modifyTaxRate",
                    params={
                        'castleId': castle_id,
                        'rate': 100,  # 100% tax
                    },
                    delay_after=0.5,
                ),
                CheatAction(
                    name="Collect Tax",
                    command="interior.taxation",
                    params={
                        'castleId': castle_id,
                    },
                    delay_after=0.5,
                ),
                CheatAction(
                    name="Pacify (restore loyalty)",
                    command="interior.pacifyPeople",
                    params={
                        'castleId': castle_id,
                    },
                    delay_after=0.1,
                ),
            ]
        )
        
        self.sequences.append(sequence)
        return sequence
    
    def resource_transfer_overflow(self, source_castle: int, target_castle: int,
                                    resource_type: str = 'food') -> CheatSequence:
        """
        RESOURCE TRANSFER OVERFLOW - Send negative resources.
        
        Theory: If resource amount overflows, target may receive
        resources while source loses nothing.
        """
        resource_map = {'food': 0, 'wood': 1, 'stone': 2, 'iron': 3}
        res_idx = resource_map.get(resource_type, 0)
        
        resources = {'food': 0, 'wood': 0, 'stone': 0, 'iron': 0}
        resources[resource_type] = 2147483648  # Just over INT32_MAX
        
        sequence = CheatSequence(
            name="Resource Transfer Overflow",
            description=f"Transfer {resource_type} via overflow",
            actions=[
                CheatAction(
                    name="Send Overflow Transport",
                    command="army.newArmy",
                    params={
                        'castleId': source_castle,
                        'newArmyBean': {
                            'heroId': 0,
                            'targetFieldId': target_castle,
                            'troops': {'transporter': 100000},
                            'resources': resources,
                            'missionType': 2,  # Transport
                        }
                    },
                    delay_after=0.5,
                ),
            ]
        )
        
        self.sequences.append(sequence)
        return sequence


class TroopCheats:
    """
    Troop manipulation cheats.
    
    Methods:
    - instant_army: Generate troops instantly
    - troop_save: Save troops from battle
    - free_troops: Get troops without cost
    """
    
    def __init__(self):
        self.sequences: List[CheatSequence] = []
    
    def free_troops_sequence(self, castle_id: int, position_id: int,
                              troop_type: str, count: int) -> CheatSequence:
        """
        FREE TROOPS - Get troops via overflow + cancel.
        
        When you cancel overflowed production, you may get troops
        queued for "free" (negative cost already calculated).
        """
        troop_id = list(TROOP_TYPES.keys())[list(TROOP_TYPES.values()).index(troop_type)]
        
        sequence = CheatSequence(
            name="Free Troops",
            description=f"Get {count:,} {troop_type}s via overflow",
            actions=[
                CheatAction(
                    name="Start Overflow Production",
                    command="troop.produceTroop",
                    params={
                        'castleId': castle_id,
                        'positionId': position_id,
                        'troopType': troop_id,
                        'num': OVERFLOW_THRESHOLDS.get(troop_type, count),
                        'isShare': False,
                        'toIdle': True,
                    },
                    delay_after=0.1,
                ),
                CheatAction(
                    name="Start Normal Production",
                    command="troop.produceTroop",
                    params={
                        'castleId': castle_id,
                        'positionId': position_id,
                        'troopType': troop_id,
                        'num': count,
                        'isShare': False,
                        'toIdle': True,
                    },
                    delay_after=0.3,
                ),
                CheatAction(
                    name="Cancel First (Overflow)",
                    command="troop.cancelTroopProduce",
                    params={
                        'castleId': castle_id,
                        'positionId': position_id,
                        'queueId': 0,
                    },
                    delay_after=0.1,
                ),
            ]
        )
        
        self.sequences.append(sequence)
        return sequence
    
    def troop_save_sequence(self, castle_id: int, hero_id: int,
                             safe_valley: tuple) -> CheatSequence:
        """
        TROOP SAVE - Hide troops when attacked.
        
        Send troops to a far valley when under attack.
        They won't be present when enemy arrives.
        """
        sequence = CheatSequence(
            name="Troop Save",
            description="Emergency troop evacuation to valley",
            actions=[
                CheatAction(
                    name="Send Troops to Valley",
                    command="army.newArmy",
                    params={
                        'castleId': castle_id,
                        'newArmyBean': {
                            'heroId': hero_id,
                            'targetPoint': {'x': safe_valley[0], 'y': safe_valley[1]},
                            'troops': {},  # Will be filled with all troops
                            'resources': {'food': 0, 'wood': 0, 'stone': 0, 'iron': 0},
                            'missionType': 4,  # Scout/reinforce
                        }
                    },
                    delay_after=0.1,
                ),
            ]
        )
        
        self.sequences.append(sequence)
        return sequence


class ItemCheats:
    """
    Item manipulation cheats.
    
    Methods:
    - item_dupe: Duplicate items via race condition
    - free_amulet: Get free amulet spins
    - chest_exploit: Open chests without keys
    """
    
    def __init__(self):
        self.sequences: List[CheatSequence] = []
    
    def item_dupe_sequence(self, castle_id: int, item_id: str,
                            simultaneous: int = 10) -> CheatSequence:
        """
        ITEM DUPE - Duplicate item via race condition.
        
        Send many "use item" packets simultaneously.
        Server may process multiple before decrementing count.
        """
        actions = []
        for i in range(simultaneous):
            actions.append(CheatAction(
                name=f"Use Item {i+1}",
                command="shop.useGoods",
                params={
                    'castleId': castle_id,
                    'itemId': item_id,
                    'num': 1,
                },
                delay_after=0,  # No delay - send simultaneously
            ))
        
        sequence = CheatSequence(
            name="Item Duplication",
            description=f"Duplicate {item_id} via {simultaneous} simultaneous requests",
            actions=actions,
        )
        
        self.sequences.append(sequence)
        return sequence
    
    def amulet_exploit_sequence(self, castle_id: int, 
                                 spins: int = 10) -> CheatSequence:
        """
        AMULET EXPLOIT - Rapid amulet spinning.
        
        May hit race condition for better rewards.
        """
        actions = []
        for i in range(spins):
            actions.append(CheatAction(
                name=f"Spin Amulet {i+1}",
                command="shop.useGoods",
                params={
                    'castleId': castle_id,
                    'itemId': ITEM_IDS['amulet_3'],
                    'num': 1,
                },
                delay_after=0.1,
            ))
        
        sequence = CheatSequence(
            name="Amulet Exploit",
            description=f"Rapid {spins} amulet spins",
            actions=actions,
        )
        
        self.sequences.append(sequence)
        return sequence
    
    def chest_bypass_sequence(self, castle_id: int, 
                               chest_type: int = 3) -> CheatSequence:
        """
        CHEST BYPASS - Attempt to open chest without key.
        
        Theory: Send open command directly, bypassing key check.
        """
        chest_id = f"player.box.{chest_type}"
        
        sequence = CheatSequence(
            name="Chest Bypass",
            description=f"Open {chest_id} without key",
            actions=[
                CheatAction(
                    name="Open Chest Direct",
                    command="shop.useGoods",
                    params={
                        'castleId': castle_id,
                        'itemId': chest_id,
                        'num': 1,
                    },
                    delay_after=0.1,
                ),
            ]
        )
        
        self.sequences.append(sequence)
        return sequence


class SpeedCheats:
    """
    Speed and time manipulation cheats.
    
    Methods:
    - instant_build: Complete buildings instantly
    - instant_research: Complete research instantly
    - instant_train: Complete training instantly
    """
    
    def __init__(self):
        self.sequences: List[CheatSequence] = []
    
    def instant_build_sequence(self, castle_id: int, 
                                position_id: int) -> CheatSequence:
        """
        INSTANT BUILD - Complete building via race condition.
        
        Rapidly send speed-up commands.
        """
        sequence = CheatSequence(
            name="Instant Build",
            description="Attempt instant building completion",
            actions=[
                # Use free 5-minute speedup multiple times
                CheatAction(
                    name="Apply Speed (Free)",
                    command="city.speedUpBuild",
                    params={
                        'castleId': castle_id,
                        'positionId': position_id,
                        'itemId': '',  # Empty = free speedup
                    },
                    delay_after=0,
                    repeat=50,  # Repeat 50 times
                ),
            ]
        )
        
        self.sequences.append(sequence)
        return sequence
    
    def instant_research_sequence(self, castle_id: int) -> CheatSequence:
        """
        INSTANT RESEARCH - Complete research via race condition.
        """
        sequence = CheatSequence(
            name="Instant Research",
            description="Attempt instant research completion",
            actions=[
                CheatAction(
                    name="Apply Speed (Free)",
                    command="tech.speedUpResearch",
                    params={
                        'castleId': castle_id,
                        'itemId': '',
                    },
                    delay_after=0,
                    repeat=50,
                ),
            ]
        )
        
        self.sequences.append(sequence)
        return sequence


# =============================================================================
# MASTER CHEAT ENGINE
# =============================================================================

class BorgCheatEngine:
    """
    Master cheat engine combining all cheat modules.
    
    Usage:
        engine = BorgCheatEngine()
        
        # Generate food
        seq = engine.resources.food_glitch_sequence(castle_id=123)
        engine.execute(seq)
        
        # Duplicate items
        seq = engine.items.item_dupe_sequence(castle_id=123, item_id='...')
        engine.execute(seq)
    """
    
    def __init__(self, connection=None):
        self.connection = connection
        self.resources = ResourceCheats()
        self.troops = TroopCheats()
        self.items = ItemCheats()
        self.speed = SpeedCheats()
        
        self.execution_log: List[Dict] = []
    
    def set_connection(self, connection):
        """Set connection for cheat execution"""
        self.connection = connection
    
    def execute(self, sequence: CheatSequence, 
                callback: Callable = None) -> Dict:
        """
        Execute a cheat sequence.
        
        Args:
            sequence: CheatSequence to execute
            callback: Optional callback for progress updates
        
        Returns:
            Dict with execution results
        """
        results = {
            'sequence': sequence.name,
            'started': datetime.now().isoformat(),
            'actions': [],
            'success': False,
        }
        
        if callback:
            callback(f"[*] Starting: {sequence.name}")
            callback(f"    {sequence.description}")
        
        for action in sequence.actions:
            for i in range(action.repeat):
                action_result = {
                    'name': action.name,
                    'command': action.command,
                    'attempt': i + 1,
                }
                
                if self.connection:
                    try:
                        response = self.connection.send_command(
                            action.command, action.params
                        )
                        action_result['response'] = response
                        action_result['success'] = True
                    except Exception as e:
                        action_result['error'] = str(e)
                        action_result['success'] = False
                else:
                    action_result['simulated'] = True
                    action_result['success'] = True
                
                results['actions'].append(action_result)
                
                if callback:
                    status = "OK" if action_result.get('success') else "FAIL"
                    callback(f"    [{status}] {action.name}")
                
                if action.delay_after > 0:
                    time.sleep(action.delay_after)
        
        results['completed'] = datetime.now().isoformat()
        results['success'] = all(a.get('success', False) for a in results['actions'])
        
        sequence.total_runs += 1
        if results['success']:
            sequence.success_count += 1
        
        self.execution_log.append(results)
        
        return results
    
    def execute_parallel(self, sequence: CheatSequence) -> Dict:
        """Execute all actions in parallel (for race conditions)"""
        threads = []
        results = []
        
        def run_action(action):
            if self.connection:
                try:
                    resp = self.connection.send_command(action.command, action.params)
                    results.append({'action': action.name, 'success': True, 'response': resp})
                except Exception as e:
                    results.append({'action': action.name, 'success': False, 'error': str(e)})
            else:
                results.append({'action': action.name, 'simulated': True})
        
        # Create threads
        for action in sequence.actions:
            t = threading.Thread(target=run_action, args=(action,))
            threads.append(t)
        
        # Start all simultaneously
        for t in threads:
            t.start()
        
        # Wait for completion
        for t in threads:
            t.join()
        
        return {
            'sequence': sequence.name,
            'parallel_execution': True,
            'results': results,
        }
    
    def get_all_cheats(self) -> Dict[str, List[str]]:
        """Get list of all available cheats"""
        return {
            'resource_cheats': [
                'food_glitch_sequence - Generate food via troop overflow',
                'gold_farm_sequence - Automated gold income',
                'resource_transfer_overflow - Transfer via overflow',
            ],
            'troop_cheats': [
                'free_troops_sequence - Get troops for free',
                'troop_save_sequence - Emergency troop evacuation',
            ],
            'item_cheats': [
                'item_dupe_sequence - Duplicate items via race condition',
                'amulet_exploit_sequence - Rapid amulet spinning',
                'chest_bypass_sequence - Open chests without keys',
            ],
            'speed_cheats': [
                'instant_build_sequence - Instant building',
                'instant_research_sequence - Instant research',
            ],
        }
    
    def export_log(self, filepath: Path = None) -> Path:
        """Export execution log"""
        if filepath is None:
            filepath = Path(f"cheat_log_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json")
        
        filepath.write_text(json.dumps(self.execution_log, indent=2))
        return filepath


def demo_cheats():
    """Demonstrate cheat engine"""
    print("=" * 70)
    print("BORG TOOLKIT - Automated Cheat Engine")
    print("=" * 70)
    
    engine = BorgCheatEngine()
    
    print("\n[+] AVAILABLE CHEATS:")
    for category, cheats in engine.get_all_cheats().items():
        print(f"\n  {category.upper()}:")
        for cheat in cheats:
            print(f"    - {cheat}")
    
    print("\n" + "=" * 70)
    print("[+] FOOD GLITCH SEQUENCE (Simulation):")
    seq = engine.resources.food_glitch_sequence(castle_id=12345)
    result = engine.execute(seq, callback=print)
    
    print(f"\n    Result: {'SUCCESS' if result['success'] else 'FAILED'}")
    print(f"    Actions: {len(result['actions'])}")


if __name__ == "__main__":
    demo_cheats()
