#!/usr/bin/env python3
"""
Borg Display - Svony Studio Borg Training Visualization
Dynamic ASCII art, animations, and live dashboard for training

Features:
- Multiple ASCII art designs that transition during training
- Color gradients that change with progress
- Live dashboard with Rich library
- Stage-specific animations
- Sparkline graphs for metrics
"""

import time
import random
from datetime import datetime
from typing import Optional, List, Dict, Any
from dataclasses import dataclass, field

try:
    from rich.console import Console
    from rich.live import Live
    from rich.table import Table
    from rich.panel import Panel
    from rich.progress import Progress, SpinnerColumn, BarColumn, TextColumn, TaskID
    from rich.layout import Layout
    from rich.text import Text
    from rich.align import Align
    from rich.columns import Columns
    from rich import box
    RICH_AVAILABLE = True
except ImportError:
    RICH_AVAILABLE = False
    print("Rich not installed. Run: pip install rich")

from borg_theme import COLORS, get_progress_color, get_phase_color, get_loss_color

# =============================================================================
# ASCII ART COLLECTIONS - Multiple designs that rotate during training
# =============================================================================

BANNERS = {
    "svony_main": """
[green4]███████╗██╗   ██╗ ██████╗ ███╗   ██╗██╗   ██╗[/]
[green4]██╔════╝██║   ██║██╔═══██╗████╗  ██║╚██╗ ██╔╝[/]
[dark_cyan]███████╗██║   ██║██║   ██║██╔██╗ ██║ ╚████╔╝[/]
[dark_blue]╚════██║╚██╗ ██╔╝██║   ██║██║╚██╗██║  ╚██╔╝[/]
[dark_magenta]███████║ ╚████╔╝ ╚██████╔╝██║ ╚████║   ██║[/]
[dark_magenta]╚══════╝  ╚═══╝   ╚═════╝ ╚═╝  ╚═══╝   ╚═╝[/]
[green3]        ╔═╗╔╦╗╦ ╦╔╦╗╦╔═╗  ╔╗ ╔═╗╦═╗╔═╗[/]
[green3]        ╚═╗ ║ ║ ║ ║║║║ ║  ╠╩╗║ ║╠╦╝║ ╦[/]
[green4]        ╚═╝ ╩ ╚═╝═╩╝╩╚═╝  ╚═╝╚═╝╩╚═╚═╝[/]
""",
    
    "borg_cube": """
[green4]    ╔═══════════════════════════════╗[/]
[green4]    ║[dark_cyan] ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ [/]║[/]
[green4]    ║[dark_cyan] ▓[/][dark_blue] ████████████████████████ [/][dark_cyan]▓ [/]║[/]
[green4]    ║[dark_cyan] ▓[/][dark_blue] ██[/][green3]  BORG COLLECTIVE  [/][dark_blue]██ [/][dark_cyan]▓ [/]║[/]
[green4]    ║[dark_cyan] ▓[/][dark_blue] ██[/][green3]   NEURAL LINK    [/][dark_blue]██ [/][dark_cyan]▓ [/]║[/]
[green4]    ║[dark_cyan] ▓[/][dark_blue] ████████████████████████ [/][dark_cyan]▓ [/]║[/]
[green4]    ║[dark_cyan] ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ [/]║[/]
[green4]    ╚═══════════════════════════════╝[/]
""",

    "neural_net": """
[dark_cyan]    ●━━━━●━━━━●━━━━●━━━━●[/]
[dark_cyan]    │    │    │    │    │[/]
[green4]    ●━━━━●━━━━●━━━━●━━━━●[/]
[green4]    │    │    │    │    │[/]
[dark_blue]    ●━━━━●━━━━●━━━━●━━━━●[/]
[dark_blue]    │    │    │    │    │[/]
[dark_magenta]    ●━━━━●━━━━●━━━━●━━━━●[/]
""",

    "matrix": """
[green4]    ╭──────────────────────────────╮[/]
[green4]    │[dark_cyan] 01001000 01100101 01101100 [/]│[/]
[green4]    │[green3] 01101100 01101111 00100000 [/]│[/]
[green4]    │[dark_blue] 01000010 01101111 01110010 [/]│[/]
[green4]    │[dark_magenta] 01100111 00100001 00100001 [/]│[/]
[green4]    ╰──────────────────────────────╯[/]
""",

    "hexagon": """
[green4]         ╱╲     ╱╲     ╱╲[/]
[green4]        ╱  ╲   ╱  ╲   ╱  ╲[/]
[dark_cyan]       ╱    ╲ ╱    ╲ ╱    ╲[/]
[dark_cyan]       ╲    ╱ ╲    ╱ ╲    ╱[/]
[dark_blue]        ╲  ╱   ╲  ╱   ╲  ╱[/]
[dark_blue]         ╲╱     ╲╱     ╲╱[/]
""",
}

