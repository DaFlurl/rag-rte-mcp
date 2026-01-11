# Svony Studio - Installation Guide

> **"Setup Instructions"** - Platform-Specific Installation Guide

---

## System Requirements

### Minimum Requirements

| Component | Requirement |
|-----------|-------------|
| **OS** | Windows 10/11 (64-bit) |
| **CPU** | Intel i5 / AMD Ryzen 5 |
| **RAM** | 8 GB |
| **Storage** | 2 GB free space |
| **Display** | 1920x1080 |

### Recommended Requirements

| Component | Requirement |
|-----------|-------------|
| **OS** | Windows 11 (64-bit) |
| **CPU** | Intel i7 / AMD Ryzen 7 |
| **RAM** | 16+ GB |
| **Storage** | 10 GB SSD |
| **Display** | 2560x1440 |

### Required Software

| Software | Version | Purpose |
|----------|---------|---------|
| **Python** | 3.11+ | Core runtime |
| **Java** | 8+ | FFDec requirement |
| **FFDec** | 20.1.0+ | SWF decompilation |

---

## Windows Installation

### Step 1: Install Python

1. Download Python from https://www.python.org/downloads/
2. Run installer
3. **IMPORTANT**: Check "Add Python to PATH"
4. Click "Install Now"
5. Verify installation:
   ```powershell
   python --version
   # Should show: Python 3.11.x or higher
   ```

### Step 2: Install Java

1. Download Java from https://adoptium.net/
2. Select "Latest LTS" (Java 21 recommended)
3. Run installer with default options
4. Verify installation:
   ```powershell
   java -version
   # Should show: openjdk version "21.x.x"
   ```

### Step 3: Install FFDec

1. Download from https://github.com/jindrapetrik/jpexs-decompiler/releases
2. Run the installer (`ffdec_xx.x.x_setup.exe`)
3. Note installation path (default: `C:\Program Files (x86)\FFDec`)
4. Verify FFDec is accessible:
   ```powershell
   "C:\Program Files (x86)\FFDec\ffdec.bat" -help
   ```

### Step 4: Clone/Download Svony Studio

**Option A: Git Clone**
```powershell
cd D:\
git clone https://github.com/yourusername/svony_studio.git
cd svony_studio
```

**Option B: Download ZIP**
1. Download ZIP from repository
2. Extract to `D:\svony_studio`

### Step 5: Create Virtual Environment

```powershell
cd D:\svony_studio
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

### Step 6: Install Dependencies

```powershell
pip install -r requirements.txt
```

### Step 7: Configure FFDec Path

Edit `config/settings.yaml`:
```yaml
tools:
  ffdec_path: "C:/Program Files (x86)/FFDec"
```

Or set environment variable:
```powershell
$env:FFDEC_PATH = "C:\Program Files (x86)\FFDec"
```

### Step 8: Run Svony Studio

```powershell
python main.py
```

Or use the launcher script:
```powershell
.\run.ps1
```

---

## Linux Installation

### Ubuntu/Debian

#### Step 1: Install System Dependencies

```bash
sudo apt update
sudo apt install python3.11 python3.11-venv python3-pip
sudo apt install openjdk-21-jre-headless
sudo apt install git
```

#### Step 2: Install FFDec

```bash
# Download latest release
wget https://github.com/jindrapetrik/jpexs-decompiler/releases/download/version20.1.0/ffdec_20.1.0.deb

# Install
sudo dpkg -i ffdec_20.1.0.deb
sudo apt-get install -f  # Fix dependencies if needed
```

#### Step 3: Clone Repository

```bash
cd ~
git clone https://github.com/yourusername/svony_studio.git
cd svony_studio
```

#### Step 4: Setup Virtual Environment

```bash
python3.11 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

#### Step 5: Run

```bash
python main.py
```

### Fedora/RHEL

```bash
sudo dnf install python3.11 java-21-openjdk git
# Then follow Ubuntu steps 2-5
```

### Arch Linux

```bash
sudo pacman -S python java-runtime git
yay -S ffdec  # From AUR
# Then follow Ubuntu steps 3-5
```

---

## macOS Installation (Planned)

### Step 1: Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Step 2: Install Dependencies

```bash
brew install python@3.11
brew install openjdk@21
brew install --cask ffdec
```

