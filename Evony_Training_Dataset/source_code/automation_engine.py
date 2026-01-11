#!/usr/bin/env python3
"""
BORG TOOLKIT EPIC 2026 - Automation Engine
===========================================

Handles scheduled automation tasks for all accounts/cities:
- Tax collection
- Quest completion
- Colony farming
- NPC hunting
- HH hunting coordination
- Resource balancing
- Troop management

Works with borg_master.py for multi-account orchestration.
"""

import asyncio
import json
from datetime import datetime, timedelta
from typing import Dict, List, Any, Optional, Callable
from dataclasses import dataclass, field
from enum import Enum
import hashlib
import threading
import time

class TaskType(Enum):
    """Available automation task types"""
    TAX_COLLECT = "tax_collect"
    QUEST_COMPLETE = "quest_complete"
    COLONY_LEVY = "colony_levy"
    NPC_FARM = "npc_farm"
    HH_HUNT = "hh_hunt"
    RESOURCE_BALANCE = "resource_balance"
    TROOP_TRAIN = "troop_train"
    BUILDING_UPGRADE = "building_upgrade"
    RESEARCH_QUEUE = "research_queue"
    OVERFLOW_EXPLOIT = "overflow_exploit"
    AMULET_SPIN = "amulet_spin"
    PACKAGE_CLAIM = "package_claim"
    CUSTOM_SCRIPT = "custom_script"

class TaskPriority(Enum):
    """Task priority levels"""
    LOW = 1
    MEDIUM = 2
    HIGH = 3
    CRITICAL = 4

@dataclass
class ScheduledTask:
    """A scheduled automation task"""
    id: str
    account_id: str
    city_id: str  # "*" for all cities
    task_type: TaskType
    priority: TaskPriority = TaskPriority.MEDIUM
    interval_minutes: int = 60  # Run every N minutes
    enabled: bool = True
    config: Dict = field(default_factory=dict)
    last_run: Optional[datetime] = None
    next_run: Optional[datetime] = None
    run_count: int = 0
    error_count: int = 0
    last_error: str = ""

@dataclass
class TaskResult:
    """Result of a task execution"""
    task_id: str
    success: bool
    message: str
    data: Dict = field(default_factory=dict)
    timestamp: datetime = field(default_factory=datetime.now)