# Training stage ASCII - cycles through these
TRAINING_FRAMES = [
    # Frame 1 - Neural pulse
    """
[{color}]◢████████████████████████████████◣[/]
[{color}]█[/][dark_cyan]  ══════════════════════════  [/][{color}]█[/]
[{color}]█[/]  [bold {color}]NEURAL LINK ACTIVE[/]           [{color}]█[/]
[{color}]█[/]  ════════════════════════════  [{color}]█[/]
[{color}]█[/]  STEP: [bold]{step:>6}[/] / {total:<6}        [{color}]█[/]
[{color}]█[/]  LOSS: [bold {loss_color}]{loss:>8.4f}[/]              [{color}]█[/]
[{color}]█[/]  SPEED: [bold]{speed:>6.2f}[/] steps/sec      [{color}]█[/]
[{color}]◥████████████████████████████████◤[/]
""",
    # Frame 2 - Data stream
    """
[{color}]┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓[/]
[{color}]┃[/][dark_blue]  ▶▶▶ DATA STREAM ACTIVE ◀◀◀  [/][{color}]┃[/]
[{color}]┃[/]  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━  [{color}]┃[/]
[{color}]┃[/]  ITERATION [bold]{step:>6}[/] / {total:<6}    [{color}]┃[/]
[{color}]┃[/]  ENTROPY   [bold {loss_color}]{loss:>8.4f}[/]          [{color}]┃[/]
[{color}]┃[/]  THROUGHPUT [bold]{speed:>6.2f}[/] s/s        [{color}]┃[/]
[{color}]┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛[/]
""",
    # Frame 3 - Assimilation
    """
[{color}]╔══════════════════════════════════╗[/]
[{color}]║[/][dark_magenta]   ◉ ASSIMILATION IN PROGRESS ◉  [/][{color}]║[/]
[{color}]║[/]  ══════════════════════════════  [{color}]║[/]
[{color}]║[/]  PATTERNS: [bold]{step:>6}[/] / {total:<6}    [{color}]║[/]
[{color}]║[/]  DEVIATION: [bold {loss_color}]{loss:>8.4f}[/]          [{color}]║[/]
[{color}]║[/]  RATE: [bold]{speed:>6.2f}[/] patterns/sec    [{color}]║[/]
[{color}]╚══════════════════════════════════╝[/]
""",
    # Frame 4 - Quantum state
    """
[{color}]╭──────────────────────────────────╮[/]
[{color}]│[/][dark_cyan]   ψ QUANTUM STATE EVOLVING ψ   [/][{color}]│[/]
[{color}]│[/]  ──────────────────────────────  [{color}]│[/]
[{color}]│[/]  EPOCH [bold]{step:>6}[/] / {total:<6}        [{color}]│[/]
[{color}]│[/]  Δ LOSS [bold {loss_color}]{loss:>8.4f}[/]              [{color}]│[/]
[{color}]│[/]  λ RATE [bold]{speed:>6.2f}[/] q/sec          [{color}]│[/]
[{color}]╰──────────────────────────────────╯[/]
""",
    # Frame 5 - Hive mind
    """
[{color}]▛▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▜[/]
[{color}]▌[/][green3]    ◈ HIVE MIND PROCESSING ◈   [/][{color}]▐[/]
[{color}]▌[/]  ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔  [{color}]▐[/]
[{color}]▌[/]  CYCLES: [bold]{step:>6}[/] / {total:<6}      [{color}]▐[/]
[{color}]▌[/]  VARIANCE: [bold {loss_color}]{loss:>8.4f}[/]           [{color}]▐[/]
[{color}]▌[/]  FREQ: [bold]{speed:>6.2f}[/] cycles/sec      [{color}]▐[/]
[{color}]▙▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▟[/]
""",
]

