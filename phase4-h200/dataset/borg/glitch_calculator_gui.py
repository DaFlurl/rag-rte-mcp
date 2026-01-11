#!/usr/bin/env python3
"""
Glitch Calculator GUI - Optimal Food Glitch Configuration Tool
==============================================================
Calculate exact troop counts for maximum food generation.

Features:
- Adjust glitch count per troop type
- See real-time food generation vs consumption
- Preset "goldilocks" configurations for +8B to +12B net food
- Parse existing glitch counter output
- Export configurations as scripts

Key Rule: ODD glitches = GENERATING FOOD (+2,147,483,647/hr per type)
"""

import tkinter as tk
from tkinter import ttk, filedialog, messagebox, scrolledtext
import json
import re
from dataclasses import dataclass
from typing import Dict, List, Tuple, Optional

# Constants
INT32_MAX = 2_147_483_647
FOOD_PER_GLITCH = INT32_MAX  # Food generated per ODD glitch type

@dataclass
class TroopType:
    name: str
    abbr: str
    food_cost: int
    city_threshold: int
    valley_threshold: int
    priority: str  # "high", "medium", "low"
    
    @property
    def glitch_efficiency(self) -> float:
        """Higher = more efficient for glitching (more glitches per food consumed)"""
        return self.city_threshold / self.food_cost

# Troop definitions - ordered by food cost (highest first for display)
TROOPS = [
    TroopType("Catapults", "cp", 125, 17_179_870, 8_589_935, "high"),
    TroopType("Battering Rams", "r", 50, 42_949_673, 21_474_836, "high"),
    TroopType("Ballista", "b", 25, 85_899_346, 42_949_673, "high"),
    TroopType("Cataphracts", "cata", 17, 126_322_568, 63_161_284, "high"),
    TroopType("Cavalry", "c", 9, 238_609_295, 119_304_647, "high"),
    TroopType("Transporters", "t", 5, 429_496_730, 214_748_365, "medium"),
    TroopType("Archers", "a", 4, 536_870_912, 268_435_456, "high"),
    TroopType("Swordsmen", "sw", 3, 715_827_883, 357_913_941, "low"),
    TroopType("Pikemen", "p", 3, 715_827_883, 357_913_941, "low"),
    TroopType("Scouts", "s", 2, 1_073_741_824, 536_870_912, "low"),
    TroopType("Warriors", "w", 1, 2_147_483_648, 1_073_741_824, "low"),
    TroopType("Workers", "wo", 1, 2_147_483_648, 1_073_741_824, "low"),
]

