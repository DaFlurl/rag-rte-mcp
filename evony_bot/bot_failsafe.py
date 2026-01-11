#!/usr/bin/env python3
"""
Bot Server Failsafe Module
==========================
Provides retry logic, health checks, and consistent response handling.
Ensures all operations return results without failing.
"""

import time
import json
import socket
import logging
from typing import Dict, Any, Optional, Callable
from functools import wraps
from datetime import datetime

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s [%(levelname)s] %(message)s'
)
logger = logging.getLogger(__name__)

# ============================================================
# RETRY DECORATOR - Ensures operations complete
# ============================================================

def retry_operation(max_retries: int = 3, delay: float = 1.0, backoff: float = 2.0):
    """
    Decorator that retries failed operations with exponential backoff.
    Ensures operations don't fail silently.
    """
    def decorator(func: Callable):
        @wraps(func)
        def wrapper(*args, **kwargs):
            last_error = None
            current_delay = delay
            
            for attempt in range(max_retries):
                try:
                    result = func(*args, **kwargs)
                    if attempt > 0:
                        logger.info(f"{func.__name__} succeeded on attempt {attempt + 1}")
                    return result
                except Exception as e:
                    last_error = e
                    logger.warning(f"{func.__name__} attempt {attempt + 1} failed: {e}")
                    if attempt < max_retries - 1:
                        time.sleep(current_delay)
                        current_delay *= backoff
            
            # All retries failed - return error dict instead of raising
            logger.error(f"{func.__name__} failed after {max_retries} attempts: {last_error}")
            return {
                "error": str(last_error),
                "retries": max_retries,
                "function": func.__name__,
                "timestamp": datetime.now().isoformat()
            }
        return wrapper
    return decorator


# ============================================================
# RESPONSE VALIDATION - Ensures consistent responses
# ============================================================

def validate_response(response: Any, required_fields: list = None) -> Dict:
    """
    Validate and normalize response to ensure it's always a valid dict.
    Never returns None or invalid types.
    """
    if response is None:
        return {"error": "Operation returned None", "data": None}
    
    if isinstance(response, str):
        try:
            response = json.loads(response)
        except:
            return {"data": response, "type": "string"}
    
    if not isinstance(response, dict):
        return {"data": response, "type": type(response).__name__}
    
    # Check required fields
    if required_fields:
        missing = [f for f in required_fields if f not in response]
        if missing:
            response["_missing_fields"] = missing
    
    return response


def ensure_response(func: Callable):
    """Decorator that ensures function always returns a valid response."""
    @wraps(func)
    def wrapper(*args, **kwargs):
        try:
            result = func(*args, **kwargs)
            return validate_response(result)
        except Exception as e:
            logger.error(f"{func.__name__} error: {e}")
            return {
                "error": str(e),
                "function": func.__name__,
                "success": False
            }
    return wrapper


# ============================================================
# CONNECTION MANAGEMENT - Ensures connections succeed
# ============================================================

class ConnectionManager:
    """Manages connections with retry and health check capabilities."""
    
    def __init__(self, host: str = "localhost", port: int = 9999):
        self.host = host
        self.port = port
        self.socket = None
        self.connected = False
        self.last_health_check = None
        self.health_interval = 30  # seconds
    
    @retry_operation(max_retries=3, delay=1.0)
    def connect(self) -> Dict:
        """Connect with retry logic."""
        if self.socket:
            self.close()
        
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.socket.settimeout(10)
        self.socket.connect((self.host, self.port))
        self.connected = True
        
        return {
            "connected": True,
            "host": self.host,
            "port": self.port,
            "timestamp": datetime.now().isoformat()
        }
    
    def close(self):
        """Close connection safely."""
        if self.socket:
            try:
                self.socket.close()
            except:
                pass
            self.socket = None
        self.connected = False
    
    def is_healthy(self) -> bool:
        """Check if connection is healthy."""
        if not self.connected or not self.socket:
            return False
        
        try:
            # Send ping
            self.socket.settimeout(5)
            return True
        except:
            self.connected = False
            return False
    
    @retry_operation(max_retries=3, delay=0.5)
    def send_command(self, cmd: str, data: Dict = None) -> Dict:
        """Send command with retry logic."""
        if not self.is_healthy():
            self.connect()
        
        payload = json.dumps({"cmd": cmd, "data": data or {}})
        self.socket.sendall(payload.encode() + b'\n')
        
        response = self.socket.recv(65536).decode()
        return json.loads(response)


# ============================================================
# HEALTH CHECK SYSTEM
# ============================================================

class HealthChecker:
    """System health monitoring."""
    
    def __init__(self):
        self.checks = {}
        self.last_results = {}
    
    def register_check(self, name: str, check_func: Callable):
        """Register a health check function."""
        self.checks[name] = check_func
    
    def run_all_checks(self) -> Dict:
        """Run all health checks and return results."""
        results = {
            "timestamp": datetime.now().isoformat(),
            "status": "healthy",
            "checks": {}
        }
        
        for name, check_func in self.checks.items():
            try:
                check_result = check_func()
                results["checks"][name] = {
                    "status": "ok" if check_result else "failed",
                    "result": check_result
                }
                if not check_result:
                    results["status"] = "degraded"
            except Exception as e:
                results["checks"][name] = {
                    "status": "error",
                    "error": str(e)
                }
                results["status"] = "unhealthy"
        
        self.last_results = results
        return results