class AutomationEngine:
    """
    Central automation engine for scheduling and executing tasks.
    """
    
    def __init__(self):
        self.tasks: Dict[str, ScheduledTask] = {}
        self.task_queue: List[ScheduledTask] = []
        self.running = False
        self.results: List[TaskResult] = []
        self._lock = threading.Lock()
        
        # Task generators - produce AutoEvony scripts
        self.generators: Dict[TaskType, Callable] = {
            TaskType.TAX_COLLECT: self._gen_tax_collect,
            TaskType.QUEST_COMPLETE: self._gen_quest_complete,
            TaskType.COLONY_LEVY: self._gen_colony_levy,
            TaskType.NPC_FARM: self._gen_npc_farm,
            TaskType.HH_HUNT: self._gen_hh_hunt,
            TaskType.RESOURCE_BALANCE: self._gen_resource_balance,
            TaskType.TROOP_TRAIN: self._gen_troop_train,
            TaskType.OVERFLOW_EXPLOIT: self._gen_overflow_exploit,
            TaskType.AMULET_SPIN: self._gen_amulet_spin,
            TaskType.PACKAGE_CLAIM: self._gen_package_claim,
            TaskType.CUSTOM_SCRIPT: self._gen_custom_script,
        }
    
    # =========================================================================
    # TASK MANAGEMENT
    # =========================================================================
    
    def add_task(self, task: ScheduledTask) -> str:
        """Add a new scheduled task"""
        if not task.id:
            task.id = hashlib.md5(f"{task.account_id}{task.task_type}{datetime.now()}".encode()).hexdigest()[:8]
        
        task.next_run = datetime.now() + timedelta(minutes=1)  # Start in 1 minute
        
        with self._lock:
            self.tasks[task.id] = task
        
        return task.id
    
    def remove_task(self, task_id: str) -> bool:
        """Remove a scheduled task"""
        with self._lock:
            if task_id in self.tasks:
                del self.tasks[task_id]
                return True
        return False
    
    def enable_task(self, task_id: str, enabled: bool = True):
        """Enable/disable a task"""
        if task_id in self.tasks:
            self.tasks[task_id].enabled = enabled
    
    def get_due_tasks(self) -> List[ScheduledTask]:
        """Get tasks that are due to run"""
        now = datetime.now()
        due = []
        
        with self._lock:
            for task in self.tasks.values():
                if task.enabled and task.next_run and task.next_run <= now:
                    due.append(task)
        
        # Sort by priority (highest first)
        due.sort(key=lambda t: t.priority.value, reverse=True)
        return due
    
    def update_task_schedule(self, task: ScheduledTask):
        """Update next run time after execution"""
        task.last_run = datetime.now()
        task.next_run = datetime.now() + timedelta(minutes=task.interval_minutes)
        task.run_count += 1
    
    # =========================================================================
    # SCRIPT GENERATORS
    # =========================================================================
    
    def generate_script(self, task: ScheduledTask) -> str:
        """Generate AutoEvony script for a task"""
        generator = self.generators.get(task.task_type)
        if generator:
            return generator(task)
        return f"// Unknown task type: {task.task_type}"
    
    def _gen_tax_collect(self, task: ScheduledTask) -> str:
        """Generate tax collection script"""
        tax_rate = task.config.get('tax_rate', 100)
        comfort_type = task.config.get('comfort_type', 'disaster')
        
        return f"""// BORG AUTO - Tax Collection
// Account: {task.account_id}
// Generated: {datetime.now().isoformat()}

setsilence off
echo [AUTO] Starting tax collection...

// Set tax rate and collect
settaxrate {tax_rate}
sleep 500
levy tax
sleep 500

// Comfort to restore population
comfort {comfort_type}

echo [AUTO] Tax collection complete
"""
    
    def _gen_quest_complete(self, task: ScheduledTask) -> str:
        """Generate quest completion script"""
        return f"""// BORG AUTO - Quest Completion
// Account: {task.account_id}
// Generated: {datetime.now().isoformat()}

setsilence off
echo [AUTO] Completing quests...

completequests all

echo [AUTO] Quests completed
"""
    
    def _gen_colony_levy(self, task: ScheduledTask) -> str:
        """Generate colony levy script"""
        return f"""// BORG AUTO - Colony Levy
// Account: {task.account_id}
// Generated: {datetime.now().isoformat()}

setsilence off
echo [AUTO] Levying from colonies...

colony levyfood all
sleep 500
colony levytax all
sleep 500
colony levyarmy all

echo [AUTO] Colony levy complete
"""
    
    def _gen_npc_farm(self, task: ScheduledTask) -> str:
        """Generate NPC farming script"""
        npc_level = task.config.get('npc_level', 5)
        waves = task.config.get('waves', 3)
        troops = task.config.get('troops', 'a:50000')
        
        return f"""// BORG AUTO - NPC Farming
// Account: {task.account_id}
// Generated: {datetime.now().isoformat()}

setsilence off
echo [AUTO] Starting NPC farm (Level {npc_level})...

// Find nearby NPCs
scanmap $c.castle.fieldId$ 20
sleep 1
set npcs $c.getMapFieldList(npc,{npc_level},20,c.castle.fieldId)$
setarr targets "%npcs%"

// Send attack waves
set wave 0
label attackLoop
if {{%wave%>={waves}}} goto farmDone
if {{%wave%>=%targets.length%}} goto farmDone

attack %targets[{{%wave%}}]% any {troops}
echo Sent wave %wave% to %targets[{{%wave%}}]%
set wave {{%wave%+1}}
sleep 3000
goto attackLoop

label farmDone
echo [AUTO] NPC farming waves sent
"""
    
    def _gen_hh_hunt(self, task: ScheduledTask) -> str:
        """Generate HH hunting script"""
        scan_radius = task.config.get('scan_radius', 50)
        scouts_per_batch = task.config.get('scouts_per_batch', 5)
        
        return f"""// BORG AUTO - HH Hunt
// Account: {task.account_id}
// Generated: {datetime.now().isoformat()}

setsilence off
echo [AUTO] Starting HH Hunt (radius: {scan_radius})...

// Scan for L10 NPCs
scanmap $c.castle.fieldId$ {scan_radius}
sleep 2
set npcList $c.getMapFieldList(npc,10,{scan_radius},c.castle.fieldId)$
iferror %npcList% noNPCs

setarr npcs "%npcList%"
echo Found %npcs.length% L10 NPCs

// Scout NPCs
set idx 0
set batch 0
label scoutLoop
if {{%idx%>=%npcs.length%}} goto huntDone

scout %npcs[{{%idx%}}]% none s:1
echo Scouting: %npcs[{{%idx%}}]%
set batch {{%batch%+1}}
set idx {{%idx%+1}}

if {{%batch%>={scouts_per_batch}}} goto waitReports
goto scoutLoop

label waitReports
echo Waiting for scout reports...
sleep 30000
// Reports will be parsed by master server
set batch 0
goto scoutLoop

label noNPCs
echo No L10 NPCs found in range

label huntDone
echo [AUTO] HH Hunt complete
"""
    
    def _gen_resource_balance(self, task: ScheduledTask) -> str:
        """Generate resource balancing script"""
        target_city = task.config.get('target_city', '')
        resources = task.config.get('resources', 'f:10000000')
        
        return f"""// BORG AUTO - Resource Balance
// Account: {task.account_id}
// Generated: {datetime.now().isoformat()}

setsilence off
echo [AUTO] Balancing resources...

// Send resources to target city
transport {target_city} t:50000 {resources}

echo [AUTO] Transport sent to {target_city}
"""
    
    def _gen_troop_train(self, task: ScheduledTask) -> str:
        """Generate troop training script"""
        troop_type = task.config.get('troop_type', 'a')
        amount = task.config.get('amount', 10000)
        
        return f"""// BORG AUTO - Troop Training
// Account: {task.account_id}
// Generated: {datetime.now().isoformat()}

setsilence off
echo [AUTO] Training troops...

train {troop_type}:{amount}

echo [AUTO] Queued {amount} {troop_type}
"""
    
    def _gen_overflow_exploit(self, task: ScheduledTask) -> str:
        """Generate overflow exploit script"""
        troop_type = task.config.get('troop_type', 'a')
        overflow_num = task.config.get('overflow_num', 6135037)
        
        return f"""// BORG AUTO - Overflow Exploit
// Account: {task.account_id}
// Generated: {datetime.now().isoformat()}
// WARNING: Use at your own risk!

setsilence off
echo [AUTO] Running overflow exploit...

train {troop_type}:{overflow_num}
sleep 500
cleartroopqueues

echo [AUTO] Overflow exploit executed - check resources!
"""
    
    def _gen_amulet_spin(self, task: ScheduledTask) -> str:
        """Generate amulet spinning script"""
        spins = task.config.get('spins', 10)
        
        return f"""// BORG AUTO - Amulet Spin
// Account: {task.account_id}
// Generated: {datetime.now().isoformat()}

setsilence off
echo [AUTO] Spinning amulets...

set i 0
label spinLoop
if {{%i%>={spins}}} goto spinDone
useitem player.box.gambling.3
sleep 500
set i {{%i%+1}}
goto spinLoop

label spinDone
echo [AUTO] Completed {spins} spins
"""
    
    def _gen_package_claim(self, task: ScheduledTask) -> str:
        """Generate package claiming script"""
        return f"""// BORG AUTO - Package Claim
// Account: {task.account_id}
// Generated: {datetime.now().isoformat()}

setsilence off
echo [AUTO] Claiming packages...

getpackages

echo [AUTO] Packages claimed
"""
    
    def _gen_custom_script(self, task: ScheduledTask) -> str:
        """Generate custom script from config"""
        script = task.config.get('script', '// No custom script defined')
        return f"""// BORG AUTO - Custom Script
// Account: {task.account_id}
// Generated: {datetime.now().isoformat()}

{script}
"""
    
    # =========================================================================
    # PRESET CONFIGURATIONS
    # =========================================================================
    
    @staticmethod
    def get_preset_configs() -> Dict[str, List[Dict]]:
        """Get preset automation configurations"""
        return {
            'basic_farm': [
                {'type': TaskType.TAX_COLLECT, 'interval': 15, 'config': {'tax_rate': 100}},
                {'type': TaskType.QUEST_COMPLETE, 'interval': 60, 'config': {}},
                {'type': TaskType.COLONY_LEVY, 'interval': 30, 'config': {}},
            ],
            'aggressive_farm': [
                {'type': TaskType.TAX_COLLECT, 'interval': 10, 'config': {'tax_rate': 100}},
                {'type': TaskType.QUEST_COMPLETE, 'interval': 30, 'config': {}},
                {'type': TaskType.COLONY_LEVY, 'interval': 15, 'config': {}},
                {'type': TaskType.NPC_FARM, 'interval': 20, 'config': {'npc_level': 5, 'waves': 5}},
                {'type': TaskType.AMULET_SPIN, 'interval': 60, 'config': {'spins': 5}},
            ],
            'hh_hunter': [
                {'type': TaskType.HH_HUNT, 'interval': 120, 'config': {'scan_radius': 100}},
            ],
            'exploit_mode': [
                {'type': TaskType.OVERFLOW_EXPLOIT, 'interval': 300, 'config': {'troop_type': 'a', 'overflow_num': 6135037}},
                {'type': TaskType.TAX_COLLECT, 'interval': 15, 'config': {'tax_rate': 100}},
            ],
        }
    
    def apply_preset(self, account_id: str, preset_name: str) -> List[str]:
        """Apply a preset configuration to an account"""
        presets = self.get_preset_configs()
        if preset_name not in presets:
            return []
        
        task_ids = []
        for config in presets[preset_name]:
            task = ScheduledTask(
                id="",
                account_id=account_id,
                city_id="*",
                task_type=config['type'],
                interval_minutes=config['interval'],
                config=config['config']
            )
            task_id = self.add_task(task)
            task_ids.append(task_id)
        
        return task_ids
    
    # =========================================================================
    # EXECUTION LOOP
    # =========================================================================
    
    async def run_loop(self, send_callback: Callable):
        """
        Main automation loop.
        
        send_callback: async function to send script to account
                      signature: send_callback(account_id: str, script: str)
        """
        self.running = True
        print("[Automation] Starting automation loop...")
        
        while self.running:
            try:
                # Get due tasks
                due_tasks = self.get_due_tasks()
                
                for task in due_tasks:
                    try:
                        # Generate script
                        script = self.generate_script(task)
                        
                        # Send to account
                        await send_callback(task.account_id, script)
                        
                        # Update schedule
                        self.update_task_schedule(task)
                        
                        # Log result
                        result = TaskResult(
                            task_id=task.id,
                            success=True,
                            message=f"Task {task.task_type.value} executed"
                        )
                        self.results.append(result)
                        
                        print(f"[Automation] Executed {task.task_type.value} for {task.account_id}")
                        
                    except Exception as e:
                        task.error_count += 1
                        task.last_error = str(e)
                        print(f"[Automation] Error in task {task.id}: {e}")
                
                # Wait before next check
                await asyncio.sleep(10)
                
            except Exception as e:
                print(f"[Automation] Loop error: {e}")
                await asyncio.sleep(30)
        
        print("[Automation] Loop stopped")
    
    def stop(self):
        """Stop the automation loop"""
        self.running = False
    
    # =========================================================================
    # STATISTICS
    # =========================================================================
    
    def get_stats(self) -> Dict:
        """Get automation statistics"""
        return {
            'total_tasks': len(self.tasks),
            'enabled_tasks': sum(1 for t in self.tasks.values() if t.enabled),
            'total_runs': sum(t.run_count for t in self.tasks.values()),
            'total_errors': sum(t.error_count for t in self.tasks.values()),
            'recent_results': len(self.results),
        }
    
    def get_task_summary(self) -> List[Dict]:
        """Get summary of all tasks"""
        summary = []
        for task in self.tasks.values():
            summary.append({
                'id': task.id,
                'account_id': task.account_id,
                'type': task.task_type.value,
                'enabled': task.enabled,
                'interval_minutes': task.interval_minutes,
                'run_count': task.run_count,
                'error_count': task.error_count,
                'next_run': task.next_run.isoformat() if task.next_run else None,
            })
        return summary


