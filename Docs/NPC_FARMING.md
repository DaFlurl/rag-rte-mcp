# Evony Age II - NPC Farming Guide

> **"Farming Protocols"** - Optimal NPC Farming Strategies for Bots

---

## Overview

NPC farming is the core resource acquisition method in Evony. This guide covers optimal army compositions, timing, and bot configurations for maximum efficiency.

---

## NPC Level Data

### NPC Garrison by Level

| Level | Warrior | Pike | Sword | Archer | Cavalry | Cata | Ballista | Wall |
|-------|---------|------|-------|--------|---------|------|----------|------|
| 1 | 10 | 0 | 0 | 5 | 0 | 0 | 0 | 1 |
| 2 | 20 | 10 | 0 | 10 | 0 | 0 | 0 | 2 |
| 3 | 50 | 30 | 0 | 25 | 10 | 0 | 0 | 3 |
| 4 | 100 | 60 | 30 | 50 | 25 | 0 | 10 | 4 |
| 5 | 200 | 120 | 60 | 100 | 50 | 20 | 20 | 5 |
| 6 | 500 | 300 | 150 | 250 | 120 | 50 | 50 | 6 |
| 7 | 1000 | 600 | 300 | 500 | 250 | 100 | 100 | 7 |
| 8 | 2500 | 1500 | 750 | 1200 | 600 | 250 | 170 | 8 |
| 9 | 5000 | 3000 | 1500 | 2500 | 1200 | 500 | 250 | 9 |
| 10 | 10000 | 6000 | 3000 | 5000 | 2500 | 1000 | 550 | 10 |

### NPC Loot by Level

| Level | Gold | Food | Wood | Stone | Iron | Medal Chance |
|-------|------|------|------|-------|------|--------------|
| 1 | 500 | 500 | 500 | 500 | 500 | 1% |
| 2 | 1000 | 1000 | 1000 | 1000 | 1000 | 2% |
| 3 | 2500 | 2500 | 2500 | 2500 | 2500 | 3% |
| 4 | 5000 | 5000 | 5000 | 5000 | 5000 | 5% |
| 5 | 10000 | 10000 | 10000 | 10000 | 10000 | 7% |
| 6 | 25000 | 25000 | 25000 | 25000 | 25000 | 10% |
| 7 | 50000 | 50000 | 50000 | 50000 | 50000 | 15% |
| 8 | 100000 | 100000 | 100000 | 100000 | 100000 | 20% |
| 9 | 200000 | 200000 | 200000 | 200000 | 200000 | 25% |
| 10 | 500000 | 500000 | 500000 | 500000 | 500000 | 35% |

---

## Optimal Attack Compositions

### Minimum Archer Counts (Zero Loss)

From RoboEvony documentation:

```python
MIN_ARCHERS_ZERO_LOSS = {
    1: 100,
    2: 200,
    3: 500,
    4: 1000,
    5: 2500,
    6: 5000,
    7: 10000,
    8: 25000,
    9: 50000,
    10: 100000
}
```

### RoboEvony Default NPC10 Composition

```python
# Standard NPC10 attack composition
NPC10_ATTACK = {
    "archer": 91100,
    "warrior": 2000,
    "worker": 2000,
    "scout": 3000,
    "transporter": 1900
}

# Losses per attack (approx)
NPC10_LOSSES = {
    "archer": 500,      # Varies with hero
    "warrior": 100,
    "scout": 50
}
```

### Economic Efficiency by Level

| Level | Archers Needed | Expected Loss | Profit per Attack | Efficiency |
|-------|----------------|---------------|-------------------|------------|
| 5 | 2,500 | 50 | 45,000 | High |
| 6 | 5,000 | 100 | 120,000 | High |
| 7 | 10,000 | 200 | 240,000 | Medium |
| 8 | 25,000 | 500 | 480,000 | Medium |
| 9 | 50,000 | 1000 | 950,000 | Medium |
| 10 | 100,000 | 2000 | 2,400,000 | High |

---

## Hero Configuration