### Step 3: Setup Project

```bash
cd ~
git clone https://github.com/yourusername/svony_studio.git
cd svony_studio
python3.11 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

### Step 4: Run

```bash
python main.py
```

---

## Docker Installation (Optional)

For isolated environment using Docker:

```dockerfile
# Dockerfile
FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    openjdk-21-jre-headless \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install FFDec
RUN wget -q https://github.com/jindrapetrik/jpexs-decompiler/releases/download/version20.1.0/ffdec_20.1.0.zip \
    && unzip ffdec_20.1.0.zip -d /opt/ffdec \
    && rm ffdec_20.1.0.zip

ENV FFDEC_PATH=/opt/ffdec

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

CMD ["python", "main.py"]
```

Build and run:
```bash
docker build -t svony-studio .
docker run -it --rm -v $(pwd):/data svony-studio
```

---

## Configuration

### FFDec Configuration

Create/edit `config/settings.yaml`:

```yaml
# Svony Studio Configuration

tools:
  ffdec_path: "C:/Program Files (x86)/FFDec"
  java_path: ""  # Auto-detect if empty
  rabcdasm_path: ""  # Optional

paths:
  projects_dir: "D:/svony_studio/projects"
  temp_dir: "D:/svony_studio/temp"
  logs_dir: "D:/svony_studio/logs"

ui:
  theme: "dark"
  font_size: 12
  show_toolbar: true
  
evony:
  default_server: "svr12.evony.com"
  sol_scan_paths:
    - "%APPDATA%/Macromedia/Flash Player"
    - "%LOCALAPPDATA%/Google/Chrome/User Data"
```

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `FFDEC_PATH` | FFDec installation directory | Auto-detect |
| `JAVA_HOME` | Java installation directory | Auto-detect |
| `SVONY_CONFIG` | Config file path | `config/settings.yaml` |
| `SVONY_LOG_LEVEL` | Logging level | `INFO` |

---

## Verification

### Verify Installation

Run the verification script:

```powershell
python scripts/verify_install.py
```

Expected output:
```
✅ Python 3.11.7
✅ Java 21.0.1
✅ FFDec 20.1.0
✅ All dependencies installed
✅ Configuration valid
✅ Ready to run!
```

### Quick Test

```powershell
# Open Svony Studio
python main.py

# In another terminal, run tests
pytest tests/ -v
```

---

## Troubleshooting Installation

### Python Not Found

**Error**: `'python' is not recognized`

**Solution**:
1. Re-run Python installer
2. Check "Add to PATH"
3. Or manually add to PATH:
   ```powershell
   $env:PATH += ";C:\Users\YourName\AppData\Local\Programs\Python\Python311"
   ```

### FFDec Not Found

**Error**: `FFDec not found at specified path`

**Solution**:
1. Verify FFDec installation
2. Check path in `config/settings.yaml`
3. Set `FFDEC_PATH` environment variable

### Java Version Mismatch

**Error**: `Java version must be 8 or higher`

**Solution**:
1. Install Java 8+
2. Set `JAVA_HOME` environment variable
3. Verify: `java -version`

### Permission Denied

**Error**: `Permission denied` when running

**Solution** (Windows):
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**Solution** (Linux/macOS):
```bash
chmod +x run.sh
```

### Missing Dependencies

**Error**: `ModuleNotFoundError: No module named 'xxx'`

**Solution**:
```powershell
pip install -r requirements.txt --force-reinstall
```

---

## Updating

### Update Svony Studio

```powershell
cd D:\svony_studio
git pull origin main
pip install -r requirements.txt --upgrade
```

### Update FFDec

1. Download latest version
2. Run installer (will update existing)
3. Or update via package manager on Linux

---

## Uninstallation

### Windows

1. Delete project folder: `D:\svony_studio`
2. (Optional) Uninstall FFDec via Control Panel
3. (Optional) Remove Python virtual environment

### Linux

```bash
rm -rf ~/svony_studio
sudo apt remove ffdec  # If installed via apt
```

---

## Related Documentation

- `QUICK_START.md` - Getting started guide
- `TROUBLESHOOTING.md` - Problem solving
- `USER_GUIDE.md` - Usage documentation
- `DEVELOPER_GUIDE.md` - Development setup

---

*Document Version: 1.0.0 | Installation Guide*
