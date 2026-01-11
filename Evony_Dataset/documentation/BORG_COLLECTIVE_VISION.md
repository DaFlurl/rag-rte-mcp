# 🤖 BORG COLLECTIVE AGENT SYSTEM - VISION DOCUMENT
## Multi-Account Evony Automation Swarm Architecture

> **Status**: Phase 6+ (Future Implementation)
> **Priority**: CRITICAL - This is the ultimate goal
> **Last Updated**: 2026-01-02

---

## 🎯 CORE CONCEPT

A **swarm of AI agents** managing multiple Evony accounts and cities, coordinating via:
- In-game mail system
- In-game chat (alliance/whisper)
- External messaging (email, Discord, etc.)

The agents form a **Borg Collective** - each agent manages one or more accounts/cities but they coordinate as a unified system.

---

## 🔧 KEY AUTOMATION FEATURES

### 1. Valley Glitching System (AMULET FARMING)

**The Setup:**
```
┌─────────────────────────────────────────────────────┐
│  VALLEY GLITCH CONFIGURATION                        │
├─────────────────────────────────────────────────────┤
│  RED PLAYER (Enemy Alliance):                       │
│    - Owns valley 1-3 tiles from ATTACKER's city    │
│    - Garrisons 20M archers in valley               │
│                                                     │
│  ATTACKER (Your Account):                           │
│    - Sends 33K catapults per wave                  │
│    - Maximum waves possible (speed = profit)        │
│    - Closer valley = faster cycles = more amulets  │
└─────────────────────────────────────────────────────┘
```

**The Mechanic:**
- Attacker loses troops intentionally
- Troop losses generate **Amulets**
- Amulets spin the wheel → **Cents + Items**
- 1 tile distance = ~25K amulets/day
- 3 tile distance = ~15K amulets/day

**Automation Requirements:**
```python
class ValleyGlitchBot:
    def __init__(self):
        self.target_amulets_per_day = 25000
        self.cata_per_wave = 33000
        self.max_cata_loss = 1_000_000_000  # 1B limit per session
        
    def calculate_waves_needed(self, target_amulets):
        # Amulet formula based on troop loss
        pass
    
    def find_optimal_valley(self, attacker_city, red_player_valleys):
        # Return valley with minimum tile distance
        pass
    
    def execute_attack_wave(self, hero, valley, troop_count):
        # Send troops, wait for result, log amulets gained
        pass
```

---

### 2. Resource Glitching System (FOOD OVERFLOW)

**CRITICAL RULES:**
```
┌─────────────────────────────────────────────────────┐
│  RESOURCE OVERFLOW BEHAVIOR                         │
├─────────────────────────────────────────────────────┤
│  FOOD:      Flips to ZERO at 999,999,999+          │
│  GOLD:      NO FLIP - can exceed 999M              │
│  LUMBER:    NO FLIP - can exceed 999M              │
│  STONE:     NO FLIP - can exceed 999M              │
│  IRON:      NO FLIP - can exceed 999M              │
│  TROOPS:    FLIP at certain thresholds             │
└─────────────────────────────────────────────────────┘
```

**Goldilocks Safe Zone (Best Practices):**
```python
class ResourceSafetyManager:
    # NEVER exceed these values
    MAX_SAFE_FOOD = 485_000_000      # 485M - safe buffer
    MAX_SAFE_TROOP_TYPE = 700_000_000  # 700M of any single type
    
    # Valley transport limits
    MAX_VALLEY_TRANSPORT = 495_000_000  # 495M max to valley
    
    def check_food_safety(self, current_food):
        if current_food >= self.MAX_SAFE_FOOD:
            return "DANGER - MOVE FOOD NOW"
        return "SAFE"
    
    def auto_distribute_food(self, city, excess_food):
        """When food hits 485M, auto-send to friendly or storage"""
        pass
```

**Valley Glitch for Resources:**
- Send up to 495M food to valley via transports
- NEVER have more than 485-490M in city before glitching
- Can glitch unlimited gold/lumber/stone/iron
- Food is the ONLY resource that flips to 0

---

### 3. Troop Safety System

**Troop Overflow Prevention:**
```python
class TroopSafetyManager:
    MAX_SAFE_SINGLE_TYPE = 700_000_000  # 700M any single type
    
    def check_troop_safety(self, troop_counts: dict):
        warnings = []
        for troop_type, count in troop_counts.items():
            if count > self.MAX_SAFE_SINGLE_TYPE:
                warnings.append(f"DANGER: {troop_type} at {count:,}")
        return warnings
    
    def recommend_action(self, troop_type, current_count):
        if current_count > 650_000_000:
            return f"Consider moving {troop_type} to another city"
        return "SAFE"
```

---

### 4. Multi-Agent Communication System

**The Borg Collective Architecture:**
```
┌─────────────────────────────────────────────────────┐
│                   HIVE MIND                         │
│              (Central Coordinator)                  │
└────────────────────┬────────────────────────────────┘
                     │
        ┌────────────┼────────────┐
        │            │            │
   ┌────▼────┐  ┌────▼────┐  ┌────▼────┐
   │ Agent 1 │  │ Agent 2 │  │ Agent 3 │
   │ Acc 1-3 │  │ Acc 4-6 │  │ Acc 7-10│
   └────┬────┘  └────┬────┘  └────┬────┘
        │            │            │
   ┌────▼────────────▼────────────▼────┐
   │       IN-GAME CHAT RELAY          │
   │    (Alliance + Whisper + Mail)    │
   └───────────────────────────────────┘
```

