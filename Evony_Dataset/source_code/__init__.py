# Evony RE Hub - Automated Organization & Indexing System
"""
Complete reverse engineering resource hub for Evony.
Auto-organizes, indexes, and discovers related resources.

Components:
- main.py           - Unified entry point
- automation.py     - Full automation controller
- scheduler.py      - Task scheduling
- watcher.py        - File watcher for auto-organize
- borg_toolkit.py   - Core exploitation toolkit
- exploit_discovery.py - Exploit scanner
- glitch_calculator.py - Overflow calculator
- protocol_exploiter.py - Protocol exploitation
- indexer.py        - File indexing
- organizer.py      - File organization
- scanner.py        - Directory scanner
- config.py         - Configuration

Usage:
    python -m evony_hub.main              # Interactive menu
    python -m evony_hub.main --server     # Start script server
    python -m evony_hub.main --daemon     # Background automation
    python -m evony_hub.automation        # Full automation
"""

__version__ = "2.0.0"
__author__ = "Evony RE Team"

# Lazy exports to avoid circular imports
def get_hub():
    from .main import EvonyHub
    return EvonyHub()

def get_toolkit():
    from .borg_toolkit import BorgToolkit
    return BorgToolkit()
