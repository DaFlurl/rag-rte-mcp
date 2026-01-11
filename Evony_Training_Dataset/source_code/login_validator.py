#!/usr/bin/env python3
"""
BORG TOOLKIT - Login Validator
Validates Evony account logins using AMF protocol with proxy rotation
"""

import json
import time
import logging
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Optional, Tuple
from dataclasses import dataclass, asdict
import threading

try:
    import socks
    SOCKS_AVAILABLE = True
except ImportError:
    SOCKS_AVAILABLE = False

from .amf_commander import AMFCommander, ServerConfig, GameCommand

logger = logging.getLogger(__name__)

# Server mappings (from config.xml - actual game server IPs)
# Evony uses RAW TCP with AMF protocol, NOT SSL
SERVERS = {
    'cc2': {'host': '216.66.17.168', 'port': 443, 'use_ssl': False},
    'cc1': {'host': '216.66.17.167', 'port': 443, 'use_ssl': False},
    'cc3': {'host': '216.66.17.169', 'port': 443, 'use_ssl': False},
    'na1': {'host': '216.66.17.165', 'port': 443, 'use_ssl': False},
    'na2': {'host': '216.66.17.166', 'port': 443, 'use_ssl': False},
}


@dataclass
class ValidationResult:
    """Result of account validation"""
    email: str
    password: str
    server: str
    success: bool
    player_name: Optional[str] = None
    player_id: Optional[int] = None
    error: Optional[str] = None
    attempts: int = 0
    latency_ms: float = 0.0
    validated_at: Optional[str] = None
    
    def to_dict(self) -> dict:
        return asdict(self)


class LoginValidator:
    """
    Validates Evony account logins with retry logic and proxy rotation.
    
    Features:
    - 3-5 retry attempts per account
    - SOCKS4/5 proxy support for Tor
    - Rate limiting between attempts
    - Detailed result tracking
    """
    
    def __init__(self, max_retries: int = 5, retry_delay: float = 3.0):
        self.max_retries = max_retries
        self.retry_delay = retry_delay
        
        self.proxies: List[Dict] = []
        self.current_proxy_idx = 0
        
        self.results: List[ValidationResult] = []
        self.active_count = 0
        self.failed_count = 0
        
        self._stop_event = threading.Event()
        self._lock = threading.Lock()
        
        # Output paths
        self.output_dir = Path(__file__).parent.parent / "data" / "validation"
        self.output_dir.mkdir(parents=True, exist_ok=True)
    
    def add_proxy(self, host: str, port: int, proxy_type: str = "SOCKS4"):
        """Add proxy for rotation"""
        self.proxies.append({
            'host': host,
            'port': port,
            'type': proxy_type
        })
    
    def add_tor_proxies(self, base_port: int = 9000, count: int = 50):
        """Add multiple Tor proxies"""
        for i in range(count):
            self.add_proxy("127.0.0.1", base_port + i, "SOCKS4")
        logger.info(f"Added {count} Tor proxies (ports {base_port}-{base_port+count-1})")
    
    def _get_next_proxy(self) -> Optional[Dict]:
        """Get next proxy in rotation"""
        if not self.proxies:
            return None
        with self._lock:
            proxy = self.proxies[self.current_proxy_idx]
            self.current_proxy_idx = (self.current_proxy_idx + 1) % len(self.proxies)
        return proxy
    
    def validate_account(self, email: str, password: str, 
                        server: str = "cc2") -> ValidationResult:
        """
        Validate a single account with retry logic.
        Returns ValidationResult.
        """
        result = ValidationResult(
            email=email,
            password=password,
            server=server,
            success=False,
            validated_at=datetime.now().isoformat()
        )
        
        # Get server config
        server_info = SERVERS.get(server, SERVERS['cc2'])
        
        for attempt in range(1, self.max_retries + 1):
            if self._stop_event.is_set():
                result.error = "Validation stopped"
                break
            
            result.attempts = attempt
            logger.info(f"[{attempt}/{self.max_retries}] Validating {email}...")
            
            try:
                # Get proxy
                proxy = self._get_next_proxy()
                
                # Create commander
                commander = AMFCommander()
                
                # Configure proxy if available
                if proxy and SOCKS_AVAILABLE:
                    # Set up SOCKS proxy on socket
                    import socket
                    socks.set_default_proxy(
                        socks.SOCKS4 if proxy['type'] == 'SOCKS4' else socks.SOCKS5,
                        proxy['host'],
                        proxy['port']
                    )
                    socket.socket = socks.socksocket
                    logger.debug(f"Using proxy {proxy['host']}:{proxy['port']}")
                
                # Connect
                config = ServerConfig(
                    host=server_info['host'],
                    port=server_info['port'],
                    server_id=server,
                    use_ssl=server_info.get('use_ssl', False)
                )
                
                if not commander.connect(config):
                    result.error = "Connection failed"
                    if attempt < self.max_retries:
                        time.sleep(self.retry_delay)
                    continue
                
                # Login
                login_result = commander.login(email, password)
                
                # Disconnect
                commander.disconnect()
                
                # Reset socket if we used proxy
                if proxy and SOCKS_AVAILABLE:
                    import socket as real_socket
                    socks.set_default_proxy()
                
                if login_result.success:
                    result.success = True
                    result.player_id = commander.player_id
                    result.player_name = login_result.data.get('playerName', 'Unknown')
                    result.latency_ms = login_result.latency_ms
                    result.error = None
                    logger.info(f"✓ SUCCESS: {email} -> {result.player_name}")
                    break
                else:
                    result.error = login_result.error or "Login failed"
                    logger.warning(f"✗ Attempt {attempt} failed: {result.error}")
                    
            except Exception as e:
                result.error = str(e)
                logger.error(f"✗ Attempt {attempt} error: {e}")
            
            # Wait before retry
            if attempt < self.max_retries:
                time.sleep(self.retry_delay)
        
        # Final status
        if result.success:
            self.active_count += 1
        else:
            self.failed_count += 1
            logger.warning(f"✗ FAILED: {email} after {result.attempts} attempts")
        
        self.results.append(result)
        return result
    
    def validate_accounts(self, accounts: List[Dict], 
                         progress_callback=None) -> List[ValidationResult]:
        """
        Validate multiple accounts.
        accounts: List of {email, password, server} dicts
        progress_callback(email, status, progress_pct)
        """
        self._stop_event.clear()
        self.results = []
        self.active_count = 0
        self.failed_count = 0
        
        total = len(accounts)
        logger.info(f"Validating {total} accounts...")
        
        for i, acc in enumerate(accounts):
            if self._stop_event.is_set():
                break
            
            result = self.validate_account(
                email=acc['email'],
                password=acc['password'],
                server=acc.get('server', 'cc2')
            )
            
            if progress_callback:
                progress_callback(
                    acc['email'],
                    'active' if result.success else 'failed',
                    (i + 1) / total
                )
        
        logger.info(f"Validation complete: {self.active_count} active, {self.failed_count} failed")
        return self.results
    
    def stop(self):
        """Stop validation"""
        self._stop_event.set()
    
    def save_results(self) -> Dict[str, Path]:
        """Save validation results to files"""
        ts = datetime.now().strftime('%Y%m%d_%H%M%S')
        paths = {}
        
        # All results JSON
        json_file = self.output_dir / f"validation_{ts}.json"
        with open(json_file, 'w', encoding='utf-8') as f:
            json.dump([r.to_dict() for r in self.results], f, indent=2)
        paths['json'] = json_file
        
        # Active accounts
        active = [r for r in self.results if r.success]
        active_file = self.output_dir / f"active_{ts}.txt"
        with open(active_file, 'w', encoding='utf-8') as f:
            for r in active:
                f.write(f"{r.email}:{r.password}\n")
        paths['active'] = active_file
        
        # Failed accounts (editable format)
        failed = [r for r in self.results if not r.success]
        failed_file = self.output_dir / f"failed_{ts}.txt"
        with open(failed_file, 'w', encoding='utf-8') as f:
            f.write("# Failed accounts - edit passwords and resubmit\n")
            f.write("# Format: email:password  # error\n\n")
            for r in failed:
                f.write(f"{r.email}:{r.password}  # {r.error}\n")
        paths['failed'] = failed_file
        
        logger.info(f"Results saved to {self.output_dir}")
        return paths
    
    def get_stats(self) -> Dict:
        """Get validation statistics"""
        return {
            'total': len(self.results),
            'active': self.active_count,
            'failed': self.failed_count,
            'pending': 0,
            'proxies': len(self.proxies),
        }


