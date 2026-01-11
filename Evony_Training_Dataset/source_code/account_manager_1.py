"""
ETK SOL Manager - Account Manager Module
Manages multiple Evony accounts with tagging, filtering, and grouping
"""

import os
import json
from pathlib import Path
from typing import Dict, List, Any, Optional, Set

from .config import MACROMEDIA_PATH, TAGS_FILE, SOL_TYPES
from .sol_handler import get_sol_handler
from .utils import port_to_node, event_bus


class Account:
    """Represents a single Evony account"""
    
    def __init__(self, email: str, config_path: str, folder: str):
        self.email = email
        self.config_path = config_path
        self.folder = folder
        self.data: Dict = {}
        self.sol_files: Dict[str, str] = {}
        self.tags: Set[str] = set()
        self.group: str = ""
        self._loaded = False
    
    @property
    def password(self) -> str:
        return self.data.get("now", {}).get("password", "")
    
    @property
    def server(self) -> str:
        return self.data.get("now", {}).get("server", "")
    
    @property
    def server_ip(self) -> str:
        return self.data.get("now", {}).get("serverIP", "")
    
    @property
    def server_alias(self) -> str:
        return self.data.get("now", {}).get("strserverAlias", "")
    
    @property
    def proxy_port(self) -> str:
        return self.data.get("now", {}).get("proxyPort", "")
    
    @property
    def node(self) -> int:
        try:
            return port_to_node(int(self.proxy_port))
        except (ValueError, TypeError):
            return -1
    
    @property
    def auto_login(self) -> bool:
        return self.data.get("now", {}).get("autoLogin", False)
    
    @property
    def is_active(self) -> bool:
        return self.auto_login
    
    def to_dict(self) -> Dict:
        return {
            "email": self.email,
            "config_path": self.config_path,
            "folder": self.folder,
            "server": self.server,
            "server_alias": self.server_alias,
            "proxy_port": self.proxy_port,
            "node": self.node,
            "auto_login": self.auto_login,
            "tags": list(self.tags),
            "group": self.group,
            "sol_files": list(self.sol_files.keys())
        }


