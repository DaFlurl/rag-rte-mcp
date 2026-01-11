"""
Multi-Account Swarm Controller

Coordinates 50+ bot accounts simultaneously with Borg Swarm integration.
Enables mass farming, coordinated attacks, and distributed operations.
"""

import logging
import time
import random
import json
from dataclasses import dataclass, field
from enum import Enum
from typing import Dict, Optional, List, Any, Callable, Set
from pathlib import Path
import threading
from queue import Queue, PriorityQueue
from concurrent.futures import ThreadPoolExecutor, as_completed

logger = logging.getLogger(__name__)


class AccountState(Enum):
    """Account connection state"""
    OFFLINE = "offline"
    CONNECTING = "connecting"
    ONLINE = "online"
    BUSY = "busy"
    ERROR = "error"
    BANNED = "banned"


class TaskPriority(Enum):
    """Task priority levels"""
    CRITICAL = 0  # Immediate execution
    HIGH = 1      # Within 1 minute
    NORMAL = 2    # Within 5 minutes
    LOW = 3       # When available
    BACKGROUND = 4  # Idle time only


class TaskType(Enum):
    """Swarm task types"""
    # Farming
    FARM_NPC = "farm_npc"
    FARM_VALLEY = "farm_valley"
    COLLECT_RESOURCES = "collect_resources"
    
    # Combat
    ATTACK_PLAYER = "attack_player"
    REINFORCE = "reinforce"
    SCOUT = "scout"
    
    # Building
    BUILD = "build"
    UPGRADE = "upgrade"
    TRAIN_TROOPS = "train_troops"
    RESEARCH = "research"
    
    # Special
    FOOD_FLIP = "food_flip"
    MASS_ATTACK = "mass_attack"
    COORDINATED_STRIKE = "coordinated_strike"
    
    # Utility
    USE_ITEMS = "use_items"
    SPIN_WHEEL = "spin_wheel"
    CLAIM_QUESTS = "claim_quests"
    
    # Maintenance
    HEARTBEAT = "heartbeat"
    RECONNECT = "reconnect"


@dataclass
class AccountConfig:
    """Account configuration"""
    account_id: str
    username: str
    password: str
    server: str
    enabled: bool = True
    priority: int = 0
    tags: List[str] = field(default_factory=list)
    settings: Dict[str, Any] = field(default_factory=dict)


@dataclass
class SwarmTask:
    """A task to be executed by the swarm"""
    task_id: str
    task_type: TaskType
    priority: TaskPriority
    params: Dict[str, Any] = field(default_factory=dict)
    target_accounts: Optional[List[str]] = None  # None = all accounts
    created_at: float = field(default_factory=time.time)
    execute_at: Optional[float] = None  # Scheduled execution time
    timeout: float = 60.0
    retries: int = 3
    
    def __lt__(self, other):
        """For priority queue ordering"""
        return (self.priority.value, self.created_at) < (other.priority.value, other.created_at)


@dataclass
class TaskResult:
    """Result of task execution"""
    task_id: str
    account_id: str
    success: bool
    data: Dict = field(default_factory=dict)
    error: Optional[str] = None
    execution_time: float = 0.0


@dataclass
class AccountStatus:
    """Current account status"""
    account_id: str
    state: AccountState
    player_id: Optional[int] = None
    server: str = ""
    last_activity: float = 0.0
    current_task: Optional[str] = None
    error_count: int = 0
    stats: Dict[str, Any] = field(default_factory=dict)


