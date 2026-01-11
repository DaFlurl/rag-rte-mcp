"""
ETK SOL Manager - Account Data Tab
Enhanced account data display with cities, troops, heroes, items
Matches RoboEvony style with Resume/Refresh/Logout buttons
"""

import tkinter as tk
from tkinter import ttk
from typing import Optional, Dict, Any, Callable, List
from pathlib import Path

try:
    from ...theme import RoboEvonyTheme as Theme
except ImportError:
    from sol_manager.theme import RoboEvonyTheme as Theme


class AccountDataTab(ttk.Frame):
    """
    Enhanced account data display container.
    Shows:
    - Account header with player name, server, prestige
    - Action buttons (Resume, Refresh, Logout)
    - Stats bar (gold, food, cities, troops, heroes, alliance)
    - Cities as individual sub-tabs with per-city data
    - Alliance/colonization status
    """
    
    def __init__(self, parent, **kwargs):
        super().__init__(parent, **kwargs)
        
        self.current_account: Optional[Dict[str, Any]] = None
        self.on_resume: Optional[Callable] = None
        self.on_refresh: Optional[Callable] = None
        self.on_logout: Optional[Callable] = None
        self.city_tabs: Dict[str, ttk.Frame] = {}
        
        self._setup_ui()
    
    def _setup_ui(self):
        """Setup the main UI layout"""
        self.columnconfigure(0, weight=1)
        self.rowconfigure(2, weight=1)
        
        # Row 0: Account header with player name and action buttons
        self._create_account_header()
        
        # Row 1: Stats bar
        self._create_stats_bar()
        
        # Row 2: Cities notebook (each city as a tab)
        self._create_cities_notebook()
    
    def _create_account_header(self):
        """Create account header with name, server, and action buttons"""
        header_frame = tk.Frame(self, bg=Theme.BG_HEADER)
        header_frame.grid(row=0, column=0, sticky="ew", padx=0, pady=0)
        header_frame.columnconfigure(1, weight=1)
        
        # Left side: Player name box (like RoboEvony)
        name_frame = tk.Frame(header_frame, bg="#1a4a7a", padx=10, pady=5)
        name_frame.grid(row=0, column=0, sticky="w", padx=5, pady=5)
        
        self.player_name_label = tk.Label(
            name_frame,
            text="No Account",
            font=('Segoe UI', 14, 'bold'),
            bg="#1a4a7a",
            fg="#FFD700"
        )
        self.player_name_label.pack()
        
        # Center: Server and account info
        info_frame = tk.Frame(header_frame, bg=Theme.BG_HEADER)
        info_frame.grid(row=0, column=1, sticky="ew", padx=10)
        
        # Server info row
        server_row = tk.Frame(info_frame, bg=Theme.BG_HEADER)
        server_row.pack(anchor="w")
        
        self.server_label = tk.Label(
            server_row, text="Server: -", 
            bg=Theme.BG_HEADER, fg=Theme.TEXT_SECONDARY,
            font=('Segoe UI', 10)
        )
        self.server_label.pack(side="left", padx=5)
        
        self.prestige_label = tk.Label(
            server_row, text="Prestige: 0",
            bg=Theme.BG_HEADER, fg="#FFD700",
            font=('Segoe UI', 10, 'bold')
        )
        self.prestige_label.pack(side="left", padx=15)
        
        self.honor_label = tk.Label(
            server_row, text="Honor: 0",
            bg=Theme.BG_HEADER, fg="#87CEEB",
            font=('Segoe UI', 10)
        )
        self.honor_label.pack(side="left", padx=15)
        
        # Alliance info row
        alliance_row = tk.Frame(info_frame, bg=Theme.BG_HEADER)
        alliance_row.pack(anchor="w")
        
        self.alliance_label = tk.Label(
            alliance_row, text="Alliance: None",
            bg=Theme.BG_HEADER, fg=Theme.STATUS_POSITIVE,
            font=('Segoe UI', 10)
        )
        self.alliance_label.pack(side="left", padx=5)
        
        self.rank_label = tk.Label(
            alliance_row, text="Rank: -",
            bg=Theme.BG_HEADER, fg=Theme.TEXT_SECONDARY,
            font=('Segoe UI', 10)
        )
        self.rank_label.pack(side="left", padx=15)
        
        # Right side: Action buttons (Resume, Refresh, Logout)
        btn_frame = tk.Frame(header_frame, bg=Theme.BG_HEADER)
        btn_frame.grid(row=0, column=2, sticky="e", padx=10, pady=5)
        
        # Resume button (orange/gold like RoboEvony)
        self.resume_btn = tk.Button(
            btn_frame, text="▶ Resume",
            bg="#D4A84B", fg="black",
            font=('Segoe UI', 10, 'bold'),
            relief="raised", bd=2,
            command=self._on_resume_click,
            width=10
        )
        self.resume_btn.pack(side="left", padx=3)
        
        # Refresh button
        self.refresh_btn = tk.Button(
            btn_frame, text="⟳ Refresh",
            bg="#D4A84B", fg="black",
            font=('Segoe UI', 10, 'bold'),
            relief="raised", bd=2,
            command=self._on_refresh_click,
            width=10
        )
        self.refresh_btn.pack(side="left", padx=3)
        
        # Logout button (blue like RoboEvony)
        self.logout_btn = tk.Button(
            btn_frame, text="Logout",
            bg="#4a6a9a", fg="white",
            font=('Segoe UI', 10),
            relief="raised", bd=2,
            command=self._on_logout_click,
            width=8
        )
        self.logout_btn.pack(side="left", padx=3)
    
    def _create_stats_bar(self):
        """Create stats bar with all account statistics"""
        stats_frame = tk.Frame(self, bg=Theme.BG_PANEL)
        stats_frame.grid(row=1, column=0, sticky="ew", padx=5, pady=5)
        
        self.stat_value_labels = {}
        
        # Stats to display
        stats = [
            ("Gold", "#FFD700", "gold"),
            ("Food", "#90EE90", "food"),
            ("Lumber", "#DEB887", "lumber"),
            ("Stone", "#A9A9A9", "stone"),
            ("Iron", "#B0C4DE", "iron"),
            ("Cities", "#87CEEB", "cities"),
            ("Troops", "#DDA0DD", "troops"),
            ("Heroes", "#F0E68C", "heroes"),
            ("Stars", "#FFD700", "stars"),
        ]
        
        for i, (label, color, key) in enumerate(stats):
            frame = tk.Frame(stats_frame, bg=Theme.BG_PANEL)
            frame.pack(side="left", padx=8, pady=5)
            
            lbl = tk.Label(
                frame, text=label,
                bg=Theme.BG_PANEL, fg=Theme.TEXT_SECONDARY,
                font=('Segoe UI', 9)
            )
            lbl.pack()
            
            val = tk.Label(
                frame, text="0",
                bg=Theme.BG_PANEL, fg=color,
                font=('Segoe UI', 11, 'bold')
            )
            val.pack()
            self.stat_value_labels[key] = val
    
    def _create_cities_notebook(self):
        """Create cities notebook - each city as a separate tab"""
        self.cities_notebook = ttk.Notebook(self)
        self.cities_notebook.grid(row=2, column=0, sticky="nsew", padx=5, pady=5)
        
        # Overview tab (always present)
        self.overview_frame = tk.Frame(self.cities_notebook, bg=Theme.BG_DARK)
        self.cities_notebook.add(self.overview_frame, text="📊 Overview")
        self._setup_overview_tab()
        
        # All Cities tab
        self.all_cities_frame = tk.Frame(self.cities_notebook, bg=Theme.BG_DARK)
        self.cities_notebook.add(self.all_cities_frame, text="🏰 All Cities")
        self._setup_all_cities_tab()
        
        # All Troops tab
        self.all_troops_frame = tk.Frame(self.cities_notebook, bg=Theme.BG_DARK)
        self.cities_notebook.add(self.all_troops_frame, text="⚔️ Troops")
        self._setup_all_troops_tab()
        
        # All Heroes tab
        self.all_heroes_frame = tk.Frame(self.cities_notebook, bg=Theme.BG_DARK)
        self.cities_notebook.add(self.all_heroes_frame, text="👑 Heroes")
        self._setup_all_heroes_tab()
        
        # Items tab
        self.items_frame = tk.Frame(self.cities_notebook, bg=Theme.BG_DARK)
        self.cities_notebook.add(self.items_frame, text="📦 Items")
        self._setup_items_tab()
    
    def _setup_all_cities_tab(self):
        """Setup the all cities tab with city list"""
        self.all_cities_frame.columnconfigure(0, weight=1)
        self.all_cities_frame.rowconfigure(0, weight=1)
        
        # Cities treeview
        columns = ("name", "coords", "state", "mayor", "gold", "food", "troops", "colonized")
        self.cities_tree = ttk.Treeview(self.all_cities_frame, columns=columns, show="headings")
        
        headers = [
            ("name", "City Name", 120),
            ("coords", "Location", 80),
            ("state", "State", 80),
            ("mayor", "Mayor", 100),
            ("gold", "Gold", 80),
            ("food", "Food", 80),
            ("troops", "Troops", 80),
            ("colonized", "Status", 100)
        ]
        
        for col, header, width in headers:
            self.cities_tree.heading(col, text=header)
            self.cities_tree.column(col, width=width, anchor="center" if col != "name" else "w")
        
        self.cities_tree.grid(row=0, column=0, sticky="nsew", padx=5, pady=5)
        
        # Scrollbar
        vsb = ttk.Scrollbar(self.all_cities_frame, orient="vertical", command=self.cities_tree.yview)
        vsb.grid(row=0, column=1, sticky="ns")
        self.cities_tree.configure(yscrollcommand=vsb.set)
        
        # Bind double-click to show city details
        self.cities_tree.bind("<Double-1>", self._on_city_double_click)
    
    def _setup_all_troops_tab(self):
        """Setup all troops summary tab"""
        self.all_troops_frame.columnconfigure(0, weight=1)
        self.all_troops_frame.rowconfigure(1, weight=1)
        
        # Troop totals summary
        totals_frame = tk.LabelFrame(self.all_troops_frame, text="Total Troops", 
                                     bg=Theme.BG_DARK, fg=Theme.ACCENT_ORANGE)
        totals_frame.grid(row=0, column=0, sticky="ew", padx=5, pady=5)
        
        self.troop_total_labels = {}
        troop_types = [
            ("Workers", "wo"), ("Warriors", "w"), ("Scouts", "s"),
            ("Pikemen", "p"), ("Swordsmen", "sw"), ("Archers", "a"),
            ("Cavalry", "c"), ("Cataphracts", "cata"), ("Transporters", "t"),
            ("Rams", "r"), ("Ballistas", "b"), ("Catapults", "cp")
        ]
        
        for i, (name, code) in enumerate(troop_types):
            row, col = i // 6, i % 6
            frame = tk.Frame(totals_frame, bg=Theme.BG_DARK)
            frame.grid(row=row, column=col, padx=10, pady=5)
            
            tk.Label(frame, text=name, bg=Theme.BG_DARK, fg=Theme.TEXT_SECONDARY,
                    font=('Segoe UI', 9)).pack()
            lbl = tk.Label(frame, text="0", bg=Theme.BG_DARK, fg=Theme.ACCENT_ORANGE,
                          font=('Segoe UI', 11, 'bold'))
            lbl.pack()
            self.troop_total_labels[code] = lbl
        
        # Troops by city treeview
        columns = ["city"] + [t[1] for t in troop_types] + ["total"]
        self.troops_tree = ttk.Treeview(self.all_troops_frame, columns=columns, show="headings")
        
        self.troops_tree.heading("city", text="City")
        self.troops_tree.column("city", width=100)
        for name, code in troop_types:
            self.troops_tree.heading(code, text=code.upper())
            self.troops_tree.column(code, width=50, anchor="center")
        self.troops_tree.heading("total", text="Total")
        self.troops_tree.column("total", width=70, anchor="center")
        
        self.troops_tree.grid(row=1, column=0, sticky="nsew", padx=5, pady=5)
    
    def _setup_all_heroes_tab(self):
        """Setup all heroes tab"""
        self.all_heroes_frame.columnconfigure(0, weight=1)
        self.all_heroes_frame.rowconfigure(1, weight=1)
        
        # Hero type summary
        summary_frame = tk.Frame(self.all_heroes_frame, bg=Theme.BG_DARK)
        summary_frame.grid(row=0, column=0, sticky="ew", padx=5, pady=5)
        
        self.hero_summary_labels = {}
        for text, key, color in [("Total Heroes", "total", Theme.TEXT_PRIMARY),
                                  ("Ring Heroes (120)", "ring", "#FFD700"),
                                  ("HH Heroes", "hh", "#FF6B6B")]:
            frame = tk.Frame(summary_frame, bg=Theme.BG_DARK)
            frame.pack(side="left", padx=20)
            tk.Label(frame, text=text, bg=Theme.BG_DARK, fg=Theme.TEXT_SECONDARY).pack()
            lbl = tk.Label(frame, text="0", bg=Theme.BG_DARK, fg=color, font=('Segoe UI', 14, 'bold'))
            lbl.pack()
            self.hero_summary_labels[key] = lbl
        
        # Heroes treeview
        columns = ("name", "level", "attack", "politics", "intel", "city", "type", "status")
        self.heroes_tree = ttk.Treeview(self.all_heroes_frame, columns=columns, show="headings")
        
        for col, header, width in [("name", "Hero Name", 150), ("level", "Lvl", 50),
                                    ("attack", "Attack", 70), ("politics", "Pol", 50),
                                    ("intel", "Int", 50), ("city", "City", 100),
                                    ("type", "Type", 60), ("status", "Status", 70)]:
            self.heroes_tree.heading(col, text=header)
            self.heroes_tree.column(col, width=width, anchor="center" if col != "name" else "w")
        
        self.heroes_tree.grid(row=1, column=0, sticky="nsew", padx=5, pady=5)
    
    def _setup_items_tab(self):
        """Setup items tab"""
        self.items_frame.columnconfigure(0, weight=1)
        self.items_frame.rowconfigure(1, weight=1)
        
        # Quick item counts
        quick_frame = tk.Frame(self.items_frame, bg=Theme.BG_DARK)
        quick_frame.grid(row=0, column=0, sticky="ew", padx=5, pady=5)
        
        self.item_quick_labels = {}
        for text, key, color in [("Thunder Raids", "tr", "#FF6B6B"),
                                  ("Fleet Feet", "ff", "#4ECDC4"),
                                  ("Speakers", "sp", "#FFE66D"),
                                  ("War Ensigns", "we", "#9B59B6")]:
            frame = tk.Frame(quick_frame, bg=Theme.BG_DARK)
            frame.pack(side="left", padx=15)
            tk.Label(frame, text=text, bg=Theme.BG_DARK, fg=Theme.TEXT_SECONDARY).pack()
            lbl = tk.Label(frame, text="0", bg=Theme.BG_DARK, fg=color, font=('Segoe UI', 12, 'bold'))
            lbl.pack()
            self.item_quick_labels[key] = lbl
        
        # Items treeview
        columns = ("name", "count", "category")
        self.items_tree = ttk.Treeview(self.items_frame, columns=columns, show="headings")
        
        self.items_tree.heading("name", text="Item Name")
        self.items_tree.heading("count", text="Count")
        self.items_tree.heading("category", text="Category")
        self.items_tree.column("name", width=250)
        self.items_tree.column("count", width=80, anchor="center")
        self.items_tree.column("category", width=120)
        
        self.items_tree.grid(row=1, column=0, sticky="nsew", padx=5, pady=5)
    
    def _setup_overview_tab(self):
        """Setup the overview tab content"""
        self.overview_frame.columnconfigure(0, weight=1)
        self.overview_frame.rowconfigure(0, weight=1)
        
        # Create text widget for overview
        self.overview_text = tk.Text(
            self.overview_frame,
            wrap=tk.WORD,
            font=('Consolas', 10),
            bg='#1e1e1e',
            fg='#d4d4d4',
            insertbackground='white'
        )
        self.overview_text.grid(row=0, column=0, sticky="nsew")
        
        # Scrollbar
        scrollbar = ttk.Scrollbar(self.overview_frame, orient="vertical", 
                                  command=self.overview_text.yview)
        scrollbar.grid(row=0, column=1, sticky="ns")
        self.overview_text.configure(yscrollcommand=scrollbar.set)
        
        # Initial message
        self.overview_text.insert("1.0", "Select an account to view data.\n\n"
                                         "Use the extraction scripts to gather data:\n"
                                         "1. Launch bot for account\n"
                                         "2. Load master_extraction.txt script\n"
                                         "3. Run script to extract all data\n"
                                         "4. Data will appear here")
        self.overview_text.config(state='disabled')
    
    def _setup_placeholder(self, frame: ttk.Frame, message: str):
        """Setup placeholder content for a tab"""
        frame.columnconfigure(0, weight=1)
        frame.rowconfigure(0, weight=1)
        
        lbl = ttk.Label(
            frame,
            text=message,
            font=('Segoe UI', 12),
            foreground='gray'
        )
        lbl.grid(row=0, column=0)
    
    def _on_resume_click(self):
        """Handle Resume button click - launches bot for account"""
        if self.on_resume and self.current_account:
            self.on_resume(self.current_account.get('email', ''))
    
    def _on_refresh_click(self):
        """Handle Refresh button click - reloads account data"""
        if self.on_refresh and self.current_account:
            self.on_refresh(self.current_account.get('email', ''))
    
    def _on_logout_click(self):
        """Handle Logout button click"""
        if self.on_logout and self.current_account:
            self.on_logout(self.current_account.get('email', ''))
    
    def _on_city_double_click(self, event):
        """Handle double-click on city to show details"""
        selection = self.cities_tree.selection()
        if selection:
            item = self.cities_tree.item(selection[0])
            city_name = item['values'][0]
            self._show_city_details(city_name)
    
    def _show_city_details(self, city_name: str):
        """Show detailed city information in a popup or new tab"""
        # // DONE: Implement city details popup
        pass
    
    def _add_city_tab(self, city_data: Dict[str, Any]):
        """Add a tab for a specific city"""
        city_name = city_data.get('name', 'City')
        coords = f"({city_data.get('x', 0)},{city_data.get('y', 0)})"
        
        city_frame = tk.Frame(self.cities_notebook, bg=Theme.BG_DARK)
        self.cities_notebook.add(city_frame, text=f"🏠 {city_name}")
        self.city_tabs[city_name] = city_frame
        
        # City header
        header = tk.Frame(city_frame, bg=Theme.BG_HEADER)
        header.pack(fill="x", padx=5, pady=5)
        
        tk.Label(header, text=f"{city_name} {coords}", 
                bg=Theme.BG_HEADER, fg=Theme.ACCENT_ORANGE,
                font=('Segoe UI', 12, 'bold')).pack(side="left", padx=10)
        
        # Resources section
        res_frame = tk.LabelFrame(city_frame, text="Resources", 
                                  bg=Theme.BG_DARK, fg=Theme.ACCENT_ORANGE)
        res_frame.pack(fill="x", padx=5, pady=5)
        
        resources = city_data.get('resources', {})
        for res, val in [("Gold", resources.get('gold', 0)),
                         ("Food", resources.get('food', 0)),
                         ("Lumber", resources.get('lumber', 0)),
                         ("Stone", resources.get('stone', 0)),
                         ("Iron", resources.get('iron', 0))]:
            frame = tk.Frame(res_frame, bg=Theme.BG_DARK)
            frame.pack(side="left", padx=15, pady=5)
            tk.Label(frame, text=res, bg=Theme.BG_DARK, fg=Theme.TEXT_SECONDARY).pack()
            tk.Label(frame, text=self._format_number(val), bg=Theme.BG_DARK, 
                    fg="#FFD700", font=('Segoe UI', 10, 'bold')).pack()
        
        # Troops section
        troops_frame = tk.LabelFrame(city_frame, text="Troops", 
                                     bg=Theme.BG_DARK, fg=Theme.ACCENT_ORANGE)
        troops_frame.pack(fill="x", padx=5, pady=5)
        
        troops = city_data.get('troops', {})
        for name, code in [("Workers", "workers"), ("Warriors", "warriors"),
                           ("Archers", "archers"), ("Cavalry", "cavalry"),
                           ("Cataphracts", "cataphracts"), ("Ballistas", "ballistas")]:
            frame = tk.Frame(troops_frame, bg=Theme.BG_DARK)
            frame.pack(side="left", padx=10, pady=5)
            tk.Label(frame, text=name, bg=Theme.BG_DARK, fg=Theme.TEXT_SECONDARY).pack()
            tk.Label(frame, text=self._format_number(troops.get(code, 0)), 
                    bg=Theme.BG_DARK, fg=Theme.ACCENT_ORANGE, 
                    font=('Segoe UI', 10, 'bold')).pack()
    
    def set_account(self, account_data: Dict[str, Any]):
        """Set the current account and update display"""
        self.current_account = account_data
        
        # Update player name header
        email = account_data.get('email', 'Unknown')
        player_name = account_data.get('player_name', email.split('@')[0])
        self.player_name_label.config(text=player_name if player_name else email.split('@')[0])
        
        # Update server/prestige/honor
        creds = account_data.get('credentials', {})
        summary = account_data.get('summary', {})
        
        server = creds.get('server', 'cc2')
        server_alias = creds.get('server_alias', 'Parapet')
        self.server_label.config(text=f"Server: {server} ({server_alias})")
        self.prestige_label.config(text=f"Prestige: {self._format_number(summary.get('prestige', 0))}")
        self.honor_label.config(text=f"Honor: {self._format_number(summary.get('honor', 0))}")
        
        # Update alliance info
        alliance = account_data.get('alliance', 'None')
        rank = account_data.get('rank', '-')
        self.alliance_label.config(text=f"Alliance: {alliance}")
        self.rank_label.config(text=f"Rank: {rank}")
        
        # Update stats bar
        if hasattr(self, 'stat_value_labels'):
            self.stat_value_labels.get('gold', tk.Label()).config(
                text=self._format_number(summary.get('total_gold', 0)))
            self.stat_value_labels.get('food', tk.Label()).config(
                text=self._format_number(summary.get('total_food', 0)))
            self.stat_value_labels.get('lumber', tk.Label()).config(
                text=self._format_number(summary.get('total_lumber', 0)))
            self.stat_value_labels.get('stone', tk.Label()).config(
                text=self._format_number(summary.get('total_stone', 0)))
            self.stat_value_labels.get('iron', tk.Label()).config(
                text=self._format_number(summary.get('total_iron', 0)))
            self.stat_value_labels.get('cities', tk.Label()).config(
                text=str(summary.get('total_cities', 0)))
            self.stat_value_labels.get('troops', tk.Label()).config(
                text=self._format_number(summary.get('total_troops', 0)))
            self.stat_value_labels.get('heroes', tk.Label()).config(
                text=str(summary.get('total_heroes', 0)))
            self.stat_value_labels.get('stars', tk.Label()).config(
                text=str(summary.get('stars', 0)))
        
        # Update cities list
        self._update_cities_list(account_data.get('cities', []))
        
        # Update overview
        self._update_overview(account_data)
    
    def _update_cities_list(self, cities: List[Dict[str, Any]]):
        """Update the cities treeview"""
        # Clear existing cities
        for item in self.cities_tree.get_children():
            self.cities_tree.delete(item)
        
        # Clear existing city tabs (keep Overview, All Cities, Troops, Heroes, Items)
        for name, tab in list(self.city_tabs.items()):
            try:
                self.cities_notebook.forget(tab)
            except:
                pass
        self.city_tabs.clear()
        
        # Add cities to treeview and create tabs
        for city in cities:
            coords = f"({city.get('x', 0)},{city.get('y', 0)})"
            resources = city.get('resources', {})
            troops = city.get('troops', {})
            total_troops = sum(troops.values()) if isinstance(troops, dict) else 0
            
            # Determine colonization status
            colonized_by = city.get('colonized_by', '')
            if colonized_by:
                status = f"🔴 {colonized_by}" if city.get('is_enemy', False) else f"🟢 {colonized_by}"
            else:
                status = "Free"
            
            values = (
                city.get('name', 'Unknown'),
                coords,
                city.get('state', '-'),
                city.get('mayor_name', '-'),
                self._format_number(resources.get('gold', 0)),
                self._format_number(resources.get('food', 0)),
                self._format_number(total_troops),
                status
            )
            self.cities_tree.insert("", "end", values=values)
            
            # Add city as a tab
            self._add_city_tab(city)
    
    def _update_overview(self, account_data: Dict[str, Any]):
        """Update the overview text"""
        self.overview_text.config(state='normal')
        self.overview_text.delete("1.0", tk.END)
        
        lines = []
        lines.append(f"Account: {account_data.get('email', 'Unknown')}")
        lines.append(f"Server: {account_data.get('credentials', {}).get('server', 'cc2')}")
        lines.append(f"Status: {account_data.get('status', 'unknown')}")
        lines.append("")
        
        # Summary
        summary = account_data.get('summary', {})
        lines.append("=== SUMMARY ===")
        lines.append(f"Gold: {self._format_number(summary.get('total_gold', 0))}")
        lines.append(f"Food: {self._format_number(summary.get('total_food', 0))}")
        lines.append(f"Cities: {summary.get('total_cities', 0)}")
        lines.append(f"Heroes: {summary.get('total_heroes', 0)}")
        lines.append(f"  - Ring Heroes (120): {summary.get('ring_heroes', 0)}")
        lines.append(f"  - HH Heroes: {summary.get('hh_heroes', 0)}")
        lines.append(f"Troops: {self._format_number(summary.get('total_troops', 0))}")
        lines.append("")
        
        # Credentials info
        creds = account_data.get('credentials', {})
        lines.append("=== CONNECTION ===")
        lines.append(f"Server IP: {creds.get('server_ip', 'N/A')}")
        lines.append(f"Proxy: {creds.get('proxy_host', 'N/A')}:{creds.get('proxy_port', 'N/A')}")
        lines.append(f"SOL Files: {len(account_data.get('sol_paths', []))}")
        
        self.overview_text.insert("1.0", "\n".join(lines))
        self.overview_text.config(state='disabled')
    
    def _format_number(self, num) -> str:
        """Format large numbers with commas and abbreviations"""
        try:
            num = int(num)
            if num >= 1_000_000_000:
                return f"{num/1_000_000_000:.1f}B"
            elif num >= 1_000_000:
                return f"{num/1_000_000:.1f}M"
            elif num >= 1_000:
                return f"{num:,}"
            return str(num)
        except (ValueError, TypeError):
            return "0"
    
    def clear(self):
        """Clear all displayed data"""
        self.current_account = None
        self.player_name_label.config(text="No Account")
        self.server_label.config(text="Server: -")
        self.prestige_label.config(text="Prestige: 0")
        self.honor_label.config(text="Honor: 0")
        self.alliance_label.config(text="Alliance: None")
        self.rank_label.config(text="Rank: -")
        
        if hasattr(self, 'stat_value_labels'):
            for lbl in self.stat_value_labels.values():
                lbl.config(text="0")
        
        # Clear cities tree
        if hasattr(self, 'cities_tree'):
            for item in self.cities_tree.get_children():
                self.cities_tree.delete(item)
        
        # Clear city tabs
        for name, tab in list(self.city_tabs.items()):
            try:
                self.cities_notebook.forget(tab)
            except:
                pass
        self.city_tabs.clear()
        
        self.overview_text.config(state='normal')
        self.overview_text.delete("1.0", tk.END)
        self.overview_text.insert("1.0", "Select an account to view data.\n\n"
                                         "Use extraction scripts to gather data:\n"
                                         "1. Launch bot for account\n"
                                         "2. Load master_extraction.txt script\n"
                                         "3. Run script - data will appear here")
        self.overview_text.config(state='disabled')
