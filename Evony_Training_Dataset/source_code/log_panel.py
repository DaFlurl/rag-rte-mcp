"""
ETK SOL Manager - Multi-Pane Log Window
Like RoboEvony's log system with multiple tabs for different log types
"""

import tkinter as tk
from tkinter import ttk
from datetime import datetime
from typing import Optional, Dict, List, Callable
from collections import deque
import threading

from ..theme import RoboEvonyTheme as Theme


class LogLevel:
    """Log level constants with colors"""
    INFO = ("INFO", Theme.TEXT_PRIMARY)
    SUCCESS = ("SUCCESS", Theme.STATUS_POSITIVE)
    WARNING = ("WARNING", Theme.STATUS_WARNING)
    ERROR = ("ERROR", Theme.STATUS_NEGATIVE)
    SYSTEM = ("SYSTEM", Theme.ACCENT_BLUE)
    CITY = ("CITY", "#87CEEB")
    COMBAT = ("COMBAT", "#FF6B6B")
    ITEM = ("ITEM", "#FFD700")
    MAINTENANCE = ("MAINTENANCE", Theme.STATUS_WARNING)


class LogEntry:
    """Single log entry"""
    def __init__(self, message: str, level: tuple = LogLevel.INFO, 
                 account: str = "", city: str = ""):
        self.timestamp = datetime.now()
        self.message = message
        self.level = level
        self.account = account
        self.city = city
    
    def format(self) -> str:
        time_str = self.timestamp.strftime("%H:%M:%S")
        prefix = f"({self.account})" if self.account else ""
        return f"{time_str} {prefix} - {self.message}"


class LogManager:
    """
    Central log manager for the application.
    Singleton pattern - one instance shared across app.
    """
    _instance = None
    
    def __new__(cls):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
            cls._instance._initialized = False
        return cls._instance
    
    def __init__(self):
        if self._initialized:
            return
        self._initialized = True
        
        self.max_entries = 1000
        self.logs: Dict[str, deque] = {
            "main": deque(maxlen=self.max_entries),
            "city": deque(maxlen=self.max_entries),
            "war": deque(maxlen=self.max_entries),
            "system": deque(maxlen=self.max_entries),
            "chat": deque(maxlen=self.max_entries)
        }
        self.callbacks: List[Callable] = []
        self._lock = threading.Lock()
    
    def add_callback(self, callback: Callable):
        """Add callback for log updates"""
        self.callbacks.append(callback)
    
    def remove_callback(self, callback: Callable):
        """Remove callback"""
        if callback in self.callbacks:
            self.callbacks.remove(callback)
    
    def log(self, message: str, level: tuple = LogLevel.INFO,
            account: str = "", city: str = "", log_type: str = "main"):
        """Add a log entry"""
        entry = LogEntry(message, level, account, city)
        
        with self._lock:
            if log_type in self.logs:
                self.logs[log_type].append(entry)
            
            # Also add to main log
            if log_type != "main":
                self.logs["main"].append(entry)
        
        # Notify callbacks
        for callback in self.callbacks:
            try:
                callback(entry, log_type)
            except:
                pass
    
    def info(self, message: str, account: str = "", city: str = ""):
        self.log(message, LogLevel.INFO, account, city)
    
    def success(self, message: str, account: str = "", city: str = ""):
        self.log(message, LogLevel.SUCCESS, account, city)
    
    def warning(self, message: str, account: str = "", city: str = ""):
        self.log(message, LogLevel.WARNING, account, city)
    
    def error(self, message: str, account: str = "", city: str = ""):
        self.log(message, LogLevel.ERROR, account, city)
    
    def system(self, message: str):
        self.log(message, LogLevel.SYSTEM, log_type="system")
    
    def city_log(self, message: str, account: str = "", city: str = ""):
        self.log(message, LogLevel.CITY, account, city, log_type="city")
    
    def war_log(self, message: str, account: str = ""):
        self.log(message, LogLevel.COMBAT, account, log_type="war")
    
    def maintenance(self, message: str):
        self.log(message, LogLevel.MAINTENANCE, log_type="system")
    
    def get_logs(self, log_type: str = "main") -> List[LogEntry]:
        """Get logs for a specific type"""
        with self._lock:
            return list(self.logs.get(log_type, []))
    
    def clear(self, log_type: str = None):
        """Clear logs"""
        with self._lock:
            if log_type:
                if log_type in self.logs:
                    self.logs[log_type].clear()
            else:
                for log_list in self.logs.values():
                    log_list.clear()


