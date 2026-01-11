"""
ETK SOL Manager - Custom Widget Module
RoboEvony-styled custom tkinter widgets
"""

import tkinter as tk
from tkinter import ttk
from typing import List, Callable, Optional, Any

from ..theme import RoboEvonyTheme as Theme


class ThemedFrame(ttk.Frame):
    """Base themed frame"""
    
    def __init__(self, parent, style: str = "TFrame", **kwargs):
        super().__init__(parent, style=style, **kwargs)


class HeaderBar(tk.Frame):
    """RoboEvony-style header bar with title and info"""
    
    def __init__(self, parent, title: str = "", **kwargs):
        super().__init__(parent, bg=Theme.BG_HEADER, **kwargs)
        
        self.title_label = tk.Label(
            self,
            text=title,
            bg=Theme.BG_HEADER,
            fg=Theme.ACCENT_ORANGE,
            font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_HEADER, "bold")
        )
        self.title_label.pack(side=tk.LEFT, padx=10, pady=8)
        
        self.info_frame = tk.Frame(self, bg=Theme.BG_HEADER)
        self.info_frame.pack(side=tk.RIGHT, padx=10)
        
        self._info_labels = {}
    
    def set_title(self, title: str) -> None:
        self.title_label.config(text=title)
    
    def add_info(self, key: str, label: str, value: str = "-") -> None:
        """Add an info item to the header"""
        frame = tk.Frame(self.info_frame, bg=Theme.BG_HEADER)
        frame.pack(side=tk.LEFT, padx=15)
        
        lbl = tk.Label(
            frame,
            text=f"{label}:",
            bg=Theme.BG_HEADER,
            fg=Theme.TEXT_SECONDARY,
            font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_SMALL)
        )
        lbl.pack(side=tk.LEFT)
        
        val = tk.Label(
            frame,
            text=value,
            bg=Theme.BG_HEADER,
            fg=Theme.TEXT_PRIMARY,
            font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_NORMAL, "bold")
        )
        val.pack(side=tk.LEFT, padx=5)
        
        self._info_labels[key] = val
    
    def update_info(self, key: str, value: str, color: str = None) -> None:
        """Update an info value"""
        if key in self._info_labels:
            self._info_labels[key].config(text=value)
            if color:
                self._info_labels[key].config(fg=color)


class StatusBar(tk.Frame):
    """RoboEvony-style status bar"""
    
    def __init__(self, parent, **kwargs):
        super().__init__(parent, bg=Theme.BG_PANEL, height=25, **kwargs)
        self.pack_propagate(False)
        
        self.status_label = tk.Label(
            self,
            text="Ready",
            bg=Theme.BG_PANEL,
            fg=Theme.TEXT_SECONDARY,
            font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_SMALL),
            anchor=tk.W
        )
        self.status_label.pack(side=tk.LEFT, padx=10, fill=tk.X, expand=True)
        
        self.right_frame = tk.Frame(self, bg=Theme.BG_PANEL)
        self.right_frame.pack(side=tk.RIGHT, padx=10)
    
    def set_status(self, text: str, color: str = None) -> None:
        self.status_label.config(
            text=text,
            fg=color or Theme.TEXT_SECONDARY
        )
    
    def add_indicator(self, key: str, text: str, color: str = None) -> tk.Label:
        """Add a status indicator on the right"""
        indicator = tk.Label(
            self.right_frame,
            text=text,
            bg=Theme.BG_PANEL,
            fg=color or Theme.TEXT_SECONDARY,
            font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_SMALL)
        )
        indicator.pack(side=tk.LEFT, padx=10)
        return indicator


class ThemedButton(tk.Button):
    """RoboEvony-styled button"""
    
    def __init__(self, parent, text: str = "", command: Callable = None,
                 accent: bool = False, **kwargs):
        bg = Theme.ACCENT_ORANGE if accent else Theme.BG_BUTTON
        fg = Theme.BG_DARK if accent else Theme.TEXT_PRIMARY
        
        super().__init__(
            parent,
            text=text,
            command=command,
            bg=bg,
            fg=fg,
            activebackground=Theme.ACCENT_GOLD if accent else Theme.BG_BUTTON_HOVER,
            activeforeground=Theme.BG_DARK if accent else Theme.TEXT_PRIMARY,
            font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_NORMAL),
            relief=tk.FLAT,
            cursor="hand2",
            padx=15,
            pady=5,
            **kwargs
        )
        
        self._accent = accent
        self._default_bg = bg
        
        self.bind("<Enter>", self._on_enter)
        self.bind("<Leave>", self._on_leave)
    
    def _on_enter(self, event):
        if self._accent:
            self.config(bg=Theme.ACCENT_GOLD)
        else:
            self.config(bg=Theme.BG_BUTTON_HOVER)
    
    def _on_leave(self, event):
        self.config(bg=self._default_bg)


