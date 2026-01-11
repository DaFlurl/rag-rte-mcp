"""
ETK SOL Manager - Portable Configuration & Auto-Heal System

This module provides:
1. Auto-detection of project root (portable - works after moving)
2. Detection of system Macromedia SharedObjects folder (random subfolder like YUGK6X86)
3. SOL file sync between system and project
4. Configuration persistence with auto-heal on project move
5. Detailed logging for debugging

Architecture:
- Project can be moved to any location/drive/PC
- System Macromedia folder: %APPDATA%/Macromedia/Flash Player/#SharedObjects/{RANDOM}/
- Project SOL folder: {PROJECT_ROOT}/SOL_Data/
- Config file: {PROJECT_ROOT}/etk_config.json
"""

import os
import sys
import json
import shutil
import hashlib
import logging
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Optional, Tuple, Any
from dataclasses import dataclass, asdict
import threading
import time

# ============================================================================
# LOGGING SETUP
# ============================================================================

def setup_logging(log_dir: Path) -> logging.Logger:
    """Setup detailed logging with file and console output"""
    log_dir.mkdir(parents=True, exist_ok=True)
    
    logger = logging.getLogger("ETK_SOL_Manager")
    logger.setLevel(logging.DEBUG)
    
    # Clear existing handlers
    logger.handlers.clear()
    
    # File handler - detailed debug log
    log_file = log_dir / f"sol_manager_{datetime.now().strftime('%Y%m%d')}.log"
    file_handler = logging.FileHandler(log_file, encoding='utf-8')
    file_handler.setLevel(logging.DEBUG)
    file_format = logging.Formatter(
        '%(asctime)s | %(levelname)-8s | %(name)s | %(funcName)s:%(lineno)d | %(message)s',
        datefmt='%Y-%m-%d %H:%M:%S'
    )
    file_handler.setFormatter(file_format)
    
    # Console handler - info and above
    console_handler = logging.StreamHandler()
    console_handler.setLevel(logging.INFO)
    console_format = logging.Formatter('[%(levelname)s] %(message)s')
    console_handler.setFormatter(console_format)
    
    logger.addHandler(file_handler)
    logger.addHandler(console_handler)
    
    return logger


# ============================================================================
# PATH DETECTION
# ============================================================================

def get_project_root() -> Path:
    """
    Auto-detect project root directory.
    Works regardless of where project is moved.
    """
    # Method 1: Look for marker files from current file location
    current_file = Path(__file__).resolve()
    search_path = current_file.parent
    
    marker_files = ['SOL_Manager_Pro.bat', 'run_sol_manager.py', 'Botfile']
    
    for _ in range(5):  # Go up to 5 levels
        for marker in marker_files:
            if (search_path / marker).exists():
                return search_path
        search_path = search_path.parent
    
    # Method 2: Check if we're in sol_manager package
    if current_file.parent.name == 'sol_manager':
        return current_file.parent.parent
    
    # Fallback: Use current working directory
    return Path.cwd()


def get_system_macromedia_path() -> Optional[Path]:
    """
    Find the system Macromedia SharedObjects folder.
    Location: %APPDATA%/Macromedia/Flash Player/#SharedObjects/
    """
    appdata = os.environ.get('APPDATA')
    if not appdata:
        return None
    
    macromedia_base = Path(appdata) / "Macromedia" / "Flash Player" / "#SharedObjects"
    
    if macromedia_base.exists():
        return macromedia_base
    return None


def detect_random_subfolder(base_path: Path) -> Optional[str]:
    """
    Detect the random subfolder name (like YUGK6X86) in SharedObjects.
    This folder is created by Flash/RoboEvony and has a random name.
    """
    if not base_path or not base_path.exists():
        return None
    
    # Look for subfolders that look like random IDs (8 chars alphanumeric)
    candidates = []
    for item in base_path.iterdir():
        if item.is_dir():
            name = item.name
            # Random folders are typically 8 uppercase alphanumeric chars
            if len(name) == 8 and name.isalnum() and name.isupper():
                # Check if it contains SOL files or roboevony data
                sol_files = list(item.rglob("*.sol"))
                if sol_files:
                    candidates.append((item, len(sol_files)))
    
    if candidates:
        # Return the one with most SOL files
        candidates.sort(key=lambda x: x[1], reverse=True)
        return candidates[0][0].name
    
    # If no candidates with SOL files, return first matching folder
    for item in base_path.iterdir():
        if item.is_dir() and len(item.name) == 8:
            return item.name
    
    return None