# Completion ASCII art - multiple victory screens
COMPLETION_ARTS = [
    """
[green3]╔════════════════════════════════════════════════╗[/]
[green3]║[/]  [bold green3]█████╗ ███████╗███████╗██╗███╗   ███╗[/]  [green3]║[/]
[green3]║[/]  [bold green3]██╔══██╗██╔════╝██╔════╝██║████╗ ████║[/]  [green3]║[/]
[green3]║[/]  [bold dark_cyan]███████║███████╗███████╗██║██╔████╔██║[/]  [green3]║[/]
[green3]║[/]  [bold dark_blue]██╔══██║╚════██║╚════██║██║██║╚██╔╝██║[/]  [green3]║[/]
[green3]║[/]  [bold dark_magenta]██║  ██║███████║███████║██║██║ ╚═╝ ██║[/]  [green3]║[/]
[green3]║[/]  [bold dark_magenta]╚═╝  ╚═╝╚══════╝╚══════╝╚═╝╚═╝     ╚═╝[/]  [green3]║[/]
[green3]║[/]        [bold green4]◆ ASSIMILATION COMPLETE ◆[/]         [green3]║[/]
[green3]╚════════════════════════════════════════════════╝[/]
""",
    """
[green3]╭──────────────────────────────────────────────╮[/]
[green3]│[/]                                              [green3]│[/]
[green3]│[/]    [bold green4]██████╗  ██████╗ ███╗   ██╗███████╗[/]    [green3]│[/]
[green3]│[/]    [bold dark_cyan]██╔══██╗██╔═══██╗████╗  ██║██╔════╝[/]    [green3]│[/]
[green3]│[/]    [bold dark_cyan]██║  ██║██║   ██║██╔██╗ ██║█████╗[/]      [green3]│[/]
[green3]│[/]    [bold dark_blue]██║  ██║██║   ██║██║╚██╗██║██╔══╝[/]      [green3]│[/]
[green3]│[/]    [bold dark_magenta]██████╔╝╚██████╔╝██║ ╚████║███████╗[/]    [green3]│[/]
[green3]│[/]    [bold dark_magenta]╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚══════╝[/]    [green3]│[/]
[green3]│[/]                                              [green3]│[/]
[green3]│[/]         [bold green3]◈ TRAINING SUCCESSFUL ◈[/]           [green3]│[/]
[green3]╰──────────────────────────────────────────────╯[/]
""",
]

# Loading spinners
SPINNERS = {
    "borg": ["◢", "◣", "◤", "◥"],
    "dots": ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"],
    "pulse": ["●", "◉", "○", "◉"],
    "arrows": ["←", "↖", "↑", "↗", "→", "↘", "↓", "↙"],
    "blocks": ["▁", "▂", "▃", "▄", "▅", "▆", "▇", "█", "▇", "▆", "▅", "▄", "▃", "▂"],
}

# Sparkline characters for loss graph
SPARKLINE_CHARS = "▁▂▃▄▅▆▇█"


@dataclass
class TrainingMetrics:
    """Container for training metrics"""
    step: int = 0
    total_steps: int = 0
    loss: float = 0.0
    start_loss: float = 0.0
    speed: float = 0.0
    epoch: int = 0
    total_epochs: int = 0
    elapsed_minutes: float = 0.0
    estimated_cost: float = 0.0
    loss_history: List[float] = field(default_factory=list)
    gpu_util: float = 0.0
    gpu_memory: float = 0.0