class ThemedEntry(tk.Entry):
    """RoboEvony-styled entry field"""
    
    def __init__(self, parent, placeholder: str = "", **kwargs):
        super().__init__(
            parent,
            bg=Theme.BG_INPUT,
            fg=Theme.TEXT_PRIMARY,
            insertbackground=Theme.TEXT_PRIMARY,
            selectbackground=Theme.ACCENT_ORANGE,
            selectforeground=Theme.BG_DARK,
            font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_NORMAL),
            relief=tk.FLAT,
            highlightthickness=1,
            highlightcolor=Theme.ACCENT_ORANGE,
            highlightbackground=Theme.BORDER_DEFAULT,
            **kwargs
        )
        
        self._placeholder = placeholder
        self._has_placeholder = False
        
        if placeholder:
            self._show_placeholder()
            self.bind("<FocusIn>", self._on_focus_in)
            self.bind("<FocusOut>", self._on_focus_out)
    
    def _show_placeholder(self):
        if not self.get():
            self.insert(0, self._placeholder)
            self.config(fg=Theme.TEXT_DISABLED)
            self._has_placeholder = True
    
    def _on_focus_in(self, event):
        if self._has_placeholder:
            self.delete(0, tk.END)
            self.config(fg=Theme.TEXT_PRIMARY)
            self._has_placeholder = False
    
    def _on_focus_out(self, event):
        if not self.get():
            self._show_placeholder()
    
    def get_value(self) -> str:
        """Get value, ignoring placeholder"""
        if self._has_placeholder:
            return ""
        return self.get()


class ThemedListbox(tk.Listbox):
    """RoboEvony-styled listbox"""
    
    def __init__(self, parent, **kwargs):
        super().__init__(
            parent,
            bg=Theme.BG_PANEL,
            fg=Theme.TEXT_PRIMARY,
            selectbackground=Theme.ACCENT_ORANGE,
            selectforeground=Theme.BG_DARK,
            font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_NORMAL),
            relief=tk.FLAT,
            borderwidth=0,
            highlightthickness=1,
            highlightcolor=Theme.ACCENT_ORANGE,
            highlightbackground=Theme.BORDER_DEFAULT,
            activestyle='none',
            **kwargs
        )


class ThemedText(tk.Text):
    """RoboEvony-styled text widget"""
    
    def __init__(self, parent, **kwargs):
        super().__init__(
            parent,
            bg=Theme.BG_INPUT,
            fg=Theme.TEXT_PRIMARY,
            insertbackground=Theme.TEXT_PRIMARY,
            selectbackground=Theme.ACCENT_ORANGE,
            selectforeground=Theme.BG_DARK,
            font=(Theme.FONT_MONO, Theme.FONT_SIZE_NORMAL),
            relief=tk.FLAT,
            borderwidth=1,
            highlightthickness=1,
            highlightcolor=Theme.ACCENT_ORANGE,
            highlightbackground=Theme.BORDER_DEFAULT,
            **kwargs
        )
        
        # Configure syntax highlighting tags
        self.tag_configure("keyword", foreground=Theme.ACCENT_BLUE)
        self.tag_configure("string", foreground=Theme.STATUS_POSITIVE)
        self.tag_configure("number", foreground=Theme.ACCENT_GOLD)
        self.tag_configure("error", foreground=Theme.STATUS_NEGATIVE)
        self.tag_configure("comment", foreground=Theme.TEXT_SECONDARY)


class SearchEntry(tk.Frame):
    """Search entry with icon and clear button"""
    
    def __init__(self, parent, placeholder: str = "Search...",
                 on_change: Callable = None, **kwargs):
        super().__init__(parent, bg=Theme.BG_DARK, **kwargs)
        
        self._on_change = on_change
        
        # Search icon
        self.icon_label = tk.Label(
            self,
            text="🔍",
            bg=Theme.BG_DARK,
            fg=Theme.TEXT_SECONDARY
        )
        self.icon_label.pack(side=tk.LEFT, padx=5)
        
        # Entry
        self.entry = ThemedEntry(self, placeholder=placeholder)
        self.entry.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=5)
        
        # Bind change event
        self._var = tk.StringVar()
        self.entry.config(textvariable=self._var)
        self._var.trace("w", self._on_text_change)
        
        # Clear button
        self.clear_btn = tk.Label(
            self,
            text="✕",
            bg=Theme.BG_DARK,
            fg=Theme.TEXT_SECONDARY,
            cursor="hand2"
        )
        self.clear_btn.pack(side=tk.RIGHT, padx=5)
        self.clear_btn.bind("<Button-1>", self._clear)
    
    def _on_text_change(self, *args):
        if self._on_change:
            self._on_change(self.get())
    
    def _clear(self, event=None):
        self.entry.delete(0, tk.END)
        self.entry.config(fg=Theme.TEXT_PRIMARY)
        self.entry._has_placeholder = False
    
    def get(self) -> str:
        return self.entry.get_value()