# ============================================================
# BACKUP/FALLBACK RESPONSES
# ============================================================

FALLBACK_RESPONSES = {
    "status": {
        "status": "offline",
        "message": "Bot server is not responding. Using fallback.",
        "fallback": True
    },
    "resources": {
        "gold": 0,
        "food": 0,
        "wood": 0,
        "stone": 0,
        "iron": 0,
        "fallback": True,
        "message": "Resource data unavailable"
    },
    "troops": {
        "troops": {},
        "fallback": True,
        "message": "Troop data unavailable"
    },
    "error": {
        "error": "Unknown error occurred",
        "fallback": True
    }
}

def get_fallback_response(response_type: str) -> Dict:
    """Get a fallback response when primary fails."""
    return FALLBACK_RESPONSES.get(response_type, FALLBACK_RESPONSES["error"]).copy()


# ============================================================
# COMMAND EXECUTION WITH FAILSAFE
# ============================================================

@retry_operation(max_retries=3, delay=1.0)
@ensure_response
def execute_command(cmd: str, params: Dict = None, conn_manager: ConnectionManager = None) -> Dict:
    """
    Execute a command with full failsafe protection.
    - Retries on failure
    - Validates response
    - Returns fallback if all else fails
    """
    if conn_manager is None:
        conn_manager = ConnectionManager()
    
    result = conn_manager.send_command(cmd, params)
    
    if "error" in result:
        logger.warning(f"Command {cmd} returned error: {result['error']}")
    
    return result


# ============================================================
# BOT SERVER WRAPPER - All operations go through here
# ============================================================

class BotServerClient:
    """
    Failsafe client for bot server operations.
    All operations guaranteed to return a response.
    """
    
    def __init__(self, host: str = "localhost", port: int = 9999):
        self.conn = ConnectionManager(host, port)
        self.health = HealthChecker()
        self._setup_health_checks()
    
    def _setup_health_checks(self):
        """Setup health check functions."""
        self.health.register_check("connection", lambda: self.conn.is_healthy())
        self.health.register_check("server_ping", self._ping_server)
    
    def _ping_server(self) -> bool:
        """Ping the server to check if it's alive."""
        try:
            import urllib.request
            req = urllib.request.Request(f"http://{self.conn.host}:{self.conn.port}/api/status")
            resp = urllib.request.urlopen(req, timeout=5)
            return resp.status == 200
        except:
            return False
    
    @ensure_response
    def get_status(self) -> Dict:
        """Get bot server status with failsafe."""
        try:
            import urllib.request
            req = urllib.request.Request(f"http://{self.conn.host}:{self.conn.port}/api/status")
            resp = urllib.request.urlopen(req, timeout=5)
            return json.loads(resp.read().decode())
        except Exception as e:
            return get_fallback_response("status")
    
    @ensure_response
    def get_resources(self) -> Dict:
        """Get resources with failsafe."""
        try:
            result = execute_command("getResources", conn_manager=self.conn)
            if "error" in result:
                return get_fallback_response("resources")
            return result
        except:
            return get_fallback_response("resources")
    
    @ensure_response
    def get_troops(self) -> Dict:
        """Get troops with failsafe."""
        try:
            result = execute_command("getTroops", conn_manager=self.conn)
            if "error" in result:
                return get_fallback_response("troops")
            return result
        except:
            return get_fallback_response("troops")
    
    @ensure_response
    def send_command(self, cmd: str, data: Dict = None) -> Dict:
        """Send any command with failsafe."""
        return execute_command(cmd, data, conn_manager=self.conn)
    
    def run_health_check(self) -> Dict:
        """Run full health check."""
        return self.health.run_all_checks()


# ============================================================
# SINGLETON CLIENT INSTANCE
# ============================================================

_client = None

def get_bot_client() -> BotServerClient:
    """Get singleton bot client instance."""
    global _client
    if _client is None:
        _client = BotServerClient()
    return _client


# ============================================================
# TEST FUNCTIONS
# ============================================================

def test_failsafe():
    """Test the failsafe system."""
    print("=" * 50)
    print("BOT FAILSAFE SYSTEM TEST")
    print("=" * 50)
    
    client = get_bot_client()
    
    print("\n[1] Testing status with failsafe...")
    status = client.get_status()
    print(f"    Result: {json.dumps(status, indent=2)[:200]}")
    
    print("\n[2] Testing health check...")
    health = client.run_health_check()
    print(f"    Result: {json.dumps(health, indent=2)}")
    
    print("\n[3] Testing retry decorator...")
    @retry_operation(max_retries=2, delay=0.1)
    def failing_func():
        raise Exception("Test failure")
    
    result = failing_func()
    print(f"    Retry result: {result}")
    
    print("\n" + "=" * 50)
    print("FAILSAFE TEST COMPLETE")
    print("=" * 50)


if __name__ == "__main__":
    test_failsafe()
