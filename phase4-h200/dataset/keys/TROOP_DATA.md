# Evony Age II - Troop Data Reference

> **"Unit Database"** - Complete Troop Statistics and Requirements

---

## Overview

Complete reference for all troop types in Evony Age II, including base stats, training requirements, combat roles, and optimization data.

---

## Troop Statistics

### Complete Troop Table

| Troop | Attack | Defense | HP | Speed | Range | Load | Upkeep | Pop |
|-------|--------|---------|----|----|-------|------|--------|-----|
| Worker | 5 | 5 | 100 | 100 | 20 | 200 | 1 | 1 |
| Warrior | 50 | 50 | 200 | 150 | 20 | 30 | 2 | 1 |
| Scout | 20 | 20 | 100 | 3000 | 20 | 5 | 2 | 1 |
| Pikeman | 150 | 150 | 300 | 200 | 20 | 50 | 3 | 1 |
| Swordsman | 250 | 250 | 450 | 175 | 20 | 60 | 4 | 1 |
| Archer | 120 | 50 | 250 | 250 | 1200 | 35 | 3 | 1 |
| Cavalry | 250 | 180 | 500 | 1000 | 20 | 100 | 6 | 2 |
| Cataphract | 350 | 350 | 750 | 750 | 20 | 120 | 8 | 3 |
| Transporter | 10 | 80 | 500 | 150 | 20 | 5000 | 8 | 3 |
| Ballista | 450 | 160 | 320 | 100 | 1400 | 80 | 7 | 4 |
| Battering Ram | 250 | 160 | 500 | 120 | 20 | 100 | 10 | 5 |
| Catapult | 600 | 200 | 480 | 80 | 1500 | 120 | 12 | 6 |

---

## Training Requirements

### Building Requirements

| Troop | Barracks Level | Required Buildings | Tech Requirements |
|-------|----------------|-------------------|-------------------|
| Worker | 1 | - | - |
| Warrior | 1 | - | - |
| Scout | 2 | Beacon Tower 1 | - |
| Pikeman | 3 | - | Military Science 1 |
| Swordsman | 5 | Forge 1 | Military Science 2, Iron Working 2 |
| Archer | 4 | - | Archery 1 |
| Cavalry | 6 | Stable 1 | Horseback Riding 2 |
| Cataphract | 8 | Stable 4 | Horseback Riding 5, Iron Working 4 |
| Transporter | 5 | Workshop 1 | - |
| Ballista | 7 | Workshop 4 | Military Science 4 |
| Battering Ram | 8 | Workshop 5 | Military Science 5 |
| Catapult | 9 | Workshop 7 | Military Science 6 |

### Resource Costs

| Troop | Gold | Food | Wood | Stone | Iron | Time (base) |
|-------|------|------|------|-------|------|-------------|
| Worker | 50 | 150 | 50 | 0 | 0 | 15s |
| Warrior | 100 | 200 | 50 | 0 | 50 | 25s |
| Scout | 100 | 200 | 100 | 0 | 0 | 20s |
| Pikeman | 300 | 400 | 200 | 0 | 100 | 45s |
| Swordsman | 500 | 600 | 200 | 0 | 300 | 75s |
| Archer | 250 | 350 | 400 | 0 | 0 | 35s |
| Cavalry | 500 | 800 | 100 | 0 | 350 | 90s |
| Cataphract | 800 | 1200 | 200 | 0 | 600 | 150s |
| Transporter | 400 | 400 | 500 | 200 | 0 | 60s |
| Ballista | 1000 | 800 | 1000 | 500 | 300 | 180s |
| Battering Ram | 1500 | 1000 | 1500 | 1000 | 400 | 240s |
| Catapult | 2000 | 1500 | 1500 | 1200 | 800 | 300s |

---

## Training Time Formulas

### Base Training Time

```python
def training_time(base_time, barracks_level, rally_spot_level, tech_level):
    """
    Calculate actual training time per unit.
    
    Args:
        base_time: Base training time in seconds
        barracks_level: Level of barracks
        rally_spot_level: Level of rally spot
        tech_level: Military Tradition level
    """
    # Barracks reduces time by 10% per level
    barracks_mod = 1 - (barracks_level * 0.10)
    
    # Rally spot bonus (minor)
    rally_mod = 1 - (rally_spot_level * 0.02)
    
    # Military Tradition reduces by 10% per level
    tech_mod = 1 - (tech_level * 0.10)
    
    return int(base_time * barracks_mod * rally_mod * tech_mod)
```

### Queue Capacity

