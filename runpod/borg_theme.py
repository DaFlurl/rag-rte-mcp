#!/usr/bin/env python3
"""
Borg Theme - Color definitions for Svony Studio Borg display
Dark colors only - white terminal compatible
"""

# Rich color names (dark only for white backgrounds)
COLORS = {
    # Primary Borg greens
    "borg_primary": "green4",         # #008700
    "borg_dark": "dark_green",        # #006400
    "borg_bright": "green3",          # #00d700
    
    # Secondary colors
    "borg_blue": "dark_blue",         # #000087
    "borg_cyan": "dark_cyan",         # #008b8b
    "borg_magenta": "dark_magenta",   # #8b008b
    "borg_red": "dark_red",           # #8b0000
    "borg_orange": "dark_orange3",    # #cd6600
    
    # Neutrals
    "text": "grey23",                 # #303030
    "muted": "grey37",                # #5f5f5f
    "border": "green4",               # #008700
    "bg": "grey7",                    # #121212
    
    # Status colors
    "success": "green3",
    "warning": "dark_orange3",
    "error": "red3",
    "info": "dark_cyan",
}

# Progress bar color stages
PROGRESS_COLORS = [
    (0, "dark_red"),
    (25, "dark_magenta"),
    (50, "dark_blue"),
    (75, "green4"),
    (90, "green3"),
]

# Training phase colors (cycle through these)
PHASE_COLORS = [
    "green4",
    "dark_cyan", 
    "dark_blue",
    "dark_magenta",
    "green3",
]

# Border styles
BORDERS = {
    "borg": "green4",
    "alert": "dark_red",
    "success": "green3",
    "info": "dark_cyan",
}

def get_progress_color(percent: float) -> str:
    """Get color based on progress percentage"""
    for threshold, color in reversed(PROGRESS_COLORS):
        if percent >= threshold:
            return color
    return PROGRESS_COLORS[0][1]

def get_phase_color(step: int, total_phases: int = 5) -> str:
    """Get cycling color based on training step"""
    idx = (step // 100) % len(PHASE_COLORS)
    return PHASE_COLORS[idx]

def get_loss_color(loss: float, start_loss: float) -> str:
    """Get color based on loss reduction"""
    if start_loss <= 0:
        return "green4"
    
    reduction = (start_loss - loss) / start_loss * 100
    
    if reduction >= 90:
        return "green3"
    elif reduction >= 70:
        return "green4"
    elif reduction >= 50:
        return "dark_cyan"
    elif reduction >= 25:
        return "dark_blue"
    else:
        return "dark_magenta"
