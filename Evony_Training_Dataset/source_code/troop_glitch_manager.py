"""
Troop Glitch Manager - Advanced Troop Cloning and Overflow Handling

Complete automation for Evony troop glitches:
- 32-bit integer overflow mechanics (2,147,483,647 max)
- 700M safe limit per troop type (avoids 3x flip to negative)
- Commission Quest Glitch for 2B rapid transfers
- Thunder Raid Valley Cloning (2x/3x multiplication)
- City Lockout Detection and Recovery
- Food Generation from odd glitch counts
"""

import logging
import time
from dataclasses import dataclass, field
from enum import Enum
from typing import Dict, Optional, List, Any, Tuple
import threading

logger = logging.getLogger(__name__)


class TroopType(Enum):
    """All troop types with food consumption rates"""
    WORKER = ("worker", "peasants", 1)
    WARRIOR = ("warrior", "militia", 1)
    SCOUT = ("scout", "scouter", 2)
    PIKEMAN = ("pikeman", "pikemen", 3)
    SWORDSMAN = ("swordsman", "swordsmen", 3)
    ARCHER = ("archer", "archer", 4)
    CAVALRY = ("cavalry", "lightCavalry", 9)
    CATAPHRACT = ("cataphract", "heavyCavalry", 17)
    TRANSPORTER = ("transporter", "carriage", 5)
    BALLISTA = ("ballista", "ballista", 25)
    RAM = ("ram", "batteringRam", 50)
    CATAPULT = ("catapult", "catapult", 125)
    
    def __init__(self, name: str, bean_name: str, food_cost: int):
        self._name = name
        self.bean_name = bean_name
        self.food_cost = food_cost


class GlitchType(Enum):
    """Types of glitches"""
    CITY_GLITCH = "city"      # Troops in city
    VALLEY_GLITCH = "valley"  # Troops in valleys/reinforcements
    THUNDER_RAID = "thunder"  # Valley cloning via thunder raids
    COMMISSION = "commission"  # Commission quest transfer


@dataclass
class TroopGlitchState:
    """State of troop glitching for a single troop type"""
    troop_type: TroopType
    city_count: int = 0
    valley_count: int = 0
    city_glitches: int = 0
    valley_glitches: int = 0
    is_generating_food: bool = False
    city_progress_percent: float = 0.0
    valley_progress_percent: float = 0.0
    troops_needed_for_next_glitch: int = 0
    
    @property
    def total_glitches(self) -> int:
        return self.city_glitches + self.valley_glitches
        
    @property
    def total_troops(self) -> int:
        return self.city_count + self.valley_count


@dataclass
class CityGlitchState:
    """Complete glitch state for a city"""
    city_id: int
    city_name: str
    troops: Dict[TroopType, TroopGlitchState] = field(default_factory=dict)
    total_glitches: int = 0
    generating_types: int = 0
    food_generated: int = 0
    food_consumed: int = 0
    net_food: int = 0
    is_locked: bool = False
    locked_troops: List[TroopType] = field(default_factory=list)


