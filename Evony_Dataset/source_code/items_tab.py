"""
ETK SOL Manager - Items Tab
Displays item inventory with category filtering
"""

import tkinter as tk
from tkinter import ttk
from typing import Optional, Dict, List, Any

from ...theme import RoboEvonyTheme as Theme
from ...data_models.item_data import ItemCategory, VALUABLE_ITEMS


class ItemsTab(ttk.Frame):
    """
    Items data display tab.
    Shows item inventory with category filtering like the game UI.
    """
    
    def __init__(self, parent, **kwargs):
        super().__init__(parent, **kwargs)
        self.items: Dict[str, List[Dict[str, Any]]] = {}
        self.all_items: List[Dict[str, Any]] = []
        self._setup_ui()
    
    def _setup_ui(self):
        """Setup the items tab UI"""
        self.columnconfigure(0, weight=1)
        self.rowconfigure(1, weight=1)
        
        # Filter header
        self._create_filter_header()
        
        # Items display
        self._create_items_display()
    
    def _create_filter_header(self):
        """Create filter controls"""
        header = ttk.Frame(self)
        header.grid(row=0, column=0, sticky="ew", padx=5, pady=5)
        
        # Item count
        self.count_label = ttk.Label(
            header, 
            text="Items: 0",
            font=('Segoe UI', 11, 'bold')
        )
        self.count_label.pack(side="left")
        
        # Category filter
        ttk.Label(header, text="  View by Type:").pack(side="left", padx=(20, 5))
        
        self.category_var = tk.StringVar(value="All")
        categories = ["All", "Valuable", "Items", "Chests", "Resources", 
                     "Stratagems", "Teleporters", "Speed Ups", "Medals", "Materials"]
        
        category_combo = ttk.Combobox(
            header, 
            textvariable=self.category_var,
            values=categories,
            state="readonly",
            width=15
        )
        category_combo.pack(side="left")
        category_combo.bind("<<ComboboxSelected>>", self._apply_filter)
        
        # Search
        ttk.Label(header, text="  Search:").pack(side="left", padx=(20, 5))
        self.search_var = tk.StringVar()
        search_entry = ttk.Entry(header, textvariable=self.search_var, width=20)
        search_entry.pack(side="left")
        search_entry.bind("<KeyRelease>", self._apply_filter)
        
        # Quick stats
        stats_frame = ttk.Frame(header)
        stats_frame.pack(side="right", padx=10)
        
        self.thunder_label = ttk.Label(stats_frame, text="TR: 0", foreground="#FF6B6B")
        self.thunder_label.pack(side="left", padx=5)
        
        self.fleet_label = ttk.Label(stats_frame, text="FF: 0", foreground="#4ECDC4")
        self.fleet_label.pack(side="left", padx=5)
        
        self.speaker_label = ttk.Label(stats_frame, text="Sp: 0", foreground="#FFE66D")
        self.speaker_label.pack(side="left", padx=5)
    
    def _create_items_display(self):
        """Create items treeview"""
        tree_frame = ttk.Frame(self)
        tree_frame.grid(row=1, column=0, sticky="nsew", padx=5, pady=5)
        tree_frame.columnconfigure(0, weight=1)
        tree_frame.rowconfigure(0, weight=1)
        
        columns = ("name", "count", "category", "description")
        
        self.tree = ttk.Treeview(tree_frame, columns=columns, show="headings")
        
        # Define headings
        self.tree.heading("name", text="Item Name", command=lambda: self._sort_by("name"))
        self.tree.heading("count", text="Count", command=lambda: self._sort_by("count"))
        self.tree.heading("category", text="Category")
        self.tree.heading("description", text="Description")
        
        self.tree.column("name", width=200)
        self.tree.column("count", width=80, anchor="center")
        self.tree.column("category", width=120)
        self.tree.column("description", width=400)
        
        self.tree.grid(row=0, column=0, sticky="nsew")
        
        # Scrollbars
        vsb = ttk.Scrollbar(tree_frame, orient="vertical", command=self.tree.yview)
        vsb.grid(row=0, column=1, sticky="ns")
        self.tree.configure(yscrollcommand=vsb.set)
        
        # Sort tracking
        self.sort_column = "count"
        self.sort_reverse = True
    
    def _sort_by(self, column: str):
        """Sort by column"""
        if self.sort_column == column:
            self.sort_reverse = not self.sort_reverse
        else:
            self.sort_column = column
            self.sort_reverse = column == "count"
        
        self._apply_filter()
    
    def _apply_filter(self, event=None):
        """Apply category and search filters"""
        category = self.category_var.get()
        search_text = self.search_var.get().lower()
        
        filtered = []
        
        for item in self.all_items:
            item_name = item.get('name', '')
            item_cat = item.get('category', 'Items')
            item_desc = item.get('description', '')
            
            # Category filter
            if category == "Valuable":
                if item_name not in VALUABLE_ITEMS:
                    continue
            elif category != "All":
                if category.lower() not in item_cat.lower():
                    continue
            
            # Search filter
            if search_text:
                display_name = item_name.replace("_", " ").lower()
                if search_text not in display_name and search_text not in item_desc.lower():
                    continue
            
            # Skip zero count items
            if item.get('count', 0) <= 0:
                continue
            
            filtered.append(item)
        
        self._display_items(filtered)
    
    def _display_items(self, items: List[Dict[str, Any]]):
        """Display items in treeview"""
        # Clear existing
        for tree_item in self.tree.get_children():
            self.tree.delete(tree_item)
        
        # Sort
        def get_sort_key(i):
            if self.sort_column == "count":
                return i.get('count', 0)
            elif self.sort_column == "name":
                return i.get('name', '').lower()
            return i.get(self.sort_column, '')
        
        sorted_items = sorted(items, key=get_sort_key, reverse=self.sort_reverse)
        
        # Add items
        for item in sorted_items:
            name = item.get('name', 'Unknown').replace("_", " ")
            count = item.get('count', 0)
            category = item.get('category', 'Items')
            desc = item.get('description', '')[:100]  # Truncate long descriptions
            
            values = (name, f"{count:,}", category, desc)
            
            # Tag valuable items
            tags = ()
            if item.get('name') in VALUABLE_ITEMS:
                tags = ('valuable',)
            
            self.tree.insert("", "end", values=values, tags=tags)
        
        # Configure tag
        self.tree.tag_configure('valuable', foreground='#FFD700')
        
        self.count_label.config(text=f"Items: {len(sorted_items)}")
    
    def set_items(self, items: Dict[str, List[Dict[str, Any]]]):
        """Set and display item data from categorized dict"""
        self.items = items
        
        # Flatten to list
        self.all_items = []
        for category, item_list in items.items():
            for item in item_list:
                item['category'] = category
                self.all_items.append(item)
        
        # Update quick stats
        thunder = sum(i.get('count', 0) for i in self.all_items 
                     if 'thunder' in i.get('name', '').lower())
        fleet = sum(i.get('count', 0) for i in self.all_items 
                   if 'fleet' in i.get('name', '').lower())
        speaker = sum(i.get('count', 0) for i in self.all_items 
                     if i.get('name', '').lower() == 'speaker')
        
        self.thunder_label.config(text=f"TR: {thunder:,}")
        self.fleet_label.config(text=f"FF: {fleet:,}")
        self.speaker_label.config(text=f"Sp: {speaker:,}")
        
        # Apply filter
        self._apply_filter()
    
    def set_items_list(self, items: List[Dict[str, Any]]):
        """Set items from flat list"""
        self.all_items = items
        
        # Update quick stats
        thunder = sum(i.get('count', 0) for i in items 
                     if 'thunder' in i.get('name', '').lower())
        fleet = sum(i.get('count', 0) for i in items 
                   if 'fleet' in i.get('name', '').lower())
        speaker = sum(i.get('count', 0) for i in items 
                     if i.get('name', '').lower() == 'speaker')
        
        self.thunder_label.config(text=f"TR: {thunder:,}")
        self.fleet_label.config(text=f"FF: {fleet:,}")
        self.speaker_label.config(text=f"Sp: {speaker:,}")
        
        self._apply_filter()
    
    def clear(self):
        """Clear all item data"""
        self.items = {}
        self.all_items = []
        self.count_label.config(text="Items: 0")
        self.thunder_label.config(text="TR: 0")
        self.fleet_label.config(text="FF: 0")
        self.speaker_label.config(text="Sp: 0")
        for item in self.tree.get_children():
            self.tree.delete(item)
