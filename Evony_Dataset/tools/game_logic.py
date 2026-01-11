"""
Game Logic Reverse Engineering - Complete Evony Game Mechanics

Reverse-engineered game mechanics, rules, and validation:
- Combat formulas and calculations
- Resource production and consumption
- Building requirements and effects
- Research trees and bonuses
- Troop stats and counters
- Valley mechanics and NPC data
- Food flip and glitch mechanics
"""

import logging
import math
from dataclasses import dataclass, field
from enum import Enum, IntEnum
from typing import Dict, Optional, List, Any, Tuple
import json
from pathlib import Path

logger = logging.getLogger(__name__)


class TroopTier(IntEnum):
    """Troop tier classification"""
    T1 = 1  # Worker, Warrior
    T2 = 2  # Scout, Pikeman
    T3 = 3  # Swordsman, Archer
    T4 = 4  # Cavalry, Cataphract
    T5 = 5  # Siege (Ballista, Ram, Catapult)
    T6 = 6  # Transporter


class CombatType(Enum):
    """Combat unit type"""
    INFANTRY = "infantry"
    RANGED = "ranged"
    CAVALRY = "cavalry"
    SIEGE = "siege"
    SUPPORT = "support"


class BuildingCategory(Enum):
    """Building categories"""
    MILITARY = "military"
    RESOURCE = "resource"
    DEFENSE = "defense"
    SPECIAL = "special"
    FIELD = "field"


@dataclass
class TroopStats:
    """Complete troop statistics"""
    troop_id: int
    name: str
    tier: TroopTier
    combat_type: CombatType
    
    # Base stats
    attack: int
    defense: int
    life: int
    speed: int
    range: int
    load: int
    
    # Costs
    food_cost: int
    wood_cost: int
    stone_cost: int
    iron_cost: int
    gold_cost: int
    population: int
    train_time: int  # seconds
    
    # Combat modifiers
    attack_bonus: Dict[str, float] = field(default_factory=dict)  # vs other types
    defense_bonus: Dict[str, float] = field(default_factory=dict)
    
    def get_power(self) -> float:
        """Calculate troop power rating"""
        return (self.attack + self.defense + self.life / 10) * (1 + self.tier * 0.1)


@dataclass
class BuildingStats:
    """Building statistics and requirements"""
    building_id: int
    name: str
    category: BuildingCategory
    max_level: int
    
    # Requirements per level
    requirements: Dict[int, Dict] = field(default_factory=dict)
    # Effects per level
    effects: Dict[int, Dict] = field(default_factory=dict)
    
    def get_requirement(self, level: int) -> Dict:
        return self.requirements.get(level, {})
        
    def get_effect(self, level: int) -> Dict:
        return self.effects.get(level, {})


@dataclass
class ResearchStats:
    """Research/Technology statistics"""
    research_id: int
    name: str
    category: str
    max_level: int
    
    requirements: Dict[int, Dict] = field(default_factory=dict)
    effects: Dict[int, Dict] = field(default_factory=dict)
    
    def get_bonus(self, level: int, stat: str) -> float:
        effects = self.effects.get(level, {})
        return effects.get(stat, 0.0)


@dataclass
class NPCData:
    """NPC/Valley data"""
    npc_level: int
    troops: Dict[str, int]
    resources: Dict[str, int]
    drop_items: List[str]
    respawn_time: int  # seconds
    
    def get_power(self) -> float:
        """Estimate NPC power"""
        # Simplified power calculation
        total_troops = sum(self.troops.values())
        return total_troops * (1 + self.npc_level * 0.5)