```python
QUEUE_CAPACITY = {
    1: 100,
    2: 200,
    3: 400,
    4: 800,
    5: 1500,
    6: 3000,
    7: 5000,
    8: 8000,
    9: 12000,
    10: 20000
}
```

---

## Combat Roles

### Role Classification

| Role | Troops | Primary Use |
|------|--------|-------------|
| **Tank** | Warrior, Pikeman, Swordsman | Absorb damage |
| **DPS** | Archer, Ballista, Catapult | Deal damage |
| **Cavalry** | Cavalry, Cataphract | Quick strikes |
| **Siege** | Battering Ram, Catapult | Wall destruction |
| **Support** | Worker, Scout, Transporter | Utility |

### Combat Phase Priority

```python
COMBAT_PRIORITY = {
    "ranged": ["Archer", "Ballista", "Catapult"],     # Phase 1
    "cavalry": ["Cavalry", "Cataphract"],              # Phase 2
    "infantry": ["Warrior", "Pikeman", "Swordsman"],   # Phase 3
    "siege": ["Battering Ram"],                         # Phase 4
    "support": ["Worker", "Scout", "Transporter"]      # Last
}
```

---

## Speed Reference

### March Speed Calculation

```python
def march_speed(troops, hero_intel=0, tech_level=0):
    """
    Calculate march speed (slowest unit determines speed).
    """
    speeds = {
        "Worker": 100,
        "Warrior": 150,
        "Scout": 3000,
        "Pikeman": 200,
        "Swordsman": 175,
        "Archer": 250,
        "Cavalry": 1000,
        "Cataphract": 750,
        "Transporter": 150,
        "Ballista": 100,
        "Battering Ram": 120,
        "Catapult": 80
    }
    
    # Get slowest unit in march
    slowest = min(speeds[t] for t in troops if troops[t] > 0)
    
    # Hero intelligence bonus
    intel_bonus = 1 + (hero_intel * 0.001)
    
    # Compass tech bonus (10% per level)
    tech_bonus = 1 + (tech_level * 0.10)
    
    return int(slowest * intel_bonus * tech_bonus)
```

### Speed Tiers

| Speed | Time per Tile | Troops |
|-------|---------------|--------|
| 3000 | 1.2s | Scout |
| 1000 | 3.6s | Cavalry |
| 750 | 4.8s | Cataphract |
| 250 | 14.4s | Archer |
| 200 | 18s | Pikeman |
| 175 | 20.6s | Swordsman |
| 150 | 24s | Warrior, Transporter |
| 120 | 30s | Battering Ram |
| 100 | 36s | Worker, Ballista |
| 80 | 45s | Catapult |

---

## Load Capacity

### Resource Carrying

```python
def calculate_load(troops, hero_politics=0, tech_level=0):
    """
    Calculate total carrying capacity.
    """
    loads = {
        "Worker": 200,
        "Warrior": 30,
        "Scout": 5,
        "Pikeman": 50,
        "Swordsman": 60,
        "Archer": 35,
        "Cavalry": 100,
        "Cataphract": 120,
        "Transporter": 5000,
        "Ballista": 80,
        "Battering Ram": 100,
        "Catapult": 120
    }
    
    base_load = sum(loads[t] * count for t, count in troops.items())
    
    # Hero politics bonus (1% per point)
    politics_bonus = 1 + (hero_politics * 0.01)
    
    # Logistics tech bonus (10% per level)
    tech_bonus = 1 + (tech_level * 0.10)
    
    return int(base_load * politics_bonus * tech_bonus)
```

### Optimal Farming Compositions

| Purpose | Composition | Load | Speed |
|---------|-------------|------|-------|
| Fast Farm | 10k Cavalry | 1M | 1000 |
| Heavy Farm | 20k Archer + 5k Transporter | 25.7M | 150 |
| Max Load | 50k Transporter | 250M | 150 |
| Scout Run | 100 Scout | 500 | 3000 |

---

## Upkeep Management

### Hourly Food Consumption

```python
def hourly_upkeep(troops):
    """
    Calculate hourly food consumption.
    """
    upkeep = {
        "Worker": 1,
        "Warrior": 2,
        "Scout": 2,
        "Pikeman": 3,
        "Swordsman": 4,
        "Archer": 3,
        "Cavalry": 6,
        "Cataphract": 8,
        "Transporter": 8,
        "Ballista": 7,
        "Battering Ram": 10,
        "Catapult": 12
    }
    
    return sum(upkeep[t] * count for t, count in troops.items())
```

### Food Balance Calculator