# Global log manager instance
log_manager = LogManager()


class LogTextWidget(tk.Text):
    """Custom text widget for log display with color support"""
    
    def __init__(self, parent, **kwargs):
        super().__init__(parent, **kwargs)
        self.configure(
            bg=Theme.BG_DARK,
            fg=Theme.TEXT_PRIMARY,
            font=('Consolas', 9),
            wrap=tk.WORD,
            state='disabled',
            cursor="arrow",
            borderwidth=0,
            highlightthickness=0
        )
        
        # Configure tags for colors
        self.tag_configure("INFO", foreground=Theme.TEXT_PRIMARY)
        self.tag_configure("SUCCESS", foreground=Theme.STATUS_POSITIVE)
        self.tag_configure("WARNING", foreground=Theme.STATUS_WARNING)
        self.tag_configure("ERROR", foreground=Theme.STATUS_NEGATIVE)
        self.tag_configure("SYSTEM", foreground=Theme.ACCENT_BLUE)
        self.tag_configure("CITY", foreground="#87CEEB")
        self.tag_configure("COMBAT", foreground="#FF6B6B")
        self.tag_configure("ITEM", foreground="#FFD700")
        self.tag_configure("MAINTENANCE", foreground=Theme.STATUS_WARNING)
        self.tag_configure("timestamp", foreground=Theme.TEXT_SECONDARY)
        self.tag_configure("account", foreground=Theme.ACCENT_ORANGE)
    
    def add_entry(self, entry: LogEntry):
        """Add a log entry with proper formatting"""
        self.configure(state='normal')
        
        # Timestamp
        time_str = entry.timestamp.strftime("%H:%M:%S")
        self.insert(tk.END, time_str + " ", "timestamp")
        
        # Account name if present
        if entry.account:
            self.insert(tk.END, f"({entry.account})", "account")
            self.insert(tk.END, " - ")
        
        # Message with level color
        level_name = entry.level[0]
        self.insert(tk.END, entry.message + "\n", level_name)
        
        self.configure(state='disabled')
        self.see(tk.END)


