# Evony RE Hub - Glitch Calculator & Overflow Detector
"""
Calculates exact overflow points, glitch thresholds, and exploit parameters
based on reverse-engineered game mechanics from source code analysis.
"""

import json
import math
from pathlib import Path
from typing import Dict, List, Tuple, Optional
from dataclasses import dataclass, asdict

HUB_ROOT = Path(r"c:\Users\Admin\Downloads\Evony_Decrypted")


@dataclass
class GlitchThreshold:
    """Calculated glitch threshold for a specific exploit."""
    name: str
    unit_type: str
    threshold_value: int
    overflow_point: int
    safe_max: int
    mechanism: str
    formula: str
    exploitation_steps: List[str]


@dataclass
class OverflowCalculation:
    """Integer overflow calculation result."""
    operation: str
    initial_value: int
    operand: int
    result: int
    overflowed: bool
    wrapped_value: int
    exploit_viable: bool


class GlitchCalculator:
    """
    Calculates exploit parameters based on Evony's integer handling.
    Uses 32-bit signed integer overflow mechanics.
    """
    
    INT32_MAX = 2147483647  # 2^31 - 1
    INT32_MIN = -2147483648  # -2^31
    UINT32_MAX = 4294967295  # 2^32 - 1
    
    # Known troop training costs (food per unit)
    TROOP_COSTS = {
        'worker': {'food': 50, 'gold': 0, 'pop': 1},
        'warrior': {'food': 100, 'gold': 0, 'pop': 1},
        'scout': {'food': 200, 'gold': 0, 'pop': 1},
        'pikeman': {'food': 500, 'gold': 0, 'pop': 1},
        'swordsman': {'food': 1000, 'gold': 0, 'pop': 1},
        'archer': {'food': 350, 'gold': 0, 'pop': 1},
        'cavalry': {'food': 800, 'gold': 0, 'pop': 3},
        'cataphract': {'food': 1500, 'gold': 0, 'pop': 5},
        'transporter': {'food': 500, 'gold': 0, 'pop': 5},
        'ballista': {'food': 2500, 'gold': 0, 'pop': 6},
        'ram': {'food': 4000, 'gold': 0, 'pop': 8},
        'catapult': {'food': 6000, 'gold': 0, 'pop': 10},
    }
    
    # Troop upkeep rates (food per hour per unit)
    TROOP_UPKEEP = {
        'worker': 3,
        'warrior': 6,
        'scout': 3,
        'pikeman': 8,
        'swordsman': 12,
        'archer': 5,
        'cavalry': 20,
        'cataphract': 45,
        'transporter': 10,
        'ballista': 75,
        'ram': 100,
        'catapult': 250,
    }
    
    # Glitch threshold multipliers (from source analysis)
    GLITCH_MULTIPLIERS = {
        'archer': 6135036,  # Known archer glitch threshold
        'cavalry': 2684354,
        'cataphract': 1431655,
        'catapult': 357913,
        'worker': 42949672,
        'warrior': 21474836,
    }
    
    def __init__(self):
        self.thresholds: List[GlitchThreshold] = []
        self.calculations: List[OverflowCalculation] = []
    
    def calculate_overflow(self, initial: int, operand: int, 
                           operation: str = 'add') -> OverflowCalculation:
        """Calculate result of arithmetic operation with overflow detection."""
        if operation == 'add':
            raw_result = initial + operand
        elif operation == 'multiply':
            raw_result = initial * operand
        elif operation == 'subtract':
            raw_result = initial - operand
        else:
            raw_result = initial
        
        # Check for overflow
        overflowed = raw_result > self.INT32_MAX or raw_result < self.INT32_MIN
        
        # Calculate wrapped value (how it appears in game)
        if overflowed:
            # Simulate 32-bit signed overflow
            wrapped = raw_result & 0xFFFFFFFF
            if wrapped > self.INT32_MAX:
                wrapped = wrapped - 0x100000000
        else:
            wrapped = raw_result
        
        # Determine if exploitable
        exploit_viable = overflowed and (wrapped <= 0 or wrapped < initial)
        
        calc = OverflowCalculation(
            operation=operation,
            initial_value=initial,
            operand=operand,
            result=raw_result,
            overflowed=overflowed,
            wrapped_value=wrapped,
            exploit_viable=exploit_viable
        )
        self.calculations.append(calc)
        return calc
    
    def find_overflow_point(self, cost_per_unit: int, 
                            start_troops: int = 1000000) -> Tuple[int, int]:
        """
        Find exact troop count that causes overflow in cost calculation.
        Returns (threshold, wrapped_cost).
        """
        # cost = troops * cost_per_unit
        # Overflow when troops * cost_per_unit > INT32_MAX
        
        threshold = self.INT32_MAX // cost_per_unit
        
        # Verify
        at_threshold = threshold * cost_per_unit
        over_threshold = (threshold + 1) * cost_per_unit
        
        # Calculate wrapped value
        wrapped = over_threshold & 0xFFFFFFFF
        if wrapped > self.INT32_MAX:
            wrapped = wrapped - 0x100000000
        
        return threshold, wrapped
    
    def calculate_troop_glitch_thresholds(self) -> List[GlitchThreshold]:
        """Calculate glitch thresholds for all troop types."""
        thresholds = []
        
        for unit, costs in self.TROOP_COSTS.items():
            food_cost = costs['food']
            
            # Calculate overflow point for food cost
            overflow_troops, wrapped_cost = self.find_overflow_point(food_cost)
            
            # Known glitch threshold if available
            known_threshold = self.GLITCH_MULTIPLIERS.get(unit)
            
            threshold = GlitchThreshold(
                name=f"{unit.title()} Glitch",
                unit_type=unit,
                threshold_value=known_threshold or overflow_troops,
                overflow_point=overflow_troops,
                safe_max=overflow_troops - 1,
                mechanism="Integer overflow in cost calculation",
                formula=f"threshold = INT32_MAX / {food_cost} = {overflow_troops:,}",
                exploitation_steps=[
                    f"1. Queue {overflow_troops + 1:,} {unit}s",
                    f"2. Food cost wraps from {(overflow_troops + 1) * food_cost:,} to {wrapped_cost:,}",
                    "3. If wrapped value is negative, you GAIN resources",
                    "4. Cancel training to receive 'refund' of negative cost",
                ]
            )
            thresholds.append(threshold)
        
        self.thresholds = thresholds
        return thresholds
    
    def calculate_resource_glitch(self, resource_type: str, 
                                  current_amount: int) -> dict:
        """Calculate resource overflow exploit parameters."""
        # Resource storage is typically int32
        overflow_at = self.INT32_MAX - current_amount
        
        # Calculate what happens at overflow
        at_max = current_amount + overflow_at
        over_max = current_amount + overflow_at + 1
        wrapped = (over_max & 0xFFFFFFFF)
        if wrapped > self.INT32_MAX:
            wrapped = wrapped - 0x100000000
        
        return {
            'resource': resource_type,
            'current': current_amount,
            'overflow_threshold': overflow_at,
            'at_threshold': at_max,
            'wrapped_to': wrapped,
            'exploit': 'Overflow causes resource to wrap to negative, then add more to normalize',
            'steps': [
                f"1. Current {resource_type}: {current_amount:,}",
                f"2. Add {overflow_at + 1:,} to trigger overflow",
                f"3. {resource_type} wraps to {wrapped:,}",
                f"4. Add more {resource_type} to reach desired amount",
            ]
        }
    
    def calculate_upkeep_glitch(self, troop_counts: Dict[str, int]) -> dict:
        """Calculate negative upkeep exploit through troop overflow."""
        total_upkeep = 0
        breakdown = {}
        
        for unit, count in troop_counts.items():
            upkeep_rate = self.TROOP_UPKEEP.get(unit, 10)
            unit_upkeep = count * upkeep_rate
            
            # Check for overflow in individual calculation
            calc = self.calculate_overflow(count, upkeep_rate, 'multiply')
            
            breakdown[unit] = {
                'count': count,
                'rate': upkeep_rate,
                'raw_upkeep': unit_upkeep,
                'actual_upkeep': calc.wrapped_value,
                'overflowed': calc.overflowed,
            }
            
            total_upkeep += calc.wrapped_value
        
        return {
            'total_upkeep': total_upkeep,
            'breakdown': breakdown,
            'negative_upkeep': total_upkeep < 0,
            'exploit': 'Negative upkeep = food GENERATION instead of consumption' if total_upkeep < 0 else 'No exploit',
        }
    
    def calculate_prestige_overflow(self, current_prestige: int, 
                                    action_prestige: int) -> dict:
        """Calculate prestige overflow exploit."""
        calc = self.calculate_overflow(current_prestige, action_prestige, 'add')
        
        return {
            'current': current_prestige,
            'gain': action_prestige,
            'result': calc.wrapped_value,
            'overflowed': calc.overflowed,
            'exploit_viable': calc.exploit_viable,
            'recommendation': self._get_prestige_recommendation(current_prestige),
        }
    
    def _get_prestige_recommendation(self, current: int) -> str:
        """Get recommendation for prestige overflow exploit."""
        distance_to_overflow = self.INT32_MAX - current
        
        if distance_to_overflow > 1000000000:
            return "Far from overflow - farm normally"
        elif distance_to_overflow > 100000000:
            return "Getting close - consider rapid farming"
        else:
            return f"CLOSE TO OVERFLOW - {distance_to_overflow:,} prestige until wrap!"
    
    def generate_glitch_database(self) -> dict:
        """Generate complete glitch/exploit database."""
        self.calculate_troop_glitch_thresholds()
        
        database = {
            'generated': str(Path(__file__)),
            'constants': {
                'INT32_MAX': self.INT32_MAX,
                'INT32_MIN': self.INT32_MIN,
                'UINT32_MAX': self.UINT32_MAX,
            },
            'troop_glitch_thresholds': [asdict(t) for t in self.thresholds],
            'troop_costs': self.TROOP_COSTS,
            'troop_upkeep': self.TROOP_UPKEEP,
            'known_glitch_values': self.GLITCH_MULTIPLIERS,
            'exploitation_notes': [
                "Troop glitches work by overflowing the cost calculation",
                "When cost overflows to negative, canceling training gives RESOURCES",
                "Upkeep overflow can result in negative upkeep = resource generation",
                "Most effective: High-cost units (catapult) have lower thresholds",
                "Queue troops in barracks, then cancel before completion",
                "Server-side validation may catch some exploits - test carefully",
            ],
            'safe_values': {
                unit: self.GLITCH_MULTIPLIERS.get(unit, self.INT32_MAX // costs['food']) - 1
                for unit, costs in self.TROOP_COSTS.items()
            }
        }
        
        return database
    
    def save_database(self, output_path: Path = None):
        """Save glitch database to file."""
        if output_path is None:
            output_path = HUB_ROOT / "evony_hub" / "glitch_database.json"
        
        output_path.parent.mkdir(parents=True, exist_ok=True)
        database = self.generate_glitch_database()
        
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(database, f, indent=2)
        
        print(f"Glitch database saved to: {output_path}")
        return database


class ExploitParameterGenerator:
    """Generates specific exploit parameters for known vulnerabilities."""
    
    def __init__(self):
        self.calculator = GlitchCalculator()
    
    def generate_archer_glitch_params(self, target_gain: int = 1000000000) -> dict:
        """Generate parameters for archer glitch."""
        # Archer food cost: 350
        # Threshold: ~6,135,036 archers
        
        threshold = 6135036
        cost_at_threshold = threshold * 350
        cost_over = (threshold + 1) * 350
        
        # Wrapped value
        wrapped = cost_over - (1 << 32) if cost_over > GlitchCalculator.INT32_MAX else cost_over
        
        return {
            'exploit_name': 'Archer Food Glitch',
            'mechanism': 'Integer overflow in training cost calculation',
            'parameters': {
                'unit_type': 'archer',
                'queue_amount': threshold + 1,
                'food_cost_per_unit': 350,
                'expected_cost': cost_at_threshold,
                'actual_cost_displayed': wrapped,
                'food_gain_on_cancel': abs(wrapped) if wrapped < 0 else 0,
            },
            'steps': [
                "1. Ensure barracks level allows large queues",
                "2. Have enough food for apparent cost (may show 0 or negative)",
                f"3. Queue exactly {threshold + 1:,} archers",
                "4. Verify cost display shows abnormal value",
                "5. Start training, then immediately cancel",
                "6. Check food - should have gained resources",
            ],
            'variations': [
                {'archers': threshold + 100, 'note': 'Larger overflow'},
                {'archers': threshold + 1000, 'note': 'Even larger gain'},
                {'archers': threshold * 2, 'note': 'Double overflow - may wrap back'},
            ],
            'risks': [
                "Server-side validation may reject",
                "Account flag for suspicious activity",
                "Rollback possible if detected",
            ]
        }
    
    def generate_resource_transfer_exploit(self, 
                                           source_food: int,
                                           target_coord: str) -> dict:
        """Generate parameters for resource transfer exploit."""
        # Exploit: Send negative resources via transport overflow
        
        calc = GlitchCalculator()
        overflow_point, wrapped = calc.find_overflow_point(1)  # 1:1 ratio
        
        return {
            'exploit_name': 'Resource Transfer Overflow',
            'mechanism': 'Overflow in transport resource calculation',
            'current_food': source_food,
            'target': target_coord,
            'parameters': {
                'send_amount': overflow_point + source_food,
                'apparent_received': wrapped + source_food,
            },
            'steps': [
                f"1. Current food: {source_food:,}",
                f"2. Send transport to {target_coord}",
                f"3. Set food amount to {overflow_point + source_food:,}",
                "4. If accepted, target receives wrapped amount",
            ],
            'note': 'Most servers validate transport amounts server-side'
        }
    
    def generate_timing_exploit(self, action_type: str) -> dict:
        """Generate timing/race condition exploit parameters."""
        return {
            'exploit_name': f'{action_type} Timing Exploit',
            'mechanism': 'Race condition in action processing',
            'technique': 'Double-action through rapid packet sending',
            'parameters': {
                'action': action_type,
                'packet_delay_ms': 50,
                'simultaneous_requests': 2,
            },
            'steps': [
                "1. Prepare two identical action requests",
                "2. Send both packets within 50ms window",
                "3. Server may process both before validation",
                "4. Result: Action performed twice with single cost",
            ],
            'applicable_actions': [
                'item_use',
                'medal_award', 
                'quest_complete',
                'chest_open',
            ]
        }


def run_glitch_calculator():
    """Run glitch calculator and generate database."""
    print("=" * 60)
    print("EVONY GLITCH CALCULATOR")
    print("=" * 60)
    
    calc = GlitchCalculator()
    
    print("\n[1] Calculating Troop Glitch Thresholds...")
    thresholds = calc.calculate_troop_glitch_thresholds()
    
    print("\nTROOP GLITCH THRESHOLDS:")
    print("-" * 50)
    for t in thresholds:
        print(f"  {t.unit_type.upper()}: {t.threshold_value:,} troops")
        print(f"    Formula: {t.formula}")
    
    print("\n[2] Generating Glitch Database...")
    calc.save_database()
    
    print("\n[3] Generating Specific Exploit Parameters...")
    gen = ExploitParameterGenerator()
    
    archer_params = gen.generate_archer_glitch_params()
    print(f"\nARCHER GLITCH:")
    print(f"  Queue: {archer_params['parameters']['queue_amount']:,} archers")
    print(f"  Expected gain: {archer_params['parameters']['food_gain_on_cancel']:,} food")
    
    return calc


if __name__ == "__main__":
    run_glitch_calculator()