# =============================================================================
# CONVENIENCE FUNCTIONS
# =============================================================================

def create_quick_task(account_id: str, task_type: str, interval: int = 60, **config) -> ScheduledTask:
    """Quick task creation helper"""
    try:
        tt = TaskType(task_type)
    except ValueError:
        tt = TaskType.CUSTOM_SCRIPT
    
    return ScheduledTask(
        id="",
        account_id=account_id,
        city_id="*",
        task_type=tt,
        interval_minutes=interval,
        config=config
    )


# =============================================================================
# DEMO
# =============================================================================

if __name__ == "__main__":
    engine = AutomationEngine()
    
    print("BORG TOOLKIT - Automation Engine")
    print("=" * 50)
    
    # Show presets
    print("\nAvailable Presets:")
    for name, tasks in engine.get_preset_configs().items():
        print(f"  {name}:")
        for t in tasks:
            print(f"    - {t['type'].value} (every {t['interval']} min)")
    
    # Demo task creation
    print("\nDemo: Creating tasks...")
    task = create_quick_task("demo_account", "tax_collect", interval=15, tax_rate=100)
    task_id = engine.add_task(task)
    print(f"  Created task: {task_id}")
    
    # Generate script
    print("\nGenerated Script:")
    print("-" * 40)
    print(engine.generate_script(task))