class LogPanel(tk.Frame):
    """
    Multi-pane log panel like RoboEvony.
    Tabs: Log, City Log, War Log, System
    """
    
    def __init__(self, parent, **kwargs):
        super().__init__(parent, bg=Theme.BG_DARK, **kwargs)
        
        self.log_widgets: Dict[str, LogTextWidget] = {}
        self._setup_ui()
        
        # Register with log manager
        log_manager.add_callback(self._on_log_entry)
    
    def _setup_ui(self):
        """Create the log panel UI"""
        self.columnconfigure(0, weight=1)
        self.rowconfigure(1, weight=1)
        
        # Tab bar
        tab_frame = tk.Frame(self, bg=Theme.BG_HEADER)
        tab_frame.grid(row=0, column=0, sticky="ew")
        
        self.tabs = {}
        self.active_tab = "main"
        
        tab_configs = [
            ("Log", "main"),
            ("City Log", "city"),
            ("War Log", "war"),
            ("System", "system")
        ]
        
        for text, key in tab_configs:
            btn = tk.Label(
                tab_frame, text=text,
                bg=Theme.BG_TAB_INACTIVE if key != "main" else Theme.BG_TAB_ACTIVE,
                fg=Theme.TEXT_SECONDARY if key != "main" else Theme.ACCENT_ORANGE,
                font=('Segoe UI', 9),
                padx=12, pady=6,
                cursor="hand2"
            )
            btn.pack(side="left")
            btn.bind("<Button-1>", lambda e, k=key: self._switch_tab(k))
            self.tabs[key] = btn
        
        # Control buttons (right side)
        ctrl_frame = tk.Frame(tab_frame, bg=Theme.BG_HEADER)
        ctrl_frame.pack(side="right", padx=5)
        
        tk.Button(
            ctrl_frame, text="Clear",
            bg=Theme.BG_BUTTON, fg=Theme.TEXT_PRIMARY,
            font=('Segoe UI', 8),
            command=self._clear_current,
            width=6
        ).pack(side="left", padx=2)
        
        tk.Button(
            ctrl_frame, text="Save",
            bg=Theme.BG_BUTTON, fg=Theme.TEXT_PRIMARY,
            font=('Segoe UI', 8),
            command=self._save_logs,
            width=6
        ).pack(side="left", padx=2)
        
        # Log content frame
        content_frame = tk.Frame(self, bg=Theme.BG_DARK)
        content_frame.grid(row=1, column=0, sticky="nsew")
        content_frame.columnconfigure(0, weight=1)
        content_frame.rowconfigure(0, weight=1)
        
        # Create log widgets for each tab
        for key in ["main", "city", "war", "system"]:
            frame = tk.Frame(content_frame, bg=Theme.BG_DARK)
            frame.grid(row=0, column=0, sticky="nsew")
            frame.columnconfigure(0, weight=1)
            frame.rowconfigure(0, weight=1)
            
            log_widget = LogTextWidget(frame)
            log_widget.grid(row=0, column=0, sticky="nsew")
            
            # Scrollbar
            vsb = ttk.Scrollbar(frame, orient="vertical", command=log_widget.yview)
            vsb.grid(row=0, column=1, sticky="ns")
            log_widget.configure(yscrollcommand=vsb.set)
            
            self.log_widgets[key] = log_widget
            
            # Hide non-active tabs
            if key != "main":
                frame.lower()
            
            self.log_widgets[key + "_frame"] = frame
    
    def _switch_tab(self, tab_key: str):
        """Switch to a different log tab"""
        # Update tab styles
        for key, btn in self.tabs.items():
            if key == tab_key:
                btn.configure(bg=Theme.BG_TAB_ACTIVE, fg=Theme.ACCENT_ORANGE)
                self.log_widgets[key + "_frame"].lift()
            else:
                btn.configure(bg=Theme.BG_TAB_INACTIVE, fg=Theme.TEXT_SECONDARY)
        
        self.active_tab = tab_key
    
    def _on_log_entry(self, entry: LogEntry, log_type: str):
        """Called when a new log entry is added"""
        # Add to appropriate widget(s)
        if log_type in self.log_widgets:
            self.after(0, lambda: self.log_widgets[log_type].add_entry(entry))
        
        # Always add to main log
        if log_type != "main" and "main" in self.log_widgets:
            self.after(0, lambda: self.log_widgets["main"].add_entry(entry))
    
    def _clear_current(self):
        """Clear current tab logs"""
        if self.active_tab in self.log_widgets:
            widget = self.log_widgets[self.active_tab]
            widget.configure(state='normal')
            widget.delete("1.0", tk.END)
            widget.configure(state='disabled')
        
        log_manager.clear(self.active_tab)
    
    def _save_logs(self):
        """Save current tab logs to file"""
        from tkinter import filedialog
        
        filename = filedialog.asksaveasfilename(
            defaultextension=".log",
            filetypes=[("Log files", "*.log"), ("Text files", "*.txt")],
            initialfile=f"{self.active_tab}_log.log"
        )
        
        if filename:
            logs = log_manager.get_logs(self.active_tab)
            with open(filename, 'w', encoding='utf-8') as f:
                for entry in logs:
                    f.write(entry.format() + "\n")
    
    def add_log(self, message: str, level: tuple = LogLevel.INFO,
                account: str = "", city: str = ""):
        """Convenience method to add a log"""
        log_manager.log(message, level, account, city)
    
    def destroy(self):
        """Cleanup"""
        log_manager.remove_callback(self._on_log_entry)
        super().destroy()


