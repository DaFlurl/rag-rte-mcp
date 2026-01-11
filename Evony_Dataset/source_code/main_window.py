"""
ETK SOL Manager - Main Window Module
RoboEvony-themed main application window
"""

import os
import json
import tkinter as tk
from tkinter import ttk, messagebox, filedialog
from typing import Optional
from datetime import datetime

from ..config import SOL_TYPES, ETK_ROOT
from ..theme import RoboEvonyTheme as Theme
from ..account_manager import get_account_manager, Account
from ..sol_handler import get_sol_handler
from ..backup_manager import get_backup_manager
from ..node_manager import get_node_manager
from ..utils import json_safe_dump, json_safe_load, format_timestamp, event_bus
from .widgets import (
    HeaderBar, StatusBar, ThemedButton, ThemedEntry, ThemedListbox,
    ThemedText, SearchEntry, NodeGrid, TagBadge, InfoCard
)
from .bot_launcher_dialog import show_bot_launcher


class SOLManagerApp:
    """Main SOL Manager Application with RoboEvony theming"""
    
    def __init__(self, root: tk.Tk):
        self.root = root
        self.root.title("ETK SOL Manager Pro - RoboEvony Account Management")
        self.root.geometry("1400x900")
        self.root.minsize(1200, 700)
        
        # Apply theme
        Theme.apply_theme(self.root)
        
        # Initialize managers
        self.account_manager = get_account_manager()
        self.sol_handler = get_sol_handler()
        self.backup_manager = get_backup_manager()
        self.node_manager = get_node_manager()
        
        # Current state
        self.current_account: Optional[Account] = None
        self.current_sol_type: str = "config.sol"
        self.unsaved_changes: bool = False
        self._clipboard_data: dict = {}
        
        # Build UI
        self._create_layout()
        
        # Load accounts
        self.root.after(100, self._initial_load)
    
    def _create_layout(self):
        """Create the main application layout"""
        # Main container
        self.main_container = tk.Frame(self.root, bg=Theme.BG_DARK)
        self.main_container.pack(fill=tk.BOTH, expand=True)
        
        # Header bar
        self._create_header()
        
        # Main content area
        self._create_main_content()
        
        # Status bar
        self._create_status_bar()
        
        # Menu bar
        self._create_menu()
    
    def _create_header(self):
        """Create the header bar"""
        self.header = HeaderBar(self.main_container, title="ETK SOL Manager Pro")
        self.header.pack(fill=tk.X)
        
        # Add info items
        self.header.add_info("accounts", "Accounts", "0")
        self.header.add_info("active", "Active", "0")
        self.header.add_info("nodes", "Nodes Used", "0/50")
        self.header.add_info("version", "Version", "2.0")
    
    def _create_main_content(self):
        """Create the main content area with panes"""
        # Vertical paned window for main content + log panel
        self.vpaned = ttk.PanedWindow(self.main_container, orient=tk.VERTICAL)
        self.vpaned.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # Top section - Horizontal paned for account list and details
        top_frame = tk.Frame(self.vpaned, bg=Theme.BG_DARK)
        self.vpaned.add(top_frame, weight=3)
        
        # Paned window for resizable panels
        self.paned = ttk.PanedWindow(top_frame, orient=tk.HORIZONTAL)
        self.paned.pack(fill=tk.BOTH, expand=True)
        
        # Left panel - Account list
        self._create_left_panel()
        
        # Right panel - Details and editor
        self._create_right_panel()
        
        # Bottom section - Log panel
        self._create_log_panel()
    
    def _create_left_panel(self):
        """Create the left panel with account list"""
        left_frame = tk.Frame(self.paned, bg=Theme.BG_DARK, width=320)
        self.paned.add(left_frame, weight=1)
        
        # Search
        search_frame = tk.Frame(left_frame, bg=Theme.BG_DARK)
        search_frame.pack(fill=tk.X, padx=5, pady=5)
        
        self.search_entry = SearchEntry(
            search_frame,
            placeholder="Search accounts...",
            on_change=self._filter_accounts
        )
        self.search_entry.pack(fill=tk.X)
        
        # Filter buttons
        filter_frame = tk.Frame(left_frame, bg=Theme.BG_DARK)
        filter_frame.pack(fill=tk.X, padx=5, pady=2)
        
        self.filter_var = tk.StringVar(value="all")
        filters = [("All", "all"), ("Active", "active"), ("Inactive", "inactive")]
        for text, value in filters:
            rb = ttk.Radiobutton(
                filter_frame,
                text=text,
                value=value,
                variable=self.filter_var,
                command=self._filter_accounts
            )
            rb.pack(side=tk.LEFT, padx=5)
        
        # Account list
        list_frame = tk.LabelFrame(
            left_frame,
            text="Accounts (0)",
            bg=Theme.BG_DARK,
            fg=Theme.ACCENT_ORANGE,
            font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_NORMAL, "bold")
        )
        list_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        self.account_list_frame = list_frame
        
        # Listbox with scrollbar
        list_inner = tk.Frame(list_frame, bg=Theme.BG_DARK)
        list_inner.pack(fill=tk.BOTH, expand=True, padx=2, pady=2)
        
        self.account_listbox = ThemedListbox(list_inner, selectmode=tk.SINGLE)
        self.account_listbox.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        self.account_listbox.bind('<<ListboxSelect>>', self._on_account_select)
        self.account_listbox.bind('<Button-3>', self._show_context_menu)
        
        scrollbar = ttk.Scrollbar(list_inner, orient=tk.VERTICAL,
                                  command=self.account_listbox.yview)
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y)
        self.account_listbox.config(yscrollcommand=scrollbar.set)
        
        # Quick stats
        stats_frame = tk.Frame(left_frame, bg=Theme.BG_PANEL)
        stats_frame.pack(fill=tk.X, padx=5, pady=5)
        
        self.stats_label = tk.Label(
            stats_frame,
            text="Select an account to view details",
            bg=Theme.BG_PANEL,
            fg=Theme.TEXT_SECONDARY,
            font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_SMALL)
        )
        self.stats_label.pack(pady=5)
    
    def _create_right_panel(self):
        """Create the right panel with details and editor"""
        right_frame = tk.Frame(self.paned, bg=Theme.BG_DARK)
        self.paned.add(right_frame, weight=3)
        
        # Account info header
        self._create_account_info(right_frame)
        
        # Notebook with tabs
        self._create_notebook(right_frame)
        
        # Action buttons
        self._create_action_buttons(right_frame)
    
    def _create_account_info(self, parent):
        """Create account info section"""
        info_frame = tk.Frame(parent, bg=Theme.BG_HEADER)
        info_frame.pack(fill=tk.X, padx=5, pady=5)
        
        # Account details row
        self.info_labels = {}
        details = [
            ("email", "Email"),
            ("server", "Server"),
            ("proxy", "Proxy"),
            ("node", "Node"),
            ("status", "Status")
        ]
        
        for key, label in details:
            frame = tk.Frame(info_frame, bg=Theme.BG_HEADER)
            frame.pack(side=tk.LEFT, padx=15, pady=8)
            
            lbl = tk.Label(
                frame,
                text=f"{label}:",
                bg=Theme.BG_HEADER,
                fg=Theme.TEXT_SECONDARY,
                font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_SMALL)
            )
            lbl.pack(anchor=tk.W)
            
            val = tk.Label(
                frame,
                text="-",
                bg=Theme.BG_HEADER,
                fg=Theme.TEXT_PRIMARY,
                font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_NORMAL, "bold")
            )
            val.pack(anchor=tk.W)
            self.info_labels[key] = val
        
        # Tags section
        self.tags_frame = tk.Frame(info_frame, bg=Theme.BG_HEADER)
        self.tags_frame.pack(side=tk.RIGHT, padx=15, pady=8)
    
    def _create_notebook(self, parent):
        """Create notebook with SOL type tabs and account data tabs"""
        self.notebook = ttk.Notebook(parent)
        self.notebook.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # Add Account Data tab first
        self._create_account_data_tab()
        
        self.sol_tabs = {}
        self.sol_editors = {}
        
        for sol_type, info in SOL_TYPES.items():
            tab = tk.Frame(self.notebook, bg=Theme.BG_DARK)
            tab_name = f"{info.get('icon', '')} {sol_type.replace('.sol', '').title()}"
            self.notebook.add(tab, text=tab_name)
            self.sol_tabs[sol_type] = tab
            
            # Description
            desc_frame = tk.Frame(tab, bg=Theme.BG_PANEL)
            desc_frame.pack(fill=tk.X, padx=5, pady=5)
            
            tk.Label(
                desc_frame,
                text=info["description"],
                bg=Theme.BG_PANEL,
                fg=Theme.ACCENT_ORANGE,
                font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_NORMAL, "bold")
            ).pack(anchor=tk.W, padx=10, pady=5)
            
            tk.Label(
                desc_frame,
                text=f"Location: {info['location']}",
                bg=Theme.BG_PANEL,
                fg=Theme.TEXT_SECONDARY,
                font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_SMALL)
            ).pack(anchor=tk.W, padx=10, pady=(0, 5))
            
            # Editor with scrollbar
            editor_frame = tk.Frame(tab, bg=Theme.BG_DARK)
            editor_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
            
            editor = ThemedText(editor_frame, wrap=tk.NONE)
            editor.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
            
            v_scroll = ttk.Scrollbar(editor_frame, orient=tk.VERTICAL, command=editor.yview)
            v_scroll.pack(side=tk.RIGHT, fill=tk.Y)
            
            h_scroll = ttk.Scrollbar(tab, orient=tk.HORIZONTAL, command=editor.xview)
            h_scroll.pack(fill=tk.X, padx=5)
            
            editor.config(yscrollcommand=v_scroll.set, xscrollcommand=h_scroll.set)
            editor.bind('<KeyRelease>', lambda e, st=sol_type: self._on_editor_change(st))
            
            self.sol_editors[sol_type] = editor
            
            # Field reference
            ref_frame = tk.LabelFrame(
                tab,
                text="Field Reference",
                bg=Theme.BG_DARK,
                fg=Theme.ACCENT_ORANGE,
                font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_SMALL, "bold")
            )
            ref_frame.pack(fill=tk.X, padx=5, pady=5)
            
            ref_text = tk.Text(
                ref_frame,
                height=3,
                wrap=tk.WORD,
                bg=Theme.BG_PANEL,
                fg=Theme.TEXT_SECONDARY,
                font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_SMALL),
                state=tk.DISABLED,
                relief=tk.FLAT
            )
            ref_text.pack(fill=tk.X, padx=5, pady=5)
            
            ref_text.config(state=tk.NORMAL)
            for field, desc in info["fields"].items():
                ref_text.insert(tk.END, f"• {field}: {desc}\n")
            ref_text.config(state=tk.DISABLED)
    
    def _create_action_buttons(self, parent):
        """Create action button bar"""
        btn_frame = tk.Frame(parent, bg=Theme.BG_DARK)
        btn_frame.pack(fill=tk.X, padx=5, pady=10)
        
        buttons = [
            ("💾 Save", self._save_changes, True),
            ("↩️ Discard", self._discard_changes, False),
            ("📋 Copy", self._copy_config, False),
            ("📥 Paste", self._paste_config, False),
            ("🔄 Share", self._show_share_dialog, False),
            ("📁 Backup", self._create_backup, False),
            ("⏱️ Timeline", self._show_timeline, False),
            ("🌐 Nodes", self._show_node_manager, False),
            ("🚀 Launch Bots", self._show_bot_launcher, False),
        ]
        
        for text, command, accent in buttons:
            btn = ThemedButton(btn_frame, text=text, command=command, accent=accent)
            btn.pack(side=tk.LEFT, padx=3)
    
    def _create_status_bar(self):
        """Create status bar"""
        self.status_bar = StatusBar(self.main_container)
        self.status_bar.pack(side=tk.BOTTOM, fill=tk.X)
        
        self.status_bar.add_indicator("pyamf", "PyAMF: " + 
            ("✓" if self.sol_handler.amf_available else "✗"))
    
    def _create_menu(self):
        """Create menu bar"""
        menubar = tk.Menu(self.root, bg=Theme.BG_PANEL, fg=Theme.TEXT_PRIMARY)
        self.root.config(menu=menubar)
        
        # File menu
        file_menu = tk.Menu(menubar, tearoff=0, bg=Theme.BG_PANEL, fg=Theme.TEXT_PRIMARY)
        menubar.add_cascade(label="File", menu=file_menu)
        file_menu.add_command(label="Refresh Accounts", command=self._load_accounts)
        file_menu.add_command(label="Export All", command=self._export_all)
        file_menu.add_separator()
        file_menu.add_command(label="Exit", command=self.root.quit)
        
        # Edit menu
        edit_menu = tk.Menu(menubar, tearoff=0, bg=Theme.BG_PANEL, fg=Theme.TEXT_PRIMARY)
        menubar.add_cascade(label="Edit", menu=edit_menu)
        edit_menu.add_command(label="Save Changes", command=self._save_changes)
        edit_menu.add_command(label="Discard Changes", command=self._discard_changes)
        edit_menu.add_separator()
        edit_menu.add_command(label="Batch Edit", command=self._show_batch_edit)
        
        # Tools menu
        tools_menu = tk.Menu(menubar, tearoff=0, bg=Theme.BG_PANEL, fg=Theme.TEXT_PRIMARY)
        menubar.add_cascade(label="Tools", menu=tools_menu)
        tools_menu.add_command(label="🔍 Account Scanner", command=self._show_scanner)
        tools_menu.add_command(label="Share Config", command=self._show_share_dialog)
        tools_menu.add_command(label="Node Manager", command=self._show_node_manager)
        tools_menu.add_command(label="Dashboard", command=self._show_dashboard)
        tools_menu.add_separator()
        tools_menu.add_command(label="🚀 Bot Launcher", command=self._show_bot_launcher)
        tools_menu.add_command(label="Auto-Distribute Nodes", command=self._auto_distribute_nodes)
        
        # Backup menu
        backup_menu = tk.Menu(menubar, tearoff=0, bg=Theme.BG_PANEL, fg=Theme.TEXT_PRIMARY)
        menubar.add_cascade(label="Backup", menu=backup_menu)
        backup_menu.add_command(label="Create Backup", command=self._create_backup)
        backup_menu.add_command(label="View Timeline", command=self._show_timeline)
        backup_menu.add_command(label="Backup Statistics", command=self._show_backup_stats)
        
        # Help menu
        help_menu = tk.Menu(menubar, tearoff=0, bg=Theme.BG_PANEL, fg=Theme.TEXT_PRIMARY)
        menubar.add_cascade(label="Help", menu=help_menu)
        help_menu.add_command(label="SOL Reference", command=self._show_reference)
        help_menu.add_command(label="About", command=self._show_about)
    
    # ========================================================================
    # EVENT HANDLERS
    # ========================================================================
    
    def _initial_load(self):
        """Initial data load"""
        self._load_accounts()
    
    def _load_accounts(self):
        """Load all accounts"""
        self.status_bar.set_status("Loading accounts...", Theme.STATUS_INFO)
        self.root.update()
        
        count = self.account_manager.scan_accounts()
        self.node_manager.load_from_accounts(self.account_manager.accounts)
        
        self._populate_account_list()
        self._update_header_stats()
        
        self.status_bar.set_status(f"Loaded {count} accounts", Theme.STATUS_POSITIVE)
    
    def _populate_account_list(self, accounts=None):
        """Populate account listbox"""
        self.account_listbox.delete(0, tk.END)
        
        if accounts is None:
            accounts = self.account_manager.get_all_accounts()
        
        for account in sorted(accounts, key=lambda a: a.email):
            # Show status indicator
            status = "●" if account.is_active else "○"
            self.account_listbox.insert(tk.END, f"{status} {account.email}")
        
        self.account_list_frame.config(text=f"Accounts ({len(accounts)})")
    
    def _filter_accounts(self, search_text=None):
        """Filter account list"""
        search = search_text or self.search_entry.get()
        filter_type = self.filter_var.get()
        
        active_only = filter_type == "active"
        inactive_only = filter_type == "inactive"
        
        accounts = []
        for account in self.account_manager.get_all_accounts():
            # Search filter
            if search and search.lower() not in account.email.lower():
                continue
            # Active filter
            if active_only and not account.is_active:
                continue
            if inactive_only and account.is_active:
                continue
            accounts.append(account)
        
        self._populate_account_list(accounts)
    
    def _on_account_select(self, event):
        """Handle account selection"""
        selection = self.account_listbox.curselection()
        if not selection:
            return
        
        if self.unsaved_changes:
            if not messagebox.askyesno("Unsaved Changes", "Discard unsaved changes?"):
                return
        
        item = self.account_listbox.get(selection[0])
        email = item.split(" ", 1)[1]  # Remove status indicator
        self._load_account(email)
    
    def _load_account(self, email: str):
        """Load account data into editors"""
        account = self.account_manager.get_account(email)
        if not account:
            return
        
        self.current_account = account
        self.unsaved_changes = False
        
        # Update info labels
        self.info_labels["email"].config(text=email, fg=Theme.TEXT_PRIMARY)
        self.info_labels["server"].config(
            text=f"{account.server} ({account.server_alias})" if account.server_alias else account.server,
            fg=Theme.TEXT_PRIMARY
        )
        self.info_labels["proxy"].config(
            text=f"127.0.0.1:{account.proxy_port}",
            fg=Theme.TEXT_PRIMARY
        )
        self.info_labels["node"].config(
            text=f"Node {account.node}" if account.node >= 0 else "-",
            fg=Theme.ACCENT_BLUE
        )
        self.info_labels["status"].config(
            text="Active" if account.is_active else "Inactive",
            fg=Theme.STATUS_POSITIVE if account.is_active else Theme.TEXT_SECONDARY
        )
        
        # Update tags display
        self._update_tags_display()
        
        # Update account data tab
        self._update_account_data_display(account)
        
        # Log account selection
        self._log(f"Selected account: {email}", "info", email.split('@')[0])
        self._log(f"Server: {account.server} ({account.server_alias})", "info", email.split('@')[0])
        
        # Load SOL files into editors
        for sol_type, editor in self.sol_editors.items():
            editor.delete("1.0", tk.END)
            
            sol_path = account.sol_files.get(sol_type)
            if sol_path and os.path.exists(sol_path):
                data = self.sol_handler.read_sol(sol_path)
                if data:
                    formatted = json_safe_dump(data)
                    editor.insert("1.0", formatted)
                    self._log(f"Loaded {sol_type}", "success", email.split('@')[0])
            else:
                editor.insert("1.0", "# No data found")
        
        self.status_bar.set_status(f"Loaded: {email}")
    
    def _update_tags_display(self):
        """Update tags display for current account"""
        for widget in self.tags_frame.winfo_children():
            widget.destroy()
        
        if not self.current_account:
            return
        
        for tag in self.current_account.tags:
            badge = TagBadge(
                self.tags_frame,
                text=tag,
                on_remove=lambda t: self._remove_tag(t)
            )
            badge.pack(side=tk.LEFT, padx=2)
        
        # Add tag button
        add_btn = tk.Label(
            self.tags_frame,
            text="+",
            bg=Theme.BG_HEADER,
            fg=Theme.ACCENT_ORANGE,
            font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_NORMAL),
            cursor="hand2"
        )
        add_btn.pack(side=tk.LEFT, padx=5)
        add_btn.bind("<Button-1>", lambda e: self._add_tag_dialog())
    
    def _on_editor_change(self, sol_type: str):
        """Handle editor content change"""
        self.unsaved_changes = True
        self.status_bar.set_status(f"Editing {sol_type} - UNSAVED", Theme.STATUS_WARNING)
    
    def _update_header_stats(self):
        """Update header statistics"""
        stats = self.account_manager.get_stats()
        node_stats = self.node_manager.get_stats()
        
        self.header.update_info("accounts", str(stats["total_accounts"]))
        self.header.update_info("active", str(stats["active_accounts"]), Theme.STATUS_POSITIVE)
        self.header.update_info("nodes", f"{node_stats['used_nodes']}/{node_stats['total_nodes']}")
    
    # ========================================================================
    # ACTIONS
    # ========================================================================
    
    def _save_changes(self):
        """Save changes to SOL files"""
        if not self.current_account:
            messagebox.showwarning("No Account", "Select an account first")
            return
        
        # Create backup first
        all_data = {}
        for sol_type, path in self.current_account.sol_files.items():
            if os.path.exists(path):
                all_data[sol_type] = self.sol_handler.read_sol(path)
        
        self.backup_manager.create_backup(
            self.current_account.email,
            all_data,
            reason="before_save"
        )
        
        # Save each editor
        saved = 0
        for sol_type, editor in self.sol_editors.items():
            content = editor.get("1.0", tk.END).strip()
            if content.startswith("#"):
                continue
            
            data, error = json_safe_load(content)
            if error:
                messagebox.showerror("JSON Error", f"{sol_type}: {error}")
                return
            
            path = self.current_account.sol_files.get(sol_type)
            if path:
                success, err = self.sol_handler.write_sol(path, data)
                if success:
                    saved += 1
                else:
                    messagebox.showerror("Save Error", f"{sol_type}: {err}")
                    return
        
        self.unsaved_changes = False
        self.status_bar.set_status(f"Saved {saved} files", Theme.STATUS_POSITIVE)
        messagebox.showinfo("Saved", f"Saved {saved} SOL files")
    
    def _discard_changes(self):
        """Discard unsaved changes"""
        if self.current_account:
            self._load_account(self.current_account.email)
        self.unsaved_changes = False
    
    def _copy_config(self):
        """Copy current tab config to clipboard"""
        if not self.current_account:
            return
        
        tab_idx = self.notebook.index(self.notebook.select())
        sol_type = list(self.sol_editors.keys())[tab_idx]
        content = self.sol_editors[sol_type].get("1.0", tk.END)
        
        self._clipboard_data = {"sol_type": sol_type, "content": content}
        self.root.clipboard_clear()
        self.root.clipboard_append(content)
        self.status_bar.set_status(f"Copied {sol_type}", Theme.STATUS_INFO)
    
    def _paste_config(self):
        """Paste config from clipboard"""
        try:
            content = self.root.clipboard_get()
            data, error = json_safe_load(content)
            if error:
                messagebox.showerror("Invalid JSON", error)
                return
            
            tab_idx = self.notebook.index(self.notebook.select())
            sol_type = list(self.sol_editors.keys())[tab_idx]
            
            self.sol_editors[sol_type].delete("1.0", tk.END)
            self.sol_editors[sol_type].insert("1.0", json_safe_dump(data))
            self.unsaved_changes = True
            self.status_bar.set_status(f"Pasted to {sol_type}", Theme.STATUS_INFO)
        except Exception as e:
            messagebox.showerror("Paste Error", str(e))
    
    def _create_backup(self):
        """Create manual backup"""
        if not self.current_account:
            messagebox.showwarning("No Account", "Select an account first")
            return
        
        all_data = {}
        for sol_type, path in self.current_account.sol_files.items():
            if os.path.exists(path):
                all_data[sol_type] = self.sol_handler.read_sol(path)
        
        path, success = self.backup_manager.create_backup(
            self.current_account.email,
            all_data,
            reason="manual"
        )
        
        if success:
            messagebox.showinfo("Backup Created", f"Saved to:\n{path}")
        else:
            messagebox.showerror("Backup Failed", path)
    
    def _show_timeline(self):
        """Show backup timeline dialog"""
        if not self.current_account:
            messagebox.showwarning("No Account", "Select an account first")
            return
        
        timeline = self.backup_manager.get_timeline(self.current_account.email)
        
        win = tk.Toplevel(self.root)
        win.title(f"Backup Timeline - {self.current_account.email}")
        win.geometry("700x500")
        win.configure(bg=Theme.BG_DARK)
        
        tk.Label(
            win,
            text=f"Backups for: {self.current_account.email}",
            bg=Theme.BG_DARK,
            fg=Theme.ACCENT_ORANGE,
            font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_HEADER, "bold")
        ).pack(pady=10)
        
        # Treeview
        tree = ttk.Treeview(win, columns=("date", "reason", "files"), show="headings")
        tree.heading("date", text="Date/Time")
        tree.heading("reason", text="Reason")
        tree.heading("files", text="Files")
        tree.column("date", width=180)
        tree.column("reason", width=150)
        tree.column("files", width=300)
        tree.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)
        
        for backup in timeline:
            tree.insert("", tk.END, values=(
                format_timestamp(backup.get("created", "")),
                backup.get("reason", ""),
                ", ".join(backup.get("files", []))
            ), tags=(backup.get("path"),))
        
        def restore():
            sel = tree.selection()
            if sel:
                path = tree.item(sel[0])["tags"][0]
                data, success = self.backup_manager.restore_backup(path)
                if success:
                    for sol_type, sol_data in data.items():
                        if sol_type in self.sol_editors:
                            self.sol_editors[sol_type].delete("1.0", tk.END)
                            self.sol_editors[sol_type].insert("1.0", json_safe_dump(sol_data))
                    self.unsaved_changes = True
                    messagebox.showinfo("Restored", "Data restored. Save to apply.")
                    win.destroy()
        
        ThemedButton(win, text="Restore Selected", command=restore, accent=True).pack(pady=10)
    
    def _show_share_dialog(self):
        """Show config sharing dialog"""
        if not self.current_account:
            messagebox.showwarning("No Account", "Select source account first")
            return
        
        win = tk.Toplevel(self.root)
        win.title("Share Config")
        win.geometry("700x600")
        win.configure(bg=Theme.BG_DARK)
        
        tk.Label(
            win,
            text=f"Share from: {self.current_account.email}",
            bg=Theme.BG_DARK,
            fg=Theme.ACCENT_ORANGE,
            font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_HEADER, "bold")
        ).pack(pady=10)
        
        # SOL type selection
        sol_frame = tk.LabelFrame(win, text="Select what to share",
                                  bg=Theme.BG_DARK, fg=Theme.ACCENT_ORANGE)
        sol_frame.pack(fill=tk.X, padx=10, pady=5)
        
        sol_vars = {}
        for sol_type in SOL_TYPES:
            var = tk.BooleanVar(value=False)
            sol_vars[sol_type] = var
            ttk.Checkbutton(sol_frame, text=sol_type, variable=var).pack(anchor=tk.W, padx=10)
        
        # Target selection
        target_frame = tk.LabelFrame(win, text="Select targets",
                                     bg=Theme.BG_DARK, fg=Theme.ACCENT_ORANGE)
        target_frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=5)
        
        listbox = ThemedListbox(target_frame, selectmode=tk.MULTIPLE)
        listbox.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        for account in sorted(self.account_manager.get_all_accounts(), key=lambda a: a.email):
            if account.email != self.current_account.email:
                listbox.insert(tk.END, account.email)
        
        def execute():
            types = [t for t, v in sol_vars.items() if v.get()]
            targets = [listbox.get(i) for i in listbox.curselection()]
            
            if not types or not targets:
                messagebox.showwarning("Selection Required", "Select SOL types and targets")
                return
            
            if not messagebox.askyesno("Confirm", f"Share {len(types)} configs to {len(targets)} accounts?"):
                return
            
            # Get source data
            source_data = {}
            for sol_type in types:
                path = self.current_account.sol_files.get(sol_type)
                if path and os.path.exists(path):
                    source_data[sol_type] = self.sol_handler.read_sol(path)
            
            # Apply to targets
            success = 0
            for email in targets:
                target = self.account_manager.get_account(email)
                if not target:
                    continue
                
                # Backup target
                target_data = {}
                for sol_type, path in target.sol_files.items():
                    if os.path.exists(path):
                        target_data[sol_type] = self.sol_handler.read_sol(path)
                self.backup_manager.create_backup(email, target_data, "before_share")
                
                # Apply changes
                for sol_type, data in source_data.items():
                    path = target.sol_files.get(sol_type)
                    if path:
                        # Preserve login credentials for config.sol
                        if sol_type == "config.sol":
                            existing = self.sol_handler.read_sol(path)
                            if existing and "now" in existing and "now" in data:
                                data["now"]["username"] = existing["now"].get("username", "")
                                data["now"]["password"] = existing["now"].get("password", "")
                                data["now"]["proxyPort"] = existing["now"].get("proxyPort", "")
                        self.sol_handler.write_sol(path, data)
                success += 1
            
            messagebox.showinfo("Complete", f"Shared to {success} accounts")
            win.destroy()
        
        ThemedButton(win, text="Execute Share", command=execute, accent=True).pack(pady=10)
    
    def _show_node_manager(self):
        """Show node management dialog"""
        win = tk.Toplevel(self.root)
        win.title("Tor Node Manager")
        win.geometry("900x600")
        win.configure(bg=Theme.BG_DARK)
        
        tk.Label(
            win,
            text="Tor Node Management",
            bg=Theme.BG_DARK,
            fg=Theme.ACCENT_ORANGE,
            font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_HEADER, "bold")
        ).pack(pady=10)
        
        # Stats
        stats_frame = tk.Frame(win, bg=Theme.BG_PANEL)
        stats_frame.pack(fill=tk.X, padx=10, pady=5)
        
        stats = self.node_manager.get_stats()
        for label, value in [
            ("Total Nodes", stats["total_nodes"]),
            ("Used", stats["used_nodes"]),
            ("Empty", stats["empty_nodes"]),
            ("Accounts", stats["total_accounts"]),
            ("Overloaded", stats["overloaded_nodes"])
        ]:
            frame = tk.Frame(stats_frame, bg=Theme.BG_PANEL)
            frame.pack(side=tk.LEFT, padx=20, pady=10)
            tk.Label(frame, text=str(value), bg=Theme.BG_PANEL, fg=Theme.ACCENT_ORANGE,
                    font=(Theme.FONT_FAMILY, 18, "bold")).pack()
            tk.Label(frame, text=label, bg=Theme.BG_PANEL, fg=Theme.TEXT_SECONDARY,
                    font=(Theme.FONT_FAMILY, 10)).pack()
        
        # Node grid
        grid_frame = tk.Frame(win, bg=Theme.BG_DARK)
        grid_frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)
        
        node_grid = NodeGrid(grid_frame, nodes=50)
        node_grid.pack(fill=tk.BOTH, expand=True)
        node_grid.update_all(stats["distribution"])
        
        # Actions
        btn_frame = tk.Frame(win, bg=Theme.BG_DARK)
        btn_frame.pack(pady=10)
        
        def auto_dist():
            if messagebox.askyesno("Confirm", "Redistribute all accounts evenly?"):
                self._auto_distribute_nodes()
                win.destroy()
        
        ThemedButton(btn_frame, text="Auto-Distribute", command=auto_dist, accent=True).pack(side=tk.LEFT, padx=5)
        ThemedButton(btn_frame, text="Close", command=win.destroy).pack(side=tk.LEFT, padx=5)
    
    def _auto_distribute_nodes(self):
        """Auto-distribute accounts across nodes"""
        emails = self.account_manager.get_all_emails()
        assignments = self.node_manager.auto_distribute(emails)
        
        for email, (node, port) in assignments.items():
            account = self.account_manager.get_account(email)
            if not account:
                continue
            
            path = account.sol_files.get("config.sol")
            if path and os.path.exists(path):
                data = self.sol_handler.read_sol(path)
                if data and "now" in data:
                    # Backup first
                    self.backup_manager.create_backup(email, {"config.sol": data}, "node_redistribute")
                    data["now"]["proxyPort"] = str(port)
                    data["now"]["proxyHost"] = "127.0.0.1"
                    self.sol_handler.write_sol(path, data)
        
        self._update_header_stats()
        messagebox.showinfo("Complete", f"Distributed {len(assignments)} accounts across 50 nodes")
    
    def _show_dashboard(self):
        """Show dashboard with statistics"""
        win = tk.Toplevel(self.root)
        win.title("Account Dashboard")
        win.geometry("800x600")
        win.configure(bg=Theme.BG_DARK)
        
        tk.Label(
            win,
            text="Account Dashboard",
            bg=Theme.BG_DARK,
            fg=Theme.ACCENT_ORANGE,
            font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_TITLE, "bold")
        ).pack(pady=15)
        
        stats = self.account_manager.get_stats()
        
        # Info cards
        cards_frame = tk.Frame(win, bg=Theme.BG_DARK)
        cards_frame.pack(fill=tk.X, padx=20, pady=10)
        
        cards_data = [
            ("Total Accounts", str(stats["total_accounts"]), "👥"),
            ("Active", str(stats["active_accounts"]), "✓"),
            ("Inactive", str(stats["inactive_accounts"]), "○"),
            ("Servers", str(len(stats["servers"])), "🌐"),
            ("Tags", str(stats["unique_tags"]), "🏷️"),
        ]
        
        for title, value, icon in cards_data:
            card = InfoCard(cards_frame, title=title, value=value, icon=icon)
            card.pack(side=tk.LEFT, padx=10, pady=10, fill=tk.BOTH, expand=True)
        
        # Server distribution
        server_frame = tk.LabelFrame(win, text="Server Distribution",
                                     bg=Theme.BG_DARK, fg=Theme.ACCENT_ORANGE)
        server_frame.pack(fill=tk.X, padx=20, pady=10)
        
        for server, count in sorted(stats["servers"].items(), key=lambda x: -x[1]):
            frame = tk.Frame(server_frame, bg=Theme.BG_DARK)
            frame.pack(fill=tk.X, padx=10, pady=2)
            
            tk.Label(frame, text=server, bg=Theme.BG_DARK, fg=Theme.TEXT_PRIMARY,
                    width=15, anchor=tk.W).pack(side=tk.LEFT)
            
            # Progress bar
            pct = count / stats["total_accounts"] * 100 if stats["total_accounts"] > 0 else 0
            bar_frame = tk.Frame(frame, bg=Theme.BG_PANEL, height=15)
            bar_frame.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=5)
            bar_frame.pack_propagate(False)
            
            fill = tk.Frame(bar_frame, bg=Theme.ACCENT_ORANGE, width=int(pct * 2))
            fill.pack(side=tk.LEFT, fill=tk.Y)
            
            tk.Label(frame, text=f"{count} ({pct:.1f}%)", bg=Theme.BG_DARK,
                    fg=Theme.TEXT_SECONDARY, width=15).pack(side=tk.RIGHT)
    
    def _show_batch_edit(self):
        """Show batch edit dialog"""
        win = tk.Toplevel(self.root)
        win.title("Batch Edit")
        win.geometry("600x500")
        win.configure(bg=Theme.BG_DARK)
        
        tk.Label(
            win,
            text="Batch Edit Accounts",
            bg=Theme.BG_DARK,
            fg=Theme.ACCENT_ORANGE,
            font=(Theme.FONT_FAMILY, Theme.FONT_SIZE_HEADER, "bold")
        ).pack(pady=10)
        
        # Field selection
        field_frame = tk.LabelFrame(win, text="Field to edit",
                                    bg=Theme.BG_DARK, fg=Theme.ACCENT_ORANGE)
        field_frame.pack(fill=tk.X, padx=10, pady=5)
        
        field_var = tk.StringVar(value="proxyPort")
        for field in ["proxyPort", "proxyHost", "server", "autoLogin", "autoRun"]:
            ttk.Radiobutton(field_frame, text=field, value=field, variable=field_var).pack(anchor=tk.W, padx=10)
        
        # New value
        value_frame = tk.LabelFrame(win, text="New value",
                                    bg=Theme.BG_DARK, fg=Theme.ACCENT_ORANGE)
        value_frame.pack(fill=tk.X, padx=10, pady=5)
        
        value_entry = ThemedEntry(value_frame)
        value_entry.pack(fill=tk.X, padx=10, pady=10)
        
        # Account selection
        acct_frame = tk.LabelFrame(win, text="Select accounts",
                                   bg=Theme.BG_DARK, fg=Theme.ACCENT_ORANGE)
        acct_frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=5)
        
        listbox = ThemedListbox(acct_frame, selectmode=tk.MULTIPLE)
        listbox.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        for account in sorted(self.account_manager.get_all_accounts(), key=lambda a: a.email):
            listbox.insert(tk.END, account.email)
        
        def apply():
            field = field_var.get()
            value = value_entry.get()
            selection = [listbox.get(i) for i in listbox.curselection()]
            
            if not selection or not value:
                messagebox.showwarning("Required", "Select accounts and enter value")
                return
            
            if not messagebox.askyesno("Confirm", f"Set {field}={value} for {len(selection)} accounts?"):
                return
            
            for email in selection:
                account = self.account_manager.get_account(email)
                if not account:
                    continue
                
                path = account.sol_files.get("config.sol")
                if path and os.path.exists(path):
                    data = self.sol_handler.read_sol(path)
                    self.backup_manager.create_backup(email, {"config.sol": data}, "batch_edit")
                    
                    if "now" in data:
                        if value.lower() in ['true', 'false']:
                            data["now"][field] = value.lower() == 'true'
                        else:
                            data["now"][field] = value
                        self.sol_handler.write_sol(path, data)
            
            messagebox.showinfo("Complete", f"Updated {len(selection)} accounts")
            win.destroy()
        
        ThemedButton(win, text="Apply Changes", command=apply, accent=True).pack(pady=10)
    
    def _show_context_menu(self, event):
        """Show right-click context menu"""
        selection = self.account_listbox.curselection()
        if not selection:
            return
        
        menu = tk.Menu(self.root, tearoff=0, bg=Theme.BG_PANEL, fg=Theme.TEXT_PRIMARY)
        menu.add_command(label="Add Tag", command=self._add_tag_dialog)
        menu.add_command(label="Remove Tags", command=self._remove_all_tags)
        menu.add_separator()
        menu.add_command(label="Create Backup", command=self._create_backup)
        menu.add_command(label="Export Account", command=self._export_account)
        
        menu.post(event.x_root, event.y_root)
    
    def _add_tag_dialog(self):
        """Show add tag dialog"""
        if not self.current_account:
            return
        
        tag = tk.simpledialog.askstring("Add Tag", "Enter tag name:")
        if tag:
            self.account_manager.add_tag(self.current_account.email, tag)
            self._update_tags_display()
    
    def _remove_tag(self, tag: str):
        """Remove a tag from current account"""
        if self.current_account:
            self.account_manager.remove_tag(self.current_account.email, tag)
            self._update_tags_display()
    
    def _remove_all_tags(self):
        """Remove all tags from current account"""
        if self.current_account:
            for tag in list(self.current_account.tags):
                self.account_manager.remove_tag(self.current_account.email, tag)
            self._update_tags_display()
    
    def _export_account(self):
        """Export current account data"""
        if not self.current_account:
            return
        
        path = filedialog.asksaveasfilename(
            defaultextension=".json",
            filetypes=[("JSON", "*.json")],
            initialfilename=f"{self.current_account.email.replace('@', '_')}.json"
        )
        
        if path:
            data = {"email": self.current_account.email, "sol_files": {}}
            for sol_type, sol_path in self.current_account.sol_files.items():
                if os.path.exists(sol_path):
                    data["sol_files"][sol_type] = self.sol_handler.read_sol(sol_path)
            
            with open(path, 'w') as f:
                json.dump(data, f, indent=2, default=str)
            messagebox.showinfo("Exported", f"Saved to {path}")
    
    def _export_all(self):
        """Export all accounts"""
        path = filedialog.asksaveasfilename(
            defaultextension=".json",
            filetypes=[("JSON", "*.json")],
            initialfilename="all_accounts.json"
        )
        
        if not path:
            return
        
        data = {
            "exported": datetime.now().isoformat(),
            "total": len(self.account_manager.accounts),
            "accounts": []
        }
        
        for account in self.account_manager.get_all_accounts():
            acc_data = {"email": account.email, "sol_files": {}}
            for sol_type, sol_path in account.sol_files.items():
                if os.path.exists(sol_path):
                    acc_data["sol_files"][sol_type] = self.sol_handler.read_sol(sol_path)
            data["accounts"].append(acc_data)
        
        with open(path, 'w') as f:
            json.dump(data, f, indent=2, default=str)
        messagebox.showinfo("Exported", f"Exported {len(data['accounts'])} accounts")
    
    def _show_backup_stats(self):
        """Show backup statistics"""
        stats = self.backup_manager.get_stats()
        
        size_mb = stats["total_size"] / (1024 * 1024)
        
        messagebox.showinfo(
            "Backup Statistics",
            f"Accounts with backups: {stats['total_accounts']}\n"
            f"Total backups: {stats['total_backups']}\n"
            f"Total size: {size_mb:.2f} MB\n"
            f"Max per account: {stats['max_backups_per_account']}\n"
            f"Location: {stats['backup_root']}"
        )
    
    def _show_reference(self):
        """Show SOL reference"""
        win = tk.Toplevel(self.root)
        win.title("SOL File Reference")
        win.geometry("800x600")
        win.configure(bg=Theme.BG_DARK)
        
        text = ThemedText(win)
        text.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)
        
        content = """
═══════════════════════════════════════════════════════════════════
                    SOL FILE REFERENCE GUIDE
                 RoboEvony / Evony Age II Bot
═══════════════════════════════════════════════════════════════════

config.sol - Account Login & Settings
─────────────────────────────────────────
Location: RoboEvony > Settings
Fields:
  • username    - Email for Evony login
  • password    - Account password
  • server      - Server code (cc2, na1, etc.)
  • proxyPort   - Tor node port (9949-9999)
  • autoLogin   - Auto-login on start

goals.sol - Automation Scripts
─────────────────────────────────────────
Location: RoboEvony > Goals Window
Fields:
  • now         - Current active script
  • goals       - Saved goal scripts

newArmyTroopCfgs.sol - Army Presets
─────────────────────────────────────────
Troop Codes:
  wo=Workers, w=Warriors, s=Scouts, p=Pikemen
  sw=Swordsmen, a=Archers, c=Cavalry, cata=Cataphracts
  t=Transporters, r=Rams, b=Ballista, cp=Catapults

NODE MANAGEMENT
─────────────────────────────────────────
• 50 Tor nodes (Node 0-49)
• Port = 9999 - NodeNumber
• Max 10-12 accounts per node recommended
"""
        text.insert("1.0", content)
        text.config(state=tk.DISABLED)
    
    def _show_bot_launcher(self):
        """Show bot launcher dialog"""
        show_bot_launcher(self.root)
    
    def _show_about(self):
        """Show about dialog"""
        messagebox.showinfo(
            "About ETK SOL Manager Pro",
            "ETK SOL Manager Pro v2.0\n\n"
            "RoboEvony-themed SOL file management\n"
            "for 500+ Evony Age II accounts\n\n"
            "Features:\n"
            "• View/Edit SOL files\n"
            "• Automatic backups with timeline\n"
            "• Share configs across accounts\n"
            "• Tor node management\n"
            "• Bot launcher with Tor proxy\n"
            "• Account tagging & filtering\n"
            "• Dashboard statistics\n"
            "• Account data extraction & search"
        )
    
    def _create_log_panel(self):
        """Create the log panel at the bottom like RoboEvony"""
        try:
            from .log_panel import LogPanel, log_manager
            
            log_frame = tk.Frame(self.vpaned, bg=Theme.BG_DARK, height=200)
            self.vpaned.add(log_frame, weight=1)
            
            self.log_panel = LogPanel(log_frame)
            self.log_panel.pack(fill=tk.BOTH, expand=True)
            
            # Store reference to log manager for easy access
            self.log_manager = log_manager
            
            # Log startup message
            log_manager.system("ETK SOL Manager Pro v2.0 started")
            log_manager.info("Ready to manage accounts")
            
        except Exception as e:
            # Fallback if log panel fails
            log_frame = tk.Frame(self.vpaned, bg=Theme.BG_DARK, height=100)
            self.vpaned.add(log_frame, weight=1)
            
            tk.Label(
                log_frame, text=f"Log panel unavailable: {e}",
                bg=Theme.BG_DARK, fg=Theme.TEXT_SECONDARY
            ).pack(pady=10)
    
    def _log(self, message: str, level: str = "info", account: str = ""):
        """Log a message to the log panel"""
        if hasattr(self, 'log_manager'):
            if level == "success":
                self.log_manager.success(message, account)
            elif level == "warning":
                self.log_manager.warning(message, account)
            elif level == "error":
                self.log_manager.error(message, account)
            elif level == "system":
                self.log_manager.system(message)
            else:
                self.log_manager.info(message, account)
    
    def _create_account_data_tab(self):
        """Create the Account Data tab with sub-tabs for Cities, Troops, Heroes, Items"""
        try:
            from .tabs.account_data_tab import AccountDataTab
            
            # Create account data tab
            self.account_data_tab = AccountDataTab(self.notebook)
            self.notebook.add(self.account_data_tab, text="📊 Account Data")
            
        except ImportError as e:
            # Fallback if tabs module not available
            fallback = tk.Frame(self.notebook, bg=Theme.BG_DARK)
            self.notebook.add(fallback, text="📊 Account Data")
            
            tk.Label(
                fallback,
                text="Account Data tab coming soon...\n\nUse extraction scripts to gather:\n• Cities & Resources\n• Troops\n• Heroes (Ring/HH)\n• Items",
                bg=Theme.BG_DARK,
                fg=Theme.TEXT_PRIMARY,
                font=(Theme.FONT_FAMILY, 12),
                justify=tk.CENTER
            ).pack(expand=True)
    
    def _update_account_data_display(self, account: Account):
        """Update the account data tab when an account is selected"""
        if not hasattr(self, 'account_data_tab'):
            self._log("Account data tab not available", "warning")
            return
        
        if not account:
            self._log("No account provided to display", "warning")
            return
        
        try:
            # Use email prefix as player name if not set
            player_name = account.email.split('@')[0]
            if hasattr(account, 'data') and account.data:
                player_name = account.data.get('player_name', player_name)
            
            # Convert account to dict format for display
            account_dict = {
                'email': account.email,
                'player_name': player_name,
                'alliance': account.data.get('alliance', 'None') if hasattr(account, 'data') else 'None',
                'rank': account.data.get('rank', '-') if hasattr(account, 'data') else '-',
                'credentials': {
                    'server': account.server,
                    'server_ip': account.server_ip,
                    'server_alias': account.server_alias,
                    'proxy_port': account.proxy_port,
                    'proxy_host': '127.0.0.1'
                },
                'summary': account.data.get('summary', {}) if hasattr(account, 'data') else {},
                'cities': account.data.get('cities', []) if hasattr(account, 'data') else [],
                'status': 'valid' if account.password else 'unknown',
                'sol_paths': [str(account.sol_path)] if account.sol_path else []
            }
            
            # Ensure summary has all fields
            default_summary = {
                'total_gold': 0, 'total_food': 0, 'total_lumber': 0,
                'total_stone': 0, 'total_iron': 0, 'total_cities': 0,
                'total_troops': 0, 'total_heroes': 0, 'ring_heroes': 0,
                'hh_heroes': 0, 'prestige': 0, 'honor': 0, 'stars': 0
            }
            for key, val in default_summary.items():
                if key not in account_dict['summary']:
                    account_dict['summary'][key] = val
            
            # Wire up button handlers
            self.account_data_tab.on_resume = self._on_resume_account
            self.account_data_tab.on_refresh = self._on_refresh_account
            self.account_data_tab.on_logout = self._on_logout_account
            
            self.account_data_tab.set_account(account_dict)
            self._log(f"Account data updated: {player_name}", "success", player_name)
            
        except Exception as e:
            self._log(f"Error updating account data: {e}", "error")
            import traceback
            traceback.print_exc()
    
    def _show_scanner(self):
        """Show account scanner dialog"""
        from .scanner_dialog import show_scanner_dialog
        show_scanner_dialog(self.root)
    
    def _on_resume_account(self, email: str):
        """Handle Resume button - launch bot for this account"""
        if email:
            self._show_bot_launcher()
    
    def _on_refresh_account(self, email: str):
        """Handle Refresh button - reload account data"""
        if email and self.current_account:
            self._load_account(email)
            self._update_status(f"Refreshed account: {email}")
    
    def _on_logout_account(self, email: str):
        """Handle Logout button - placeholder for logout functionality"""
        if email:
            self._update_status(f"Logout requested for: {email}")
