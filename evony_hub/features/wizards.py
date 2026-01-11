#!/usr/bin/env python3
"""
Evony Hub - Setup and Configuration Wizards
Guided setup processes for various operations.
"""

import tkinter as tk
from tkinter import ttk, messagebox, filedialog
from pathlib import Path
from typing import Dict, List, Optional, Callable
from dataclasses import dataclass


@dataclass
class WizardStep:
    """A single step in a wizard."""
    title: str
    description: str
    widget_builder: Callable[[tk.Frame], tk.Widget]
    validator: Optional[Callable[[], bool]] = None
    data_key: Optional[str] = None


class WizardBase:
    """Base class for multi-step wizards."""
    
    def __init__(self, parent: tk.Tk, title: str):
        self.parent = parent
        self.window = tk.Toplevel(parent)
        self.window.title(title)
        self.window.geometry("600x450")
        self.window.transient(parent)
        self.window.grab_set()
        
        self.steps: List[WizardStep] = []
        self.current_step = 0
        self.data: Dict = {}
        self.completed = False
        
        self._setup_ui()
    
    def _setup_ui(self):
        """Setup wizard UI."""
        # Header
        self.header_frame = tk.Frame(self.window, bg='#1a1a2e', height=60)
        self.header_frame.pack(fill='x')
        self.header_frame.pack_propagate(False)
        
        self.title_label = tk.Label(
            self.header_frame, text="", 
            font=('Segoe UI', 14, 'bold'),
            fg='#00ff88', bg='#1a1a2e'
        )
        self.title_label.pack(pady=15)
        
        # Content area
        self.content_frame = tk.Frame(self.window, bg='#0f0f1a')
        self.content_frame.pack(fill='both', expand=True, padx=20, pady=10)
        
        # Description
        self.desc_label = tk.Label(
            self.content_frame, text="",
            font=('Segoe UI', 10),
            fg='#888', bg='#0f0f1a',
            wraplength=500, justify='left'
        )
        self.desc_label.pack(pady=10)
        
        # Step content
        self.step_frame = tk.Frame(self.content_frame, bg='#0f0f1a')
        self.step_frame.pack(fill='both', expand=True, pady=10)
        
        # Navigation buttons
        self.nav_frame = tk.Frame(self.window, bg='#0f0f1a')
        self.nav_frame.pack(fill='x', padx=20, pady=10)
        
        self.back_btn = tk.Button(
            self.nav_frame, text="← Back",
            command=self._prev_step,
            font=('Segoe UI', 10), bg='#333', fg='white',
            state='disabled'
        )
        self.back_btn.pack(side='left')
        
        self.next_btn = tk.Button(
            self.nav_frame, text="Next →",
            command=self._next_step,
            font=('Segoe UI', 10, 'bold'), bg='#00aa66', fg='white'
        )
        self.next_btn.pack(side='right')
        
        self.cancel_btn = tk.Button(
            self.nav_frame, text="Cancel",
            command=self._cancel,
            font=('Segoe UI', 10), bg='#aa3333', fg='white'
        )
        self.cancel_btn.pack(side='right', padx=10)
        
        # Progress indicator
        self.progress_label = tk.Label(
            self.nav_frame, text="Step 1 of 1",
            font=('Segoe UI', 9), fg='#666', bg='#0f0f1a'
        )
        self.progress_label.pack(side='left', padx=20)
    
    def add_step(self, step: WizardStep):
        """Add a step to the wizard."""
        self.steps.append(step)
    
    def start(self):
        """Start the wizard."""
        if self.steps:
            self._show_step(0)
    
    def _show_step(self, index: int):
        """Display a specific step."""
        if 0 <= index < len(self.steps):
            self.current_step = index
            step = self.steps[index]
            
            # Update header
            self.title_label.config(text=step.title)
            self.desc_label.config(text=step.description)
            
            # Clear and rebuild content
            for widget in self.step_frame.winfo_children():
                widget.destroy()
            
            step.widget_builder(self.step_frame)
            
            # Update navigation
            self.back_btn.config(state='normal' if index > 0 else 'disabled')
            
            if index == len(self.steps) - 1:
                self.next_btn.config(text="Finish ✓")
            else:
                self.next_btn.config(text="Next →")
            
            self.progress_label.config(text=f"Step {index + 1} of {len(self.steps)}")
    
    def _next_step(self):
        """Go to next step or finish."""
        step = self.steps[self.current_step]
        
        # Validate current step
        if step.validator and not step.validator():
            return
        
        if self.current_step < len(self.steps) - 1:
            self._show_step(self.current_step + 1)
        else:
            self._finish()
    
    def _prev_step(self):
        """Go to previous step."""
        if self.current_step > 0:
            self._show_step(self.current_step - 1)
    
    def _finish(self):
        """Complete the wizard."""
        self.completed = True
        self.on_complete()
        self.window.destroy()
    
    def _cancel(self):
        """Cancel the wizard."""
        if messagebox.askyesno("Cancel", "Are you sure you want to cancel?"):
            self.window.destroy()
    
    def on_complete(self):
        """Called when wizard completes. Override in subclass."""
        pass


