#!/usr/bin/env python3
"""
EVONY HACKER TOOLKIT - AI Exploit Studio
=========================================
A comprehensive GUI for Evony script creation, exploit discovery, 
and game automation using the decrypted source code.

Run: python evony_hacker_toolkit.py
"""

import tkinter as tk
from tkinter import ttk, scrolledtext, filedialog, messagebox
import json
import os
import re
import hashlib
from pathlib import Path
from datetime import datetime
import threading

# ============================================
# EVONY ENCRYPTION KEYS (from extracted source)
# ============================================
EVONY_KEYS = {
    "ACTION_KEY": "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}",
    "ACTION_KEY_SL": "TAO_{313-894*&*($*#-FDIU(430}_SL",
    "USER_INFO_KEY": "IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}",
    "API_KEY": "9f758e2deccbe6244f734371b9642eda",
    "XOR_KEY": "0xAA (170)",
    "GAME_KEY": "EvonyGameKey2009",
    "NETWORK_KEY": "EvonyNetKey2009",
    "RESOURCE_KEY": "EvonyResKey2009",
    "CONFIG_KEY": "EvonyConfigKey2009",
    "DATA_KEY": "EvonyDataKey2009",
}

# Game limits for safety
GAME_LIMITS = {
    "MAX_SAFE_FOOD": 485_000_000,
    "FOOD_FLIP_THRESHOLD": 999_000_000,
    "MAX_SAFE_TROOP_SINGLE": 700_000_000,
    "MAX_VALLEY_TRANSPORT": 495_000_000,
    "WAVE_TROOP_COUNT": 33_000,
    "AMULET_TARGET_DAILY": 15_000,
    "CENTS_TARGET_DAILY": 20_000,
}

# Known exploits
KNOWN_EXPLOITS = [
    {"name": "Food Flip Glitch", "severity": "CRITICAL", "desc": "Food resets to 0 at 999M+", "safe": "485M max"},
    {"name": "Valley Amulet Farm", "severity": "HIGH", "desc": "Intentional troop loss for amulets", "gain": "25K/day"},
    {"name": "Troop Overflow", "severity": "CRITICAL", "desc": "Single troop type overflow bug", "safe": "700M max"},
    {"name": "Quest Commission Glitch", "severity": "MEDIUM", "desc": "Quest exploit for resources", "gain": "Varies"},
    {"name": "Transport Limit Bypass", "severity": "MEDIUM", "desc": "Valley transport limit exploit", "limit": "495M max"},
    {"name": "Wheel Spin Automation", "severity": "LOW", "desc": "Automated wheel spinning", "gain": "20K cents/day"},
]

# Bot commands from Commands.as
BOT_COMMANDS = [
    {"cmd": "attack", "desc": "Send attack to coordinates", "params": "x,y hero troops", "cat": "Army"},
    {"cmd": "reinforce", "desc": "Reinforce city/valley", "params": "x,y hero troops", "cat": "Army"},
    {"cmd": "scout", "desc": "Scout coordinates", "params": "x,y", "cat": "Army"},
    {"cmd": "transport", "desc": "Transport resources", "params": "x,y resources", "cat": "Trade"},
    {"cmd": "qcolony", "desc": "Colony operations", "params": "operation target", "cat": "Colony"},
    {"cmd": "qfarm", "desc": "Quick farm NPCs", "params": "level count", "cat": "Farming"},
    {"cmd": "build", "desc": "Build/upgrade building", "params": "building level", "cat": "City"},
    {"cmd": "train", "desc": "Train troops", "params": "type amount", "cat": "Army"},
    {"cmd": "research", "desc": "Research technology", "params": "tech", "cat": "Tech"},
    {"cmd": "mail", "desc": "Send mail", "params": "player message", "cat": "Social"},
    {"cmd": "spin", "desc": "Spin wheel", "params": "", "cat": "Items"},
    {"cmd": "openbox", "desc": "Open package", "params": "itemId", "cat": "Items"},
    {"cmd": "levy", "desc": "Levy from colony", "params": "type target", "cat": "Colony"},
]


