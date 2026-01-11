# BORG TOOLKIT - Setup Guide

> Step-by-step setup instructions for all components

---

## Prerequisites

### Required Software

| Software | Version | Purpose |
|----------|---------|---------|
| Python | 3.7+ | Core runtime |
| pip | Latest | Package manager |
| AutoEvony | 2.0+ | Bot integration (optional) |

### Python Packages

```bash
# Core requirements
pip install pyamf        # AMF protocol (Python 3.7-3.9)
# OR
pip install Py3AMF       # AMF protocol (Python 3.10+)

# Optional
pip install pysocks      # SOCKS proxy support
pip install colorama     # Colored terminal output
```

---

## Installation

### Method 1: Direct Use

```bash
# Navigate to toolkit
cd C:\Users\Admin\Downloads\Evony_Decrypted\BorgToolkit

# Start the advanced server
python advanced_server.py
```

### Method 2: Add to Python Path

```bash
# Add to PYTHONPATH (Windows)
set PYTHONPATH=%PYTHONPATH%;C:\Users\Admin\Downloads\Evony_Decrypted\BorgToolkit

# Import in scripts
from src.protocol_commands import COMMANDS
from src.exploit_engine import TroopOverflowCalculator
```

---

## Configuration

### Environment Variables (Optional)

```bash
# Create .env file
EVONY_SERVER=cc2.evony.com
EVONY_PORT=443
EVONY_EMAIL=your@email.com
EVONY_PASSWORD=yourpassword
PROXY_HOST=127.0.0.1
PROXY_PORT=1080
```

### Server Configuration

Edit `src/connection.py`:

```python
DEFAULT_SERVERS = {
    'cc2': 'cc2.evony.com',
    'cc3': 'cc3.evony.com',
    # Add your server
}

DEFAULT_PORT = 443
```

---

## AutoEvony Integration

### Option 1: External Script Server

1. Start the script server:
   ```bash
   python advanced_server.py
   ```

2. In AutoEvony Script tab:
   ```
   includeurl http://localhost:8088/epic/overflow_chain
   ```

### Option 2: Local Script Files

1. Copy scripts to AutoEvony:
   ```
   BorgToolkit/scripts/*.txt → AutoEvony/scripts/
   ```

2. In AutoEvony:
   - Go to **Script** tab
   - Click **Load File**
   - Select script
   - Click **Run**

### Script Server Endpoints

| Endpoint | Description |
|----------|-------------|
| `http://localhost:8088/` | List all endpoints |
| `http://localhost:8088/epic/overflow_chain` | All troop overflows |
| `http://localhost:8088/epic/infinite_resources` | Combined exploits |
| `http://localhost:8088/epic/race_blitz` | 50 rapid item uses |
| `http://localhost:8088/calc/overflow?troop=6` | Calculate overflow |

---

## Testing

### Verify Installation

```bash
cd C:\Users\Admin\Downloads\Evony_Decrypted\BorgToolkit

# Test protocol commands
python -c "from src.protocol_commands import COMMANDS; print(f'Loaded {len(COMMANDS)} commands')"

# Test exploit engine
python src/exploit_engine.py
```

### Start Script Server

```bash
python advanced_server.py
```

Expected output:
```
======================================================================
BORG TOOLKIT - Advanced Exploit Server
======================================================================

Listening on http://0.0.0.0:8088

EPIC EXPLOITS:
  http://localhost:8088/epic/overflow_chain
  http://localhost:8088/epic/infinite_resources
  ...

Press Ctrl+C to stop
```

### Test from Browser

Open: `http://localhost:8088/`

---

## Troubleshooting

### Common Issues

#### "No module named 'pyamf'"
```bash
# For Python 3.7-3.9
pip install pyamf

# For Python 3.10+
pip install Py3AMF
```

#### "Address already in use"
```bash
# Find process using port 8088
netstat -ano | findstr :8088

# Kill process
taskkill /PID <pid> /F
```

#### "Connection refused" in AutoEvony
- Verify server is running: `python advanced_server.py`
- Check firewall allows port 8088
- Try `http://127.0.0.1:8088` instead of `localhost`

#### Terminal freezes when running scripts
- Run outside IDE terminal
- Use `python -u script.py` for unbuffered output
- Check Python version compatibility

---

## File Structure

```
BorgToolkit/
├── advanced_server.py       # Main exploit server
├── script_server.py         # Basic script server
├── run_borg.py              # Interactive launcher
├── requirements.txt         # Python dependencies
├── src/
│   ├── __init__.py
│   ├── protocol_commands.py # 301+ commands
│   ├── exploit_engine.py    # Exploit discovery
│   ├── connection.py        # Server connection
│   ├── injection.py         # Packet forging
│   ├── exploits.py          # Exploit implementations
│   ├── cheats.py            # Cheat sequences
│   ├── bot_integration.py   # AutoEvony integration
│   └── client_wrapper.py    # evony_client wrapper
├── scripts/
│   ├── 01_troop_overflow.txt
│   ├── 02_valley_hide.txt
│   └── discovery/
│       ├── ultimate_overflow_chain.txt
│       └── race_condition_blitz.txt
├── docs/
│   ├── SETUP.md             # This file
│   ├── PROTOCOL.md          # Protocol reference
│   ├── EXPLOITS.md          # Exploit documentation
│   ├── ACTION_PLAN.md       # Development roadmap
│   └── AUTOEVONY_INTEGRATION.md
└── diagrams/
    └── architecture.md
```

---

## Security Notes

- **Never share your credentials** in scripts
- Use environment variables for sensitive data
- Test on alt accounts first
- Use VPN/proxy for anonymity

---

*Last Updated: 2026-01-03*
