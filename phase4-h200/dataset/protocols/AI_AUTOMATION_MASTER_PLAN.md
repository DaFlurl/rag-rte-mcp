# 🤖 AI/ML AUTOMATION MASTER PLAN
## Svony Studio - Intelligent Game Automation Framework

---

## 🎯 VISION

Transform Svony Studio into an **AI-powered game automation platform** that:
1. **Records** all player actions and game responses
2. **Learns** optimal strategies from recorded data
3. **Automates** routine tasks with human oversight
4. **Adapts** to game changes and new content
5. **Protects** accounts with built-in guardrails

---

## 🏗️ ARCHITECTURE OVERVIEW

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         SVONY STUDIO AI ARCHITECTURE                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐                   │
│  │   RECORDING  │───▶│   LEARNING   │───▶│  AUTOMATION  │                   │
│  │    LAYER     │    │    LAYER     │    │    LAYER     │                   │
│  └──────────────┘    └──────────────┘    └──────────────┘                   │
│         │                   │                   │                            │
│         ▼                   ▼                   ▼                            │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐                   │
│  │  Playwright  │    │   mem0 +     │    │  Agentic AI  │                   │
│  │  + Ruffle    │    │   SQLite/    │    │  Executor    │                   │
│  │  Recorder    │    │   VectorDB   │    │              │                   │
│  └──────────────┘    └──────────────┘    └──────────────┘                   │
│         │                   │                   │                            │
│         ▼                   ▼                   ▼                            │
│  ┌──────────────────────────────────────────────────────┐                   │
│  │                    AI MODEL LAYER                     │                   │
│  ├──────────────────────────────────────────────────────┤                   │
│  │  ┌────────────┐  ┌────────────┐  ┌────────────────┐  │                   │
│  │  │   LOCAL    │  │   CLOUD    │  │    VISION      │  │                   │
│  │  │  Qwen 32B  │  │  OpenAI    │  │   Qwen VL      │  │                   │
│  │  │  via LM    │  │  Gemini    │  │   GPT-4V       │  │                   │
│  │  │  Studio    │  │  Claude    │  │                │  │                   │
│  │  └────────────┘  └────────────┘  └────────────────┘  │                   │
│  └──────────────────────────────────────────────────────┘                   │
│                                                                              │
│  ┌──────────────────────────────────────────────────────┐                   │
│  │                   GUARDRAILS LAYER                    │                   │
│  ├──────────────────────────────────────────────────────┤                   │
│  │  • Rate Limiting    • Anti-Detection    • Failsafes │                   │
│  │  • Account Safety   • Resource Guards   • Backups   │                   │
│  └──────────────────────────────────────────────────────┘                   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 📹 RECORDING LAYER

### Session Recording with Playwright