class AccountManager:
    """Manages multiple Evony accounts with advanced organization features"""
    
    def __init__(self, macromedia_path: Path = None):
        self.macromedia_path = macromedia_path or MACROMEDIA_PATH
        self.accounts: Dict[str, Account] = {}
        self.sol_handler = get_sol_handler()
        self._tags_file = TAGS_FILE
        self._load_tags()
    
    def scan_accounts(self) -> int:
        """
        Scan for all accounts in Macromedia folder
        
        Returns:
            Number of accounts found
        """
        self.accounts = {}
        
        if not self.macromedia_path.exists():
            return 0
        
        for config_sol in self.macromedia_path.rglob("config.sol"):
            data = self.sol_handler.read_sol(str(config_sol))
            
            if data and "now" in data:
                email = data["now"].get("username", "")
                if email and email not in self.accounts:
                    account = Account(
                        email=email,
                        config_path=str(config_sol),
                        folder=str(config_sol.parent)
                    )
                    account.data = data
                    account.sol_files = self._get_account_sol_files(config_sol.parent)
                    
                    # Load saved tags
                    if email in self._account_tags:
                        account.tags = set(self._account_tags[email].get("tags", []))
                        account.group = self._account_tags[email].get("group", "")
                    
                    self.accounts[email] = account
        
        event_bus.emit("accounts_loaded", len(self.accounts))
        return len(self.accounts)
    
    def _get_account_sol_files(self, folder: Path) -> Dict[str, str]:
        """Get all SOL files for an account"""
        sol_files = {}
        for sol_file in folder.glob("*.sol"):
            sol_files[sol_file.name] = str(sol_file)
        return sol_files
    
    def get_account(self, email: str) -> Optional[Account]:
        """Get account by email"""
        return self.accounts.get(email)
    
    def get_all_emails(self) -> List[str]:
        """Get list of all account emails"""
        return list(self.accounts.keys())
    
    def get_all_accounts(self) -> List[Account]:
        """Get list of all accounts"""
        return list(self.accounts.values())
    
    # ========================================================================
    # FILTERING
    # ========================================================================
    
    def filter_accounts(self, 
                       search: str = "",
                       server: str = "",
                       node: int = -1,
                       tag: str = "",
                       group: str = "",
                       active_only: bool = False) -> List[Account]:
        """
        Filter accounts by multiple criteria
        
        Args:
            search: Search in email
            server: Filter by server code
            node: Filter by node number (-1 for all)
            tag: Filter by tag
            group: Filter by group name
            active_only: Only return active accounts
            
        Returns:
            List of matching accounts
        """
        results = []
        
        for account in self.accounts.values():
            # Search filter
            if search and search.lower() not in account.email.lower():
                continue
            
            # Server filter
            if server and account.server != server:
                continue
            
            # Node filter
            if node >= 0 and account.node != node:
                continue
            
            # Tag filter
            if tag and tag not in account.tags:
                continue
            
            # Group filter
            if group and account.group != group:
                continue
            
            # Active filter
            if active_only and not account.is_active:
                continue
            
            results.append(account)
        
        return results
    
    def get_accounts_by_server(self, server: str) -> List[Account]:
        """Get accounts for a specific server"""
        return [a for a in self.accounts.values() if a.server == server]
    
    def get_accounts_by_node(self, node: int) -> List[Account]:
        """Get accounts for a specific node"""
        return [a for a in self.accounts.values() if a.node == node]
    
    # ========================================================================
    # TAGGING
    # ========================================================================
    
    _account_tags: Dict[str, Dict] = {}
    
    def _load_tags(self) -> None:
        """Load saved tags from file"""
        try:
            if self._tags_file.exists():
                with open(self._tags_file, 'r', encoding='utf-8') as f:
                    self._account_tags = json.load(f)
        except Exception:
            self._account_tags = {}
    
    def _save_tags(self) -> None:
        """Save tags to file"""
        try:
            self._tags_file.parent.mkdir(parents=True, exist_ok=True)
            with open(self._tags_file, 'w', encoding='utf-8') as f:
                json.dump(self._account_tags, f, indent=2)
        except Exception:
            pass
    
    def add_tag(self, email: str, tag: str) -> bool:
        """Add a tag to an account"""
        account = self.get_account(email)
        if account:
            account.tags.add(tag)
            if email not in self._account_tags:
                self._account_tags[email] = {"tags": [], "group": ""}
            if tag not in self._account_tags[email]["tags"]:
                self._account_tags[email]["tags"].append(tag)
            self._save_tags()
            return True
        return False
    
    def remove_tag(self, email: str, tag: str) -> bool:
        """Remove a tag from an account"""
        account = self.get_account(email)
        if account:
            account.tags.discard(tag)
            if email in self._account_tags:
                if tag in self._account_tags[email]["tags"]:
                    self._account_tags[email]["tags"].remove(tag)
            self._save_tags()
            return True
        return False
    
    def set_group(self, email: str, group: str) -> bool:
        """Set account group"""
        account = self.get_account(email)
        if account:
            account.group = group
            if email not in self._account_tags:
                self._account_tags[email] = {"tags": [], "group": ""}
            self._account_tags[email]["group"] = group
            self._save_tags()
            return True
        return False
    
    def get_all_tags(self) -> List[str]:
        """Get list of all unique tags"""
        tags = set()
        for account in self.accounts.values():
            tags.update(account.tags)
        return sorted(tags)
    
    def get_all_groups(self) -> List[str]:
        """Get list of all unique groups"""
        groups = set()
        for account in self.accounts.values():
            if account.group:
                groups.add(account.group)
        return sorted(groups)
    
    # ========================================================================
    # STATISTICS
    # ========================================================================
    
    def get_stats(self) -> Dict[str, Any]:
        """Get account statistics"""
        total = len(self.accounts)
        active = sum(1 for a in self.accounts.values() if a.is_active)
        
        servers = {}
        nodes = {}
        tags = {}
        
        for account in self.accounts.values():
            # Server stats
            server = account.server or "Unknown"
            servers[server] = servers.get(server, 0) + 1
            
            # Node stats
            node = account.node
            if node >= 0:
                nodes[node] = nodes.get(node, 0) + 1
            
            # Tag stats
            for tag in account.tags:
                tags[tag] = tags.get(tag, 0) + 1
        
        return {
            "total_accounts": total,
            "active_accounts": active,
            "inactive_accounts": total - active,
            "servers": servers,
            "nodes": nodes,
            "tags": tags,
            "unique_tags": len(tags),
            "groups": len(self.get_all_groups())
        }
    
    def get_node_distribution(self) -> Dict[int, int]:
        """Get number of accounts per node"""
        distribution = {}
        for account in self.accounts.values():
            node = account.node
            if node >= 0:
                distribution[node] = distribution.get(node, 0) + 1
        return distribution


# Singleton instance
_account_manager_instance: Optional[AccountManager] = None


def get_account_manager() -> AccountManager:
    """Get the singleton account manager instance"""
    global _account_manager_instance
    if _account_manager_instance is None:
        _account_manager_instance = AccountManager()
    return _account_manager_instance
