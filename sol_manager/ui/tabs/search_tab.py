"""
ETK SOL Manager - Search Tab
Cross-account search and comparison functionality
"""

import tkinter as tk
from tkinter import ttk
from typing import Optional, Dict, List, Any, Callable

from ...theme import RoboEvonyTheme as Theme


class SearchTab(ttk.Frame):
    """
    Cross-account search and comparison tab.
    
    Features:
    - Search across all accounts
    - Find accounts by: gold, food, troops, items, heroes
    - Sort/rank accounts by various criteria
    - Quick filters for common searches
    """
    
    def __init__(self, parent, **kwargs):
        super().__init__(parent, **kwargs)
        self.accounts: Dict[str, Dict[str, Any]] = {}
        self.search_results: List[Dict[str, Any]] = []
        self.on_account_select: Optional[Callable] = None
        self._setup_ui()
    
    def _setup_ui(self):
        """Setup the search tab UI"""
        self.columnconfigure(0, weight=1)
        self.rowconfigure(2, weight=1)
        
        # Quick filters
        self._create_quick_filters()
        
        # Search controls
        self._create_search_controls()
        
        # Results display
        self._create_results_display()
    
    def _create_quick_filters(self):
        """Create quick filter buttons"""
        filter_frame = ttk.LabelFrame(self, text="Quick Filters")
        filter_frame.grid(row=0, column=0, sticky="ew", padx=5, pady=5)
        
        filters = [
            ("Most Gold", self._filter_most_gold),
            ("Most Food", self._filter_most_food),
            ("Most Troops", self._filter_most_troops),
            ("Has Ring Heroes", self._filter_ring_heroes),
            ("Has HH Heroes", self._filter_hh_heroes),
            ("Has Thunder Raids", self._filter_thunder_raids),
            ("All Accounts", self._show_all)
        ]
        
        for i, (text, command) in enumerate(filters):
            btn = ttk.Button(filter_frame, text=text, command=command, width=15)
            btn.grid(row=0, column=i, padx=3, pady=3)
    
    def _create_search_controls(self):
        """Create search input controls"""
        search_frame = ttk.LabelFrame(self, text="Custom Search")
        search_frame.grid(row=1, column=0, sticky="ew", padx=5, pady=5)
        
        # Search type
        ttk.Label(search_frame, text="Find accounts with:").grid(row=0, column=0, padx=5, pady=5)
        
        self.search_type_var = tk.StringVar(value="gold")
        search_types = [
            ("Gold ≥", "gold"),
            ("Food ≥", "food"),
            ("Troops ≥", "troops"),
            ("Heroes ≥", "heroes"),
            ("Item named", "item")
        ]
        
        for i, (text, value) in enumerate(search_types):
            rb = ttk.Radiobutton(search_frame, text=text, variable=self.search_type_var, value=value)
            rb.grid(row=0, column=i+1, padx=5)
        
        # Search value
        ttk.Label(search_frame, text="Value:").grid(row=1, column=0, padx=5, pady=5)
        self.search_value_var = tk.StringVar()
        search_entry = ttk.Entry(search_frame, textvariable=self.search_value_var, width=30)
        search_entry.grid(row=1, column=1, columnspan=3, padx=5, pady=5, sticky="w")
        
        # Search button
        ttk.Button(search_frame, text="Search", command=self._do_search).grid(row=1, column=4, padx=10)
        
        # Result count
        self.result_label = ttk.Label(search_frame, text="")
        self.result_label.grid(row=1, column=5, padx=10)
    
    def _create_results_display(self):
        """Create results treeview"""
        results_frame = ttk.LabelFrame(self, text="Results")
        results_frame.grid(row=2, column=0, sticky="nsew", padx=5, pady=5)
        results_frame.columnconfigure(0, weight=1)
        results_frame.rowconfigure(0, weight=1)
        
        columns = ("email", "player", "gold", "food", "cities", 
                   "troops", "heroes", "ring", "hh", "status")
        
        self.tree = ttk.Treeview(results_frame, columns=columns, show="headings")
        
        # Define headings with sorting
        headers = {
            "email": ("Email", 200),
            "player": ("Player", 100),
            "gold": ("Gold", 80),
            "food": ("Food", 80),
            "cities": ("Cities", 60),
            "troops": ("Troops", 80),
            "heroes": ("Heroes", 60),
            "ring": ("Ring", 50),
            "hh": ("HH", 50),
            "status": ("Status", 70)
        }
        
        for col, (header, width) in headers.items():
            self.tree.heading(col, text=header, command=lambda c=col: self._sort_results(c))
            self.tree.column(col, width=width, anchor="center" if col not in ["email", "player"] else "w")
        
        self.tree.grid(row=0, column=0, sticky="nsew")
        
        # Scrollbar
        vsb = ttk.Scrollbar(results_frame, orient="vertical", command=self.tree.yview)
        vsb.grid(row=0, column=1, sticky="ns")
        self.tree.configure(yscrollcommand=vsb.set)
        
        # Double-click to select
        self.tree.bind("<Double-1>", self._on_double_click)
        
        # Sort state
        self.sort_column = "gold"
        self.sort_reverse = True
    
    def _sort_results(self, column: str):
        """Sort results by column"""
        if self.sort_column == column:
            self.sort_reverse = not self.sort_reverse
        else:
            self.sort_column = column
            self.sort_reverse = column in ["gold", "food", "troops", "heroes", "ring", "hh"]
        
        self._display_results(self.search_results)
    
    def _on_double_click(self, event):
        """Handle double-click on result"""
        selection = self.tree.selection()
        if selection and self.on_account_select:
            item = self.tree.item(selection[0])
            email = item['values'][0]
            if email in self.accounts:
                self.on_account_select(email)
    
    def _filter_most_gold(self):
        """Show accounts sorted by gold"""
        self.sort_column = "gold"
        self.sort_reverse = True
        self.search_results = list(self.accounts.values())
        self._display_results(self.search_results)
        self.result_label.config(text=f"Sorted by gold ({len(self.search_results)} accounts)")
    
    def _filter_most_food(self):
        """Show accounts sorted by food"""
        self.sort_column = "food"
        self.sort_reverse = True
        self.search_results = list(self.accounts.values())
        self._display_results(self.search_results)
        self.result_label.config(text=f"Sorted by food ({len(self.search_results)} accounts)")
    
    def _filter_most_troops(self):
        """Show accounts sorted by troops"""
        self.sort_column = "troops"
        self.sort_reverse = True
        self.search_results = list(self.accounts.values())
        self._display_results(self.search_results)
        self.result_label.config(text=f"Sorted by troops ({len(self.search_results)} accounts)")
    
    def _filter_ring_heroes(self):
        """Show accounts with ring heroes"""
        self.search_results = [
            acc for acc in self.accounts.values()
            if acc.get('summary', {}).get('ring_heroes', 0) > 0
        ]
        self.sort_column = "ring"
        self.sort_reverse = True
        self._display_results(self.search_results)
        self.result_label.config(text=f"Found {len(self.search_results)} accounts with Ring Heroes")
    
    def _filter_hh_heroes(self):
        """Show accounts with HH heroes"""
        self.search_results = [
            acc for acc in self.accounts.values()
            if acc.get('summary', {}).get('hh_heroes', 0) > 0
        ]
        self.sort_column = "hh"
        self.sort_reverse = True
        self._display_results(self.search_results)
        self.result_label.config(text=f"Found {len(self.search_results)} accounts with HH Heroes")
    
    def _filter_thunder_raids(self):
        """Show accounts with thunder raids"""
        self.search_results = [
            acc for acc in self.accounts.values()
            if self._get_item_count(acc, 'Thunder_Raid') > 0
        ]
        self._display_results(self.search_results)
        self.result_label.config(text=f"Found {len(self.search_results)} accounts with Thunder Raids")
    
    def _show_all(self):
        """Show all accounts"""
        self.search_results = list(self.accounts.values())
        self._display_results(self.search_results)
        self.result_label.config(text=f"All {len(self.search_results)} accounts")
    
    def _do_search(self):
        """Execute custom search"""
        search_type = self.search_type_var.get()
        search_value = self.search_value_var.get().strip()
        
        if not search_value:
            return
        
        self.search_results = []
        
        if search_type == "item":
            # Search for item by name
            search_lower = search_value.lower()
            for acc in self.accounts.values():
                items = acc.get('items', {})
                for cat_items in items.values():
                    for item in cat_items:
                        if search_lower in item.get('name', '').lower().replace('_', ' '):
                            if item.get('count', 0) > 0:
                                self.search_results.append(acc)
                                break
                    else:
                        continue
                    break
        else:
            # Numeric search
            try:
                threshold = int(search_value.replace(',', '').replace('M', '000000').replace('K', '000'))
            except ValueError:
                self.result_label.config(text="Invalid number")
                return
            
            for acc in self.accounts.values():
                summary = acc.get('summary', {})
                
                if search_type == "gold" and summary.get('total_gold', 0) >= threshold:
                    self.search_results.append(acc)
                elif search_type == "food" and summary.get('total_food', 0) >= threshold:
                    self.search_results.append(acc)
                elif search_type == "troops" and summary.get('total_troops', 0) >= threshold:
                    self.search_results.append(acc)
                elif search_type == "heroes" and summary.get('total_heroes', 0) >= threshold:
                    self.search_results.append(acc)
        
        self._display_results(self.search_results)
        self.result_label.config(text=f"Found {len(self.search_results)} accounts")
    
    def _get_item_count(self, account: Dict, item_name: str) -> int:
        """Get count of specific item in account"""
        items = account.get('items', {})
        for cat_items in items.values():
            for item in cat_items:
                if item.get('name', '').lower() == item_name.lower():
                    return item.get('count', 0)
        return 0
    
    def _display_results(self, results: List[Dict[str, Any]]):
        """Display search results"""
        # Clear existing
        for item in self.tree.get_children():
            self.tree.delete(item)
        
        # Sort
        def get_sort_key(acc):
            summary = acc.get('summary', {})
            if self.sort_column == "email":
                return acc.get('email', '').lower()
            elif self.sort_column == "player":
                return acc.get('player_name', '').lower()
            elif self.sort_column == "gold":
                return summary.get('total_gold', 0)
            elif self.sort_column == "food":
                return summary.get('total_food', 0)
            elif self.sort_column == "cities":
                return summary.get('total_cities', 0)
            elif self.sort_column == "troops":
                return summary.get('total_troops', 0)
            elif self.sort_column == "heroes":
                return summary.get('total_heroes', 0)
            elif self.sort_column == "ring":
                return summary.get('ring_heroes', 0)
            elif self.sort_column == "hh":
                return summary.get('hh_heroes', 0)
            return 0
        
        sorted_results = sorted(results, key=get_sort_key, reverse=self.sort_reverse)
        
        # Add results
        for acc in sorted_results:
            summary = acc.get('summary', {})
            
            values = (
                acc.get('email', 'Unknown'),
                acc.get('player_name', '-'),
                self._fmt(summary.get('total_gold', 0)),
                self._fmt(summary.get('total_food', 0)),
                summary.get('total_cities', 0),
                self._fmt(summary.get('total_troops', 0)),
                summary.get('total_heroes', 0),
                summary.get('ring_heroes', 0),
                summary.get('hh_heroes', 0),
                acc.get('status', 'unknown')
            )
            
            self.tree.insert("", "end", values=values)
    
    def _fmt(self, num) -> str:
        """Format number"""
        try:
            num = int(num)
            if num >= 1_000_000_000:
                return f"{num/1_000_000_000:.1f}B"
            elif num >= 1_000_000:
                return f"{num/1_000_000:.1f}M"
            elif num >= 1_000:
                return f"{num/1_000:.0f}K"
            return str(num)
        except:
            return "0"
    
    def set_accounts(self, accounts: Dict[str, Dict[str, Any]]):
        """Set accounts for searching"""
        self.accounts = accounts
        self._show_all()
    
    def clear(self):
        """Clear search results"""
        self.accounts = {}
        self.search_results = []
        self.result_label.config(text="")
        for item in self.tree.get_children():
            self.tree.delete(item)