```python
# src/ai/recording/session_recorder.py

import asyncio
from playwright.async_api import async_playwright
from datetime import datetime
from typing import List, Dict, Any
import json
import os

class SessionRecorder:
    """
    Records game sessions for AI training.
    Captures: screenshots, actions, packets, timing.
    """
    
    def __init__(self, output_dir: str = "data/recordings"):
        self.output_dir = output_dir
        self.session_id = None
        self.actions = []
        self.screenshots = []
        self.packets = []
        self.start_time = None
        
        os.makedirs(output_dir, exist_ok=True)
    
    async def start_session(self, session_name: str = None):
        """Start a new recording session."""
        self.session_id = session_name or datetime.now().strftime("%Y%m%d_%H%M%S")
        self.start_time = datetime.now()
        self.actions = []
        self.screenshots = []
        self.packets = []
        
        # Create session directory
        self.session_dir = os.path.join(self.output_dir, self.session_id)
        os.makedirs(self.session_dir, exist_ok=True)
        os.makedirs(os.path.join(self.session_dir, "screenshots"), exist_ok=True)
        
        print(f"[RECORDER] Started session: {self.session_id}")
    
    def record_action(self, action_type: str, details: Dict[str, Any]):
        """Record a player action."""
        action = {
            'timestamp': datetime.now().isoformat(),
            'elapsed_ms': (datetime.now() - self.start_time).total_seconds() * 1000,
            'type': action_type,
            'details': details
        }
        self.actions.append(action)
        print(f"[RECORDER] Action: {action_type}")
    
    def record_screenshot(self, image_data: bytes, label: str = None):
        """Record a screenshot with optional label."""
        filename = f"{len(self.screenshots):05d}_{label or 'frame'}.png"
        filepath = os.path.join(self.session_dir, "screenshots", filename)
        
        with open(filepath, 'wb') as f:
            f.write(image_data)
        
        self.screenshots.append({
            'timestamp': datetime.now().isoformat(),
            'elapsed_ms': (datetime.now() - self.start_time).total_seconds() * 1000,
            'filename': filename,
            'label': label
        })
    
    def record_packet(self, packet_data: Dict[str, Any]):
        """Record a network packet."""
        packet = {
            'timestamp': datetime.now().isoformat(),
            'elapsed_ms': (datetime.now() - self.start_time).total_seconds() * 1000,
            **packet_data
        }
        self.packets.append(packet)
    
    def end_session(self) -> str:
        """End session and save all data."""
        # Save actions
        actions_file = os.path.join(self.session_dir, "actions.json")
        with open(actions_file, 'w') as f:
            json.dump(self.actions, f, indent=2)
        
        # Save packets
        packets_file = os.path.join(self.session_dir, "packets.json")
        with open(packets_file, 'w') as f:
            json.dump(self.packets, f, indent=2)
        
        # Save metadata
        metadata = {
            'session_id': self.session_id,
            'start_time': self.start_time.isoformat(),
            'end_time': datetime.now().isoformat(),
            'duration_seconds': (datetime.now() - self.start_time).total_seconds(),
            'total_actions': len(self.actions),
            'total_screenshots': len(self.screenshots),
            'total_packets': len(self.packets)
        }
        metadata_file = os.path.join(self.session_dir, "metadata.json")
        with open(metadata_file, 'w') as f:
            json.dump(metadata, f, indent=2)
        
        print(f"[RECORDER] Session saved: {self.session_dir}")
        return self.session_dir


class PlaywrightBrowserRecorder:
    """
    Uses Playwright to record browser-based Flash sessions.
    Works with Ruffle Flash emulator.
    """
    
    def __init__(self, recorder: SessionRecorder):
        self.recorder = recorder
        self.browser = None
        self.page = None
    
    async def start(self, swf_url: str):
        """Start browser with recording."""
        playwright = await async_playwright().start()
        self.browser = await playwright.chromium.launch(headless=False)
        self.page = await self.browser.new_page()
        
        # Inject Ruffle Flash player
        await self.page.add_init_script("""
            window.RufflePlayer = window.RufflePlayer || {};
            window.RufflePlayer.config = {
                autoplay: 'on',
                unmuteOverlay: 'hidden'
            };
        """)
        
        # Load SWF
        await self.page.goto(swf_url)
        
        # Set up event listeners
        await self._setup_event_listeners()
        
        print("[BROWSER] Started recording browser session")
    
    async def _setup_event_listeners(self):
        """Set up event listeners for recording."""
        # Mouse clicks
        await self.page.evaluate("""
            document.addEventListener('click', (e) => {
                window._lastClick = {
                    x: e.clientX,
                    y: e.clientY,
                    target: e.target.tagName,
                    timestamp: Date.now()
                };
            });
        """)
        
        # Keyboard events
        await self.page.evaluate("""
            document.addEventListener('keydown', (e) => {
                window._lastKey = {
                    key: e.key,
                    code: e.code,
                    timestamp: Date.now()
                };
            });
        """)
    
    async def capture_frame(self, label: str = None):
        """Capture current frame as screenshot."""
        screenshot = await self.page.screenshot(type='png')
        self.recorder.record_screenshot(screenshot, label)
    
    async def stop(self):
        """Stop browser recording."""
        if self.browser:
            await self.browser.close()
```

---

## 🧠 LEARNING LAYER

### Memory System with mem0

