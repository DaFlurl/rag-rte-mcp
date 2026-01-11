# Svony Studio - Security Guide

> **"Security Best Practices"** - Safe Usage and Credential Protection

---

## Overview

This document covers security considerations for using Svony Studio, protecting credentials, and responsible reverse engineering practices.

---

## Credential Security

### Password Handling

**Never Store Plaintext Passwords**

```python
# BAD - Plaintext storage
password = "mysecretpassword"

# GOOD - Environment variable
import os
password = os.environ.get("EVONY_PASSWORD")

# GOOD - Encrypted config
from cryptography.fernet import Fernet
encrypted_password = config.get("encrypted_password")
password = cipher.decrypt(encrypted_password)
```

### SOL File Security

SOL files contain sensitive data:

```python
# cevony_sol.sol contents
{
    "username": "player1",
    "password": "5f4dcc3b...",  # MD5 hash
    "server": "svr12.evony.com",
    "sessionToken": "abc123..."
}
```

**Recommendations:**
- Don't share SOL files
- Encrypt exported credentials
- Clear SOL files when not needed
- Use unique passwords per game

### Config File Protection

```yaml
# config/accounts.yaml - SENSITIVE
accounts:
  - username: player1
    password_hash: "5f4dcc3b..."  # Store hash only
    server: svr12.evony.com
```

**File Permissions:**
```bash
# Windows - Restrict to user
icacls accounts.yaml /inheritance:r /grant:r "%USERNAME%:R"

# Linux - Owner only
chmod 600 accounts.yaml
```

---

## Network Security

### Proxy Traffic

When using the proxy tool:

1. **Localhost Only**
   ```yaml
   proxy:
     listen_host: 127.0.0.1  # Never 0.0.0.0
     listen_port: 8888
   ```

2. **Disable When Not in Use**
   ```bash
   python main.py proxy stop
   ```

3. **Secure Captures**
   - Encrypt capture files
   - Delete after analysis
   - Don't share raw captures

### SSL/TLS

```python
# Always verify SSL in production
import ssl
context = ssl.create_default_context()
context.verify_mode = ssl.CERT_REQUIRED

# Only disable for testing (with warning)
if DEBUG_MODE:
    context.check_hostname = False
    context.verify_mode = ssl.CERT_NONE
    logging.warning("SSL verification disabled - TESTING ONLY")
```

### Tor Integration

When using Tor for anonymity:

```python
# Verify Tor is working
import requests

def verify_tor():
    proxies = {
        'http': 'socks5h://127.0.0.1:9050',
        'https': 'socks5h://127.0.0.1:9050'
    }
    
    # Check Tor exit IP
    response = requests.get('https://check.torproject.org/api/ip', proxies=proxies)
    data = response.json()
    
    if data['IsTor']:
        print(f"Tor active, exit IP: {data['IP']}")
        return True
    else:
        print("WARNING: Not using Tor!")
        return False
```

---

## File System Security

### Temporary Files

```python
import tempfile
import os

# Secure temporary directory
temp_dir = tempfile.mkdtemp(prefix="svony_")

try:
    # Use temp files
    work_file = os.path.join(temp_dir, "work.swf")
    # ... operations ...
finally:
    # Clean up sensitive data
    import shutil
    shutil.rmtree(temp_dir, ignore_errors=True)
```

### Sensitive File Handling

```python
def secure_delete(filepath):
    """Overwrite before delete for sensitive files."""
    import os
    
    if os.path.exists(filepath):
        # Overwrite with random data
        size = os.path.getsize(filepath)
        with open(filepath, 'wb') as f:
            f.write(os.urandom(size))
        
        # Then delete
        os.remove(filepath)
```

### Project Files

```
D:\svony_studio\
├── projects/           # May contain sensitive data
├── captures/           # SENSITIVE - network captures
├── exports/            # May contain credentials
└── logs/              # May log sensitive operations
```

**Recommended .gitignore:**
```gitignore
# Sensitive directories
captures/
exports/*.json
logs/*.log

# Config with credentials
config/accounts.yaml
config/*.secret

# SOL files
*.sol

# Environment files
.env
.env.local
```

---

## Input Validation

### SWF File Validation

```python
def validate_swf(filepath):
    """Validate SWF before processing."""
    import os
    
    # Check file exists
    if not os.path.exists(filepath):
        raise ValueError("File not found")
    
    # Check extension
    if not filepath.lower().endswith('.swf'):
        raise ValueError("Not a SWF file")
    
    # Check magic bytes
    with open(filepath, 'rb') as f:
        magic = f.read(3)
        if magic not in [b'FWS', b'CWS', b'ZWS']:
            raise ValueError("Invalid SWF signature")
    
    # Check size limits
    size = os.path.getsize(filepath)
    if size > 100 * 1024 * 1024:  # 100MB
        raise ValueError("File too large")
    
    return True
```

### Path Traversal Prevention

```python
import os

def safe_path(base_dir, user_path):
    """Prevent path traversal attacks."""
    # Resolve to absolute path
    abs_path = os.path.abspath(os.path.join(base_dir, user_path))
    abs_base = os.path.abspath(base_dir)
    
    # Verify path is under base directory
    if not abs_path.startswith(abs_base):
        raise ValueError("Path traversal detected")
    
    return abs_path

# Usage
try:
    safe = safe_path("/projects", "../../../etc/passwd")
except ValueError:
    print("Blocked path traversal attempt")
```

