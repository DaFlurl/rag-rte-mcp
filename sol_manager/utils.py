"""
ETK SOL Manager - Utilities Module
Common utility functions for the SOL Manager application
"""

import os
import json
import hashlib
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Any, Optional, Tuple


def safe_email_to_filename(email: str) -> str:
    """Convert email to safe filename format"""
    return email.replace("@", "_at_").replace(".", "_")


def filename_to_email(filename: str) -> str:
    """Convert safe filename back to email format"""
    return filename.replace("_at_", "@").replace("_", ".")


def get_timestamp() -> str:
    """Get current timestamp string"""
    return datetime.now().strftime("%Y%m%d_%H%M%S")


def get_iso_timestamp() -> str:
    """Get current ISO format timestamp"""
    return datetime.now().isoformat()


def format_timestamp(timestamp: str) -> str:
    """Format timestamp for display"""
    try:
        if "T" in timestamp:
            dt = datetime.fromisoformat(timestamp)
        else:
            dt = datetime.strptime(timestamp, "%Y%m%d_%H%M%S")
        return dt.strftime("%Y-%m-%d %H:%M:%S")
    except (ValueError, TypeError):
        return timestamp


def calculate_file_hash(filepath: str) -> str:
    """Calculate MD5 hash of a file"""
    try:
        with open(filepath, 'rb') as f:
            return hashlib.md5(f.read()).hexdigest()
    except Exception:
        return ""


def format_file_size(size_bytes: int) -> str:
    """Format file size for display"""
    for unit in ['B', 'KB', 'MB', 'GB']:
        if size_bytes < 1024:
            return f"{size_bytes:.1f} {unit}"
        size_bytes /= 1024
    return f"{size_bytes:.1f} TB"


def get_file_info(filepath: str) -> Dict[str, Any]:
    """Get file information"""
    try:
        stat = os.stat(filepath)
        return {
            "path": filepath,
            "size": stat.st_size,
            "size_formatted": format_file_size(stat.st_size),
            "created": datetime.fromtimestamp(stat.st_ctime).isoformat(),
            "modified": datetime.fromtimestamp(stat.st_mtime).isoformat(),
            "hash": calculate_file_hash(filepath)
        }
    except Exception as e:
        return {"path": filepath, "error": str(e)}


def node_to_port(node: int) -> int:
    """Convert node number to port number"""
    return 9999 - node


def port_to_node(port: int) -> int:
    """Convert port number to node number"""
    return 9999 - port


def parse_troop_string(troop_str: str) -> Dict[str, int]:
    """Parse troop configuration string"""
    troops = {}
    if not troop_str:
        return troops
    
    parts = troop_str.split(",")
    for part in parts:
        if ":" in part:
            code, count = part.split(":", 1)
            try:
                troops[code.strip()] = int(count.strip())
            except ValueError:
                pass
    return troops


def format_troop_string(troops: Dict[str, int]) -> str:
    """Format troop dictionary to string"""
    return ",".join(f"{k}:{v}" for k, v in troops.items() if v > 0)


def format_number_short(value: Any) -> str:
    """Format large numbers with k/m/b suffix"""
    try:
        num = float(value)
        if abs(num) >= 1_000_000_000:
            return f"{num/1_000_000_000:.1f}b"
        elif abs(num) >= 1_000_000:
            return f"{num/1_000_000:.1f}m"
        elif abs(num) >= 1_000:
            return f"{num/1_000:.1f}k"
        return str(int(num))
    except (ValueError, TypeError):
        return str(value)


def deep_get(data: Dict, path: str, default: Any = None) -> Any:
    """Get nested dictionary value using dot notation path"""
    keys = path.split(".")
    result = data
    for key in keys:
        if isinstance(result, dict) and key in result:
            result = result[key]
        else:
            return default
    return result


def deep_set(data: Dict, path: str, value: Any) -> None:
    """Set nested dictionary value using dot notation path"""
    keys = path.split(".")
    for key in keys[:-1]:
        if key not in data:
            data[key] = {}
        data = data[key]
    data[keys[-1]] = value


def json_safe_dump(data: Any) -> str:
    """Safely dump data to JSON string"""
    return json.dumps(data, indent=2, default=str, ensure_ascii=False)


def json_safe_load(text: str) -> Tuple[Optional[Dict], Optional[str]]:
    """Safely load JSON from string, returns (data, error)"""
    try:
        return json.loads(text), None
    except json.JSONDecodeError as e:
        return None, f"JSON Error at line {e.lineno}: {e.msg}"


def validate_email(email: str) -> bool:
    """Basic email validation"""
    if not email or "@" not in email:
        return False
    parts = email.split("@")
    return len(parts) == 2 and len(parts[0]) > 0 and "." in parts[1]


def get_server_display(server: str, alias: str = "") -> str:
    """Get server display string"""
    if alias:
        return f"{server} ({alias})"
    return server


def truncate_string(text: str, max_length: int = 50) -> str:
    """Truncate string with ellipsis"""
    if len(text) <= max_length:
        return text
    return text[:max_length - 3] + "..."


class EventEmitter:
    """Simple event emitter for decoupled communication"""
    
    def __init__(self):
        self._listeners: Dict[str, List[callable]] = {}
    
    def on(self, event: str, callback: callable) -> None:
        """Register event listener"""
        if event not in self._listeners:
            self._listeners[event] = []
        self._listeners[event].append(callback)
    
    def off(self, event: str, callback: callable = None) -> None:
        """Remove event listener"""
        if event in self._listeners:
            if callback:
                self._listeners[event] = [
                    cb for cb in self._listeners[event] if cb != callback
                ]
            else:
                del self._listeners[event]
    
    def emit(self, event: str, *args, **kwargs) -> None:
        """Emit event to all listeners"""
        if event in self._listeners:
            for callback in self._listeners[event]:
                try:
                    callback(*args, **kwargs)
                except Exception as e:
                    print(f"Error in event handler for {event}: {e}")


# Global event bus for application-wide events
event_bus = EventEmitter()