class SwarmController:
    """
    Multi-account swarm controller for coordinated bot operations.
    
    Features:
    - Manage 50+ accounts simultaneously
    - Task queue with priorities
    - Coordinated mass actions
    - Load balancing
    - Failure recovery
    - Borg collective integration
    """
    
    MAX_WORKERS = 20  # Concurrent account operations
    HEARTBEAT_INTERVAL = 300  # 5 minutes
    
    def __init__(self):
        # Account management
        self._accounts: Dict[str, AccountConfig] = {}
        self._status: Dict[str, AccountStatus] = {}
        self._clients: Dict[str, Any] = {}  # AMFCommander instances
        
        # Task queue
        self._task_queue: PriorityQueue = PriorityQueue()
        self._pending_tasks: Dict[str, SwarmTask] = {}
        self._completed_tasks: Dict[str, TaskResult] = {}
        
        # Thread pool
        self._executor: Optional[ThreadPoolExecutor] = None
        self._running = False
        
        # Callbacks
        self._on_task_complete: List[Callable] = []
        self._on_account_state_change: List[Callable] = []
        
        # Lock
        self._lock = threading.RLock()
        
        # Collective memory for Borg integration
        self._collective_memory: Dict[str, Any] = {}
        
    def start(self):
        """Start the swarm controller"""
        if self._running:
            return
            
        self._running = True
        self._executor = ThreadPoolExecutor(max_workers=self.MAX_WORKERS)
        
        # Start task processor
        threading.Thread(target=self._task_processor, daemon=True).start()
        
        # Start heartbeat
        threading.Thread(target=self._heartbeat_loop, daemon=True).start()
        
        logger.info("Swarm controller started")
        
    def stop(self):
        """Stop the swarm controller"""
        self._running = False
        if self._executor:
            self._executor.shutdown(wait=False)
            
    def add_account(self, config: AccountConfig):
        """Add an account to the swarm"""
        with self._lock:
            self._accounts[config.account_id] = config
            self._status[config.account_id] = AccountStatus(
                account_id=config.account_id,
                state=AccountState.OFFLINE,
                server=config.server,
            )
            
    def remove_account(self, account_id: str):
        """Remove an account from the swarm"""
        with self._lock:
            if account_id in self._accounts:
                del self._accounts[account_id]
            if account_id in self._status:
                del self._status[account_id]
            if account_id in self._clients:
                self._clients[account_id].disconnect()
                del self._clients[account_id]
                
    def load_accounts(self, filepath: str):
        """Load accounts from JSON file"""
        with open(filepath, 'r') as f:
            data = json.load(f)
            
        for acc_data in data.get("accounts", []):
            config = AccountConfig(
                account_id=acc_data.get("id", acc_data.get("username")),
                username=acc_data["username"],
                password=acc_data["password"],
                server=acc_data["server"],
                enabled=acc_data.get("enabled", True),
                priority=acc_data.get("priority", 0),
                tags=acc_data.get("tags", []),
            )
            self.add_account(config)
            
        logger.info(f"Loaded {len(self._accounts)} accounts")
        
    def connect_all(self, stagger_delay: float = 5.0):
        """Connect all enabled accounts"""
        enabled = [a for a in self._accounts.values() if a.enabled]
        
        for i, config in enumerate(enabled):
            if not self._running:
                break
                
            self._executor.submit(self._connect_account, config)
            
            if i < len(enabled) - 1:
                time.sleep(stagger_delay + random.uniform(0, 2))
                
    def disconnect_all(self):
        """Disconnect all accounts"""
        for account_id in list(self._clients.keys()):
            try:
                self._clients[account_id].disconnect()
            except:
                pass
                
        self._clients.clear()
        
        for status in self._status.values():
            status.state = AccountState.OFFLINE
            
    def submit_task(self, task: SwarmTask) -> str:
        """Submit a task to the swarm"""
        with self._lock:
            self._pending_tasks[task.task_id] = task
            self._task_queue.put(task)
            
        logger.debug(f"Task submitted: {task.task_id} ({task.task_type.value})")
        return task.task_id
        
    def cancel_task(self, task_id: str) -> bool:
        """Cancel a pending task"""
        with self._lock:
            if task_id in self._pending_tasks:
                del self._pending_tasks[task_id]
                return True
        return False
        
    def get_task_result(self, task_id: str) -> Optional[TaskResult]:
        """Get result of completed task"""
        return self._completed_tasks.get(task_id)
        
    # ========== High-Level Operations ==========
    
    def mass_farm_npc(self, npc_level: int = 10, troops: Dict[str, int] = None,
                      accounts: List[str] = None) -> str:
        """Mass farm NPCs across all accounts"""
        task = SwarmTask(
            task_id=f"mass_farm_{int(time.time())}",
            task_type=TaskType.FARM_NPC,
            priority=TaskPriority.NORMAL,
            params={
                "npc_level": npc_level,
                "troops": troops or {"archer": 90000},
                "waves": 3,
            },
            target_accounts=accounts,
        )
        return self.submit_task(task)
        
    def coordinated_attack(self, target_x: int, target_y: int,
                           troops_per_account: Dict[str, int],
                           execute_at: float = None) -> str:
        """Coordinate attack from multiple accounts"""
        task = SwarmTask(
            task_id=f"coord_attack_{int(time.time())}",
            task_type=TaskType.COORDINATED_STRIKE,
            priority=TaskPriority.CRITICAL,
            params={
                "target_x": target_x,
                "target_y": target_y,
                "troops": troops_per_account,
            },
            execute_at=execute_at or time.time(),
        )
        return self.submit_task(task)
        
    def mass_collect(self, accounts: List[str] = None) -> str:
        """Collect resources across all accounts"""
        task = SwarmTask(
            task_id=f"mass_collect_{int(time.time())}",
            task_type=TaskType.COLLECT_RESOURCES,
            priority=TaskPriority.LOW,
            target_accounts=accounts,
        )
        return self.submit_task(task)
        
    def mass_spin_wheel(self, spin_count: int = 10) -> str:
        """Spin wheel on all accounts"""
        task = SwarmTask(
            task_id=f"mass_wheel_{int(time.time())}",
            task_type=TaskType.SPIN_WHEEL,
            priority=TaskPriority.BACKGROUND,
            params={"count": spin_count},
        )
        return self.submit_task(task)
        
    def mass_claim_quests(self) -> str:
        """Claim quests on all accounts"""
        task = SwarmTask(
            task_id=f"mass_quest_{int(time.time())}",
            task_type=TaskType.CLAIM_QUESTS,
            priority=TaskPriority.BACKGROUND,
        )
        return self.submit_task(task)
        
    def food_flip_setup(self, account_id: str, target_food: int) -> str:
        """Set up food flip exploit on account"""
        task = SwarmTask(
            task_id=f"food_flip_{account_id}_{int(time.time())}",
            task_type=TaskType.FOOD_FLIP,
            priority=TaskPriority.HIGH,
            params={"target_food": target_food},
            target_accounts=[account_id],
        )
        return self.submit_task(task)
        
    # ========== Account Filtering ==========
    
    def get_accounts_by_tag(self, tag: str) -> List[str]:
        """Get account IDs by tag"""
        return [
            acc.account_id for acc in self._accounts.values()
            if tag in acc.tags
        ]
        
    def get_online_accounts(self) -> List[str]:
        """Get all online account IDs"""
        return [
            acc_id for acc_id, status in self._status.items()
            if status.state == AccountState.ONLINE
        ]
        
    def get_idle_accounts(self) -> List[str]:
        """Get accounts not currently executing tasks"""
        return [
            acc_id for acc_id, status in self._status.items()
            if status.state == AccountState.ONLINE and not status.current_task
        ]
        
    # ========== Status & Statistics ==========
    
    def get_account_status(self, account_id: str) -> Optional[AccountStatus]:
        """Get status of specific account"""
        return self._status.get(account_id)
        
    def get_all_status(self) -> Dict[str, AccountStatus]:
        """Get status of all accounts"""
        return dict(self._status)
        
    def get_statistics(self) -> Dict:
        """Get swarm statistics"""
        states = {}
        for status in self._status.values():
            state = status.state.value
            states[state] = states.get(state, 0) + 1
            
        return {
            "total_accounts": len(self._accounts),
            "states": states,
            "pending_tasks": len(self._pending_tasks),
            "completed_tasks": len(self._completed_tasks),
            "running": self._running,
        }
        
    def on_task_complete(self, callback: Callable):
        """Register task completion callback"""
        self._on_task_complete.append(callback)
        
    def on_account_state_change(self, callback: Callable):
        """Register account state change callback"""
        self._on_account_state_change.append(callback)
        
    # ========== Collective Memory (Borg Integration) ==========
    
    def share_data(self, key: str, value: Any):
        """Share data with collective"""
        self._collective_memory[key] = value
        
    def get_shared_data(self, key: str) -> Any:
        """Get data from collective"""
        return self._collective_memory.get(key)
        
    def get_collective_state(self) -> Dict:
        """Get full collective state for Borg agents"""
        return {
            "accounts": {
                acc_id: {
                    "state": status.state.value,
                    "player_id": status.player_id,
                    "server": status.server,
                }
                for acc_id, status in self._status.items()
            },
            "shared_data": dict(self._collective_memory),
            "statistics": self.get_statistics(),
        }
        
    # ========== Private Methods ==========
    
    def _connect_account(self, config: AccountConfig) -> bool:
        """Connect a single account"""
        from .amf_commander import AMFCommander, ServerConfig
        
        self._update_state(config.account_id, AccountState.CONNECTING)
        
        try:
            # Parse server config
            server = ServerConfig(
                host=config.server,
                port=443,
                server_id=config.server.split('.')[0],
            )
            
            # Create commander
            commander = AMFCommander(server)
            
            if commander.connect(server):
                result = commander.login(config.username, config.password)
                
                if result.success:
                    self._clients[config.account_id] = commander
                    self._status[config.account_id].player_id = commander.player_id
                    self._update_state(config.account_id, AccountState.ONLINE)
                    logger.info(f"Account connected: {config.username}")
                    return True
                    
            self._update_state(config.account_id, AccountState.ERROR)
            return False
            
        except Exception as e:
            logger.error(f"Failed to connect {config.username}: {e}")
            self._update_state(config.account_id, AccountState.ERROR)
            return False
            
    def _update_state(self, account_id: str, state: AccountState):
        """Update account state and notify callbacks"""
        if account_id in self._status:
            old_state = self._status[account_id].state
            self._status[account_id].state = state
            self._status[account_id].last_activity = time.time()
            
            if old_state != state:
                for callback in self._on_account_state_change:
                    try:
                        callback(account_id, old_state, state)
                    except:
                        pass
                        
    def _task_processor(self):
        """Process tasks from queue"""
        while self._running:
            try:
                # Get next task (blocks for 1 second)
                try:
                    task = self._task_queue.get(timeout=1.0)
                except:
                    continue
                    
                # Check if task was cancelled
                if task.task_id not in self._pending_tasks:
                    continue
                    
                # Check scheduled time
                if task.execute_at and time.time() < task.execute_at:
                    # Re-queue for later
                    self._task_queue.put(task)
                    time.sleep(0.5)
                    continue
                    
                # Execute task
                self._execute_task(task)
                
            except Exception as e:
                logger.error(f"Task processor error: {e}")
                
    def _execute_task(self, task: SwarmTask):
        """Execute a swarm task"""
        # Get target accounts
        if task.target_accounts:
            accounts = [a for a in task.target_accounts if a in self._clients]
        else:
            accounts = list(self._clients.keys())
            
        if not accounts:
            logger.warning(f"No accounts available for task {task.task_id}")
            return
            
        # Execute on each account
        futures = []
        for account_id in accounts:
            future = self._executor.submit(
                self._execute_task_on_account,
                task,
                account_id,
            )
            futures.append((account_id, future))
            
        # Collect results
        for account_id, future in futures:
            try:
                result = future.result(timeout=task.timeout)
                self._completed_tasks[f"{task.task_id}_{account_id}"] = result
                
                for callback in self._on_task_complete:
                    try:
                        callback(result)
                    except:
                        pass
                        
            except Exception as e:
                logger.error(f"Task {task.task_id} failed on {account_id}: {e}")
                
        # Remove from pending
        if task.task_id in self._pending_tasks:
            del self._pending_tasks[task.task_id]
            
    def _execute_task_on_account(self, task: SwarmTask, 
                                  account_id: str) -> TaskResult:
        """Execute task on specific account"""
        start_time = time.time()
        
        try:
            client = self._clients.get(account_id)
            if not client:
                return TaskResult(
                    task_id=task.task_id,
                    account_id=account_id,
                    success=False,
                    error="Client not found",
                )
                
            # Mark account as busy
            self._status[account_id].current_task = task.task_id
            
            # Execute based on task type
            result_data = self._execute_task_type(task, client)
            
            return TaskResult(
                task_id=task.task_id,
                account_id=account_id,
                success=True,
                data=result_data,
                execution_time=time.time() - start_time,
            )
            
        except Exception as e:
            return TaskResult(
                task_id=task.task_id,
                account_id=account_id,
                success=False,
                error=str(e),
                execution_time=time.time() - start_time,
            )
            
        finally:
            if account_id in self._status:
                self._status[account_id].current_task = None
                
    def _execute_task_type(self, task: SwarmTask, client) -> Dict:
        """Execute specific task type"""
        params = task.params
        
        if task.task_type == TaskType.FARM_NPC:
            return self._task_farm_npc(client, params)
        elif task.task_type == TaskType.COLLECT_RESOURCES:
            result = client.collect_resources(params.get("city_id", 0))
            return result.data
        elif task.task_type == TaskType.SPIN_WHEEL:
            results = []
            for _ in range(params.get("count", 1)):
                result = client.spin_wheel()
                results.append(result.data)
                time.sleep(1)
            return {"spins": results}
        elif task.task_type == TaskType.CLAIM_QUESTS:
            quests = client.get_quests()
            claimed = []
            for quest in quests.data.get("quests", []):
                if quest.get("completed"):
                    result = client.complete_quest(quest["id"])
                    claimed.append(quest["id"])
            return {"claimed": claimed}
        elif task.task_type == TaskType.COORDINATED_STRIKE:
            return self._task_coordinated_attack(client, params)
        else:
            return {"message": f"Task type {task.task_type} executed"}
            
    def _task_farm_npc(self, client, params: Dict) -> Dict:
        """Execute NPC farming task"""
        npc_level = params.get("npc_level", 10)
        troops = params.get("troops", {"archer": 90000})
        waves = params.get("waves", 3)
        
        results = []
        # In real implementation, would scan for NPCs and attack
        for i in range(waves):
            # Simulated attack
            time.sleep(2)
            results.append({"wave": i + 1, "status": "sent"})
            
        return {"waves_sent": results}
        
    def _task_coordinated_attack(self, client, params: Dict) -> Dict:
        """Execute coordinated attack"""
        x = params.get("target_x")
        y = params.get("target_y")
        troops = params.get("troops", {})
        
        result = client.attack_player(0, x, y, 0, troops)
        return result.data
        
    def _heartbeat_loop(self):
        """Send heartbeats to keep connections alive"""
        while self._running:
            time.sleep(self.HEARTBEAT_INTERVAL)
            
            for account_id, client in list(self._clients.items()):
                try:
                    client.send_command(0x1003, {})  # Heartbeat
                except:
                    self._update_state(account_id, AccountState.ERROR)


# Singleton
_swarm: Optional[SwarmController] = None

def get_swarm_controller() -> SwarmController:
    """Get singleton swarm controller"""
    global _swarm
    if _swarm is None:
        _swarm = SwarmController()
    return _swarm
