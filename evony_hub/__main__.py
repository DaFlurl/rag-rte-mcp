#!/usr/bin/env python3
# Evony Hub - Package Entry Point
"""
Allows running evony_hub as a module:
    python -m evony_hub
    python -m evony_hub --server
    python -m evony_hub --daemon
"""

from evony_hub.main import main

if __name__ == "__main__":
    main()
