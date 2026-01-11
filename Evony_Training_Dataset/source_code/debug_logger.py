"""
ETK SOL Manager - Advanced Debug Logging System

Provides comprehensive debugging with:
1. Multi-level logging (DEBUG, INFO, WARNING, ERROR, CRITICAL)
2. File rotation and retention
3. Process launch tracking
4. SOL file change tracking
5. System state snapshots
6. Performance timing
"""

import os
import sys
import time
import json
import traceback
import logging
import logging.handlers
from pathlib import Path
from datetime import datetime
from typing import Dict, Any, Optional, List, Callable
from functools import wraps
from contextlib import contextmanager
from dataclasses import dataclass, asdict
import threading

# ============================================================================
# LOG CONFIGURATION
# ============================================================================

LOG_FORMAT_DETAILED = (
    '%(asctime)s | %(levelname)-8s | %(name)-20s | '
    '%(filename)s:%(lineno)d | %(funcName)s | %(message)s'
)
LOG_FORMAT_SIMPLE = '[%(levelname)s] %(message)s'
LOG_DATE_FORMAT = '%Y-%m-%d %H:%M:%S'

MAX_LOG_SIZE = 10 * 1024 * 1024  # 10MB
BACKUP_COUNT = 5


@dataclass
class ProcessLaunchLog:
    """Log entry for process launches"""
    timestamp: str
    exe_path: str
    working_dir: str
    arguments: List[str]
    environment: Dict[str, str]
    success: bool
    error_message: str = ""
    pid: int = 0
    exit_code: Optional[int] = None


@dataclass
class SOLChangeLog:
    """Log entry for SOL file changes"""
    timestamp: str
    file_path: str
    change_type: str  # created, modified, deleted
    old_size: int = 0
    new_size: int = 0
    old_hash: str = ""
    new_hash: str = ""