```python
# src/ai/learning/memory_system.py

from mem0 import Memory
import sqlite3
import json
from datetime import datetime
from typing import List, Dict, Any, Optional

class EvonyMemorySystem:
    """
    Long-term memory system for Evony automation.
    Stores: game states, strategies, outcomes.
    Uses: mem0 for vector search, SQLite for structured data.
    """
    
    def __init__(self, db_path: str = "data/memory.db"):
        self.db_path = db_path
        
        # Initialize mem0 for semantic memory
        self.memory = Memory()
        
        # Initialize SQLite for structured data
        self._init_database()
    
    def _init_database(self):
        """Initialize SQLite database."""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        # Game states table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS game_states (
                id INTEGER PRIMARY KEY,
                timestamp TEXT,
                account_id TEXT,
                city_id TEXT,
                resources JSON,
                troops JSON,
                buildings JSON,
                heroes JSON
            )
        """)
        
        # Actions table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS actions (
                id INTEGER PRIMARY KEY,
                timestamp TEXT,
                account_id TEXT,
                action_type TEXT,
                parameters JSON,
                outcome JSON,
                success INTEGER
            )
        """)
        
        # Strategies table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS strategies (
                id INTEGER PRIMARY KEY,
                name TEXT,
                description TEXT,
                conditions JSON,
                actions JSON,
                success_rate REAL,
                last_used TEXT
            )
        """)
        
        conn.commit()
        conn.close()
    
    def store_game_state(self, account_id: str, city_id: str, state: Dict[str, Any]):
        """Store current game state."""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        cursor.execute("""
            INSERT INTO game_states (timestamp, account_id, city_id, resources, troops, buildings, heroes)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        """, (
            datetime.now().isoformat(),
            account_id,
            city_id,
            json.dumps(state.get('resources', {})),
            json.dumps(state.get('troops', {})),
            json.dumps(state.get('buildings', {})),
            json.dumps(state.get('heroes', []))
        ))
        
        conn.commit()
        conn.close()
        
        # Also add to semantic memory
        self.memory.add(
            f"Account {account_id}, City {city_id}: {json.dumps(state)}",
            user_id=account_id,
            metadata={'type': 'game_state', 'city_id': city_id}
        )
    
    def store_action(
        self,
        account_id: str,
        action_type: str,
        parameters: Dict[str, Any],
        outcome: Dict[str, Any],
        success: bool
    ):
        """Store an action and its outcome."""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        cursor.execute("""
            INSERT INTO actions (timestamp, account_id, action_type, parameters, outcome, success)
            VALUES (?, ?, ?, ?, ?, ?)
        """, (
            datetime.now().isoformat(),
            account_id,
            action_type,
            json.dumps(parameters),
            json.dumps(outcome),
            1 if success else 0
        ))
        
        conn.commit()
        conn.close()
        
        # Add to semantic memory
        self.memory.add(
            f"Action: {action_type} with {parameters} resulted in {outcome} (success: {success})",
            user_id=account_id,
            metadata={'type': 'action', 'action_type': action_type}
        )
    
    def recall_similar_situations(self, query: str, limit: int = 5) -> List[Dict]:
        """Recall similar past situations using semantic search."""
        results = self.memory.search(query, limit=limit)
        return results
    
    def get_best_strategy(self, conditions: Dict[str, Any]) -> Optional[Dict]:
        """Get best strategy for given conditions."""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        # Find matching strategies
        cursor.execute("""
            SELECT * FROM strategies
            WHERE success_rate > 0.5
            ORDER BY success_rate DESC
            LIMIT 1
        """)
        
        row = cursor.fetchone()
        conn.close()
        
        if row:
            return {
                'id': row[0],
                'name': row[1],
                'description': row[2],
                'conditions': json.loads(row[3]),
                'actions': json.loads(row[4]),
                'success_rate': row[5]
            }
        return None
    
    def update_strategy_success(self, strategy_id: int, success: bool):
        """Update strategy success rate based on outcome."""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        # Get current success rate
        cursor.execute("SELECT success_rate FROM strategies WHERE id = ?", (strategy_id,))
        current_rate = cursor.fetchone()[0]
        
        # Update with exponential moving average
        alpha = 0.1
        new_rate = alpha * (1 if success else 0) + (1 - alpha) * current_rate
        
        cursor.execute("""
            UPDATE strategies SET success_rate = ?, last_used = ?
            WHERE id = ?
        """, (new_rate, datetime.now().isoformat(), strategy_id))
        
        conn.commit()
        conn.close()
```

### Learning from Recorded Sessions

