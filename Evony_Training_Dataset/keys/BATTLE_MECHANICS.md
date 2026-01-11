# Evony Age II - Battle Mechanics

> **"Combat Protocols"** - Reverse-Engineered Battle Formulas and Data

---

## Overview

This document contains reverse-engineered battle mechanics from RoboEvony, AutoEvony, SPITFIRE private server source, and community research (2010-2018). These formulas are essential for bot development and combat optimization.

---

## Combat Formula Foundation

### Basic Attack Calculation

```
Base Damage = (Attacker_Attack × Attacker_Count) / (Defender_Defense + 1)
```

### Full Combat Formula

```python
def calculate_damage(attacker, defender, hero_attack=0, tech_bonus=0, terrain_mod=1.0):
    """
    Calculate damage dealt by attacker to defender.
    
    From SPITFIRE source and RoboEvony analysis.
    """
    # Base attack power
    base_attack = attacker.attack * attacker.count
    
    # Hero bonus (percentage)
    hero_modifier = 1 + (hero_attack / 100)
    
    # Technology bonus (percentage)  
    tech_modifier = 1 + (tech_bonus / 100)
    
    # Terrain modifier (valleys, flatland, etc.)
    terrain = terrain_mod
    
    # Defense reduction
    defense_factor = defender.defense * defender.count
    
    # Final damage calculation
    effective_attack = base_attack * hero_modifier * tech_modifier * terrain
    damage = effective_attack / (1 + defense_factor / 1000)
    
    return int(damage)
```

### Defense Calculation

```python
def calculate_defense(defender, wall_level=0, hero_defense=0, fortification=0):
    """
    Calculate effective defense value.
    """
    base_defense = defender.defense * defender.count
    
    # Wall bonus (5% per level)
    wall_bonus = 1 + (wall_level * 0.05)
    
    # Hero defense bonus
    hero_mod = 1 + (hero_defense / 100)
    
    # Fortification (traps, abatis, etc.)
    fort_bonus = fortification * 0.1
    
    return int(base_defense * wall_bonus * hero_mod + fort_bonus)
```

---

## Troop Combat Statistics

### Base Troop Stats (Age II)

| Troop | Attack | Defense | HP | Speed | Range | Load | Upkeep |
|-------|--------|---------|----|----|-------|------|--------|
| Worker | 5 | 5 | 100 | 100 | 20 | 200 | 1 |
| Warrior | 50 | 50 | 200 | 150 | 20 | 30 | 2 |
| Scout | 20 | 20 | 100 | 3000 | 20 | 5 | 2 |
| Pikeman | 150 | 150 | 300 | 200 | 20 | 50 | 3 |
| Swordsman | 250 | 250 | 450 | 175 | 20 | 60 | 4 |
| Archer | 120 | 50 | 250 | 250 | 1200 | 35 | 3 |
| Cavalry | 250 | 180 | 500 | 1000 | 20 | 100 | 6 |
| Cataphract | 350 | 350 | 750 | 750 | 20 | 120 | 8 |
| Transporter | 10 | 80 | 500 | 150 | 20 | 5000 | 8 |
| Ballista | 450 | 160 | 320 | 100 | 1400 | 80 | 7 |
| Battering Ram | 250 | 160 | 500 | 120 | 20 | 100 | 10 |
| Catapult | 600 | 200 | 480 | 80 | 1500 | 120 | 12 |

### Combat Priority Order

1. **Ranged First**: Archers, Ballista, Catapults attack first
2. **Cavalry Charge**: Cavalry/Cataphract engage
3. **Infantry Clash**: Warriors, Pikemen, Swordsmen
4. **Siege Damage**: Rams target fortifications
5. **Cleanup**: Remaining units

---

## NPC Battle Data

### NPC Defense Compositions by Level

