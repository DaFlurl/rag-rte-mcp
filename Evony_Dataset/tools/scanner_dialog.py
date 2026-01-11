"""
ETK SOL Manager - Account Scanner Dialog
Real-time account scanning with progress display
"""

import tkinter as tk
from tkinter import ttk, messagebox
import threading
from typing import Optional, Dict, Any, List
from pathlib import Path

from ..theme import RoboEvonyTheme as Theme
from ..scanner.account_scanner import AccountScanner, ScanResult, ScanProgress, ScanStatus
from ..scanner.duplicate_finder import DuplicateFinder


class ScannerDialog:
    """
    Account Scanner Dialog with real-time progress display.
    
    Features:
    - Scan all accounts or selected accounts
    - Real-time progress bar and stats
    - Live account data display during scan
    - Pause/Resume/Stop controls
    - Export results
    """
    
    def __init__(self, parent: tk.Tk):
        self.parent = parent
        self.scanner = AccountScanner()
        self.dialog: Optional[tk.Toplevel] = None
        self._update_timer = None
    
    def show(self):
        """Show the scanner dialog"""
        if self.dialog and self.dialog.winfo_exists():
            self.dialog.lift()
            return
        
        self.dialog = tk.Toplevel(self.parent)
        self.dialog.title("Account Scanner - ETK SOL Manager")
        self.dialog.geometry("1000x700")
        self.dialog.configure(bg=Theme.BG_DARK)
        self.dialog.transient(self.parent)
        
        self._create_ui()
        self._load_accounts()
    
    def _create_ui(self):
        """Create the scanner UI"""
        # Main container
        main = tk.Frame(self.dialog, bg=Theme.BG_DARK)
        main.pack(fill="both", expand=True, padx=10, pady=10)
        main.columnconfigure(0, weight=1)
        main.rowconfigure(2, weight=1)
        
        # Header with summary
        self._create_header(main)
        
        # Control buttons
        self._create_controls(main)
        
        # Results display
        self._create_results_display(main)
        
        # Current account display
        self._create_current_account_panel(main)
        
        # Status bar
        self._create_status_bar(main)
    
    def _create_header(self, parent):
        """Create header with account summary"""
        header = tk.Frame(parent, bg=Theme.BG_HEADER)
        header.grid(row=0, column=0, sticky="ew", pady=(0, 10))
        
        # Title
        tk.Label(
            header, text="Account Scanner",
            bg=Theme.BG_HEADER, fg=Theme.ACCENT_ORANGE,
            font=('Segoe UI', 16, 'bold')
        ).pack(side="left", padx=10, pady=10)
        
        # Summary stats frame
        stats_frame = tk.Frame(header, bg=Theme.BG_HEADER)
        stats_frame.pack(side="right", padx=10)
        
        self.summary_labels = {}
        for text, key, color in [
            ("Total", "total", Theme.TEXT_PRIMARY),
            ("With Password", "with_pw", Theme.STATUS_POSITIVE),
            ("Duplicates", "duplicates", Theme.STATUS_WARNING),
            ("Scanned", "scanned", Theme.ACCENT_BLUE)
        ]:
            frame = tk.Frame(stats_frame, bg=Theme.BG_HEADER)
            frame.pack(side="left", padx=15)
            tk.Label(frame, text=text, bg=Theme.BG_HEADER, 
                    fg=Theme.TEXT_SECONDARY, font=('Segoe UI', 9)).pack()
            lbl = tk.Label(frame, text="0", bg=Theme.BG_HEADER, 
                          fg=color, font=('Segoe UI', 14, 'bold'))
            lbl.pack()
            self.summary_labels[key] = lbl
    
    def _create_controls(self, parent):
        """Create control buttons"""
        controls = tk.Frame(parent, bg=Theme.BG_DARK)
        controls.grid(row=1, column=0, sticky="ew", pady=5)
        
        # Left side - action buttons
        btn_frame = tk.Frame(controls, bg=Theme.BG_DARK)
        btn_frame.pack(side="left")
        
        self.start_btn = tk.Button(
            btn_frame, text="▶ Start Scan",
            bg="#3fb950", fg="white",
            font=('Segoe UI', 10, 'bold'),
            command=self._start_scan,
            width=12
        )
        self.start_btn.pack(side="left", padx=5)
        
        self.pause_btn = tk.Button(
            btn_frame, text="⏸ Pause",
            bg=Theme.STATUS_WARNING, fg="black",
            font=('Segoe UI', 10),
            command=self._pause_scan,
            width=10,
            state="disabled"
        )
        self.pause_btn.pack(side="left", padx=5)
        
        self.stop_btn = tk.Button(
            btn_frame, text="⏹ Stop",
            bg=Theme.STATUS_NEGATIVE, fg="white",
            font=('Segoe UI', 10),
            command=self._stop_scan,
            width=10,
            state="disabled"
        )
        self.stop_btn.pack(side="left", padx=5)
        
        # Right side - options
        opt_frame = tk.Frame(controls, bg=Theme.BG_DARK)
        opt_frame.pack(side="right")
        
        self.scan_mode_var = tk.StringVar(value="all")
        ttk.Radiobutton(opt_frame, text="Scan All", variable=self.scan_mode_var, 
                       value="all").pack(side="left", padx=5)
        ttk.Radiobutton(opt_frame, text="With Password Only", variable=self.scan_mode_var, 
                       value="password").pack(side="left", padx=5)
        
        tk.Button(
            opt_frame, text="Export Results",
            bg=Theme.BG_BUTTON, fg=Theme.TEXT_PRIMARY,
            command=self._export_results,
            width=12
        ).pack(side="left", padx=10)
        
        # Progress bar
        progress_frame = tk.Frame(parent, bg=Theme.BG_DARK)
        progress_frame.grid(row=1, column=0, sticky="ew", pady=(40, 5))
        
        self.progress_var = tk.DoubleVar(value=0)
        self.progress_bar = ttk.Progressbar(
            progress_frame, 
            variable=self.progress_var,
            maximum=100,
            length=400
        )
        self.progress_bar.pack(fill="x", padx=5)
        
        self.progress_label = tk.Label(
            progress_frame, text="Ready to scan",
            bg=Theme.BG_DARK, fg=Theme.TEXT_SECONDARY
        )
        self.progress_label.pack(pady=2)
    
    def _create_results_display(self, parent):
        """Create results treeview"""
        results_frame = tk.LabelFrame(
            parent, text="Scan Results",
            bg=Theme.BG_DARK, fg=Theme.ACCENT_ORANGE
        )
        results_frame.grid(row=2, column=0, sticky="nsew", pady=5)
        results_frame.columnconfigure(0, weight=1)
        results_frame.rowconfigure(0, weight=1)
        
        columns = ("email", "status", "player", "prestige", "gold", 
                   "cities", "troops", "alliance", "time")
        
        self.results_tree = ttk.Treeview(results_frame, columns=columns, show="headings")
        
        headers = [
            ("email", "Email", 200),
            ("status", "Status", 80),
            ("player", "Player Name", 100),
            ("prestige", "Prestige", 80),
            ("gold", "Gold", 80),
            ("cities", "Cities", 60),
            ("troops", "Troops", 80),
            ("alliance", "Alliance", 100),
            ("time", "Time", 60)
        ]
        
        for col, header, width in headers:
            self.results_tree.heading(col, text=header)
            self.results_tree.column(col, width=width, 
                                     anchor="center" if col not in ["email", "player", "alliance"] else "w")
        
        self.results_tree.grid(row=0, column=0, sticky="nsew", padx=5, pady=5)
        
        # Scrollbar
        vsb = ttk.Scrollbar(results_frame, orient="vertical", command=self.results_tree.yview)
        vsb.grid(row=0, column=1, sticky="ns")
        self.results_tree.configure(yscrollcommand=vsb.set)
        
        # Tag configuration
        self.results_tree.tag_configure('success', foreground=Theme.STATUS_POSITIVE)
        self.results_tree.tag_configure('failed', foreground=Theme.STATUS_NEGATIVE)
        self.results_tree.tag_configure('pending', foreground=Theme.TEXT_SECONDARY)
        self.results_tree.tag_configure('scanning', foreground=Theme.ACCENT_ORANGE)
    
    def _create_current_account_panel(self, parent):
        """Create panel showing current account being scanned"""
        current_frame = tk.LabelFrame(
            parent, text="Current Account",
            bg=Theme.BG_DARK, fg=Theme.ACCENT_ORANGE
        )
        current_frame.grid(row=3, column=0, sticky="ew", pady=5)
        
        # Current account info
        info_frame = tk.Frame(current_frame, bg=Theme.BG_DARK)
        info_frame.pack(fill="x", padx=10, pady=10)
        
        self.current_labels = {}
        for text, key in [("Email", "email"), ("Status", "status"), 
                          ("Player", "player"), ("Gold", "gold"),
                          ("Cities", "cities"), ("Troops", "troops")]:
            frame = tk.Frame(info_frame, bg=Theme.BG_DARK)
            frame.pack(side="left", padx=15)
            tk.Label(frame, text=text, bg=Theme.BG_DARK, 
                    fg=Theme.TEXT_SECONDARY, font=('Segoe UI', 9)).pack()
            lbl = tk.Label(frame, text="-", bg=Theme.BG_DARK, 
                          fg=Theme.ACCENT_ORANGE, font=('Segoe UI', 11, 'bold'))
            lbl.pack()
            self.current_labels[key] = lbl
    
    def _create_status_bar(self, parent):
        """Create status bar"""
        status_frame = tk.Frame(parent, bg=Theme.BG_PANEL)
        status_frame.grid(row=4, column=0, sticky="ew", pady=(5, 0))
        
        self.status_label = tk.Label(
            status_frame, text="Ready",
            bg=Theme.BG_PANEL, fg=Theme.TEXT_SECONDARY,
            font=('Segoe UI', 9)
        )
        self.status_label.pack(side="left", padx=10, pady=5)
        
        self.time_label = tk.Label(
            status_frame, text="Elapsed: 0:00",
            bg=Theme.BG_PANEL, fg=Theme.TEXT_SECONDARY,
            font=('Segoe UI', 9)
        )
        self.time_label.pack(side="right", padx=10, pady=5)
    
    def _load_accounts(self):
        """Load accounts and update summary"""
        self.status_label.config(text="Loading accounts...")
        self.dialog.update()
        
        # Load accounts in background
        def load():
            count = self.scanner.load_accounts()
            summary = self.scanner.duplicate_finder.get_summary()
            
            # Update UI from main thread
            self.dialog.after(0, lambda: self._update_summary(count, summary))
        
        threading.Thread(target=load, daemon=True).start()
    
    def _update_summary(self, count: int, summary: Dict):
        """Update summary labels"""
        self.summary_labels["total"].config(text=str(summary["total_unique_accounts"]))
        self.summary_labels["with_pw"].config(text=str(summary["accounts_with_passwords"]))
        self.summary_labels["duplicates"].config(text=str(summary["duplicate_accounts"]))
        self.summary_labels["scanned"].config(text="0")
        
        self.status_label.config(text=f"Loaded {count} accounts ready to scan")
    
    def _start_scan(self):
        """Start the scan"""
        self.start_btn.config(state="disabled")
        self.pause_btn.config(state="normal")
        self.stop_btn.config(state="normal")
        
        # Clear previous results
        for item in self.results_tree.get_children():
            self.results_tree.delete(item)
        
        # Setup callbacks
        self.scanner.on_progress = self._on_progress
        self.scanner.on_account_scanned = self._on_account_scanned
        self.scanner.on_complete = self._on_complete
        
        # Start scan
        self.scanner.start_scan(use_roboevony=True)
        
        # Start UI update timer
        self._start_update_timer()
    
    def _pause_scan(self):
        """Pause/Resume the scan"""
        if self.scanner.progress.is_paused:
            self.scanner.resume_scan()
            self.pause_btn.config(text="⏸ Pause")
        else:
            self.scanner.pause_scan()
            self.pause_btn.config(text="▶ Resume")
    
    def _stop_scan(self):
        """Stop the scan"""
        self.scanner.stop_scan()
        self._stop_update_timer()
        
        self.start_btn.config(state="normal")
        self.pause_btn.config(state="disabled")
        self.stop_btn.config(state="disabled")
        
        self.status_label.config(text="Scan stopped")
    
    def _start_update_timer(self):
        """Start periodic UI update"""
        def update():
            if self.scanner.progress.is_running:
                self._update_ui()
                self._update_timer = self.dialog.after(100, update)
        
        update()
    
    def _stop_update_timer(self):
        """Stop UI update timer"""
        if self._update_timer:
            self.dialog.after_cancel(self._update_timer)
            self._update_timer = None
    
    def _update_ui(self):
        """Update UI with current progress"""
        progress = self.scanner.progress
        
        # Progress bar
        self.progress_var.set(progress.percent_complete)
        self.progress_label.config(
            text=f"Scanning {progress.scanned}/{progress.total_accounts} "
                 f"({progress.percent_complete:.1f}%)"
        )
        
        # Summary
        self.summary_labels["scanned"].config(text=str(progress.scanned))
        
        # Time
        elapsed = int(progress.elapsed_time)
        minutes, seconds = divmod(elapsed, 60)
        self.time_label.config(text=f"Elapsed: {minutes}:{seconds:02d}")
        
        # Current account
        if progress.current_account:
            self.current_labels["email"].config(text=progress.current_account[:30])
            self.current_labels["status"].config(text=progress.current_status)
    
    def _on_progress(self, progress: ScanProgress):
        """Called when progress updates"""
        pass  # Handled by timer
    
    def _on_account_scanned(self, result: ScanResult):
        """Called when an account is scanned"""
        # Add to treeview from main thread
        self.dialog.after(0, lambda: self._add_result_to_tree(result))
    
    def _add_result_to_tree(self, result: ScanResult):
        """Add scan result to treeview"""
        status_text = result.status.value.title()
        
        tag = 'pending'
        if result.status == ScanStatus.COMPLETED:
            tag = 'success'
        elif result.status == ScanStatus.FAILED:
            tag = 'failed'
        elif result.status == ScanStatus.SCANNING:
            tag = 'scanning'
        
        values = (
            result.email[:40],
            status_text,
            result.player_name or "-",
            f"{result.prestige:,}" if result.prestige else "-",
            f"{result.gold:,}" if result.gold else "-",
            result.cities_count or "-",
            f"{result.troops_count:,}" if result.troops_count else "-",
            result.alliance or "-",
            f"{result.scan_duration:.1f}s"
        )
        
        self.results_tree.insert("", 0, values=values, tags=(tag,))
        
        # Update current account panel
        self.current_labels["email"].config(text=result.email[:30])
        self.current_labels["status"].config(text=status_text)
        self.current_labels["player"].config(text=result.player_name or "-")
        self.current_labels["gold"].config(text=f"{result.gold:,}" if result.gold else "-")
        self.current_labels["cities"].config(text=str(result.cities_count) if result.cities_count else "-")
        self.current_labels["troops"].config(text=f"{result.troops_count:,}" if result.troops_count else "-")
    
    def _on_complete(self, results: Dict[str, ScanResult]):
        """Called when scan completes"""
        self._stop_update_timer()
        
        self.start_btn.config(state="normal")
        self.pause_btn.config(state="disabled")
        self.stop_btn.config(state="disabled")
        
        summary = self.scanner.get_results_summary()
        self.status_label.config(
            text=f"Scan complete: {summary['successful']} successful, "
                 f"{summary['failed']} failed, {summary['scanned']} total"
        )
        
        messagebox.showinfo(
            "Scan Complete",
            f"Scanned {summary['scanned']} accounts\n\n"
            f"Successful: {summary['successful']}\n"
            f"Failed: {summary['failed']}\n"
            f"Time: {summary['elapsed_time']:.1f} seconds"
        )
    
    def _export_results(self):
        """Export scan results"""
        output_path = Path(r"D:\EvonyToolKit\data\scan_results.json")
        
        if self.scanner.export_results(output_path):
            messagebox.showinfo("Export Complete", f"Results exported to:\n{output_path}")
        else:
            messagebox.showerror("Export Failed", "Failed to export results")


def show_scanner_dialog(parent: tk.Tk):
    """Show the scanner dialog"""
    dialog = ScannerDialog(parent)
    dialog.show()