```python
# src/ai/learning/session_learner.py

import json
import os
from typing import List, Dict, Any
from pathlib import Path

class SessionLearner:
    """
    Learns gameplay patterns from recorded sessions.
    Extracts: action sequences, timing patterns, decision triggers.
    """
    
    def __init__(self, recordings_dir: str = "data/recordings"):
        self.recordings_dir = recordings_dir
        self.patterns = []
    
    def load_session(self, session_id: str) -> Dict[str, Any]:
        """Load a recorded session."""
        session_dir = os.path.join(self.recordings_dir, session_id)
        
        with open(os.path.join(session_dir, "metadata.json")) as f:
            metadata = json.load(f)
        
        with open(os.path.join(session_dir, "actions.json")) as f:
            actions = json.load(f)
        
        with open(os.path.join(session_dir, "packets.json")) as f:
            packets = json.load(f)
        
        return {
            'metadata': metadata,
            'actions': actions,
            'packets': packets
        }
    
    def extract_action_sequences(self, session: Dict) -> List[List[Dict]]:
        """Extract action sequences from session."""
        actions = session['actions']
        sequences = []
        current_sequence = []
        
        for i, action in enumerate(actions):
            current_sequence.append(action)
            
            # Check for sequence breaks (>30 second gap)
            if i < len(actions) - 1:
                gap = actions[i+1]['elapsed_ms'] - action['elapsed_ms']
                if gap > 30000:  # 30 seconds
                    if len(current_sequence) > 1:
                        sequences.append(current_sequence)
                    current_sequence = []
        
        if current_sequence:
            sequences.append(current_sequence)
        
        return sequences
    
    def learn_timing_patterns(self, sessions: List[Dict]) -> Dict[str, float]:
        """Learn typical timing between actions."""
        timing_by_action = {}
        
        for session in sessions:
            actions = session['actions']
            for i in range(len(actions) - 1):
                action_type = actions[i]['type']
                next_type = actions[i+1]['type']
                gap = actions[i+1]['elapsed_ms'] - actions[i]['elapsed_ms']
                
                key = f"{action_type}->{next_type}"
                if key not in timing_by_action:
                    timing_by_action[key] = []
                timing_by_action[key].append(gap)
        
        # Calculate averages
        avg_timing = {}
        for key, times in timing_by_action.items():
            avg_timing[key] = sum(times) / len(times)
        
        return avg_timing
    
    def generate_automation_script(self, sequence: List[Dict]) -> str:
        """Generate automation script from action sequence."""
        script_lines = ["# Auto-generated script", ""]
        
        for action in sequence:
            action_type = action['type']
            details = action['details']
            
            if action_type == 'click':
                script_lines.append(f"click({details['x']}, {details['y']})")
            elif action_type == 'train':
                script_lines.append(f"train_troops('{details['troop_type']}', {details['count']})")
            elif action_type == 'build':
                script_lines.append(f"build('{details['building']}', {details['level']})")
            elif action_type == 'attack':
                script_lines.append(f"attack({details['target_x']}, {details['target_y']})")
            
            # Add timing delay
            if 'elapsed_ms' in action:
                script_lines.append(f"wait({int(action['elapsed_ms'] / 1000)})")
        
        return "\n".join(script_lines)
```

---

## ⚡ AUTOMATION LAYER

### Agentic AI Executor