| Level | Warrior | Pike | Sword | Archer | Cavalry | Cataphract | Ballista |
|-------|---------|------|-------|--------|---------|------------|----------|
| 1 | 10 | 0 | 0 | 5 | 0 | 0 | 0 |
| 2 | 20 | 10 | 0 | 10 | 0 | 0 | 0 |
| 3 | 50 | 30 | 0 | 25 | 10 | 0 | 0 |
| 4 | 100 | 60 | 30 | 50 | 25 | 0 | 10 |
| 5 | 200 | 120 | 60 | 100 | 50 | 20 | 20 |
| 6 | 500 | 300 | 150 | 250 | 120 | 50 | 50 |
| 7 | 1000 | 600 | 300 | 500 | 250 | 100 | 100 |
| 8 | 2500 | 1500 | 750 | 1200 | 600 | 250 | 170 |
| 9 | 5000 | 3000 | 1500 | 2500 | 1200 | 500 | 250 |
| 10 | 10000 | 6000 | 3000 | 5000 | 2500 | 1000 | 550 |

### NPC Ballista Counts (Critical for Farming)

From RoboEvony documentation:

```python
NPC_BALLISTA = {
    1: 0,
    2: 0,
    3: 0,
    4: 10,
    5: 20,
    6: 50,
    7: 100,
    8: 170,
    9: 250,
    10: 550
}
```

### RoboEvony NPC10 Default Attack Composition

```python
# From roboev.webstarts.com
NPC10_ATTACK = {
    "archer": 91100,
    "warrior": 2000,
    "worker": 2000,
    "scout": 3000,
    "transporter": 1900
}
```

---

## Valley Combat Data

### Valley Archer Requirements by Level

From RoboEvony scripting documentation:

```python
VALLEY_ARCHERS = {
    1: 50,
    2: 100,
    3: 200,
    4: 400,
    5: 800,
    6: 1600,
    7: 3200,
    8: 6400,
    9: 12800,
    10: 19990  # Note: Not 20000, specific value
}
```

### Valley Terrain Modifiers

| Valley Type | Attack Mod | Defense Mod | Notes |
|-------------|------------|-------------|-------|
| Grassland | 1.00 | 1.00 | Standard |
| Forest | 0.90 | 1.10 | Archers +10% |
| Desert | 1.10 | 0.90 | Cavalry +15% |
| Hill | 0.85 | 1.15 | Defensive bonus |
| Lake | 0.80 | 1.20 | Strong defense |
| Swamp | 0.70 | 1.00 | Mobility penalty |
| Flat | 1.10 | 0.95 | Cavalry advantage |

---

## Hero Combat Formulas

### Hero Attribute Effects

```python
def hero_combat_bonus(hero_attack, hero_politics, hero_intel):
    """
    Calculate hero bonuses for combat.
    """
    return {
        "attack_bonus": hero_attack * 0.5,      # +0.5% per attack point
        "defense_bonus": hero_politics * 0.25,   # +0.25% per politics point
        "speed_bonus": hero_intel * 0.1,         # +0.1% march speed per intel
        "load_bonus": hero_politics * 1.0        # +1% load per politics point
    }
```

### Hero Experience Formula

```python
def experience_per_kill(enemy_type, enemy_count, enemy_level):
    """
    Calculate hero experience from kills.
    """
    base_exp = {
        "worker": 1,
        "warrior": 2,
        "scout": 2,
        "pikeman": 3,
        "swordsman": 4,
        "archer": 3,
        "cavalry": 5,
        "cataphract": 7,
        "transporter": 2,
        "ballista": 6,
        "ram": 8,
        "catapult": 10
    }
    
    return base_exp.get(enemy_type, 1) * enemy_count * (1 + enemy_level * 0.1)
```

### Hero Level Requirements

| Level | Experience Required | Cumulative |
|-------|--------------------:|----------:|
| 1 | 0 | 0 |
| 10 | 1,000 | 5,500 |
| 25 | 10,000 | 137,500 |
| 50 | 50,000 | 1,275,000 |
| 75 | 150,000 | 5,775,000 |
| 100 | 500,000 | 25,500,000 |