### Optimal Hero Stats for Farming

```python
def hero_priority_npc_farming():
    """
    Hero attribute priority for NPC farming.
    """
    return {
        "attack": 1,      # Highest priority - reduces losses
        "politics": 2,    # Second - increases load
        "intelligence": 3  # Third - slightly faster marches
    }
```

### Hero Attack Thresholds

| Hero Attack | NPC5 Loss | NPC10 Loss | Recommended Level |
|-------------|-----------|------------|-------------------|
| 50 | 100 | 3000 | NPC5 |
| 100 | 50 | 2000 | NPC7 |
| 150 | 25 | 1500 | NPC8 |
| 200 | 10 | 1000 | NPC9 |
| 250+ | 5 | 500 | NPC10 |

---

## Wave Attacks

### Multi-Wave Strategy

```python
def calculate_waves(target_level, available_archers, hero_attack):
    """
    Calculate optimal number of waves.
    """
    min_per_wave = MIN_ARCHERS_ZERO_LOSS[target_level]
    
    # Add buffer for hero attack level
    buffer_multiplier = 1.0 - (hero_attack / 500)  # Max 50% reduction
    adjusted_min = int(min_per_wave * max(0.5, buffer_multiplier))
    
    # Calculate waves
    max_waves = available_archers // adjusted_min
    
    return min(max_waves, 10)  # Cap at 10 waves
```

### Wave Timing

```python
def wave_timing(distance, speed=250):
    """
    Calculate when to send each wave for simultaneous arrival.
    
    Waves should arrive 1-2 seconds apart.
    """
    travel_time = (distance * 3600) / speed  # seconds
    
    waves = []
    for i in range(10):
        wave = {
            "wave_number": i + 1,
            "send_delay": i * 2,  # 2 second spacing
            "arrival_time": travel_time
        }
        waves.append(wave)
    
    return waves
```

---

## Bot Scripting Examples

### AutoEvony NPC Farm Script

```
// npc_farm_basic.txt
// Basic NPC farming script

// Configuration
set npc_level = 5
set min_archers = 2500
set wait_time = 300

// Main loop
LOOP 1000
    // Check archer count
    IF $archers > min_archers
        // Find nearest NPC of target level
        ATTACK_NPC $npc_level 1
        
        // Wait for return
        WAIT $wait_time
    ELSE
        // Not enough archers, wait for training
        LOG "Waiting for archers..."
        WAIT 600
    ENDIF
END
```

### RoboEvony Task Configuration

```xml
<!-- npc_farm_task.xml -->
<task name="FarmNPC10" priority="50" enabled="true">
    <trigger>
        <condition type="troops" troop="archer" operator="gt" value="90000"/>
        <condition type="hero" attribute="attack" operator="gt" value="150"/>
        <condition type="interval" minutes="10"/>
    </trigger>
    
    <action type="attackNpc">
        <param name="level" value="10"/>
        <param name="waves" value="1"/>
        <param name="composition">
            <archer>91100</archer>
            <warrior>2000</warrior>
            <worker>2000</worker>
            <scout>3000</scout>
            <transporter>1900</transporter>
        </param>
    </action>
    
    <postAction type="wait" duration="180"/>
</task>
```

### Python Bot Example