**Communication Channels:**
```python
class BorgCollectiveCommunication:
    CHANNELS = {
        "alliance_chat": "Public coordination",
        "whisper": "Private agent-to-agent",
        "mail": "Detailed instructions + reports",
        "email": "External backup channel",
        "discord": "Real-time monitoring"
    }
    
    def send_command(self, from_agent, to_agent, command):
        """Send command via in-game mail"""
        # Format: [BORG][CMD]{action}[/CMD]
        pass
    
    def broadcast_alert(self, alert_type, message):
        """Broadcast to all agents via alliance chat"""
        pass
    
    def request_resources(self, from_city, to_city, resource_type, amount):
        """Coordinate resource transfer between accounts"""
        pass
```

---

### 5. Alliance Coordination Features

**Valley Glitch Workflow:**
```
1. AGENT_RED leaves alliance (becomes enemy)
2. AGENT_RED takes valley near ATTACKER's city
3. AGENT_RED garrisons 20M archers
4. ATTACKER sends 33K cata waves continuously
5. Monitor amulet count
6. When target reached (e.g., 100M cata lost), STOP
7. AGENT_RED rejoins alliance
8. Repeat with different ATTACKER
```

**Automation Script:**
```python
class ValleyGlitchOrchestrator:
    def setup_glitch_session(self, red_agent, attacker_agent, target_amulets):
        # Step 1: Red leaves alliance
        red_agent.leave_alliance()
        
        # Step 2: Red finds/takes optimal valley
        valley = red_agent.find_valley_near(attacker_agent.main_city, max_tiles=3)
        red_agent.capture_valley(valley)
        
        # Step 3: Red garrisons archers
        red_agent.garrison_valley(valley, troop_type="archer", count=20_000_000)
        
        # Step 4: Attacker begins waves
        amulets_gained = 0
        cata_lost = 0
        while amulets_gained < target_amulets and cata_lost < 1_000_000_000:
            result = attacker_agent.attack_valley(valley, troop_type="catapult", count=33_000)
            amulets_gained += result.amulets
            cata_lost += result.losses
        
        # Step 5: Cleanup
        red_agent.abandon_valley(valley)
        red_agent.rejoin_alliance()
        
        return {"amulets": amulets_gained, "cata_lost": cata_lost}
```

---

### 6. All-City Rotation System

**Maximize Daily Amulets:**
```python
class DailyAmuletMaximizer:
    def run_daily_rotation(self, account):
        """Run valley glitch from all 10 cities"""
        total_amulets = 0
        
        for city in account.cities:  # 10 cities
            # Each city can farm amulets independently
            session = self.setup_glitch_for_city(city)
            result = session.run_until_target(amulets=2500)  # 2.5K per city
            total_amulets += result.amulets
            
        # Target: 25K amulets/day from all cities
        return total_amulets
```

---

### 7. Wheel Spinning Automation

**Amulet → Cents Conversion:**
```python
class WheelSpinner:
    AVERAGE_CENTS_PER_SPIN = 0.8  # Estimated
    
    def spin_all_amulets(self, amulet_count):
        """Spin wheel for all available amulets"""
        spins = amulet_count
        cents_gained = 0
        items_gained = []
        
        for _ in range(spins):
            result = self.spin_wheel()
            cents_gained += result.cents
            items_gained.extend(result.items)
        
        # Target: 20K cents/day from amulet spins
        return {"cents": cents_gained, "items": items_gained}
```

---

## 📊 DAILY TARGETS

| Metric | Target | Method |
|--------|--------|--------|
| Amulets | 15-25K/day | Valley glitch from 10 cities |
| Cents | 20K/day | Spin all amulets |
| Cata Lost | 700M-1B/day | Controlled loss for amulets |

---

## 🔗 INTEGRATION WITH CLAUDE-CODE-ACTION

Reference: https://github.com/anthropics/claude-code-action

The Borg Collective can use Claude as a scripting agent to:
- Generate automation scripts on-demand
- Analyze game state and recommend actions
- Coordinate multi-agent strategies
- Handle edge cases and exceptions

---

## 📁 PROPOSED FILE STRUCTURE

```
src/
├── agents/
│   ├── __init__.py
│   ├── base_agent.py           # Base agent class
│   ├── borg_collective.py      # Hive mind coordinator
│   ├── city_agent.py           # Per-city automation
│   └── account_agent.py        # Per-account management
├── automation/
│   ├── valley_glitch.py        # Valley glitch orchestration
│   ├── resource_glitch.py      # Resource overflow management
│   ├── amulet_farmer.py        # Amulet farming loops
│   ├── wheel_spinner.py        # Automated wheel spinning
│   └── troop_safety.py         # Overflow prevention
├── communication/
│   ├── chat_relay.py           # In-game chat parsing/sending
│   ├── mail_handler.py         # Mail-based commands
│   ├── discord_bridge.py       # External notifications
│   └── command_parser.py       # Parse [BORG][CMD] format
└── safety/
    ├── goldilocks.py           # Resource safety limits
    ├── troop_limits.py         # Troop overflow prevention
    └── emergency_stop.py       # Kill switch for all agents
```

---

## ⚠️ SAFETY SYSTEMS

### Emergency Stop
```python
class EmergencyStop:
    def kill_all_agents(self):
        """Immediately stop all agent activity"""
        for agent in self.collective.agents:
            agent.stop_all_actions()
            agent.status = "HALTED"
```

### Goldilocks Monitor
```python
class GoldilocksMonitor:
    def continuous_check(self):
        """Run every 30 seconds"""
        for city in self.all_cities:
            if city.food > 485_000_000:
                self.emergency_food_transfer(city)
            for troop_type, count in city.troops.items():
                if count > 700_000_000:
                    self.alert_troop_overflow(city, troop_type)
```

---

*This document captures the vision for the ultimate Evony automation system.*
*Implementation begins after Phase 5 of Svony Studio is complete.*
