"""
ETK SOL Manager - RoboEvony Theme Module
Color scheme and styles matching RoboEvony Bot UI

Color palette extracted from RoboEvony screenshots:
- Dark navy backgrounds with orange/gold accents
- Green for positive values, red for negative
- Tab-based navigation with orange highlights
"""

import tkinter as tk
from tkinter import ttk
from typing import Dict, Any


class RoboEvonyTheme:
    """RoboEvony-inspired dark theme with orange accents"""
    
    # ========================================================================
    # PRIMARY COLORS (from RoboEvony screenshots)
    # ========================================================================
    
    # Backgrounds
    BG_DARK = "#0d1117"          # Main background (darkest)
    BG_PANEL = "#161b22"         # Panel backgrounds
    BG_HEADER = "#1a2332"        # Header/toolbar background
    BG_INPUT = "#0d1117"         # Input field background
    BG_TABLE_ROW1 = "#161b22"    # Table row (odd)
    BG_TABLE_ROW2 = "#1c2333"    # Table row (even)
    BG_TABLE_HEADER = "#21262d"  # Table header
    BG_BUTTON = "#21262d"        # Button background
    BG_BUTTON_HOVER = "#30363d"  # Button hover
    BG_TAB_ACTIVE = "#1a2332"    # Active tab background
    BG_TAB_INACTIVE = "#0d1117"  # Inactive tab background
    
    # Accent Colors
    ACCENT_ORANGE = "#FF9900"    # Primary accent (selected, highlights)
    ACCENT_GOLD = "#FFA500"      # Secondary accent (important text)
    ACCENT_BLUE = "#58a6ff"      # Links, info
    
    # Text Colors
    TEXT_PRIMARY = "#FFFFFF"     # Primary text (white)
    TEXT_SECONDARY = "#8b949e"   # Secondary text (gray)
    TEXT_DISABLED = "#484f58"    # Disabled text
    TEXT_HIGHLIGHT = "#FF9900"   # Highlighted text (orange)
    
    # Status Colors
    STATUS_POSITIVE = "#3fb950"  # Green (success, positive values)
    STATUS_NEGATIVE = "#f85149"  # Red (error, negative values)
    STATUS_WARNING = "#d29922"   # Yellow (warnings)
    STATUS_INFO = "#58a6ff"      # Blue (info)
    STATUS_ACTIVE = "#3fb950"    # Active indicator
    STATUS_INACTIVE = "#8b949e"  # Inactive indicator
    
    # Border Colors
    BORDER_DEFAULT = "#30363d"   # Default border
    BORDER_FOCUS = "#58a6ff"     # Focused element border
    BORDER_ACCENT = "#FF9900"    # Accent border
    
    # City Tab Colors (from RoboEvony city tabs)
    CITY_TAB_COLORS = [
        "#FF6B6B",  # Red
        "#4ECDC4",  # Teal
        "#45B7D1",  # Blue
        "#96CEB4",  # Green
        "#FFEAA7",  # Yellow
        "#DDA0DD",  # Plum
        "#98D8C8",  # Mint
        "#F7DC6F",  # Gold
    ]
    
    # ========================================================================
    # FONTS
    # ========================================================================
    FONT_FAMILY = "Segoe UI"
    FONT_MONO = "Consolas"
    FONT_SIZE_SMALL = 9
    FONT_SIZE_NORMAL = 10
    FONT_SIZE_LARGE = 12
    FONT_SIZE_HEADER = 14
    FONT_SIZE_TITLE = 16
    
    @classmethod
    def get_fonts(cls) -> Dict[str, tuple]:
        """Get font configurations"""
        return {
            "default": (cls.FONT_FAMILY, cls.FONT_SIZE_NORMAL),
            "small": (cls.FONT_FAMILY, cls.FONT_SIZE_SMALL),
            "large": (cls.FONT_FAMILY, cls.FONT_SIZE_LARGE),
            "header": (cls.FONT_FAMILY, cls.FONT_SIZE_HEADER, "bold"),
            "title": (cls.FONT_FAMILY, cls.FONT_SIZE_TITLE, "bold"),
            "mono": (cls.FONT_MONO, cls.FONT_SIZE_NORMAL),
            "mono_small": (cls.FONT_MONO, cls.FONT_SIZE_SMALL),
        }
    
    @classmethod
    def apply_theme(cls, root: tk.Tk) -> None:
        """Apply RoboEvony theme to the entire application"""
        
        # Configure root window
        root.configure(bg=cls.BG_DARK)
        
        # Create and configure ttk style
        style = ttk.Style()
        style.theme_use('clam')  # Base theme for customization
        
        # ====================================================================
        # FRAME STYLES
        # ====================================================================
        style.configure(
            "TFrame",
            background=cls.BG_DARK
        )
        
        style.configure(
            "Panel.TFrame",
            background=cls.BG_PANEL
        )
        
        style.configure(
            "Header.TFrame",
            background=cls.BG_HEADER
        )
        
        # ====================================================================
        # LABEL STYLES
        # ====================================================================
        style.configure(
            "TLabel",
            background=cls.BG_DARK,
            foreground=cls.TEXT_PRIMARY,
            font=(cls.FONT_FAMILY, cls.FONT_SIZE_NORMAL)
        )
        
        style.configure(
            "Header.TLabel",
            background=cls.BG_HEADER,
            foreground=cls.ACCENT_ORANGE,
            font=(cls.FONT_FAMILY, cls.FONT_SIZE_HEADER, "bold")
        )
        
        style.configure(
            "Title.TLabel",
            background=cls.BG_DARK,
            foreground=cls.ACCENT_ORANGE,
            font=(cls.FONT_FAMILY, cls.FONT_SIZE_TITLE, "bold")
        )
        
        style.configure(
            "Secondary.TLabel",
            background=cls.BG_DARK,
            foreground=cls.TEXT_SECONDARY,
            font=(cls.FONT_FAMILY, cls.FONT_SIZE_SMALL)
        )
        
        style.configure(
            "Positive.TLabel",
            background=cls.BG_DARK,
            foreground=cls.STATUS_POSITIVE
        )
        
        style.configure(
            "Negative.TLabel",
            background=cls.BG_DARK,
            foreground=cls.STATUS_NEGATIVE
        )
        
        style.configure(
            "Warning.TLabel",
            background=cls.BG_DARK,
            foreground=cls.STATUS_WARNING
        )
        
        # ====================================================================
        # BUTTON STYLES
        # ====================================================================
        style.configure(
            "TButton",
            background=cls.BG_BUTTON,
            foreground=cls.TEXT_PRIMARY,
            bordercolor=cls.BORDER_DEFAULT,
            focuscolor=cls.ACCENT_ORANGE,
            font=(cls.FONT_FAMILY, cls.FONT_SIZE_NORMAL),
            padding=(10, 5)
        )
        
        style.map(
            "TButton",
            background=[
                ("active", cls.BG_BUTTON_HOVER),
                ("pressed", cls.ACCENT_ORANGE)
            ],
            foreground=[
                ("active", cls.TEXT_PRIMARY),
                ("pressed", cls.BG_DARK)
            ]
        )
        
        style.configure(
            "Accent.TButton",
            background=cls.ACCENT_ORANGE,
            foreground=cls.BG_DARK,
            font=(cls.FONT_FAMILY, cls.FONT_SIZE_NORMAL, "bold")
        )
        
        style.map(
            "Accent.TButton",
            background=[
                ("active", cls.ACCENT_GOLD),
                ("pressed", cls.STATUS_WARNING)
            ]
        )
        
        # ====================================================================
        # ENTRY STYLES
        # ====================================================================
        style.configure(
            "TEntry",
            fieldbackground=cls.BG_INPUT,
            foreground=cls.TEXT_PRIMARY,
            insertcolor=cls.TEXT_PRIMARY,
            bordercolor=cls.BORDER_DEFAULT,
            font=(cls.FONT_FAMILY, cls.FONT_SIZE_NORMAL)
        )
        
        style.map(
            "TEntry",
            bordercolor=[("focus", cls.ACCENT_ORANGE)],
            fieldbackground=[("focus", cls.BG_PANEL)]
        )
        
        # ====================================================================
        # NOTEBOOK (TABS) STYLES
        # ====================================================================
        style.configure(
            "TNotebook",
            background=cls.BG_DARK,
            bordercolor=cls.BORDER_DEFAULT,
            tabmargins=[2, 5, 2, 0]
        )
        
        style.configure(
            "TNotebook.Tab",
            background=cls.BG_TAB_INACTIVE,
            foreground=cls.TEXT_SECONDARY,
            padding=[12, 6],
            font=(cls.FONT_FAMILY, cls.FONT_SIZE_NORMAL)
        )
        
        style.map(
            "TNotebook.Tab",
            background=[
                ("selected", cls.BG_TAB_ACTIVE),
                ("active", cls.BG_BUTTON_HOVER)
            ],
            foreground=[
                ("selected", cls.ACCENT_ORANGE),
                ("active", cls.TEXT_PRIMARY)
            ],
            expand=[("selected", [1, 1, 1, 0])]
        )
        
        # ====================================================================
        # TREEVIEW STYLES
        # ====================================================================
        style.configure(
            "Treeview",
            background=cls.BG_PANEL,
            foreground=cls.TEXT_PRIMARY,
            fieldbackground=cls.BG_PANEL,
            bordercolor=cls.BORDER_DEFAULT,
            font=(cls.FONT_FAMILY, cls.FONT_SIZE_NORMAL),
            rowheight=25
        )
        
        style.configure(
            "Treeview.Heading",
            background=cls.BG_TABLE_HEADER,
            foreground=cls.ACCENT_ORANGE,
            font=(cls.FONT_FAMILY, cls.FONT_SIZE_NORMAL, "bold"),
            bordercolor=cls.BORDER_DEFAULT
        )
        
        style.map(
            "Treeview",
            background=[("selected", cls.BG_BUTTON_HOVER)],
            foreground=[("selected", cls.ACCENT_ORANGE)]
        )
        
        style.map(
            "Treeview.Heading",
            background=[("active", cls.BG_BUTTON_HOVER)]
        )
        
        # ====================================================================
        # SCROLLBAR STYLES
        # ====================================================================
        style.configure(
            "TScrollbar",
            background=cls.BG_PANEL,
            troughcolor=cls.BG_DARK,
            bordercolor=cls.BORDER_DEFAULT,
            arrowcolor=cls.TEXT_SECONDARY
        )
        
        style.map(
            "TScrollbar",
            background=[("active", cls.BG_BUTTON_HOVER)]
        )
        
        # ====================================================================
        # LABELFRAME STYLES
        # ====================================================================
        style.configure(
            "TLabelframe",
            background=cls.BG_DARK,
            bordercolor=cls.BORDER_DEFAULT
        )
        
        style.configure(
            "TLabelframe.Label",
            background=cls.BG_DARK,
            foreground=cls.ACCENT_ORANGE,
            font=(cls.FONT_FAMILY, cls.FONT_SIZE_NORMAL, "bold")
        )
        
        # ====================================================================
        # CHECKBUTTON STYLES
        # ====================================================================
        style.configure(
            "TCheckbutton",
            background=cls.BG_DARK,
            foreground=cls.TEXT_PRIMARY,
            font=(cls.FONT_FAMILY, cls.FONT_SIZE_NORMAL)
        )
        
        style.map(
            "TCheckbutton",
            background=[("active", cls.BG_DARK)],
            foreground=[("active", cls.ACCENT_ORANGE)]
        )
        
        # ====================================================================
        # RADIOBUTTON STYLES
        # ====================================================================
        style.configure(
            "TRadiobutton",
            background=cls.BG_DARK,
            foreground=cls.TEXT_PRIMARY,
            font=(cls.FONT_FAMILY, cls.FONT_SIZE_NORMAL)
        )
        
        style.map(
            "TRadiobutton",
            background=[("active", cls.BG_DARK)],
            foreground=[("active", cls.ACCENT_ORANGE)]
        )
        
        # ====================================================================
        # PROGRESSBAR STYLES
        # ====================================================================
        style.configure(
            "TProgressbar",
            background=cls.ACCENT_ORANGE,
            troughcolor=cls.BG_PANEL,
            bordercolor=cls.BORDER_DEFAULT
        )
        
        style.configure(
            "Green.Horizontal.TProgressbar",
            background=cls.STATUS_POSITIVE
        )
        
        style.configure(
            "Red.Horizontal.TProgressbar",
            background=cls.STATUS_NEGATIVE
        )
        
        # ====================================================================
        # PANEDWINDOW STYLES
        # ====================================================================
        style.configure(
            "TPanedwindow",
            background=cls.BG_DARK
        )
        
        # ====================================================================
        # COMBOBOX STYLES
        # ====================================================================
        style.configure(
            "TCombobox",
            fieldbackground=cls.BG_INPUT,
            background=cls.BG_BUTTON,
            foreground=cls.TEXT_PRIMARY,
            arrowcolor=cls.ACCENT_ORANGE,
            bordercolor=cls.BORDER_DEFAULT
        )
        
        style.map(
            "TCombobox",
            fieldbackground=[("focus", cls.BG_PANEL)],
            bordercolor=[("focus", cls.ACCENT_ORANGE)]
        )
        
        # Configure option menu dropdown colors (requires root option_add)
        root.option_add("*TCombobox*Listbox.background", cls.BG_PANEL)
        root.option_add("*TCombobox*Listbox.foreground", cls.TEXT_PRIMARY)
        root.option_add("*TCombobox*Listbox.selectBackground", cls.ACCENT_ORANGE)
        root.option_add("*TCombobox*Listbox.selectForeground", cls.BG_DARK)
    
    @classmethod
    def configure_text_widget(cls, widget: tk.Text) -> None:
        """Apply theme to a Text widget"""
        widget.configure(
            bg=cls.BG_INPUT,
            fg=cls.TEXT_PRIMARY,
            insertbackground=cls.TEXT_PRIMARY,
            selectbackground=cls.ACCENT_ORANGE,
            selectforeground=cls.BG_DARK,
            font=(cls.FONT_MONO, cls.FONT_SIZE_NORMAL),
            relief=tk.FLAT,
            borderwidth=1,
            highlightthickness=1,
            highlightcolor=cls.ACCENT_ORANGE,
            highlightbackground=cls.BORDER_DEFAULT
        )
    
    @classmethod
    def configure_listbox(cls, widget: tk.Listbox) -> None:
        """Apply theme to a Listbox widget"""
        widget.configure(
            bg=cls.BG_PANEL,
            fg=cls.TEXT_PRIMARY,
            selectbackground=cls.ACCENT_ORANGE,
            selectforeground=cls.BG_DARK,
            font=(cls.FONT_FAMILY, cls.FONT_SIZE_NORMAL),
            relief=tk.FLAT,
            borderwidth=0,
            highlightthickness=1,
            highlightcolor=cls.ACCENT_ORANGE,
            highlightbackground=cls.BORDER_DEFAULT
        )
    
    @classmethod
    def configure_canvas(cls, widget: tk.Canvas) -> None:
        """Apply theme to a Canvas widget"""
        widget.configure(
            bg=cls.BG_DARK,
            highlightthickness=0
        )
    
    @classmethod
    def get_status_color(cls, status: str) -> str:
        """Get color for a status value"""
        status_lower = status.lower()
        if status_lower in ("active", "online", "success", "positive", "true"):
            return cls.STATUS_POSITIVE
        elif status_lower in ("inactive", "offline", "error", "negative", "false"):
            return cls.STATUS_NEGATIVE
        elif status_lower in ("warning", "pending"):
            return cls.STATUS_WARNING
        elif status_lower in ("info",):
            return cls.STATUS_INFO
        return cls.TEXT_SECONDARY
    
    @classmethod
    def format_number(cls, value: Any, show_sign: bool = False) -> tuple:
        """Format a number and return (text, color)"""
        try:
            num = float(value)
            if num > 0:
                text = f"+{num:,.0f}" if show_sign else f"{num:,.0f}"
                color = cls.STATUS_POSITIVE
            elif num < 0:
                text = f"{num:,.0f}"
                color = cls.STATUS_NEGATIVE
            else:
                text = "0"
                color = cls.TEXT_SECONDARY
            return text, color
        except (ValueError, TypeError):
            return str(value), cls.TEXT_PRIMARY