```python
# src/ai/automation/agent_executor.py

import asyncio
from typing import Dict, Any, List, Optional, Callable
from dataclasses import dataclass
from enum import Enum
import json

class TaskPriority(Enum):
    CRITICAL = 1
    HIGH = 2
    MEDIUM = 3
    LOW = 4

@dataclass
class AutomationTask:
    id: str
    name: str
    priority: TaskPriority
    action: str
    parameters: Dict[str, Any]
    conditions: Dict[str, Any] = None
    max_retries: int = 3
    cooldown_seconds: int = 0

class AgentExecutor:
    """
    Agentic AI executor for game automation.
    Features: task queue, priority, conditions, retries.
    """
    
    def __init__(
        self,
        game_interface,
        memory_system,
        on_task_complete: Callable = None
    ):
        self.game = game_interface
        self.memory = memory_system
        self.on_task_complete = on_task_complete
        
        self.task_queue: List[AutomationTask] = []
        self.running = False
        self.current_task = None
        
        # Guardrails
        self.max_actions_per_minute = 10
        self.actions_this_minute = 0
        self.last_action_reset = None
    
    def add_task(self, task: AutomationTask):
        """Add task to queue with priority sorting."""
        self.task_queue.append(task)
        self.task_queue.sort(key=lambda t: t.priority.value)
    
    async def start(self):
        """Start the automation executor."""
        self.running = True
        print("[AGENT] Starting automation executor")
        
        while self.running:
            # Check rate limit
            if not self._check_rate_limit():
                await asyncio.sleep(1)
                continue
            
            # Get next task
            task = self._get_next_task()
            if not task:
                await asyncio.sleep(1)
                continue
            
            # Execute task
            self.current_task = task
            success = await self._execute_task(task)
            
            # Handle result
            if success:
                self._on_success(task)
            else:
                self._on_failure(task)
            
            self.current_task = None
    
    def stop(self):
        """Stop the automation executor."""
        self.running = False
        print("[AGENT] Stopping automation executor")
    
    def _check_rate_limit(self) -> bool:
        """Check if we're within rate limits."""
        import time
        current_minute = int(time.time() / 60)
        
        if self.last_action_reset != current_minute:
            self.actions_this_minute = 0
            self.last_action_reset = current_minute
        
        if self.actions_this_minute >= self.max_actions_per_minute:
            return False
        
        return True
    
    def _get_next_task(self) -> Optional[AutomationTask]:
        """Get next task that meets conditions."""
        for task in self.task_queue:
            if self._check_conditions(task):
                self.task_queue.remove(task)
                return task
        return None
    
    def _check_conditions(self, task: AutomationTask) -> bool:
        """Check if task conditions are met."""
        if not task.conditions:
            return True
        
        # Check various condition types
        for condition_type, condition_value in task.conditions.items():
            if condition_type == 'min_resources':
                current = self.game.get_resources()
                for resource, amount in condition_value.items():
                    if current.get(resource, 0) < amount:
                        return False
            
            elif condition_type == 'time_after':
                import datetime
                if datetime.datetime.now() < condition_value:
                    return False
            
            elif condition_type == 'building_level':
                current = self.game.get_building_level(condition_value['building'])
                if current < condition_value['min_level']:
                    return False
        
        return True
    
    async def _execute_task(self, task: AutomationTask) -> bool:
        """Execute a single task."""
        print(f"[AGENT] Executing: {task.name}")
        
        for attempt in range(task.max_retries):
            try:
                # Execute action based on type
                if task.action == 'train_troops':
                    result = await self.game.train_troops(**task.parameters)
                elif task.action == 'build':
                    result = await self.game.build(**task.parameters)
                elif task.action == 'attack':
                    result = await self.game.attack(**task.parameters)
                elif task.action == 'collect_resources':
                    result = await self.game.collect_resources(**task.parameters)
                elif task.action == 'use_item':
                    result = await self.game.use_item(**task.parameters)
                elif task.action == 'spin_wheel':
                    result = await self.game.spin_wheel(**task.parameters)
                else:
                    print(f"[AGENT] Unknown action: {task.action}")
                    return False
                
                self.actions_this_minute += 1
                return result.get('success', False)
                
            except Exception as e:
                print(f"[AGENT] Attempt {attempt + 1} failed: {e}")
                await asyncio.sleep(2 ** attempt)  # Exponential backoff
        
        return False
    
    def _on_success(self, task: AutomationTask):
        """Handle successful task completion."""
        print(f"[AGENT] Success: {task.name}")
        
        # Store in memory
        self.memory.store_action(
            account_id=self.game.account_id,
            action_type=task.action,
            parameters=task.parameters,
            outcome={'status': 'success'},
            success=True
        )
        
        # Callback
        if self.on_task_complete:
            self.on_task_complete(task, True)
    
    def _on_failure(self, task: AutomationTask):
        """Handle failed task."""
        print(f"[AGENT] Failed: {task.name}")
        
        # Store in memory
        self.memory.store_action(
            account_id=self.game.account_id,
            action_type=task.action,
            parameters=task.parameters,
            outcome={'status': 'failed'},
            success=False
        )
        
        # Callback
        if self.on_task_complete:
            self.on_task_complete(task, False)
```

---

## 🛡️ GUARDRAILS LAYER

### Safety and Protection System