### AMF Data Validation

```python
def validate_amf_data(data, schema):
    """Validate AMF data structure."""
    
    # Check required fields
    for field in schema.get('required', []):
        if field not in data:
            raise ValueError(f"Missing required field: {field}")
    
    # Type validation
    for field, expected_type in schema.get('types', {}).items():
        if field in data:
            if not isinstance(data[field], expected_type):
                raise TypeError(f"Invalid type for {field}")
    
    # Range validation
    for field, (min_val, max_val) in schema.get('ranges', {}).items():
        if field in data:
            if not min_val <= data[field] <= max_val:
                raise ValueError(f"Value out of range for {field}")
```

---

## Code Execution Safety

### FFDec Isolation

```python
import subprocess

def run_ffdec_safe(args, timeout=60):
    """Run FFDec with safety constraints."""
    
    # Build command
    cmd = ["java", "-jar", FFDEC_JAR] + args
    
    try:
        result = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            timeout=timeout,  # Prevent hangs
            check=False
        )
        return result
    except subprocess.TimeoutExpired:
        logging.warning("FFDec timed out")
        raise
```

### Script Execution

When running bot scripts:

```python
class ScriptSandbox:
    """Sandboxed script execution."""
    
    ALLOWED_COMMANDS = {
        'ATTACK_NPC', 'TRAIN', 'BUILD', 'WAIT',
        'LOG', 'IF', 'ENDIF', 'LOOP', 'END'
    }
    
    MAX_ITERATIONS = 10000
    MAX_RUNTIME = 3600  # 1 hour
    
    def execute(self, script):
        iteration = 0
        start_time = time.time()
        
        for line in script:
            # Check limits
            iteration += 1
            if iteration > self.MAX_ITERATIONS:
                raise RuntimeError("Iteration limit exceeded")
            
            if time.time() - start_time > self.MAX_RUNTIME:
                raise RuntimeError("Runtime limit exceeded")
            
            # Validate command
            cmd = line.split()[0].upper()
            if cmd not in self.ALLOWED_COMMANDS:
                raise ValueError(f"Disallowed command: {cmd}")
            
            # Execute safely
            self._execute_command(line)
```

---

## Logging Security

### Sensitive Data Redaction

```python
import re
import logging

class RedactingFilter(logging.Filter):
    """Filter to redact sensitive data from logs."""
    
    PATTERNS = [
        (r'password["\']?\s*[:=]\s*["\']?[\w]+', 'password=***'),
        (r'token["\']?\s*[:=]\s*["\']?[\w-]+', 'token=***'),
        (r'\b[A-Fa-f0-9]{32}\b', '[MD5_HASH]'),  # MD5 hashes
        (r'username["\']?\s*[:=]\s*["\']?([\w]+)', r'username=***'),
    ]
    
    def filter(self, record):
        msg = record.getMessage()
        for pattern, replacement in self.PATTERNS:
            msg = re.sub(pattern, replacement, msg, flags=re.IGNORECASE)
        record.msg = msg
        record.args = ()
        return True

# Setup logging with redaction
logger = logging.getLogger('svony')
logger.addFilter(RedactingFilter())
```

### Log File Protection

```python
import logging
from logging.handlers import RotatingFileHandler
import os

def setup_secure_logging():
    """Setup logging with security considerations."""
    
    log_dir = "logs"
    os.makedirs(log_dir, exist_ok=True)
    
    # Rotate logs to limit exposure
    handler = RotatingFileHandler(
        os.path.join(log_dir, "svony.log"),
        maxBytes=10*1024*1024,  # 10MB
        backupCount=5
    )
    
    # Don't log sensitive operations in production
    if not DEBUG_MODE:
        handler.setLevel(logging.WARNING)
    
    logger = logging.getLogger('svony')
    logger.addHandler(handler)
```

---

## Legal and Ethical Considerations

### Terms of Service

- Review game ToS before reverse engineering
- Understand local laws regarding RE
- Use only for research/educational purposes

### Responsible Disclosure

If you discover security vulnerabilities:

1. Don't exploit for personal gain
2. Document the issue
3. Report to game developer
4. Wait for fix before public disclosure

### Bot Usage

- Understand consequences of ToS violation
- Account bans are possible
- Don't disrupt game for others

---

## Security Checklist

### Before Using Svony Studio

- [ ] Review security settings
- [ ] Configure credential encryption
- [ ] Setup secure log handling
- [ ] Understand legal implications

### During Operation

- [ ] Use localhost-only proxy
- [ ] Don't expose credentials in logs
- [ ] Clean up temporary files
- [ ] Monitor for suspicious activity

### After Use

- [ ] Secure delete captures
- [ ] Clear session data
- [ ] Rotate passwords if exposed
- [ ] Review logs for issues

---

## Related Documentation

- `CONFIGURATION.md` - Secure config setup
- `PROXY_TOOL.md` - Proxy security
- `evony/BOT_INTEGRATION.md` - Bot security
- `TROUBLESHOOTING.md` - Security issues

---

*Document Version: 1.0.0 | Security Guide*
