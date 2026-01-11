#!/usr/bin/env python3
"""
ETK SOL Manager - Comprehensive GUI Tool
Manages SOL files for 470+ Evony Age II accounts

Features:
- View/Edit/Save SOL files with plain English descriptions
- Backup system with timeline, rollback, failsafes
- Share/merge configs across accounts
- Node management for Tor routing
- Detailed documentation for each SOL type
"""
import os
import sys
import json
import shutil
import hashlib
import tkinter as tk
from tkinter import ttk, messagebox, filedialog, scrolledtext
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Any, Optional
import threading
import copy

try:
    import pyamf.sol as sol
    HAS_AMF = True
except ImportError:
    HAS_AMF = False

# ============================================================================
# CONFIGURATION
# ============================================================================
ETK_ROOT = Path(r"D:\EvonyToolKit")
MACROMEDIA_PATH = ETK_ROOT / "Macromedia" / "Flash Player" / "#SharedObjects"
BACKUP_PATH = ETK_ROOT / "sol_backups_managed"
CONFIG_FILE = ETK_ROOT / "tools" / "sol_manager_config.json"

# SOL File Type Documentation
SOL_TYPES = {
    "config.sol": {
        "description": "Account Login & Settings",
        "location": "RoboEvony > Settings",
        "fields": {
            "username": "Email address for Evony login",
            "password": "Account password",
            "server": "Server code (e.g., cc2)",
            "serverIP": "Server IP address",
            "strserverAlias": "Server display name (e.g., Parapet)",
            "sid": "Server ID number",
            "proxyHost": "Proxy server address (127.0.0.1 for Tor)",
            "proxyPort": "Tor node port (9949-9999)",
            "proxyType": "Proxy type (ss5 = SOCKS5)",
            "autoLogin": "Auto-login on start",
            "autoRun": "Auto-run scripts on login",
            "autoScript": "Auto-execute scripts",
            "theme": "RoboEvony theme name",
            "loginType": "Login method (ev = Evony direct)",
        }
    },
    "goals.sol": {
        "description": "Automation Goals & Scripts",
        "location": "RoboEvony > Goals Window",
        "fields": {
            "now": "Current active goal script",
            "goals": "List of saved goal scripts",
            "scripts": "Script text content",
            "sindex": "Selected script index",
        }
    },
    "newArmyTroopCfgs.sol": {
        "description": "Troop Army Configurations",
        "location": "RoboEvony > Army Presets",
        "fields": {
            "troopCfg": "Troop composition string (a=archers, w=warriors, etc.)",
            "label": "Preset name (wave1, bighitter, etc.)",
        }
    },
    "citydata.sol": {
        "description": "City Management Data",
        "location": "RoboEvony > City View",
        "fields": {
            "cities": "City configurations",
            "index": "Selected city index",
            "goals": "City-specific goals",
        }
    },
    "settings.sol": {
        "description": "Application Settings",
        "location": "Flash Player Settings",
        "fields": {
            "bandwidth": "Bandwidth settings",
            "defaultcamera": "Camera permissions",
            "defaultmicrophone": "Microphone permissions",
        }
    }
}

# Troop type codes
TROOP_CODES = {
    "wo": "Workers", "w": "Warriors", "s": "Scouts", "p": "Pikemen",
    "sw": "Swordsmen", "a": "Archers", "c": "Cavalry", "cata": "Cataphracts",
    "t": "Transporters", "r": "Ram", "b": "Ballista", "cp": "Catapult"
}


# ============================================================================
# BACKUP MANAGER
# ============================================================================
class BackupManager:
    """Handles backup, rollback, and timeline features"""
    
    def __init__(self, backup_root: Path = BACKUP_PATH):
        self.backup_root = backup_root
        self.backup_root.mkdir(parents=True, exist_ok=True)
        self.max_backups = 10  # Keep 10 backups per account
        
    def create_backup(self, account_email: str, sol_files: Dict[str, Any], 
                      reason: str = "manual") -> str:
        """Create a backup before making changes - ALWAYS called before edits"""
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        safe_email = account_email.replace("@", "_at_").replace(".", "_")
        
        backup_dir = self.backup_root / safe_email / timestamp
        backup_dir.mkdir(parents=True, exist_ok=True)
        
        # Save all SOL data
        for filename, data in sol_files.items():
            backup_file = backup_dir / f"{filename}.json"
            with open(backup_file, 'w', encoding='utf-8') as f:
                json.dump(data, f, indent=2, default=str)
        
        # Save metadata
        metadata = {
            "timestamp": timestamp,
            "account": account_email,
            "reason": reason,
            "files": list(sol_files.keys()),
            "created": datetime.now().isoformat()
        }
        with open(backup_dir / "metadata.json", 'w') as f:
            json.dump(metadata, f, indent=2)
        
        # Cleanup old backups
        self._cleanup_old_backups(safe_email)
        
        return str(backup_dir)
    
    def get_timeline(self, account_email: str) -> List[Dict]:
        """Get backup timeline for an account"""
        safe_email = account_email.replace("@", "_at_").replace(".", "_")
        account_dir = self.backup_root / safe_email
        
        if not account_dir.exists():
            return []
        
        timeline = []
        for backup_dir in sorted(account_dir.iterdir(), reverse=True):
            if backup_dir.is_dir():
                metadata_file = backup_dir / "metadata.json"
                if metadata_file.exists():
                    with open(metadata_file, 'r') as f:
                        metadata = json.load(f)
                    metadata["path"] = str(backup_dir)
                    timeline.append(metadata)
        
        return timeline
    
    def restore_backup(self, backup_path: str) -> Dict[str, Any]:
        """Restore SOL data from a backup"""
        backup_dir = Path(backup_path)
        restored_data = {}
        
        for json_file in backup_dir.glob("*.json"):
            if json_file.name != "metadata.json":
                with open(json_file, 'r') as f:
                    restored_data[json_file.stem] = json.load(f)
        
        return restored_data
    
    def _cleanup_old_backups(self, safe_email: str):
        """Keep only max_backups most recent backups"""
        account_dir = self.backup_root / safe_email
        if not account_dir.exists():
            return
        
        backups = sorted(account_dir.iterdir(), reverse=True)
        for old_backup in backups[self.max_backups:]:
            if old_backup.is_dir():
                shutil.rmtree(old_backup)


