"""
ETK SOL Manager - Account Scanner Package
Validates accounts, extracts data, finds duplicates
"""

from .evony_client import EvonyClient
from .account_scanner import AccountScanner, ScanResult
from .duplicate_finder import DuplicateFinder

__all__ = [
    'EvonyClient',
    'AccountScanner',
    'ScanResult',
    'DuplicateFinder'
]