class BorgDisplay:
    """Main display controller for Borg-themed training visualization"""
    
    def __init__(self):
        self.console = Console() if RICH_AVAILABLE else None
        self.metrics = TrainingMetrics()
        self.frame_idx = 0
        self.banner_idx = 0
        self.spinner_idx = 0
        self.phase = "init"
        self.start_time = time.time()
        
    def show_banner(self, style: str = "svony_main"):
        """Display startup banner"""
        if not self.console:
            print("=" * 60)
            print("SVONY STUDIO BORG - NEURAL TRAINING")
            print("=" * 60)
            return
            
        banner = BANNERS.get(style, BANNERS["svony_main"])
        self.console.print(banner)
        self.console.print()
        
    def show_loading(self, message: str = "ASSIMILATING MODEL..."):
        """Show loading animation"""
        if not self.console:
            print(f"Loading: {message}")
            return
            
        art = """
[green4]    ╔═══════════════════════════╗[/]
[green4]    ║[dark_cyan] ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ [/]║[/]
[green4]    ║[dark_cyan] ▓[/][dark_blue] ████████████████████ [/][dark_cyan]▓ [/]║[/]
[green4]    ║[dark_cyan] ▓[/][dark_blue] ██[/][green3] {spinner} {msg:<15}[/][dark_blue]██ [/][dark_cyan]▓ [/]║[/]
[green4]    ║[dark_cyan] ▓[/][dark_blue] ████████████████████ [/][dark_cyan]▓ [/]║[/]
[green4]    ║[dark_cyan] ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ [/]║[/]
[green4]    ╚═══════════════════════════╝[/]
"""
        spinner = SPINNERS["borg"][self.spinner_idx % len(SPINNERS["borg"])]
        self.spinner_idx += 1
        
        formatted = art.format(spinner=spinner, msg=message[:15])
        self.console.print(formatted)
        
    def get_sparkline(self, values: List[float], width: int = 20) -> str:
        """Generate sparkline graph from values"""
        if not values:
            return "─" * width
            
        # Normalize values
        min_val = min(values)
        max_val = max(values)
        range_val = max_val - min_val if max_val != min_val else 1
        
        # Take last 'width' values
        recent = values[-width:] if len(values) > width else values
        
        # Map to sparkline characters
        chars = []
        for v in recent:
            normalized = (v - min_val) / range_val
            idx = min(int(normalized * (len(SPARKLINE_CHARS) - 1)), len(SPARKLINE_CHARS) - 1)
            chars.append(SPARKLINE_CHARS[idx])
            
        return "".join(chars).ljust(width, "▁")
        
    def get_progress_bar(self, percent: float, width: int = 30) -> str:
        """Generate colored progress bar"""
        filled = int(width * percent / 100)
        empty = width - filled
        
        color = get_progress_color(percent)
        bar = f"[{color}]{'█' * filled}[/][grey37]{'░' * empty}[/]"
        
        return bar
        
    def get_training_frame(self) -> str:
        """Get current training animation frame"""
        # Cycle through frames based on step
        frame_idx = (self.metrics.step // 50) % len(TRAINING_FRAMES)
        frame = TRAINING_FRAMES[frame_idx]
        
        # Get colors based on progress
        progress = (self.metrics.step / max(self.metrics.total_steps, 1)) * 100
        main_color = get_progress_color(progress)
        loss_color = get_loss_color(self.metrics.loss, self.metrics.start_loss)
        
        return frame.format(
            color=main_color,
            loss_color=loss_color,
            step=self.metrics.step,
            total=self.metrics.total_steps,
            loss=self.metrics.loss,
            speed=self.metrics.speed,
        )
        
    def create_stats_table(self) -> Table:
        """Create metrics table"""
        progress = (self.metrics.step / max(self.metrics.total_steps, 1)) * 100
        color = get_progress_color(progress)
        
        table = Table(
            title=f"[bold {color}]◈ BORG TELEMETRY ◈[/]",
            border_style=color,
            box=box.DOUBLE_EDGE,
            header_style=f"bold white on {color}",
            show_header=True,
        )
        
        table.add_column("METRIC", style="bold", width=15)
        table.add_column("VALUE", justify="right", width=15)
        table.add_column("STATUS", justify="center", width=12)
        
        # Progress
        progress_status = "🟢" if progress > 75 else "🟡" if progress > 25 else "🔴"
        table.add_row("Progress", f"{progress:.1f}%", progress_status)
        
        # Steps
        table.add_row("Step", f"{self.metrics.step:,} / {self.metrics.total_steps:,}", "")
        
        # Loss
        loss_reduction = 0
        if self.metrics.start_loss > 0:
            loss_reduction = ((self.metrics.start_loss - self.metrics.loss) / self.metrics.start_loss) * 100
        loss_status = "🟢" if loss_reduction > 50 else "🟡" if loss_reduction > 0 else "🔴"
        table.add_row("Loss", f"{self.metrics.loss:.4f}", loss_status)
        
        # Speed
        speed_status = "🟢" if self.metrics.speed >= 0.6 else "🟡" if self.metrics.speed >= 0.25 else "🔴"
        table.add_row("Speed", f"{self.metrics.speed:.2f} s/s", speed_status)
        
        # Epoch
        table.add_row("Epoch", f"{self.metrics.epoch} / {self.metrics.total_epochs}", "")
        
        # Time
        table.add_row("Elapsed", f"{self.metrics.elapsed_minutes:.1f} min", "")
        
        # Cost
        table.add_row("Est. Cost", f"${self.metrics.estimated_cost:.2f}", "")
        
        return table
        
    def create_loss_panel(self) -> Panel:
        """Create loss visualization panel"""
        sparkline = self.get_sparkline(self.metrics.loss_history, 30)
        
        start = self.metrics.start_loss if self.metrics.start_loss > 0 else self.metrics.loss
        current = self.metrics.loss
        reduction = ((start - current) / start * 100) if start > 0 else 0
        
        color = get_loss_color(current, start)
        
        content = f"""
[{color}]LOSS TREND[/]

[bold]{start:.2f}[/] {sparkline} [bold {color}]{current:.4f}[/]

[{color}]↓ {reduction:.1f}% REDUCTION[/]
"""
        
        return Panel(
            content,
            title=f"[bold {color}]◈ CONVERGENCE ◈[/]",
            border_style=color,
            box=box.ROUNDED,
        )
        
    def create_dashboard(self) -> Layout:
        """Create full dashboard layout"""
        layout = Layout()
        
        # Header
        layout.split_column(
            Layout(name="header", size=3),
            Layout(name="main"),
            Layout(name="footer", size=3),
        )
        
        # Main area
        layout["main"].split_row(
            Layout(name="left", ratio=1),
            Layout(name="right", ratio=1),
        )
        
        # Header content
        progress = (self.metrics.step / max(self.metrics.total_steps, 1)) * 100
        color = get_progress_color(progress)
        header_text = Text()
        header_text.append("◈ ", style=color)
        header_text.append("SVONY STUDIO BORG", style=f"bold {color}")
        header_text.append(" ◈ ", style=color)
        header_text.append(f"Step {self.metrics.step:,}/{self.metrics.total_steps:,}", style="grey37")
        
        layout["header"].update(Panel(Align.center(header_text), box=box.MINIMAL))
        
        # Left: Training frame
        layout["left"].update(Panel(
            Text.from_markup(self.get_training_frame()),
            title=f"[{color}]NEURAL LINK[/]",
            border_style=color,
        ))
        
        # Right: Stats + Loss
        layout["right"].split_column(
            Layout(name="stats", ratio=2),
            Layout(name="loss", ratio=1),
        )
        layout["right"]["stats"].update(self.create_stats_table())
        layout["right"]["loss"].update(self.create_loss_panel())
        
        # Footer: Progress bar
        bar = self.get_progress_bar(progress, 50)
        footer_text = Text.from_markup(f"[{color}]PROGRESS:[/] {bar} [{color}]{progress:.1f}%[/]")
        layout["footer"].update(Panel(Align.center(footer_text), box=box.MINIMAL))
        
        return layout
        
    def update_metrics(self, **kwargs):
        """Update training metrics"""
        for key, value in kwargs.items():
            if hasattr(self.metrics, key):
                setattr(self.metrics, key, value)
                
        # Track loss history
        if "loss" in kwargs and kwargs["loss"] > 0:
            self.metrics.loss_history.append(kwargs["loss"])
            if len(self.metrics.loss_history) > 100:
                self.metrics.loss_history = self.metrics.loss_history[-100:]
                
            # Set start loss if not set
            if self.metrics.start_loss == 0:
                self.metrics.start_loss = kwargs["loss"]
                
    def show_completion(self, final_metrics: Dict[str, Any]):
        """Show completion screen"""
        if not self.console:
            print("\n" + "=" * 60)
            print("TRAINING COMPLETE!")
            print("=" * 60)
            return
            
        # Pick random completion art
        art = random.choice(COMPLETION_ARTS)
        self.console.print(art)
        
        # Final stats
        table = Table(
            title="[bold green3]◈ FINAL TELEMETRY ◈[/]",
            border_style="green3",
            box=box.DOUBLE_EDGE,
        )
        
        table.add_column("METRIC", style="bold green4")
        table.add_column("VALUE", justify="right", style="green3")
        
        for key, value in final_metrics.items():
            if isinstance(value, float):
                table.add_row(key, f"{value:.4f}")
            else:
                table.add_row(key, str(value))
                
        self.console.print(table)
        self.console.print()
        
        # Victory sound
        print('\a')
        
    def show_error(self, message: str, details: str = ""):
        """Show error panel"""
        if not self.console:
            print(f"ERROR: {message}")
            if details:
                print(details)
            return
            
        error_art = f"""
[dark_red]╔══════════════════════════════════════════════╗[/]
[dark_red]║[/]  [bold dark_red]⚠  BORG ALERT - ANOMALY DETECTED  ⚠[/]  [dark_red]║[/]
[dark_red]║[/]  ────────────────────────────────────────  [dark_red]║[/]
[dark_red]║[/]  {message:<40}  [dark_red]║[/]
[dark_red]╚══════════════════════════════════════════════╝[/]
"""
        self.console.print(error_art)
        
        if details:
            self.console.print(Panel(details, title="[dark_red]Details[/]", border_style="dark_red"))
            
    def show_guardrail_warning(self, speed: float, threshold: float):
        """Show guardrail warning"""
        if not self.console:
            print(f"WARNING: Speed {speed:.3f} below threshold {threshold}")
            return
            
        warning_art = f"""
[dark_orange3]╔══════════════════════════════════════════════╗[/]
[dark_orange3]║[/]  [bold dark_orange3]◉ GUARDRAIL CHECK - BORDERLINE ◉[/]  [dark_orange3]║[/]
[dark_orange3]║[/]  ────────────────────────────────────────  [dark_orange3]║[/]
[dark_orange3]║[/]  Speed: [bold]{speed:.3f}[/] steps/sec                 [dark_orange3]║[/]
[dark_orange3]║[/]  Threshold: [bold]{threshold:.3f}[/] steps/sec            [dark_orange3]║[/]
[dark_orange3]║[/]  Status: [bold dark_orange3]MONITORING[/]                     [dark_orange3]║[/]
[dark_orange3]╚══════════════════════════════════════════════╝[/]
"""
        self.console.print(warning_art)


# Singleton instance
_display: Optional[BorgDisplay] = None

def get_display() -> BorgDisplay:
    """Get or create display instance"""
    global _display
    if _display is None:
        _display = BorgDisplay()
    return _display


# Convenience functions
def show_banner(style: str = "svony_main"):
    get_display().show_banner(style)
    
def show_loading(message: str = "ASSIMILATING MODEL..."):
    get_display().show_loading(message)
    
def update_metrics(**kwargs):
    get_display().update_metrics(**kwargs)
    
def create_dashboard():
    return get_display().create_dashboard()
    
def show_completion(final_metrics: Dict[str, Any]):
    get_display().show_completion(final_metrics)
    
def show_error(message: str, details: str = ""):
    get_display().show_error(message, details)