class DebugLogger:
    """
    Advanced debugging logger with comprehensive tracking.
    
    Features:
    - Rotating file logs
    - Process launch tracking
    - SOL file change tracking
    - Performance timing
    - System state snapshots
    """
    
    def __init__(self, log_dir: Path, name: str = "ETK_Debug"):
        self.log_dir = Path(log_dir)
        self.log_dir.mkdir(parents=True, exist_ok=True)
        self.name = name
        
        # Main logger
        self.logger = logging.getLogger(name)
        self.logger.setLevel(logging.DEBUG)
        self.logger.handlers.clear()
        
        # Setup handlers
        self._setup_file_handler()
        self._setup_console_handler()
        self._setup_error_handler()
        
        # Tracking storage
        self.process_logs: List[ProcessLaunchLog] = []
        self.sol_change_logs: List[SOLChangeLog] = []
        self._lock = threading.Lock()
        
        self.info("Debug logger initialized")
        self.info(f"Log directory: {self.log_dir}")
    
    def _setup_file_handler(self):
        """Setup rotating file handler for detailed logs"""
        log_file = self.log_dir / "debug.log"
        handler = logging.handlers.RotatingFileHandler(
            log_file,
            maxBytes=MAX_LOG_SIZE,
            backupCount=BACKUP_COUNT,
            encoding='utf-8'
        )
        handler.setLevel(logging.DEBUG)
        handler.setFormatter(logging.Formatter(LOG_FORMAT_DETAILED, LOG_DATE_FORMAT))
        self.logger.addHandler(handler)
    
    def _setup_console_handler(self):
        """Setup console handler for info+ logs"""
        handler = logging.StreamHandler(sys.stdout)
        handler.setLevel(logging.INFO)
        handler.setFormatter(logging.Formatter(LOG_FORMAT_SIMPLE))
        self.logger.addHandler(handler)
    
    def _setup_error_handler(self):
        """Setup separate error log file"""
        error_file = self.log_dir / "errors.log"
        handler = logging.handlers.RotatingFileHandler(
            error_file,
            maxBytes=MAX_LOG_SIZE,
            backupCount=BACKUP_COUNT,
            encoding='utf-8'
        )
        handler.setLevel(logging.ERROR)
        handler.setFormatter(logging.Formatter(LOG_FORMAT_DETAILED, LOG_DATE_FORMAT))
        self.logger.addHandler(handler)
    
    # Standard logging methods
    def debug(self, msg: str, *args, **kwargs):
        self.logger.debug(msg, *args, **kwargs)
    
    def info(self, msg: str, *args, **kwargs):
        self.logger.info(msg, *args, **kwargs)
    
    def warning(self, msg: str, *args, **kwargs):
        self.logger.warning(msg, *args, **kwargs)
    
    def error(self, msg: str, *args, **kwargs):
        self.logger.error(msg, *args, **kwargs)
    
    def critical(self, msg: str, *args, **kwargs):
        self.logger.critical(msg, *args, **kwargs)
    
    def exception(self, msg: str, *args, **kwargs):
        self.logger.exception(msg, *args, **kwargs)
    
    # Process launch logging
    def log_process_launch(self, exe_path: str, working_dir: str, 
                           arguments: List[str] = None,
                           environment: Dict[str, str] = None,
                           success: bool = True,
                           error_message: str = "",
                           pid: int = 0):
        """Log a process launch attempt"""
        entry = ProcessLaunchLog(
            timestamp=datetime.now().isoformat(),
            exe_path=exe_path,
            working_dir=working_dir,
            arguments=arguments or [],
            environment=environment or {},
            success=success,
            error_message=error_message,
            pid=pid
        )
        
        with self._lock:
            self.process_logs.append(entry)
        
        if success:
            self.info(f"Process launched: {exe_path} (PID: {pid})")
            self.debug(f"  Working dir: {working_dir}")
            self.debug(f"  Arguments: {arguments}")
        else:
            self.error(f"Process launch FAILED: {exe_path}")
            self.error(f"  Error: {error_message}")
            self.error(f"  Working dir: {working_dir}")
        
        # Save to file
        self._save_process_log(entry)
    
    def _save_process_log(self, entry: ProcessLaunchLog):
        """Save process log to JSON file"""
        log_file = self.log_dir / "process_launches.json"
        try:
            logs = []
            if log_file.exists():
                with open(log_file, 'r') as f:
                    logs = json.load(f)
            logs.append(asdict(entry))
            # Keep last 100 entries
            logs = logs[-100:]
            with open(log_file, 'w') as f:
                json.dump(logs, f, indent=2)
        except Exception as e:
            self.debug(f"Failed to save process log: {e}")
    
    # SOL file change logging
    def log_sol_change(self, file_path: str, change_type: str,
                       old_size: int = 0, new_size: int = 0,
                       old_hash: str = "", new_hash: str = ""):
        """Log a SOL file change"""
        entry = SOLChangeLog(
            timestamp=datetime.now().isoformat(),
            file_path=file_path,
            change_type=change_type,
            old_size=old_size,
            new_size=new_size,
            old_hash=old_hash,
            new_hash=new_hash
        )
        
        with self._lock:
            self.sol_change_logs.append(entry)
        
        self.info(f"SOL {change_type}: {file_path}")
        self.debug(f"  Size: {old_size} -> {new_size}")
    
    # Performance timing
    @contextmanager
    def timer(self, operation: str):
        """Context manager for timing operations"""
        start = time.perf_counter()
        self.debug(f"Starting: {operation}")
        try:
            yield
        finally:
            elapsed = time.perf_counter() - start
            self.debug(f"Completed: {operation} in {elapsed:.3f}s")
    
    def timed(self, func: Callable):
        """Decorator for timing function calls"""
        @wraps(func)
        def wrapper(*args, **kwargs):
            with self.timer(f"{func.__module__}.{func.__name__}"):
                return func(*args, **kwargs)
        return wrapper
    
    # System state
    def log_system_state(self):
        """Log current system state for debugging"""
        self.info("=" * 50)
        self.info("SYSTEM STATE SNAPSHOT")
        self.info("=" * 50)
        
        # Python info
        self.info(f"Python: {sys.version}")
        self.info(f"Platform: {sys.platform}")
        self.info(f"CWD: {os.getcwd()}")
        
        # Process info
        self.info(f"Process launches logged: {len(self.process_logs)}")
        self.info(f"SOL changes logged: {len(self.sol_change_logs)}")
        
        # Environment
        relevant_env = ['APPDATA', 'PATH', 'USERPROFILE', 'TEMP']
        for key in relevant_env:
            val = os.environ.get(key, 'NOT SET')
            self.debug(f"ENV {key}: {val[:100]}...")
    
    # Detailed exception logging
    def log_exception_details(self, exc: Exception, context: str = ""):
        """Log detailed exception information"""
        self.error("=" * 50)
        self.error(f"EXCEPTION: {context}" if context else "EXCEPTION OCCURRED")
        self.error("=" * 50)
        self.error(f"Type: {type(exc).__name__}")
        self.error(f"Message: {str(exc)}")
        self.error("Traceback:")
        for line in traceback.format_exc().split('\n'):
            self.error(f"  {line}")
    
    # Validation helpers
    def validate_path(self, path: Path, description: str) -> bool:
        """Validate and log path existence"""
        exists = path.exists()
        if exists:
            self.debug(f"✓ {description}: {path}")
        else:
            self.warning(f"✗ {description} NOT FOUND: {path}")
        return exists
    
    def validate_executable(self, exe_path: Path) -> bool:
        """Validate executable file"""
        if not exe_path.exists():
            self.error(f"Executable not found: {exe_path}")
            return False
        
        if not exe_path.is_file():
            self.error(f"Not a file: {exe_path}")
            return False
        
        # Check file size
        size = exe_path.stat().st_size
        if size == 0:
            self.error(f"Executable is empty (0 bytes): {exe_path}")
            return False
        
        self.debug(f"Executable validated: {exe_path} ({size:,} bytes)")
        return True


# ============================================================================
# SINGLETON INSTANCE
# ============================================================================

_debug_logger: Optional[DebugLogger] = None


def get_debug_logger(log_dir: Path = None) -> DebugLogger:
    """Get singleton debug logger"""
    global _debug_logger
    if _debug_logger is None:
        if log_dir is None:
            # Default to project logs folder
            from .portable_config import get_config_manager
            log_dir = get_config_manager().get_logs_path()
        _debug_logger = DebugLogger(log_dir)
    return _debug_logger


def debug(msg: str):
    get_debug_logger().debug(msg)


def info(msg: str):
    get_debug_logger().info(msg)


def warning(msg: str):
    get_debug_logger().warning(msg)


def error(msg: str):
    get_debug_logger().error(msg)


def log_launch(exe: str, cwd: str, success: bool, error: str = "", pid: int = 0):
    get_debug_logger().log_process_launch(exe, cwd, success=success, error_message=error, pid=pid)
