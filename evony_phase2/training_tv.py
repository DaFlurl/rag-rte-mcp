#!/usr/bin/env python3
"""
SVONY STUDIO TRAINING TV - Ultimate Borg Edition
=================================================
A full "Training TV" experience for watching model training.

Features:
- 3D ASCII art banners with multiple fonts
- Borg green/black theme with transitions
- Color explosions and pixelation effects  
- Dynamic theme changes every 5%
- Live metrics dashboard
- Progress bars with color gradients
- Sparkline loss graphs
- Animated transitions between states

Designed to be watched like a live TV broadcast during training.
"""

import time
import math
import random
from dataclasses import dataclass
from typing import Optional, List, Tuple
from datetime import datetime

# Try to import display libraries
try:
    from rich.console import Console
    from rich.text import Text
    from rich.panel import Panel
    from rich.table import Table
    from rich.align import Align
    from rich.progress import Progress, BarColumn, TextColumn, TimeRemainingColumn, SpinnerColumn
    from rich.layout import Layout
    from rich.live import Live
    from rich import box
    RICH_AVAILABLE = True
except ImportError:
    RICH_AVAILABLE = False
    print("[WARNING] Rich not installed - basic display mode")

try:
    import pyfiglet
    PYFIGLET_AVAILABLE = True
except ImportError:
    PYFIGLET_AVAILABLE = False


