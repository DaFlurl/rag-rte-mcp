#!/usr/bin/env python3
"""
AutoEvony UI Clone - Exact 1:1 replica of the AutoEvony interface
Dark blue theme with orange gradient buttons, resource tables, script editor, chat panel
"""

import tkinter as tk
from tkinter import ttk, filedialog, messagebox
from datetime import datetime
import json
import threading
import time

# ============== EXACT AUTOEVONY COLORS ==============
COLORS = {
    # Backgrounds
    'bg_main': '#0A0E14',           # Main dark background
    'bg_header': '#141B24',         # Header/toolbar background
    'bg_panel': '#0D1219',          # Panel backgrounds
    'bg_input': '#0A0E14',          # Input field background
    'bg_table': '#0D1219',          # Table background
    'bg_table_alt': '#111820',      # Alternating row
    'bg_table_header': '#1A2430',   # Table header
    
    # Text
    'text_primary': '#E6E6E6',      # Primary text
    'text_secondary': '#A0A8B0',    # Secondary/dim text
    'text_gold': '#FFD700',         # Gold text for names
    'text_green': '#00FF00',        # Green for positive values
    'text_red': '#FF4444',          # Red for negative/alerts
    'text_cyan': '#00BFFF',         # Cyan for links/highlights
    'text_yellow': '#FFFF00',       # Yellow for warnings
    'text_orange': '#FFA500',       # Orange for commands
    
    # Buttons
    'btn_orange_light': '#FFB31A',  # Orange button gradient start
    'btn_orange_dark': '#FF9F00',   # Orange button gradient end
    'btn_blue': '#1E3A5F',          # Blue button
    'btn_hover': '#2A4A70',         # Button hover
    
    # Borders
    'border_dark': '#1A2430',       # Dark border
    'border_light': '#2A3A4A',      # Light border
    'border_gold': '#8B7355',       # Gold/bronze border
    
    # Tab colors
    'tab_active': '#1E3A5F',        # Active tab
    'tab_inactive': '#141B24',      # Inactive tab
    
    # Banner
    'banner_red': '#8B0000',        # Red banner background
    'banner_gold': '#FFD700',       # Gold banner text
}