# ============================================================================
# PORTABLE CONFIGURATION
# ============================================================================

@dataclass
class PortableConfig:
    """Configuration that persists and auto-heals when project is moved"""
    # Paths (stored as relative when possible)
    project_root: str = ""
    sol_data_dir: str = "SOL_Data"
    backup_dir: str = "SOL_Backups"
    logs_dir: str = "logs"
    botfile_dir: str = "Botfile"
    
    # System paths (detected dynamically)
    system_macromedia_path: str = ""
    system_random_folder: str = ""
    
    # Sync settings
    auto_sync_enabled: bool = True
    sync_interval_seconds: int = 30
    sync_on_launch: bool = True
    
    # Last known state
    last_sync_time: str = ""
    last_project_path: str = ""
    
    # Node settings
    total_nodes: int = 50
    max_accounts_per_node: int = 10
    tor_port_base: int = 9999
    
    def to_dict(self) -> Dict[str, Any]:
        return asdict(self)
    
    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> 'PortableConfig':
        return cls(**{k: v for k, v in data.items() if k in cls.__dataclass_fields__})


class ConfigManager:
    """
    Manages portable configuration with auto-heal capability.
    
    Features:
    - Detects project root dynamically
    - Finds system Macromedia folder and random subfolder
    - Saves/loads config that survives project moves
    - Triggers re-detection when project location changes
    """
    
    CONFIG_FILENAME = "etk_config.json"
    
    def __init__(self):
        self.logger = None
        self.config = PortableConfig()
        self.project_root = get_project_root()
        self._initialize()
    
    def _initialize(self):
        """Initialize configuration and logging"""
        # Setup logging first
        log_dir = self.project_root / "logs"
        self.logger = setup_logging(log_dir)
        self.logger.info("=" * 60)
        self.logger.info("ETK SOL Manager - Portable Config Initializing")
        self.logger.info(f"Project Root: {self.project_root}")
        
        # Load or create config
        config_file = self.project_root / self.CONFIG_FILENAME
        
        if config_file.exists():
            self._load_config(config_file)
            self._check_for_project_move()
        else:
            self._create_new_config()
        
        # Detect system paths
        self._detect_system_paths()
        
        # Save updated config
        self._save_config()
        
        self.logger.info("Configuration initialized successfully")
    
    def _load_config(self, config_file: Path):
        """Load existing configuration"""
        try:
            with open(config_file, 'r', encoding='utf-8') as f:
                data = json.load(f)
            self.config = PortableConfig.from_dict(data)
            self.logger.info(f"Loaded config from {config_file}")
        except Exception as e:
            self.logger.error(f"Failed to load config: {e}")
            self._create_new_config()
    
    def _create_new_config(self):
        """Create new default configuration"""
        self.config = PortableConfig()
        self.config.project_root = str(self.project_root)
        self.config.last_project_path = str(self.project_root)
        self.logger.info("Created new default configuration")
    
    def _check_for_project_move(self):
        """Check if project was moved and heal if needed"""
        current_path = str(self.project_root)
        last_path = self.config.last_project_path
        
        if last_path and last_path != current_path:
            self.logger.warning(f"Project moved detected!")
            self.logger.warning(f"  Previous: {last_path}")
            self.logger.warning(f"  Current:  {current_path}")
            self._heal_after_move(last_path, current_path)
    
    def _heal_after_move(self, old_path: str, new_path: str):
        """Auto-heal configuration after project move"""
        self.logger.info("Auto-healing configuration after project move...")
        
        # Update project root
        self.config.project_root = new_path
        self.config.last_project_path = new_path
        
        # Re-detect system paths (they don't change on move)
        self._detect_system_paths()
        
        # Verify SOL data exists in new location
        sol_data = self.get_sol_data_path()
        if sol_data.exists():
            self.logger.info(f"SOL data found at new location: {sol_data}")
        else:
            self.logger.warning(f"SOL data not found at: {sol_data}")
            self.logger.info("Will sync from system Macromedia folder...")
        
        self.logger.info("Auto-heal complete")
    
    def _detect_system_paths(self):
        """Detect system Macromedia paths"""
        self.logger.info("Detecting system Macromedia paths...")
        
        # Find system SharedObjects folder
        system_path = get_system_macromedia_path()
        if system_path:
            self.config.system_macromedia_path = str(system_path)
            self.logger.info(f"System Macromedia: {system_path}")
            
            # Find random subfolder
            random_folder = detect_random_subfolder(system_path)
            if random_folder:
                self.config.system_random_folder = random_folder
                self.logger.info(f"Random subfolder detected: {random_folder}")
                
                # Log SOL files found
                full_path = system_path / random_folder
                sol_files = list(full_path.rglob("*.sol"))
                self.logger.info(f"Found {len(sol_files)} SOL files in system folder")
            else:
                self.logger.warning("No random subfolder detected (RoboEvony may not have run yet)")
        else:
            self.logger.warning("System Macromedia folder not found")
    
    def _save_config(self):
        """Save configuration to file"""
        config_file = self.project_root / self.CONFIG_FILENAME
        try:
            with open(config_file, 'w', encoding='utf-8') as f:
                json.dump(self.config.to_dict(), f, indent=2)
            self.logger.debug(f"Config saved to {config_file}")
        except Exception as e:
            self.logger.error(f"Failed to save config: {e}")
    
    # Path getters
    def get_sol_data_path(self) -> Path:
        return self.project_root / self.config.sol_data_dir
    
    def get_backup_path(self) -> Path:
        return self.project_root / self.config.backup_dir
    
    def get_logs_path(self) -> Path:
        return self.project_root / self.config.logs_dir
    
    def get_botfile_path(self) -> Path:
        return self.project_root / self.config.botfile_dir
    
    def get_system_sol_path(self) -> Optional[Path]:
        """Get the full system SOL path including random folder"""
        if self.config.system_macromedia_path and self.config.system_random_folder:
            return Path(self.config.system_macromedia_path) / self.config.system_random_folder
        return None
    
    def refresh_system_detection(self):
        """Re-detect system paths (useful after RoboEvony creates folders)"""
        self._detect_system_paths()
        self._save_config()