class ChatPanel(tk.Frame):
    """
    Chat/System message panel like RoboEvony's right side.
    Tabs: Alliance Chat, World Chat, System
    """
    
    def __init__(self, parent, **kwargs):
        super().__init__(parent, bg=Theme.BG_DARK, **kwargs)
        
        self._setup_ui()
    
    def _setup_ui(self):
        """Create chat panel UI"""
        self.columnconfigure(0, weight=1)
        self.rowconfigure(1, weight=1)
        
        # Tab bar
        tab_frame = tk.Frame(self, bg=Theme.BG_HEADER)
        tab_frame.grid(row=0, column=0, sticky="ew")
        
        self.tabs = {}
        self.active_tab = "alliance"
        
        for text, key in [("Alliance", "alliance"), ("World", "world"), ("System", "system")]:
            btn = tk.Label(
                tab_frame, text=text,
                bg=Theme.BG_TAB_ACTIVE if key == "alliance" else Theme.BG_TAB_INACTIVE,
                fg=Theme.ACCENT_ORANGE if key == "alliance" else Theme.TEXT_SECONDARY,
                font=('Segoe UI', 9),
                padx=10, pady=4,
                cursor="hand2"
            )
            btn.pack(side="left")
            btn.bind("<Button-1>", lambda e, k=key: self._switch_tab(k))
            self.tabs[key] = btn
        
        # Chat content
        self.chat_text = tk.Text(
            self, bg=Theme.BG_DARK, fg=Theme.TEXT_PRIMARY,
            font=('Segoe UI', 9), wrap=tk.WORD, state='disabled',
            cursor="arrow", borderwidth=0
        )
        self.chat_text.grid(row=1, column=0, sticky="nsew", padx=2, pady=2)
        
        # Scrollbar
        vsb = ttk.Scrollbar(self, orient="vertical", command=self.chat_text.yview)
        vsb.grid(row=1, column=1, sticky="ns")
        self.chat_text.configure(yscrollcommand=vsb.set)
        
        # Input field
        input_frame = tk.Frame(self, bg=Theme.BG_PANEL)
        input_frame.grid(row=2, column=0, columnspan=2, sticky="ew")
        
        self.chat_entry = tk.Entry(
            input_frame, bg=Theme.BG_INPUT, fg=Theme.TEXT_PRIMARY,
            font=('Segoe UI', 9), insertbackground=Theme.TEXT_PRIMARY
        )
        self.chat_entry.pack(side="left", fill="x", expand=True, padx=5, pady=5)
        
        tk.Button(
            input_frame, text="Send",
            bg=Theme.BG_BUTTON, fg=Theme.TEXT_PRIMARY,
            font=('Segoe UI', 8)
        ).pack(side="right", padx=5, pady=5)
    
    def _switch_tab(self, tab_key: str):
        """Switch chat tab"""
        for key, btn in self.tabs.items():
            if key == tab_key:
                btn.configure(bg=Theme.BG_TAB_ACTIVE, fg=Theme.ACCENT_ORANGE)
            else:
                btn.configure(bg=Theme.BG_TAB_INACTIVE, fg=Theme.TEXT_SECONDARY)
        self.active_tab = tab_key
    
    def add_message(self, sender: str, message: str, color: str = None):
        """Add a chat message"""
        self.chat_text.configure(state='normal')
        
        time_str = datetime.now().strftime("%H:%M:%S")
        
        if color:
            tag = f"color_{color}"
            self.chat_text.tag_configure(tag, foreground=color)
            self.chat_text.insert(tk.END, f"{time_str} [{sender}]: {message}\n", tag)
        else:
            self.chat_text.insert(tk.END, f"{time_str} [{sender}]: {message}\n")
        
        self.chat_text.configure(state='disabled')
        self.chat_text.see(tk.END)
