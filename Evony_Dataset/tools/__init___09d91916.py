# BORG TOOLKIT - Enterprise Grade Evony Exploitation Framework
"""
Complete toolkit for Evony reverse engineering, protocol manipulation,
live networking, packet injection, and working cheats/exploits.

Modules:
- connection: Live server connection and packet capture
- injection: Packet injection using extracted encryption keys
- exploits: Working exploit implementations (food, troops, items)
- cheats: Automated cheat engines for resources, troops, items
- protocol: Complete protocol command registry
- crypto: Encryption/decryption using extracted keys
"""

__version__ = "2.0.0"
__author__ = "Borg Collective"

from pathlib import Path

TOOLKIT_ROOT = Path(__file__).parent.parent
SRC_ROOT = TOOLKIT_ROOT / "src"
DOCS_ROOT = TOOLKIT_ROOT / "docs"
EXPLOITS_ROOT = TOOLKIT_ROOT / "exploits"
NETWORK_ROOT = TOOLKIT_ROOT / "network"