class AutoEvonyClone:
    def __init__(self, root):
        self.root = root
        self.root.title("RoboEvony - AI Assistant")
        self.root.geometry("1280x800")
        self.root.configure(bg=COLORS['bg_main'])
        self.root.minsize(1024, 600)
        
        # Configure styles
        self.setup_styles()
        
        # Create main layout
        self.create_header()
        self.create_city_tabs()
        self.create_main_content()
        self.create_bottom_tabs()
        self.create_status_bar()
        
        # Start update loop
        self.start_updates()
    
    def setup_styles(self):
        """Configure ttk styles for AutoEvony look"""
        style = ttk.Style()
        style.theme_use('clam')
        
        # Frame styles
        style.configure('Dark.TFrame', background=COLORS['bg_main'])
        style.configure('Header.TFrame', background=COLORS['bg_header'])
        style.configure('Panel.TFrame', background=COLORS['bg_panel'])
        
        # Label styles
        style.configure('Dark.TLabel', 
                       background=COLORS['bg_main'],
                       foreground=COLORS['text_primary'],
                       font=('Arial', 9))
        style.configure('Gold.TLabel',
                       background=COLORS['bg_main'],
                       foreground=COLORS['text_gold'],
                       font=('Arial', 10, 'bold'))
        style.configure('Header.TLabel',
                       background=COLORS['bg_header'],
                       foreground=COLORS['text_primary'],
                       font=('Arial', 9))
        
        # Button styles
        style.configure('Orange.TButton',
                       background=COLORS['btn_orange_light'],
                       foreground='black',
                       font=('Arial', 9, 'bold'),
                       borderwidth=1)
        style.map('Orange.TButton',
                 background=[('active', COLORS['btn_orange_dark'])])
        
        style.configure('Blue.TButton',
                       background=COLORS['btn_blue'],
                       foreground=COLORS['text_primary'],
                       font=('Arial', 9),
                       borderwidth=1)
        style.map('Blue.TButton',
                 background=[('active', COLORS['btn_hover'])])
        
        # Notebook (tabs) style
        style.configure('Dark.TNotebook',
                       background=COLORS['bg_main'],
                       borderwidth=0)
        style.configure('Dark.TNotebook.Tab',
                       background=COLORS['tab_inactive'],
                       foreground=COLORS['text_primary'],
                       padding=[10, 2],
                       font=('Arial', 9))
        style.map('Dark.TNotebook.Tab',
                 background=[('selected', COLORS['tab_active'])],
                 foreground=[('selected', COLORS['text_gold'])])
    
    def create_header(self):
        """Create the top header with player info and resources"""
        header = tk.Frame(self.root, bg=COLORS['bg_header'], height=60)
        header.pack(fill=tk.X, side=tk.TOP)
        header.pack_propagate(False)
        
        # Left side - Player banner
        banner_frame = tk.Frame(header, bg=COLORS['banner_red'], 
                               highlightbackground=COLORS['border_gold'],
                               highlightthickness=2)
        banner_frame.pack(side=tk.LEFT, padx=10, pady=5)
        
        # Player name with gold text
        player_name = tk.Label(banner_frame, text="  CrazyKiwi  ",
                              bg=COLORS['banner_red'],
                              fg=COLORS['banner_gold'],
                              font=('Times New Roman', 14, 'bold italic'))
        player_name.pack(padx=20, pady=5)
        
        # Center - Server/Stats info
        stats_frame = tk.Frame(header, bg=COLORS['bg_header'])
        stats_frame.pack(side=tk.LEFT, padx=20, fill=tk.X, expand=True)
        
        # Stats row
        stats = [
            ("🏰", "Parapet (cc2)", COLORS['text_cyan']),
            ("💰", "1227", COLORS['text_gold']),
            ("🪙", "24,800,339", COLORS['text_gold']),
            ("⚔️", "General", COLORS['text_primary']),
            ("👥", "870", COLORS['text_primary']),
            ("🏆", "Member", COLORS['text_primary']),
            ("💎", "574,612,500", COLORS['text_cyan']),
            ("👑", "Prinzessin", COLORS['text_gold']),
        ]
        
        for icon, value, color in stats:
            frame = tk.Frame(stats_frame, bg=COLORS['bg_header'])
            frame.pack(side=tk.LEFT, padx=8)
            tk.Label(frame, text=f"{icon} {value}", bg=COLORS['bg_header'],
                    fg=color, font=('Arial', 9)).pack()
        
        # Right side - Time and buttons
        right_frame = tk.Frame(header, bg=COLORS['bg_header'])
        right_frame.pack(side=tk.RIGHT, padx=10)
        
        # Time display
        self.time_label = tk.Label(right_frame, text="04:34:52",
                                   bg=COLORS['bg_header'],
                                   fg=COLORS['text_gold'],
                                   font=('Arial', 18, 'bold'))
        self.time_label.pack(side=tk.RIGHT, padx=10)
        
        # Control buttons
        for btn_text in ["Logout", "Refresh", "Pause"]:
            btn = tk.Button(right_frame, text=btn_text,
                          bg=COLORS['btn_blue'],
                          fg=COLORS['text_primary'],
                          font=('Arial', 8),
                          relief='raised',
                          borderwidth=1)
            btn.pack(side=tk.RIGHT, padx=2)
    
    def create_city_tabs(self):
        """Create city selection tabs"""
        tab_bar = tk.Frame(self.root, bg=COLORS['bg_header'], height=28)
        tab_bar.pack(fill=tk.X)
        tab_bar.pack_propagate(False)
        
        # City tabs
        cities = [
            ("ALL(784,792)", True),
            ("ano(781,794)", False),
            ("Cum(785,793)", False),
            ("DFW(785,791)", False),
            ("hi(787,793)", False),
            ("nex(785,794)", False),
            ("THE(786,796)", False),
            ("tro(786,798)", False),
            ("Wic(786,794)", False),
        ]
        
        for city, active in cities:
            bg = COLORS['tab_active'] if active else COLORS['tab_inactive']
            fg = COLORS['text_gold'] if active else COLORS['text_primary']
            
            tab = tk.Label(tab_bar, text=city,
                          bg=bg, fg=fg,
                          font=('Arial', 9),
                          padx=8, pady=4,
                          relief='raised' if active else 'flat',
                          borderwidth=1)
            tab.pack(side=tk.LEFT, padx=1)
            tab.bind('<Button-1>', lambda e, t=tab: self.select_city_tab(t))
    
    def select_city_tab(self, tab):
        """Handle city tab selection"""
        pass
    
    def create_main_content(self):
        """Create the main content area with script editor, resource table, and chat"""
        main_frame = tk.Frame(self.root, bg=COLORS['bg_main'])
        main_frame.pack(fill=tk.BOTH, expand=True, padx=2, pady=2)
        
        # Left panel - Script editor
        left_panel = tk.Frame(main_frame, bg=COLORS['bg_panel'], width=450)
        left_panel.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        left_panel.pack_propagate(False)
        
        # Goals/Script tabs
        script_tabs = ttk.Notebook(left_panel, style='Dark.TNotebook')
        script_tabs.pack(fill=tk.BOTH, expand=True)
        
        # Goals tab
        goals_frame = tk.Frame(script_tabs, bg=COLORS['bg_panel'])
        script_tabs.add(goals_frame, text='Goals')
        
        # Script tab
        script_frame = tk.Frame(script_tabs, bg=COLORS['bg_panel'])
        script_tabs.add(script_frame, text='Script')
        
        # Script text editor
        self.script_text = tk.Text(script_frame,
                                   bg=COLORS['bg_input'],
                                   fg=COLORS['text_primary'],
                                   insertbackground=COLORS['text_primary'],
                                   font=('Consolas', 10),
                                   relief='flat',
                                   borderwidth=0)
        self.script_text.pack(fill=tk.BOTH, expand=True, padx=2, pady=2)
        
        # Add sample script
        sample_script = """# Food Glitch Counter script v1.2 by Ogliss.

===================================================================
# This script when run in a city will output all Food Glitch information to the war log tab

setsilence true //

===================================================================
# Mode can be set to either Full or Lite
# Lite will display food geberation status from any food glitches for that troop type
# Full will display current valley/city glitch numbers, progress towards the next glitch for each troop type as well as food geberation status from any food glitches for that troop type

set Mode full //
# output can be set to eltger Log or WarLog //
set Output WarLog //

set # 0
set Generating 0
set NotGenerating 0
"""
        self.script_text.insert('1.0', sample_script)
        
        # Button bar under script
        btn_bar = tk.Frame(left_panel, bg=COLORS['bg_header'], height=30)
        btn_bar.pack(fill=tk.X, side=tk.BOTTOM)
        
        # Script buttons
        buttons = [
            ("March", COLORS['btn_blue']),
            ("Save File", COLORS['btn_orange_light']),
            ("Load File", COLORS['btn_orange_light']),
            ("Run", COLORS['btn_orange_light']),
            ("Stop", COLORS['text_red']),
            ("Save", COLORS['btn_orange_light']),
            ("Load", COLORS['btn_orange_light']),
            ("Save All", COLORS['btn_orange_light']),
        ]
        
        for text, color in buttons:
            btn = tk.Button(btn_bar, text=text,
                          bg=color,
                          fg='black' if color != COLORS['text_red'] else 'white',
                          font=('Arial', 9),
                          relief='raised',
                          borderwidth=1,
                          padx=8)
            btn.pack(side=tk.LEFT, padx=2, pady=3)
        
        # Center panel - Resource table
        center_panel = tk.Frame(main_frame, bg=COLORS['bg_panel'], width=400)
        center_panel.pack(side=tk.LEFT, fill=tk.BOTH, expand=True, padx=2)
        
        # City header
        city_header = tk.Frame(center_panel, bg=COLORS['bg_header'])
        city_header.pack(fill=tk.X)
        
        tk.Label(city_header, text="aattack",
                bg=COLORS['bg_header'], fg=COLORS['text_gold'],
                font=('Arial', 11, 'bold')).pack(side=tk.LEFT, padx=10)
        
        tk.Label(city_header, text="💚 100  / 0",
                bg=COLORS['bg_header'], fg=COLORS['text_green'],
                font=('Arial', 10)).pack(side=tk.LEFT, padx=20)
        
        tk.Label(city_header, text="⚔️ 0%",
                bg=COLORS['bg_header'], fg=COLORS['text_primary'],
                font=('Arial', 10)).pack(side=tk.RIGHT, padx=10)
        
        # City info
        info_frame = tk.Frame(center_panel, bg=COLORS['bg_panel'])
        info_frame.pack(fill=tk.X)
        
        tk.Label(info_frame, text="(3,796) Burgundy",
                bg=COLORS['bg_panel'], fg=COLORS['text_cyan'],
                font=('Arial', 9)).pack(side=tk.LEFT, padx=10)
        
        tk.Label(info_frame, text="💰 39,150 / 📈 14,725",
                bg=COLORS['bg_panel'], fg=COLORS['text_gold'],
                font=('Arial', 9)).pack(side=tk.LEFT, padx=20)
        
        tk.Label(info_frame, text="🏠 100%",
                bg=COLORS['bg_panel'], fg=COLORS['text_green'],
                font=('Arial', 9)).pack(side=tk.RIGHT, padx=10)
        
        # Resource table
        self.create_resource_table(center_panel)
        
        # Right panel - Chat
        right_panel = tk.Frame(main_frame, bg=COLORS['bg_panel'], width=350)
        right_panel.pack(side=tk.RIGHT, fill=tk.BOTH)
        right_panel.pack_propagate(False)
        
        # Chat tabs
        chat_tabs = ttk.Notebook(right_panel, style='Dark.TNotebook')
        chat_tabs.pack(fill=tk.BOTH, expand=True)
        
        # Create chat channels
        for channel in ["Alliance Chat", "Private Chat", "World Chat", "System", "Commands"]:
            chat_frame = tk.Frame(chat_tabs, bg=COLORS['bg_panel'])
            chat_tabs.add(chat_frame, text=channel.split()[0])
            
            # Chat history
            chat_text = tk.Text(chat_frame,
                              bg=COLORS['bg_input'],
                              fg=COLORS['text_primary'],
                              font=('Arial', 9),
                              relief='flat',
                              height=20)
            chat_text.pack(fill=tk.BOTH, expand=True, padx=2, pady=2)
        
        # Chat input
        input_frame = tk.Frame(right_panel, bg=COLORS['bg_header'])
        input_frame.pack(fill=tk.X, side=tk.BOTTOM)
        
        self.chat_input = tk.Entry(input_frame,
                                  bg=COLORS['bg_input'],
                                  fg=COLORS['text_primary'],
                                  font=('Arial', 10),
                                  relief='flat')
        self.chat_input.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=5, pady=5)
        
        send_btn = tk.Button(input_frame, text="Send",
                           bg=COLORS['btn_orange_light'],
                           fg='black',
                           font=('Arial', 9),
                           relief='raised')
        send_btn.pack(side=tk.RIGHT, padx=5, pady=5)
    
    def create_resource_table(self, parent):
        """Create the resource/troops table"""
        # Table header
        columns = ['R', 'V', 'C', 'I', 'H', 'B', 'S', 'G', 'A', 'T', 'Q', 'F', 'X', 'E']
        
        table_frame = tk.Frame(parent, bg=COLORS['bg_table'])
        table_frame.pack(fill=tk.BOTH, expand=True, padx=2, pady=2)
        
        # Header row
        header_frame = tk.Frame(table_frame, bg=COLORS['bg_table_header'])
        header_frame.pack(fill=tk.X)
        
        tk.Label(header_frame, text="Resource", width=12,
                bg=COLORS['bg_table_header'], fg=COLORS['text_primary'],
                font=('Arial', 9, 'bold')).pack(side=tk.LEFT)
        tk.Label(header_frame, text="Amount", width=10,
                bg=COLORS['bg_table_header'], fg=COLORS['text_primary'],
                font=('Arial', 9, 'bold')).pack(side=tk.LEFT)
        tk.Label(header_frame, text="All", width=10,
                bg=COLORS['bg_table_header'], fg=COLORS['text_primary'],
                font=('Arial', 9, 'bold')).pack(side=tk.LEFT)
        tk.Label(header_frame, text="Rate", width=10,
                bg=COLORS['bg_table_header'], fg=COLORS['text_primary'],
                font=('Arial', 9, 'bold')).pack(side=tk.LEFT)
        tk.Label(header_frame, text="Days left", width=15,
                bg=COLORS['bg_table_header'], fg=COLORS['text_primary'],
                font=('Arial', 9, 'bold')).pack(side=tk.LEFT)
        tk.Label(header_frame, text="Incoming", width=10,
                bg=COLORS['bg_table_header'], fg=COLORS['text_primary'],
                font=('Arial', 9, 'bold')).pack(side=tk.LEFT)
        
        # Resource rows
        resources = [
            ("Gold (g)", "100t", "1490t", "-13.4k", "309805010d:-10h:0-5", "0", COLORS['text_gold']),
            ("Food (f)", "0", "918b", "-4.59b", "00m:00", "0", COLORS['text_red']),
            ("Lumber (w)", "10.1t", "318t", "56.6k", "", "0", COLORS['text_primary']),
            ("Stone (s)", "1.54t", "137t", "100", "", "0", COLORS['text_primary']),
            ("Iron (i)", "2.35t", "133t", "166k", "", "0", COLORS['text_primary']),
            ("Population", "39,150", "443k", "", "", "", COLORS['text_primary']),
        ]
        
        for i, (name, amount, all_val, rate, days, incoming, color) in enumerate(resources):
            bg = COLORS['bg_table'] if i % 2 == 0 else COLORS['bg_table_alt']
            
            row = tk.Frame(table_frame, bg=bg)
            row.pack(fill=tk.X)
            
            tk.Label(row, text=name, width=12, anchor='w',
                    bg=bg, fg=color, font=('Arial', 9)).pack(side=tk.LEFT)
            tk.Label(row, text=amount, width=10,
                    bg=bg, fg=COLORS['text_primary'], font=('Arial', 9)).pack(side=tk.LEFT)
            tk.Label(row, text=all_val, width=10,
                    bg=bg, fg=COLORS['text_primary'], font=('Arial', 9)).pack(side=tk.LEFT)
            tk.Label(row, text=rate, width=10,
                    bg=bg, fg=COLORS['text_red'] if rate.startswith('-') else COLORS['text_green'],
                    font=('Arial', 9)).pack(side=tk.LEFT)
            tk.Label(row, text=days, width=15,
                    bg=bg, fg=COLORS['text_primary'], font=('Arial', 9)).pack(side=tk.LEFT)
            tk.Label(row, text=incoming, width=10,
                    bg=bg, fg=COLORS['text_primary'], font=('Arial', 9)).pack(side=tk.LEFT)
    
    def create_bottom_tabs(self):
        """Create bottom tab bar (Log, City Log, War Log, etc.)"""
        bottom_frame = tk.Frame(self.root, bg=COLORS['bg_main'])
        bottom_frame.pack(fill=tk.BOTH, expand=True)
        
        # Tab bar
        tab_bar = tk.Frame(bottom_frame, bg=COLORS['bg_header'], height=24)
        tab_bar.pack(fill=tk.X)
        
        tabs = ["Log", "City Log", "War Log", "Maps", "Account", "Snippets"]
        for tab in tabs:
            lbl = tk.Label(tab_bar, text=tab,
                          bg=COLORS['tab_inactive'],
                          fg=COLORS['text_primary'],
                          font=('Arial', 9),
                          padx=10, pady=2)
            lbl.pack(side=tk.LEFT, padx=1)
        
        # Log area
        log_frame = tk.Frame(bottom_frame, bg=COLORS['bg_panel'])
        log_frame.pack(fill=tk.BOTH, expand=True)
        
        self.log_text = tk.Text(log_frame,
                               bg=COLORS['bg_input'],
                               fg=COLORS['text_primary'],
                               font=('Consolas', 9),
                               relief='flat',
                               height=10)
        self.log_text.pack(fill=tk.BOTH, expand=True, padx=2, pady=2)
        
        # Add sample log entries
        sample_logs = [
            ("09:26:13", "(Hindu)", "Castle Hindu is at (8,7) in Friesland, and is a Food City", COLORS['text_cyan']),
            ("09:26:13", "(Hindu)", "No Castle Buffs", COLORS['text_yellow']),
            ("09:26:33", "(Jerusalem)", "Castle Jerusalem is at (300,700) in Lombardy, and is a Food City", COLORS['text_cyan']),
            ("09:26:57", "(LOLA)", "Castle LOLA is at (2,1) in Friesland, and is a Wood City", COLORS['text_green']),
            ("09:27:25", "(Mojo)", "Castle Mojo is at (793,796) in Romagna, and is a Food City", COLORS['text_cyan']),
            ("09:32:26", "(aattack)", "FOOD IS LOW, UNDER 1 DAY LEFT, nonessential tasks are disabled automatically.", COLORS['text_red']),
        ]
        
        for time, city, msg, color in sample_logs:
            self.log_text.insert(tk.END, f"{time} ")
            self.log_text.insert(tk.END, f"{city} ", 'city')
            self.log_text.insert(tk.END, f"- {msg}\n")
        
        self.log_text.tag_configure('city', foreground=COLORS['text_gold'])
    
    def create_status_bar(self):
        """Create bottom status bar"""
        status_bar = tk.Frame(self.root, bg=COLORS['bg_header'], height=20)
        status_bar.pack(fill=tk.X, side=tk.BOTTOM)
        
        tk.Label(status_bar, text="RE for Age II v1.60",
                bg=COLORS['bg_header'], fg=COLORS['text_secondary'],
                font=('Arial', 8)).pack(side=tk.LEFT, padx=10)
        
        tk.Label(status_bar, text="Connected • Training: Epoch 40+",
                bg=COLORS['bg_header'], fg=COLORS['text_green'],
                font=('Arial', 8)).pack(side=tk.RIGHT, padx=10)
    
    def start_updates(self):
        """Start background update thread"""
        def update_time():
            while True:
                now = datetime.now().strftime("%H:%M:%S")
                try:
                    self.time_label.config(text=now)
                except:
                    break
                time.sleep(1)
        
        thread = threading.Thread(target=update_time, daemon=True)
        thread.start()
    
    def add_log(self, message, color=None):
        """Add message to log"""
        timestamp = datetime.now().strftime("%H:%M:%S")
        self.log_text.insert(tk.END, f"{timestamp} - {message}\n")
        self.log_text.see(tk.END)


def main():
    root = tk.Tk()
    app = AutoEvonyClone(root)
    root.mainloop()


if __name__ == "__main__":
    main()
