"""
ETK SOL Manager - Cities Tab
Displays city data with resources and troops per city
"""

import tkinter as tk
from tkinter import ttk
from typing import Optional, Dict, List, Any

from ...theme import RoboEvonyTheme as Theme


class CitiesTab(ttk.Frame):
    """
    Cities data display tab.
    Shows list of cities with coordinates, resources, and troop counts.
    """
    
    def __init__(self, parent, **kwargs):
        super().__init__(parent, **kwargs)
        self.cities: List[Dict[str, Any]] = []
        self._setup_ui()
    
    def _setup_ui(self):
        """Setup the cities tab UI"""
        self.columnconfigure(0, weight=1)
        self.rowconfigure(1, weight=1)
        
        # Header with city count
        header = ttk.Frame(self)
        header.grid(row=0, column=0, sticky="ew", padx=5, pady=5)
        
        self.count_label = ttk.Label(
            header, 
            text="Cities: 0",
            font=('Segoe UI', 11, 'bold')
        )
        self.count_label.pack(side="left")
        
        # Refresh button
        ttk.Button(header, text="Refresh", command=self._refresh).pack(side="right")
        
        # Cities treeview
        self._create_treeview()
    
    def _create_treeview(self):
        """Create the cities treeview"""
        tree_frame = ttk.Frame(self)
        tree_frame.grid(row=1, column=0, sticky="nsew", padx=5, pady=5)
        tree_frame.columnconfigure(0, weight=1)
        tree_frame.rowconfigure(0, weight=1)
        
        columns = (
            "name", "coords", "gold", "food", "lumber", 
            "stone", "iron", "troops", "mayor"
        )
        
        self.tree = ttk.Treeview(tree_frame, columns=columns, show="headings")
        
        # Define headings
        self.tree.heading("name", text="City Name")
        self.tree.heading("coords", text="Coords")
        self.tree.heading("gold", text="Gold")
        self.tree.heading("food", text="Food")
        self.tree.heading("lumber", text="Lumber")
        self.tree.heading("stone", text="Stone")
        self.tree.heading("iron", text="Iron")
        self.tree.heading("troops", text="Troops")
        self.tree.heading("mayor", text="Mayor")
        
        # Column widths
        self.tree.column("name", width=120)
        self.tree.column("coords", width=80)
        self.tree.column("gold", width=80)
        self.tree.column("food", width=80)
        self.tree.column("lumber", width=80)
        self.tree.column("stone", width=80)
        self.tree.column("iron", width=80)
        self.tree.column("troops", width=80)
        self.tree.column("mayor", width=100)
        
        self.tree.grid(row=0, column=0, sticky="nsew")
        
        # Scrollbars
        vsb = ttk.Scrollbar(tree_frame, orient="vertical", command=self.tree.yview)
        vsb.grid(row=0, column=1, sticky="ns")
        self.tree.configure(yscrollcommand=vsb.set)
        
        hsb = ttk.Scrollbar(tree_frame, orient="horizontal", command=self.tree.xview)
        hsb.grid(row=1, column=0, sticky="ew")
        self.tree.configure(xscrollcommand=hsb.set)
        
        # Bind selection
        self.tree.bind("<<TreeviewSelect>>", self._on_city_select)
    
    def _on_city_select(self, event):
        """Handle city selection"""
        selection = self.tree.selection()
        if selection:
            item = self.tree.item(selection[0])
            # Could show detailed city info in a panel
    
    def _refresh(self):
        """Refresh city display"""
        self.set_cities(self.cities)
    
    def set_cities(self, cities: List[Dict[str, Any]]):
        """Set and display city data"""
        self.cities = cities
        self.count_label.config(text=f"Cities: {len(cities)}")
        
        # Clear existing
        for item in self.tree.get_children():
            self.tree.delete(item)
        
        # Add cities
        for city in cities:
            resources = city.get('resources', {})
            coords = f"({city.get('x', 0)}, {city.get('y', 0)})"
            
            values = (
                city.get('name', 'Unknown'),
                coords,
                self._format_num(resources.get('gold', 0)),
                self._format_num(resources.get('food', 0)),
                self._format_num(resources.get('lumber', 0)),
                self._format_num(resources.get('stone', 0)),
                self._format_num(resources.get('iron', 0)),
                self._format_num(city.get('total_troops', sum(city.get('troops', {}).values()))),
                city.get('mayor_name', '-')
            )
            
            self.tree.insert("", "end", values=values)
    
    def _format_num(self, num) -> str:
        """Format number with abbreviations"""
        try:
            num = int(num)
            if num >= 1_000_000_000:
                return f"{num/1_000_000_000:.1f}B"
            elif num >= 1_000_000:
                return f"{num/1_000_000:.1f}M"
            elif num >= 1_000:
                return f"{num/1_000:.1f}K"
            return str(num)
        except (ValueError, TypeError):
            return "0"
    
    def clear(self):
        """Clear all city data"""
        self.cities = []
        self.count_label.config(text="Cities: 0")
        for item in self.tree.get_children():
            self.tree.delete(item)