# ============================================================
# BORG COLOR THEMES
# ============================================================
class BorgThemes:
    """Borg-inspired color themes that transition during training"""
    
    # Core Borg palette (green/black dominant)
    BORG_PRIMARY = [
        ("ASSIMILATING", "green4", "green3", "grey19"),      # Classic Borg green
        ("COLLECTIVE", "dark_green", "spring_green4", "grey15"),
        ("NEURAL_LINK", "chartreuse4", "green_yellow", "grey11"),
        ("HIVE_MIND", "sea_green3", "spring_green3", "grey19"),
    ]
    
    # Transition themes (for variety)
    TRANSITION_THEMES = [
        ("CYBER_PULSE", "deep_sky_blue3", "cyan3", "grey23"),
        ("MATRIX_FLOW", "green4", "bright_green", "black"),
        ("BORG_ALERT", "dark_orange3", "orange3", "grey19"),
        ("CRITICAL", "red3", "red1", "grey15"),
        ("EVAL_MODE", "purple3", "magenta3", "grey19"),
        ("EXCELLENCE", "gold3", "yellow3", "grey23"),
    ]
    
    # Progress bar styles
    BAR_STYLES = [
        ("borg", "grey37", "green4", "green3"),
        ("matrix", "grey23", "bright_green", "chartreuse3"),
        ("cyber", "grey30", "deep_sky_blue3", "cyan3"),
        ("alert", "grey19", "dark_orange3", "orange3"),
        ("critical", "grey15", "red3", "red1"),
    ]
    
    @classmethod
    def get_theme_for_progress(cls, pct: float, loss: float = None, 
                                speed: float = None, eval_mode: bool = False):
        """Get theme based on training state"""
        if eval_mode:
            return cls.TRANSITION_THEMES[4]  # EVAL_MODE
        
        if speed is not None and speed < 0.25:
            return cls.TRANSITION_THEMES[3]  # CRITICAL
        if speed is not None and speed < 0.4:
            return cls.TRANSITION_THEMES[2]  # BORG_ALERT
        
        # Rotate through Borg themes every 25%
        idx = int(pct // 25) % len(cls.BORG_PRIMARY)
        return cls.BORG_PRIMARY[idx]
    
    @classmethod
    def get_bar_style(cls, pct: float):
        """Get progress bar style for current progress"""
        idx = int(pct // 20) % len(cls.BAR_STYLES)
        return cls.BAR_STYLES[idx]


# ============================================================
# ASCII ART GENERATORS
# ============================================================
class BorgASCII:
    """3D ASCII art for Borg Training TV"""
    
    # Borg cube frames for animation
    BORG_CUBE_FRAMES = [
        """
    ╔═══════════════════════════════════════╗
    ║  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  ║
    ║  ▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓  ║
    ║  ▓▓░░  ╔══════════════════╗  ░░▓▓  ║
    ║  ▓▓░░  ║  BORG COLLECTIVE ║  ░░▓▓  ║
    ║  ▓▓░░  ║   NEURAL LINK    ║  ░░▓▓  ║
    ║  ▓▓░░  ╚══════════════════╝  ░░▓▓  ║
    ║  ▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓  ║
    ║  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  ║
    ╚═══════════════════════════════════════╝
        """,
        """
    ╔═══════════════════════════════════════╗
    ║  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
    ║  ░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░  ║
    ║  ░░▓▓  ╔══════════════════╗  ▓▓░░  ║
    ║  ░░▓▓  ║  ASSIMILATING... ║  ▓▓░░  ║
    ║  ░░▓▓  ║   RESISTANCE=0   ║  ▓▓░░  ║
    ║  ░░▓▓  ╚══════════════════╝  ▓▓░░  ║
    ║  ░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░  ║
    ║  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
    ╚═══════════════════════════════════════╝
        """,
    ]
    
    # Matrix rain effect characters
    MATRIX_CHARS = "ﾊﾐﾋｰｳｼﾅﾓﾆｻﾜﾂｵﾘｱﾎﾃﾏｹﾒｴｶｷﾑﾕﾗｾﾈｽﾀﾇﾍ01234567890"
    
    # Explosion frames
    EXPLOSION_FRAMES = [
        "    *    ",
        "   ***   ",
        "  *****  ",
        " ******* ",
        "*********",
        " ******* ",
        "  *****  ",
        "   ***   ",
    ]
    
    # Pixelation patterns
    PIXEL_CHARS = ["░", "▒", "▓", "█"]
    
    @classmethod
    def get_figlet_banner(cls, text: str, pct: float) -> str:
        """Get 3D ASCII banner that changes font every 5%"""
        if not PYFIGLET_AVAILABLE:
            return f"=== {text} ==="
        
        fonts = ["slant", "standard", "big", "doom", "small", "banner3", "block"]
        font_idx = int(pct // 5) % len(fonts)
        
        try:
            return pyfiglet.figlet_format(text, font=fonts[font_idx])
        except:
            return pyfiglet.figlet_format(text, font="standard")
    
    @classmethod
    def get_borg_cube(cls, frame: int = 0) -> str:
        """Get animated Borg cube frame"""
        return cls.BORG_CUBE_FRAMES[frame % len(cls.BORG_CUBE_FRAMES)]
    
    @classmethod
    def generate_matrix_line(cls, width: int = 60) -> str:
        """Generate a matrix rain line"""
        return "".join(random.choice(cls.MATRIX_CHARS) for _ in range(width))
    
    @classmethod
    def generate_explosion(cls, frame: int) -> str:
        """Get explosion animation frame"""
        return cls.EXPLOSION_FRAMES[frame % len(cls.EXPLOSION_FRAMES)]
    
    @classmethod
    def pixelate_text(cls, text: str, intensity: float) -> str:
        """Pixelate text based on intensity (0-1)"""
        result = []
        for char in text:
            if random.random() < intensity:
                result.append(random.choice(cls.PIXEL_CHARS))
            else:
                result.append(char)
        return "".join(result)


# ============================================================
# SPARKLINE GENERATOR
# ============================================================
class Sparkline:
    """ASCII sparkline for loss visualization"""
    
    CHARS = " ▁▂▃▄▅▆▇█"
    
    def __init__(self, max_points: int = 50):
        self.values: List[float] = []
        self.max_points = max_points
    
    def add(self, value: float):
        self.values.append(value)
        if len(self.values) > self.max_points:
            self.values = self.values[-self.max_points:]
    
    def render(self) -> str:
        if not self.values:
            return ""
        
        min_val = min(self.values)
        max_val = max(self.values)
        range_val = max_val - min_val if max_val != min_val else 1
        
        chars = []
        for v in self.values:
            normalized = (v - min_val) / range_val
            idx = int(normalized * (len(self.CHARS) - 1))
            chars.append(self.CHARS[idx])
        
        return "".join(chars)


# ============================================================
# TRAINING STATE
# ============================================================
@dataclass
class TrainingState:
    """Current training state for display"""
    pct: float
    step: int
    total_steps: int
    epoch: float
    total_epochs: int
    loss: float
    eval_loss: Optional[float]
    lr: float
    steps_per_sec: float
    eta_min: float
    guardrail: str
    vram_used: float = 0.0
    vram_total: float = 0.0
    phase: int = 2
    

# ============================================================
# MAIN TRAINING TV CLASS
# ============================================================
class TrainingTV:
    """
    SVONY STUDIO TRAINING TV
    A full broadcast-style training display
    """
    
    def __init__(self, title: str = "SVONY STUDIO"):
        self.title = title
        self.console = Console(force_terminal=True, color_system="truecolor", width=100)
        self.last_pct_int = -1
        self.frame_count = 0
        self.loss_sparkline = Sparkline(50)
        self.speed_sparkline = Sparkline(30)
        self.start_time = datetime.now()
        self.transition_mode = False
        self.last_theme = None
        
    def _get_header(self, state: TrainingState, theme: Tuple) -> Text:
        """Generate the header with 3D ASCII art"""
        theme_name, primary, accent, bg = theme
        
        # Get figlet banner
        banner = BorgASCII.get_figlet_banner(theme_name, state.pct)
        
        # Apply pixelation effect during transitions
        if self.transition_mode:
            intensity = 0.3 + 0.2 * math.sin(self.frame_count / 5)
            banner = BorgASCII.pixelate_text(banner, intensity)
        
        return Text(banner, style=f"bold {primary}")
    
    def _get_borg_decoration(self, state: TrainingState, theme: Tuple) -> str:
        """Get Borg-themed decoration"""
        theme_name, primary, accent, bg = theme
        
        # Alternate between cube frames
        cube = BorgASCII.get_borg_cube(self.frame_count)
        
        # Add matrix rain effect every 10%
        if int(state.pct) % 10 == 0:
            matrix_line = BorgASCII.generate_matrix_line(40)
            return f"{matrix_line}\n{cube}"
        
        return cube
    
    def _get_progress_section(self, state: TrainingState, theme: Tuple) -> Panel:
        """Create progress bars section"""
        theme_name, primary, accent, bg = theme
        bar_style = BorgThemes.get_bar_style(state.pct)
        
        # Create progress display
        progress_text = Text()
        
        # Overall progress bar (ASCII style)
        bar_width = 50
        filled = int(state.pct / 100 * bar_width)
        empty = bar_width - filled
        
        # Use different bar characters based on theme
        bar_chars = ["█", "▓", "▒", "░"]
        fill_char = bar_chars[int(state.pct // 25) % 2]
        empty_char = "░"
        
        bar = f"[{primary}]{fill_char * filled}[/][grey37]{empty_char * empty}[/]"
        progress_text.append(f"\n  OVERALL: ")
        progress_text.append_text(Text.from_markup(bar))
        progress_text.append(f" {state.pct:5.1f}%\n")
        
        # Epoch progress
        epoch_pct = (state.epoch % 1) * 100
        epoch_filled = int(epoch_pct / 100 * bar_width)
        epoch_bar = f"[{accent}]{'▓' * epoch_filled}[/][grey30]{'░' * (bar_width - epoch_filled)}[/]"
        progress_text.append(f"  EPOCH {int(state.epoch)+1}/{state.total_epochs}: ")
        progress_text.append_text(Text.from_markup(epoch_bar))
        progress_text.append(f" {epoch_pct:5.1f}%\n")
        
        return Panel(
            progress_text,
            title=f"[bold {primary}]◈ TRAINING PROGRESS ◈[/]",
            border_style=primary,
            box=box.DOUBLE,
        )
    
    def _get_metrics_table(self, state: TrainingState, theme: Tuple) -> Table:
        """Create metrics table"""
        theme_name, primary, accent, bg = theme
        
        table = Table(box=box.HEAVY, expand=True, show_header=True)
        table.add_column("METRIC", style=f"bold {primary}", justify="right", width=15)
        table.add_column("VALUE", style=f"bold {accent}", justify="left", width=20)
        table.add_column("METRIC", style=f"bold {primary}", justify="right", width=15)
        table.add_column("VALUE", style=f"bold {accent}", justify="left", width=20)
        
        # Row 1: Step & Epoch
        table.add_row(
            "STEP", f"{state.step:,} / {state.total_steps:,}",
            "EPOCH", f"{state.epoch:.2f} / {state.total_epochs}"
        )
        
        # Row 2: Loss & Eval Loss
        eval_str = f"{state.eval_loss:.4f}" if state.eval_loss else "---"
        table.add_row(
            "LOSS", f"{state.loss:.4f}",
            "EVAL LOSS", eval_str
        )
        
        # Row 3: Speed & ETA
        speed_color = "green3" if state.steps_per_sec >= 0.6 else ("orange3" if state.steps_per_sec >= 0.3 else "red3")
        table.add_row(
            "SPEED", f"[{speed_color}]{state.steps_per_sec:.3f} steps/sec[/]",
            "ETA", f"{state.eta_min:.1f} min"
        )
        
        # Row 4: LR & Guardrail
        guardrail_color = "green3" if state.guardrail == "OK" else ("orange3" if state.guardrail == "BORDERLINE" else "red3")
        table.add_row(
            "LR", f"{state.lr:.2e}",
            "GUARDRAIL", f"[bold {guardrail_color}]{state.guardrail}[/]"
        )
        
        return table
    
    def _get_sparklines_panel(self, state: TrainingState, theme: Tuple) -> Panel:
        """Create sparklines panel for loss/speed trends"""
        theme_name, primary, accent, bg = theme
        
        self.loss_sparkline.add(state.loss)
        self.speed_sparkline.add(state.steps_per_sec)
        
        content = Text()
        content.append(f"  LOSS TREND:  ", style=f"bold {primary}")
        content.append(self.loss_sparkline.render(), style=accent)
        content.append(f"\n  SPEED TREND: ", style=f"bold {primary}")
        content.append(self.speed_sparkline.render(), style="green3")
        
        return Panel(
            content,
            title=f"[bold {primary}]◈ LIVE GRAPHS ◈[/]",
            border_style=primary,
            box=box.ROUNDED,
        )
    
    def _get_status_bar(self, state: TrainingState, theme: Tuple) -> Text:
        """Get bottom status bar"""
        theme_name, primary, accent, bg = theme
        
        elapsed = datetime.now() - self.start_time
        elapsed_min = elapsed.total_seconds() / 60
        cost = elapsed_min / 60 * 3.59  # H200 rate
        
        status = Text()
        status.append(f"  ◈ PHASE {state.phase} ", style=f"bold {primary}")
        status.append(f"│ ELAPSED: {elapsed_min:.1f}min ", style="grey50")
        status.append(f"│ COST: ${cost:.2f} ", style="grey50")
        status.append(f"│ FRAME: {self.frame_count} ", style="grey37")
        status.append(f"◈", style=f"bold {primary}")
        
        return status
    
    def render(self, state: TrainingState, eval_mode: bool = False):
        """Render the full Training TV display"""
        if not RICH_AVAILABLE:
            print(f"[{state.pct:.1f}%] Loss: {state.loss:.4f} | Speed: {state.steps_per_sec:.3f}")
            return
        
        pct_int = int(state.pct)
        
        # Only full repaint on 1% boundaries (performance)
        if pct_int == self.last_pct_int and self.frame_count % 10 != 0:
            self.frame_count += 1
            return
        
        self.last_pct_int = pct_int
        self.frame_count += 1
        
        # Detect theme transition
        theme = BorgThemes.get_theme_for_progress(
            state.pct, state.loss, state.steps_per_sec, eval_mode
        )
        if self.last_theme and theme[0] != self.last_theme[0]:
            self.transition_mode = True
        else:
            self.transition_mode = False
        self.last_theme = theme
        
        theme_name, primary, accent, bg = theme
        
        # Build the display
        self.console.clear()
        
        # Header with 3D ASCII
        header = self._get_header(state, theme)
        header_panel = Panel(
            Align.center(header),
            border_style=primary,
            box=box.DOUBLE,
            padding=(0, 2),
        )
        self.console.print(header_panel)
        
        # Progress bars
        self.console.print(self._get_progress_section(state, theme))
        
        # Metrics table
        metrics = self._get_metrics_table(state, theme)
        metrics_panel = Panel(
            metrics,
            title=f"[bold {primary}]◈ LIVE METRICS ◈[/]",
            border_style=primary,
            box=box.DOUBLE,
        )
        self.console.print(metrics_panel)
        
        # Sparklines
        self.console.print(self._get_sparklines_panel(state, theme))
        
        # Status bar
        self.console.print(self._get_status_bar(state, theme))
        
        # Special effects on milestones
        if pct_int % 25 == 0 and pct_int > 0:
            self._show_milestone(pct_int, theme)
    
    def _show_milestone(self, pct: int, theme: Tuple):
        """Show special animation at milestones"""
        theme_name, primary, accent, bg = theme
        
        milestone_text = f"═══════ {pct}% COMPLETE ═══════"
        self.console.print(
            Panel(
                Align.center(Text(milestone_text, style=f"bold {accent}")),
                border_style=primary,
                box=box.DOUBLE,
            )
        )
    
    def show_completion(self, state: TrainingState, total_time: float, total_cost: float):
        """Show training completion screen"""
        if not RICH_AVAILABLE:
            print(f"\n=== TRAINING COMPLETE ===")
            print(f"Time: {total_time:.1f} min | Cost: ${total_cost:.2f}")
            return
        
        completion_banner = BorgASCII.get_figlet_banner("COMPLETE", 100)
        
        self.console.clear()
        self.console.print(Panel(
            Align.center(Text(completion_banner, style="bold green3")),
            border_style="green3",
            box=box.DOUBLE,
            title="[bold green3]◈ ASSIMILATION COMPLETE ◈[/]",
        ))
        
        summary = Table(box=box.HEAVY, expand=True)
        summary.add_column("FINAL METRIC", style="bold green4")
        summary.add_column("VALUE", style="bold spring_green3")
        
        summary.add_row("Total Steps", f"{state.step:,}")
        summary.add_row("Final Loss", f"{state.loss:.4f}")
        summary.add_row("Final Eval Loss", f"{state.eval_loss:.4f}" if state.eval_loss else "---")
        summary.add_row("Training Time", f"{total_time:.1f} minutes")
        summary.add_row("Estimated Cost", f"${total_cost:.2f}")
        summary.add_row("Average Speed", f"{state.steps_per_sec:.3f} steps/sec")
        
        self.console.print(Panel(summary, border_style="green3", box=box.DOUBLE))


# ============================================================
# DEMO / TEST
# ============================================================
def demo():
    """Demo the Training TV display"""
    tv = TrainingTV()
    
    total_steps = 500
    for step in range(total_steps + 1):
        pct = (step / total_steps) * 100.0
        
        # Simulated metrics
        loss = 0.35 + 1.8 * math.exp(-step / 100) + 0.02 * math.sin(step / 10)
        steps_per_sec = 0.75 + 0.1 * math.sin(step / 30)
        lr = 1e-5 * (1 - step / total_steps)
        
        eval_loss = None
        eval_mode = False
        if step % 100 == 0 and step > 0:
            eval_loss = max(0.30, loss + 0.05)
            eval_mode = True
        
        guardrail = "OK" if steps_per_sec >= 0.5 else "BORDERLINE"
        
        state = TrainingState(
            pct=pct,
            step=step,
            total_steps=total_steps,
            epoch=2.0 * step / total_steps,
            total_epochs=2,
            loss=loss,
            eval_loss=eval_loss,
            lr=lr,
            steps_per_sec=steps_per_sec,
            eta_min=(total_steps - step) / max(steps_per_sec, 0.1) / 60.0,
            guardrail=guardrail,
            phase=2,
        )
        
        tv.render(state, eval_mode)
        time.sleep(0.05)
    
    tv.show_completion(state, 45.0, 2.70)


if __name__ == "__main__":
    demo()
