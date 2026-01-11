"""
ETK SOL Manager - SOL File Handler Module
Handles reading, writing, and manipulating Flash Local Shared Object (.sol) files
"""

import os
import copy
from pathlib import Path
from typing import Dict, List, Any, Optional

try:
    import pyamf.sol as sol
    HAS_AMF = True
except ImportError:
    HAS_AMF = False


class SOLHandler:
    """Handles reading, writing, and manipulating SOL files"""
    
    def __init__(self):
        self._cache: Dict[str, Dict] = {}
        self._cache_enabled = True
    
    @property
    def amf_available(self) -> bool:
        """Check if pyamf is available"""
        return HAS_AMF
    
    def clear_cache(self) -> None:
        """Clear the SOL data cache"""
        self._cache.clear()
    
    def read_sol(self, path: str, use_cache: bool = True) -> Optional[Dict]:
        """
        Read a SOL file and return its data
        
        Args:
            path: Path to the .sol file
            use_cache: Whether to use cached data if available
            
        Returns:
            Dictionary of SOL data, or None if error
        """
        if not HAS_AMF:
            return {"_error": "pyamf not installed. Run: pip install Py3AMF"}
        
        if not os.path.exists(path):
            return {"_error": f"File not found: {path}"}
        
        # Check cache
        if use_cache and self._cache_enabled and path in self._cache:
            return copy.deepcopy(self._cache[path])
        
        try:
            with open(path, 'rb') as f:
                data = sol.load(f)
            
            result = dict(data)
            
            # Cache the result
            if self._cache_enabled:
                self._cache[path] = copy.deepcopy(result)
            
            return result
            
        except Exception as e:
            return {"_error": f"Error reading SOL: {str(e)}"}
    
    def write_sol(self, path: str, data: Dict, name: str = None) -> tuple:
        """
        Write data to a SOL file
        
        Args:
            path: Path to the .sol file
            data: Dictionary of data to write
            name: SOL name (defaults to filename without extension)
            
        Returns:
            Tuple of (success: bool, error_message: str or None)
        """
        if not HAS_AMF:
            return False, "pyamf not installed. Run: pip install Py3AMF"
        
        if name is None:
            name = Path(path).stem
        
        try:
            # Create directory if needed
            os.makedirs(os.path.dirname(path), exist_ok=True)
            
            with open(path, 'wb') as f:
                sol.save(data, f, name=name)
            
            # Update cache
            if self._cache_enabled:
                self._cache[path] = copy.deepcopy(data)
            
            return True, None
            
        except Exception as e:
            return False, f"Error writing SOL: {str(e)}"
    
    def merge_data(self, source: Dict, target: Dict, 
                   fields: List[str] = None,
                   preserve_fields: List[str] = None) -> Dict:
        """
        Merge data from source to target
        
        Args:
            source: Source data dictionary
            target: Target data dictionary
            fields: Specific fields to merge (None = all)
            preserve_fields: Fields in target to preserve
            
        Returns:
            Merged dictionary
        """
        result = copy.deepcopy(target)
        preserve = preserve_fields or []
        
        if fields is None:
            # Merge all fields
            for key, value in source.items():
                if key not in preserve:
                    result[key] = copy.deepcopy(value)
        else:
            # Merge only specified fields
            for field in fields:
                if field in preserve:
                    continue
                    
                if "." in field:
                    # Handle nested fields
                    self._merge_nested(source, result, field)
                elif field in source:
                    result[field] = copy.deepcopy(source[field])
        
        return result
    
    def _merge_nested(self, source: Dict, target: Dict, path: str) -> None:
        """Merge a nested field using dot notation path"""
        parts = path.split(".")
        
        # Navigate to source value
        src_val = source
        for p in parts:
            if isinstance(src_val, dict) and p in src_val:
                src_val = src_val[p]
            else:
                return  # Path not found in source
        
        # Set in target
        curr = target
        for p in parts[:-1]:
            if p not in curr:
                curr[p] = {}
            curr = curr[p]
        curr[parts[-1]] = copy.deepcopy(src_val)
    
    def extract_account_info(self, config_data: Dict) -> Dict[str, Any]:
        """
        Extract account information from config.sol data
        
        Args:
            config_data: Data from config.sol
            
        Returns:
            Dictionary with normalized account info
        """
        now = config_data.get("now", {})
        
        return {
            "email": now.get("username", ""),
            "password": now.get("password", ""),
            "server": now.get("server", ""),
            "server_alias": now.get("strserverAlias", ""),
            "server_ip": now.get("serverIP", ""),
            "server_id": now.get("sid", ""),
            "proxy_host": now.get("proxyHost", "127.0.0.1"),
            "proxy_port": now.get("proxyPort", "9999"),
            "proxy_type": now.get("proxyType", "ss5"),
            "auto_login": now.get("autoLogin", False),
            "auto_run": now.get("autoRun", False),
            "auto_script": now.get("autoScript", False),
            "login_type": now.get("loginType", "ev"),
            "theme": now.get("theme", ""),
        }
    
    def create_config_data(self, account_info: Dict[str, Any]) -> Dict:
        """
        Create config.sol data from account info
        
        Args:
            account_info: Dictionary with account information
            
        Returns:
            Dictionary suitable for writing to config.sol
        """
        return {
            "now": {
                "username": account_info.get("email", ""),
                "password": account_info.get("password", ""),
                "server": account_info.get("server", ""),
                "strserverAlias": account_info.get("server_alias", ""),
                "serverIP": account_info.get("server_ip", ""),
                "sid": account_info.get("server_id", ""),
                "proxyHost": account_info.get("proxy_host", "127.0.0.1"),
                "proxyPort": account_info.get("proxy_port", "9999"),
                "proxyType": account_info.get("proxy_type", "ss5"),
                "autoLogin": account_info.get("auto_login", False),
                "autoRun": account_info.get("auto_run", False),
                "autoScript": account_info.get("auto_script", False),
                "loginType": account_info.get("login_type", "ev"),
                "theme": account_info.get("theme", ""),
            }
        }
    
    def validate_sol_data(self, data: Dict, sol_type: str) -> List[str]:
        """
        Validate SOL data structure
        
        Args:
            data: SOL data dictionary
            sol_type: Type of SOL file (e.g., "config.sol")
            
        Returns:
            List of validation warnings/errors
        """
        warnings = []
        
        if "_error" in data:
            warnings.append(f"Data contains error: {data['_error']}")
            return warnings
        
        if sol_type == "config.sol":
            if "now" not in data:
                warnings.append("Missing 'now' container")
            else:
                now = data["now"]
                if not now.get("username"):
                    warnings.append("Missing username/email")
                if not now.get("server"):
                    warnings.append("Missing server")
                    
        elif sol_type == "goals.sol":
            if "now" not in data:
                warnings.append("Missing 'now' field (current script)")
                
        return warnings


# Singleton instance
_handler_instance: Optional[SOLHandler] = None


def get_sol_handler() -> SOLHandler:
    """Get the singleton SOL handler instance"""
    global _handler_instance
    if _handler_instance is None:
        _handler_instance = SOLHandler()
    return _handler_instance
