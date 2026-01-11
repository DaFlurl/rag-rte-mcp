"""
ETK SOL Manager - Entry Point
Run with: python -m sol_manager
"""

import sys
import tkinter as tk

def main():
    # Check for pyamf
    try:
        import pyamf.sol
        print("[✓] PyAMF loaded successfully")
    except ImportError:
        print("[!] PyAMF not found. Install with: pip install Py3AMF")
        print("    Some features will be limited without PyAMF.")
    
    # Import and run app
    from .ui.main_window import SOLManagerApp
    
    root = tk.Tk()
    app = SOLManagerApp(root)
    root.mainloop()

if __name__ == "__main__":
    main()
