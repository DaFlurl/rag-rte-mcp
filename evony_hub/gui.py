#!/usr/bin/env python3
# Evony Master Hub - Unified GUI
"""
Unified GUI integrating all Evony toolkits into tabbed interface:
- Dashboard (status, quick launch)
- Script Server (AutoEvony integration)
- Exploit Engine (overflow, race conditions)
- Protocol Commander (352+ commands)
- Script Studio (166+ scripts)
- Source Browser (3,278 AS3 files)
- Crypto Tools (keys, signatures)
- File Organizer (auto-organization)
- Browser Controller (FlashBrowser)

Usage:
    python -m evony_hub.gui
"""

import tkinter as tk
from tkinter import ttk, scrolledtext, messagebox, filedialog
import threading
import webbrowser
import subprocess
import json
import sys
from pathlib import Path
from datetime import datetime

# Add paths
sys.path.insert(0, str(Path(__file__).parent.parent))

HUB_ROOT = Path(r"c:\Users\Admin\Downloads\Evony_Decrypted")

# =============================================================================
# ENCRYPTION KEYS
# =============================================================================
ENCRYPTION_KEYS = {
    'ACTION_KEY': "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}",
    'API_KEY': "9f758e2deccbe6244f734371b9642eda",
    'USER_INFO_KEY': "IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}",
    'XOR_KEY': '0xAA (170)',
    'LOGIN_SALT': "evony",
    'GAME_KEY': "EvonyGameKey2009",
    'NETWORK_KEY': "EvonyNetKey2009",
}

# =============================================================================
# OVERFLOW THRESHOLDS
# =============================================================================
INT32_MAX = 2147483647
TROOP_DATA = {
    1: {'name': 'Worker', 'abbrev': 'wo', 'cost': 50},
    2: {'name': 'Warrior', 'abbrev': 'wa', 'cost': 75},
    3: {'name': 'Scout', 'abbrev': 'sc', 'cost': 100},
    4: {'name': 'Pikeman', 'abbrev': 'pi', 'cost': 200},
    5: {'name': 'Swordsman', 'abbrev': 'sw', 'cost': 250},
    6: {'name': 'Archer', 'abbrev': 'a', 'cost': 350},
    7: {'name': 'Cavalry', 'abbrev': 'cav', 'cost': 800},
    8: {'name': 'Cataphract', 'abbrev': 'cata', 'cost': 1500},
    9: {'name': 'Transporter', 'abbrev': 'tr', 'cost': 300},
    10: {'name': 'Ballista', 'abbrev': 'ba', 'cost': 2000},
    11: {'name': 'Ram', 'abbrev': 'r', 'cost': 2500},
    12: {'name': 'Catapult', 'abbrev': 'c', 'cost': 3000},
}

# =============================================================================
# INTEGRATED TOOLKITS
# =============================================================================
TOOLKITS = {
    'evony_hub': HUB_ROOT / 'evony_hub',
    'BorgToolkit': HUB_ROOT / 'BorgToolkit',
    'EvonyCommandCenter': HUB_ROOT / 'EvonyCommandCenter',
    'EvonyMasterSuite': HUB_ROOT / 'EvonyMasterSuite',
    'EvonyMegaToolkit': HUB_ROOT / 'EvonyMegaToolkit',
    'flash_toolkit_v2': HUB_ROOT / 'flash_toolkit_v2',
    'FlashBrowser': HUB_ROOT / 'FlashBrowser',
}


