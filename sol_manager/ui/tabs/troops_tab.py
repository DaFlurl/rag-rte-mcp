"""
ETK SOL Manager - Troops Tab
Displays troop data per city and totals
"""

import tkinter as tk
from tkinter import ttk
from typing import Optional, Dict, List, Any

from ...theme import RoboEvonyTheme as Theme
from ...data_models.troop_data import TROOP_TYPES


class TroopsTab(ttk.Frame):
    """
    Troops data display tab.
    Shows troop counts per city and account totals.
    """
    
    def __init__(self, parent, **kwargs):
        super().__init__(parent, **kwargs)
        self.troop_data: Dict[str, Any] = {}
        self._setup_ui()
    
    def _setup_ui(self):
        """Setup the troops tab UI"""
        self.columnconfigure(0, weight=1)
        self.rowconfigure(1, weight=1)
        
        # Summary header
        self._create_summary_header()
        
        # Troops by city treeview
        self._create_treeview()
    
    def _create_summary_header(self):
        """Create troops summary header"""
        header = ttk.LabelFrame(self, text="Total Troops")
        header.grid(row=0, column=0, sticky="ew", padx=5, pady=5)
        
        # Create grid of troop type totals
        troop_types = [
            ("Workers", "wo"), ("Warriors", "w"), ("Scouts", "s"),
            ("Pikemen", "p"), ("Swordsmen", "sw"), ("Archers", "a"),
            ("Cavalry", "c"), ("Cataphracts", "cata"), ("Transporters", "t"),
            ("Rams", "r"), ("Ballistas", "b"), ("Catapults", "cp")
        ]
        
        self.troop_labels = {}
        
        for i, (name, code) in enumerate(troop_types):
            row = i // 6
            col = i % 6
            
            frame = ttk.Frame(header)
            frame.grid(row=row, column=col, padx=10, pady=3)
            
            ttk.Label(frame, text=name, font=('Segoe UI', 9)).pack()
            lbl = ttk.Label(frame, text="0", font=('Segoe UI', 10, 'bold'))
            lbl.pack()
            self.troop_labels[code] = lbl
    
    def _create_treeview(self):
        """Create troops by city treeview"""
        tree_frame = ttk.LabelFrame(self, text="Troops by City")
        tree_frame.grid(row=1, column=0, sticky="nsew", padx=5, pady=5)
        tree_frame.columnconfigure(0, weight=1)
        tree_frame.rowconfigure(0, weight=1)
        
        columns = ("city", "workers", "warriors", "scouts", "pikemen", 
                   "swordsmen", "archers", "cavalry", "cataphracts",
                   "transporters", "rams", "ballistas", "catapults", "total")
        
        self.tree = ttk.Treeview(tree_frame, columns=columns, show="headings")
        
        # Define headings
        headers = {
            "city": "City", "workers": "Wo", "warriors": "Wa", "scouts": "Sc",
            "pikemen": "Pk", "swordsmen": "Sw", "archers": "Ar", "cavalry": "Cv",
            "cataphracts": "Ct", "transporters": "Tr", "rams": "Rm",
            "ballistas": "Ba", "catapults": "Cp", "total": "Total"
        }
        
        for col, header in headers.items():
            self.tree.heading(col, text=header)
            width = 80 if col == "city" else 50
            self.tree.column(col, width=width, anchor="center")
        
        self.tree.grid(row=0, column=0, sticky="nsew")
        
        # Scrollbars
        vsb = ttk.Scrollbar(tree_frame, orient="vertical", command=self.tree.yview)
        vsb.grid(row=0, column=1, sticky="ns")
        self.tree.configure(yscrollcommand=vsb.set)
        
        hsb = ttk.Scrollbar(tree_frame, orient="horizontal", command=self.tree.xview)
        hsb.grid(row=1, column=0, sticky="ew")
        self.tree.configure(xscrollcommand=hsb.set)
    
    def set_troops(self, cities: List[Dict[str, Any]], totals: Dict[str, int] = None):
        """Set and display troop data"""
        # Clear existing
        for item in self.tree.get_children():
            self.tree.delete(item)
        
        # Calculate totals if not provided
        if totals is None:
            totals = {code: 0 for code in self.troop_labels.keys()}
        
        # Add cities
        for city in cities:
            troops = city.get('troops', {})
            
            # Map troop names to values
            wo = troops.get('workers', troops.get('worker', 0))
            wa = troops.get('warriors', troops.get('warrior', 0))
            sc = troops.get('scouts', troops.get('scout', 0))
            pk = troops.get('pikemen', troops.get('pike', 0))
            sw = troops.get('swordsmen', troops.get('sword', 0))
            ar = troops.get('archers', troops.get('archer', 0))
            cv = troops.get('cavalry', 0)
            ct = troops.get('cataphracts', troops.get('cataphract', 0))
            tr = troops.get('transporters', troops.get('transporter', 0))
            rm = troops.get('rams', troops.get('ram', 0))
            ba = troops.get('ballistas', troops.get('ballista', 0))
            cp = troops.get('catapults', troops.get('catapult', 0))
            
            total = wo + wa + sc + pk + sw + ar + cv + ct + tr + rm + ba + cp
            
            values = (
                city.get('name', 'Unknown'),
                self._fmt(wo), self._fmt(wa), self._fmt(sc), self._fmt(pk),
                self._fmt(sw), self._fmt(ar), self._fmt(cv), self._fmt(ct),
                self._fmt(tr), self._fmt(rm), self._fmt(ba), self._fmt(cp),
                self._fmt(total)
            )
            
            self.tree.insert("", "end", values=values)
            
            # Update totals
            totals['wo'] = totals.get('wo', 0) + wo
            totals['w'] = totals.get('w', 0) + wa
            totals['s'] = totals.get('s', 0) + sc
            totals['p'] = totals.get('p', 0) + pk
            totals['sw'] = totals.get('sw', 0) + sw
            totals['a'] = totals.get('a', 0) + ar
            totals['c'] = totals.get('c', 0) + cv
            totals['cata'] = totals.get('cata', 0) + ct
            totals['t'] = totals.get('t', 0) + tr
            totals['r'] = totals.get('r', 0) + rm
            totals['b'] = totals.get('b', 0) + ba
            totals['cp'] = totals.get('cp', 0) + cp
        
        # Update summary labels
        for code, lbl in self.troop_labels.items():
            lbl.config(text=self._fmt(totals.get(code, 0)))
    
    def _fmt(self, num) -> str:
        """Format number"""
        try:
            num = int(num)
            if num >= 1_000_000:
                return f"{num/1_000_000:.1f}M"
            elif num >= 1_000:
                return f"{num/1_000:.0f}K"
            return str(num)
        except:
            return "0"
    
    def clear(self):
        """Clear all troop data"""
        for item in self.tree.get_children():
            self.tree.delete(item)
        for lbl in self.troop_labels.values():
            lbl.config(text="0")
