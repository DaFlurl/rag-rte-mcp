"""
ETK SOL Manager - Node Manager Module
Manages Tor node assignments for accounts with load balancing
"""

from typing import Dict, List, Any, Optional, Tuple

from .config import TOTAL_TOR_NODES, TOR_PORT_BASE, MAX_ACCOUNTS_PER_NODE
from .utils import node_to_port, port_to_node


class NodeManager:
    """Manages Tor node assignments for accounts with load balancing"""
    
    def __init__(self, total_nodes: int = TOTAL_TOR_NODES):
        self.total_nodes = total_nodes
        self.port_base = TOR_PORT_BASE
        self.max_per_node = MAX_ACCOUNTS_PER_NODE
        
        # Track assignments: node_number -> list of emails
        self.node_assignments: Dict[int, List[str]] = {
            i: [] for i in range(total_nodes)
        }
    
    def load_from_accounts(self, accounts: Dict[str, Any]) -> None:
        """Load node assignments from existing account data"""
        # Clear existing assignments
        self.node_assignments = {i: [] for i in range(self.total_nodes)}
        
        for email, account in accounts.items():
            port = None
            
            # Handle both Account objects and dictionaries
            if hasattr(account, 'proxy_port'):
                port = account.proxy_port
            elif isinstance(account, dict):
                port = account.get("data", {}).get("now", {}).get("proxyPort", "")
            
            if port:
                try:
                    node = port_to_node(int(port))
                    if 0 <= node < self.total_nodes:
                        self.node_assignments[node].append(email)
                except (ValueError, TypeError):
                    pass
    
    def get_port(self, node: int) -> int:
        """Get port number for a node"""
        return node_to_port(node)
    
    def get_node(self, port: int) -> int:
        """Get node number for a port"""
        return port_to_node(port)
    
    def assign_account(self, email: str, node: int = None) -> Tuple[int, int]:
        """
        Assign an account to a node
        
        Args:
            email: Account email
            node: Specific node to assign (None = auto-select)
            
        Returns:
            Tuple of (assigned_node, port)
        """
        # Remove from any existing assignment
        self.unassign_account(email)
        
        if node is None:
            # Find node with fewest accounts
            node = self.get_least_loaded_node()
        
        # Validate node
        if node < 0 or node >= self.total_nodes:
            node = 0
        
        self.node_assignments[node].append(email)
        return node, self.get_port(node)
    
    def unassign_account(self, email: str) -> Optional[int]:
        """
        Remove account from any node assignment
        
        Returns:
            Previous node number, or None if not assigned
        """
        for node, accounts in self.node_assignments.items():
            if email in accounts:
                accounts.remove(email)
                return node
        return None
    
    def get_account_node(self, email: str) -> int:
        """Get node number for an account (-1 if not assigned)"""
        for node, accounts in self.node_assignments.items():
            if email in accounts:
                return node
        return -1
    
    def get_least_loaded_node(self) -> int:
        """Get node with fewest accounts"""
        return min(
            range(self.total_nodes),
            key=lambda n: len(self.node_assignments[n])
        )
    
    def get_node_count(self, node: int) -> int:
        """Get number of accounts on a node"""
        return len(self.node_assignments.get(node, []))
    
    def get_node_accounts(self, node: int) -> List[str]:
        """Get list of account emails on a node"""
        return list(self.node_assignments.get(node, []))
    
    def is_node_overloaded(self, node: int) -> bool:
        """Check if node has too many accounts"""
        return self.get_node_count(node) > self.max_per_node
    
    def get_overloaded_nodes(self) -> List[int]:
        """Get list of overloaded nodes"""
        return [
            node for node in range(self.total_nodes)
            if self.is_node_overloaded(node)
        ]
    
    def get_empty_nodes(self) -> List[int]:
        """Get list of nodes with no accounts"""
        return [
            node for node in range(self.total_nodes)
            if self.get_node_count(node) == 0
        ]
    
    def get_stats(self) -> Dict[str, Any]:
        """Get node usage statistics"""
        counts = [self.get_node_count(n) for n in range(self.total_nodes)]
        used_nodes = [n for n in range(self.total_nodes) if counts[n] > 0]
        
        return {
            "total_nodes": self.total_nodes,
            "used_nodes": len(used_nodes),
            "empty_nodes": self.total_nodes - len(used_nodes),
            "total_accounts": sum(counts),
            "max_per_node": self.max_per_node,
            "min_accounts": min(counts),
            "max_accounts": max(counts),
            "avg_accounts": sum(counts) / self.total_nodes if self.total_nodes > 0 else 0,
            "overloaded_nodes": len(self.get_overloaded_nodes()),
            "distribution": {n: counts[n] for n in range(self.total_nodes)}
        }
    
    def calculate_redistribution(self) -> Dict[str, int]:
        """
        Calculate optimal redistribution of accounts
        
        Returns:
            Dictionary of {email: new_node} for accounts that should move
        """
        total_accounts = sum(len(accs) for accs in self.node_assignments.values())
        target_per_node = total_accounts // self.total_nodes
        
        moves = {}
        
        # Collect accounts from overloaded nodes
        overflow_accounts = []
        for node in range(self.total_nodes):
            accounts = self.node_assignments[node]
            if len(accounts) > target_per_node + 1:
                # Take excess accounts
                excess = len(accounts) - target_per_node
                overflow_accounts.extend(accounts[-excess:])
        
        # Assign to underloaded nodes
        for email in overflow_accounts:
            # Find node that needs accounts
            for node in range(self.total_nodes):
                if self.get_node_count(node) < target_per_node:
                    moves[email] = node
                    break
        
        return moves
    
    def auto_distribute(self, emails: List[str]) -> Dict[str, Tuple[int, int]]:
        """
        Distribute accounts evenly across all nodes
        
        Args:
            emails: List of account emails to distribute
            
        Returns:
            Dictionary of {email: (node, port)}
        """
        # Clear existing assignments for these emails
        for email in emails:
            self.unassign_account(email)
        
        assignments = {}
        for i, email in enumerate(emails):
            node = i % self.total_nodes
            self.node_assignments[node].append(email)
            assignments[email] = (node, self.get_port(node))
        
        return assignments
    
    def get_node_status_grid(self) -> List[Dict[str, Any]]:
        """
        Get node status for grid display
        
        Returns:
            List of node status dictionaries
        """
        return [
            {
                "node": n,
                "port": self.get_port(n),
                "count": self.get_node_count(n),
                "overloaded": self.is_node_overloaded(n),
                "status": "overloaded" if self.is_node_overloaded(n) 
                         else "normal" if self.get_node_count(n) > 0 
                         else "empty"
            }
            for n in range(self.total_nodes)
        ]


# Singleton instance
_node_manager_instance: Optional[NodeManager] = None


def get_node_manager() -> NodeManager:
    """Get the singleton node manager instance"""
    global _node_manager_instance
    if _node_manager_instance is None:
        _node_manager_instance = NodeManager()
    return _node_manager_instance