```python
def food_sustainability(food_rate, troops):
    """
    Calculate hours until food runs out.
    
    Args:
        food_rate: Net food production per hour
        troops: Dict of troop counts
    """
    upkeep = hourly_upkeep(troops)
    net_food = food_rate - upkeep
    
    if net_food >= 0:
        return float('inf')  # Sustainable
    else:
        return abs(net_food)  # Hours until starvation
```

---

## Troop Counters

### Effectiveness Matrix

| Attacker ↓ vs Defender → | Warrior | Pike | Sword | Archer | Cavalry | Cata |
|--------------------------|---------|------|-------|--------|---------|------|
| Warrior | 1.0 | 0.8 | 0.7 | 0.9 | 0.6 | 0.5 |
| Pikeman | 1.2 | 1.0 | 0.9 | 0.8 | 1.5 | 1.2 |
| Swordsman | 1.3 | 1.1 | 1.0 | 1.0 | 0.7 | 0.6 |
| Archer | 1.1 | 1.2 | 1.0 | 1.0 | 0.8 | 0.7 |
| Cavalry | 1.4 | 0.7 | 1.3 | 1.5 | 1.0 | 0.8 |
| Cataphract | 1.5 | 0.9 | 1.4 | 1.6 | 1.2 | 1.0 |

> Values > 1.0 = Effective, < 1.0 = Ineffective

### Counter Guide

- **Pikemen** → Counter Cavalry/Cataphract
- **Archers** → Counter Infantry (from range)
- **Cavalry** → Counter Archers
- **Cataphract** → All-purpose heavy unit
- **Swordsmen** → Tank for archers

---

## Population Impact

### Population Costs

| Troop | Pop per Unit | Max at Pop 100k |
|-------|-------------|-----------------|
| Worker | 1 | 100,000 |
| Warrior | 1 | 100,000 |
| Scout | 1 | 100,000 |
| Pikeman | 1 | 100,000 |
| Swordsman | 1 | 100,000 |
| Archer | 1 | 100,000 |
| Cavalry | 2 | 50,000 |
| Cataphract | 3 | 33,333 |
| Transporter | 3 | 33,333 |
| Ballista | 4 | 25,000 |
| Battering Ram | 5 | 20,000 |
| Catapult | 6 | 16,666 |

---

## Python Reference

```python
# Troop data structure for bots
TROOP_DATA = {
    "worker": {"attack": 5, "defense": 5, "hp": 100, "speed": 100, "range": 20, "load": 200, "upkeep": 1, "pop": 1},
    "warrior": {"attack": 50, "defense": 50, "hp": 200, "speed": 150, "range": 20, "load": 30, "upkeep": 2, "pop": 1},
    "scout": {"attack": 20, "defense": 20, "hp": 100, "speed": 3000, "range": 20, "load": 5, "upkeep": 2, "pop": 1},
    "pikeman": {"attack": 150, "defense": 150, "hp": 300, "speed": 200, "range": 20, "load": 50, "upkeep": 3, "pop": 1},
    "swordsman": {"attack": 250, "defense": 250, "hp": 450, "speed": 175, "range": 20, "load": 60, "upkeep": 4, "pop": 1},
    "archer": {"attack": 120, "defense": 50, "hp": 250, "speed": 250, "range": 1200, "load": 35, "upkeep": 3, "pop": 1},
    "cavalry": {"attack": 250, "defense": 180, "hp": 500, "speed": 1000, "range": 20, "load": 100, "upkeep": 6, "pop": 2},
    "cataphract": {"attack": 350, "defense": 350, "hp": 750, "speed": 750, "range": 20, "load": 120, "upkeep": 8, "pop": 3},
    "transporter": {"attack": 10, "defense": 80, "hp": 500, "speed": 150, "range": 20, "load": 5000, "upkeep": 8, "pop": 3},
    "ballista": {"attack": 450, "defense": 160, "hp": 320, "speed": 100, "range": 1400, "load": 80, "upkeep": 7, "pop": 4},
    "ram": {"attack": 250, "defense": 160, "hp": 500, "speed": 120, "range": 20, "load": 100, "upkeep": 10, "pop": 5},
    "catapult": {"attack": 600, "defense": 200, "hp": 480, "speed": 80, "range": 1500, "load": 120, "upkeep": 12, "pop": 6}
}
```

---

## Related Documentation

- `BATTLE_MECHANICS.md` - Combat formulas
- `NPC_FARMING.md` - Farming strategies
- `BOT_SCRIPTING.md` - Automation

---

*Document Version: 1.0.0 | Sources: SPITFIRE, RoboEvony, AutoEvony*