# Preset configurations - goldilocks zone for +8B to +12B net food
PRESETS = {
    "Maximum Food (+12B)": {
        "description": "Maximum food generation - all high-value troops at ODD glitches",
        "glitches": {
            "Catapults": 101,      # 101 glitches = ODD = generating
            "Battering Rams": 41,  # 41 glitches = ODD
            "Ballista": 21,        # 21 glitches = ODD
            "Cataphracts": 15,     # 15 glitches = ODD
            "Cavalry": 9,          # 9 glitches = ODD
            "Transporters": 5,     # 5 glitches = ODD
            "Archers": 3,          # 3 glitches = ODD
            "Swordsmen": 1,        # 1 glitch = ODD (minimal)
            "Pikemen": 1,          # 1 glitch = ODD (minimal)
            "Scouts": 1,           # 1 glitch = ODD (minimal)
            "Warriors": 0,         # Skip - too expensive threshold
            "Workers": 0,          # Skip - too expensive threshold
        }
    },
    "Balanced (+10B)": {
        "description": "Good balance of troops and food generation",
        "glitches": {
            "Catapults": 81,
            "Battering Rams": 33,
            "Ballista": 17,
            "Cataphracts": 13,
            "Cavalry": 7,
            "Transporters": 3,
            "Archers": 3,
            "Swordsmen": 1,
            "Pikemen": 1,
            "Scouts": 1,
            "Warriors": 0,
            "Workers": 0,
        }
    },
    "Conservative (+8B)": {
        "description": "Lower troop counts, still positive food",
        "glitches": {
            "Catapults": 61,
            "Battering Rams": 25,
            "Ballista": 13,
            "Cataphracts": 11,
            "Cavalry": 5,
            "Transporters": 3,
            "Archers": 3,
            "Swordsmen": 1,
            "Pikemen": 1,
            "Scouts": 1,
            "Warriors": 0,
            "Workers": 0,
        }
    },
    "Mech Heavy (+11B)": {
        "description": "Focus on mechs (catapults, rams, ballista) for maximum efficiency",
        "glitches": {
            "Catapults": 121,      # Highest priority - most efficient
            "Battering Rams": 51,
            "Ballista": 25,
            "Cataphracts": 11,
            "Cavalry": 5,
            "Transporters": 3,
            "Archers": 1,
            "Swordsmen": 0,
            "Pikemen": 0,
            "Scouts": 1,
            "Warriors": 0,
            "Workers": 0,
        }
    },
    "Horse Focus (+9B)": {
        "description": "Balance mechs with cavalry/cataphracts",
        "glitches": {
            "Catapults": 71,
            "Battering Rams": 31,
            "Ballista": 15,
            "Cataphracts": 21,     # More cataphracts
            "Cavalry": 13,         # More cavalry
            "Transporters": 3,
            "Archers": 3,
            "Swordsmen": 1,
            "Pikemen": 1,
            "Scouts": 1,
            "Warriors": 0,
            "Workers": 0,
        }
    },
    "Minimum Viable (+5B)": {
        "description": "Minimum troops needed for positive food",
        "glitches": {
            "Catapults": 41,
            "Battering Rams": 17,
            "Ballista": 9,
            "Cataphracts": 7,
            "Cavalry": 3,
            "Transporters": 1,
            "Archers": 1,
            "Swordsmen": 0,
            "Pikemen": 0,
            "Scouts": 1,
            "Warriors": 0,
            "Workers": 0,
        }
    },
    "All Types Active (+7B)": {
        "description": "All 12 troop types generating (for achievements/variety)",
        "glitches": {
            "Catapults": 51,
            "Battering Rams": 21,
            "Ballista": 11,
            "Cataphracts": 9,
            "Cavalry": 5,
            "Transporters": 3,
            "Archers": 3,
            "Swordsmen": 1,
            "Pikemen": 1,
            "Scouts": 1,
            "Warriors": 1,
            "Workers": 1,
        }
    },
    "Ultra Mech (+15B)": {
        "description": "Maximum mechs for highest food - requires massive troops",
        "glitches": {
            "Catapults": 151,
            "Battering Rams": 71,
            "Ballista": 35,
            "Cataphracts": 17,
            "Cavalry": 9,
            "Transporters": 5,
            "Archers": 3,
            "Swordsmen": 0,
            "Pikemen": 0,
            "Scouts": 0,
            "Warriors": 0,
            "Workers": 0,
        }
    },
}


class GlitchCalculatorGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("Evony Glitch Calculator - Goldilocks Zone Finder")
        self.root.geometry("1200x900")
        self.root.configure(bg='#1a1a2e')
        
        # Style
        self.style = ttk.Style()
        self.style.theme_use('clam')
        self.configure_styles()
        
        # Variables for each troop type
        self.glitch_vars = {}
        self.troop_labels = {}
        self.result_labels = {}
        
        self.create_widgets()
        self.apply_preset("Balanced (+10B)")
        
    def configure_styles(self):
        """Configure ttk styles for dark theme"""
        self.style.configure('TFrame', background='#1a1a2e')
        self.style.configure('TLabel', background='#1a1a2e', foreground='#e0e0e0', font=('Consolas', 10))
        self.style.configure('Title.TLabel', font=('Consolas', 14, 'bold'), foreground='#ffd700')
        self.style.configure('Header.TLabel', font=('Consolas', 11, 'bold'), foreground='#00ffff')
        self.style.configure('Good.TLabel', foreground='#00ff00')
        self.style.configure('Bad.TLabel', foreground='#ff4444')
        self.style.configure('Neutral.TLabel', foreground='#ffff00')
        self.style.configure('TButton', font=('Consolas', 10))
        self.style.configure('TScale', background='#1a1a2e')
        self.style.configure('TCombobox', font=('Consolas', 10))
        
    def create_widgets(self):
        """Create all GUI widgets"""
        # Main container
        main_frame = ttk.Frame(self.root)
        main_frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)
        
        # Title
        title = ttk.Label(main_frame, text="═══ EVONY GLITCH CALCULATOR ═══", style='Title.TLabel')
        title.pack(pady=(0, 5))
        
        subtitle = ttk.Label(main_frame, text="Find the Goldilocks Zone for +8B to +12B Net Food", 
                            style='Header.TLabel')
        subtitle.pack(pady=(0, 10))
        
        # Top controls frame
        controls_frame = ttk.Frame(main_frame)
        controls_frame.pack(fill=tk.X, pady=5)
        
        # Preset selector
        ttk.Label(controls_frame, text="Preset:", style='TLabel').pack(side=tk.LEFT, padx=5)
        self.preset_var = tk.StringVar(value="Balanced (+10B)")
        preset_combo = ttk.Combobox(controls_frame, textvariable=self.preset_var, 
                                    values=list(PRESETS.keys()), width=25, state='readonly')
        preset_combo.pack(side=tk.LEFT, padx=5)
        preset_combo.bind('<<ComboboxSelected>>', lambda e: self.apply_preset(self.preset_var.get()))
        
        # Buttons
        ttk.Button(controls_frame, text="Parse Output", command=self.parse_output).pack(side=tk.LEFT, padx=5)
        ttk.Button(controls_frame, text="Export Script", command=self.export_script).pack(side=tk.LEFT, padx=5)
        ttk.Button(controls_frame, text="Copy Summary", command=self.copy_summary).pack(side=tk.LEFT, padx=5)
        ttk.Button(controls_frame, text="Reset All", command=self.reset_all).pack(side=tk.LEFT, padx=5)
        
        # Main content - split into left (troops) and right (summary)
        content_frame = ttk.Frame(main_frame)
        content_frame.pack(fill=tk.BOTH, expand=True, pady=10)
        
        # Left side - Troop controls
        left_frame = ttk.Frame(content_frame)
        left_frame.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        
        # Troop header
        header_frame = ttk.Frame(left_frame)
        header_frame.pack(fill=tk.X, pady=5)
        
        ttk.Label(header_frame, text="Troop Type", width=15, style='Header.TLabel').grid(row=0, column=0, padx=5)
        ttk.Label(header_frame, text="Glitches", width=10, style='Header.TLabel').grid(row=0, column=1, padx=5)
        ttk.Label(header_frame, text="Troops Needed", width=18, style='Header.TLabel').grid(row=0, column=2, padx=5)
        ttk.Label(header_frame, text="Food/hr", width=15, style='Header.TLabel').grid(row=0, column=3, padx=5)
        ttk.Label(header_frame, text="Status", width=12, style='Header.TLabel').grid(row=0, column=4, padx=5)
        
        # Troop rows
        troops_frame = ttk.Frame(left_frame)
        troops_frame.pack(fill=tk.BOTH, expand=True)
        
        for i, troop in enumerate(TROOPS):
            self.create_troop_row(troops_frame, troop, i)
        
        # Right side - Summary
        right_frame = ttk.Frame(content_frame, width=350)
        right_frame.pack(side=tk.RIGHT, fill=tk.Y, padx=(20, 0))
        right_frame.pack_propagate(False)
        
        # Summary section
        summary_title = ttk.Label(right_frame, text="═══ SUMMARY ═══", style='Title.TLabel')
        summary_title.pack(pady=10)
        
        self.summary_frame = ttk.Frame(right_frame)
        self.summary_frame.pack(fill=tk.X, pady=5)
        
        # Create summary labels
        self.create_summary_labels()
        
        # Preset description
        desc_frame = ttk.Frame(right_frame)
        desc_frame.pack(fill=tk.X, pady=20)
        ttk.Label(desc_frame, text="Preset Info:", style='Header.TLabel').pack(anchor=tk.W)
        self.preset_desc = ttk.Label(desc_frame, text="", wraplength=300, style='TLabel')
        self.preset_desc.pack(anchor=tk.W, pady=5)
        
        # Tips section
        tips_frame = ttk.Frame(right_frame)
        tips_frame.pack(fill=tk.X, pady=10)
        ttk.Label(tips_frame, text="═══ TIPS ═══", style='Header.TLabel').pack(anchor=tk.W)
        tips_text = """
• ODD glitches = GENERATING food
• EVEN glitches = NOT generating
• Focus on mechs (cp, r, b) for efficiency
• Keep upper troops (wo, w, s, p, sw) minimal
• Target +8B to +12B net food per city
• Each glitch type generates +2.1B/hr
"""
        ttk.Label(tips_frame, text=tips_text, style='TLabel', justify=tk.LEFT).pack(anchor=tk.W)
        
    def create_troop_row(self, parent, troop: TroopType, row: int):
        """Create a row for troop type configuration"""
        frame = ttk.Frame(parent)
        frame.pack(fill=tk.X, pady=2)
        
        # Color based on priority
        name_color = {'high': '#00ff00', 'medium': '#ffff00', 'low': '#888888'}[troop.priority]
        
        # Troop name
        name_label = tk.Label(frame, text=f"{troop.name}", width=15, anchor='w',
                             bg='#1a1a2e', fg=name_color, font=('Consolas', 10, 'bold'))
        name_label.grid(row=0, column=0, padx=5)
        
        # Glitch count spinbox
        self.glitch_vars[troop.name] = tk.IntVar(value=0)
        spinbox = ttk.Spinbox(frame, from_=0, to=200, width=8, 
                             textvariable=self.glitch_vars[troop.name],
                             command=self.update_calculations)
        spinbox.grid(row=0, column=1, padx=5)
        spinbox.bind('<KeyRelease>', lambda e: self.update_calculations())
        
        # Odd/Even indicator
        self.result_labels[troop.name] = {}
        
        # Troops needed label
        troops_label = tk.Label(frame, text="0", width=18, anchor='e',
                               bg='#1a1a2e', fg='#e0e0e0', font=('Consolas', 10))
        troops_label.grid(row=0, column=2, padx=5)
        self.result_labels[troop.name]['troops'] = troops_label
        
        # Food consumption label
        food_label = tk.Label(frame, text="0", width=15, anchor='e',
                             bg='#1a1a2e', fg='#e0e0e0', font=('Consolas', 10))
        food_label.grid(row=0, column=3, padx=5)
        self.result_labels[troop.name]['food'] = food_label
        
        # Status label (ODD/EVEN)
        status_label = tk.Label(frame, text="---", width=12, anchor='center',
                               bg='#1a1a2e', fg='#888888', font=('Consolas', 10, 'bold'))
        status_label.grid(row=0, column=4, padx=5)
        self.result_labels[troop.name]['status'] = status_label
        
        # +/- buttons for fine control
        btn_frame = ttk.Frame(frame)
        btn_frame.grid(row=0, column=5, padx=5)
        
        ttk.Button(btn_frame, text="-2", width=3, 
                  command=lambda t=troop.name: self.adjust_glitch(t, -2)).pack(side=tk.LEFT)
        ttk.Button(btn_frame, text="+2", width=3,
                  command=lambda t=troop.name: self.adjust_glitch(t, 2)).pack(side=tk.LEFT)
        
    def create_summary_labels(self):
        """Create summary display labels"""
        labels = [
            ("total_glitches", "Total Glitches:"),
            ("generating_types", "Generating Types:"),
            ("total_troops", "Total Troops:"),
            ("food_generated", "Food Generated:"),
            ("food_consumed", "Food Consumed:"),
            ("net_food", "NET FOOD:"),
        ]
        
        self.summary_labels = {}
        for key, text in labels:
            frame = ttk.Frame(self.summary_frame)
            frame.pack(fill=tk.X, pady=3)
            
            ttk.Label(frame, text=text, width=18, style='TLabel').pack(side=tk.LEFT)
            value_label = tk.Label(frame, text="0", width=20, anchor='e',
                                  bg='#1a1a2e', fg='#e0e0e0', font=('Consolas', 11, 'bold'))
            value_label.pack(side=tk.RIGHT)
            self.summary_labels[key] = value_label
            
    def adjust_glitch(self, troop_name: str, delta: int):
        """Adjust glitch count by delta (ensures odd numbers only)"""
        current = self.glitch_vars[troop_name].get()
        new_val = max(0, current + delta)
        # Ensure odd if > 0
        if new_val > 0 and new_val % 2 == 0:
            new_val += 1 if delta > 0 else -1
        self.glitch_vars[troop_name].set(max(0, new_val))
        self.update_calculations()
        
    def calculate_troops_for_glitches(self, troop: TroopType, glitches: int) -> int:
        """Calculate exact troops needed for N glitches"""
        if glitches <= 0:
            return 0
        # Troops = threshold * glitches + 1 (to be just over the threshold)
        return troop.city_threshold * glitches + 1
        
    def update_calculations(self):
        """Update all calculations and display"""
        total_glitches = 0
        generating_types = 0
        total_troops = 0
        food_generated = 0
        food_consumed = 0
        
        for troop in TROOPS:
            glitches = self.glitch_vars[troop.name].get()
            troops_needed = self.calculate_troops_for_glitches(troop, glitches)
            
            # Food calculations
            troop_food = troops_needed * troop.food_cost
            is_odd = glitches > 0 and glitches % 2 == 1
            generated = FOOD_PER_GLITCH if is_odd else 0
            
            # Update totals
            total_glitches += glitches
            if is_odd:
                generating_types += 1
                food_generated += generated
            total_troops += troops_needed
            food_consumed += troop_food
            
            # Update row labels
            self.result_labels[troop.name]['troops'].config(
                text=f"{troops_needed:,}")
            self.result_labels[troop.name]['food'].config(
                text=f"-{troop_food:,}/hr" if troop_food > 0 else "0")
            
            # Status
            if glitches == 0:
                self.result_labels[troop.name]['status'].config(
                    text="---", fg='#888888')
            elif is_odd:
                self.result_labels[troop.name]['status'].config(
                    text="✓ ODD", fg='#00ff00')
            else:
                self.result_labels[troop.name]['status'].config(
                    text="✗ EVEN", fg='#ff4444')
                    
        # Net food calculation
        net_food = food_generated - food_consumed
        
        # Update summary
        self.summary_labels['total_glitches'].config(text=f"{total_glitches:,}")
        self.summary_labels['generating_types'].config(text=f"{generating_types} / 12")
        self.summary_labels['total_troops'].config(text=f"{total_troops:,}")
        self.summary_labels['food_generated'].config(
            text=f"+{food_generated:,}/hr", fg='#00ff00')
        self.summary_labels['food_consumed'].config(
            text=f"-{food_consumed:,}/hr", fg='#ff4444')
        
        # Net food with color
        if net_food > 0:
            color = '#00ff00'
            prefix = "+"
        elif net_food < 0:
            color = '#ff4444'
            prefix = ""
        else:
            color = '#ffff00'
            prefix = ""
        self.summary_labels['net_food'].config(
            text=f"{prefix}{net_food:,}/hr", fg=color)
            
    def apply_preset(self, preset_name: str):
        """Apply a preset configuration"""
        if preset_name not in PRESETS:
            return
            
        preset = PRESETS[preset_name]
        for troop_name, glitches in preset['glitches'].items():
            if troop_name in self.glitch_vars:
                self.glitch_vars[troop_name].set(glitches)
                
        self.preset_desc.config(text=preset['description'])
        self.update_calculations()
        
    def reset_all(self):
        """Reset all glitch counts to 0"""
        for var in self.glitch_vars.values():
            var.set(0)
        self.update_calculations()
        
    def parse_output(self):
        """Open dialog to parse glitch counter output"""
        dialog = tk.Toplevel(self.root)
        dialog.title("Parse Glitch Counter Output")
        dialog.geometry("600x500")
        dialog.configure(bg='#1a1a2e')
        
        ttk.Label(dialog, text="Paste your glitch counter output:", style='Header.TLabel').pack(pady=10)
        
        text_widget = scrolledtext.ScrolledText(dialog, width=70, height=20, 
                                                bg='#2a2a4e', fg='#e0e0e0',
                                                font=('Consolas', 9))
        text_widget.pack(pady=10, padx=10)
        
        def do_parse():
            text = text_widget.get("1.0", tk.END)
            self.parse_glitch_text(text)
            dialog.destroy()
            
        ttk.Button(dialog, text="Parse & Apply", command=do_parse).pack(pady=10)
        
    def parse_glitch_text(self, text: str):
        """Parse glitch counter output and apply values"""
        # Pattern: Type: <name>\n...City Glitches: <N>
        troop_map = {
            "Workers": "Workers", "Warriors": "Warriors", "Scouts": "Scouts",
            "Pikemen": "Pikemen", "Swordsmen": "Swordsmen", "Archers": "Archers",
            "Cavalry": "Cavalry", "Cataphracts": "Cataphracts", "Transporters": "Transporters",
            "Ballista": "Ballista", "Battering Rams": "Battering Rams", "Catapults": "Catapults"
        }
        
        current_troop = None
        for line in text.split('\n'):
            # Find troop type
            type_match = re.search(r'Type:\s*(\w+(?:\s+\w+)?)', line)
            if type_match:
                name = type_match.group(1).strip()
                if name in troop_map:
                    current_troop = troop_map[name]
                    
            # Find glitch count
            glitch_match = re.search(r'City Glitches:\s*(\d+)', line)
            if glitch_match and current_troop:
                glitches = int(glitch_match.group(1))
                if current_troop in self.glitch_vars:
                    self.glitch_vars[current_troop].set(glitches)
                    
        self.update_calculations()
        messagebox.showinfo("Parsed", "Glitch data parsed and applied!")
        
    def export_script(self):
        """Export current configuration as AutoEvony script commands"""
        lines = ["# Glitch Calculator Export", "# Troop counts for current configuration", ""]
        
        for troop in TROOPS:
            glitches = self.glitch_vars[troop.name].get()
            if glitches > 0:
                troops = self.calculate_troops_for_glitches(
                    troop, glitches)
                lines.append(f"# {troop.name}: {glitches} glitches = {troops:,} troops")
                
        lines.append("")
        lines.append("# Commands to train to these levels:")
        for troop in TROOPS:
            glitches = self.glitch_vars[troop.name].get()
            if glitches > 0:
                troops = self.calculate_troops_for_glitches(troop, glitches)
                lines.append(f"# train {troop.abbr}:{troops}")
                
        # Save to file
        filepath = filedialog.asksaveasfilename(
            defaultextension=".txt",
            filetypes=[("Text files", "*.txt"), ("All files", "*.*")],
            title="Export Configuration"
        )
        if filepath:
            with open(filepath, 'w') as f:
                f.write('\n'.join(lines))
            messagebox.showinfo("Exported", f"Configuration saved to {filepath}")
            
    def copy_summary(self):
        """Copy summary to clipboard"""
        lines = ["═══ GLITCH CONFIGURATION ═══", ""]
        
        for troop in TROOPS:
            glitches = self.glitch_vars[troop.name].get()
            if glitches > 0:
                troops = self.calculate_troops_for_glitches(troop, glitches)
                status = "ODD ✓" if glitches % 2 == 1 else "EVEN ✗"
                lines.append(f"{troop.name}: {glitches} glitches ({status}) = {troops:,} troops")
                
        lines.append("")
        lines.append(f"Total Glitches: {self.summary_labels['total_glitches'].cget('text')}")
        lines.append(f"Net Food: {self.summary_labels['net_food'].cget('text')}")
        
        self.root.clipboard_clear()
        self.root.clipboard_append('\n'.join(lines))
        messagebox.showinfo("Copied", "Summary copied to clipboard!")


def main():
    root = tk.Tk()
    app = GlitchCalculatorGUI(root)
    root.mainloop()


if __name__ == "__main__":
    main()