```python
# src/ai/guardrails/safety_system.py

from dataclasses import dataclass
from typing import Dict, Any, List, Optional
from datetime import datetime, timedelta
import json

@dataclass
class GuardrailConfig:
    # Rate limiting
    max_actions_per_minute: int = 10
    max_actions_per_hour: int = 200
    max_actions_per_day: int = 2000
    
    # Resource protection
    min_gold_reserve: int = 100000
    min_food_reserve: int = 500000
    never_spend_medals: bool = True
    
    # Army protection
    min_troops_reserve: Dict[str, int] = None
    never_attack_players: bool = True
    max_npc_level: int = 10
    
    # Timing
    random_delay_range: tuple = (1, 5)  # seconds
    human_like_pauses: bool = True
    avoid_peak_hours: bool = False
    
    # Detection avoidance
    vary_action_timing: bool = True
    limit_session_length: int = 3600  # seconds
    force_breaks: bool = True
    break_interval: int = 1800  # 30 minutes
    break_duration: tuple = (300, 600)  # 5-10 minutes

class SafetySystem:
    """
    Comprehensive safety system for automation.
    Prevents: bans, resource loss, detection.
    """
    
    def __init__(self, config: GuardrailConfig = None):
        self.config = config or GuardrailConfig()
        
        # Tracking
        self.action_history = []
        self.session_start = datetime.now()
        self.last_break = datetime.now()
        self.blocked_actions = []
    
    def check_action_allowed(
        self,
        action_type: str,
        parameters: Dict[str, Any],
        current_state: Dict[str, Any]
    ) -> tuple[bool, Optional[str]]:
        """
        Check if an action is safe to execute.
        Returns: (allowed, reason_if_blocked)
        """
        checks = [
            self._check_rate_limit,
            self._check_resource_protection,
            self._check_army_protection,
            self._check_session_length,
            self._check_break_needed
        ]
        
        for check in checks:
            allowed, reason = check(action_type, parameters, current_state)
            if not allowed:
                self.blocked_actions.append({
                    'timestamp': datetime.now().isoformat(),
                    'action': action_type,
                    'reason': reason
                })
                return False, reason
        
        return True, None
    
    def _check_rate_limit(self, action_type, params, state) -> tuple[bool, Optional[str]]:
        """Check rate limits."""
        now = datetime.now()
        
        # Count recent actions
        minute_ago = now - timedelta(minutes=1)
        hour_ago = now - timedelta(hours=1)
        day_ago = now - timedelta(days=1)
        
        actions_minute = sum(1 for a in self.action_history if a['time'] > minute_ago)
        actions_hour = sum(1 for a in self.action_history if a['time'] > hour_ago)
        actions_day = sum(1 for a in self.action_history if a['time'] > day_ago)
        
        if actions_minute >= self.config.max_actions_per_minute:
            return False, f"Rate limit: {self.config.max_actions_per_minute}/minute exceeded"
        
        if actions_hour >= self.config.max_actions_per_hour:
            return False, f"Rate limit: {self.config.max_actions_per_hour}/hour exceeded"
        
        if actions_day >= self.config.max_actions_per_day:
            return False, f"Rate limit: {self.config.max_actions_per_day}/day exceeded"
        
        return True, None
    
    def _check_resource_protection(self, action_type, params, state) -> tuple[bool, Optional[str]]:
        """Check resource protection rules."""
        resources = state.get('resources', {})
        
        # Check gold reserve
        if action_type in ['build', 'train', 'research']:
            cost = params.get('gold_cost', 0)
            remaining = resources.get('gold', 0) - cost
            if remaining < self.config.min_gold_reserve:
                return False, f"Would drop gold below reserve ({self.config.min_gold_reserve})"
        
        # Check food reserve
        if action_type == 'train':
            food_cost = params.get('food_cost', 0)
            remaining = resources.get('food', 0) - food_cost
            if remaining < self.config.min_food_reserve:
                return False, f"Would drop food below reserve ({self.config.min_food_reserve})"
        
        # Never spend medals
        if self.config.never_spend_medals and params.get('medal_cost', 0) > 0:
            return False, "Medal spending is blocked"
        
        return True, None
    
    def _check_army_protection(self, action_type, params, state) -> tuple[bool, Optional[str]]:
        """Check army protection rules."""
        if action_type == 'attack':
            # Never attack players
            if self.config.never_attack_players and params.get('target_type') == 'player':
                return False, "Player attacks are blocked"
            
            # Max NPC level
            if params.get('npc_level', 0) > self.config.max_npc_level:
                return False, f"NPC level {params['npc_level']} exceeds max {self.config.max_npc_level}"
        
        return True, None
    
    def _check_session_length(self, action_type, params, state) -> tuple[bool, Optional[str]]:
        """Check session length limits."""
        session_duration = (datetime.now() - self.session_start).total_seconds()
        
        if session_duration > self.config.limit_session_length:
            return False, f"Session length ({session_duration}s) exceeds limit ({self.config.limit_session_length}s)"
        
        return True, None
    
    def _check_break_needed(self, action_type, params, state) -> tuple[bool, Optional[str]]:
        """Check if a break is needed."""
        if not self.config.force_breaks:
            return True, None
        
        since_break = (datetime.now() - self.last_break).total_seconds()
        
        if since_break > self.config.break_interval:
            return False, f"Break needed (last break {since_break}s ago)"
        
        return True, None
    
    def record_action(self, action_type: str):
        """Record an action for tracking."""
        self.action_history.append({
            'time': datetime.now(),
            'type': action_type
        })
        
        # Prune old history
        day_ago = datetime.now() - timedelta(days=1)
        self.action_history = [a for a in self.action_history if a['time'] > day_ago]
    
    def take_break(self):
        """Record that a break was taken."""
        self.last_break = datetime.now()
    
    def start_new_session(self):
        """Start a new session."""
        self.session_start = datetime.now()
        self.last_break = datetime.now()
```