# ============================================================================
# SOL FILE SYNC SYSTEM
# ============================================================================

@dataclass
class SOLFileInfo:
    """Information about a SOL file"""
    path: Path
    name: str
    size: int
    modified: float
    hash: str
    
    @classmethod
    def from_path(cls, path: Path) -> 'SOLFileInfo':
        stat = path.stat()
        with open(path, 'rb') as f:
            file_hash = hashlib.md5(f.read()).hexdigest()
        return cls(
            path=path,
            name=path.name,
            size=stat.st_size,
            modified=stat.st_mtime,
            hash=file_hash
        )


class SOLSyncManager:
    """
    Manages syncing SOL files between system and project.
    
    Features:
    - Monitors system Macromedia folder for changes
    - Copies changed SOL files to project
    - Preserves folder structure (account folders)
    - Tracks sync history
    """
    
    def __init__(self, config_manager: ConfigManager):
        self.config = config_manager
        self.logger = config_manager.logger
        self._sync_thread = None
        self._stop_event = threading.Event()
        self._last_file_states: Dict[str, SOLFileInfo] = {}
    
    def sync_from_system(self, force: bool = False) -> Dict[str, Any]:
        """
        Sync SOL files from system Macromedia folder to project.
        
        Returns dict with sync results.
        """
        self.logger.info("=" * 40)
        self.logger.info("Starting SOL sync from system...")
        
        results = {
            "success": True,
            "copied": 0,
            "updated": 0,
            "skipped": 0,
            "errors": [],
            "files": []
        }
        
        system_path = self.config.get_system_sol_path()
        if not system_path or not system_path.exists():
            self.logger.error("System SOL path not found or doesn't exist")
            self.logger.error(f"Expected: {system_path}")
            results["success"] = False
            results["errors"].append("System SOL path not found")
            return results
        
        project_sol = self.config.get_sol_data_path()
        project_sol.mkdir(parents=True, exist_ok=True)
        
        self.logger.info(f"Source: {system_path}")
        self.logger.info(f"Destination: {project_sol}")
        
        # Find all SOL files
        sol_files = list(system_path.rglob("*.sol"))
        self.logger.info(f"Found {len(sol_files)} SOL files in system folder")
        
        for sol_file in sol_files:
            try:
                # Calculate relative path to preserve structure
                rel_path = sol_file.relative_to(system_path)
                dest_path = project_sol / rel_path
                
                # Create parent directory
                dest_path.parent.mkdir(parents=True, exist_ok=True)
                
                # Check if file needs copying
                should_copy = force
                if not should_copy:
                    if not dest_path.exists():
                        should_copy = True
                        self.logger.debug(f"New file: {rel_path}")
                    else:
                        # Compare modification times and sizes
                        src_stat = sol_file.stat()
                        dst_stat = dest_path.stat()
                        if src_stat.st_mtime > dst_stat.st_mtime or src_stat.st_size != dst_stat.st_size:
                            should_copy = True
                            self.logger.debug(f"Updated file: {rel_path}")
                
                if should_copy:
                    shutil.copy2(sol_file, dest_path)
                    if dest_path.exists():
                        results["copied" if not dest_path.exists() else "updated"] += 1
                    else:
                        results["copied"] += 1
                    results["files"].append(str(rel_path))
                    self.logger.info(f"Synced: {rel_path}")
                else:
                    results["skipped"] += 1
                    
            except Exception as e:
                self.logger.error(f"Error syncing {sol_file}: {e}")
                results["errors"].append(f"{sol_file}: {e}")
        
        # Update sync time
        self.config.config.last_sync_time = datetime.now().isoformat()
        self.config._save_config()
        
        self.logger.info(f"Sync complete: {results['copied']} copied, {results['updated']} updated, {results['skipped']} skipped")
        return results
    
    def get_changed_files(self) -> List[Path]:
        """Get list of SOL files that have changed since last check"""
        changed = []
        system_path = self.config.get_system_sol_path()
        
        if not system_path or not system_path.exists():
            return changed
        
        for sol_file in system_path.rglob("*.sol"):
            try:
                current_info = SOLFileInfo.from_path(sol_file)
                key = str(sol_file)
                
                if key not in self._last_file_states:
                    changed.append(sol_file)
                    self._last_file_states[key] = current_info
                elif self._last_file_states[key].hash != current_info.hash:
                    changed.append(sol_file)
                    self._last_file_states[key] = current_info
                    
            except Exception as e:
                self.logger.error(f"Error checking file {sol_file}: {e}")
        
        return changed
    
    def start_auto_sync(self):
        """Start background auto-sync thread"""
        if self._sync_thread and self._sync_thread.is_alive():
            return
        
        self._stop_event.clear()
        self._sync_thread = threading.Thread(target=self._sync_loop, daemon=True)
        self._sync_thread.start()
        self.logger.info("Auto-sync started")
    
    def stop_auto_sync(self):
        """Stop background auto-sync"""
        self._stop_event.set()
        if self._sync_thread:
            self._sync_thread.join(timeout=5)
        self.logger.info("Auto-sync stopped")
    
    def _sync_loop(self):
        """Background sync loop"""
        interval = self.config.config.sync_interval_seconds
        while not self._stop_event.is_set():
            try:
                changed = self.get_changed_files()
                if changed:
                    self.logger.info(f"Detected {len(changed)} changed files, syncing...")
                    self.sync_from_system()
            except Exception as e:
                self.logger.error(f"Auto-sync error: {e}")
            
            self._stop_event.wait(interval)


# ============================================================================
# SINGLETON INSTANCES
# ============================================================================

_config_manager: Optional[ConfigManager] = None
_sync_manager: Optional[SOLSyncManager] = None


def get_config_manager() -> ConfigManager:
    """Get singleton config manager"""
    global _config_manager
    if _config_manager is None:
        _config_manager = ConfigManager()
    return _config_manager


def get_sync_manager() -> SOLSyncManager:
    """Get singleton sync manager"""
    global _sync_manager
    if _sync_manager is None:
        _sync_manager = SOLSyncManager(get_config_manager())
    return _sync_manager


# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

def get_project_root_path() -> Path:
    """Get the auto-detected project root"""
    return get_config_manager().project_root


def get_logger() -> logging.Logger:
    """Get the configured logger"""
    return get_config_manager().logger


def sync_sol_files(force: bool = False) -> Dict[str, Any]:
    """Convenience function to sync SOL files"""
    return get_sync_manager().sync_from_system(force)


def start_auto_sync():
    """Start auto-sync"""
    get_sync_manager().start_auto_sync()


def stop_auto_sync():
    """Stop auto-sync"""
    get_sync_manager().stop_auto_sync()