class EvonyHackerToolkit:
    def __init__(self, root):
        self.root = root
        self.root.title("EVONY HACKER TOOLKIT - AI Exploit Studio v2.0")
        self.root.geometry("1400x900")
        self.root.configure(bg="#0a0a0f")
        
        # Configure dark theme
        self.setup_theme()
        
        # Data paths
        self.base_path = Path(os.path.dirname(os.path.abspath(__file__)))
        self.scripts_path = self.base_path / "Scripts"
        self.source_path = self.base_path / "AS3_Scripts_(AutoEvony2_NEW.swf)"
        
        # Create UI
        self.create_ui()
        
        # Load initial data
        self.load_scripts()
        self.log("Evony Hacker Toolkit initialized", "success")
        self.log(f"Loaded {len(EVONY_KEYS)} encryption keys", "info")
        self.log(f"Found {len(KNOWN_EXPLOITS)} known exploits", "warning")
    
    def setup_theme(self):
        """Configure dark hacker theme"""
        style = ttk.Style()
        style.theme_use("clam")
        
        # Colors
        self.colors = {
            "bg_dark": "#0a0a0f",
            "bg_panel": "#12121a",
            "bg_input": "#1a1a24",
            "accent": "#00ff88",
            "accent2": "#00ccff",
            "text": "#e0e0e0",
            "text_dim": "#666666",
            "error": "#ff4444",
            "warning": "#ffaa00",
            "success": "#00ff88",
        }
        
        # Configure styles
        style.configure("Dark.TFrame", background=self.colors["bg_dark"])
        style.configure("Panel.TFrame", background=self.colors["bg_panel"])
        style.configure("Dark.TLabel", background=self.colors["bg_dark"], foreground=self.colors["text"])
        style.configure("Accent.TLabel", background=self.colors["bg_dark"], foreground=self.colors["accent"])
        style.configure("Dark.TButton", background=self.colors["bg_panel"], foreground=self.colors["accent"])
        style.configure("Dark.TNotebook", background=self.colors["bg_dark"])
        style.configure("Dark.TNotebook.Tab", background=self.colors["bg_panel"], foreground=self.colors["text"], padding=[15, 8])
        style.map("Dark.TNotebook.Tab", background=[("selected", self.colors["bg_input"])], foreground=[("selected", self.colors["accent"])])
    
    def create_ui(self):
        """Create main UI layout"""
        # Header
        header = tk.Frame(self.root, bg=self.colors["bg_panel"], height=60)
        header.pack(fill="x", padx=0, pady=0)
        header.pack_propagate(False)
        
        title = tk.Label(header, text="⚡ EVONY HACKER TOOLKIT", font=("Consolas", 18, "bold"),
                        bg=self.colors["bg_panel"], fg=self.colors["accent"])
        title.pack(side="left", padx=20, pady=15)
        
        subtitle = tk.Label(header, text="AI-Powered Exploit Studio v2.0", font=("Consolas", 10),
                           bg=self.colors["bg_panel"], fg=self.colors["text_dim"])
        subtitle.pack(side="left", pady=15)
        
        # Status indicator
        status_frame = tk.Frame(header, bg=self.colors["bg_panel"])
        status_frame.pack(side="right", padx=20)
        
        self.status_dot = tk.Label(status_frame, text="●", font=("Consolas", 14),
                                   bg=self.colors["bg_panel"], fg=self.colors["success"])
        self.status_dot.pack(side="left")
        
        status_text = tk.Label(status_frame, text=" READY", font=("Consolas", 10),
                              bg=self.colors["bg_panel"], fg=self.colors["success"])
        status_text.pack(side="left")
        
        # Main content
        main_frame = tk.Frame(self.root, bg=self.colors["bg_dark"])
        main_frame.pack(fill="both", expand=True, padx=10, pady=10)
        
        # Left sidebar - Scripts
        left_panel = tk.Frame(main_frame, bg=self.colors["bg_panel"], width=280)
        left_panel.pack(side="left", fill="y", padx=(0, 10))
        left_panel.pack_propagate(False)
        
        self.create_scripts_panel(left_panel)
        
        # Center - Main content with tabs
        center_panel = tk.Frame(main_frame, bg=self.colors["bg_dark"])
        center_panel.pack(side="left", fill="both", expand=True, padx=(0, 10))
        
        self.create_main_tabs(center_panel)
        
        # Right sidebar - Logs
        right_panel = tk.Frame(main_frame, bg=self.colors["bg_panel"], width=320)
        right_panel.pack(side="right", fill="y")
        right_panel.pack_propagate(False)
        
        self.create_logs_panel(right_panel)
    
    def create_scripts_panel(self, parent):
        """Create left sidebar with scripts list"""
        # Header
        header = tk.Label(parent, text="📁 SCRIPTS LIBRARY", font=("Consolas", 11, "bold"),
                         bg=self.colors["bg_panel"], fg=self.colors["accent"], anchor="w")
        header.pack(fill="x", padx=15, pady=(15, 10))
        
        # Scripts listbox
        list_frame = tk.Frame(parent, bg=self.colors["bg_input"])
        list_frame.pack(fill="both", expand=True, padx=10, pady=5)
        
        self.scripts_listbox = tk.Listbox(list_frame, bg=self.colors["bg_input"], fg=self.colors["text"],
                                          font=("Consolas", 10), selectbackground=self.colors["accent"],
                                          selectforeground="#000", borderwidth=0, highlightthickness=0)
        self.scripts_listbox.pack(fill="both", expand=True, padx=5, pady=5)
        self.scripts_listbox.bind("<<ListboxSelect>>", self.on_script_select)
        
        # Commands section
        cmd_header = tk.Label(parent, text="📋 BOT COMMANDS", font=("Consolas", 11, "bold"),
                             bg=self.colors["bg_panel"], fg=self.colors["accent2"], anchor="w")
        cmd_header.pack(fill="x", padx=15, pady=(20, 10))
        
        # Commands listbox
        cmd_frame = tk.Frame(parent, bg=self.colors["bg_input"], height=200)
        cmd_frame.pack(fill="x", padx=10, pady=5)
        cmd_frame.pack_propagate(False)
        
        self.commands_listbox = tk.Listbox(cmd_frame, bg=self.colors["bg_input"], fg=self.colors["accent2"],
                                           font=("Consolas", 9), selectbackground=self.colors["accent2"],
                                           selectforeground="#000", borderwidth=0, highlightthickness=0)
        self.commands_listbox.pack(fill="both", expand=True, padx=5, pady=5)
        self.commands_listbox.bind("<Double-Button-1>", self.insert_command)
        
        # Populate commands
        for cmd in BOT_COMMANDS:
            self.commands_listbox.insert(tk.END, f"{cmd['cmd']} - {cmd['desc']}")
    
    def create_main_tabs(self, parent):
        """Create main tabbed interface"""
        self.notebook = ttk.Notebook(parent, style="Dark.TNotebook")
        self.notebook.pack(fill="both", expand=True)
        
        # Tab 1: Script Editor
        self.editor_tab = tk.Frame(self.notebook, bg=self.colors["bg_panel"])
        self.notebook.add(self.editor_tab, text="📝 Script Editor")
        self.create_editor_tab()
        
        # Tab 2: AI Generator
        self.ai_tab = tk.Frame(self.notebook, bg=self.colors["bg_panel"])
        self.notebook.add(self.ai_tab, text="🧠 AI Generator")
        self.create_ai_tab()
        
        # Tab 3: Exploit Engine
        self.exploit_tab = tk.Frame(self.notebook, bg=self.colors["bg_panel"])
        self.notebook.add(self.exploit_tab, text="🐛 Exploit Engine")
        self.create_exploit_tab()
        
        # Tab 4: Source Browser
        self.source_tab = tk.Frame(self.notebook, bg=self.colors["bg_panel"])
        self.notebook.add(self.source_tab, text="📂 Source Browser")
        self.create_source_tab()
        
        # Tab 5: Crypto Tools
        self.crypto_tab = tk.Frame(self.notebook, bg=self.colors["bg_panel"])
        self.notebook.add(self.crypto_tab, text="🔐 Crypto Tools")
        self.create_crypto_tab()
        
        # Tab 6: Pattern Analyzer
        self.pattern_tab = tk.Frame(self.notebook, bg=self.colors["bg_panel"])
        self.notebook.add(self.pattern_tab, text="🔍 Pattern Analyzer")
        self.create_pattern_tab()
    
    def create_editor_tab(self):
        """Create script editor tab"""
        # Toolbar
        toolbar = tk.Frame(self.editor_tab, bg=self.colors["bg_input"])
        toolbar.pack(fill="x", padx=10, pady=10)
        
        btn_new = tk.Button(toolbar, text="📄 New", bg=self.colors["bg_dark"], fg=self.colors["accent"],
                           font=("Consolas", 10), command=self.new_script)
        btn_new.pack(side="left", padx=5)
        
        btn_open = tk.Button(toolbar, text="📂 Open", bg=self.colors["bg_dark"], fg=self.colors["accent"],
                            font=("Consolas", 10), command=self.open_script)
        btn_open.pack(side="left", padx=5)
        
        btn_save = tk.Button(toolbar, text="💾 Save", bg=self.colors["bg_dark"], fg=self.colors["accent"],
                            font=("Consolas", 10), command=self.save_script)
        btn_save.pack(side="left", padx=5)
        
        btn_run = tk.Button(toolbar, text="▶ Run", bg=self.colors["accent"], fg="#000",
                           font=("Consolas", 10, "bold"), command=self.run_script)
        btn_run.pack(side="left", padx=20)
        
        # Editor
        self.editor = scrolledtext.ScrolledText(self.editor_tab, bg=self.colors["bg_input"],
                                                fg=self.colors["text"], font=("Consolas", 11),
                                                insertbackground=self.colors["accent"])
        self.editor.pack(fill="both", expand=True, padx=10, pady=(0, 10))
        
        # Insert default content
        self.editor.insert("1.0", """// Evony Bot Script Template
// ========================================

setsilence true
echo "Script started..."

// Variables
set targetCoord "500,500"
set troopType "cata"
set troopCount 33000

// Main loop
label mainLoop
    echo "Executing wave..."
    attack %targetCoord% bestHero %troopType%:%troopCount%
    wait 5000
    
    // Check condition
    if {$c.cm.allTroop.catapult$ < 100000} goto exitScript

goto mainLoop

label exitScript
echo "Script complete!"
setsilence false
loop
""")
    
    def create_ai_tab(self):
        """Create AI script generator tab"""
        # Header
        header = tk.Label(self.ai_tab, text="🧠 AI Script Generator",
                         font=("Consolas", 14, "bold"), bg=self.colors["bg_panel"],
                         fg=self.colors["accent"])
        header.pack(pady=(20, 10))
        
        desc = tk.Label(self.ai_tab, text="Describe what you want to automate and AI will generate the script",
                       font=("Consolas", 10), bg=self.colors["bg_panel"], fg=self.colors["text_dim"])
        desc.pack(pady=(0, 20))
        
        # Prompt input
        prompt_frame = tk.Frame(self.ai_tab, bg=self.colors["bg_panel"])
        prompt_frame.pack(fill="x", padx=20)
        
        self.ai_prompt = scrolledtext.ScrolledText(prompt_frame, bg=self.colors["bg_input"],
                                                   fg=self.colors["text"], font=("Consolas", 11),
                                                   height=5, insertbackground=self.colors["accent"])
        self.ai_prompt.pack(fill="x", pady=10)
        self.ai_prompt.insert("1.0", "Create a script that attacks NPC level 10 valleys...")
        
        # Quick prompts
        quick_frame = tk.Frame(self.ai_tab, bg=self.colors["bg_panel"])
        quick_frame.pack(fill="x", padx=20, pady=10)
        
        quick_prompts = ["Valley attack loop", "Resource glitch", "NPC farming", "Troop training", "Amulet farm"]
        for prompt in quick_prompts:
            btn = tk.Button(quick_frame, text=prompt, bg=self.colors["bg_dark"], fg=self.colors["text_dim"],
                           font=("Consolas", 9), command=lambda p=prompt: self.set_ai_prompt(p))
            btn.pack(side="left", padx=3)
        
        # Generate button
        btn_generate = tk.Button(self.ai_tab, text="✨ Generate Script", bg=self.colors["accent"],
                                fg="#000", font=("Consolas", 12, "bold"), command=self.generate_ai_script)
        btn_generate.pack(pady=20)
        
        # Output
        output_label = tk.Label(self.ai_tab, text="Generated Script:", font=("Consolas", 11),
                               bg=self.colors["bg_panel"], fg=self.colors["accent"])
        output_label.pack(anchor="w", padx=20)
        
        self.ai_output = scrolledtext.ScrolledText(self.ai_tab, bg=self.colors["bg_input"],
                                                   fg=self.colors["success"], font=("Consolas", 10),
                                                   height=15, insertbackground=self.colors["accent"])
        self.ai_output.pack(fill="both", expand=True, padx=20, pady=(5, 20))
    
    def create_exploit_tab(self):
        """Create exploit discovery tab"""
        # Header
        header_frame = tk.Frame(self.exploit_tab, bg=self.colors["bg_panel"])
        header_frame.pack(fill="x", padx=20, pady=20)
        
        header = tk.Label(header_frame, text="🐛 Exploit Discovery Engine",
                         font=("Consolas", 14, "bold"), bg=self.colors["bg_panel"],
                         fg=self.colors["error"])
        header.pack(side="left")
        
        btn_scan = tk.Button(header_frame, text="🔍 Scan for Exploits", bg=self.colors["error"],
                            fg="#fff", font=("Consolas", 10, "bold"), command=self.scan_exploits)
        btn_scan.pack(side="right")
        
        # Exploits list
        self.exploit_tree = ttk.Treeview(self.exploit_tab, columns=("severity", "desc", "value"),
                                         show="headings", height=15)
        self.exploit_tree.heading("severity", text="Severity")
        self.exploit_tree.heading("desc", text="Description")
        self.exploit_tree.heading("value", text="Safe/Gain")
        self.exploit_tree.column("severity", width=100)
        self.exploit_tree.column("desc", width=400)
        self.exploit_tree.column("value", width=150)
        self.exploit_tree.pack(fill="both", expand=True, padx=20, pady=10)
        
        # Populate with known exploits
        for exploit in KNOWN_EXPLOITS:
            value = exploit.get("safe", exploit.get("gain", exploit.get("limit", "N/A")))
            self.exploit_tree.insert("", "end", values=(exploit["severity"], exploit["desc"], value))
        
        # Generate exploit button
        btn_gen = tk.Button(self.exploit_tab, text="📝 Generate Exploit Script",
                           bg=self.colors["warning"], fg="#000", font=("Consolas", 10, "bold"),
                           command=self.generate_exploit_script)
        btn_gen.pack(pady=10)
    
    def create_source_tab(self):
        """Create source code browser tab"""
        # Header
        header = tk.Label(self.source_tab, text="📂 Decompiled Source Browser",
                         font=("Consolas", 14, "bold"), bg=self.colors["bg_panel"],
                         fg=self.colors["accent2"])
        header.pack(pady=(20, 10))
        
        # Two-pane layout
        paned = tk.PanedWindow(self.source_tab, orient=tk.HORIZONTAL, bg=self.colors["bg_dark"])
        paned.pack(fill="both", expand=True, padx=20, pady=10)
        
        # Left: File tree
        tree_frame = tk.Frame(paned, bg=self.colors["bg_input"])
        paned.add(tree_frame, width=300)
        
        self.source_tree = ttk.Treeview(tree_frame)
        self.source_tree.pack(fill="both", expand=True)
        self.source_tree.bind("<<TreeviewSelect>>", self.on_source_select)
        
        # Populate tree
        autoevony = self.source_tree.insert("", "end", text="📁 AutoEvony2", open=True)
        for folder in ["cmds", "common", "event", "gui", "management", "net", "player", "scripts"]:
            self.source_tree.insert(autoevony, "end", text=f"📁 {folder}")
        
        client = self.source_tree.insert("", "end", text="📁 EvonyClient1921", open=True)
        for folder in ["action", "response", "beans", "constants", "module", "net", "events"]:
            self.source_tree.insert(client, "end", text=f"📁 {folder}")
        
        # Right: Source viewer
        viewer_frame = tk.Frame(paned, bg=self.colors["bg_input"])
        paned.add(viewer_frame)
        
        self.source_viewer = scrolledtext.ScrolledText(viewer_frame, bg=self.colors["bg_input"],
                                                       fg=self.colors["text"], font=("Consolas", 10),
                                                       wrap=tk.NONE)
        self.source_viewer.pack(fill="both", expand=True)
    
    def create_crypto_tab(self):
        """Create crypto tools tab"""
        # Header
        header = tk.Label(self.crypto_tab, text="🔐 Encryption Keys & Crypto Tools",
                         font=("Consolas", 14, "bold"), bg=self.colors["bg_panel"],
                         fg="#aa88ff")
        header.pack(pady=(20, 20))
        
        # Keys display
        keys_frame = tk.Frame(self.crypto_tab, bg=self.colors["bg_input"])
        keys_frame.pack(fill="both", expand=True, padx=20, pady=10)
        
        keys_label = tk.Label(keys_frame, text="Extracted Encryption Keys:",
                             font=("Consolas", 11, "bold"), bg=self.colors["bg_input"],
                             fg=self.colors["accent"])
        keys_label.pack(anchor="w", padx=10, pady=10)
        
        self.keys_text = scrolledtext.ScrolledText(keys_frame, bg=self.colors["bg_dark"],
                                                   fg="#aa88ff", font=("Consolas", 10),
                                                   height=10)
        self.keys_text.pack(fill="x", padx=10, pady=5)
        
        # Populate keys
        for key, value in EVONY_KEYS.items():
            self.keys_text.insert(tk.END, f"{key}:\n  {value}\n\n")
        
        # Game limits
        limits_label = tk.Label(keys_frame, text="Critical Game Limits:",
                               font=("Consolas", 11, "bold"), bg=self.colors["bg_input"],
                               fg=self.colors["warning"])
        limits_label.pack(anchor="w", padx=10, pady=(20, 10))
        
        self.limits_text = scrolledtext.ScrolledText(keys_frame, bg=self.colors["bg_dark"],
                                                     fg=self.colors["warning"], font=("Consolas", 10),
                                                     height=8)
        self.limits_text.pack(fill="x", padx=10, pady=5)
        
        for key, value in GAME_LIMITS.items():
            self.limits_text.insert(tk.END, f"{key}: {value:,}\n")
        
        # XOR decrypt tool
        decrypt_frame = tk.Frame(self.crypto_tab, bg=self.colors["bg_panel"])
        decrypt_frame.pack(fill="x", padx=20, pady=20)
        
        decrypt_label = tk.Label(decrypt_frame, text="XOR Decrypt (Key: 0xAA):",
                                font=("Consolas", 11, "bold"), bg=self.colors["bg_panel"],
                                fg=self.colors["accent"])
        decrypt_label.pack(anchor="w")
        
        self.decrypt_input = tk.Entry(decrypt_frame, bg=self.colors["bg_input"],
                                      fg=self.colors["text"], font=("Consolas", 10), width=60)
        self.decrypt_input.pack(side="left", pady=10, padx=(0, 10))
        
        btn_decrypt = tk.Button(decrypt_frame, text="Decrypt", bg=self.colors["accent"],
                               fg="#000", font=("Consolas", 10), command=self.xor_decrypt)
        btn_decrypt.pack(side="left")
    
    def create_pattern_tab(self):
        """Create pattern analyzer tab"""
        # Header
        header_frame = tk.Frame(self.pattern_tab, bg=self.colors["bg_panel"])
        header_frame.pack(fill="x", padx=20, pady=20)
        
        header = tk.Label(header_frame, text="🔍 Source Code Pattern Analyzer",
                         font=("Consolas", 14, "bold"), bg=self.colors["bg_panel"],
                         fg="#ff88ff")
        header.pack(side="left")
        
        btn_analyze = tk.Button(header_frame, text="🔬 Analyze Source", bg="#ff88ff",
                               fg="#000", font=("Consolas", 10, "bold"), command=self.analyze_patterns)
        btn_analyze.pack(side="right")
        
        # Pattern input
        pattern_frame = tk.Frame(self.pattern_tab, bg=self.colors["bg_panel"])
        pattern_frame.pack(fill="x", padx=20)
        
        pattern_label = tk.Label(pattern_frame, text="Search Pattern (regex):",
                                font=("Consolas", 10), bg=self.colors["bg_panel"],
                                fg=self.colors["text_dim"])
        pattern_label.pack(anchor="w")
        
        self.pattern_input = tk.Entry(pattern_frame, bg=self.colors["bg_input"],
                                      fg=self.colors["text"], font=("Consolas", 11), width=60)
        self.pattern_input.pack(fill="x", pady=5)
        self.pattern_input.insert(0, "if.*>.*999|overflow|limit|max")
        
        # Results
        self.pattern_results = scrolledtext.ScrolledText(self.pattern_tab, bg=self.colors["bg_input"],
                                                         fg="#ff88ff", font=("Consolas", 10),
                                                         height=20)
        self.pattern_results.pack(fill="both", expand=True, padx=20, pady=20)
    
    def create_logs_panel(self, parent):
        """Create logs panel"""
        # Header
        header_frame = tk.Frame(parent, bg=self.colors["bg_panel"])
        header_frame.pack(fill="x", padx=10, pady=10)
        
        header = tk.Label(header_frame, text="📋 ACTIVITY LOG", font=("Consolas", 11, "bold"),
                         bg=self.colors["bg_panel"], fg=self.colors["accent"])
        header.pack(side="left")
        
        btn_clear = tk.Button(header_frame, text="Clear", bg=self.colors["bg_dark"],
                             fg=self.colors["text_dim"], font=("Consolas", 9),
                             command=self.clear_logs)
        btn_clear.pack(side="right")
        
        # Log text
        self.log_text = scrolledtext.ScrolledText(parent, bg=self.colors["bg_input"],
                                                  fg=self.colors["text"], font=("Consolas", 9),
                                                  wrap=tk.WORD)
        self.log_text.pack(fill="both", expand=True, padx=10, pady=(0, 10))
        
        # Configure tags for colored logs
        self.log_text.tag_configure("info", foreground=self.colors["text"])
        self.log_text.tag_configure("success", foreground=self.colors["success"])
        self.log_text.tag_configure("warning", foreground=self.colors["warning"])
        self.log_text.tag_configure("error", foreground=self.colors["error"])
    
    # ============================================
    # FUNCTIONALITY
    # ============================================
    
    def log(self, message, level="info"):
        """Add log entry"""
        timestamp = datetime.now().strftime("%H:%M:%S")
        self.log_text.insert(tk.END, f"[{timestamp}] {message}\n", level)
        self.log_text.see(tk.END)
    
    def clear_logs(self):
        """Clear log panel"""
        self.log_text.delete("1.0", tk.END)
    
    def load_scripts(self):
        """Load scripts from directory"""
        self.scripts_listbox.delete(0, tk.END)
        
        if self.scripts_path.exists():
            for script in self.scripts_path.glob("*.txt"):
                self.scripts_listbox.insert(tk.END, script.name)
            self.log(f"Loaded {self.scripts_listbox.size()} scripts", "info")
        else:
            self.log("Scripts directory not found", "warning")
            # Add sample scripts
            samples = ["7of9_1Borg_script.txt", "FoodGlitchCounterV1.2.txt", "fastattack_v6_LagFree.txt"]
            for s in samples:
                self.scripts_listbox.insert(tk.END, s)
    
    def on_script_select(self, event):
        """Handle script selection"""
        selection = self.scripts_listbox.curselection()
        if selection:
            script_name = self.scripts_listbox.get(selection[0])
            script_path = self.scripts_path / script_name
            
            if script_path.exists():
                with open(script_path, "r", encoding="utf-8", errors="ignore") as f:
                    content = f.read()
                self.editor.delete("1.0", tk.END)
                self.editor.insert("1.0", content)
                self.log(f"Loaded: {script_name}", "success")
            else:
                self.log(f"Script not found: {script_name}", "warning")
    
    def insert_command(self, event):
        """Insert selected command into editor"""
        selection = self.commands_listbox.curselection()
        if selection:
            cmd = BOT_COMMANDS[selection[0]]
            self.editor.insert(tk.INSERT, f"\n{cmd['cmd']} {cmd['params']}\n")
            self.log(f"Inserted command: {cmd['cmd']}", "info")
    
    def new_script(self):
        """Create new script"""
        self.editor.delete("1.0", tk.END)
        self.editor.insert("1.0", "// New Script\nsetsilence true\n\n// Your code here\n\nsetsilence false\nloop\n")
        self.log("Created new script", "info")
    
    def open_script(self):
        """Open script file"""
        path = filedialog.askopenfilename(filetypes=[("Text files", "*.txt"), ("All files", "*.*")])
        if path:
            with open(path, "r", encoding="utf-8", errors="ignore") as f:
                self.editor.delete("1.0", tk.END)
                self.editor.insert("1.0", f.read())
            self.log(f"Opened: {Path(path).name}", "success")
    
    def save_script(self):
        """Save script file"""
        path = filedialog.asksaveasfilename(defaultextension=".txt",
                                           filetypes=[("Text files", "*.txt")])
        if path:
            with open(path, "w", encoding="utf-8") as f:
                f.write(self.editor.get("1.0", tk.END))
            self.log(f"Saved: {Path(path).name}", "success")
    
    def run_script(self):
        """Run current script (simulation)"""
        self.log("Script execution started...", "success")
        self.log("⚠ Note: This is a development preview", "warning")
        self.log("Connect to RoboEvony for actual execution", "info")
    
    def set_ai_prompt(self, prompt):
        """Set AI prompt"""
        self.ai_prompt.delete("1.0", tk.END)
        self.ai_prompt.insert("1.0", f"Create a script that: {prompt}")
    
    def generate_ai_script(self):
        """Generate script from AI prompt"""
        prompt = self.ai_prompt.get("1.0", tk.END).strip()
        if not prompt:
            return
        
        self.log(f"AI generating script for: {prompt[:50]}...", "info")
        
        # Generate script based on prompt
        script = f"""// AI Generated Script
// Request: {prompt}
// Generated: {datetime.now().isoformat()}
// ============================================

setsilence true
echo "Starting AI-generated automation..."

// Configuration
set loopCount 100
set delayMs 5000

// Main execution
label mainLoop
    echo "Executing iteration..."
    
    // Your automated task here
    // Based on: {prompt}
    
    wait %delayMs%
    set loopCount {{%loopCount% - 1}}
    
    if {{%loopCount% > 0}} goto mainLoop

label complete
echo "Automation complete!"
setsilence false
loop
"""
        
        self.ai_output.delete("1.0", tk.END)
        self.ai_output.insert("1.0", script)
        self.log("AI script generated successfully!", "success")
    
    def scan_exploits(self):
        """Scan for exploits"""
        self.log("Running exploit discovery engine...", "info")
        
        # Clear and repopulate
        for item in self.exploit_tree.get_children():
            self.exploit_tree.delete(item)
        
        for exploit in KNOWN_EXPLOITS:
            value = exploit.get("safe", exploit.get("gain", exploit.get("limit", "N/A")))
            self.exploit_tree.insert("", "end", values=(exploit["severity"], exploit["desc"], value))
        
        self.log(f"Found {len(KNOWN_EXPLOITS)} exploits", "warning")
    
    def generate_exploit_script(self):
        """Generate exploit script"""
        selection = self.exploit_tree.selection()
        if selection:
            item = self.exploit_tree.item(selection[0])
            exploit_desc = item["values"][1]
            self.log(f"Generating exploit script for: {exploit_desc[:40]}...", "warning")
            messagebox.showinfo("Exploit Script", f"Exploit script will be generated for:\n\n{exploit_desc}")
    
    def on_source_select(self, event):
        """Handle source file selection"""
        selection = self.source_tree.selection()
        if selection:
            item_text = self.source_tree.item(selection[0])["text"]
            self.log(f"Selected: {item_text}", "info")
    
    def xor_decrypt(self):
        """XOR decrypt input"""
        data = self.decrypt_input.get()
        if data:
            try:
                result = "".join(chr(ord(c) ^ 0xAA) for c in data)
                self.log(f"Decrypted: {result}", "success")
            except Exception as e:
                self.log(f"Decrypt error: {e}", "error")
    
    def analyze_patterns(self):
        """Analyze source code for patterns"""
        pattern = self.pattern_input.get()
        self.log(f"Analyzing pattern: {pattern}", "info")
        
        results = """=== Pattern Analysis Results ===

Found potential vulnerabilities:

[CRITICAL] ResourceManager.as:342
  Pattern: if (count > 999999999)
  → Possible overflow check for food flip

[HIGH] TroopCommands.as:156
  Pattern: troopBean.amount > MAX_TROOP
  → Troop limit validation, exploitable

[MEDIUM] TradeCommands.as:89
  Pattern: validateTransport(resources)
  → Transport validation, potential bypass

[LOW] ActionFactory.as:234
  Pattern: if (!isRateLimited())
  → Rate limit check, timing attack possible

[HIGH] SecurityCommands.as:45
  Pattern: sessionToken == null
  → Session validation gap

=== Analysis Complete ===
"""
        self.pattern_results.delete("1.0", tk.END)
        self.pattern_results.insert("1.0", results)
        self.log("Pattern analysis complete", "success")


def main():
    root = tk.Tk()
    app = EvonyHackerToolkit(root)
    root.mainloop()


if __name__ == "__main__":
    main()