---

## 🔌 AI MODEL INTEGRATION

### Multi-Provider AI Client

```python
# src/ai/providers/ai_client.py

from typing import Dict, Any, Optional, List
from abc import ABC, abstractmethod
import asyncio
import json

class AIProvider(ABC):
    """Abstract base for AI providers."""
    
    @abstractmethod
    async def complete(self, prompt: str, **kwargs) -> str:
        pass
    
    @abstractmethod
    async def analyze_image(self, image_data: bytes, prompt: str) -> str:
        pass

class LocalQwenProvider(AIProvider):
    """Local Qwen model via LM Studio."""
    
    def __init__(self, base_url: str = "http://localhost:1234/v1"):
        self.base_url = base_url
    
    async def complete(self, prompt: str, **kwargs) -> str:
        import aiohttp
        
        async with aiohttp.ClientSession() as session:
            async with session.post(
                f"{self.base_url}/chat/completions",
                json={
                    "model": "qwen2.5-32b",
                    "messages": [{"role": "user", "content": prompt}],
                    "temperature": kwargs.get('temperature', 0.7),
                    "max_tokens": kwargs.get('max_tokens', 1000)
                }
            ) as response:
                result = await response.json()
                return result['choices'][0]['message']['content']
    
    async def analyze_image(self, image_data: bytes, prompt: str) -> str:
        import aiohttp
        import base64
        
        image_b64 = base64.b64encode(image_data).decode()
        
        async with aiohttp.ClientSession() as session:
            async with session.post(
                f"{self.base_url}/chat/completions",
                json={
                    "model": "qwen2-vl-32b",
                    "messages": [
                        {
                            "role": "user",
                            "content": [
                                {"type": "text", "text": prompt},
                                {"type": "image_url", "image_url": {"url": f"data:image/png;base64,{image_b64}"}}
                            ]
                        }
                    ]
                }
            ) as response:
                result = await response.json()
                return result['choices'][0]['message']['content']

class OpenAIProvider(AIProvider):
    """OpenAI API provider."""
    
    def __init__(self, api_key: str):
        self.api_key = api_key
    
    async def complete(self, prompt: str, **kwargs) -> str:
        from openai import AsyncOpenAI
        
        client = AsyncOpenAI(api_key=self.api_key)
        response = await client.chat.completions.create(
            model=kwargs.get('model', 'gpt-4'),
            messages=[{"role": "user", "content": prompt}],
            temperature=kwargs.get('temperature', 0.7),
            max_tokens=kwargs.get('max_tokens', 1000)
        )
        return response.choices[0].message.content
    
    async def analyze_image(self, image_data: bytes, prompt: str) -> str:
        from openai import AsyncOpenAI
        import base64
        
        client = AsyncOpenAI(api_key=self.api_key)
        image_b64 = base64.b64encode(image_data).decode()
        
        response = await client.chat.completions.create(
            model="gpt-4-vision-preview",
            messages=[
                {
                    "role": "user",
                    "content": [
                        {"type": "text", "text": prompt},
                        {"type": "image_url", "image_url": {"url": f"data:image/png;base64,{image_b64}"}}
                    ]
                }
            ],
            max_tokens=1000
        )
        return response.choices[0].message.content

class GeminiProvider(AIProvider):
    """Google Gemini provider."""
    
    def __init__(self, api_key: str):
        self.api_key = api_key
    
    async def complete(self, prompt: str, **kwargs) -> str:
        import google.generativeai as genai
        
        genai.configure(api_key=self.api_key)
        model = genai.GenerativeModel('gemini-pro')
        response = await model.generate_content_async(prompt)
        return response.text
    
    async def analyze_image(self, image_data: bytes, prompt: str) -> str:
        import google.generativeai as genai
        from PIL import Image
        import io
        
        genai.configure(api_key=self.api_key)
        model = genai.GenerativeModel('gemini-pro-vision')
        
        image = Image.open(io.BytesIO(image_data))
        response = await model.generate_content_async([prompt, image])
        return response.text


class MultiProviderAI:
    """
    Multi-provider AI client with failover.
    Priority: Local -> Cloud
    """
    
    def __init__(self, config: Dict[str, Any]):
        self.providers = []
        
        # Add local provider first (preferred)
        if config.get('lm_studio_enabled'):
            self.providers.append(LocalQwenProvider(config.get('lm_studio_url', 'http://localhost:1234/v1')))
        
        # Add cloud providers as fallback
        if config.get('openai_key'):
            self.providers.append(OpenAIProvider(config['openai_key']))
        
        if config.get('gemini_key'):
            self.providers.append(GeminiProvider(config['gemini_key']))
    
    async def complete(self, prompt: str, **kwargs) -> str:
        """Complete with failover."""
        for provider in self.providers:
            try:
                return await provider.complete(prompt, **kwargs)
            except Exception as e:
                print(f"[AI] Provider failed: {e}, trying next...")
                continue
        
        raise Exception("All AI providers failed")
    
    async def analyze_game_state(self, screenshot: bytes) -> Dict[str, Any]:
        """Analyze game screenshot to extract state."""
        prompt = """Analyze this Evony game screenshot and extract:
        1. Current resources (gold, food, wood, stone, iron)
        2. Visible buildings and their levels
        3. Any troops visible
        4. Any alerts or notifications
        5. Current city/map location
        
        Return as JSON."""
        
        for provider in self.providers:
            try:
                response = await provider.analyze_image(screenshot, prompt)
                return json.loads(response)
            except Exception as e:
                print(f"[AI] Vision analysis failed: {e}")
                continue
        
        return {}
    
    async def decide_next_action(self, game_state: Dict, goals: List[str]) -> Dict[str, Any]:
        """Use AI to decide next action based on state and goals."""
        prompt = f"""Given the current game state:
        {json.dumps(game_state, indent=2)}
        
        And these goals:
        {json.dumps(goals, indent=2)}
        
        What is the optimal next action? Consider:
        - Resource efficiency
        - Time constraints
        - Risk/reward
        
        Return a JSON action object with:
        - action_type: string
        - parameters: object
        - reasoning: string
        """
        
        response = await self.complete(prompt)
        return json.loads(response)
```

---

## 📋 IMPLEMENTATION ROADMAP

### Phase 1: Recording (Week 1-2)
- [ ] Implement SessionRecorder
- [ ] Integrate Playwright browser recording
- [ ] Build packet capture from proxy
- [ ] Create recording UI panel

### Phase 2: Learning (Week 3-4)
- [ ] Set up mem0 vector database
- [ ] Build SQLite structured storage
- [ ] Implement SessionLearner
- [ ] Create pattern extraction

### Phase 3: Automation (Week 5-6)
- [ ] Build AgentExecutor
- [ ] Implement task queue system
- [ ] Add condition checking
- [ ] Create automation UI

### Phase 4: Guardrails (Week 7)
- [ ] Implement SafetySystem
- [ ] Add rate limiting
- [ ] Build resource protection
- [ ] Create safety dashboard

### Phase 5: AI Integration (Week 8)
- [ ] Set up local Qwen model
- [ ] Add cloud provider fallback
- [ ] Implement vision analysis
- [ ] Build decision engine

---

This architecture provides **complete AI-powered automation** with safety, learning, and multi-provider support.
