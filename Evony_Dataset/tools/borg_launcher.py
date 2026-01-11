#!/usr/bin/env python3
"""
BORG TOOLKIT - Interactive CLI Launcher
Supports clickable menu items and keyboard navigation
"""

import os
import sys
import subprocess
from pathlib import Path

# Try to import prompt_toolkit for interactive menus
try:
    from prompt_toolkit import Application
    from prompt_toolkit.key_binding import KeyBindings
    from prompt_toolkit.layout import Layout, HSplit, Window
    from prompt_toolkit.widgets import Label
    from prompt_toolkit.formatted_text import HTML, ANSI
    from prompt_toolkit.styles import Style
    HAS_PROMPT_TOOLKIT = True
except ImportError:
    HAS_PROMPT_TOOLKIT = False

SCRIPT_DIR = Path(__file__).parent

# Borg green ANSI
GREEN = "\033[92m"
DARK_GREEN = "\033[32m"
GRAY = "\033[90m"
WHITE = "\033[97m"
RED = "\033[91m"
RESET = "\033[0m"
UNDERLINE = "\033[4m"
BOLD = "\033[1m"

LOGO = f"""
{GREEN}██████╗  ██████╗ ██████╗  ██████╗ {RESET}
{GREEN}██╔══██╗██╔═══██╗██╔══██╗██╔════╝ {RESET}
{GREEN}██████╔╝██║   ██║██████╔╝██║  ███╗{RESET}
{GREEN}██╔══██╗██║   ██║██╔══██╗██║   ██║{RESET}
{GREEN}██████╔╝╚██████╔╝██║  ██║╚██████╔╝{RESET}
{GREEN}╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ {RESET}

{GREEN}████████╗ ██████╗  ██████╗ ██╗     ██╗  ██╗██╗████████╗{RESET}
{GREEN}╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██║ ██╔╝██║╚══██╔══╝{RESET}
{GREEN}   ██║   ██║   ██║██║   ██║██║     █████╔╝ ██║   ██║   {RESET}
{GREEN}   ██║   ██║   ██║██║   ██║██║     ██╔═██╗ ██║   ██║   {RESET}
{GREEN}   ██║   ╚██████╔╝╚██████╔╝███████╗██║  ██╗██║   ██║   {RESET}
{GREEN}   ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝   ╚═╝   {RESET}

{GRAY}╔════════════════════════════════════════════════════════════════╗{RESET}
{GRAY}║{RESET}  {GREEN}"Resistance is Futile. Your accounts will be assimilated."{RESET}  {GRAY}║{RESET}
{GRAY}╚════════════════════════════════════════════════════════════════╝{RESET}
"""

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

def clear_screen():
    os.system('cls' if os.name == 'nt' else 'clear')

def run_action(item):
    """Run the selected action"""
    key, name, desc, script = item
    
    if script is None:  # Exit
        print(f"\n{GREEN}╔══════════════════════════════════════════════════════════╗{RESET}")
        print(f"{GREEN}║      DISCONNECTING FROM THE BORG COLLECTIVE...           ║{RESET}")
        print(f"{GREEN}║              \"We will return.\"                           ║{RESET}")
        print(f"{GREEN}╚══════════════════════════════════════════════════════════╝{RESET}\n")
        sys.exit(0)
    
    clear_screen()
    print(f"\n{GREEN}▓▓▓ {name.upper()} ▓▓▓{RESET}\n")
    
    script_path = SCRIPT_DIR / script
    
    if script.endswith('.py'):
        subprocess.run([sys.executable, str(script_path)], cwd=str(SCRIPT_DIR))
    elif script.endswith('.bat'):
        subprocess.run(['cmd', '/c', str(script_path)], cwd=str(SCRIPT_DIR))
    elif script.endswith('.txt'):
        # Open in notepad
        subprocess.run(['notepad', str(script_path)])
    
    input(f"\n{GRAY}Press Enter to return to menu...{RESET}")

