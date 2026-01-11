"""
Real-Time Script Tester

Tests scripts and exploits in real-time using actual game accounts:
- Live account integration
- Script execution monitoring
- Result validation
- Exploit verification
- Learning from outcomes
"""

import logging
import time
import json
import threading
from dataclasses import dataclass, field
from datetime import datetime
from enum import Enum
from typing import Dict, Optional, List, Any, Callable
from queue import Queue
from pathlib import Path

logger = logging.getLogger(__name__)


class TestStatus(Enum):
    """Test execution status"""
    PENDING = "pending"
    RUNNING = "running"
    SUCCESS = "success"
    FAILED = "failed"
    ERROR = "error"
    TIMEOUT = "timeout"


@dataclass
class TestResult:
    """Result of a single test"""
    test_id: str
    script_name: str
    account: str
    status: TestStatus
    started_at: datetime
    completed_at: Optional[datetime] = None
    duration_ms: int = 0
    state_before: Dict = field(default_factory=dict)
    state_after: Dict = field(default_factory=dict)
    changes_detected: Dict = field(default_factory=dict)
    exploit_triggered: bool = False
    exploit_type: str = ""
    error_message: str = ""
    logs: List[str] = field(default_factory=list)
    
    def to_dict(self) -> Dict:
        return {
            "test_id": self.test_id,
            "script_name": self.script_name,
            "account": self.account,
            "status": self.status.value,
            "duration_ms": self.duration_ms,
            "changes": self.changes_detected,
            "exploit_triggered": self.exploit_triggered,
            "exploit_type": self.exploit_type,
            "error": self.error_message,
        }


@dataclass
class TestConfig:
    """Configuration for a test run"""
    script_path: str = ""
    script_content: str = ""
    accounts: List[str] = field(default_factory=list)
    timeout_seconds: int = 300
    capture_state: bool = True
    detect_exploits: bool = True
    retry_on_fail: int = 0
    parallel: bool = False


class AccountConnector:
    """
    Manages connections to game accounts for testing.
    """
    
    def __init__(self):
        self._connections: Dict[str, Any] = {}
        self._lock = threading.Lock()
        
    def connect(self, account_id: str, credentials: Dict) -> bool:
        """Connect to a game account"""
        try:
            # This would integrate with AMFCommander
            # For now, simulate connection
            with self._lock:
                self._connections[account_id] = {
                    "connected": True,
                    "connected_at": datetime.now(),
                    "credentials": credentials,
                }
            logger.info(f"Connected to account: {account_id}")
            return True
        except Exception as e:
            logger.error(f"Failed to connect {account_id}: {e}")
            return False
            
    def disconnect(self, account_id: str):
        """Disconnect from account"""
        with self._lock:
            if account_id in self._connections:
                del self._connections[account_id]
                
    def is_connected(self, account_id: str) -> bool:
        """Check if account is connected"""
        return account_id in self._connections
        
    def get_state(self, account_id: str) -> Dict:
        """Get current game state for account"""
        if not self.is_connected(account_id):
            return {}
            
        # This would fetch actual game state
        # Simulated for now
        return {
            "resources": {
                "food": 0,
                "wood": 0,
                "stone": 0,
                "iron": 0,
                "gold": 0,
            },
            "troops": {},
            "cities": [],
            "timestamp": datetime.now().isoformat(),
        }
        
    def execute_command(self, account_id: str, command: str, params: Dict) -> Dict:
        """Execute a game command"""
        if not self.is_connected(account_id):
            return {"error": "Not connected"}
            
        # This would send actual command via AMFCommander
        return {"ok": True, "data": {}}
        
    def get_connected_accounts(self) -> List[str]:
        """Get list of connected accounts"""
        return list(self._connections.keys())


class ScriptExecutor:
    """
    Executes scripts against game accounts.
    """
    
    def __init__(self, connector: AccountConnector):
        self._connector = connector
        self._running_scripts: Dict[str, threading.Thread] = {}
        
    def execute(self, account_id: str, script_content: str,
               callback: Callable[[str, Dict], None] = None) -> str:
        """Execute a script on an account"""
        
        exec_id = f"{account_id}_{int(time.time())}"
        
        thread = threading.Thread(
            target=self._run_script,
            args=(exec_id, account_id, script_content, callback),
            daemon=True
        )
        self._running_scripts[exec_id] = thread
        thread.start()
        
        return exec_id
        
    def _run_script(self, exec_id: str, account_id: str,
                   script_content: str, callback: Callable):
        """Run script in background"""
        try:
            # Parse and execute script
            lines = script_content.strip().split('\n')
            
            for i, line in enumerate(lines):
                line = line.strip()
                if not line or line.startswith('#') or line.startswith('//'):
                    continue
                    
                # Parse command
                result = self._execute_line(account_id, line)
                
                if callback:
                    callback(exec_id, {
                        "line": i,
                        "command": line,
                        "result": result,
                    })
                    
                # Small delay between commands
                time.sleep(0.1)
                
        except Exception as e:
            logger.error(f"Script execution error: {e}")
            if callback:
                callback(exec_id, {"error": str(e)})
                
        finally:
            if exec_id in self._running_scripts:
                del self._running_scripts[exec_id]
                
    def _execute_line(self, account_id: str, line: str) -> Dict:
        """Execute a single script line"""
        parts = line.split()
        if not parts:
            return {}
            
        command = parts[0].lower()
        args = parts[1:] if len(parts) > 1 else []
        
        # Map script commands to game commands
        command_map = {
            "attack": "army.attack",
            "train": "troop.train",
            "build": "castle.build",
            "upgrade": "castle.upgrade",
            "research": "tech.research",
            "collect": "castle.collect",
            "transfer": "troop.transfer",
            "reinforce": "army.reinforce",
        }
        
        if command in command_map:
            return self._connector.execute_command(
                account_id,
                command_map[command],
                {"args": args}
            )
            
        return {"skipped": True, "command": command}
        
    def stop(self, exec_id: str):
        """Stop a running script"""
        # Would need to implement cancellation
        pass