class NodeGrid(tk.Frame):
    """Grid display for Tor nodes"""
    
    def __init__(self, parent, nodes: int = 50, on_click: Callable = None, **kwargs):
        super().__init__(parent, bg=Theme.BG_DARK, **kwargs)
        
        self.nodes = nodes
        self.on_click = on_click
        self._node_labels = {}
        
        self._create_grid()
    
    def _create_grid(self):
        cols = 10
        rows = (self.nodes + cols - 1) // cols
        
        for i in range(self.nodes):
            row, col = i // cols, i % cols
            
            frame = tk.Frame(
                self,
                bg=Theme.BG_PANEL,
                relief=tk.RAISED,
                borderwidth=1
            )
            frame.grid(row=row, column=col, padx=2, pady=2)
            
            label = tk.Label(
                frame,
                text=f"N{i}\n0",
                bg=Theme.BG_PANEL,
                fg=Theme.TEXT_SECONDARY,
                font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_SMALL),
                width=5,
                cursor="hand2"
            )
            label.pack(padx=2, pady=2)
            label.bind("<Button-1>", lambda e, n=i: self._on_node_click(n))
            
            self._node_labels[i] = label
    
    def _on_node_click(self, node: int):
        if self.on_click:
            self.on_click(node)
    
    def update_node(self, node: int, count: int):
        """Update node display"""
        if node not in self._node_labels:
            return
        
        label = self._node_labels[node]
        label.config(text=f"N{node}\n{count}")
        
        # Color based on count
        if count == 0:
            bg = Theme.BG_PANEL
            fg = Theme.TEXT_DISABLED
        elif count > 12:  # Overloaded
            bg = Theme.STATUS_NEGATIVE
            fg = Theme.TEXT_PRIMARY
        elif count > 8:  # High
            bg = Theme.STATUS_WARNING
            fg = Theme.BG_DARK
        else:  # Normal
            bg = Theme.STATUS_POSITIVE
            fg = Theme.BG_DARK
        
        label.config(bg=bg, fg=fg)
        label.master.config(bg=bg)
    
    def update_all(self, distribution: dict):
        """Update all nodes from distribution dict"""
        for node in range(self.nodes):
            count = distribution.get(node, 0)
            self.update_node(node, count)


class TagBadge(tk.Frame):
    """Tag badge widget with remove button"""
    
    def __init__(self, parent, text: str, on_remove: Callable = None,
                 color: str = None, **kwargs):
        super().__init__(parent, bg=color or Theme.ACCENT_BLUE, **kwargs)
        
        self.tag_text = text
        
        label = tk.Label(
            self,
            text=text,
            bg=color or Theme.ACCENT_BLUE,
            fg=Theme.TEXT_PRIMARY,
            font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_SMALL),
            padx=5
        )
        label.pack(side=tk.LEFT)
        
        if on_remove:
            remove_btn = tk.Label(
                self,
                text="×",
                bg=color or Theme.ACCENT_BLUE,
                fg=Theme.TEXT_PRIMARY,
                font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_SMALL),
                cursor="hand2"
            )
            remove_btn.pack(side=tk.LEFT, padx=2)
            remove_btn.bind("<Button-1>", lambda e: on_remove(text))


class InfoCard(tk.Frame):
    """Information card with title and value"""
    
    def __init__(self, parent, title: str, value: str = "0",
                 icon: str = "", **kwargs):
        super().__init__(parent, bg=Theme.BG_PANEL, **kwargs)
        
        if icon:
            icon_lbl = tk.Label(
                self,
                text=icon,
                bg=Theme.BG_PANEL,
                font=(Theme.FONT_FAMILY, 20)
            )
            icon_lbl.pack(pady=(10, 0))
        
        self.value_label = tk.Label(
            self,
            text=value,
            bg=Theme.BG_PANEL,
            fg=Theme.ACCENT_ORANGE,
            font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_TITLE, "bold")
        )
        self.value_label.pack(pady=5)
        
        title_lbl = tk.Label(
            self,
            text=title,
            bg=Theme.BG_PANEL,
            fg=Theme.TEXT_SECONDARY,
            font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_SMALL)
        )
        title_lbl.pack(pady=(0, 10))
    
    def set_value(self, value: str, color: str = None):
        self.value_label.config(
            text=value,
            fg=color or Theme.ACCENT_ORANGE
        )