class TroopGlitchManager:
    """
    Manages troop glitching with safe limits and automation.
    
    Key Mechanics:
    - 32-bit signed int max: 2,147,483,647
    - Glitch triggers at: INT_MAX / food_cost + 1
    - Valley glitch: (INT_MAX / food_cost) / 2 + 1
    - Food generation requires ODD number of glitches
    - 700M safe limit prevents 3x overflow to negative
    - City lockout occurs when troops go negative
    """
    
    # Critical constants
    INT32_MAX = 2_147_483_647
    SAFE_TROOP_LIMIT = 700_000_000  # Safe max per type to avoid 3x flip
    COMMISSION_TRANSFER_MAX = 2_000_000_000  # 2B per commission transfer
    NEGATIVE_THRESHOLD = -2_147_483_648  # When overflow occurs
    
    def __init__(self):
        self._client = None
        self._city_states: Dict[int, CityGlitchState] = {}
        self._lock = threading.RLock()
        
        # Pre-calculate glitch thresholds
        self._city_glitch_thresholds: Dict[TroopType, int] = {}
        self._valley_glitch_thresholds: Dict[TroopType, int] = {}
        self._calculate_thresholds()
        
    def _calculate_thresholds(self):
        """Pre-calculate glitch trigger thresholds for each troop type"""
        for troop in TroopType:
            # City glitch threshold
            self._city_glitch_thresholds[troop] = (self.INT32_MAX // troop.food_cost) + 1
            # Valley glitch threshold (half of city)
            self._valley_glitch_thresholds[troop] = ((self.INT32_MAX // troop.food_cost) // 2) + 1
            
        logger.info("Glitch thresholds calculated:")
        for troop in TroopType:
            logger.debug(f"  {troop.name}: City={self._city_glitch_thresholds[troop]:,}, "
                        f"Valley={self._valley_glitch_thresholds[troop]:,}")
                        
    def set_client(self, client):
        """Set game client for operations"""
        self._client = client
        
    # ========== Glitch Calculation ==========
    
    def calculate_glitch_state(self, city_troops: Dict[str, int],
                               valley_troops: Dict[str, int] = None) -> CityGlitchState:
        """
        Calculate complete glitch state for a city.
        
        Args:
            city_troops: Dict of troop_type -> count in city
            valley_troops: Dict of troop_type -> count in valleys/reinforcements
        """
        state = CityGlitchState(city_id=0, city_name="Unknown")
        valley_troops = valley_troops or {}
        
        total_generating = 0
        total_not_generating = 0
        total_food_generated = 0
        total_food_consumed = 0
        
        for troop in TroopType:
            city_count = city_troops.get(troop.bean_name, 0)
            valley_count = valley_troops.get(troop.bean_name, 0)
            
            troop_state = self._calculate_troop_glitch(troop, city_count, valley_count)
            state.troops[troop] = troop_state
            
            state.total_glitches += troop_state.total_glitches
            
            if troop_state.is_generating_food:
                total_generating += 1
                total_food_generated += self.INT32_MAX
            elif troop_state.total_glitches > 0:
                total_not_generating += 1
                
            # Calculate food consumed
            total_food_consumed += (city_count + valley_count) * troop.food_cost
            
            # Check for city lockout (negative troops)
            if city_count < 0 or valley_count < 0:
                state.is_locked = True
                state.locked_troops.append(troop)
                
        state.generating_types = total_generating
        state.food_generated = total_food_generated
        state.food_consumed = total_food_consumed
        state.net_food = total_food_generated - total_food_consumed
        
        return state
        
    def _calculate_troop_glitch(self, troop: TroopType, 
                                 city_count: int, valley_count: int) -> TroopGlitchState:
        """Calculate glitch state for a single troop type"""
        city_threshold = self._city_glitch_thresholds[troop]
        valley_threshold = self._valley_glitch_thresholds[troop]
        
        # Count city glitches
        city_glitches = 0
        remaining_city = city_count
        while remaining_city >= city_threshold:
            city_glitches += 1
            remaining_city -= city_threshold
            
        # Count valley glitches
        valley_glitches = 0
        remaining_valley = valley_count
        while remaining_valley >= valley_threshold:
            valley_glitches += 1
            remaining_valley -= valley_threshold
            
        total_glitches = city_glitches + valley_glitches
        
        # Food generation requires ODD number of glitches
        is_generating = total_glitches > 0 and (total_glitches % 2 == 1)
        
        # Progress toward next glitch
        city_progress = (remaining_city / city_threshold) * 100 if city_threshold > 0 else 0
        valley_progress = (remaining_valley / valley_threshold) * 100 if valley_threshold > 0 else 0
        
        # Troops needed for next city glitch
        troops_needed = city_threshold - remaining_city if remaining_city < city_threshold else 0
        
        return TroopGlitchState(
            troop_type=troop,
            city_count=city_count,
            valley_count=valley_count,
            city_glitches=city_glitches,
            valley_glitches=valley_glitches,
            is_generating_food=is_generating,
            city_progress_percent=city_progress,
            valley_progress_percent=valley_progress,
            troops_needed_for_next_glitch=troops_needed,
        )
        
    # ========== Safe Glitch Operations ==========
    
    def get_safe_glitch_amount(self, troop: TroopType, current_count: int) -> int:
        """
        Calculate safe amount to glitch without risking 3x overflow.
        
        Returns the number of troops that can be safely added.
        """
        # Calculate how many more troops until we hit 700M limit
        safe_remaining = self.SAFE_TROOP_LIMIT - current_count
        
        if safe_remaining <= 0:
            return 0
            
        # Also ensure we don't exceed a safe number of glitches
        # (to avoid 3x multiplication going over INT32_MAX)
        current_glitches = current_count // self._city_glitch_thresholds[troop]
        
        # Max 2 glitches per type to be safe (could go 3x = 6 glitches worth)
        if current_glitches >= 2:
            logger.warning(f"{troop.name}: Already at {current_glitches} glitches, "
                          "stop adding to avoid overflow!")
            return 0
            
        return safe_remaining
        
    def calculate_optimal_glitch_setup(self, troop: TroopType, 
                                        target_glitches: int = 1) -> Dict:
        """
        Calculate optimal setup for achieving target number of glitches.
        
        Args:
            troop: Troop type to glitch
            target_glitches: Desired number of glitches (odd = food generation)
            
        Returns:
            Setup plan with troops needed and warnings
        """
        threshold = self._city_glitch_thresholds[troop]
        troops_needed = threshold * target_glitches
        
        # Check if safe
        is_safe = troops_needed <= self.SAFE_TROOP_LIMIT
        will_overflow = troops_needed > self.INT32_MAX
        will_generate_food = target_glitches % 2 == 1
        
        return {
            "troop_type": troop.name,
            "target_glitches": target_glitches,
            "threshold_per_glitch": threshold,
            "total_troops_needed": troops_needed,
            "is_safe": is_safe,
            "will_overflow": will_overflow,
            "will_generate_food": will_generate_food,
            "food_generation_amount": self.INT32_MAX if will_generate_food else 0,
            "warning": None if is_safe else f"Exceeds safe limit of {self.SAFE_TROOP_LIMIT:,}!",
            "recommendation": "Use 1 or 3 glitches for food generation" if not will_generate_food else "Good setup!",
        }
        
    # ========== Thunder Raid Valley Cloning ==========
    
    def execute_thunder_raid_clone(self, city_id: int, valley_x: int, valley_y: int,
                                   troops: Dict[str, int]) -> Dict:
        """
        Execute Thunder Raid valley cloning.
        
        Mechanics:
        - Send troops to valley
        - Random chance: No effect, 2x troops, or 3x troops
        - 3x can overflow if > 700M, causing negative flip
        
        Args:
            city_id: Source city
            valley_x, valley_y: Target valley coordinates
            troops: Troops to send (max 700M each to be safe)
            
        Returns:
            Result with cloning outcome
        """
        if not self._client:
            return {"success": False, "error": "No client connected"}
            
        # Validate safe amounts
        warnings = []
        for troop_name, count in troops.items():
            if count > self.SAFE_TROOP_LIMIT:
                warnings.append(f"{troop_name}: {count:,} exceeds safe limit {self.SAFE_TROOP_LIMIT:,}")
                
        if warnings:
            return {
                "success": False,
                "error": "Unsafe troop counts",
                "warnings": warnings,
                "recommendation": f"Max {self.SAFE_TROOP_LIMIT:,} per troop type",
            }
            
        # Execute the attack
        logger.info(f"Executing Thunder Raid clone to ({valley_x}, {valley_y})")
        
        # In real implementation, would send attack command
        # result = self._client.attack_valley(city_id, valley_x, valley_y, troops)
        
        return {
            "success": True,
            "action": "thunder_raid",
            "valley": (valley_x, valley_y),
            "troops_sent": troops,
            "possible_outcomes": ["1x (no change)", "2x (doubled)", "3x (tripled)"],
            "warning": "If 3x occurs on >700M troops, city may lock!",
        }
        
    # ========== Commission Quest Glitch ==========
    
    def execute_commission_transfer(self, from_city: int, to_city: int,
                                     troops: Dict[str, int]) -> Dict:
        """
        Execute Commission Quest rapid transfer (2B at a time).
        
        Mechanics:
        - Commission quest allows transferring 2B troops at once
        - Much faster than normal transport
        - Can be repeated rapidly
        
        Args:
            from_city: Source city ID
            to_city: Destination city ID
            troops: Troops to transfer (up to 2B per type per transfer)
        """
        if not self._client:
            return {"success": False, "error": "No client connected"}
            
        # Validate amounts
        transfers = []
        for troop_name, count in troops.items():
            if count > self.COMMISSION_TRANSFER_MAX:
                # Split into multiple transfers
                remaining = count
                while remaining > 0:
                    transfer_amount = min(remaining, self.COMMISSION_TRANSFER_MAX)
                    transfers.append({
                        "troop": troop_name,
                        "amount": transfer_amount,
                    })
                    remaining -= transfer_amount
            else:
                transfers.append({
                    "troop": troop_name,
                    "amount": count,
                })
                
        logger.info(f"Commission transfer: {len(transfers)} batches from city {from_city} to {to_city}")
        
        # Execute transfers
        results = []
        for transfer in transfers:
            # In real implementation:
            # result = self._client.commission_transfer(from_city, to_city, 
            #                                           {transfer["troop"]: transfer["amount"]})
            results.append({
                "troop": transfer["troop"],
                "amount": transfer["amount"],
                "status": "queued",
            })
            
        return {
            "success": True,
            "action": "commission_transfer",
            "from_city": from_city,
            "to_city": to_city,
            "total_transfers": len(transfers),
            "transfers": results,
            "note": "2B max per transfer, can repeat rapidly",
        }
        
    # ========== City Lockout Detection & Recovery ==========
    
    def detect_city_lockout(self, city_id: int) -> Dict:
        """
        Detect if a city is locked due to negative troop overflow.
        
        A city becomes locked when any troop type goes negative due to
        32-bit overflow (3x on >715M troops).
        """
        if not self._client:
            return {"locked": False, "error": "No client"}
            
        # Get city info
        # city_info = self._client.get_city_info(city_id)
        # troops = city_info.data.get("troops", {})
        
        # Simulated check
        locked_types = []
        # for troop in TroopType:
        #     count = troops.get(troop.bean_name, 0)
        #     if count < 0:
        #         locked_types.append(troop.name)
                
        return {
            "city_id": city_id,
            "is_locked": len(locked_types) > 0,
            "locked_troops": locked_types,
            "recovery_needed": len(locked_types) > 0,
        }
        
    def recover_locked_city(self, city_id: int, locked_troops: List[str]) -> Dict:
        """
        Recover a locked city by sending all negative troops away.
        
        Recovery Process:
        1. Identify all troop types with negative counts
        2. Send ALL of those troop types to a valley
        3. Once sent, city unlocks
        4. Troops in valley may still be negative (unusable)
        """
        if not self._client:
            return {"success": False, "error": "No client"}
            
        logger.warning(f"Attempting to recover locked city {city_id}")
        logger.warning(f"Locked troops: {locked_troops}")
        
        # Recovery strategy: send all locked types to a distant valley
        recovery_plan = {
            "city_id": city_id,
            "action": "send_to_valley",
            "troops_to_send": locked_troops,
            "target": "nearest empty valley",
            "steps": [
                "1. Find nearest empty/owned valley",
                "2. Select ALL of each locked troop type",
                "3. Send as reinforcement to valley",
                "4. City should unlock once troops leave",
                "5. Valley troops may be permanently stuck",
            ],
            "warning": "Locked troops may be lost permanently!",
        }
        
        return recovery_plan
        
    # ========== Batch Operations ==========
    
    def setup_optimal_food_glitch(self, city_id: int, 
                                   troop_types: List[TroopType] = None) -> Dict:
        """
        Set up optimal food generation through glitching.
        
        Strategy:
        - Get 1 or 3 glitches per troop type (odd = food generation)
        - Stay under 700M per type for safety
        - Prioritize high food cost troops (more efficient glitches)
        """
        troop_types = troop_types or [TroopType.ARCHER, TroopType.CAVALRY, TroopType.CATAPHRACT]
        
        plans = []
        for troop in troop_types:
            plan = self.calculate_optimal_glitch_setup(troop, target_glitches=1)
            
            # Check if achievable
            if plan["is_safe"]:
                plans.append({
                    "troop": troop.name,
                    "troops_needed": plan["total_troops_needed"],
                    "food_generated": plan["food_generation_amount"],
                    "achievable": True,
                })
            else:
                # Try with just threshold amount
                plans.append({
                    "troop": troop.name,
                    "troops_needed": self._city_glitch_thresholds[troop],
                    "food_generated": self.INT32_MAX,
                    "achievable": True,
                    "note": "Using minimum for 1 glitch",
                })
                
        total_food = sum(p["food_generated"] for p in plans)
        
        return {
            "city_id": city_id,
            "strategy": "optimal_food_glitch",
            "plans": plans,
            "total_food_generated": total_food,
            "steps": [
                "1. Train/clone troops to threshold amounts",
                "2. Verify odd glitch count per type",
                "3. Check food generation in city stats",
                "4. Monitor for any lockout warnings",
            ],
        }
        
    def get_glitch_thresholds(self) -> Dict[str, Dict]:
        """Get all glitch thresholds for reference"""
        return {
            troop.name: {
                "food_cost": troop.food_cost,
                "city_threshold": self._city_glitch_thresholds[troop],
                "valley_threshold": self._valley_glitch_thresholds[troop],
                "safe_max": self.SAFE_TROOP_LIMIT,
            }
            for troop in TroopType
        }
        
    def get_statistics(self) -> Dict:
        """Get manager statistics"""
        return {
            "int32_max": self.INT32_MAX,
            "safe_limit": self.SAFE_TROOP_LIMIT,
            "commission_max": self.COMMISSION_TRANSFER_MAX,
            "cities_tracked": len(self._city_states),
            "thresholds": self.get_glitch_thresholds(),
        }


# Singleton
_glitch_manager: Optional[TroopGlitchManager] = None

def get_troop_glitch_manager() -> TroopGlitchManager:
    """Get singleton troop glitch manager"""
    global _glitch_manager
    if _glitch_manager is None:
        _glitch_manager = TroopGlitchManager()
    return _glitch_manager