class EvonyMasterHub:
    """Unified GUI for all Evony toolkits."""
    
    def __init__(self):
        self.root = tk.Tk()
        self.root.title("⚔️ EVONY MASTER HUB - Unified Exploitation Framework")
        self.root.geometry("1200x800")
        self.root.configure(bg='#1a1a2e')
        
        self.server_running = False
        self.server_thread = None
        
        self._setup_styles()
        self._create_ui()
    
    def _setup_styles(self):
        """Configure ttk styles."""
        style = ttk.Style()
        style.theme_use('clam')
        
        # Dark theme colors
        style.configure('TNotebook', background='#1a1a2e')
        style.configure('TNotebook.Tab', background='#16213e', foreground='white', 
                       padding=[20, 10], font=('Consolas', 10, 'bold'))
        style.map('TNotebook.Tab', background=[('selected', '#0f3460')])
        
        style.configure('TFrame', background='#1a1a2e')
        style.configure('TLabel', background='#1a1a2e', foreground='#e94560', 
                       font=('Consolas', 10))
        style.configure('TButton', background='#e94560', foreground='white',
                       font=('Consolas', 10, 'bold'), padding=10)
        style.configure('Header.TLabel', font=('Consolas', 14, 'bold'), 
                       foreground='#00ff88')
    
    def _create_ui(self):
        """Create the main UI with tabs."""
        # Header
        header = tk.Frame(self.root, bg='#0f3460', height=60)
        header.pack(fill='x')
        header.pack_propagate(False)
        
        title = tk.Label(header, text="⚔️ EVONY MASTER HUB", 
                        font=('Consolas', 20, 'bold'), fg='#00ff88', bg='#0f3460')
        title.pack(pady=15)
        
        # Notebook (tabs)
        self.notebook = ttk.Notebook(self.root)
        self.notebook.pack(fill='both', expand=True, padx=5, pady=5)
        
        # Create all tabs
        self._create_dashboard_tab()
        self._create_server_tab()
        self._create_exploit_tab()
        self._create_protocol_tab()
        self._create_scripts_tab()
        self._create_crypto_tab()
        self._create_tools_tab()
        
        # Status bar
        self.status_var = tk.StringVar(value="Ready")
        status = tk.Label(self.root, textvariable=self.status_var, 
                         font=('Consolas', 9), fg='#888', bg='#1a1a2e', anchor='w')
        status.pack(fill='x', padx=10, pady=5)
    
    def _create_dashboard_tab(self):
        """Dashboard tab with overview and quick launch."""
        frame = ttk.Frame(self.notebook)
        self.notebook.add(frame, text='📊 Dashboard')
        
        # Stats section
        stats_frame = tk.LabelFrame(frame, text="System Stats", 
                                   font=('Consolas', 12, 'bold'),
                                   fg='#00ff88', bg='#1a1a2e')
        stats_frame.pack(fill='x', padx=10, pady=10)
        
        stats = [
            ("Protocol Commands", "352+"),
            ("Bot Scripts", "166+"),
            ("AS3 Source Files", "3,278"),
            ("SOL Accounts", "1,693"),
            ("Encryption Keys", "7"),
            ("Known Exploits", "15+"),
        ]
        
        for i, (label, value) in enumerate(stats):
            row = i // 3
            col = i % 3
            tk.Label(stats_frame, text=f"{label}:", font=('Consolas', 10),
                    fg='#888', bg='#1a1a2e').grid(row=row, column=col*2, 
                                                   padx=10, pady=5, sticky='e')
            tk.Label(stats_frame, text=value, font=('Consolas', 12, 'bold'),
                    fg='#e94560', bg='#1a1a2e').grid(row=row, column=col*2+1,
                                                     padx=10, pady=5, sticky='w')
        
        # Quick Launch section
        launch_frame = tk.LabelFrame(frame, text="Quick Launch",
                                    font=('Consolas', 12, 'bold'),
                                    fg='#00ff88', bg='#1a1a2e')
        launch_frame.pack(fill='x', padx=10, pady=10)
        
        buttons = [
            ("🚀 Start Script Server", self._start_server),
            ("🌐 Open FlashBrowser", self._open_flashbrowser),
            ("📂 Open Hub Folder", self._open_hub_folder),
            ("📝 Generate Report", self._generate_report),
        ]
        
        for i, (text, cmd) in enumerate(buttons):
            btn = tk.Button(launch_frame, text=text, command=cmd,
                           font=('Consolas', 11, 'bold'), bg='#e94560', fg='white',
                           activebackground='#ff6b6b', width=25)
            btn.grid(row=i//2, column=i%2, padx=10, pady=10)
        
        # Keys display
        keys_frame = tk.LabelFrame(frame, text="Encryption Keys",
                                  font=('Consolas', 12, 'bold'),
                                  fg='#00ff88', bg='#1a1a2e')
        keys_frame.pack(fill='both', expand=True, padx=10, pady=10)
        
        keys_text = scrolledtext.ScrolledText(keys_frame, height=10,
                                             font=('Consolas', 10),
                                             bg='#16213e', fg='#00ff88',
                                             insertbackground='white')
        keys_text.pack(fill='both', expand=True, padx=5, pady=5)
        
        for key, value in ENCRYPTION_KEYS.items():
            keys_text.insert('end', f"{key}:\n  {value}\n\n")
        keys_text.config(state='disabled')
    
    def _create_server_tab(self):
        """Script Server tab for AutoEvony integration."""
        frame = ttk.Frame(self.notebook)
        self.notebook.add(frame, text='🚀 Script Server')
        
        # Server control
        ctrl_frame = tk.LabelFrame(frame, text="Server Control",
                                  font=('Consolas', 12, 'bold'),
                                  fg='#00ff88', bg='#1a1a2e')
        ctrl_frame.pack(fill='x', padx=10, pady=10)
        
        self.server_status = tk.StringVar(value="⚫ Server Stopped")
        tk.Label(ctrl_frame, textvariable=self.server_status,
                font=('Consolas', 14, 'bold'), fg='#ff6b6b', bg='#1a1a2e').pack(pady=10)
        
        btn_frame = tk.Frame(ctrl_frame, bg='#1a1a2e')
        btn_frame.pack(pady=10)
        
        self.start_btn = tk.Button(btn_frame, text="▶ Start Server", 
                                  command=self._start_server,
                                  font=('Consolas', 12, 'bold'), 
                                  bg='#00ff88', fg='black', width=15)
        self.start_btn.pack(side='left', padx=10)
        
        self.stop_btn = tk.Button(btn_frame, text="⏹ Stop Server",
                                 command=self._stop_server,
                                 font=('Consolas', 12, 'bold'),
                                 bg='#e94560', fg='white', width=15,
                                 state='disabled')
        self.stop_btn.pack(side='left', padx=10)
        
        # AutoEvony commands
        cmd_frame = tk.LabelFrame(frame, text="AutoEvony Commands",
                                 font=('Consolas', 12, 'bold'),
                                 fg='#00ff88', bg='#1a1a2e')
        cmd_frame.pack(fill='both', expand=True, padx=10, pady=10)
        
        commands = [
            ("Overflow Chain (All Troops)", "includeurl http://localhost:8088/epic/overflow_chain"),
            ("Infinite Resources", "includeurl http://localhost:8088/epic/infinite_resources"),
            ("Race Condition Blitz", "includeurl http://localhost:8088/epic/race_blitz"),
            ("Full Automation Loop", "includeurl http://localhost:8088/epic/full_auto"),
            ("Valley Hide", "includeurl http://localhost:8088/epic/valley_hide"),
            ("Gold Farm", "includeurl http://localhost:8088/epic/gold_farm"),
        ]
        
        for name, cmd in commands:
            row = tk.Frame(cmd_frame, bg='#1a1a2e')
            row.pack(fill='x', padx=5, pady=2)
            
            tk.Label(row, text=name, font=('Consolas', 10), fg='#888',
                    bg='#1a1a2e', width=25, anchor='w').pack(side='left')
            
            entry = tk.Entry(row, font=('Consolas', 9), bg='#16213e', fg='#00ff88',
                            width=55)
            entry.insert(0, cmd)
            entry.pack(side='left', padx=5)
            
            tk.Button(row, text="📋", command=lambda c=cmd: self._copy_to_clipboard(c),
                     font=('Consolas', 8), bg='#0f3460', fg='white').pack(side='left')
    
    def _create_exploit_tab(self):
        """Exploit Engine tab with overflow calculator."""
        frame = ttk.Frame(self.notebook)
        self.notebook.add(frame, text='💀 Exploits')
        
        # Overflow calculator
        calc_frame = tk.LabelFrame(frame, text="Troop Overflow Calculator",
                                  font=('Consolas', 12, 'bold'),
                                  fg='#00ff88', bg='#1a1a2e')
        calc_frame.pack(fill='x', padx=10, pady=10)
        
        # Troop selection
        tk.Label(calc_frame, text="Select Troop:", font=('Consolas', 10),
                fg='#888', bg='#1a1a2e').grid(row=0, column=0, padx=10, pady=5)
        
        self.troop_var = tk.StringVar(value='Archer')
        troop_names = [d['name'] for d in TROOP_DATA.values()]
        troop_menu = ttk.Combobox(calc_frame, textvariable=self.troop_var,
                                 values=troop_names, state='readonly', width=20)
        troop_menu.grid(row=0, column=1, padx=10, pady=5)
        troop_menu.bind('<<ComboboxSelected>>', self._calc_overflow)
        
        # Results
        self.overflow_result = tk.StringVar(value="Select a troop type")
        tk.Label(calc_frame, textvariable=self.overflow_result,
                font=('Consolas', 11), fg='#e94560', bg='#1a1a2e',
                justify='left').grid(row=1, column=0, columnspan=3, padx=10, pady=10)
        
        # All thresholds table
        table_frame = tk.LabelFrame(frame, text="All Overflow Thresholds",
                                   font=('Consolas', 12, 'bold'),
                                   fg='#00ff88', bg='#1a1a2e')
        table_frame.pack(fill='both', expand=True, padx=10, pady=10)
        
        # Headers
        headers = ['Troop', 'Cost', 'Threshold', 'Script Command']
        for i, h in enumerate(headers):
            tk.Label(table_frame, text=h, font=('Consolas', 10, 'bold'),
                    fg='#00ff88', bg='#1a1a2e').grid(row=0, column=i, padx=10, pady=5)
        
        # Data rows
        for tid, data in TROOP_DATA.items():
            threshold = (INT32_MAX // data['cost']) + 1
            cmd = f"train {data['abbrev']}:{threshold}"
            
            tk.Label(table_frame, text=data['name'], font=('Consolas', 9),
                    fg='white', bg='#1a1a2e').grid(row=tid, column=0, padx=10, pady=2)
            tk.Label(table_frame, text=str(data['cost']), font=('Consolas', 9),
                    fg='#888', bg='#1a1a2e').grid(row=tid, column=1, padx=10, pady=2)
            tk.Label(table_frame, text=f"{threshold:,}", font=('Consolas', 9),
                    fg='#e94560', bg='#1a1a2e').grid(row=tid, column=2, padx=10, pady=2)
            tk.Label(table_frame, text=cmd, font=('Consolas', 9),
                    fg='#00ff88', bg='#1a1a2e').grid(row=tid, column=3, padx=10, pady=2)
        
        self._calc_overflow(None)  # Initial calc
    
    def _create_protocol_tab(self):
        """Protocol Commander tab."""
        frame = ttk.Frame(self.notebook)
        self.notebook.add(frame, text='📡 Protocol')
        
        tk.Label(frame, text="352+ Protocol Commands Available",
                font=('Consolas', 14, 'bold'), fg='#00ff88', bg='#1a1a2e').pack(pady=20)
        
        # Categories list
        categories = [
            'troop', 'army', 'shop', 'common', 'castle', 'city', 'hero',
            'quest', 'alliance', 'colony', 'trade', 'tech', 'interior',
            'mail', 'report', 'rank', 'fortifications', 'commission',
            'capital', 'visit', 'friend', 'gamemaster'
        ]
        
        cat_frame = tk.Frame(frame, bg='#1a1a2e')
        cat_frame.pack(fill='x', padx=20)
        
        for i, cat in enumerate(categories):
            row = i // 4
            col = i % 4
            tk.Label(cat_frame, text=f"• {cat}.*", font=('Consolas', 10),
                    fg='#888', bg='#1a1a2e').grid(row=row, column=col, 
                                                   padx=15, pady=3, sticky='w')
        
        tk.Label(frame, text="Use evony_hub/borg_toolkit.py for full command registry",
                font=('Consolas', 10), fg='#666', bg='#1a1a2e').pack(pady=20)
    
    def _create_scripts_tab(self):
        """Scripts Studio tab."""
        frame = ttk.Frame(self.notebook)
        self.notebook.add(frame, text='📜 Scripts')
        
        tk.Label(frame, text="166+ Bot Scripts Available",
                font=('Consolas', 14, 'bold'), fg='#00ff88', bg='#1a1a2e').pack(pady=10)
        
        # Script locations
        locations = [
            ("BorgToolkit Scripts", HUB_ROOT / "BorgToolkit" / "scripts"),
            ("Legacy Scripts", HUB_ROOT / "Scripts"),
            ("Discovery Scripts", HUB_ROOT / "evony_hub" / "scripts"),
        ]
        
        for name, path in locations:
            btn = tk.Button(frame, text=f"📂 {name}", 
                           command=lambda p=path: self._open_folder(p),
                           font=('Consolas', 11), bg='#0f3460', fg='white', width=30)
            btn.pack(pady=5)
    
    def _create_crypto_tab(self):
        """Crypto Tools tab."""
        frame = ttk.Frame(self.notebook)
        self.notebook.add(frame, text='🔐 Crypto')
        
        tk.Label(frame, text="Encryption Keys & Signature Tools",
                font=('Consolas', 14, 'bold'), fg='#00ff88', bg='#1a1a2e').pack(pady=10)
        
        # All keys
        keys_frame = tk.LabelFrame(frame, text="Extracted Keys",
                                  font=('Consolas', 12, 'bold'),
                                  fg='#00ff88', bg='#1a1a2e')
        keys_frame.pack(fill='x', padx=10, pady=10)
        
        for key, value in ENCRYPTION_KEYS.items():
            row = tk.Frame(keys_frame, bg='#1a1a2e')
            row.pack(fill='x', padx=5, pady=2)
            
            tk.Label(row, text=f"{key}:", font=('Consolas', 10, 'bold'),
                    fg='#e94560', bg='#1a1a2e', width=15, anchor='w').pack(side='left')
            
            entry = tk.Entry(row, font=('Consolas', 9), bg='#16213e', fg='#00ff88',
                            width=60)
            entry.insert(0, str(value))
            entry.pack(side='left', padx=5)
            
            tk.Button(row, text="📋", 
                     command=lambda v=value: self._copy_to_clipboard(str(v)),
                     font=('Consolas', 8), bg='#0f3460', fg='white').pack(side='left')
    
    def _create_tools_tab(self):
        """External Tools launcher tab."""
        frame = ttk.Frame(self.notebook)
        self.notebook.add(frame, text='🔧 Tools')
        
        tk.Label(frame, text="Integrated Tools",
                font=('Consolas', 14, 'bold'), fg='#00ff88', bg='#1a1a2e').pack(pady=10)
        
        tools = [
            ("FlashBrowser", HUB_ROOT / "FlashBrowser" / "FlashBrowser.exe"),
            ("FFDEC (SWF Decompiler)", HUB_ROOT / "Tools" / "ffdec_22.0.2" / "ffdec.exe"),
            ("Command Center", HUB_ROOT / "EvonyCommandCenter" / "evony_command_center.py"),
            ("Master Suite", HUB_ROOT / "EvonyMasterSuite" / "master_suite.py"),
            ("Mega Toolkit", HUB_ROOT / "EvonyMegaToolkit" / "mega_toolkit.py"),
        ]
        
        for name, path in tools:
            exists = "✅" if path.exists() else "❌"
            btn = tk.Button(frame, text=f"{exists} {name}",
                           command=lambda p=path: self._launch_tool(p),
                           font=('Consolas', 11), bg='#0f3460', fg='white', width=40,
                           state='normal' if path.exists() else 'disabled')
            btn.pack(pady=5)
    
    # === Helper Methods ===
    
    def _calc_overflow(self, event):
        """Calculate overflow for selected troop."""
        troop_name = self.troop_var.get()
        for tid, data in TROOP_DATA.items():
            if data['name'] == troop_name:
                threshold = (INT32_MAX // data['cost']) + 1
                self.overflow_result.set(
                    f"Troop: {data['name']}\n"
                    f"Food Cost: {data['cost']}\n"
                    f"Overflow Threshold: {threshold:,}\n"
                    f"Script: train {data['abbrev']}:{threshold}"
                )
                break
    
    def _start_server(self):
        """Start the script server."""
        if self.server_running:
            return
        
        def run():
            try:
                from evony_hub.server import run_server
                run_server(8088)
            except Exception as e:
                print(f"Server error: {e}")
        
        self.server_thread = threading.Thread(target=run, daemon=True)
        self.server_thread.start()
        
        self.server_running = True
        self.server_status.set("🟢 Server Running (port 8088)")
        self.start_btn.config(state='disabled')
        self.stop_btn.config(state='normal')
        self.status_var.set("Script server started on http://localhost:8088")
    
    def _stop_server(self):
        """Stop the script server (note: thread is daemon, will stop with app)."""
        self.server_running = False
        self.server_status.set("⚫ Server Stopped")
        self.start_btn.config(state='normal')
        self.stop_btn.config(state='disabled')
        self.status_var.set("Server stopped")
    
    def _open_flashbrowser(self):
        """Open FlashBrowser."""
        path = HUB_ROOT / "FlashBrowser" / "FlashBrowser.exe"
        if path.exists():
            subprocess.Popen([str(path)])
            self.status_var.set("FlashBrowser launched")
        else:
            messagebox.showerror("Error", f"FlashBrowser not found at {path}")
    
    def _open_hub_folder(self):
        """Open the hub folder in explorer."""
        subprocess.Popen(['explorer', str(HUB_ROOT)])
    
    def _open_folder(self, path):
        """Open a folder in explorer."""
        if path.exists():
            subprocess.Popen(['explorer', str(path)])
        else:
            messagebox.showwarning("Warning", f"Folder not found: {path}")
    
    def _launch_tool(self, path):
        """Launch an external tool."""
        if not path.exists():
            messagebox.showerror("Error", f"Tool not found: {path}")
            return
        
        if path.suffix == '.py':
            subprocess.Popen(['python', str(path)], cwd=str(path.parent))
        elif path.suffix == '.exe':
            subprocess.Popen([str(path)])
        elif path.suffix == '.bat':
            subprocess.Popen([str(path)], shell=True)
        
        self.status_var.set(f"Launched: {path.name}")
    
    def _copy_to_clipboard(self, text):
        """Copy text to clipboard."""
        self.root.clipboard_clear()
        self.root.clipboard_append(text)
        self.status_var.set(f"Copied: {text[:50]}...")
    
    def _generate_report(self):
        """Generate exploitation report."""
        report = {
            'generated': datetime.now().isoformat(),
            'encryption_keys': ENCRYPTION_KEYS,
            'overflow_thresholds': {
                data['name']: (INT32_MAX // data['cost']) + 1
                for data in TROOP_DATA.values()
            },
        }
        
        path = HUB_ROOT / "evony_hub" / "gui_report.json"
        with open(path, 'w') as f:
            json.dump(report, f, indent=2)
        
        self.status_var.set(f"Report saved to {path}")
        messagebox.showinfo("Report Generated", f"Report saved to:\n{path}")
    
    def run(self):
        """Start the GUI."""
        self.root.mainloop()


def main():
    """Launch the GUI."""
    app = EvonyMasterHub()
    app.run()


if __name__ == "__main__":
    main()
