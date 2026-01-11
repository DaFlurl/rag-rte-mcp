#!/usr/bin/env python3
"""
BORG TOOLKIT - GUI Launcher with Clickable Buttons
"""

import os
import sys
import subprocess
import tkinter as tk
from tkinter import font as tkfont
from pathlib import Path

SCRIPT_DIR = Path(__file__).parent

# Borg colors
BG_COLOR = "#0a0a0a"
BORG_GREEN = "#00ff00"
DARK_GREEN = "#006600"
GRAY = "#666666"
WHITE = "#ffffff"

MENU_ITEMS = [
    ("1", "Account Data Viewer", "View account dumps in Web UI", "borg_data_viewer_web.py"),
    ("2", "Glitch Optimizer", "Analyze troop glitches", "evony_scripts/GlitchOptimizer_AllCities_v3.txt"),
    ("3", "Export to Excel", "Generate Excel reports", "borg_data_viewer_v2.py"),
    ("4", "Password Tester", "Test account passwords", "run_password_test_direct.py"),
    ("5", "ID Extractor", "Extract all game IDs", "extract_all_game_data.py"),
    ("6", "Login Validator", "Validate account logins", "test_login.py"),
    ("7", "Import Manager", "Manage account imports", "start_import_manager.bat"),
    ("0", "Exit", "Disconnect from Collective", None),
]

class BorgButton(tk.Frame):
    """Custom clickable button with Borg styling"""
    def __init__(self, parent, key, name, desc, command, **kwargs):
        super().__init__(parent, bg=BG_COLOR, **kwargs)
        
        self.command = command
        self.is_exit = key == "0"
        
        # Container frame
        self.container = tk.Frame(self, bg=BG_COLOR, padx=10, pady=5)
        self.container.pack(fill=tk.X)
        
        # Key label
        self.key_label = tk.Label(
            self.container, 
            text=f"[{key}]", 
            fg=BORG_GREEN, 
            bg=BG_COLOR,
            font=("Consolas", 12, "bold"),
            width=4
        )
        self.key_label.pack(side=tk.LEFT)
        
        # Name label (clickable)
        self.name_label = tk.Label(
            self.container,
            text=name,
            fg=WHITE,
            bg=BG_COLOR,
            font=("Consolas", 12, "bold", "underline"),
            cursor="hand2",
            width=22,
            anchor="w"
        )
        self.name_label.pack(side=tk.LEFT, padx=(5, 10))
        
        # Description
        self.desc_label = tk.Label(
            self.container,
            text=f"- {desc}",
            fg=GRAY,
            bg=BG_COLOR,
            font=("Consolas", 10),
            anchor="w"
        )
        self.desc_label.pack(side=tk.LEFT, fill=tk.X, expand=True)
        
        # Bind click events to all parts
        for widget in [self, self.container, self.key_label, self.name_label, self.desc_label]:
            widget.bind("<Button-1>", self.on_click)
            widget.bind("<Enter>", self.on_enter)
            widget.bind("<Leave>", self.on_leave)
    
    def on_click(self, event=None):
        if self.command:
            self.command()
    
    def on_enter(self, event=None):
        self.name_label.config(fg=BORG_GREEN)
        self.container.config(bg="#1a1a1a")
        self.key_label.config(bg="#1a1a1a")
        self.name_label.config(bg="#1a1a1a")
        self.desc_label.config(bg="#1a1a1a")
    
    def on_leave(self, event=None):
        self.name_label.config(fg=WHITE)
        self.container.config(bg=BG_COLOR)
        self.key_label.config(bg=BG_COLOR)
        self.name_label.config(bg=BG_COLOR)
        self.desc_label.config(bg=BG_COLOR)


