"""
ETK SOL Manager - Bot Launcher Dialog
UI for launching RoboEvony bots through Tor proxy nodes
"""

import tkinter as tk
from tkinter import ttk, messagebox
from typing import Optional, List, Dict

from ..theme import RoboEvonyTheme as Theme
from ..bot_launcher import get_bot_launcher, get_tor_manager, BotInstance, AccountSOLData
from ..account_manager import get_account_manager
from ..config import TOTAL_TOR_NODES
from ..utils import node_to_port
from .widgets import (
    ThemedButton, ThemedListbox, NodeGrid, HeaderBar, StatusBar
)


class BotLauncherDialog:
    """Dialog for managing bot launches with Tor proxy integration"""
    
    def __init__(self, parent: tk.Tk):
        self.parent = parent
        self.bot_launcher = get_bot_launcher()
        self.tor_manager = get_tor_manager()
        self.account_manager = get_account_manager()
        
        self._create_dialog()
    
    def _create_dialog(self):
        """Create the bot launcher dialog"""
        self.win = tk.Toplevel(self.parent)
        self.win.title("Bot Launcher - Tor Proxy Integration")
        self.win.geometry("1100x750")
        self.win.configure(bg=Theme.BG_DARK)
        
        # Header
        header = tk.Frame(self.win, bg=Theme.BG_HEADER)
        header.pack(fill=tk.X)
        
        tk.Label(
            header,
            text="🚀 Bot Launcher",
            bg=Theme.BG_HEADER,
            fg=Theme.ACCENT_ORANGE,
            font=(Theme.FONT_FAMILY, 16, "bold")
        ).pack(side=tk.LEFT, padx=15, pady=10)
        
        # Status indicators
        self.status_frame = tk.Frame(header, bg=Theme.BG_HEADER)
        self.status_frame.pack(side=tk.RIGHT, padx=15)
        
        self._add_status_indicator("bot", "Bot", "✗" if not self.bot_launcher.bot_available else "✓")
        self._add_status_indicator("tor", "Tor", "✗" if not self.tor_manager.tor_available else "✓")
        self._add_status_indicator("running", "Running", "0")
        
        # Main content
        main = tk.Frame(self.win, bg=Theme.BG_DARK)
        main.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)
        
        # Left panel - Node grid and controls
        left = tk.Frame(main, bg=Theme.BG_DARK, width=500)
        left.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        left.pack_propagate(False)
        
        self._create_node_panel(left)
        
        # Right panel - Account selection
        right = tk.Frame(main, bg=Theme.BG_DARK, width=550)
        right.pack(side=tk.RIGHT, fill=tk.BOTH, expand=True, padx=(10, 0))
        right.pack_propagate(False)
        
        self._create_account_panel(right)
        
        # Bottom action bar
        self._create_action_bar()
        
        # Initial update
        self._update_display()
    
    def _add_status_indicator(self, key: str, label: str, value: str):
        """Add a status indicator to the header"""
        frame = tk.Frame(self.status_frame, bg=Theme.BG_HEADER)
        frame.pack(side=tk.LEFT, padx=15)
        
        tk.Label(
            frame,
            text=f"{label}:",
            bg=Theme.BG_HEADER,
            fg=Theme.TEXT_SECONDARY,
            font=(Theme.FONT_FAMILY, 10)
        ).pack(side=tk.LEFT)
        
        color = Theme.STATUS_POSITIVE if value == "✓" else Theme.TEXT_SECONDARY
        lbl = tk.Label(
            frame,
            text=value,
            bg=Theme.BG_HEADER,
            fg=color,
            font=(Theme.FONT_FAMILY, 12, "bold")
        )
        lbl.pack(side=tk.LEFT, padx=5)
        
        setattr(self, f"status_{key}", lbl)
    
    def _create_node_panel(self, parent):
        """Create the node grid panel"""
        # Title
        tk.Label(
            parent,
            text="Tor Node Grid (50 nodes × 10 accounts = 500 capacity)",
            bg=Theme.BG_DARK,
            fg=Theme.ACCENT_ORANGE,
            font=(Theme.FONT_FAMILY, 12, "bold")
        ).pack(pady=(0, 10))
        
        # Node grid
        grid_frame = tk.LabelFrame(
            parent,
            text="Node Status",
            bg=Theme.BG_DARK,
            fg=Theme.ACCENT_ORANGE
        )
        grid_frame.pack(fill=tk.BOTH, expand=True)
        
        self.node_grid = NodeGrid(
            grid_frame,
            nodes=50,
            on_click=self._on_node_click
        )
        self.node_grid.pack(padx=10, pady=10)
        
        # Legend
        legend = tk.Frame(parent, bg=Theme.BG_DARK)
        legend.pack(fill=tk.X, pady=5)
        
        legends = [
            ("Empty (0)", Theme.BG_PANEL),
            ("Normal (1-8)", Theme.STATUS_POSITIVE),
            ("High (9-10)", Theme.STATUS_WARNING),
            ("Overloaded (>10)", Theme.STATUS_NEGATIVE)
        ]
        
        for text, color in legends:
            tk.Label(
                legend,
                text=f"■ {text}",
                bg=Theme.BG_DARK,
                fg=color,
                font=(Theme.FONT_FAMILY, 9)
            ).pack(side=tk.LEFT, padx=10)
        
        # Node controls
        ctrl_frame = tk.LabelFrame(
            parent,
            text="Tor Control",
            bg=Theme.BG_DARK,
            fg=Theme.ACCENT_ORANGE
        )
        ctrl_frame.pack(fill=tk.X, pady=10)
        
        btn_frame = tk.Frame(ctrl_frame, bg=Theme.BG_DARK)
        btn_frame.pack(pady=10)
        
        ThemedButton(
            btn_frame,
            text="▶ Start All Tor Nodes",
            command=self._start_all_tor
        ).pack(side=tk.LEFT, padx=5)
        
        ThemedButton(
            btn_frame,
            text="⏹ Stop All Tor Nodes",
            command=self._stop_all_tor
        ).pack(side=tk.LEFT, padx=5)
        
        self.tor_status_label = tk.Label(
            ctrl_frame,
            text="Tor nodes: 0/50 running",
            bg=Theme.BG_DARK,
            fg=Theme.TEXT_SECONDARY,
            font=(Theme.FONT_FAMILY, 10)
        )
        self.tor_status_label.pack(pady=5)
    
    def _create_account_panel(self, parent):
        """Create the account selection panel"""
        # Title
        tk.Label(
            parent,
            text="Account Selection",
            bg=Theme.BG_DARK,
            fg=Theme.ACCENT_ORANGE,
            font=(Theme.FONT_FAMILY, 12, "bold")
        ).pack(pady=(0, 10))
        
        # Filter
        filter_frame = tk.Frame(parent, bg=Theme.BG_DARK)
        filter_frame.pack(fill=tk.X, pady=5)
        
        tk.Label(
            filter_frame,
            text="Filter by Node:",
            bg=Theme.BG_DARK,
            fg=Theme.TEXT_PRIMARY
        ).pack(side=tk.LEFT)
        
        self.node_filter = ttk.Combobox(
            filter_frame,
            values=["All Nodes"] + [f"Node {i}" for i in range(50)],
            state="readonly",
            width=15
        )
        self.node_filter.set("All Nodes")
        self.node_filter.pack(side=tk.LEFT, padx=10)
        self.node_filter.bind("<<ComboboxSelected>>", self._filter_accounts)
        
        self.show_running_var = tk.BooleanVar(value=False)
        ttk.Checkbutton(
            filter_frame,
            text="Show Running Only",
            variable=self.show_running_var,
            command=self._filter_accounts
        ).pack(side=tk.LEFT, padx=10)
        
        # Account list
        list_frame = tk.LabelFrame(
            parent,
            text="Accounts (0)",
            bg=Theme.BG_DARK,
            fg=Theme.ACCENT_ORANGE
        )
        list_frame.pack(fill=tk.BOTH, expand=True, pady=5)
        self.account_list_frame = list_frame
        
        list_inner = tk.Frame(list_frame, bg=Theme.BG_DARK)
        list_inner.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        self.account_listbox = ThemedListbox(list_inner, selectmode=tk.MULTIPLE)
        self.account_listbox.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        
        scrollbar = ttk.Scrollbar(list_inner, orient=tk.VERTICAL,
                                  command=self.account_listbox.yview)
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y)
        self.account_listbox.config(yscrollcommand=scrollbar.set)
        
        # Selection buttons
        sel_frame = tk.Frame(parent, bg=Theme.BG_DARK)
        sel_frame.pack(fill=tk.X, pady=5)
        
        ThemedButton(sel_frame, text="Select All", command=self._select_all).pack(side=tk.LEFT, padx=5)
        ThemedButton(sel_frame, text="Select None", command=self._select_none).pack(side=tk.LEFT, padx=5)
        ThemedButton(sel_frame, text="Select Node...", command=self._select_by_node).pack(side=tk.LEFT, padx=5)
        
        # Launch controls
        launch_frame = tk.LabelFrame(
            parent,
            text="Launch Options",
            bg=Theme.BG_DARK,
            fg=Theme.ACCENT_ORANGE
        )
        launch_frame.pack(fill=tk.X, pady=5)
        
        opts = tk.Frame(launch_frame, bg=Theme.BG_DARK)
        opts.pack(pady=10)
        
        tk.Label(opts, text="Delay between launches:", bg=Theme.BG_DARK, fg=Theme.TEXT_PRIMARY).pack(side=tk.LEFT)
        self.delay_var = tk.StringVar(value="1.0")
        delay_entry = ttk.Entry(opts, textvariable=self.delay_var, width=5)
        delay_entry.pack(side=tk.LEFT, padx=5)
        tk.Label(opts, text="seconds", bg=Theme.BG_DARK, fg=Theme.TEXT_SECONDARY).pack(side=tk.LEFT)
    
    def _create_action_bar(self):
        """Create bottom action bar with node-based launching"""
        action_frame = tk.Frame(self.win, bg=Theme.BG_PANEL)
        action_frame.pack(fill=tk.X, side=tk.BOTTOM)
        
        # Node launch row
        node_frame = tk.Frame(action_frame, bg=Theme.BG_PANEL)
        node_frame.pack(pady=(10, 5))
        
        tk.Label(
            node_frame,
            text="Node:",
            bg=Theme.BG_PANEL,
            fg=Theme.TEXT_PRIMARY
        ).pack(side=tk.LEFT, padx=5)
        
        self.node_select = ttk.Combobox(
            node_frame,
            values=[f"Node {i}" for i in range(TOTAL_TOR_NODES)],
            state="readonly",
            width=10
        )
        self.node_select.set("Node 0")
        self.node_select.pack(side=tk.LEFT, padx=5)
        
        ThemedButton(
            node_frame,
            text="🚀 Launch Single Node",
            command=self._launch_single_node,
            accent=True
        ).pack(side=tk.LEFT, padx=5)
        
        ThemedButton(
            node_frame,
            text="⏹ Stop Node",
            command=self._stop_single_node
        ).pack(side=tk.LEFT, padx=5)
        
        # Account launch row
        btn_frame = tk.Frame(action_frame, bg=Theme.BG_PANEL)
        btn_frame.pack(pady=(5, 10))
        
        ThemedButton(
            btn_frame,
            text="🚀 Launch Selected Accounts",
            command=self._launch_selected
        ).pack(side=tk.LEFT, padx=5)
        
        ThemedButton(
            btn_frame,
            text="⏹ Stop Selected",
            command=self._stop_selected
        ).pack(side=tk.LEFT, padx=5)
        
        ThemedButton(
            btn_frame,
            text="🔄 Stop All Bots",
            command=self._stop_all_bots
        ).pack(side=tk.LEFT, padx=5)
        
        ThemedButton(
            btn_frame,
            text="📊 Refresh",
            command=self._update_display
        ).pack(side=tk.LEFT, padx=5)
        
        ThemedButton(
            btn_frame,
            text="Close",
            command=self.win.destroy
        ).pack(side=tk.LEFT, padx=5)
    
    def _update_display(self):
        """Update all display elements"""
        # Update node grid
        stats = self.bot_launcher.get_stats()
        self.node_grid.update_all(stats["node_loads"])
        
        # Update status indicators
        self.status_running.config(text=str(stats["total_running"]))
        
        # Update Tor status
        tor_running = self.tor_manager.get_running_count()
        self.tor_status_label.config(text=f"Tor nodes: {tor_running}/50 running")
        
        # Update account list
        self._populate_accounts()
    
    def _populate_accounts(self, filter_node: int = -1):
        """Populate account listbox"""
        self.account_listbox.delete(0, tk.END)
        
        accounts = self.account_manager.get_all_accounts()
        show_running = self.show_running_var.get()
        
        count = 0
        for account in sorted(accounts, key=lambda a: (a.node, a.email)):
            # Filter by node
            if filter_node >= 0 and account.node != filter_node:
                continue
            
            # Filter by running status
            is_running = account.email in self.bot_launcher.running_bots
            if show_running and not is_running:
                continue
            
            # Build display string
            status = "▶" if is_running else "○"
            node_str = f"N{account.node:02d}" if account.node >= 0 else "N--"
            display = f"{status} [{node_str}] {account.email}"
            
            self.account_listbox.insert(tk.END, display)
            count += 1
        
        self.account_list_frame.config(text=f"Accounts ({count})")
    
    def _filter_accounts(self, event=None):
        """Filter account list"""
        selection = self.node_filter.get()
        if selection == "All Nodes":
            self._populate_accounts(-1)
        else:
            node = int(selection.replace("Node ", ""))
            self._populate_accounts(node)
    
    def _on_node_click(self, node: int):
        """Handle node grid click"""
        self.node_filter.set(f"Node {node}")
        self._filter_accounts()
    
    def _select_all(self):
        self.account_listbox.select_set(0, tk.END)
    
    def _select_none(self):
        self.account_listbox.selection_clear(0, tk.END)
    
    def _select_by_node(self):
        """Select all accounts on a specific node"""
        node = tk.simpledialog.askinteger("Select Node", "Enter node number (0-49):",
                                          minvalue=0, maxvalue=49)
        if node is not None:
            self.account_listbox.selection_clear(0, tk.END)
            for i in range(self.account_listbox.size()):
                item = self.account_listbox.get(i)
                if f"[N{node:02d}]" in item:
                    self.account_listbox.select_set(i)
    
    def _get_selected_emails(self) -> List[str]:
        """Get list of selected account emails"""
        emails = []
        for i in self.account_listbox.curselection():
            item = self.account_listbox.get(i)
            # Extract email from display format
            email = item.split("] ", 1)[1] if "] " in item else item
            emails.append(email)
        return emails
    
    def _get_account_sol_data(self, email: str, node: int) -> Optional[AccountSOLData]:
        """Convert account to AccountSOLData with SOL config"""
        account = self.account_manager.get_account(email)
        if not account:
            return None
        
        # Get proxy port for node
        proxy_port = node_to_port(node)
        
        return AccountSOLData(
            email=account.email,
            password=account.password or "",
            server=account.server or "cc2",
            server_ip=account.server_ip or "",
            proxy_host="127.0.0.1",
            proxy_port=proxy_port,
            proxy_type="ss4",  # SOCKS4
            auto_login=True,
            node=node,
            sol_folder=account.folder or ""
        )
    
    def _launch_single_node(self):
        """Launch all accounts on a single selected node"""
        node_str = self.node_select.get()
        node = int(node_str.replace("Node ", ""))
        
        if not self.bot_launcher.bot_available:
            messagebox.showerror("Bot Not Found", 
                f"Bot executable not found at:\n{self.bot_launcher.bot_exe_path}")
            return
        
        # Get accounts assigned to this node
        accounts = self.account_manager.get_all_accounts()
        node_accounts = [acc for acc in accounts if acc.node == node]
        
        if not node_accounts:
            messagebox.showwarning("No Accounts", f"No accounts assigned to Node {node}")
            return
        
        if len(node_accounts) > 10:
            messagebox.showwarning("Too Many Accounts", 
                f"Node {node} has {len(node_accounts)} accounts (max 10)")
            return
        
        try:
            delay = float(self.delay_var.get())
        except ValueError:
            delay = 1.0
        
        if not messagebox.askyesno("Launch Node", 
            f"Launch all {len(node_accounts)} accounts on Node {node}?\n\n"
            f"Proxy: SOCKS4 @ 127.0.0.1:{node_to_port(node)}\n"
            f"Delay: {delay}s between launches"):
            return
        
        self.win.config(cursor="wait")
        self.win.update()
        
        # Prepare AccountSOLData for each account
        sol_accounts = []
        for acc in node_accounts:
            sol_data = self._get_account_sol_data(acc.email, node)
            if sol_data:
                sol_accounts.append(sol_data)
        
        # Launch the node
        results = self.bot_launcher.launch_node(node, sol_accounts, delay)
        
        self.win.config(cursor="")
        self._update_display()
        
        success = sum(1 for s, _ in results.values() if s)
        failed = len(results) - success
        
        if failed > 0:
            messagebox.showwarning("Node Launch Complete",
                f"Node {node}: Launched {success}, Failed {failed}")
        else:
            messagebox.showinfo("Node Launch Complete", 
                f"Node {node}: Launched {success} bots")
    
    def _stop_single_node(self):
        """Stop all bots on the selected node"""
        node_str = self.node_select.get()
        node = int(node_str.replace("Node ", ""))
        
        running = self.bot_launcher.get_accounts_on_node(node)
        if not running:
            messagebox.showinfo("No Bots Running", f"No bots running on Node {node}")
            return
        
        if not messagebox.askyesno("Stop Node", 
            f"Stop all {len(running)} bots on Node {node}?"):
            return
        
        count = self.bot_launcher.stop_node(node)
        self._update_display()
        messagebox.showinfo("Node Stopped", f"Stopped {count} bots on Node {node}")
    
    def _launch_selected(self):
        """Launch selected accounts"""
        emails = self._get_selected_emails()
        if not emails:
            messagebox.showwarning("No Selection", "Select accounts to launch")
            return
        
        if not self.bot_launcher.bot_available:
            messagebox.showerror("Bot Not Found", 
                f"Bot executable not found at:\n{self.bot_launcher.bot_exe_path}")
            return
        
        try:
            delay = float(self.delay_var.get())
        except ValueError:
            delay = 1.0
        
        if not messagebox.askyesno("Confirm Launch", 
            f"Launch {len(emails)} bot(s)?\n\n"
            f"Using AE.EXE from: {self.bot_launcher.bot_exe_path}\n"
            f"Delay: {delay}s between launches"):
            return
        
        self.win.config(cursor="wait")
        self.win.update()
        
        # Prepare AccountSOLData for each account
        sol_accounts = []
        for email in emails:
            account = self.account_manager.get_account(email)
            if account:
                node = account.node if account.node >= 0 else self.bot_launcher.get_best_node()
                sol_data = self._get_account_sol_data(email, node)
                if sol_data:
                    sol_accounts.append(sol_data)
        
        # Launch
        results = self.bot_launcher.launch_batch(sol_accounts, delay)
        
        self.win.config(cursor="")
        self._update_display()
        
        # Report
        success = sum(1 for s, _ in results.values() if s)
        failed = len(results) - success
        
        if failed > 0:
            messagebox.showwarning("Launch Complete",
                f"Launched: {success}\nFailed: {failed}")
        else:
            messagebox.showinfo("Launch Complete", f"Launched {success} bots")
    
    def _stop_selected(self):
        """Stop selected running bots"""
        emails = self._get_selected_emails()
        if not emails:
            messagebox.showwarning("No Selection", "Select accounts to stop")
            return
        
        stopped = 0
        for email in emails:
            if self.bot_launcher.stop_bot(email):
                stopped += 1
        
        self._update_display()
        messagebox.showinfo("Stopped", f"Stopped {stopped} bots")
    
    def _stop_all_bots(self):
        """Stop all running bots"""
        if not messagebox.askyesno("Confirm", "Stop ALL running bots?"):
            return
        
        count = self.bot_launcher.stop_all_bots()
        self._update_display()
        messagebox.showinfo("Stopped", f"Stopped {count} bots")
    
    def _start_all_tor(self):
        """Start all Tor nodes"""
        if not self.tor_manager.tor_available:
            messagebox.showerror("Tor Not Found",
                f"Tor executable not found at:\n{self.tor_manager.tor_exe}")
            return
        
        if not messagebox.askyesno("Start Tor", "Start all 50 Tor nodes?"):
            return
        
        self.win.config(cursor="wait")
        self.win.update()
        
        results = self.tor_manager.start_all_nodes(0.1)
        success = sum(results.values())
        
        self.win.config(cursor="")
        self._update_display()
        
        messagebox.showinfo("Tor Started", f"Started {success}/50 Tor nodes")
    
    def _stop_all_tor(self):
        """Stop all Tor nodes"""
        if not messagebox.askyesno("Stop Tor", "Stop all Tor nodes?"):
            return
        
        count = self.tor_manager.stop_all_nodes()
        self._update_display()
        messagebox.showinfo("Tor Stopped", f"Stopped {count} Tor nodes")


def show_bot_launcher(parent: tk.Tk):
    """Show the bot launcher dialog"""
    dialog = BotLauncherDialog(parent)
    return dialog