class SetupWizard(WizardBase):
    """Initial setup wizard for Evony Hub."""
    
    def __init__(self, parent: tk.Tk):
        super().__init__(parent, "Evony Hub Setup Wizard")
        self._build_steps()
        self.start()
    
    def _build_steps(self):
        """Build wizard steps."""
        # Step 1: Welcome
        self.add_step(WizardStep(
            title="Welcome to Evony Hub",
            description="This wizard will help you configure Evony Hub for first use. "
                       "We'll set up paths, scan for existing files, and configure preferences.",
            widget_builder=self._build_welcome
        ))
        
        # Step 2: Paths
        self.add_step(WizardStep(
            title="Configure Paths",
            description="Set the paths where Evony-related files are located.",
            widget_builder=self._build_paths,
            data_key='paths'
        ))
        
        # Step 3: Scan
        self.add_step(WizardStep(
            title="Scan for Files",
            description="Scan configured paths for Evony-related content.",
            widget_builder=self._build_scan
        ))
        
        # Step 4: Complete
        self.add_step(WizardStep(
            title="Setup Complete",
            description="Evony Hub is now configured and ready to use!",
            widget_builder=self._build_complete
        ))
    
    def _build_welcome(self, parent: tk.Frame):
        """Build welcome step."""
        tk.Label(
            parent, text="🚀",
            font=('Segoe UI', 48), fg='#00ff88', bg='#0f0f1a'
        ).pack(pady=20)
        
        tk.Label(
            parent, 
            text="Click 'Next' to begin setup",
            font=('Segoe UI', 12), fg='#aaa', bg='#0f0f1a'
        ).pack()
    
    def _build_paths(self, parent: tk.Frame):
        """Build paths configuration step."""
        tk.Label(
            parent, text="Hub Root Path:",
            font=('Segoe UI', 10), fg='#888', bg='#0f0f1a'
        ).pack(anchor='w')
        
        path_frame = tk.Frame(parent, bg='#0f0f1a')
        path_frame.pack(fill='x', pady=5)
        
        self.path_var = tk.StringVar(value=str(Path.home() / "Evony_Decrypted"))
        path_entry = tk.Entry(path_frame, textvariable=self.path_var, width=50)
        path_entry.pack(side='left', padx=(0, 10))
        
        tk.Button(
            path_frame, text="Browse...",
            command=lambda: self._browse_path(self.path_var)
        ).pack(side='left')
    
    def _browse_path(self, var: tk.StringVar):
        """Browse for directory."""
        path = filedialog.askdirectory()
        if path:
            var.set(path)
    
    def _build_scan(self, parent: tk.Frame):
        """Build scan step."""
        tk.Label(
            parent, text="Ready to scan for Evony files.",
            font=('Segoe UI', 11), fg='#aaa', bg='#0f0f1a'
        ).pack(pady=20)
        
        self.scan_progress = ttk.Progressbar(parent, mode='indeterminate')
        self.scan_progress.pack(fill='x', pady=10)
    
    def _build_complete(self, parent: tk.Frame):
        """Build completion step."""
        tk.Label(
            parent, text="✓",
            font=('Segoe UI', 48), fg='#00ff88', bg='#0f0f1a'
        ).pack(pady=20)
        
        tk.Label(
            parent,
            text="Setup complete! You can now use Evony Hub.",
            font=('Segoe UI', 12), fg='#aaa', bg='#0f0f1a'
        ).pack()
    
    def on_complete(self):
        """Save configuration on completion."""
        self.data['hub_root'] = self.path_var.get() if hasattr(self, 'path_var') else None


class ExploitWizard(WizardBase):
    """Wizard for configuring and running exploits."""
    
    def __init__(self, parent: tk.Tk):
        super().__init__(parent, "Exploit Configuration Wizard")
        self.selected_exploit = None
        self._build_steps()
        self.start()
    
    def _build_steps(self):
        """Build exploit wizard steps."""
        self.add_step(WizardStep(
            title="Select Exploit",
            description="Choose an exploit to configure.",
            widget_builder=self._build_select
        ))
        
        self.add_step(WizardStep(
            title="Configure Parameters",
            description="Set exploit parameters.",
            widget_builder=self._build_params
        ))
        
        self.add_step(WizardStep(
            title="Generate Script",
            description="Generate the exploit script.",
            widget_builder=self._build_generate
        ))
    
    def _build_select(self, parent: tk.Frame):
        """Build exploit selection."""
        exploits = [
            ("Troop Overflow", "Integer overflow in troop production"),
            ("Race Condition", "Rapid item use race condition"),
            ("Valley Hide", "Hide troops in valleys"),
            ("Gold Farm", "Automated tax collection"),
        ]
        
        self.exploit_var = tk.StringVar(value=exploits[0][0])
        
        for name, desc in exploits:
            rb = tk.Radiobutton(
                parent, text=f"{name} - {desc}",
                variable=self.exploit_var, value=name,
                font=('Segoe UI', 10), fg='#ccc', bg='#0f0f1a',
                selectcolor='#1a1a2e', activebackground='#0f0f1a'
            )
            rb.pack(anchor='w', pady=5)
    
    def _build_params(self, parent: tk.Frame):
        """Build parameter configuration."""
        tk.Label(
            parent, text=f"Configure: {self.exploit_var.get()}",
            font=('Segoe UI', 11, 'bold'), fg='#00ff88', bg='#0f0f1a'
        ).pack(anchor='w', pady=10)
        
        # Add parameter inputs based on selected exploit
        tk.Label(parent, text="Parameters will appear here",
                font=('Segoe UI', 10), fg='#666', bg='#0f0f1a').pack()
    
    def _build_generate(self, parent: tk.Frame):
        """Build script generation."""
        tk.Label(
            parent, text="Script generated successfully!",
            font=('Segoe UI', 11), fg='#00ff88', bg='#0f0f1a'
        ).pack(pady=20)


__all__ = ['WizardStep', 'WizardBase', 'SetupWizard', 'ExploitWizard']
