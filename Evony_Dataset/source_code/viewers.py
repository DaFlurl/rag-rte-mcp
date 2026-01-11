#!/usr/bin/env python3
"""
Evony Hub - Content Viewers
Viewers for different file types (AS3, SOL, scripts, etc.)
"""

import tkinter as tk
from tkinter import ttk, scrolledtext
from pathlib import Path
from typing import Optional, Callable
import json


class BaseViewer:
    """Base class for content viewers."""
    
    def __init__(self, parent: tk.Widget):
        self.parent = parent
        self.frame = ttk.Frame(parent)
        self.content_widget = None
    
    def load(self, filepath: Path) -> bool:
        """Load file content. Override in subclasses."""
        raise NotImplementedError
    
    def clear(self):
        """Clear the viewer."""
        if self.content_widget:
            if hasattr(self.content_widget, 'delete'):
                self.content_widget.delete('1.0', 'end')
    
    def get_widget(self) -> ttk.Frame:
        """Get the viewer widget."""
        return self.frame


class TextViewer(BaseViewer):
    """Viewer for plain text files."""
    
    def __init__(self, parent: tk.Widget, syntax_highlight: bool = False):
        super().__init__(parent)
        self.syntax_highlight = syntax_highlight
        
        self.content_widget = scrolledtext.ScrolledText(
            self.frame,
            wrap='none',
            font=('Consolas', 10),
            bg='#1e1e2e',
            fg='#cdd6f4',
            insertbackground='white'
        )
        self.content_widget.pack(fill='both', expand=True)
        
        # Add horizontal scrollbar
        h_scroll = ttk.Scrollbar(self.frame, orient='horizontal', 
                                  command=self.content_widget.xview)
        h_scroll.pack(fill='x')
        self.content_widget.configure(xscrollcommand=h_scroll.set)
    
    def load(self, filepath: Path) -> bool:
        """Load text file content."""
        try:
            with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            self.clear()
            self.content_widget.insert('1.0', content)
            
            if self.syntax_highlight:
                self._apply_syntax_highlighting()
            
            return True
        except Exception as e:
            self.clear()
            self.content_widget.insert('1.0', f"Error loading file: {e}")
            return False
    
    def _apply_syntax_highlighting(self):
        """Apply basic syntax highlighting for AS3/scripts."""
        keywords = [
            'function', 'class', 'public', 'private', 'protected',
            'static', 'var', 'const', 'import', 'package', 'extends',
            'implements', 'interface', 'override', 'return', 'if', 
            'else', 'for', 'while', 'switch', 'case', 'break',
            'new', 'this', 'super', 'null', 'true', 'false',
        ]
        
        # Configure tags
        self.content_widget.tag_configure('keyword', foreground='#cba6f7')
        self.content_widget.tag_configure('string', foreground='#a6e3a1')
        self.content_widget.tag_configure('comment', foreground='#6c7086')
        self.content_widget.tag_configure('number', foreground='#fab387')
        
        content = self.content_widget.get('1.0', 'end')
        
        # Highlight keywords
        for keyword in keywords:
            start = '1.0'
            while True:
                pos = self.content_widget.search(
                    r'\m' + keyword + r'\M', start, 
                    stopindex='end', regexp=True
                )
                if not pos:
                    break
                end = f"{pos}+{len(keyword)}c"
                self.content_widget.tag_add('keyword', pos, end)
                start = end


class JSONViewer(BaseViewer):
    """Viewer for JSON files with tree structure."""
    
    def __init__(self, parent: tk.Widget):
        super().__init__(parent)
        
        self.tree = ttk.Treeview(self.frame, show='tree headings')
        self.tree.heading('#0', text='Key')
        self.tree.column('#0', width=300)
        
        scrollbar = ttk.Scrollbar(self.frame, orient='vertical', 
                                   command=self.tree.yview)
        self.tree.configure(yscrollcommand=scrollbar.set)
        
        self.tree.pack(side='left', fill='both', expand=True)
        scrollbar.pack(side='right', fill='y')
        
        self.content_widget = self.tree
    
    def load(self, filepath: Path) -> bool:
        """Load JSON file into tree view."""
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                data = json.load(f)
            
            self.clear()
            self._populate_tree('', '', data)
            return True
        except Exception as e:
            self.clear()
            self.tree.insert('', 'end', text=f"Error: {e}")
            return False
    
    def clear(self):
        """Clear the tree view."""
        for item in self.tree.get_children():
            self.tree.delete(item)
    
    def _populate_tree(self, parent: str, key: str, value):
        """Recursively populate tree with JSON data."""
        if isinstance(value, dict):
            node = self.tree.insert(parent, 'end', text=f"{key} {{...}}" if key else "{...}")
            for k, v in list(value.items())[:100]:  # Limit to 100 items
                self._populate_tree(node, k, v)
        elif isinstance(value, list):
            node = self.tree.insert(parent, 'end', text=f"{key} [{len(value)}]" if key else f"[{len(value)}]")
            for i, v in enumerate(value[:50]):  # Limit to 50 items
                self._populate_tree(node, f"[{i}]", v)
        else:
            display = f"{key}: {value}" if key else str(value)
            if len(display) > 100:
                display = display[:100] + "..."
            self.tree.insert(parent, 'end', text=display)


class HexViewer(BaseViewer):
    """Hex viewer for binary files."""
    
    def __init__(self, parent: tk.Widget, bytes_per_row: int = 16):
        super().__init__(parent)
        self.bytes_per_row = bytes_per_row
        
        self.content_widget = scrolledtext.ScrolledText(
            self.frame,
            wrap='none',
            font=('Consolas', 9),
            bg='#1e1e2e',
            fg='#cdd6f4'
        )
        self.content_widget.pack(fill='both', expand=True)
    
    def load(self, filepath: Path, max_bytes: int = 10000) -> bool:
        """Load binary file as hex dump."""
        try:
            with open(filepath, 'rb') as f:
                data = f.read(max_bytes)
            
            self.clear()
            
            lines = []
            for i in range(0, len(data), self.bytes_per_row):
                chunk = data[i:i+self.bytes_per_row]
                hex_part = ' '.join(f'{b:02x}' for b in chunk)
                ascii_part = ''.join(chr(b) if 32 <= b < 127 else '.' for b in chunk)
                lines.append(f'{i:08x}  {hex_part:<48}  {ascii_part}')
            
            self.content_widget.insert('1.0', '\n'.join(lines))
            return True
        except Exception as e:
            self.clear()
            self.content_widget.insert('1.0', f"Error: {e}")
            return False


class ViewerFactory:
    """Factory for creating appropriate viewers."""
    
    @staticmethod
    def create(parent: tk.Widget, filepath: Path) -> BaseViewer:
        """Create appropriate viewer for file type."""
        ext = filepath.suffix.lower()
        
        if ext == '.json':
            return JSONViewer(parent)
        elif ext in ('.sol', '.swf', '.abc'):
            return HexViewer(parent)
        elif ext in ('.as', '.py', '.js'):
            return TextViewer(parent, syntax_highlight=True)
        else:
            return TextViewer(parent)


__all__ = [
    'BaseViewer', 'TextViewer', 'JSONViewer', 'HexViewer', 'ViewerFactory'
]
