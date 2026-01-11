"""
ETK SOL Manager - Bot Launcher Module
Manages launching RoboEvony bots through Tor proxy nodes with proper SOL deployment

Architecture:
- Proxifier routes traffic based on EXE filename pattern
- ae*N1.exe → Port 9999 (Node 0)
- ae*N2.exe → Port 9998 (Node 1)
- etc.

This module:
1. Uses roboevony.exe from D:\\EvonyToolKit\\Botfile\\roboevony.exe (embedded SWF + Flash Player 11)
2. Deploys config.sol with login, password, server, SOCKS4 proxy per account
3. Launches bots with proper working directory and SOL data
4. Implements Windows taskbar grouping using AppUserModelID per node
5. Enforces 10 accounts per node limit

Note: roboevony.exe contains embedded SWF and uses Flash Player 11 (2011 version)
      AE.EXE is just the Flash Player 19 projector without the SWF
"""

import os
import sys
import shutil
import subprocess
import time
import ctypes
from pathlib import Path
from typing import Dict, List, Any, Optional, Tuple
from dataclasses import dataclass, field

from .config import ETK_ROOT, TOTAL_TOR_NODES, TOR_PORT_BASE
from .utils import node_to_port, port_to_node, safe_email_to_filename


# ============================================================================
# WINDOWS TASKBAR GROUPING (AppUserModelID)
# ============================================================================

def set_app_user_model_id(app_id: str) -> bool:
    """
    Set the AppUserModelID for the current process.
    This groups windows in the taskbar under the same icon.
    """
    try:
        ctypes.windll.shell32.SetCurrentProcessExplicitAppUserModelID(app_id)
        return True
    except Exception:
        return False


def get_node_app_id(node: int) -> str:
    """Get AppUserModelID for a specific node (groups all bots on that node)"""
    return f"EvonyToolKit.SOLManager.Node{node}"


# ============================================================================
# CONFIGURATION
# ============================================================================

BOTFILE_PATH = ETK_ROOT / "Botfile"
BOT_EXE_NAME = "roboevony.exe"  # Uses embedded SWF + Flash Player 11
BOTS_PATH = ETK_ROOT / "bots"
TOR_PATH = ETK_ROOT / "Tor"
PROXIFIER_PROFILE = ETK_ROOT / "Proxy" / "Profiles" / "Default.ppx"

# Macromedia SharedObjects path for account SOL files
MACROMEDIA_BASE = ETK_ROOT / "Macromedia" / "Flash Player" / "#SharedObjects"
SYSTEM_MACROMEDIA = Path(os.environ.get('APPDATA', '')) / "Macromedia" / "Flash Player" / "#SharedObjects"

# Max accounts per node
MAX_ACCOUNTS_PER_NODE = 10


@dataclass
class BotInstance:
    """Represents a running bot instance"""
    email: str
    node: int
    port: int
    exe_path: str
    sol_folder: str = ""
    process: Optional[subprocess.Popen] = None
    started_at: Optional[float] = None
    server: str = ""
    app_id: str = ""
    
    @property
    def is_running(self) -> bool:
        if self.process is None:
            return False
        return self.process.poll() is None
    
    @property
    def exe_name(self) -> str:
        return f"roboevony_N{self.node + 1}.exe"


@dataclass
class AccountSOLData:
    """SOL configuration data for an account"""
    email: str
    password: str
    server: str = "cc2"
    server_ip: str = ""
    proxy_host: str = "127.0.0.1"
    proxy_port: int = 9999
    proxy_type: str = "ss4"  # SOCKS4
    auto_login: bool = True
    node: int = 0
    sol_folder: str = ""


