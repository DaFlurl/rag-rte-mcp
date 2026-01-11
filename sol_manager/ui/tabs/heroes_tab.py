"""
ETK SOL Manager - Heroes Tab
Displays hero data with filtering by type
"""

import tkinter as tk
from tkinter import ttk
from typing import Optional, Dict, List, Any

from ...theme import RoboEvonyTheme as Theme


class HeroesTab(ttk.Frame):
    """
    Heroes data display tab.
    Shows all heroes with stats, filterable by type (Regular/Ring/HH).
    """
    
    def __init__(self, parent, **kwargs):
        super().__init__(parent, **kwargs)
        self.heroes: List[Dict[str, Any]] = []
        self.filtered_heroes: List[Dict[str, Any]] = []
        self._setup_ui()
    
    def _setup_ui(self):
        """Setup the heroes tab UI"""
        self.columnconfigure(0, weight=1)
        self.rowconfigure(1, weight=1)
        
        # Filter header
        self._create_filter_header()
        
        # Heroes treeview
        self._create_treeview()
    
    def _create_filter_header(self):
        """Create filter controls"""
        header = ttk.Frame(self)
        header.grid(row=0, column=0, sticky="ew", padx=5, pady=5)
        
        # Hero count
        self.count_label = ttk.Label(
            header, 
            text="Heroes: 0",
            font=('Segoe UI', 11, 'bold')
        )
        self.count_label.pack(side="left")
        
        # Filter by type
        ttk.Label(header, text="  Filter:").pack(side="left", padx=(20, 5))
        
        self.filter_var = tk.StringVar(value="All")
        filter_combo = ttk.Combobox(
            header, 
            textvariable=self.filter_var,
            values=["All", "Ring Heroes (120+)", "HH Heroes", "Regular"],
            state="readonly",
            width=18
        )
        filter_combo.pack(side="left")
        filter_combo.bind("<<ComboboxSelected>>", self._apply_filter)
        
        # Search
        ttk.Label(header, text="  Search:").pack(side="left", padx=(20, 5))
        self.search_var = tk.StringVar()
        search_entry = ttk.Entry(header, textvariable=self.search_var, width=20)
        search_entry.pack(side="left")
        search_entry.bind("<KeyRelease>", self._apply_filter)
        
        # Summary labels
        summary_frame = ttk.Frame(header)
        summary_frame.pack(side="right", padx=10)
        
        self.ring_label = ttk.Label(summary_frame, text="Ring: 0", foreground="#FFD700")
        self.ring_label.pack(side="left", padx=5)
        
        self.hh_label = ttk.Label(summary_frame, text="HH: 0", foreground="#FF6B6B")
        self.hh_label.pack(side="left", padx=5)
    
    def _create_treeview(self):
        """Create heroes treeview"""
        tree_frame = ttk.Frame(self)
        tree_frame.grid(row=1, column=0, sticky="nsew", padx=5, pady=5)
        tree_frame.columnconfigure(0, weight=1)
        tree_frame.rowconfigure(0, weight=1)
        
        columns = ("name", "level", "attack", "politics", "intel", 
                   "loyalty", "speed", "city", "type", "status")
        
        self.tree = ttk.Treeview(tree_frame, columns=columns, show="headings")
        
        # Define headings
        headers = {
            "name": ("Hero Name", 150),
            "level": ("Lvl", 50),
            "attack": ("Attack", 70),
            "politics": ("Pol", 50),
            "intel": ("Int", 50),
            "loyalty": ("Loy", 50),
            "speed": ("Spd", 50),
            "city": ("City", 100),
            "type": ("Type", 70),
            "status": ("Status", 70)
        }
        
        for col, (header, width) in headers.items():
            self.tree.heading(col, text=header, command=lambda c=col: self._sort_by(c))
            self.tree.column(col, width=width, anchor="center" if col != "name" else "w")
        
        self.tree.grid(row=0, column=0, sticky="nsew")
        
        # Scrollbars
        vsb = ttk.Scrollbar(tree_frame, orient="vertical", command=self.tree.yview)
        vsb.grid(row=0, column=1, sticky="ns")
        self.tree.configure(yscrollcommand=vsb.set)
        
        # Sort tracking
        self.sort_column = "level"
        self.sort_reverse = True
    
    def _sort_by(self, column: str):
        """Sort treeview by column"""
        if self.sort_column == column:
            self.sort_reverse = not self.sort_reverse
        else:
            self.sort_column = column
            self.sort_reverse = True if column in ["level", "attack"] else False
        
        self._display_heroes(self.filtered_heroes)
    
    def _apply_filter(self, event=None):
        """Apply filter and search"""
        filter_type = self.filter_var.get()
        search_text = self.search_var.get().lower()
        
        self.filtered_heroes = []
        
        for hero in self.heroes:
            # Type filter
            hero_type = hero.get('hero_type', 'regular')
            level = hero.get('level', 0)
            
            if filter_type == "Ring Heroes (120+)" and level < 120:
                continue
            elif filter_type == "HH Heroes" and hero_type != 'historic':
                continue
            elif filter_type == "Regular" and (level >= 120 or hero_type == 'historic'):
                continue
            
            # Search filter
            if search_text:
                name = hero.get('name', '').lower()
                city = hero.get('city_name', '').lower()
                if search_text not in name and search_text not in city:
                    continue
            
            self.filtered_heroes.append(hero)
        
        self._display_heroes(self.filtered_heroes)
    
    def _display_heroes(self, heroes: List[Dict[str, Any]]):
        """Display heroes in treeview"""
        # Clear existing
        for item in self.tree.get_children():
            self.tree.delete(item)
        
        # Sort
        def get_sort_key(h):
            val = h.get(self.sort_column, 0)
            if isinstance(val, str):
                return val.lower()
            return val or 0
        
        sorted_heroes = sorted(heroes, key=get_sort_key, reverse=self.sort_reverse)
        
        # Add heroes
        for hero in sorted_heroes:
            level = hero.get('level', 0)
            hero_type = hero.get('hero_type', 'regular')
            
            # Determine display type
            if level >= 120:
                type_str = "Ring"
            elif hero_type == 'historic':
                type_str = "HH"
            else:
                type_str = "Reg"
            
            values = (
                hero.get('name', 'Unknown'),
                level,
                f"{hero.get('attack', 0):.1f}",
                hero.get('politics', 0),
                hero.get('intelligence', 0),
                hero.get('loyalty', 0),
                hero.get('speed', 0),
                hero.get('city_name', '-'),
                type_str,
                hero.get('status', '-')
            )
            
            self.tree.insert("", "end", values=values)
        
        self.count_label.config(text=f"Heroes: {len(sorted_heroes)}")
    
    def set_heroes(self, heroes: List[Dict[str, Any]]):
        """Set and display hero data"""
        self.heroes = heroes
        
        # Count by type
        ring_count = sum(1 for h in heroes if h.get('level', 0) >= 120)
        hh_count = sum(1 for h in heroes if h.get('hero_type') == 'historic')
        
        self.ring_label.config(text=f"Ring: {ring_count}")
        self.hh_label.config(text=f"HH: {hh_count}")
        
        # Apply current filter
        self._apply_filter()
    
    def clear(self):
        """Clear all hero data"""
        self.heroes = []
        self.filtered_heroes = []
        self.count_label.config(text="Heroes: 0")
        self.ring_label.config(text="Ring: 0")
        self.hh_label.config(text="HH: 0")
        for item in self.tree.get_children():
            self.tree.delete(item)