class RealTimeScriptTester:
    """
    Main tester for real-time script and exploit testing.
    
    Features:
    - Test scripts on real accounts
    - Detect state changes and exploits
    - Learn from test outcomes
    - Generate test reports
    """
    
    def __init__(self):
        self._connector = AccountConnector()
        self._executor = ScriptExecutor(self._connector)
        self._results: List[TestResult] = []
        self._test_queue: Queue = Queue()
        self._running = False
        self._worker_thread: Optional[threading.Thread] = None
        self._callbacks: List[Callable] = []
        
        # Exploit detection patterns
        self._exploit_patterns = {
            "troop_multiplication": lambda b, a: self._detect_troop_mult(b, a),
            "resource_spike": lambda b, a: self._detect_resource_spike(b, a),
            "overflow": lambda b, a: self._detect_overflow(b, a),
        }
        
    def add_account(self, account_id: str, credentials: Dict) -> bool:
        """Add and connect an account for testing"""
        return self._connector.connect(account_id, credentials)
        
    def remove_account(self, account_id: str):
        """Remove an account"""
        self._connector.disconnect(account_id)
        
    def queue_test(self, config: TestConfig) -> str:
        """Queue a test for execution"""
        test_id = f"test_{int(time.time() * 1000)}"
        self._test_queue.put({
            "id": test_id,
            "config": config,
            "queued_at": datetime.now(),
        })
        return test_id
        
    def start(self):
        """Start the test runner"""
        self._running = True
        self._worker_thread = threading.Thread(target=self._worker_loop, daemon=True)
        self._worker_thread.start()
        logger.info("Real-time tester started")
        
    def stop(self):
        """Stop the test runner"""
        self._running = False
        if self._worker_thread:
            self._worker_thread.join(timeout=5)
            
    def _worker_loop(self):
        """Background worker for processing tests"""
        while self._running:
            try:
                if self._test_queue.empty():
                    time.sleep(0.5)
                    continue
                    
                test = self._test_queue.get(timeout=1)
                self._execute_test(test["id"], test["config"])
                
            except Exception as e:
                logger.error(f"Test worker error: {e}")
                
    def _execute_test(self, test_id: str, config: TestConfig):
        """Execute a single test"""
        
        # Get accounts to test on
        accounts = config.accounts or self._connector.get_connected_accounts()
        
        if not accounts:
            logger.warning("No accounts available for testing")
            return
            
        # Load script
        script = config.script_content
        if not script and config.script_path:
            with open(config.script_path, 'r') as f:
                script = f.read()
                
        if not script:
            logger.error("No script content to test")
            return
            
        # Execute on each account
        for account in accounts:
            result = self._run_test_on_account(test_id, account, script, config)
            self._results.append(result)
            self._notify_callbacks(result)
            
    def _run_test_on_account(self, test_id: str, account: str,
                            script: str, config: TestConfig) -> TestResult:
        """Run test on a single account"""
        
        result = TestResult(
            test_id=test_id,
            script_name=config.script_path or "inline_script",
            account=account,
            status=TestStatus.RUNNING,
            started_at=datetime.now(),
        )
        
        try:
            # Capture state before
            if config.capture_state:
                result.state_before = self._connector.get_state(account)
                
            # Execute script
            exec_results = []
            
            def on_result(exec_id: str, data: Dict):
                exec_results.append(data)
                result.logs.append(json.dumps(data))
                
            exec_id = self._executor.execute(account, script, on_result)
            
            # Wait for completion (with timeout)
            start = time.time()
            while exec_id in self._executor._running_scripts:
                if time.time() - start > config.timeout_seconds:
                    result.status = TestStatus.TIMEOUT
                    break
                time.sleep(0.5)
            else:
                result.status = TestStatus.SUCCESS
                
            # Capture state after
            if config.capture_state:
                result.state_after = self._connector.get_state(account)
                
            # Detect changes
            result.changes_detected = self._detect_changes(
                result.state_before, result.state_after
            )
            
            # Detect exploits
            if config.detect_exploits:
                exploit_type = self._detect_exploits(
                    result.state_before, result.state_after
                )
                if exploit_type:
                    result.exploit_triggered = True
                    result.exploit_type = exploit_type
                    
        except Exception as e:
            result.status = TestStatus.ERROR
            result.error_message = str(e)
            
        result.completed_at = datetime.now()
        result.duration_ms = int((result.completed_at - result.started_at).total_seconds() * 1000)
        
        return result
        
    def _detect_changes(self, before: Dict, after: Dict) -> Dict:
        """Detect changes between states"""
        changes = {}
        
        # Compare resources
        if 'resources' in before and 'resources' in after:
            res_changes = {}
            for key in set(before['resources'].keys()) | set(after['resources'].keys()):
                b_val = before['resources'].get(key, 0)
                a_val = after['resources'].get(key, 0)
                if b_val != a_val:
                    res_changes[key] = {"before": b_val, "after": a_val, "delta": a_val - b_val}
            if res_changes:
                changes['resources'] = res_changes
                
        # Compare troops
        if 'troops' in before and 'troops' in after:
            troop_changes = {}
            for key in set(before.get('troops', {}).keys()) | set(after.get('troops', {}).keys()):
                b_val = before.get('troops', {}).get(key, 0)
                a_val = after.get('troops', {}).get(key, 0)
                if b_val != a_val:
                    troop_changes[key] = {"before": b_val, "after": a_val, "delta": a_val - b_val}
            if troop_changes:
                changes['troops'] = troop_changes
                
        return changes
        
    def _detect_exploits(self, before: Dict, after: Dict) -> str:
        """Detect if an exploit was triggered"""
        for name, detector in self._exploit_patterns.items():
            if detector(before, after):
                return name
        return ""
        
    def _detect_troop_mult(self, before: Dict, after: Dict) -> bool:
        """Detect troop multiplication"""
        b_troops = before.get('troops', {})
        a_troops = after.get('troops', {})
        
        for troop, b_count in b_troops.items():
            a_count = a_troops.get(troop, 0)
            # Multiplication detected if troops increased by >50% without training
            if b_count > 0 and a_count > b_count * 1.5:
                return True
        return False
        
    def _detect_resource_spike(self, before: Dict, after: Dict) -> bool:
        """Detect unusual resource increase"""
        b_res = before.get('resources', {})
        a_res = after.get('resources', {})
        
        for res, b_val in b_res.items():
            a_val = a_res.get(res, 0)
            # Spike detected if resource more than doubled
            if b_val > 0 and a_val > b_val * 2:
                return True
        return False
        
    def _detect_overflow(self, before: Dict, after: Dict) -> bool:
        """Detect integer overflow"""
        INT32_MAX = 2147483647
        
        # Check troops for overflow
        for troop, count in after.get('troops', {}).items():
            if count < 0 or count > INT32_MAX:
                return True
                
        return False
        
    def add_callback(self, callback: Callable[[TestResult], None]):
        """Add callback for test results"""
        self._callbacks.append(callback)
        
    def _notify_callbacks(self, result: TestResult):
        """Notify all callbacks of result"""
        for callback in self._callbacks:
            try:
                callback(result)
            except Exception as e:
                logger.error(f"Callback error: {e}")
                
    def get_results(self, test_id: str = None) -> List[TestResult]:
        """Get test results"""
        if test_id:
            return [r for r in self._results if r.test_id == test_id]
        return list(self._results)
        
    def get_exploit_results(self) -> List[TestResult]:
        """Get results where exploits were triggered"""
        return [r for r in self._results if r.exploit_triggered]
        
    def get_statistics(self) -> Dict:
        """Get testing statistics"""
        total = len(self._results)
        success = len([r for r in self._results if r.status == TestStatus.SUCCESS])
        exploits = len([r for r in self._results if r.exploit_triggered])
        
        exploit_types = {}
        for r in self._results:
            if r.exploit_triggered:
                exploit_types[r.exploit_type] = exploit_types.get(r.exploit_type, 0) + 1
                
        return {
            "total_tests": total,
            "successful": success,
            "failed": total - success,
            "exploits_found": exploits,
            "exploit_types": exploit_types,
            "accounts_connected": len(self._connector.get_connected_accounts()),
        }
        
    def export_results(self, output_path: str):
        """Export test results"""
        data = {
            "exported_at": datetime.now().isoformat(),
            "statistics": self.get_statistics(),
            "results": [r.to_dict() for r in self._results],
            "exploits": [r.to_dict() for r in self.get_exploit_results()],
        }
        
        with open(output_path, 'w') as f:
            json.dump(data, f, indent=2)


# Singleton
_tester: Optional[RealTimeScriptTester] = None

def get_realtime_tester() -> RealTimeScriptTester:
    """Get singleton real-time tester"""
    global _tester
    if _tester is None:
        _tester = RealTimeScriptTester()
    return _tester