---

## Combat Mechanics

### Attack Waves

```python
def calculate_wave_timing(distance, speed, wave_count):
    """
    Calculate timing for multi-wave attacks.
    
    Args:
        distance: Map tiles to target
        speed: Slowest troop speed
        wave_count: Number of waves
    
    Returns:
        List of send times in seconds
    """
    travel_time = (distance * 60) / speed  # seconds
    
    # Waves should arrive 1 second apart
    wave_times = []
    for i in range(wave_count):
        send_time = -i  # Send earlier waves first
        wave_times.append({
            "wave": i + 1,
            "send_delay": abs(send_time),
            "arrival": travel_time
        })
    
    return wave_times
```

### Combat Round Sequence

1. **Round Start**: Both sides calculate effective stats
2. **Range Phase**: Units with range > 20 attack first
3. **Melee Phase**: Close combat units engage
4. **Siege Phase**: Rams/Catapults damage walls
5. **Casualty Calculation**: Deaths processed
6. **Round End**: Check for victory conditions

### Victory Conditions

- **Attacker Wins**: All defenders eliminated
- **Defender Wins**: All attackers eliminated
- **Stalemate**: 100 rounds with no victor (attacker retreats)

---

## Wall and Fortification

### Wall Defense Bonus

```python
WALL_DEFENSE_BONUS = {
    0: 1.00,
    1: 1.05,
    2: 1.10,
    3: 1.15,
    4: 1.20,
    5: 1.30,
    6: 1.40,
    7: 1.55,
    8: 1.70,
    9: 1.90,
    10: 2.10
}
```

### Fortification Effects

| Type | Defense Bonus | Troop Killed | Capacity |
|------|--------------|--------------|----------|
| Trap | +5 | 1 Cavalry | 2000 |
| Abatis | +10 | 2 Cavalry | 2000 |
| Archer Tower | +25 | Ranged Attack | 2000 |
| Rolling Log | +15 | 3 Ground | 2000 |
| Defensive Trebuchet | +50 | AoE Damage | 1000 |

---

## Combat Simulation Code

### Python Battle Simulator

```python
class BattleSimulator:
    """
    Simulate Evony battles for bot optimization.
    """
    
    def __init__(self):
        self.max_rounds = 100
    
    def simulate(self, attacker_army, defender_army, 
                 attacker_hero=None, defender_hero=None,
                 wall_level=0, fortifications=None):
        """
        Run full battle simulation.
        
        Returns:
            {
                "winner": "attacker" | "defender" | "stalemate",
                "rounds": int,
                "attacker_losses": {...},
                "defender_losses": {...},
                "hero_exp": int
            }
        """
        results = {
            "winner": None,
            "rounds": 0,
            "attacker_losses": {},
            "defender_losses": {}
        }
        
        for round_num in range(1, self.max_rounds + 1):
            results["rounds"] = round_num
            
            # Range phase
            self._range_phase(attacker_army, defender_army)
            
            # Melee phase
            self._melee_phase(attacker_army, defender_army)
            
            # Check victory
            if self._all_dead(defender_army):
                results["winner"] = "attacker"
                break
            elif self._all_dead(attacker_army):
                results["winner"] = "defender"
                break
        
        if results["winner"] is None:
            results["winner"] = "stalemate"
        
        return results
    
    def estimate_losses(self, attacker_army, npc_level):
        """
        Quick estimate for NPC farming optimization.
        """
        npc_army = self._get_npc_army(npc_level)
        result = self.simulate(attacker_army.copy(), npc_army)
        return result["attacker_losses"]
```

---

## Related Documentation

- `TROOP_DATA.md` - Complete troop statistics
- `NPC_FARMING.md` - Optimal farming strategies
- `COMMAND_REFERENCE.md` - Protocol commands for combat
- `BOT_SCRIPTING.md` - Automation scripts

---

*Document Version: 1.0.0 | Sources: SPITFIRE, RoboEvony, AutoEvony, Community Research*