class BorgToolkitGUI:
    def __init__(self):
        self.root = tk.Tk()
        self.root.title("BORG TOOLKIT")
        self.root.configure(bg=BG_COLOR)
        self.root.geometry("700x650")
        self.root.resizable(False, False)
        
        # Center window
        self.root.update_idletasks()
        x = (self.root.winfo_screenwidth() - 700) // 2
        y = (self.root.winfo_screenheight() - 650) // 2
        self.root.geometry(f"+{x}+{y}")
        
        self.setup_ui()
        self.bind_keys()
    
    def setup_ui(self):
        # Main container
        main = tk.Frame(self.root, bg=BG_COLOR, padx=20, pady=10)
        main.pack(fill=tk.BOTH, expand=True)
        
        # ASCII Logo
        logo_text = """
██████╗  ██████╗ ██████╗  ██████╗ 
██╔══██╗██╔═══██╗██╔══██╗██╔════╝ 
██████╔╝██║   ██║██████╔╝██║  ███╗
██╔══██╗██║   ██║██╔══██╗██║   ██║
██████╔╝╚██████╔╝██║  ██║╚██████╔╝
╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ 

████████╗ ██████╗  ██████╗ ██╗     ██╗  ██╗██╗████████╗
╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██║ ██╔╝██║╚══██╔══╝
   ██║   ██║   ██║██║   ██║██║     █████╔╝ ██║   ██║   
   ██║   ██║   ██║██║   ██║██║     ██╔═██╗ ██║   ██║   
   ██║   ╚██████╔╝╚██████╔╝███████╗██║  ██╗██║   ██║   
   ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝   ╚═╝   """
        
        logo = tk.Label(
            main,
            text=logo_text,
            fg=BORG_GREEN,
            bg=BG_COLOR,
            font=("Consolas", 9),
            justify=tk.LEFT
        )
        logo.pack(pady=(0, 10))
        
        # Tagline
        tagline_frame = tk.Frame(main, bg=DARK_GREEN, padx=10, pady=5)
        tagline_frame.pack(fill=tk.X, pady=(0, 15))
        
        tagline = tk.Label(
            tagline_frame,
            text='"Resistance is Futile. Your accounts will be assimilated."',
            fg=BORG_GREEN,
            bg=BG_COLOR,
            font=("Consolas", 10, "italic")
        )
        tagline.pack()
        
        # Menu frame with border
        menu_border = tk.Frame(main, bg=DARK_GREEN, padx=2, pady=2)
        menu_border.pack(fill=tk.X, pady=10)
        
        menu_frame = tk.Frame(menu_border, bg=BG_COLOR, padx=10, pady=10)
        menu_frame.pack(fill=tk.X)
        
        # Add menu buttons
        for key, name, desc, script in MENU_ITEMS:
            btn = BorgButton(
                menu_frame,
                key=key,
                name=name,
                desc=desc,
                command=lambda s=script, n=name: self.run_action(s, n)
            )
            btn.pack(fill=tk.X, pady=2)
        
        # Footer
        footer = tk.Label(
            main,
            text="Click menu items or press number keys [0-7]",
            fg=GRAY,
            bg=BG_COLOR,
            font=("Consolas", 9)
        )
        footer.pack(pady=(15, 0))
    
    def bind_keys(self):
        """Bind number keys to menu items"""
        for key, name, desc, script in MENU_ITEMS:
            self.root.bind(key, lambda e, s=script, n=name: self.run_action(s, n))
        
        self.root.bind("<Escape>", lambda e: self.root.quit())
    
    def run_action(self, script, name):
        if script is None:  # Exit
            self.root.quit()
            return
        
        script_path = SCRIPT_DIR / script
        
        if script.endswith('.py'):
            # Run Python script in new terminal
            subprocess.Popen(
                ['cmd', '/k', sys.executable, str(script_path)],
                cwd=str(SCRIPT_DIR),
                creationflags=subprocess.CREATE_NEW_CONSOLE
            )
        elif script.endswith('.bat'):
            subprocess.Popen(
                ['cmd', '/k', str(script_path)],
                cwd=str(SCRIPT_DIR),
                creationflags=subprocess.CREATE_NEW_CONSOLE
            )
        elif script.endswith('.txt'):
            subprocess.Popen(['notepad', str(script_path)])
    
    def run(self):
        self.root.mainloop()


if __name__ == "__main__":
    app = BorgToolkitGUI()
    app.run()