# ============================================================================
# SOL FILE HANDLER
# ============================================================================
class SOLHandler:
    """Handles reading, writing, and manipulating SOL files"""
    
    def __init__(self):
        self.backup_manager = BackupManager()
        
    def read_sol(self, path: str) -> Optional[Dict]:
        """Read a SOL file and return its data"""
        if not HAS_AMF:
            return None
        try:
            with open(path, 'rb') as f:
                data = sol.load(f)
            return dict(data)
        except Exception as e:
            return {"_error": str(e)}
    
    def write_sol(self, path: str, data: Dict, account_email: str = None) -> bool:
        """Write data to a SOL file - ALWAYS creates backup first"""
        if not HAS_AMF:
            return False
        
        # Create backup before any write
        if account_email:
            existing_data = self.read_sol(path) if os.path.exists(path) else {}
            self.backup_manager.create_backup(
                account_email, 
                {Path(path).name: existing_data},
                reason="before_edit"
            )
        
        try:
            os.makedirs(os.path.dirname(path), exist_ok=True)
            with open(path, 'wb') as f:
                sol.save(data, f, name=Path(path).stem)
            return True
        except Exception as e:
            print(f"Error writing SOL: {e}")
            return False
    
    def merge_sol_data(self, source: Dict, target: Dict, 
                       fields_to_merge: List[str] = None) -> Dict:
        """Merge specific fields from source to target"""
        result = copy.deepcopy(target)
        
        if fields_to_merge is None:
            # Merge all fields
            for key, value in source.items():
                result[key] = copy.deepcopy(value)
        else:
            # Merge only specified fields
            for field in fields_to_merge:
                if field in source:
                    # Handle nested fields with dot notation
                    if "." in field:
                        parts = field.split(".")
                        src_val = source
                        for p in parts:
                            src_val = src_val.get(p, {})
                        
                        # Set in result
                        curr = result
                        for p in parts[:-1]:
                            if p not in curr:
                                curr[p] = {}
                            curr = curr[p]
                        curr[parts[-1]] = copy.deepcopy(src_val)
                    else:
                        result[field] = copy.deepcopy(source[field])
        
        return result


# ============================================================================
# ACCOUNT MANAGER
# ============================================================================
class AccountManager:
    """Manages multiple Evony accounts"""
    
    def __init__(self, macromedia_path: Path = MACROMEDIA_PATH):
        self.macromedia_path = macromedia_path
        self.accounts: Dict[str, Dict] = {}
        self.sol_handler = SOLHandler()
        
    def scan_accounts(self) -> int:
        """Scan for all accounts in Macromedia folder"""
        self.accounts = {}
        
        for config_sol in self.macromedia_path.rglob("config.sol"):
            data = self.sol_handler.read_sol(str(config_sol))
            if data and "now" in data:
                email = data["now"].get("username", "")
                if email:
                    self.accounts[email] = {
                        "email": email,
                        "config_path": str(config_sol),
                        "folder": str(config_sol.parent),
                        "data": data,
                        "sol_files": self._get_account_sol_files(config_sol.parent)
                    }
        
        return len(self.accounts)
    
    def _get_account_sol_files(self, folder: Path) -> Dict[str, str]:
        """Get all SOL files for an account"""
        sol_files = {}
        for sol_file in folder.glob("*.sol"):
            sol_files[sol_file.name] = str(sol_file)
        return sol_files
    
    def get_account(self, email: str) -> Optional[Dict]:
        """Get account data by email"""
        return self.accounts.get(email)
    
    def get_all_accounts(self) -> List[str]:
        """Get list of all account emails"""
        return list(self.accounts.keys())


# ============================================================================
# NODE MANAGER
# ============================================================================
class NodeManager:
    """Manages Tor node assignments for accounts"""
    
    def __init__(self, total_nodes: int = 50):
        self.total_nodes = total_nodes
        self.port_base = 9999  # Port = 9999 - node_number
        self.node_assignments: Dict[int, List[str]] = {i: [] for i in range(total_nodes)}
        
    def assign_account(self, email: str, node: int = None) -> int:
        """Assign an account to a node"""
        if node is None:
            # Find node with fewest accounts
            node = min(range(self.total_nodes), 
                      key=lambda n: len(self.node_assignments[n]))
        
        if node < 0 or node >= self.total_nodes:
            node = 0
        
        # Remove from any existing assignment
        for n in range(self.total_nodes):
            if email in self.node_assignments[n]:
                self.node_assignments[n].remove(email)
        
        self.node_assignments[node].append(email)
        return node
    
    def get_port(self, node: int) -> int:
        """Get port number for a node"""
        return self.port_base - node
    
    def get_node_stats(self) -> Dict:
        """Get statistics about node usage"""
        return {
            "total_nodes": self.total_nodes,
            "used_nodes": sum(1 for n in self.node_assignments.values() if n),
            "accounts_per_node": {n: len(accs) for n, accs in self.node_assignments.items() if accs}
        }


