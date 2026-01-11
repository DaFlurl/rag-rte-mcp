# ============================================================================
# EVONY MEGA TOOLKIT - MAIN GUI
# ============================================================================
# Ultimate integrated toolkit combining:
# - 246 protocol commands
# - 166+ bot scripts
# - FlashBrowser integration
# - SOL file manipulation
# - Real-time exploit engine
# - AI script generation
# ============================================================================

import tkinter as tk
from tkinter import ttk, scrolledtext, filedialog, messagebox
import os
import sys
import json
import threading
import subprocess
from datetime import datetime
from pathlib import Path

# Add src to path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'src'))

try:
    from src.protocol import (PROTOCOL_COMMANDS, GameLimits, EvonyKeys, 
                               ExploitGenerator, TroopType, get_command_count)
except ImportError:
    PROTOCOL_COMMANDS = {}
    print("Warning: protocol.py not found")

# ============================================================================
# PATHS
# ============================================================================
BASE_DIR = Path(__file__).parent.parent
SCRIPTS_DIR = BASE_DIR / "Scripts"
BOT_SOURCE_DIR = BASE_DIR / "AS3_Scripts_(AutoEvony2_NEW.swf)"
CLIENT_SOURCE_DIR = BASE_DIR / "AS3_Scripts_(EvonyClient1921.swf)"
SOL_DIR = BASE_DIR / "SOL_Accounts"
FLASH_BROWSER_DIR = BASE_DIR / "FlashBrowser"
TOOLS_DIR = BASE_DIR / "Tools"

# ============================================================================
# THEME
# ============================================================================
THEME = {
    'bg_dark': '#0a0a0f',
    'bg_panel': '#12121a',
    'bg_input': '#1a1a25',
    'accent': '#00ff88',
    'accent2': '#00ccff',
    'accent3': '#ff6600',
    'warning': '#ffaa00',
    'danger': '#ff4444',
    'text': '#e0e0e0',
    'text_dim': '#808080',
    'border': '#2a2a35'
}

# ============================================================================
# KNOWN EXPLOITS
# ============================================================================
EXPLOITS = [
    {
        'id': 'overflow_troop',
        'name': 'Troop Integer Overflow',
        'severity': 'CRITICAL',
        'category': 'Integer Overflow',
        'description': 'Train troops > INT32_MAX/cost to overflow and get free troops',
        'command': 'troop.produceTroop',
        'risk': 'Account ban if detected'
    },
    {
        'id': 'race_item',
        'name': 'Item Race Condition',
        'severity': 'HIGH',
        'category': 'Race Condition',
        'description': 'Rapid-fire item use before server validates count',
        'command': 'shop.useGoods',
        'risk': 'Server may detect rapid requests'
    },
    {
        'id': 'food_flip',
        'name': 'Food Flip Glitch',
        'severity': 'CRITICAL',
        'category': 'Integer Overflow',
        'description': 'Food resets to 0 at 999M+ - keep below 485M!',
        'command': 'N/A - Server bug',
        'risk': 'Permanent resource loss'
    },
    {
        'id': 'security_brute',
        'name': 'Security Code Brute Force',
        'severity': 'HIGH',
        'category': 'Authentication Bypass',
        'description': 'Enumerate 0000-9999 security codes',
        'command': 'common.authSecurityCode',
        'risk': 'Rate limiting may apply'
    },
    {
        'id': 'negative_param',
        'name': 'Negative Parameter Injection',
        'severity': 'MEDIUM',
        'category': 'Validation Bypass',
        'description': 'Send negative values to invert operations',
        'command': 'Various',
        'risk': 'May cause errors'
    },
    {
        'id': 'valley_amulet',
        'name': 'Valley Amulet Farm',
        'severity': 'MEDIUM',
        'category': 'Game Mechanic Abuse',
        'description': 'Intentional troop loss for 25K amulets/day',
        'command': 'army.newArmy',
        'risk': 'Time consuming'
    },
    {
        'id': 'quest_commission',
        'name': 'Commission Quest Exploit',
        'severity': 'MEDIUM',
        'category': 'Game Mechanic Abuse',
        'description': 'Rapid accept/decline for extra rewards',
        'command': 'commission.acceptCommissionQuest',
        'risk': 'Low'
    },
    {
        'id': 'gamemaster_probe',
        'name': 'Gamemaster Command Probe',
        'severity': 'HIGH',
        'category': 'Privilege Escalation',
        'description': 'Test gamemaster.* commands for access',
        'command': 'gamemaster.addItems',
        'risk': 'Will fail without GM privileges'
    }
]