class GameLogicEngine:
    """
    Complete reverse-engineered Evony game logic.
    
    Features:
    - Combat calculations
    - Resource formulas
    - Building/Research trees
    - Troop statistics
    - NPC/Valley mechanics
    - Glitch mechanics (food flip, etc.)
    """
    
    # ========== CRITICAL GAME CONSTANTS ==========
    
    # Food flip threshold (when food goes negative, it wraps)
    FOOD_FLIP_THRESHOLD = 999_000_000
    SAFE_FOOD_MAX = 485_000_000
    
    # Maximum safe troop counts
    MAX_TROOPS_SINGLE_TYPE = 700_000_000
    MAX_TRANSPORT_TO_VALLEY = 495_000_000
    
    # Daily farming targets
    AMULET_TARGET_DAILY = 15_000
    CENTS_TARGET_DAILY = 20_000
    
    # Wave attack settings
    WAVE_TROOP_COUNT = 33_000
    VALLEY_DISTANCE_OPTIMAL = 1
    VALLEY_DISTANCE_MAX = 3
    
    # Combat constants
    COMBAT_ROUNDS_MAX = 100
    RANGE_ADVANTAGE_BONUS = 0.1
    TERRAIN_BONUS_MAX = 0.3
    
    # Resource production rates (per hour per level)
    RESOURCE_BASE_PRODUCTION = {
        "food": 100,
        "wood": 100,
        "stone": 100,
        "iron": 100,
    }
    
    # Troop food consumption per hour
    TROOP_FOOD_CONSUMPTION = {
        "worker": 1,
        "warrior": 2,
        "scout": 3,
        "pikeman": 4,
        "swordsman": 6,
        "archer": 6,
        "cavalry": 10,
        "cataphract": 15,
        "transporter": 8,
        "ballista": 20,
        "ram": 25,
        "catapult": 30,
    }
    
    def __init__(self):
        # Load troop data
        self._troops: Dict[str, TroopStats] = {}
        self._buildings: Dict[str, BuildingStats] = {}
        self._research: Dict[str, ResearchStats] = {}
        self._npcs: Dict[int, NPCData] = {}
        
        # Initialize with known data
        self._init_troop_data()
        self._init_building_data()
        self._init_npc_data()
        
    # ========== COMBAT CALCULATIONS ==========
    
    def calculate_combat(self, attacker_troops: Dict[str, int],
                        defender_troops: Dict[str, int],
                        attacker_hero: Optional[Dict] = None,
                        defender_hero: Optional[Dict] = None,
                        terrain: str = "plains",
                        wall_level: int = 0) -> Dict:
        """
        Calculate combat outcome between two armies.
        
        Returns detailed battle report with losses, winner, etc.
        """
        # Get total power
        attacker_power = self._calculate_army_power(attacker_troops, attacker_hero)
        defender_power = self._calculate_army_power(defender_troops, defender_hero)
        
        # Apply terrain bonus
        terrain_bonus = self._get_terrain_bonus(terrain)
        defender_power *= (1 + terrain_bonus)
        
        # Apply wall bonus
        wall_bonus = wall_level * 0.05
        defender_power *= (1 + wall_bonus)
        
        # Determine winner
        power_ratio = attacker_power / max(defender_power, 1)
        
        if power_ratio > 1.5:
            winner = "attacker"
            attacker_loss_ratio = 0.1 + random_variance(0.05)
            defender_loss_ratio = 0.9 + random_variance(0.05)
        elif power_ratio > 1.0:
            winner = "attacker"
            attacker_loss_ratio = 0.3 + random_variance(0.1)
            defender_loss_ratio = 0.7 + random_variance(0.1)
        elif power_ratio > 0.7:
            winner = "defender"
            attacker_loss_ratio = 0.7 + random_variance(0.1)
            defender_loss_ratio = 0.3 + random_variance(0.1)
        else:
            winner = "defender"
            attacker_loss_ratio = 0.9 + random_variance(0.05)
            defender_loss_ratio = 0.1 + random_variance(0.05)
            
        # Calculate losses
        attacker_losses = {
            troop: int(count * attacker_loss_ratio)
            for troop, count in attacker_troops.items()
        }
        defender_losses = {
            troop: int(count * defender_loss_ratio)
            for troop, count in defender_troops.items()
        }
        
        return {
            "winner": winner,
            "attacker_power": attacker_power,
            "defender_power": defender_power,
            "power_ratio": power_ratio,
            "attacker_losses": attacker_losses,
            "defender_losses": defender_losses,
            "terrain": terrain,
            "wall_level": wall_level,
        }
        
    def calculate_npc_attack(self, troops: Dict[str, int],
                            npc_level: int,
                            hero: Optional[Dict] = None) -> Dict:
        """Calculate attack on NPC/Valley"""
        npc = self._npcs.get(npc_level)
        if not npc:
            return {"error": f"Unknown NPC level: {npc_level}"}
            
        return self.calculate_combat(
            attacker_troops=troops,
            defender_troops=npc.troops,
            attacker_hero=hero,
            terrain="valley",
        )
        
    def get_minimum_troops_for_npc(self, npc_level: int,
                                   troop_type: str = "archer") -> int:
        """Get minimum troops needed to defeat an NPC"""
        npc = self._npcs.get(npc_level)
        if not npc:
            return 0
            
        npc_power = npc.get_power()
        troop_stats = self._troops.get(troop_type)
        
        if not troop_stats:
            return 0
            
        # Need 1.5x power to win comfortably
        needed_power = npc_power * 1.5
        troops_needed = int(needed_power / troop_stats.get_power())
        
        # Add safety margin
        return int(troops_needed * 1.2)
        
    # ========== RESOURCE CALCULATIONS ==========
    
    def calculate_resource_production(self, buildings: Dict[str, int],
                                     research: Dict[str, int],
                                     buffs: List[str] = None) -> Dict[str, float]:
        """Calculate hourly resource production"""
        production = {
            "food": 0.0,
            "wood": 0.0,
            "stone": 0.0,
            "iron": 0.0,
        }
        
        # Base production from buildings
        building_map = {
            "farm": "food",
            "sawmill": "wood",
            "quarry": "stone",
            "ironmine": "iron",
        }
        
        for building, resource in building_map.items():
            level = buildings.get(building, 0)
            base = self.RESOURCE_BASE_PRODUCTION[resource]
            # Production increases exponentially with level
            production[resource] = base * (level ** 1.5)
            
        # Apply research bonuses
        for tech, level in (research or {}).items():
            if "production" in tech.lower():
                for resource in production:
                    production[resource] *= (1 + level * 0.1)
                    
        return production
        
    def calculate_food_consumption(self, troops: Dict[str, int]) -> float:
        """Calculate hourly food consumption from troops"""
        consumption = 0.0
        
        for troop_type, count in troops.items():
            rate = self.TROOP_FOOD_CONSUMPTION.get(troop_type, 5)
            consumption += count * rate
            
        return consumption
        
    def calculate_net_food(self, production: float, troops: Dict[str, int]) -> float:
        """Calculate net food per hour"""
        consumption = self.calculate_food_consumption(troops)
        return production - consumption
        
    def will_food_flip(self, current_food: int, net_rate: float, 
                       hours: float) -> Tuple[bool, float]:
        """
        Check if food will flip (go negative and wrap).
        Returns (will_flip, hours_until_flip)
        """
        if net_rate >= 0:
            return False, -1
            
        hours_until_zero = current_food / abs(net_rate)
        
        if hours_until_zero <= hours:
            return True, hours_until_zero
            
        return False, hours_until_zero
        
    # ========== BUILDING CALCULATIONS ==========
    
    def get_building_requirements(self, building: str, level: int) -> Dict:
        """Get requirements for building upgrade"""
        stats = self._buildings.get(building)
        if not stats:
            return {}
            
        return stats.get_requirement(level)
        
    def can_build(self, building: str, level: int, 
                  resources: Dict[str, int],
                  buildings: Dict[str, int]) -> Tuple[bool, List[str]]:
        """Check if building can be constructed"""
        reqs = self.get_building_requirements(building, level)
        missing = []
        
        # Check resources
        for resource, amount in reqs.get("resources", {}).items():
            if resources.get(resource, 0) < amount:
                missing.append(f"Need {amount} {resource}")
                
        # Check prerequisite buildings
        for prereq, prereq_level in reqs.get("buildings", {}).items():
            if buildings.get(prereq, 0) < prereq_level:
                missing.append(f"Need {prereq} level {prereq_level}")
                
        return len(missing) == 0, missing
        
    # ========== TROOP CALCULATIONS ==========
    
    def get_troop_stats(self, troop_type: str) -> Optional[TroopStats]:
        """Get stats for a troop type"""
        return self._troops.get(troop_type)
        
    def calculate_training_time(self, troop_type: str, amount: int,
                               barracks_level: int,
                               research_level: int = 0) -> float:
        """Calculate training time in seconds"""
        stats = self._troops.get(troop_type)
        if not stats:
            return 0
            
        base_time = stats.train_time * amount
        
        # Barracks reduces time
        time_reduction = 1 - (barracks_level * 0.05)
        
        # Research reduces time
        time_reduction *= 1 - (research_level * 0.03)
        
        return base_time * max(0.1, time_reduction)
        
    def calculate_march_time(self, troops: Dict[str, int],
                            distance: float,
                            hero_speed_bonus: float = 0) -> float:
        """Calculate march time in seconds"""
        # Find slowest troop
        min_speed = float('inf')
        
        for troop_type, count in troops.items():
            if count > 0:
                stats = self._troops.get(troop_type)
                if stats and stats.speed < min_speed:
                    min_speed = stats.speed
                    
        if min_speed == float('inf'):
            return 0
            
        # Base time calculation
        base_time = (distance * 60) / min_speed  # seconds
        
        # Apply hero bonus
        base_time *= (1 - hero_speed_bonus)
        
        return base_time
        
    # ========== GLITCH MECHANICS ==========
    
    def calculate_food_flip_setup(self, target_food: int,
                                  current_food: int,
                                  production_rate: float) -> Dict:
        """
        Calculate how to set up a food flip.
        
        Food flip occurs when food goes negative and wraps to max int.
        """
        if current_food >= self.SAFE_FOOD_MAX:
            return {
                "warning": "Food already near flip threshold",
                "current": current_food,
                "threshold": self.FOOD_FLIP_THRESHOLD,
            }
            
        # Calculate troops needed to consume enough food
        needed_consumption = production_rate + 1000000  # Need to go negative
        
        # Archers are most efficient for food consumption
        archer_consumption = self.TROOP_FOOD_CONSUMPTION["archer"]
        archers_needed = int(needed_consumption / archer_consumption) + 1
        
        return {
            "strategy": "food_flip",
            "archers_needed": archers_needed,
            "expected_consumption": archers_needed * archer_consumption,
            "production_rate": production_rate,
            "net_rate": production_rate - (archers_needed * archer_consumption),
            "warning": "Food flip is risky - may trigger anti-cheat",
        }
        
    def validate_transport_amount(self, amount: int,
                                  resource: str = "food") -> Tuple[bool, str]:
        """Validate transport amount is safe"""
        if amount > self.MAX_TRANSPORT_TO_VALLEY:
            return False, f"Amount exceeds safe limit of {self.MAX_TRANSPORT_TO_VALLEY:,}"
            
        if resource == "food" and amount > self.SAFE_FOOD_MAX:
            return False, f"Food amount exceeds safe limit of {self.SAFE_FOOD_MAX:,}"
            
        return True, "OK"
        
    # ========== EDGE CASES ==========
    
    def handle_edge_case(self, case_type: str, params: Dict) -> Dict:
        """Handle known edge cases"""
        handlers = {
            "negative_resources": self._handle_negative_resources,
            "overflow_troops": self._handle_overflow_troops,
            "invalid_coordinates": self._handle_invalid_coordinates,
            "concurrent_actions": self._handle_concurrent_actions,
            "session_timeout": self._handle_session_timeout,
        }
        
        handler = handlers.get(case_type)
        if handler:
            return handler(params)
            
        return {"error": f"Unknown edge case: {case_type}"}
        
    def _handle_negative_resources(self, params: Dict) -> Dict:
        """Handle negative resource edge case"""
        resource = params.get("resource", "food")
        amount = params.get("amount", 0)
        
        if amount < 0:
            # Server typically returns error or clips to 0
            return {
                "action": "clip_to_zero",
                "original": amount,
                "corrected": 0,
                "warning": "Negative resources not allowed by server",
            }
        return {"action": "none", "amount": amount}
        
    def _handle_overflow_troops(self, params: Dict) -> Dict:
        """Handle troop count overflow"""
        troop_type = params.get("troop_type", "")
        count = params.get("count", 0)
        
        if count > self.MAX_TROOPS_SINGLE_TYPE:
            return {
                "action": "split_batches",
                "original": count,
                "max_per_batch": self.MAX_TROOPS_SINGLE_TYPE,
                "batches_needed": math.ceil(count / self.MAX_TROOPS_SINGLE_TYPE),
            }
        return {"action": "none", "count": count}
        
    def _handle_invalid_coordinates(self, params: Dict) -> Dict:
        """Handle invalid map coordinates"""
        x = params.get("x", 0)
        y = params.get("y", 0)
        
        # Map is typically 0-800
        x = max(0, min(800, x))
        y = max(0, min(800, y))
        
        return {
            "action": "clamp_coordinates",
            "original_x": params.get("x"),
            "original_y": params.get("y"),
            "corrected_x": x,
            "corrected_y": y,
        }
        
    def _handle_concurrent_actions(self, params: Dict) -> Dict:
        """Handle concurrent action conflicts"""
        return {
            "action": "queue",
            "delay_ms": 1000,
            "retry": True,
            "max_retries": 3,
        }
        
    def _handle_session_timeout(self, params: Dict) -> Dict:
        """Handle session timeout"""
        return {
            "action": "reauth",
            "preserve_state": True,
            "retry_after_auth": True,
        }
        
    # ========== DATA INITIALIZATION ==========
    
    def _init_troop_data(self):
        """Initialize troop statistics"""
        troop_data = [
            TroopStats(1, "worker", TroopTier.T1, CombatType.SUPPORT,
                      attack=5, defense=5, life=50, speed=180, range=20, load=20,
                      food_cost=50, wood_cost=0, stone_cost=0, iron_cost=0, 
                      gold_cost=0, population=1, train_time=15),
            TroopStats(2, "warrior", TroopTier.T1, CombatType.INFANTRY,
                      attack=10, defense=10, life=100, speed=200, range=20, load=10,
                      food_cost=100, wood_cost=50, stone_cost=0, iron_cost=0,
                      gold_cost=0, population=1, train_time=20),
            TroopStats(3, "scout", TroopTier.T2, CombatType.CAVALRY,
                      attack=20, defense=5, life=50, speed=3000, range=20, load=5,
                      food_cost=100, wood_cost=0, stone_cost=0, iron_cost=50,
                      gold_cost=0, population=1, train_time=30),
            TroopStats(4, "pikeman", TroopTier.T2, CombatType.INFANTRY,
                      attack=30, defense=30, life=150, speed=300, range=20, load=15,
                      food_cost=200, wood_cost=100, stone_cost=0, iron_cost=50,
                      gold_cost=0, population=1, train_time=45),
            TroopStats(5, "swordsman", TroopTier.T3, CombatType.INFANTRY,
                      attack=50, defense=50, life=250, speed=275, range=30, load=20,
                      food_cost=300, wood_cost=150, stone_cost=0, iron_cost=100,
                      gold_cost=0, population=1, train_time=60),
            TroopStats(6, "archer", TroopTier.T3, CombatType.RANGED,
                      attack=60, defense=30, life=100, speed=250, range=1200, load=10,
                      food_cost=300, wood_cost=200, stone_cost=0, iron_cost=50,
                      gold_cost=0, population=1, train_time=75),
            TroopStats(7, "cavalry", TroopTier.T4, CombatType.CAVALRY,
                      attack=80, defense=40, life=300, speed=1000, range=100, load=30,
                      food_cost=500, wood_cost=100, stone_cost=0, iron_cost=300,
                      gold_cost=0, population=2, train_time=120),
            TroopStats(8, "cataphract", TroopTier.T4, CombatType.CAVALRY,
                      attack=100, defense=100, life=500, speed=750, range=80, load=40,
                      food_cost=800, wood_cost=200, stone_cost=0, iron_cost=500,
                      gold_cost=0, population=3, train_time=180),
            TroopStats(9, "transporter", TroopTier.T6, CombatType.SUPPORT,
                      attack=10, defense=10, life=100, speed=150, range=20, load=5000,
                      food_cost=500, wood_cost=500, stone_cost=0, iron_cost=0,
                      gold_cost=0, population=2, train_time=150),
            TroopStats(10, "ballista", TroopTier.T5, CombatType.SIEGE,
                      attack=150, defense=50, life=600, speed=100, range=1400, load=50,
                      food_cost=1000, wood_cost=800, stone_cost=200, iron_cost=500,
                      gold_cost=0, population=4, train_time=300),
            TroopStats(11, "ram", TroopTier.T5, CombatType.SIEGE,
                      attack=100, defense=200, life=1000, speed=80, range=30, load=80,
                      food_cost=1500, wood_cost=1200, stone_cost=500, iron_cost=300,
                      gold_cost=0, population=5, train_time=360),
            TroopStats(12, "catapult", TroopTier.T5, CombatType.SIEGE,
                      attack=200, defense=30, life=400, speed=60, range=1500, load=100,
                      food_cost=2000, wood_cost=500, stone_cost=1000, iron_cost=800,
                      gold_cost=0, population=6, train_time=450),
        ]
        
        for troop in troop_data:
            self._troops[troop.name] = troop
            
    def _init_building_data(self):
        """Initialize building data"""
        # Simplified building data
        buildings = [
            BuildingStats(1, "town_hall", BuildingCategory.SPECIAL, 10),
            BuildingStats(2, "cottage", BuildingCategory.RESOURCE, 9),
            BuildingStats(3, "barracks", BuildingCategory.MILITARY, 9),
            BuildingStats(4, "warehouse", BuildingCategory.RESOURCE, 9),
            BuildingStats(5, "farm", BuildingCategory.FIELD, 9),
            BuildingStats(6, "sawmill", BuildingCategory.FIELD, 9),
            BuildingStats(7, "quarry", BuildingCategory.FIELD, 9),
            BuildingStats(8, "ironmine", BuildingCategory.FIELD, 9),
            BuildingStats(9, "walls", BuildingCategory.DEFENSE, 10),
            BuildingStats(10, "rally_spot", BuildingCategory.MILITARY, 10),
            BuildingStats(11, "academy", BuildingCategory.SPECIAL, 9),
            BuildingStats(12, "forge", BuildingCategory.MILITARY, 9),
        ]
        
        for building in buildings:
            self._buildings[building.name] = building
            
    def _init_npc_data(self):
        """Initialize NPC/Valley data"""
        for level in range(1, 11):
            base_troops = 100 * (level ** 2)
            self._npcs[level] = NPCData(
                npc_level=level,
                troops={
                    "warrior": base_troops,
                    "pikeman": int(base_troops * 0.5) if level >= 3 else 0,
                    "swordsman": int(base_troops * 0.3) if level >= 5 else 0,
                    "archer": int(base_troops * 0.4) if level >= 4 else 0,
                },
                resources={
                    "food": 10000 * level,
                    "wood": 8000 * level,
                    "stone": 6000 * level,
                    "iron": 4000 * level,
                },
                drop_items=["medal", "chest"] if level >= 5 else ["medal"],
                respawn_time=3600 * level,
            )
            
    def _calculate_army_power(self, troops: Dict[str, int],
                             hero: Optional[Dict] = None) -> float:
        """Calculate total army power"""
        power = 0.0
        
        for troop_type, count in troops.items():
            stats = self._troops.get(troop_type)
            if stats:
                power += stats.get_power() * count
                
        # Apply hero bonus
        if hero:
            attack_bonus = hero.get("attack_bonus", 0)
            power *= (1 + attack_bonus / 100)
            
        return power
        
    def _get_terrain_bonus(self, terrain: str) -> float:
        """Get terrain bonus for defender"""
        bonuses = {
            "plains": 0.0,
            "forest": 0.1,
            "hills": 0.15,
            "mountains": 0.2,
            "valley": 0.25,
            "city": 0.3,
        }
        return bonuses.get(terrain, 0.0)


def random_variance(max_var: float) -> float:
    """Generate random variance for combat calculations"""
    import random
    return random.uniform(-max_var, max_var)


# Singleton
_game_logic: Optional[GameLogicEngine] = None

def get_game_logic() -> GameLogicEngine:
    """Get singleton game logic engine"""
    global _game_logic
    if _game_logic is None:
        _game_logic = GameLogicEngine()
    return _game_logic