def validate_from_file(input_file: Path, max_retries: int = 5,
                       use_tor: bool = True) -> Dict:
    """
    Validate accounts from a file.
    Supports CSV and TXT (email:password) formats.
    """
    # Load accounts
    accounts = []
    
    with open(input_file, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith('#'):
                continue
            
            if ':' in line:
                parts = line.split(':')
                email = parts[0].strip()
                password = parts[1].split('#')[0].strip()  # Remove comments
                accounts.append({'email': email, 'password': password, 'server': 'cc2'})
            elif ',' in line:
                parts = line.split(',')
                if len(parts) >= 2:
                    accounts.append({
                        'email': parts[0].strip(),
                        'password': parts[1].strip(),
                        'server': parts[2].strip() if len(parts) > 2 else 'cc2'
                    })
    
    print(f"Loaded {len(accounts)} accounts from {input_file}")
    
    # Create validator
    validator = LoginValidator(max_retries=max_retries)
    
    # Add Tor proxies if requested
    if use_tor:
        validator.add_tor_proxies(base_port=9000, count=50)
    
    # Validate
    results = validator.validate_accounts(accounts)
    
    # Save results
    paths = validator.save_results()
    
    return {
        'stats': validator.get_stats(),
        'paths': {k: str(v) for k, v in paths.items()}
    }


if __name__ == '__main__':
    import sys
    
    logging.basicConfig(level=logging.INFO)
    
    if len(sys.argv) < 2:
        print("Usage: python login_validator.py <accounts_file>")
        print("  accounts_file: TXT (email:password) or CSV format")
        sys.exit(1)
    
    input_file = Path(sys.argv[1])
    if not input_file.exists():
        print(f"File not found: {input_file}")
        sys.exit(1)
    
    result = validate_from_file(input_file)
    print(f"\nResults: {result['stats']}")
    print(f"Files: {result['paths']}")