# ============================================================================
# MAIN APPLICATION
# ============================================================================
class EvonyMegaToolkit:
    def __init__(self, root):
        self.root = root
        self.root.title("EVONY MEGA TOOLKIT - 246 Commands | 166 Scripts | Live Exploits")
        self.root.geometry("1600x950")
        self.root.configure(bg=THEME['bg_dark'])
        
        # State
        self.scripts = {}
        self.logs = []
        self.selected_exploit = None
        
        # Build UI
        self.setup_styles()
        self.build_header()
        self.build_main_content()
        self.build_status_bar()
        
        # Load data
        self.load_scripts()
        self.log("EVONY MEGA TOOLKIT initialized", "success")
        self.log(f"Loaded {len(PROTOCOL_COMMANDS)} command categories ({get_command_count() if PROTOCOL_COMMANDS else 246} total commands)", "info")
        
    def setup_styles(self):
        style = ttk.Style()
        style.theme_use('clam')
        
        style.configure('Dark.TNotebook', background=THEME['bg_dark'])
        style.configure('Dark.TNotebook.Tab', 
                       background=THEME['bg_panel'],
                       foreground=THEME['text'],
                       padding=[15, 8])
        style.map('Dark.TNotebook.Tab',
                 background=[('selected', THEME['bg_input'])],
                 foreground=[('selected', THEME['accent'])])
        
        style.configure('Dark.TFrame', background=THEME['bg_dark'])
        style.configure('Panel.TFrame', background=THEME['bg_panel'])
        
        style.configure('Dark.Treeview',
                       background=THEME['bg_panel'],
                       foreground=THEME['text'],
                       fieldbackground=THEME['bg_panel'])
        style.map('Dark.Treeview',
                 background=[('selected', THEME['accent'])],
                 foreground=[('selected', THEME['bg_dark'])])
        
    def build_header(self):
        header = tk.Frame(self.root, bg=THEME['bg_panel'], height=60)
        header.pack(fill='x', padx=5, pady=5)
        header.pack_propagate(False)
        
        # Title
        title = tk.Label(header, text="⚔️ EVONY MEGA TOOLKIT",
                        font=('Consolas', 20, 'bold'),
                        fg=THEME['accent'], bg=THEME['bg_panel'])
        title.pack(side='left', padx=20, pady=10)
        
        # Stats
        stats_frame = tk.Frame(header, bg=THEME['bg_panel'])
        stats_frame.pack(side='left', padx=40)
        
        stats = [
            ("Commands", "246", THEME['accent']),
            ("Scripts", "166+", THEME['accent2']),
            ("Exploits", str(len(EXPLOITS)), THEME['warning']),
            ("Keys", "7", THEME['accent3'])
        ]
        
        for label, value, color in stats:
            stat = tk.Frame(stats_frame, bg=THEME['bg_panel'])
            stat.pack(side='left', padx=15)
            tk.Label(stat, text=value, font=('Consolas', 16, 'bold'),
                    fg=color, bg=THEME['bg_panel']).pack()
            tk.Label(stat, text=label, font=('Consolas', 9),
                    fg=THEME['text_dim'], bg=THEME['bg_panel']).pack()
        
        # Launch buttons
        btn_frame = tk.Frame(header, bg=THEME['bg_panel'])
        btn_frame.pack(side='right', padx=20)
        
        tk.Button(btn_frame, text="🌐 FlashBrowser", 
                 command=self.launch_flash_browser,
                 bg=THEME['accent2'], fg='black',
                 font=('Consolas', 10, 'bold')).pack(side='left', padx=5)
        
        tk.Button(btn_frame, text="🔧 Tools", 
                 command=self.open_tools,
                 bg=THEME['bg_input'], fg=THEME['text'],
                 font=('Consolas', 10)).pack(side='left', padx=5)
        
    def build_main_content(self):
        main = tk.Frame(self.root, bg=THEME['bg_dark'])
        main.pack(fill='both', expand=True, padx=5, pady=5)
        
        # Left panel - Scripts & Commands
        left = tk.Frame(main, bg=THEME['bg_panel'], width=280)
        left.pack(side='left', fill='y', padx=(0, 5))
        left.pack_propagate(False)
        
        self.build_left_panel(left)
        
        # Center - Main tabs
        center = tk.Frame(main, bg=THEME['bg_dark'])
        center.pack(side='left', fill='both', expand=True, padx=5)
        
        self.notebook = ttk.Notebook(center, style='Dark.TNotebook')
        self.notebook.pack(fill='both', expand=True)
        
        # Create tabs
        self.build_dashboard_tab()
        self.build_script_tab()
        self.build_exploit_tab()
        self.build_protocol_tab()
        self.build_browser_tab()
        self.build_sol_tab()
        self.build_crypto_tab()
        
        # Right panel - Activity Log
        right = tk.Frame(main, bg=THEME['bg_panel'], width=320)
        right.pack(side='right', fill='y', padx=(5, 0))
        right.pack_propagate(False)
        
        self.build_log_panel(right)
        
    def build_left_panel(self, parent):
        # Scripts section
        tk.Label(parent, text="📜 SCRIPTS", font=('Consolas', 11, 'bold'),
                fg=THEME['accent'], bg=THEME['bg_panel']).pack(pady=(10, 5))
        
        # Script list
        script_frame = tk.Frame(parent, bg=THEME['bg_panel'])
        script_frame.pack(fill='both', expand=True, padx=5)
        
        self.script_list = tk.Listbox(script_frame, bg=THEME['bg_input'],
                                      fg=THEME['text'], font=('Consolas', 9),
                                      selectbackground=THEME['accent'],
                                      selectforeground='black',
                                      borderwidth=0, highlightthickness=1,
                                      highlightcolor=THEME['border'])
        self.script_list.pack(fill='both', expand=True)
        self.script_list.bind('<<ListboxSelect>>', self.on_script_select)
        self.script_list.bind('<Double-1>', self.load_script)
        
        # Commands section
        tk.Label(parent, text="⚡ COMMANDS", font=('Consolas', 11, 'bold'),
                fg=THEME['accent2'], bg=THEME['bg_panel']).pack(pady=(15, 5))
        
        # Command categories
        self.cmd_tree = ttk.Treeview(parent, style='Dark.Treeview', height=12)
        self.cmd_tree.pack(fill='x', padx=5, pady=5)
        self.cmd_tree.heading('#0', text='Category')
        
        # Populate command tree
        for category, commands in PROTOCOL_COMMANDS.items() if PROTOCOL_COMMANDS else []:
            node = self.cmd_tree.insert('', 'end', text=f"{category} ({len(commands)})")
            for cmd in commands[:5]:  # Show first 5
                self.cmd_tree.insert(node, 'end', text=f"  .{cmd}")
            if len(commands) > 5:
                self.cmd_tree.insert(node, 'end', text=f"  ...{len(commands)-5} more")
                
    def build_dashboard_tab(self):
        tab = tk.Frame(self.notebook, bg=THEME['bg_dark'])
        self.notebook.add(tab, text=" 🎮 Dashboard ")
        
        # Header
        tk.Label(tab, text="EVONY MEGA TOOLKIT DASHBOARD",
                font=('Consolas', 18, 'bold'),
                fg=THEME['accent'], bg=THEME['bg_dark']).pack(pady=20)
        
        # Stats grid
        stats_frame = tk.Frame(tab, bg=THEME['bg_dark'])
        stats_frame.pack(pady=20)
        
        stats_data = [
            ("Protocol Commands", "246", "Full client protocol extracted", THEME['accent']),
            ("Bot Scripts", "166+", "AutoEvony script library", THEME['accent2']),
            ("Source Files", "3,278", "Decompiled AS3 source", THEME['warning']),
            ("SOL Accounts", "1,693", "Flash cookie files", THEME['accent3']),
            ("Known Exploits", str(len(EXPLOITS)), "Documented vulnerabilities", THEME['danger']),
            ("Encryption Keys", "7", "Extracted from source", THEME['accent'])
        ]
        
        for i, (name, value, desc, color) in enumerate(stats_data):
            row, col = divmod(i, 3)
            card = tk.Frame(stats_frame, bg=THEME['bg_panel'], 
                           width=200, height=100)
            card.grid(row=row, column=col, padx=10, pady=10)
            card.pack_propagate(False)
            
            tk.Label(card, text=value, font=('Consolas', 28, 'bold'),
                    fg=color, bg=THEME['bg_panel']).pack(pady=(15, 0))
            tk.Label(card, text=name, font=('Consolas', 11, 'bold'),
                    fg=THEME['text'], bg=THEME['bg_panel']).pack()
            tk.Label(card, text=desc, font=('Consolas', 8),
                    fg=THEME['text_dim'], bg=THEME['bg_panel']).pack()
        
        # Quick actions
        tk.Label(tab, text="QUICK ACTIONS", font=('Consolas', 14, 'bold'),
                fg=THEME['accent2'], bg=THEME['bg_dark']).pack(pady=(30, 10))
        
        actions_frame = tk.Frame(tab, bg=THEME['bg_dark'])
        actions_frame.pack()
        
        actions = [
            ("🌐 Launch FlashBrowser", self.launch_flash_browser, THEME['accent']),
            ("📜 Load Script", self.load_script_dialog, THEME['accent2']),
            ("💉 Run Exploit", self.show_exploit_tab, THEME['warning']),
            ("🔑 View Keys", self.show_crypto_tab, THEME['accent3']),
            ("📊 Export Protocol", self.export_protocol, THEME['text'])
        ]
        
        for text, cmd, color in actions:
            tk.Button(actions_frame, text=text, command=cmd,
                     bg=THEME['bg_panel'], fg=color,
                     font=('Consolas', 11, 'bold'),
                     width=18, height=2).pack(side='left', padx=5)
                     
    def build_script_tab(self):
        tab = tk.Frame(self.notebook, bg=THEME['bg_dark'])
        self.notebook.add(tab, text=" 📜 Script Studio ")
        
        # Toolbar
        toolbar = tk.Frame(tab, bg=THEME['bg_panel'])
        toolbar.pack(fill='x', pady=5)
        
        for text, cmd in [("New", self.new_script), ("Open", self.load_script_dialog),
                          ("Save", self.save_script), ("Run", self.run_script)]:
            tk.Button(toolbar, text=text, command=cmd,
                     bg=THEME['bg_input'], fg=THEME['text'],
                     font=('Consolas', 10)).pack(side='left', padx=5, pady=5)
        
        # Editor
        self.script_editor = scrolledtext.ScrolledText(
            tab, bg=THEME['bg_input'], fg=THEME['text'],
            font=('Consolas', 11), insertbackground=THEME['accent'],
            wrap='none')
        self.script_editor.pack(fill='both', expand=True, padx=5, pady=5)
        
    def build_exploit_tab(self):
        tab = tk.Frame(self.notebook, bg=THEME['bg_dark'])
        self.notebook.add(tab, text=" 💉 Exploits ")
        
        # Split view
        left = tk.Frame(tab, bg=THEME['bg_panel'], width=400)
        left.pack(side='left', fill='y', padx=5, pady=5)
        left.pack_propagate(False)
        
        tk.Label(left, text="KNOWN EXPLOITS", font=('Consolas', 12, 'bold'),
                fg=THEME['danger'], bg=THEME['bg_panel']).pack(pady=10)
        
        # Exploit list
        self.exploit_tree = ttk.Treeview(left, style='Dark.Treeview',
                                         columns=('severity',), height=15)
        self.exploit_tree.heading('#0', text='Exploit')
        self.exploit_tree.heading('severity', text='Severity')
        self.exploit_tree.column('severity', width=80)
        self.exploit_tree.pack(fill='both', expand=True, padx=5, pady=5)
        
        for exp in EXPLOITS:
            self.exploit_tree.insert('', 'end', text=exp['name'],
                                    values=(exp['severity'],))
        
        self.exploit_tree.bind('<<TreeviewSelect>>', self.on_exploit_select)
        
        # Details panel
        right = tk.Frame(tab, bg=THEME['bg_dark'])
        right.pack(side='right', fill='both', expand=True, padx=5, pady=5)
        
        tk.Label(right, text="EXPLOIT DETAILS", font=('Consolas', 12, 'bold'),
                fg=THEME['warning'], bg=THEME['bg_dark']).pack(pady=10)
        
        self.exploit_details = scrolledtext.ScrolledText(
            right, bg=THEME['bg_panel'], fg=THEME['text'],
            font=('Consolas', 11), height=15)
        self.exploit_details.pack(fill='both', expand=True, padx=5)
        
        # Generate button
        tk.Button(right, text="🔥 GENERATE EXPLOIT SCRIPT",
                 command=self.generate_exploit_script,
                 bg=THEME['danger'], fg='white',
                 font=('Consolas', 12, 'bold')).pack(pady=10)
                 
    def build_protocol_tab(self):
        tab = tk.Frame(self.notebook, bg=THEME['bg_dark'])
        self.notebook.add(tab, text=" 📡 Protocol ")
        
        # Category selector
        top = tk.Frame(tab, bg=THEME['bg_panel'])
        top.pack(fill='x', pady=5)
        
        tk.Label(top, text="Category:", fg=THEME['text'],
                bg=THEME['bg_panel'], font=('Consolas', 10)).pack(side='left', padx=10)
        
        self.proto_category = ttk.Combobox(top, values=list(PROTOCOL_COMMANDS.keys()) if PROTOCOL_COMMANDS else [])
        self.proto_category.pack(side='left', padx=5)
        self.proto_category.bind('<<ComboboxSelected>>', self.on_category_select)
        
        # Command list
        self.proto_list = ttk.Treeview(tab, style='Dark.Treeview',
                                       columns=('params',), height=25)
        self.proto_list.heading('#0', text='Command')
        self.proto_list.heading('params', text='Parameters')
        self.proto_list.pack(fill='both', expand=True, padx=5, pady=5)
        
    def build_browser_tab(self):
        tab = tk.Frame(self.notebook, bg=THEME['bg_dark'])
        self.notebook.add(tab, text=" 🌐 Browser ")
        
        info = """
╔══════════════════════════════════════════════════════════════╗
║                    FLASHBROWSER INTEGRATION                   ║
╠══════════════════════════════════════════════════════════════╣
║                                                               ║
║  FlashBrowser is an Electron-based browser with Flash support ║
║  that allows running AutoEvony.swf with embedded web browser  ║
║                                                               ║
║  FEATURES:                                                    ║
║  • Run AutoEvony2_NEW.swf with full functionality             ║
║  • Embedded browser loads game client directly                ║
║  • Bot scripts execute while viewing game                     ║
║  • Real-time troop/resource monitoring                        ║
║                                                               ║
║  HOW TO USE:                                                  ║
║  1. Click "Launch FlashBrowser" button                        ║
║  2. Open AutoEvony2_NEW.swf in the browser                    ║
║  3. Login and configure bot settings                          ║
║  4. Load scripts from Script Studio tab                       ║
║                                                               ║
╚══════════════════════════════════════════════════════════════╝
        """
        
        tk.Label(tab, text=info, font=('Consolas', 11),
                fg=THEME['accent'], bg=THEME['bg_dark'],
                justify='left').pack(pady=20)
        
        tk.Button(tab, text="🌐 LAUNCH FLASHBROWSER",
                 command=self.launch_flash_browser,
                 bg=THEME['accent'], fg='black',
                 font=('Consolas', 14, 'bold'),
                 width=30, height=2).pack(pady=20)
                 
    def build_sol_tab(self):
        tab = tk.Frame(self.notebook, bg=THEME['bg_dark'])
        self.notebook.add(tab, text=" 💾 SOL Files ")
        
        tk.Label(tab, text="SOL FILE MANAGER", font=('Consolas', 14, 'bold'),
                fg=THEME['accent2'], bg=THEME['bg_dark']).pack(pady=10)
        
        # SOL list
        sol_frame = tk.Frame(tab, bg=THEME['bg_panel'])
        sol_frame.pack(fill='both', expand=True, padx=10, pady=10)
        
        self.sol_list = ttk.Treeview(sol_frame, style='Dark.Treeview',
                                     columns=('size', 'modified'), height=20)
        self.sol_list.heading('#0', text='SOL File')
        self.sol_list.heading('size', text='Size')
        self.sol_list.heading('modified', text='Modified')
        self.sol_list.pack(fill='both', expand=True)
        
        # Load SOL files
        self.load_sol_files()
        
    def build_crypto_tab(self):
        tab = tk.Frame(self.notebook, bg=THEME['bg_dark'])
        self.notebook.add(tab, text=" 🔑 Crypto ")
        
        # Keys display
        keys_info = f"""
╔══════════════════════════════════════════════════════════════════════════╗
║                        EXTRACTED ENCRYPTION KEYS                         ║
╠══════════════════════════════════════════════════════════════════════════╣
║                                                                          ║
║  ACTION_KEY:                                                             ║
║  {EvonyKeys.ACTION_KEY}                                                  ║
║                                                                          ║
║  API_KEY:                                                                ║
║  {EvonyKeys.API_KEY}                                                     ║
║                                                                          ║
║  USER_INFO_KEY:                                                          ║
║  {EvonyKeys.USER_INFO_KEY}                                               ║
║                                                                          ║
║  XOR_KEY: 0x{EvonyKeys.XOR_KEY:02X} ({EvonyKeys.XOR_KEY})                ║
║                                                                          ║
║  LOGIN_SALT: {EvonyKeys.LOGIN_SALT}                                      ║
║                                                                          ║
║  GAME_KEY: {EvonyKeys.GAME_KEY}                                          ║
║                                                                          ║
║  NETWORK_KEY: {EvonyKeys.NETWORK_KEY}                                    ║
║                                                                          ║
╠══════════════════════════════════════════════════════════════════════════╣
║                         CRITICAL GAME LIMITS                             ║
╠══════════════════════════════════════════════════════════════════════════╣
║                                                                          ║
║  MAX_SAFE_FOOD:        {GameLimits.MAX_SAFE_FOOD:>15,}  (flips at 999M!) ║
║  MAX_SAFE_TROOP:       {GameLimits.MAX_SAFE_TROOP_SINGLE:>15,}           ║
║  MAX_VALLEY_TRANSPORT: {GameLimits.MAX_VALLEY_TRANSPORT:>15,}            ║
║  INT32_MAX:            {GameLimits.INT32_MAX:>15,}                       ║
║                                                                          ║
╚══════════════════════════════════════════════════════════════════════════╝
        """
        
        tk.Label(tab, text=keys_info, font=('Consolas', 10),
                fg=THEME['accent'], bg=THEME['bg_dark'],
                justify='left').pack(pady=20)
        
        # Overflow calculator
        calc_frame = tk.Frame(tab, bg=THEME['bg_panel'])
        calc_frame.pack(pady=10)
        
        tk.Label(calc_frame, text="OVERFLOW CALCULATOR", 
                font=('Consolas', 12, 'bold'),
                fg=THEME['warning'], bg=THEME['bg_panel']).pack(pady=10)
                
        for troop, data in list(GameLimits.OVERFLOW.items())[:6]:
            row = tk.Frame(calc_frame, bg=THEME['bg_panel'])
            row.pack(fill='x', padx=20)
            tk.Label(row, text=f"{troop.upper()}:", width=12, anchor='w',
                    fg=THEME['text'], bg=THEME['bg_panel'],
                    font=('Consolas', 10)).pack(side='left')
            tk.Label(row, text=f"Cost: {data['cost']:>5}", width=12,
                    fg=THEME['text_dim'], bg=THEME['bg_panel'],
                    font=('Consolas', 10)).pack(side='left')
            tk.Label(row, text=f"Threshold: {data['threshold']:>12,}",
                    fg=THEME['danger'], bg=THEME['bg_panel'],
                    font=('Consolas', 10, 'bold')).pack(side='left')
                    
    def build_log_panel(self, parent):
        tk.Label(parent, text="📋 ACTIVITY LOG", font=('Consolas', 11, 'bold'),
                fg=THEME['accent'], bg=THEME['bg_panel']).pack(pady=10)
        
        self.log_text = scrolledtext.ScrolledText(
            parent, bg=THEME['bg_input'], fg=THEME['text'],
            font=('Consolas', 9), height=40)
        self.log_text.pack(fill='both', expand=True, padx=5, pady=5)
        
        # Configure tags
        self.log_text.tag_configure('info', foreground=THEME['accent2'])
        self.log_text.tag_configure('success', foreground=THEME['accent'])
        self.log_text.tag_configure('warning', foreground=THEME['warning'])
        self.log_text.tag_configure('error', foreground=THEME['danger'])
        
    def build_status_bar(self):
        status = tk.Frame(self.root, bg=THEME['bg_panel'], height=30)
        status.pack(fill='x', side='bottom')
        
        tk.Label(status, text="Ready", fg=THEME['text_dim'],
                bg=THEME['bg_panel'], font=('Consolas', 9)).pack(side='left', padx=10)
        
        tk.Label(status, text=f"Base: {BASE_DIR}", fg=THEME['text_dim'],
                bg=THEME['bg_panel'], font=('Consolas', 9)).pack(side='right', padx=10)
                
    # ========== ACTIONS ==========
    
    def log(self, message, level='info'):
        timestamp = datetime.now().strftime('%H:%M:%S')
        self.log_text.insert('end', f"[{timestamp}] ", 'timestamp')
        self.log_text.insert('end', f"{message}\n", level)
        self.log_text.see('end')
        
    def load_scripts(self):
        if SCRIPTS_DIR.exists():
            for f in SCRIPTS_DIR.glob('*.txt'):
                self.scripts[f.stem] = f
                self.script_list.insert('end', f.stem)
            self.log(f"Loaded {len(self.scripts)} scripts", "success")
            
    def load_sol_files(self):
        if SOL_DIR.exists():
            for f in SOL_DIR.glob('*.sol'):
                stat = f.stat()
                self.sol_list.insert('', 'end', text=f.name,
                                    values=(f"{stat.st_size} B",
                                           datetime.fromtimestamp(stat.st_mtime).strftime('%Y-%m-%d')))
                                           
    def on_script_select(self, event):
        pass
        
    def on_exploit_select(self, event):
        sel = self.exploit_tree.selection()
        if sel:
            idx = self.exploit_tree.index(sel[0])
            exp = EXPLOITS[idx]
            self.selected_exploit = exp
            
            details = f"""
EXPLOIT: {exp['name']}
{'='*50}

SEVERITY: {exp['severity']}
CATEGORY: {exp['category']}

DESCRIPTION:
{exp['description']}

COMMAND: {exp['command']}

RISK:
{exp['risk']}
            """
            self.exploit_details.delete('1.0', 'end')
            self.exploit_details.insert('1.0', details)
            
    def on_category_select(self, event):
        cat = self.proto_category.get()
        self.proto_list.delete(*self.proto_list.get_children())
        if cat in PROTOCOL_COMMANDS:
            for cmd in PROTOCOL_COMMANDS[cat]:
                self.proto_list.insert('', 'end', text=f"{cat}.{cmd}")
                
    def generate_exploit_script(self):
        if not self.selected_exploit:
            messagebox.showwarning("Warning", "Select an exploit first")
            return
            
        exp = self.selected_exploit
        
        if exp['id'] == 'overflow_troop':
            script = self.generate_overflow_script()
        elif exp['id'] == 'race_item':
            script = self.generate_race_script()
        else:
            script = f"; {exp['name']} exploit\n; TODO: Implement"
            
        self.script_editor.delete('1.0', 'end')
        self.script_editor.insert('1.0', script)
        self.notebook.select(1)  # Switch to script tab
        self.log(f"Generated exploit script: {exp['name']}", "warning")
        
    def generate_overflow_script(self):
        return """; TROOP OVERFLOW EXPLOIT
; Train troops > INT32_MAX/cost to overflow
; WARNING: Use at your own risk!

setarr troops "archer"
set threshold 6135037

label overflow_loop
  echo "Training {threshold} archers..."
  train %troops% %threshold%
  sleep 1
goto overflow_loop
"""

    def generate_race_script(self):
        return """; RACE CONDITION EXPLOIT  
; Rapid-fire item use before server validates

set itemId "your_item_id"
set count 100

label race_loop
set i 0
label inner
  useitem %itemId% 1
  set i {%i%+1}
  if {%i%<%count%} goto inner
echo "Fired {count} item uses"
sleep 1
goto race_loop
"""
    
    def load_script(self, event=None):
        sel = self.script_list.curselection()
        if sel:
            name = self.script_list.get(sel[0])
            path = self.scripts.get(name)
            if path and path.exists():
                content = path.read_text(encoding='utf-8', errors='ignore')
                self.script_editor.delete('1.0', 'end')
                self.script_editor.insert('1.0', content)
                self.notebook.select(1)
                self.log(f"Loaded script: {name}", "success")
                
    def load_script_dialog(self):
        path = filedialog.askopenfilename(
            initialdir=SCRIPTS_DIR,
            filetypes=[("Script files", "*.txt"), ("All files", "*.*")])
        if path:
            content = Path(path).read_text(encoding='utf-8', errors='ignore')
            self.script_editor.delete('1.0', 'end')
            self.script_editor.insert('1.0', content)
            self.log(f"Loaded: {path}", "success")
            
    def new_script(self):
        self.script_editor.delete('1.0', 'end')
        self.script_editor.insert('1.0', "; New script\n\n")
        self.log("New script created", "info")
        
    def save_script(self):
        content = self.script_editor.get('1.0', 'end')
        path = filedialog.asksaveasfilename(
            initialdir=SCRIPTS_DIR,
            defaultextension=".txt",
            filetypes=[("Script files", "*.txt")])
        if path:
            Path(path).write_text(content, encoding='utf-8')
            self.log(f"Saved: {path}", "success")
            
    def run_script(self):
        self.log("Script execution requires AutoEvony runtime", "warning")
        
    def launch_flash_browser(self):
        fb_exe = FLASH_BROWSER_DIR / "FlashBrowser.exe"
        if fb_exe.exists():
            subprocess.Popen([str(fb_exe)])
            self.log("Launched FlashBrowser", "success")
        else:
            self.log(f"FlashBrowser not found at {fb_exe}", "error")
            
    def open_tools(self):
        if TOOLS_DIR.exists():
            os.startfile(str(TOOLS_DIR))
            self.log("Opened Tools directory", "info")
            
    def show_exploit_tab(self):
        self.notebook.select(2)
        
    def show_crypto_tab(self):
        self.notebook.select(6)
        
    def export_protocol(self):
        path = filedialog.asksaveasfilename(
            defaultextension=".json",
            filetypes=[("JSON files", "*.json")])
        if path:
            with open(path, 'w') as f:
                json.dump(PROTOCOL_COMMANDS, f, indent=2)
            self.log(f"Exported protocol to {path}", "success")

# ============================================================================
# MAIN
# ============================================================================
if __name__ == '__main__':
    root = tk.Tk()
    app = EvonyMegaToolkit(root)
    root.mainloop()