```python
class NPCFarmer:
    """
    Automated NPC farming bot.
    """
    
    def __init__(self, client, config):
        self.client = client
        self.config = config
        self.min_archers = {
            5: 2500, 6: 5000, 7: 10000,
            8: 25000, 9: 50000, 10: 100000
        }
    
    def find_nearest_npc(self, level, city_x, city_y, radius=50):
        """
        Find nearest NPC of specified level.
        """
        npcs = []
        for x in range(city_x - radius, city_x + radius):
            for y in range(city_y - radius, city_y + radius):
                tile = self.client.send({
                    "cmd": "map.getTile",
                    "x": x, "y": y
                })
                if tile["data"]["type"] == 1 and tile["data"]["level"] == level:
                    distance = abs(x - city_x) + abs(y - city_y)
                    npcs.append({"x": x, "y": y, "distance": distance})
        
        return sorted(npcs, key=lambda n: n["distance"])[0] if npcs else None
    
    def can_attack(self, level):
        """
        Check if we have enough troops.
        """
        troops = self.client.get_troops()
        return troops.get("archer", 0) >= self.min_archers.get(level, 999999)
    
    def attack_npc(self, npc, hero_id):
        """
        Send attack to NPC.
        """
        composition = self.get_composition(npc["level"])
        
        return self.client.send({
            "cmd": "army.march",
            "cityId": self.config["city_id"],
            "targetX": npc["x"],
            "targetY": npc["y"],
            "heroId": hero_id,
            "troops": composition,
            "missionType": 1  # Attack
        })
    
    def get_composition(self, level):
        """
        Get optimal composition for NPC level.
        """
        compositions = {
            5: {"archer": 3000, "warrior": 200, "scout": 100},
            6: {"archer": 6000, "warrior": 300, "scout": 200},
            7: {"archer": 12000, "warrior": 500, "scout": 300},
            8: {"archer": 30000, "warrior": 1000, "scout": 500},
            9: {"archer": 60000, "warrior": 1500, "scout": 1000},
            10: {"archer": 91100, "warrior": 2000, "worker": 2000, 
                 "scout": 3000, "transporter": 1900}
        }
        return compositions.get(level, compositions[5])
    
    def run(self):
        """
        Main farming loop.
        """
        while True:
            for level in [10, 9, 8, 7, 6, 5]:  # Highest first
                if self.can_attack(level):
                    npc = self.find_nearest_npc(level, 
                        self.config["city_x"], 
                        self.config["city_y"])
                    
                    if npc:
                        self.attack_npc(npc, self.config["hero_id"])
                        time.sleep(300)  # Wait 5 minutes
                        break
            
            time.sleep(60)  # Check every minute
```

---

## Farming Strategies

### Progressive Farming

1. **Early Game (Week 1)**
   - Target: NPC 3-5
   - Build archer production
   - Focus one hero on attack

2. **Mid Game (Week 2-4)**
   - Target: NPC 6-8
   - Multiple attack heroes
   - Wave attacks

3. **Late Game (Month+)**
   - Target: NPC 9-10
   - 100k+ archer armies
   - Automated 24/7 farming

### Medal Farming

```python
MEDAL_DROP_RATES = {
    5: {"cross": 0.02, "rose": 0.01, "lion": 0.005, "honor": 0.001, "courage": 0.0005},
    6: {"cross": 0.03, "rose": 0.02, "lion": 0.01, "honor": 0.002, "courage": 0.001},
    7: {"cross": 0.05, "rose": 0.03, "lion": 0.015, "honor": 0.003, "courage": 0.0015},
    8: {"cross": 0.08, "rose": 0.05, "lion": 0.025, "honor": 0.005, "courage": 0.002},
    9: {"cross": 0.10, "rose": 0.07, "lion": 0.035, "honor": 0.007, "courage": 0.003},
    10: {"cross": 0.15, "rose": 0.10, "lion": 0.05, "honor": 0.01, "courage": 0.005}
}
```

---

## Rate Limiting

### Attack Cooldowns

- **Per City**: 5 attacks per 5 minutes
- **Per NPC**: 1 attack per 5 minutes (respawn time)
- **Server Limit**: 100 requests per minute

### Bot Detection Avoidance

```python
def safe_attack_interval():
    """
    Add randomization to avoid detection.
    """
    base_wait = 300  # 5 minutes
    variance = random.randint(-30, 30)  # ±30 seconds
    return base_wait + variance
```

---

## Related Documentation

- `BATTLE_MECHANICS.md` - Combat formulas
- `TROOP_DATA.md` - Unit statistics
- `COMMAND_REFERENCE.md` - Protocol commands
- `BOT_SCRIPTING.md` - Script syntax

---

*Document Version: 1.0.0 | Sources: RoboEvony, AutoEvony, Community Research*