class BotLauncher:
    """
    Manages launching RoboEvony bots through Tor proxy nodes
    
    Key features:
    - Uses AE.EXE from D:\\EvonyToolKit\\Botfile\\AE.EXE
    - Deploys config.sol with login, password, server, SOCKS4 proxy
    - Supports launching single nodes or selected nodes
    - Implements Windows taskbar grouping using AppUserModelID
    - Enforces 10-account-per-node limit
    """
    
    def __init__(self):
        self.bot_exe = BOTFILE_PATH / BOT_EXE_NAME
        self.bots_path = BOTS_PATH
        self.running_bots: Dict[str, BotInstance] = {}
        self.max_per_node = MAX_ACCOUNTS_PER_NODE
        self.node_assignments: Dict[int, List[str]] = {n: [] for n in range(TOTAL_TOR_NODES)}
        
        # Ensure directories exist
        self.bots_path.mkdir(parents=True, exist_ok=True)
    
    @property
    def bot_available(self) -> bool:
        """Check if bot executable exists at Botfile/AE.EXE"""
        return self.bot_exe.exists()
    
    @property
    def bot_exe_path(self) -> str:
        """Get the full path to AE.EXE"""
        return str(self.bot_exe)
    
    def get_node_folder(self, node: int) -> Path:
        """Get/create node-specific bot folder"""
        folder = self.bots_path / f"Node{node}"
        folder.mkdir(parents=True, exist_ok=True)
        return folder
    
    def get_account_folder(self, node: int, email: str) -> Path:
        """Get/create account-specific folder within a node"""
        safe_name = safe_email_to_filename(email)
        folder = self.get_node_folder(node) / safe_name
        folder.mkdir(parents=True, exist_ok=True)
        return folder
    
    def get_bot_exe_name(self, node: int) -> str:
        """
        Get bot executable name for a node.
        Proxifier matches: ae*N1.exe for Node 0, ae*N2.exe for Node 1, etc.
        """
        return f"AE_N{node + 1}.exe"
    
    def prepare_node_exe(self, node: int) -> Tuple[Path, bool]:
        """
        Copy AE.EXE from Botfile folder to node folder with proper naming
        """
        if not self.bot_available:
            return Path(), False
        
        node_folder = self.get_node_folder(node)
        exe_name = self.get_bot_exe_name(node)
        exe_path = node_folder / exe_name
        
        try:
            # Copy bot if not exists or outdated
            if not exe_path.exists():
                shutil.copy2(self.bot_exe, exe_path)
            elif self.bot_exe.stat().st_mtime > exe_path.stat().st_mtime:
                shutil.copy2(self.bot_exe, exe_path)
            
            return exe_path, True
        except Exception as e:
            print(f"Error preparing node {node}: {e}")
            return Path(), False
    
    def deploy_sol_for_account(self, account: AccountSOLData, exe_path: Path = None) -> Tuple[Path, bool]:
        """
        Deploy config.sol with account data to SYSTEM Macromedia folder.
        
        Flash Player stores SOL files at:
        C:\\Users\\{user}\\AppData\\Roaming\\Macromedia\\Flash Player\\#SharedObjects\\{RANDOM}\\localhost\\evony\\{account_name}\\roboevony.exe\\config.sol
        
        We deploy to the detected system random folder (e.g., YUGK6X86).
        """
        try:
            import pyamf.sol
        except ImportError:
            print("PyAMF not available - cannot deploy SOL files")
            return Path(), False
        
        try:
            from .debug_logger import get_debug_logger
            logger = get_debug_logger()
        except Exception:
            logger = None
        
        try:
            from .portable_config import get_config_manager
            config = get_config_manager()
            
            # Get system Macromedia path with random folder
            system_sol_path = config.get_system_sol_path()
            if not system_sol_path:
                if logger:
                    logger.error("System Macromedia path not detected")
                return Path(), False
            
            # Create account folder name from email
            account_name = safe_email_to_filename(account.email)
            
            # Build path: {system_sol}/localhost/evony/{account_name}/roboevony.exe/
            sol_folder = system_sol_path / "localhost" / "evony" / account_name / "roboevony.exe"
            sol_folder.mkdir(parents=True, exist_ok=True)
            
            if logger:
                logger.info(f"Deploying SOL to SYSTEM path: {sol_folder}")
            
            # Create the config.sol data structure
            sol_data = {
                "now": {
                    "username": account.email,
                    "password": account.password,
                    "server": account.server,
                    "serverIP": account.server_ip,
                    "proxyHost": account.proxy_host,
                    "proxyPort": str(account.proxy_port),
                    "proxyType": account.proxy_type,  # ss4 = SOCKS4
                    "autoLogin": account.auto_login,
                    "loginType": "ev"
                }
            }
            
            # Write config.sol
            sol_path = sol_folder / "config.sol"
            sol_stream = pyamf.sol.encode("config", sol_data)
            with open(sol_path, 'wb') as f:
                f.write(sol_stream.getvalue())
            
            if logger:
                logger.info(f"Deployed config.sol for {account.email}")
                logger.debug(f"  Path: {sol_path}")
                logger.debug(f"  Username: {account.email}")
                logger.debug(f"  Server: {account.server}")
                logger.debug(f"  Proxy: {account.proxy_host}:{account.proxy_port}")
            
            # Return the system sol folder as account folder
            return sol_folder.parent, True
            
        except Exception as e:
            if logger:
                logger.error(f"Error deploying SOL for {account.email}: {e}")
            print(f"Error deploying SOL for {account.email}: {e}")
            return Path(), False
    
    def prepare_all_nodes(self) -> Dict[int, bool]:
        """Prepare all 50 nodes with bot executables"""
        results = {}
        for node in range(TOTAL_TOR_NODES):
            _, success = self.prepare_node_exe(node)
            results[node] = success
        return results
    
    def get_accounts_on_node(self, node: int) -> List[str]:
        """Get list of account emails running on a node"""
        return [
            email for email, bot in self.running_bots.items()
            if bot.node == node and bot.is_running
        ]
    
    def get_assigned_accounts_on_node(self, node: int) -> List[str]:
        """Get list of accounts assigned to a node (not necessarily running)"""
        return self.node_assignments.get(node, [])
    
    def assign_account_to_node(self, email: str, node: int) -> bool:
        """Assign an account to a specific node"""
        if node < 0 or node >= TOTAL_TOR_NODES:
            return False
        
        # Remove from other nodes first
        for n in self.node_assignments:
            if email in self.node_assignments[n]:
                self.node_assignments[n].remove(email)
        
        # Check capacity
        if len(self.node_assignments[node]) >= self.max_per_node:
            return False
        
        self.node_assignments[node].append(email)
        return True
    
    def can_launch_on_node(self, node: int) -> bool:
        """Check if node has capacity for another account"""
        current = len(self.get_accounts_on_node(node))
        return current < self.max_per_node
    
    def get_best_node(self) -> int:
        """Find node with lowest load"""
        loads = {n: len(self.get_accounts_on_node(n)) for n in range(TOTAL_TOR_NODES)}
        return min(loads, key=loads.get)
    
    def launch_bot(self, account: AccountSOLData, 
                   wait_seconds: float = 0.5) -> Tuple[BotInstance, str]:
        """
        Launch a single bot instance for an account
        
        Args:
            account: AccountSOLData with login, password, server, proxy settings
            wait_seconds: Delay after launch
            
        Returns:
            Tuple of (BotInstance, error_message or None)
        """
        node = account.node
        
        # Validate node
        if node < 0 or node >= TOTAL_TOR_NODES:
            return None, f"Invalid node: {node}"
        
        # Check capacity
        if not self.can_launch_on_node(node):
            return None, f"Node {node} at capacity ({self.max_per_node} accounts)"
        
        # Check if already running
        if account.email in self.running_bots and self.running_bots[account.email].is_running:
            return self.running_bots[account.email], "Already running"
        
        # Prepare node executable
        exe_path, success = self.prepare_node_exe(node)
        if not success:
            return None, f"Failed to prepare bot executable from {self.bot_exe}"
        
        # Deploy SOL file with account data (pass exe_path for correct folder structure)
        account_folder, sol_success = self.deploy_sol_for_account(account, exe_path)
        if not sol_success:
            return None, f"Failed to deploy SOL file for {account.email}"
        
        # Get AppUserModelID for taskbar grouping
        app_id = get_node_app_id(node)
        
        # Create bot instance
        port = node_to_port(node)
        instance = BotInstance(
            email=account.email,
            node=node,
            port=port,
            exe_path=str(exe_path),
            sol_folder=str(account_folder),
            server=account.server,
            app_id=app_id
        )
        
        try:
            # Import debug logger
            from .debug_logger import get_debug_logger
            logger = get_debug_logger()
            
            logger.info(f"Launching bot for {account.email} on Node {node}")
            logger.debug(f"  Executable: {exe_path}")
            logger.debug(f"  Account folder: {account_folder}")
            logger.debug(f"  Proxy port: {port}")
            
            # Verify executable exists
            if not exe_path.exists():
                error_msg = f"Executable not found: {exe_path}"
                logger.error(error_msg)
                logger.log_process_launch(str(exe_path), str(account_folder), 
                                         success=False, error_message=error_msg)
                return None, error_msg
            
            # Log executable details
            exe_size = exe_path.stat().st_size
            logger.debug(f"  Executable size: {exe_size:,} bytes")
            
            # Launch from account folder in system Macromedia path
            # SOL files are deployed to system path, no need to modify APPDATA
            logger.info(f"Starting process: {exe_path}")
            logger.info(f"SOL folder: {account_folder}")
            
            instance.process = subprocess.Popen(
                [str(exe_path)],
                cwd=str(account_folder),  # Run from account's SOL folder
                creationflags=subprocess.CREATE_NEW_CONSOLE | subprocess.CREATE_NEW_PROCESS_GROUP
            )
            instance.started_at = time.time()
            
            # Log success
            pid = instance.process.pid
            logger.info(f"Process started with PID: {pid}")
            logger.log_process_launch(
                str(exe_path), str(account_folder),
                success=True, pid=pid
            )
            
            # Track it
            self.running_bots[account.email] = instance
            
            # Small delay between launches
            if wait_seconds > 0:
                time.sleep(wait_seconds)
            
            return instance, None
            
        except FileNotFoundError as e:
            error_msg = f"Executable not found: {e}"
            self._log_launch_error(exe_path, account_folder, error_msg)
            return None, error_msg
        except PermissionError as e:
            error_msg = f"Permission denied: {e}"
            self._log_launch_error(exe_path, account_folder, error_msg)
            return None, error_msg
        except OSError as e:
            error_msg = f"OS error launching process: {e}"
            self._log_launch_error(exe_path, account_folder, error_msg)
            return None, error_msg
        except Exception as e:
            error_msg = f"Launch failed: {type(e).__name__}: {e}"
            self._log_launch_error(exe_path, account_folder, error_msg)
            return None, error_msg
    
    def _log_launch_error(self, exe_path: Path, account_folder: Path, error_msg: str):
        """Log launch error with full details"""
        try:
            from .debug_logger import get_debug_logger
            logger = get_debug_logger()
            logger.error(f"LAUNCH FAILED: {error_msg}")
            logger.log_process_launch(str(exe_path), str(account_folder),
                                     success=False, error_message=error_msg)
        except Exception:
            print(f"LAUNCH ERROR: {error_msg}")
    
    def stop_bot(self, email: str) -> bool:
        """Stop a running bot instance"""
        if email not in self.running_bots:
            return False
        
        instance = self.running_bots[email]
        if instance.process and instance.is_running:
            try:
                instance.process.terminate()
                instance.process.wait(timeout=5)
            except subprocess.TimeoutExpired:
                instance.process.kill()
            except Exception:
                pass
        
        del self.running_bots[email]
        return True
    
    def stop_all_bots(self) -> int:
        """Stop all running bots"""
        count = 0
        for email in list(self.running_bots.keys()):
            if self.stop_bot(email):
                count += 1
        return count
    
    def stop_node(self, node: int) -> int:
        """Stop all bots on a specific node"""
        count = 0
        for email in list(self.running_bots.keys()):
            if self.running_bots[email].node == node:
                if self.stop_bot(email):
                    count += 1
        return count
    
    def launch_node(self, node: int, accounts: List[AccountSOLData], 
                    delay: float = 1.0) -> Dict[str, Tuple[bool, str]]:
        """
        Launch all accounts assigned to a single node
        
        Args:
            node: Node number (0-49)
            accounts: List of AccountSOLData for accounts on this node
            delay: Seconds between launches
            
        Returns:
            Dict of {email: (success, message)}
        """
        results = {}
        
        if node < 0 or node >= TOTAL_TOR_NODES:
            return {"error": (False, f"Invalid node: {node}")}
        
        # Filter accounts for this node
        node_accounts = [acc for acc in accounts if acc.node == node]
        
        if len(node_accounts) > self.max_per_node:
            return {"error": (False, f"Too many accounts for node {node} (max {self.max_per_node})")}
        
        for account in node_accounts:
            instance, error = self.launch_bot(account, delay)
            if error and instance is None:
                results[account.email] = (False, error)
            else:
                results[account.email] = (True, f"Launched on Node {node}")
        
        return results
    
    def launch_selected_nodes(self, nodes: List[int], accounts: List[AccountSOLData],
                              delay: float = 1.0) -> Dict[str, Tuple[bool, str]]:
        """
        Launch accounts on selected nodes only
        
        Args:
            nodes: List of node numbers to launch
            accounts: List of all AccountSOLData
            delay: Seconds between launches
            
        Returns:
            Dict of {email: (success, message)}
        """
        results = {}
        
        for node in nodes:
            node_results = self.launch_node(node, accounts, delay)
            results.update(node_results)
        
        return results
    
    def launch_batch(self, accounts: List[AccountSOLData], 
                     delay: float = 1.0) -> Dict[str, Tuple[bool, str]]:
        """
        Launch multiple accounts across their assigned nodes
        
        Args:
            accounts: List of AccountSOLData with node assignments
            delay: Seconds between launches
            
        Returns:
            Dict of {email: (success, message)}
        """
        results = {}
        
        for account in accounts:
            instance, error = self.launch_bot(account, delay)
            if error and instance is None:
                results[account.email] = (False, error)
            else:
                results[account.email] = (True, f"Launched on Node {account.node}")
        
        return results
    
    def get_stats(self) -> Dict[str, Any]:
        """Get launcher statistics"""
        running = {n: 0 for n in range(TOTAL_TOR_NODES)}
        for bot in self.running_bots.values():
            if bot.is_running:
                running[bot.node] = running.get(bot.node, 0) + 1
        
        total_running = sum(running.values())
        used_nodes = sum(1 for c in running.values() if c > 0)
        
        return {
            "total_nodes": TOTAL_TOR_NODES,
            "used_nodes": used_nodes,
            "total_running": total_running,
            "max_per_node": self.max_per_node,
            "capacity": TOTAL_TOR_NODES * self.max_per_node,
            "available": TOTAL_TOR_NODES * self.max_per_node - total_running,
            "node_loads": running,
            "bot_available": self.bot_available
        }
    
    def cleanup_stopped(self) -> int:
        """Remove stopped bots from tracking"""
        stopped = [
            email for email, bot in self.running_bots.items()
            if not bot.is_running
        ]
        for email in stopped:
            del self.running_bots[email]
        return len(stopped)