def simple_menu():
    """Simple text-based menu with number input"""
    while True:
        clear_screen()
        print(LOGO)
        
        print(f"{DARK_GREEN}┌─────────────────────────────────────────────────────────────────┐{RESET}")
        for key, name, desc, _ in MENU_ITEMS:
            print(f"{DARK_GREEN}│{RESET}  {WHITE}{UNDERLINE}[{key}] {name}{RESET}{'':>{20-len(name)}}{GRAY}- {desc}{RESET}{'':>{30-len(desc)}}{DARK_GREEN}│{RESET}")
        print(f"{DARK_GREEN}└─────────────────────────────────────────────────────────────────┘{RESET}")
        
        print(f"\n{GRAY}  (Type number and press Enter){RESET}\n")
        
        try:
            choice = input(f"  {GREEN}>{RESET} Select function [0-7]: ").strip()
        except (KeyboardInterrupt, EOFError):
            print()
            sys.exit(0)
        
        # Find matching item
        for item in MENU_ITEMS:
            if item[0] == choice:
                run_action(item)
                break
        else:
            print(f"  {RED}Invalid selection. Try again.{RESET}")
            import time
            time.sleep(1)

def interactive_menu():
    """Interactive menu with arrow keys and mouse support using prompt_toolkit"""
    selected = [0]  # Use list for mutable closure
    
    style = Style.from_dict({
        'logo': '#00ff00',
        'selected': 'reverse #00ff00',
        'normal': '#00ff00',
        'desc': '#666666',
        'border': '#006600',
    })
    
    kb = KeyBindings()
    
    @kb.add('up')
    @kb.add('k')
    def _(event):
        selected[0] = (selected[0] - 1) % len(MENU_ITEMS)
    
    @kb.add('down')
    @kb.add('j')
    def _(event):
        selected[0] = (selected[0] + 1) % len(MENU_ITEMS)
    
    @kb.add('enter')
    def _(event):
        event.app.exit(result=MENU_ITEMS[selected[0]])
    
    @kb.add('q')
    @kb.add('escape')
    def _(event):
        event.app.exit(result=MENU_ITEMS[-1])  # Exit item
    
    # Number keys
    for i, item in enumerate(MENU_ITEMS):
        key = item[0]
        @kb.add(key)
        def _(event, idx=i):
            event.app.exit(result=MENU_ITEMS[idx])
    
    def get_menu_text():
        lines = [LOGO, ""]
        lines.append(f"{DARK_GREEN}┌─────────────────────────────────────────────────────────────────┐{RESET}")
        
        for i, (key, name, desc, _) in enumerate(MENU_ITEMS):
            if i == selected[0]:
                prefix = f"  {GREEN}▶{RESET} "
                style_start = f"{WHITE}{BOLD}"
            else:
                prefix = "    "
                style_start = f"{WHITE}"
            
            line = f"{DARK_GREEN}│{RESET}{prefix}{style_start}[{key}] {name}{RESET}{'':>{18-len(name)}}{GRAY}- {desc}{RESET}{'':>{28-len(desc)}}{DARK_GREEN}│{RESET}"
            lines.append(line)
        
        lines.append(f"{DARK_GREEN}└─────────────────────────────────────────────────────────────────┘{RESET}")
        lines.append("")
        lines.append(f"{GRAY}  ↑/↓ Navigate  |  Enter Select  |  0-7 Quick Select  |  Q Quit{RESET}")
        lines.append("")
        
        return "\n".join(lines)
    
    while True:
        clear_screen()
        
        # Create simple application
        layout = Layout(Window(content=lambda: ANSI(get_menu_text())))
        app = Application(layout=layout, key_bindings=kb, full_screen=False)
        
        result = app.run()
        
        if result:
            run_action(result)
            if result[0] == '0':  # Exit
                break

def main():
    # Enable ANSI on Windows
    if os.name == 'nt':
        os.system('')  # Enable ANSI escape codes
    
    if HAS_PROMPT_TOOLKIT and '--simple' not in sys.argv:
        try:
            interactive_menu()
        except Exception:
            simple_menu()
    else:
        simple_menu()

if __name__ == "__main__":
    main()