# ============================================================================
# MAIN GUI APPLICATION
# ============================================================================
class SOLManagerGUI:
    """Main GUI Application"""
    
    def __init__(self, root: tk.Tk):
        self.root = root
        self.root.title("ETK SOL Manager - Evony Account Management")
        self.root.geometry("1400x900")
        
        # Initialize managers
        self.account_manager = AccountManager()
        self.sol_handler = SOLHandler()
        self.backup_manager = BackupManager()
        self.node_manager = NodeManager()
        
        # Current state
        self.current_account = None
        self.current_sol_file = None
        self.current_data = None
        self.unsaved_changes = False
        
        # Build UI
        self._create_menu()
        self._create_main_layout()
        self._create_status_bar()
        
        # Load accounts
        self._load_accounts()
        
    def _create_menu(self):
        """Create menu bar"""
        menubar = tk.Menu(self.root)
        self.root.config(menu=menubar)
        
        # File menu
        file_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="File", menu=file_menu)
        file_menu.add_command(label="Refresh Accounts", command=self._load_accounts)
        file_menu.add_command(label="Export All Accounts", command=self._export_all)
        file_menu.add_separator()
        file_menu.add_command(label="Exit", command=self.root.quit)
        
        # Edit menu
        edit_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="Edit", menu=edit_menu)
        edit_menu.add_command(label="Save Changes", command=self._save_changes)
        edit_menu.add_command(label="Discard Changes", command=self._discard_changes)
        
        # Backup menu
        backup_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="Backup", menu=backup_menu)
        backup_menu.add_command(label="Create Backup", command=self._create_manual_backup)
        backup_menu.add_command(label="View Timeline", command=self._show_timeline)
        backup_menu.add_command(label="Restore Backup", command=self._restore_backup)
        
        # Tools menu
        tools_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="Tools", menu=tools_menu)
        tools_menu.add_command(label="Share Config to Accounts", command=self._share_config)
        tools_menu.add_command(label="Batch Edit Accounts", command=self._batch_edit)
        tools_menu.add_command(label="Node Manager", command=self._show_node_manager)
        
        # Help menu
        help_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="Help", menu=help_menu)
        help_menu.add_command(label="SOL File Reference", command=self._show_sol_reference)
        help_menu.add_command(label="About", command=self._show_about)
        
    def _create_main_layout(self):
        """Create main application layout"""
        # Main paned window
        main_pane = ttk.PanedWindow(self.root, orient=tk.HORIZONTAL)
        main_pane.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # Left panel - Account list
        left_frame = ttk.Frame(main_pane, width=300)
        main_pane.add(left_frame, weight=1)
        
        # Account list with search
        search_frame = ttk.Frame(left_frame)
        search_frame.pack(fill=tk.X, padx=5, pady=5)
        
        ttk.Label(search_frame, text="Search:").pack(side=tk.LEFT)
        self.search_var = tk.StringVar()
        self.search_var.trace("w", self._filter_accounts)
        search_entry = ttk.Entry(search_frame, textvariable=self.search_var)
        search_entry.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=5)
        
        # Account listbox
        list_frame = ttk.LabelFrame(left_frame, text="Accounts (0)")
        list_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        self.account_list_label = list_frame
        
        self.account_listbox = tk.Listbox(list_frame, selectmode=tk.SINGLE)
        self.account_listbox.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        self.account_listbox.bind('<<ListboxSelect>>', self._on_account_select)
        
        scrollbar = ttk.Scrollbar(list_frame, orient=tk.VERTICAL, 
                                  command=self.account_listbox.yview)
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y)
        self.account_listbox.config(yscrollcommand=scrollbar.set)
        
        # Right panel - Details
        right_frame = ttk.Frame(main_pane)
        main_pane.add(right_frame, weight=3)
        
        # Account info header
        info_frame = ttk.LabelFrame(right_frame, text="Account Details")
        info_frame.pack(fill=tk.X, padx=5, pady=5)
        
        self.info_labels = {}
        info_grid = ttk.Frame(info_frame)
        info_grid.pack(fill=tk.X, padx=10, pady=10)
        
        for i, field in enumerate(["Email", "Server", "Proxy", "Node", "Status"]):
            ttk.Label(info_grid, text=f"{field}:").grid(row=0, column=i*2, sticky=tk.E, padx=5)
            label = ttk.Label(info_grid, text="-", font=('TkDefaultFont', 9, 'bold'))
            label.grid(row=0, column=i*2+1, sticky=tk.W, padx=5)
            self.info_labels[field.lower()] = label
        
        # SOL files tabs
        tab_frame = ttk.Frame(right_frame)
        tab_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        self.notebook = ttk.Notebook(tab_frame)
        self.notebook.pack(fill=tk.BOTH, expand=True)
        
        # Create tabs for each SOL type
        self.sol_tabs = {}
        self.sol_editors = {}
        
        for sol_type, info in SOL_TYPES.items():
            tab = ttk.Frame(self.notebook)
            self.notebook.add(tab, text=sol_type.replace(".sol", "").title())
            self.sol_tabs[sol_type] = tab
            
            # Description
            desc_frame = ttk.Frame(tab)
            desc_frame.pack(fill=tk.X, padx=5, pady=5)
            ttk.Label(desc_frame, text=info["description"], 
                     font=('TkDefaultFont', 10, 'bold')).pack(anchor=tk.W)
            ttk.Label(desc_frame, text=f"Location: {info['location']}", 
                     foreground='gray').pack(anchor=tk.W)
            
            # Editor
            editor_frame = ttk.LabelFrame(tab, text="Data (Editable)")
            editor_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
            
            editor = scrolledtext.ScrolledText(editor_frame, wrap=tk.WORD, 
                                               font=('Consolas', 10))
            editor.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
            editor.bind('<KeyRelease>', lambda e, st=sol_type: self._on_editor_change(st))
            self.sol_editors[sol_type] = editor
            
            # Field reference
            ref_frame = ttk.LabelFrame(tab, text="Field Reference")
            ref_frame.pack(fill=tk.X, padx=5, pady=5)
            
            ref_text = tk.Text(ref_frame, height=4, wrap=tk.WORD, 
                              font=('TkDefaultFont', 9), state=tk.DISABLED,
                              background='#f0f0f0')
            ref_text.pack(fill=tk.X, padx=5, pady=5)
            
            # Add field descriptions
            ref_text.config(state=tk.NORMAL)
            for field, desc in info["fields"].items():
                ref_text.insert(tk.END, f"• {field}: {desc}\n")
            ref_text.config(state=tk.DISABLED)
        
        # Action buttons
        btn_frame = ttk.Frame(right_frame)
        btn_frame.pack(fill=tk.X, padx=5, pady=10)
        
        ttk.Button(btn_frame, text="💾 Save Changes", 
                  command=self._save_changes).pack(side=tk.LEFT, padx=5)
        ttk.Button(btn_frame, text="↩️ Discard", 
                  command=self._discard_changes).pack(side=tk.LEFT, padx=5)
        ttk.Button(btn_frame, text="📋 Copy Config", 
                  command=self._copy_config).pack(side=tk.LEFT, padx=5)
        ttk.Button(btn_frame, text="📥 Paste Config", 
                  command=self._paste_config).pack(side=tk.LEFT, padx=5)
        ttk.Button(btn_frame, text="🔄 Share to Multiple", 
                  command=self._share_config).pack(side=tk.LEFT, padx=5)
        
    def _create_status_bar(self):
        """Create status bar"""
        self.status_var = tk.StringVar(value="Ready")
        status_bar = ttk.Label(self.root, textvariable=self.status_var, 
                              relief=tk.SUNKEN, anchor=tk.W)
        status_bar.pack(side=tk.BOTTOM, fill=tk.X)
        
    def _load_accounts(self):
        """Load all accounts from Macromedia folder"""
        self.status_var.set("Loading accounts...")
        self.root.update()
        
        count = self.account_manager.scan_accounts()
        
        self.account_listbox.delete(0, tk.END)
        for email in sorted(self.account_manager.get_all_accounts()):
            self.account_listbox.insert(tk.END, email)
        
        self.account_list_label.config(text=f"Accounts ({count})")
        self.status_var.set(f"Loaded {count} accounts")
        
    def _filter_accounts(self, *args):
        """Filter account list based on search"""
        search = self.search_var.get().lower()
        self.account_listbox.delete(0, tk.END)
        
        for email in sorted(self.account_manager.get_all_accounts()):
            if search in email.lower():
                self.account_listbox.insert(tk.END, email)
                
    def _on_account_select(self, event):
        """Handle account selection"""
        selection = self.account_listbox.curselection()
        if not selection:
            return
        
        # Check for unsaved changes
        if self.unsaved_changes:
            if not messagebox.askyesno("Unsaved Changes", 
                                       "You have unsaved changes. Discard?"):
                return
        
        email = self.account_listbox.get(selection[0])
        self._load_account(email)
        
    def _load_account(self, email: str):
        """Load account data into editors"""
        account = self.account_manager.get_account(email)
        if not account:
            return
        
        self.current_account = email
        self.unsaved_changes = False
        
        # Update info labels
        data = account["data"].get("now", {})
        self.info_labels["email"].config(text=email)
        self.info_labels["server"].config(text=f"{data.get('server', '-')} ({data.get('strserverAlias', '')})")
        self.info_labels["proxy"].config(text=f"{data.get('proxyHost', '-')}:{data.get('proxyPort', '-')}")
        
        # Calculate node from port
        port = data.get('proxyPort', '')
        if port and port.isdigit():
            node = 9999 - int(port)
            self.info_labels["node"].config(text=f"Node {node}")
        else:
            self.info_labels["node"].config(text="-")
        
        self.info_labels["status"].config(text="Active" if data.get('autoLogin') else "Inactive")
        
        # Load SOL files into editors
        for sol_type, editor in self.sol_editors.items():
            editor.delete("1.0", tk.END)
            
            sol_path = account["sol_files"].get(sol_type)
            if sol_path and os.path.exists(sol_path):
                sol_data = self.sol_handler.read_sol(sol_path)
                if sol_data:
                    # Format as readable JSON
                    formatted = json.dumps(sol_data, indent=2, default=str)
                    editor.insert("1.0", formatted)
            else:
                editor.insert("1.0", "# No data found for this SOL type")
        
        self.status_var.set(f"Loaded: {email}")
        
    def _on_editor_change(self, sol_type: str):
        """Handle editor content change"""
        self.unsaved_changes = True
        self.status_var.set(f"Editing {sol_type} - UNSAVED CHANGES")
        
    def _save_changes(self):
        """Save changes to SOL files"""
        if not self.current_account:
            messagebox.showwarning("No Account", "Please select an account first")
            return
        
        account = self.account_manager.get_account(self.current_account)
        if not account:
            return
        
        # Create backup before saving
        all_sol_data = {}
        for sol_type, sol_path in account["sol_files"].items():
            if os.path.exists(sol_path):
                all_sol_data[sol_type] = self.sol_handler.read_sol(sol_path)
        
        self.backup_manager.create_backup(self.current_account, all_sol_data, 
                                          reason="before_save")
        
        # Save each editor's content
        saved_count = 0
        for sol_type, editor in self.sol_editors.items():
            content = editor.get("1.0", tk.END).strip()
            if content.startswith("#"):
                continue  # Skip placeholder content
            
            try:
                data = json.loads(content)
                sol_path = account["sol_files"].get(sol_type)
                if sol_path:
                    if self.sol_handler.write_sol(sol_path, data):
                        saved_count += 1
            except json.JSONDecodeError as e:
                messagebox.showerror("JSON Error", 
                                    f"Invalid JSON in {sol_type}:\n{e}")
                return
        
        self.unsaved_changes = False
        self.status_var.set(f"Saved {saved_count} files for {self.current_account}")
        messagebox.showinfo("Saved", f"Successfully saved {saved_count} SOL files")
        
    def _discard_changes(self):
        """Discard unsaved changes"""
        if self.current_account:
            self._load_account(self.current_account)
        self.unsaved_changes = False
        
    def _create_manual_backup(self):
        """Create a manual backup"""
        if not self.current_account:
            messagebox.showwarning("No Account", "Please select an account first")
            return
        
        account = self.account_manager.get_account(self.current_account)
        all_sol_data = {}
        for sol_type, sol_path in account["sol_files"].items():
            if os.path.exists(sol_path):
                all_sol_data[sol_type] = self.sol_handler.read_sol(sol_path)
        
        backup_path = self.backup_manager.create_backup(
            self.current_account, all_sol_data, reason="manual_backup"
        )
        
        messagebox.showinfo("Backup Created", f"Backup saved to:\n{backup_path}")
        
    def _show_timeline(self):
        """Show backup timeline window"""
        if not self.current_account:
            messagebox.showwarning("No Account", "Please select an account first")
            return
        
        timeline = self.backup_manager.get_timeline(self.current_account)
        
        # Create timeline window
        win = tk.Toplevel(self.root)
        win.title(f"Backup Timeline - {self.current_account}")
        win.geometry("600x400")
        
        ttk.Label(win, text=f"Backups for: {self.current_account}", 
                 font=('TkDefaultFont', 11, 'bold')).pack(pady=10)
        
        # Timeline list
        tree = ttk.Treeview(win, columns=("date", "reason", "files"), show="headings")
        tree.heading("date", text="Date/Time")
        tree.heading("reason", text="Reason")
        tree.heading("files", text="Files")
        tree.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)
        
        for backup in timeline:
            tree.insert("", tk.END, values=(
                backup.get("created", ""),
                backup.get("reason", ""),
                ", ".join(backup.get("files", []))
            ), tags=(backup.get("path"),))
        
        def restore_selected():
            selection = tree.selection()
            if selection:
                item = tree.item(selection[0])
                path = item["tags"][0]
                self._restore_from_path(path)
                win.destroy()
        
        ttk.Button(win, text="Restore Selected", 
                  command=restore_selected).pack(pady=10)
        
    def _restore_backup(self):
        """Restore from a backup"""
        if not self.current_account:
            messagebox.showwarning("No Account", "Please select an account first")
            return
        
        self._show_timeline()
        
    def _restore_from_path(self, backup_path: str):
        """Restore data from a specific backup path"""
        restored_data = self.backup_manager.restore_backup(backup_path)
        
        # Load restored data into editors
        for sol_type, data in restored_data.items():
            if sol_type in self.sol_editors:
                self.sol_editors[sol_type].delete("1.0", tk.END)
                self.sol_editors[sol_type].insert("1.0", 
                    json.dumps(data, indent=2, default=str))
        
        self.unsaved_changes = True
        self.status_var.set(f"Restored from backup - SAVE to apply")
        messagebox.showinfo("Restored", 
                           "Data restored from backup. Click Save to apply changes.")
        
    def _copy_config(self):
        """Copy current config to clipboard"""
        if not self.current_account:
            return
        
        # Get current tab's data
        current_tab = self.notebook.index(self.notebook.select())
        sol_type = list(self.sol_editors.keys())[current_tab]
        content = self.sol_editors[sol_type].get("1.0", tk.END)
        
        self.root.clipboard_clear()
        self.root.clipboard_append(content)
        self.status_var.set(f"Copied {sol_type} to clipboard")
        
    def _paste_config(self):
        """Paste config from clipboard"""
        try:
            content = self.root.clipboard_get()
            # Validate JSON
            json.loads(content)
            
            current_tab = self.notebook.index(self.notebook.select())
            sol_type = list(self.sol_editors.keys())[current_tab]
            
            self.sol_editors[sol_type].delete("1.0", tk.END)
            self.sol_editors[sol_type].insert("1.0", content)
            self.unsaved_changes = True
            self.status_var.set(f"Pasted config to {sol_type}")
        except Exception as e:
            messagebox.showerror("Paste Error", f"Invalid clipboard content:\n{e}")
            
    def _share_config(self):
        """Share config to multiple accounts"""
        if not self.current_account:
            messagebox.showwarning("No Account", "Please select a source account first")
            return
        
        # Create share dialog
        win = tk.Toplevel(self.root)
        win.title("Share Config to Multiple Accounts")
        win.geometry("700x600")
        
        ttk.Label(win, text=f"Share config from: {self.current_account}", 
                 font=('TkDefaultFont', 11, 'bold')).pack(pady=10)
        
        # Select what to share
        share_frame = ttk.LabelFrame(win, text="Select what to share")
        share_frame.pack(fill=tk.X, padx=10, pady=5)
        
        share_vars = {}
        for sol_type in SOL_TYPES.keys():
            var = tk.BooleanVar(value=False)
            share_vars[sol_type] = var
            ttk.Checkbutton(share_frame, text=sol_type, 
                           variable=var).pack(anchor=tk.W, padx=10)
        
        # Select target accounts
        target_frame = ttk.LabelFrame(win, text="Select target accounts")
        target_frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=5)
        
        # Search
        search_frame = ttk.Frame(target_frame)
        search_frame.pack(fill=tk.X, padx=5, pady=5)
        ttk.Label(search_frame, text="Filter:").pack(side=tk.LEFT)
        target_search = tk.StringVar()
        ttk.Entry(search_frame, textvariable=target_search).pack(side=tk.LEFT, fill=tk.X, expand=True)
        
        # Account list with checkboxes
        canvas = tk.Canvas(target_frame)
        scrollbar = ttk.Scrollbar(target_frame, orient="vertical", command=canvas.yview)
        scroll_frame = ttk.Frame(canvas)
        
        scroll_frame.bind("<Configure>", lambda e: canvas.configure(scrollregion=canvas.bbox("all")))
        canvas.create_window((0, 0), window=scroll_frame, anchor="nw")
        canvas.configure(yscrollcommand=scrollbar.set)
        
        target_vars = {}
        for email in sorted(self.account_manager.get_all_accounts()):
            if email == self.current_account:
                continue
            var = tk.BooleanVar(value=False)
            target_vars[email] = var
            ttk.Checkbutton(scroll_frame, text=email, 
                           variable=var).pack(anchor=tk.W)
        
        canvas.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y)
        
        # Select all / none buttons
        btn_frame = ttk.Frame(target_frame)
        btn_frame.pack(fill=tk.X, padx=5, pady=5)
        
        def select_all():
            for var in target_vars.values():
                var.set(True)
        
        def select_none():
            for var in target_vars.values():
                var.set(False)
        
        ttk.Button(btn_frame, text="Select All", command=select_all).pack(side=tk.LEFT, padx=5)
        ttk.Button(btn_frame, text="Select None", command=select_none).pack(side=tk.LEFT, padx=5)
        
        # Execute share
        def execute_share():
            selected_types = [st for st, var in share_vars.items() if var.get()]
            selected_accounts = [email for email, var in target_vars.items() if var.get()]
            
            if not selected_types:
                messagebox.showwarning("Nothing Selected", "Please select SOL types to share")
                return
            
            if not selected_accounts:
                messagebox.showwarning("No Targets", "Please select target accounts")
                return
            
            # Confirm
            if not messagebox.askyesno("Confirm Share", 
                f"Share {len(selected_types)} config(s) to {len(selected_accounts)} accounts?"):
                return
            
            # Get source data
            source_account = self.account_manager.get_account(self.current_account)
            source_data = {}
            for sol_type in selected_types:
                sol_path = source_account["sol_files"].get(sol_type)
                if sol_path and os.path.exists(sol_path):
                    source_data[sol_type] = self.sol_handler.read_sol(sol_path)
            
            # Apply to targets
            success = 0
            for target_email in selected_accounts:
                target_account = self.account_manager.get_account(target_email)
                if not target_account:
                    continue
                
                # Backup target first
                target_sol_data = {}
                for sol_type, sol_path in target_account["sol_files"].items():
                    if os.path.exists(sol_path):
                        target_sol_data[sol_type] = self.sol_handler.read_sol(sol_path)
                
                self.backup_manager.create_backup(target_email, target_sol_data, 
                                                  reason=f"before_share_from_{self.current_account}")
                
                # Write shared data
                for sol_type, data in source_data.items():
                    sol_path = target_account["sol_files"].get(sol_type)
                    if sol_path:
                        # Keep target's login credentials for config.sol
                        if sol_type == "config.sol" and "now" in data:
                            existing = self.sol_handler.read_sol(sol_path)
                            if existing and "now" in existing:
                                # Preserve login credentials
                                data["now"]["username"] = existing["now"].get("username", "")
                                data["now"]["password"] = existing["now"].get("password", "")
                                data["now"]["proxyPort"] = existing["now"].get("proxyPort", "")
                        
                        self.sol_handler.write_sol(sol_path, data)
                
                success += 1
            
            messagebox.showinfo("Share Complete", 
                               f"Successfully shared to {success} accounts")
            win.destroy()
        
        ttk.Button(win, text="🔄 Execute Share", 
                  command=execute_share).pack(pady=10)
        
    def _batch_edit(self):
        """Batch edit multiple accounts"""
        # Create batch edit window
        win = tk.Toplevel(self.root)
        win.title("Batch Edit Accounts")
        win.geometry("600x500")
        
        ttk.Label(win, text="Batch Edit - Apply changes to multiple accounts", 
                 font=('TkDefaultFont', 11, 'bold')).pack(pady=10)
        
        # Field selection
        field_frame = ttk.LabelFrame(win, text="Select field to edit")
        field_frame.pack(fill=tk.X, padx=10, pady=5)
        
        field_var = tk.StringVar(value="proxyPort")
        fields = ["proxyPort", "proxyHost", "server", "autoLogin", "autoRun"]
        for field in fields:
            ttk.Radiobutton(field_frame, text=field, value=field, 
                           variable=field_var).pack(anchor=tk.W, padx=10)
        
        # New value
        value_frame = ttk.LabelFrame(win, text="New value")
        value_frame.pack(fill=tk.X, padx=10, pady=5)
        
        value_var = tk.StringVar()
        ttk.Entry(value_frame, textvariable=value_var).pack(fill=tk.X, padx=10, pady=10)
        
        # Account selection
        select_frame = ttk.LabelFrame(win, text="Select accounts")
        select_frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=5)
        
        listbox = tk.Listbox(select_frame, selectmode=tk.MULTIPLE)
        listbox.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        for email in sorted(self.account_manager.get_all_accounts()):
            listbox.insert(tk.END, email)
        
        def apply_batch():
            field = field_var.get()
            value = value_var.get()
            selection = listbox.curselection()
            
            if not selection:
                messagebox.showwarning("No Selection", "Please select accounts")
                return
            
            if not messagebox.askyesno("Confirm", 
                f"Set {field}={value} for {len(selection)} accounts?"):
                return
            
            for idx in selection:
                email = listbox.get(idx)
                account = self.account_manager.get_account(email)
                if not account:
                    continue
                
                # Backup first
                sol_path = account["sol_files"].get("config.sol")
                if sol_path and os.path.exists(sol_path):
                    data = self.sol_handler.read_sol(sol_path)
                    self.backup_manager.create_backup(email, {"config.sol": data}, 
                                                      reason="batch_edit")
                    
                    # Apply change
                    if "now" in data:
                        if value.lower() in ['true', 'false']:
                            data["now"][field] = value.lower() == 'true'
                        else:
                            data["now"][field] = value
                        self.sol_handler.write_sol(sol_path, data)
            
            messagebox.showinfo("Complete", f"Updated {len(selection)} accounts")
            win.destroy()
        
        ttk.Button(win, text="Apply Changes", command=apply_batch).pack(pady=10)
        
    def _show_node_manager(self):
        """Show node management window"""
        win = tk.Toplevel(self.root)
        win.title("Tor Node Manager")
        win.geometry("800x600")
        
        ttk.Label(win, text="Tor Node Management - Assign accounts to nodes", 
                 font=('TkDefaultFont', 11, 'bold')).pack(pady=10)
        
        # Node stats
        stats_frame = ttk.LabelFrame(win, text="Node Statistics")
        stats_frame.pack(fill=tk.X, padx=10, pady=5)
        
        # Create node grid
        grid_frame = ttk.Frame(stats_frame)
        grid_frame.pack(fill=tk.X, padx=10, pady=10)
        
        # Count accounts per port
        port_counts = {}
        for email in self.account_manager.get_all_accounts():
            account = self.account_manager.get_account(email)
            if account and "now" in account["data"]:
                port = account["data"]["now"].get("proxyPort", "")
                port_counts[port] = port_counts.get(port, 0) + 1
        
        # Display nodes in grid
        for i in range(50):
            port = str(9999 - i)
            count = port_counts.get(port, 0)
            color = "green" if count > 0 else "lightgray"
            
            row, col = i // 10, i % 10
            frame = ttk.Frame(grid_frame, relief=tk.RAISED, borderwidth=1)
            frame.grid(row=row, column=col, padx=2, pady=2)
            
            label = tk.Label(frame, text=f"N{i}\n{count}", width=5, 
                           bg=color if count > 0 else None)
            label.pack(padx=2, pady=2)
        
        # Auto-distribute button
        def auto_distribute():
            if not messagebox.askyesno("Confirm", 
                "Auto-distribute all accounts evenly across nodes?"):
                return
            
            accounts = list(self.account_manager.get_all_accounts())
            for i, email in enumerate(accounts):
                node = i % 50
                port = str(9999 - node)
                
                account = self.account_manager.get_account(email)
                sol_path = account["sol_files"].get("config.sol")
                if sol_path and os.path.exists(sol_path):
                    data = self.sol_handler.read_sol(sol_path)
                    self.backup_manager.create_backup(email, {"config.sol": data}, 
                                                      reason="node_redistribution")
                    
                    if "now" in data:
                        data["now"]["proxyPort"] = port
                        data["now"]["proxyHost"] = "127.0.0.1"
                        self.sol_handler.write_sol(sol_path, data)
            
            messagebox.showinfo("Complete", 
                               f"Distributed {len(accounts)} accounts across 50 nodes")
            win.destroy()
        
        ttk.Button(win, text="Auto-Distribute Accounts Evenly", 
                  command=auto_distribute).pack(pady=10)
        
    def _show_sol_reference(self):
        """Show SOL file reference documentation"""
        win = tk.Toplevel(self.root)
        win.title("SOL File Reference")
        win.geometry("700x600")
        
        text = scrolledtext.ScrolledText(win, wrap=tk.WORD, font=('Consolas', 10))
        text.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)
        
        content = """
╔══════════════════════════════════════════════════════════════════════════════╗
║                         SOL FILE REFERENCE GUIDE                              ║
║                    RoboEvony / Evony Age II Bot Manager                       ║
╚══════════════════════════════════════════════════════════════════════════════╝

This guide explains each SOL file type, what data it contains, and how it's
used in RoboEvony.

═══════════════════════════════════════════════════════════════════════════════
config.sol - ACCOUNT LOGIN & SETTINGS
═══════════════════════════════════════════════════════════════════════════════
Location: RoboEvony > Main Settings
Purpose: Stores account credentials and connection settings

Fields:
  • username      - Email address for Evony login
  • password      - Account password (stored in plain text)
  • server        - Server code (cc2, na1, etc.)
  • serverIP      - Server IP address (e.g., 216.66.17.168)
  • strserverAlias- Server display name (e.g., "Parapet")
  • sid           - Server ID number
  • proxyHost     - Proxy server address (127.0.0.1 for local Tor)
  • proxyPort     - Tor node port (9949-9999 for 50 nodes)
  • proxyType     - Proxy type (ss5 = SOCKS5)
  • autoLogin     - Auto-login when RoboEvony starts (true/false)
  • autoRun       - Auto-run scripts after login (true/false)
  • autoScript    - Execute saved scripts automatically (true/false)
  • theme         - RoboEvony visual theme name
  • loginType     - Login method (ev = Evony direct, fb = Facebook)

═══════════════════════════════════════════════════════════════════════════════
goals.sol - AUTOMATION GOALS & SCRIPTS
═══════════════════════════════════════════════════════════════════════════════
Location: RoboEvony > Goals Window
Purpose: Stores automation scripts for farming, building, attacking

Fields:
  • now           - Currently active goal script text
  • goals         - Array of saved goal scripts
  • scripts       - Script content for each goal
  • sindex        - Index of currently selected script

Common Script Commands:
  • priorityFarming <level> b:<limit> t:<troops> <interval> <time>
  • keepresources <coords> f:<food> <amount>m
  • config buildnpc:<level>,valley:<level>,trade:<limit>
  • distancepolicy <d1> <d2> <d3> <d4>
  • troop r:<rams>,b:<ballista>,t:<transport>

═══════════════════════════════════════════════════════════════════════════════
newArmyTroopCfgs.sol - TROOP ARMY CONFIGURATIONS
═══════════════════════════════════════════════════════════════════════════════
Location: RoboEvony > Army Presets
Purpose: Stores saved army compositions for quick deployment

Fields:
  • troopCfg      - Troop composition string
  • label         - Preset name (e.g., "wave1", "bighitter")

Troop Codes:
  • wo = Workers      • w  = Warriors     • s  = Scouts
  • p  = Pikemen      • sw = Swordsmen    • a  = Archers
  • c  = Cavalry      • cata = Cataphracts
  • t  = Transporters • r  = Rams
  • b  = Ballista     • cp = Catapults

Example: a:50000,w:25,s:25,sw:25,p:25 = 50k archers + 25 each of support

═══════════════════════════════════════════════════════════════════════════════
citydata.sol - CITY MANAGEMENT DATA
═══════════════════════════════════════════════════════════════════════════════
Location: RoboEvony > City View
Purpose: Stores city-specific settings and goals

Fields:
  • cities        - Array of city configurations
  • index         - Selected city index
  • goals         - City-specific automation goals
  • scripts       - Per-city script settings

═══════════════════════════════════════════════════════════════════════════════
settings.sol - APPLICATION SETTINGS
═══════════════════════════════════════════════════════════════════════════════
Location: Flash Player Settings Manager
Purpose: Flash Player permissions and preferences

Fields:
  • bandwidth     - Bandwidth/storage limits
  • defaultcamera - Camera access permissions
  • defaultmicrophone - Microphone access permissions
  • trustedPaths  - Trusted local file paths

═══════════════════════════════════════════════════════════════════════════════
NODE MANAGEMENT - TOR PROXY ROUTING
═══════════════════════════════════════════════════════════════════════════════

ETK uses Tor for IP rotation to bypass Evony's 10-account-per-IP limit.

Node Configuration:
  • 50 Tor nodes available (Node 0 - Node 49)
  • Port mapping: Port = 9999 - NodeNumber
  • Node 0 = Port 9999, Node 49 = Port 9950
  
Recommended Setup:
  • Max 10-12 accounts per node
  • Distribute accounts evenly across nodes
  • Use Proxifier to route RoboEvony traffic through correct node

═══════════════════════════════════════════════════════════════════════════════
BACKUP & RECOVERY
═══════════════════════════════════════════════════════════════════════════════

Backup Strategy:
  • Auto-backup before every edit (failsafe)
  • Keep 10 rolling backups per account
  • Timeline view for point-in-time recovery
  • JSON format for easy inspection

Recovery Steps:
  1. Open Backup > View Timeline
  2. Select backup timestamp
  3. Click Restore
  4. Review changes in editor
  5. Save to apply or Discard to cancel
"""
        
        text.insert("1.0", content)
        text.config(state=tk.DISABLED)
        
    def _show_about(self):
        """Show about dialog"""
        messagebox.showinfo("About ETK SOL Manager", 
            "ETK SOL Manager v1.0\n\n"
            "Comprehensive SOL file management for Evony Age II\n"
            "Manages 470+ accounts with backup and sharing features\n\n"
            "Features:\n"
            "• View/Edit SOL files in plain English\n"
            "• Automatic backup before every change\n"
            "• Timeline rollback and recovery\n"
            "• Share configs across accounts\n"
            "• Batch editing for mass changes\n"
            "• Tor node management")
            
    def _export_all(self):
        """Export all accounts to JSON"""
        output_file = filedialog.asksaveasfilename(
            defaultextension=".json",
            filetypes=[("JSON files", "*.json")],
            initialfilename="all_accounts_export.json"
        )
        
        if not output_file:
            return
        
        export_data = {
            "exported": datetime.now().isoformat(),
            "total_accounts": len(self.account_manager.accounts),
            "accounts": []
        }
        
        for email, account in self.account_manager.accounts.items():
            acc_data = {
                "email": email,
                "folder": account["folder"],
                "sol_files": {}
            }
            
            for sol_type, sol_path in account["sol_files"].items():
                if os.path.exists(sol_path):
                    acc_data["sol_files"][sol_type] = self.sol_handler.read_sol(sol_path)
            
            export_data["accounts"].append(acc_data)
        
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(export_data, f, indent=2, default=str)
        
        messagebox.showinfo("Export Complete", 
                           f"Exported {len(export_data['accounts'])} accounts to:\n{output_file}")


# ============================================================================
# MAIN
# ============================================================================
def main():
    if not HAS_AMF:
        print("[!] pyamf required: pip install Py3AMF")
        return
    
    root = tk.Tk()
    app = SOLManagerGUI(root)
    root.mainloop()


if __name__ == "__main__":
    main()