class TorManager:
    """Manages Tor node processes"""
    
    def __init__(self):
        self.tor_path = TOR_PATH
        self.tor_exe = self.tor_path / "tor.exe"
        self.data_path = ETK_ROOT / "TorData"
        self.running_nodes: Dict[int, subprocess.Popen] = {}
    
    @property
    def tor_available(self) -> bool:
        return self.tor_exe.exists()
    
    def get_node_data_dir(self, node: int) -> Path:
        """Get data directory for a Tor node"""
        path = self.data_path / f"node{node}"
        path.mkdir(parents=True, exist_ok=True)
        return path
    
    def create_torrc(self, node: int) -> Path:
        """Create torrc config for a specific node"""
        port = node_to_port(node)
        data_dir = self.get_node_data_dir(node)
        torrc_path = data_dir / "torrc"
        
        config = f"""
# Tor Node {node} Configuration
SocksPort {port}
DataDirectory {data_dir}
GeoIPFile {self.tor_path / 'geoip'}
GeoIPv6File {self.tor_path / 'geoip6'}
Log notice file {data_dir / 'tor.log'}
AvoidDiskWrites 1
"""
        
        with open(torrc_path, 'w') as f:
            f.write(config)
        
        return torrc_path
    
    def start_node(self, node: int) -> Tuple[bool, str]:
        """Start a single Tor node"""
        if not self.tor_available:
            return False, "Tor executable not found"
        
        if node in self.running_nodes:
            if self.running_nodes[node].poll() is None:
                return True, "Already running"
        
        torrc = self.create_torrc(node)
        
        try:
            process = subprocess.Popen(
                [str(self.tor_exe), "-f", str(torrc)],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
                creationflags=subprocess.CREATE_NO_WINDOW
            )
            self.running_nodes[node] = process
            return True, f"Started on port {node_to_port(node)}"
        except Exception as e:
            return False, str(e)
    
    def stop_node(self, node: int) -> bool:
        """Stop a Tor node"""
        if node not in self.running_nodes:
            return False
        
        process = self.running_nodes[node]
        try:
            process.terminate()
            process.wait(timeout=5)
        except subprocess.TimeoutExpired:
            process.kill()
        except Exception:
            pass
        
        del self.running_nodes[node]
        return True
    
    def start_all_nodes(self, delay: float = 0.2) -> Dict[int, bool]:
        """Start all 50 Tor nodes"""
        results = {}
        for node in range(TOTAL_TOR_NODES):
            success, _ = self.start_node(node)
            results[node] = success
            if delay > 0:
                time.sleep(delay)
        return results
    
    def stop_all_nodes(self) -> int:
        """Stop all running Tor nodes"""
        count = 0
        for node in list(self.running_nodes.keys()):
            if self.stop_node(node):
                count += 1
        return count
    
    def get_running_count(self) -> int:
        """Get number of running Tor nodes"""
        return sum(1 for p in self.running_nodes.values() if p.poll() is None)


# Singleton instances
_bot_launcher: Optional[BotLauncher] = None
_tor_manager: Optional[TorManager] = None


def get_bot_launcher() -> BotLauncher:
    """Get singleton bot launcher"""
    global _bot_launcher
    if _bot_launcher is None:
        _bot_launcher = BotLauncher()
    return _bot_launcher


def get_tor_manager() -> TorManager:
    """Get singleton Tor manager"""
    global _tor_manager
    if _tor_manager is None:
        _tor_manager = TorManager()
    return _tor_manager
