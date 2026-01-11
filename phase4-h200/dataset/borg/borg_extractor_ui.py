#!/usr/bin/env python3
"""
BORG TOOLKIT EPIC 2026 - Account Extractor Web UI
==================================================

Web interface for:
- Managing account logins
- Extracting data from Evony servers
- Viewing all account sections (cities, troops, heroes, resources, items)
- Exporting to CSV/JSON
- Multi-account management with Tor rotation

Usage:
    python borg_extractor_ui.py

Dashboard: http://localhost:8090/
"""

import json
import csv
import hashlib
import asyncio
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Any, Optional
from dataclasses import dataclass, field, asdict
import threading
import queue

try:
    from fastapi import FastAPI, WebSocket, WebSocketDisconnect, HTTPException, Request, UploadFile, File, Form
    from fastapi.responses import HTMLResponse, PlainTextResponse, JSONResponse, FileResponse
    from fastapi.middleware.cors import CORSMiddleware
    from contextlib import asynccontextmanager
    import uvicorn
    FASTAPI_AVAILABLE = True
except ImportError:
    FASTAPI_AVAILABLE = False
    print("[!] FastAPI not installed. Run: pip install fastapi uvicorn python-multipart")

# Import our extractor
try:
    from src.account_extractor import AccountExtractor, AccountData, CityData, TroopData
    EXTRACTOR_AVAILABLE = True
except ImportError:
    EXTRACTOR_AVAILABLE = False
    print("[!] Account extractor not available")

# Configuration
HOST = "0.0.0.0"
PORT = 8090
DATA_DIR = Path(__file__).parent / "data"
DATA_DIR.mkdir(exist_ok=True)

# =============================================================================
# DATA STORAGE
# =============================================================================

class DataStore:
    """In-memory + file storage for accounts and extracted data"""
    
    def __init__(self):
        self.accounts_file = DATA_DIR / "accounts_credentials.json"
        self.extracts_dir = DATA_DIR / "extracts"
        self.extracts_dir.mkdir(exist_ok=True)
        
        self.credentials: List[Dict] = []  # {email, password, server, status}
        self.extracted_accounts: Dict[str, Dict] = {}  # email -> full data
        self.extraction_log: List[str] = []
        
        self._load_credentials()
    
    def _load_credentials(self):
        """Load saved credentials"""
        if self.accounts_file.exists():
            try:
                self.credentials = json.loads(self.accounts_file.read_text())
            except:
                self.credentials = []
    
    def _save_credentials(self):
        """Save credentials to file"""
        self.accounts_file.write_text(json.dumps(self.credentials, indent=2))
    
    def add_credential(self, email: str, password: str, server: str = "cc2"):
        """Add account credential"""
        # Check if exists
        for cred in self.credentials:
            if cred['email'] == email:
                cred['password'] = password
                cred['server'] = server
                self._save_credentials()
                return
        
        self.credentials.append({
            'email': email,
            'password': password,
            'server': server,
            'status': 'pending',
            'last_extract': None
        })
        self._save_credentials()
    
    def remove_credential(self, email: str):
        """Remove credential"""
        self.credentials = [c for c in self.credentials if c['email'] != email]
        self._save_credentials()
    
    def add_credentials_from_csv(self, csv_content: str):
        """Parse CSV and add credentials"""
        count = 0
        for line in csv_content.strip().split('\n'):
            parts = line.strip().split(',')
            if len(parts) >= 2:
                email = parts[0].strip()
                password = parts[1].strip()
                server = parts[2].strip() if len(parts) > 2 else "cc2"
                if email and password and '@' in email:
                    self.add_credential(email, password, server)
                    count += 1
        return count
    
    def save_extracted_data(self, email: str, data: Dict):
        """Save extracted account data"""
        self.extracted_accounts[email] = data
        
        # Update credential status
        for cred in self.credentials:
            if cred['email'] == email:
                cred['status'] = 'extracted'
                cred['last_extract'] = datetime.now().isoformat()
        self._save_credentials()
        
        # Save to file
        filepath = self.extracts_dir / f"{email.replace('@', '_at_')}.json"
        filepath.write_text(json.dumps(data, indent=2))
    
    def get_extracted_data(self, email: str) -> Optional[Dict]:
        """Get extracted data for account"""
        if email in self.extracted_accounts:
            return self.extracted_accounts[email]
        
        # Try loading from file
        filepath = self.extracts_dir / f"{email.replace('@', '_at_')}.json"
        if filepath.exists():
            data = json.loads(filepath.read_text())
            self.extracted_accounts[email] = data
            return data
        
        return None
    
    def log(self, message: str):
        """Add to extraction log"""
        timestamp = datetime.now().strftime('%H:%M:%S')
        self.extraction_log.append(f"[{timestamp}] {message}")
        if len(self.extraction_log) > 500:
            self.extraction_log = self.extraction_log[-500:]


# Initialize store
store = DataStore()

# =============================================================================
# EXTRACTION WORKER
# =============================================================================

extraction_queue = queue.Queue()
extraction_results = queue.Queue()
extraction_running = False

def extraction_worker():
    """Background worker for account extraction"""
    global extraction_running
    
    if not EXTRACTOR_AVAILABLE:
        store.log("ERROR: Account extractor not available")
        return
    
    extraction_running = True
    extractor = AccountExtractor()
    extractor.set_log_callback(lambda msg: store.log(msg))
    
    while extraction_running:
        try:
            task = extraction_queue.get(timeout=1)
            if task is None:
                break
            
            email = task['email']
            password = task['password']
            server = task['server']
            proxy = task.get('proxy')
            
            store.log(f"Starting extraction: {email}")
            
            # Set proxy if provided
            if proxy:
                extractor.add_proxy(proxy['host'], proxy['port'], proxy.get('type', 'SOCKS5'))
            
            # Extract
            result = extractor.extract_account(email, password, server)
            
            # Convert to dict
            if result.extraction_success:
                data = {
                    'email': result.email,
                    'password': result.password,
                    'server': result.server,
                    'player_id': result.player_id,
                    'player_name': result.player_name,
                    'prestige': result.prestige,
                    'honor': result.honor,
                    'title': result.title,
                    'alliance_name': result.alliance_name,
                    'extraction_time': result.extraction_time,
                    'total_cities': result.total_cities,
                    'total_troops': result.total_troops,
                    'total_heroes': result.total_heroes,
                    'historic_heroes': result.historic_heroes,
                    'cities': [],
                    'items': [asdict(i) for i in result.items]
                }
                
                for city in result.cities:
                    city_data = {
                        'id': city.id,
                        'name': city.name,
                        'coords': city.coords,
                        'level': city.level,
                        'resources': asdict(city.resources),
                        'troops': asdict(city.troops),
                        'troops_total': city.troops.total(),
                        'heroes': [asdict(h) for h in city.heroes],
                        'buildings': [asdict(b) for b in city.buildings],
                        'research': [asdict(r) for r in city.research]
                    }
                    data['cities'].append(city_data)
                
                store.save_extracted_data(email, data)
                store.log(f"SUCCESS: {email} - {result.total_cities} cities, {result.total_troops} troops")
            else:
                store.log(f"FAILED: {email} - {result.extraction_error}")
            
            extraction_results.put({'email': email, 'success': result.extraction_success})
            
        except queue.Empty:
            continue
        except Exception as e:
            store.log(f"ERROR: {e}")


# =============================================================================
# FASTAPI APPLICATION
# =============================================================================

if FASTAPI_AVAILABLE:
    
    @asynccontextmanager
    async def lifespan(app: FastAPI):
        # Start extraction worker
        worker_thread = threading.Thread(target=extraction_worker, daemon=True)
        worker_thread.start()
        
        print("=" * 70)
        print("BORG TOOLKIT - Account Extractor UI")
        print("=" * 70)
        print(f"\nDashboard: http://localhost:{PORT}/")
        print("\nFeatures:")
        print("  - Add accounts (single or bulk CSV)")
        print("  - Extract data from Evony servers")
        print("  - View cities, troops, heroes, resources")
        print("  - Export to CSV/JSON")
        print("=" * 70)
        
        yield
        
        global extraction_running
        extraction_running = False
    
    app = FastAPI(
        title="Borg Account Extractor",
        version="2026.1.0",
        lifespan=lifespan
    )
    
    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_methods=["*"],
        allow_headers=["*"],
    )
    
    # =========================================================================
    # API ENDPOINTS
    # =========================================================================
    
    @app.get("/api/accounts")
    async def list_accounts():
        """List all account credentials"""
        accounts = []
        for cred in store.credentials:
            acc = {
                'email': cred['email'],
                'server': cred['server'],
                'status': cred['status'],
                'last_extract': cred.get('last_extract'),
                'has_data': cred['email'] in store.extracted_accounts or 
                           (store.extracts_dir / f"{cred['email'].replace('@', '_at_')}.json").exists()
            }
            accounts.append(acc)
        return {'accounts': accounts, 'total': len(accounts)}
    
    @app.post("/api/accounts")
    async def add_account(data: Dict):
        """Add single account"""
        email = data.get('email', '')
        password = data.get('password', '')
        server = data.get('server', 'cc2')
        
        if not email or not password:
            raise HTTPException(400, "Email and password required")
        
        store.add_credential(email, password, server)
        return {'success': True, 'email': email}
    
    @app.post("/api/accounts/bulk")
    async def add_accounts_bulk(data: Dict):
        """Add multiple accounts from CSV text"""
        csv_content = data.get('csv', '')
        count = store.add_credentials_from_csv(csv_content)
        return {'success': True, 'added': count}
    
    @app.delete("/api/accounts/{email}")
    async def delete_account(email: str):
        """Remove account"""
        store.remove_credential(email)
        return {'success': True}
    
    @app.post("/api/extract/{email}")
    async def start_extraction(email: str):
        """Start extraction for single account"""
        cred = next((c for c in store.credentials if c['email'] == email), None)
        if not cred:
            raise HTTPException(404, "Account not found")
        
        extraction_queue.put({
            'email': cred['email'],
            'password': cred['password'],
            'server': cred['server']
        })
        return {'success': True, 'message': 'Extraction queued'}
    
    @app.post("/api/extract/all")
    async def start_extraction_all():
        """Start extraction for all accounts"""
        count = 0
        for cred in store.credentials:
            extraction_queue.put({
                'email': cred['email'],
                'password': cred['password'],
                'server': cred['server']
            })
            count += 1
        return {'success': True, 'queued': count}
    
    @app.get("/api/data/{email}")
    async def get_account_data(email: str):
        """Get extracted data for account"""
        data = store.get_extracted_data(email)
        if not data:
            raise HTTPException(404, "No data extracted for this account")
        return data
    
    @app.get("/api/data/{email}/cities")
    async def get_cities(email: str):
        """Get cities for account"""
        data = store.get_extracted_data(email)
        if not data:
            raise HTTPException(404, "No data")
        return {'cities': data.get('cities', [])}
    
    @app.get("/api/data/{email}/troops")
    async def get_troops(email: str):
        """Get troops across all cities"""
        data = store.get_extracted_data(email)
        if not data:
            raise HTTPException(404, "No data")
        
        troops = []
        for city in data.get('cities', []):
            troops.append({
                'city_name': city['name'],
                'coords': city['coords'],
                'troops': city.get('troops', {}),
                'total': city.get('troops_total', 0)
            })
        return {'troops': troops}
    
    @app.get("/api/data/{email}/heroes")
    async def get_heroes(email: str):
        """Get all heroes"""
        data = store.get_extracted_data(email)
        if not data:
            raise HTTPException(404, "No data")
        
        heroes = []
        for city in data.get('cities', []):
            for hero in city.get('heroes', []):
                hero['city_name'] = city['name']
                heroes.append(hero)
        return {'heroes': heroes}
    
    @app.get("/api/log")
    async def get_log():
        """Get extraction log"""
        return {'log': store.extraction_log[-100:]}
    
    @app.get("/api/export/json")
    async def export_all_json():
        """Export all extracted data to JSON"""
        all_data = []
        for email in store.extracted_accounts:
            data = store.get_extracted_data(email)
            if data:
                all_data.append(data)
        
        filepath = DATA_DIR / f"export_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
        filepath.write_text(json.dumps(all_data, indent=2))
        return FileResponse(filepath, filename=filepath.name)
    
    @app.get("/api/export/csv")
    async def export_all_csv():
        """Export all to CSV"""
        filepath = DATA_DIR / f"export_{datetime.now().strftime('%Y%m%d_%H%M%S')}.csv"
        
        with open(filepath, 'w', newline='') as f:
            writer = csv.writer(f)
            writer.writerow(['email', 'password', 'server', 'player_name', 'city_name', 
                           'coords', 'level', 'troops', 'gold', 'food', 'heroes'])
            
            for email, data in store.extracted_accounts.items():
                for city in data.get('cities', []):
                    troops = city.get('troops', {})
                    troops_str = ",".join(f"{k}:{v}" for k, v in troops.items() if v > 0)
                    hero_names = ", ".join(h.get('name', '') for h in city.get('heroes', []))
                    res = city.get('resources', {})
                    
                    writer.writerow([
                        data.get('email'),
                        data.get('password'),
                        data.get('server'),
                        data.get('player_name'),
                        city.get('name'),
                        city.get('coords'),
                        city.get('level'),
                        troops_str,
                        res.get('gold', 0),
                        res.get('food', 0),
                        hero_names
                    ])
        
        return FileResponse(filepath, filename=filepath.name)
    
    # =========================================================================
    # WEB DASHBOARD
    # =========================================================================
    
    @app.get("/", response_class=HTMLResponse)
    async def dashboard():
        """Main dashboard"""
        accounts = store.credentials
        extracted_count = len(store.extracted_accounts)
        
        html = f"""
<!DOCTYPE html>
<html>
<head>
    <title>Borg Account Extractor</title>
    <style>
        * {{ margin: 0; padding: 0; box-sizing: border-box; }}
        body {{ 
            font-family: 'Segoe UI', sans-serif; 
            background: linear-gradient(135deg, #0f0f23 0%, #1a1a3e 100%);
            color: #e0e0e0;
            min-height: 100vh;
        }}
        .header {{
            background: rgba(0,0,0,0.4);
            padding: 20px;
            text-align: center;
            border-bottom: 2px solid #ff6600;
        }}
        .header h1 {{ color: #ff6600; font-size: 2em; }}
        .container {{ max-width: 1600px; margin: 0 auto; padding: 20px; }}
        .tabs {{
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }}
        .tab {{
            padding: 12px 24px;
            background: rgba(255,102,0,0.2);
            border: 1px solid #ff6600;
            border-radius: 8px;
            cursor: pointer;
            color: #ff6600;
            font-weight: bold;
        }}
        .tab.active {{ background: #ff6600; color: white; }}
        .tab:hover {{ opacity: 0.8; }}
        .panel {{ display: none; }}
        .panel.active {{ display: block; }}
        .card {{
            background: rgba(255,255,255,0.05);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            border: 1px solid rgba(255,102,0,0.2);
        }}
        .card h2 {{ color: #ff6600; margin-bottom: 15px; border-bottom: 1px solid rgba(255,102,0,0.3); padding-bottom: 10px; }}
        input, textarea, select {{
            width: 100%;
            padding: 12px;
            margin: 8px 0;
            background: rgba(0,0,0,0.3);
            border: 1px solid rgba(255,102,0,0.3);
            border-radius: 6px;
            color: white;
            font-size: 14px;
        }}
        button {{
            padding: 12px 24px;
            background: linear-gradient(135deg, #ff6600, #cc5200);
            border: none;
            border-radius: 6px;
            color: white;
            font-weight: bold;
            cursor: pointer;
            margin: 5px;
        }}
        button:hover {{ opacity: 0.8; }}
        button.secondary {{ background: rgba(255,255,255,0.1); border: 1px solid #666; }}
        table {{ width: 100%; border-collapse: collapse; }}
        th, td {{ padding: 12px; text-align: left; border-bottom: 1px solid rgba(255,255,255,0.1); }}
        th {{ color: #ff6600; }}
        .status-extracted {{ color: #00ff88; }}
        .status-pending {{ color: #ffaa00; }}
        .status-failed {{ color: #ff4444; }}
        .grid {{ display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; }}
        .stat-box {{
            background: rgba(0,0,0,0.3);
            padding: 20px;
            border-radius: 8px;
            text-align: center;
        }}
        .stat-value {{ font-size: 2em; color: #ff6600; font-weight: bold; }}
        .stat-label {{ color: #888; margin-top: 5px; }}
        .log-box {{
            background: #000;
            padding: 15px;
            border-radius: 8px;
            max-height: 300px;
            overflow-y: auto;
            font-family: monospace;
            font-size: 12px;
        }}
        .account-selector {{
            padding: 10px;
            margin-bottom: 20px;
            font-size: 16px;
        }}
        .troop-grid {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 10px;
        }}
        .troop-item {{
            background: rgba(0,0,0,0.3);
            padding: 15px;
            border-radius: 8px;
            text-align: center;
        }}
        .troop-count {{ font-size: 1.5em; color: #00ff88; }}
        .hero-card {{
            background: rgba(255,215,0,0.1);
            border: 1px solid rgba(255,215,0,0.3);
            padding: 15px;
            border-radius: 8px;
            margin: 10px 0;
        }}
        .hero-historic {{ border-color: #ffd700; background: rgba(255,215,0,0.2); }}
    </style>
</head>
<body>
    <div class="header">
        <h1>🔐 BORG ACCOUNT EXTRACTOR</h1>
        <div style="color:#888;margin-top:5px;">Direct Evony Server Connection & Data Extraction</div>
    </div>
    
    <div class="container">
        <!-- Stats Overview -->
        <div class="grid" style="margin-bottom:20px;">
            <div class="stat-box">
                <div class="stat-value" id="stat-accounts">{len(accounts)}</div>
                <div class="stat-label">Accounts Added</div>
            </div>
            <div class="stat-box">
                <div class="stat-value" id="stat-extracted">{extracted_count}</div>
                <div class="stat-label">Data Extracted</div>
            </div>
            <div class="stat-box">
                <div class="stat-value" id="stat-pending">{len([a for a in accounts if a.get('status') == 'pending'])}</div>
                <div class="stat-label">Pending</div>
            </div>
        </div>
        
        <!-- Tabs -->
        <div class="tabs">
            <div class="tab active" onclick="showPanel('accounts')">📋 Accounts</div>
            <div class="tab" onclick="showPanel('add')">➕ Add Accounts</div>
            <div class="tab" onclick="showPanel('viewer')">👁️ Data Viewer</div>
            <div class="tab" onclick="showPanel('troops')">⚔️ Troops</div>
            <div class="tab" onclick="showPanel('heroes')">🦸 Heroes</div>
            <div class="tab" onclick="showPanel('export')">💾 Export</div>
            <div class="tab" onclick="showPanel('log')">📜 Log</div>
        </div>
        
        <!-- Accounts Panel -->
        <div class="panel active" id="panel-accounts">
            <div class="card">
                <h2>📋 Account List</h2>
                <button onclick="extractAll()">🚀 Extract All Accounts</button>
                <button class="secondary" onclick="refreshAccounts()">🔄 Refresh</button>
                <table id="accounts-table" style="margin-top:15px;">
                    <thead>
                        <tr><th>Email</th><th>Server</th><th>Status</th><th>Last Extract</th><th>Actions</th></tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
        
        <!-- Add Accounts Panel -->
        <div class="panel" id="panel-add">
            <div class="grid">
                <div class="card">
                    <h2>➕ Add Single Account</h2>
                    <input type="email" id="add-email" placeholder="Email">
                    <input type="password" id="add-password" placeholder="Password">
                    <select id="add-server">
                        <option value="cc2">cc2.evony.com</option>
                        <option value="cc1">cc1.evony.com</option>
                        <option value="cc3">cc3.evony.com</option>
                        <option value="na1">na1.evony.com</option>
                        <option value="ss1">ss1.evony.com</option>
                    </select>
                    <button onclick="addAccount()">Add Account</button>
                </div>
                <div class="card">
                    <h2>📄 Bulk Import (CSV)</h2>
                    <textarea id="bulk-csv" rows="10" placeholder="email,password,server&#10;user1@test.com,pass123,cc2&#10;user2@test.com,pass456,cc2"></textarea>
                    <button onclick="bulkImport()">Import CSV</button>
                </div>
            </div>
        </div>
        
        <!-- Data Viewer Panel -->
        <div class="panel" id="panel-viewer">
            <div class="card">
                <h2>👁️ Account Data Viewer</h2>
                <select class="account-selector" id="viewer-account" onchange="loadAccountData()">
                    <option value="">-- Select Account --</option>
                </select>
                <div id="viewer-content">
                    <p style="color:#888;">Select an account to view data</p>
                </div>
            </div>
        </div>
        
        <!-- Troops Panel -->
        <div class="panel" id="panel-troops">
            <div class="card">
                <h2>⚔️ Troops Overview</h2>
                <select class="account-selector" id="troops-account" onchange="loadTroops()">
                    <option value="">-- Select Account --</option>
                </select>
                <div id="troops-content"></div>
            </div>
        </div>
        
        <!-- Heroes Panel -->
        <div class="panel" id="panel-heroes">
            <div class="card">
                <h2>🦸 Heroes</h2>
                <select class="account-selector" id="heroes-account" onchange="loadHeroes()">
                    <option value="">-- Select Account --</option>
                </select>
                <div id="heroes-content"></div>
            </div>
        </div>
        
        <!-- Export Panel -->
        <div class="panel" id="panel-export">
            <div class="card">
                <h2>💾 Export Data</h2>
                <p style="margin-bottom:20px;color:#888;">Export all extracted account data</p>
                <button onclick="exportJSON()">📥 Export JSON</button>
                <button onclick="exportCSV()">📥 Export CSV</button>
            </div>
        </div>
        
        <!-- Log Panel -->
        <div class="panel" id="panel-log">
            <div class="card">
                <h2>📜 Extraction Log</h2>
                <button class="secondary" onclick="refreshLog()">🔄 Refresh</button>
                <div class="log-box" id="log-content"></div>
            </div>
        </div>
    </div>
    
    <script>
        function showPanel(name) {{
            document.querySelectorAll('.panel').forEach(p => p.classList.remove('active'));
            document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
            document.getElementById('panel-' + name).classList.add('active');
            event.target.classList.add('active');
            
            if (name === 'viewer' || name === 'troops' || name === 'heroes') {{
                refreshAccountSelectors();
            }}
            if (name === 'log') refreshLog();
        }}
        
        async function refreshAccounts() {{
            const resp = await fetch('/api/accounts');
            const data = await resp.json();
            
            const tbody = document.querySelector('#accounts-table tbody');
            tbody.innerHTML = '';
            
            data.accounts.forEach(acc => {{
                const statusClass = acc.has_data ? 'status-extracted' : 
                                   (acc.status === 'pending' ? 'status-pending' : 'status-failed');
                const statusText = acc.has_data ? '✓ Extracted' : acc.status;
                
                tbody.innerHTML += `
                    <tr>
                        <td>${{acc.email}}</td>
                        <td>${{acc.server}}</td>
                        <td class="${{statusClass}}">${{statusText}}</td>
                        <td>${{acc.last_extract || '-'}}</td>
                        <td>
                            <button onclick="extractOne('${{acc.email}}')">Extract</button>
                            <button class="secondary" onclick="viewAccount('${{acc.email}}')">View</button>
                            <button class="secondary" onclick="deleteAccount('${{acc.email}}')">✕</button>
                        </td>
                    </tr>
                `;
            }});
            
            document.getElementById('stat-accounts').textContent = data.total;
        }}
        
        async function refreshAccountSelectors() {{
            const resp = await fetch('/api/accounts');
            const data = await resp.json();
            
            const options = data.accounts
                .filter(a => a.has_data)
                .map(a => `<option value="${{a.email}}">${{a.email}} (${{a.server}})</option>`)
                .join('');
            
            ['viewer-account', 'troops-account', 'heroes-account'].forEach(id => {{
                document.getElementById(id).innerHTML = '<option value="">-- Select Account --</option>' + options;
            }});
        }}
        
        async function addAccount() {{
            const email = document.getElementById('add-email').value;
            const password = document.getElementById('add-password').value;
            const server = document.getElementById('add-server').value;
            
            await fetch('/api/accounts', {{
                method: 'POST',
                headers: {{'Content-Type': 'application/json'}},
                body: JSON.stringify({{email, password, server}})
            }});
            
            document.getElementById('add-email').value = '';
            document.getElementById('add-password').value = '';
            refreshAccounts();
        }}
        
        async function bulkImport() {{
            const csv = document.getElementById('bulk-csv').value;
            const resp = await fetch('/api/accounts/bulk', {{
                method: 'POST',
                headers: {{'Content-Type': 'application/json'}},
                body: JSON.stringify({{csv}})
            }});
            const data = await resp.json();
            alert('Imported ' + data.added + ' accounts');
            document.getElementById('bulk-csv').value = '';
            refreshAccounts();
        }}
        
        async function extractOne(email) {{
            await fetch('/api/extract/' + encodeURIComponent(email), {{method: 'POST'}});
            alert('Extraction started for ' + email);
        }}
        
        async function extractAll() {{
            const resp = await fetch('/api/extract/all', {{method: 'POST'}});
            const data = await resp.json();
            alert('Queued ' + data.queued + ' accounts for extraction');
        }}
        
        async function deleteAccount(email) {{
            if (confirm('Delete ' + email + '?')) {{
                await fetch('/api/accounts/' + encodeURIComponent(email), {{method: 'DELETE'}});
                refreshAccounts();
            }}
        }}
        
        function viewAccount(email) {{
            showPanel('viewer');
            document.getElementById('viewer-account').value = email;
            loadAccountData();
        }}
        
        async function loadAccountData() {{
            const email = document.getElementById('viewer-account').value;
            if (!email) return;
            
            const resp = await fetch('/api/data/' + encodeURIComponent(email));
            if (!resp.ok) {{
                document.getElementById('viewer-content').innerHTML = '<p style="color:red;">No data available</p>';
                return;
            }}
            
            const data = await resp.json();
            
            let html = `
                <div class="grid">
                    <div class="stat-box"><div class="stat-value">${{data.player_name}}</div><div class="stat-label">Player Name</div></div>
                    <div class="stat-box"><div class="stat-value">${{data.total_cities}}</div><div class="stat-label">Cities</div></div>
                    <div class="stat-box"><div class="stat-value">${{data.total_troops?.toLocaleString()}}</div><div class="stat-label">Total Troops</div></div>
                    <div class="stat-box"><div class="stat-value">${{data.total_heroes}}</div><div class="stat-label">Heroes</div></div>
                </div>
                <h3 style="margin:20px 0 10px;color:#ff6600;">Cities</h3>
            `;
            
            data.cities?.forEach(city => {{
                const res = city.resources || {{}};
                html += `
                    <div style="background:rgba(0,0,0,0.3);padding:15px;margin:10px 0;border-radius:8px;">
                        <strong style="color:#ff6600;">${{city.name}}</strong> @ ${{city.coords}} (Level ${{city.level}})
                        <div style="margin-top:10px;font-size:0.9em;">
                            Gold: ${{res.gold?.toLocaleString() || 0}} | 
                            Food: ${{res.food?.toLocaleString() || 0}} | 
                            Wood: ${{res.wood?.toLocaleString() || 0}} | 
                            Stone: ${{res.stone?.toLocaleString() || 0}} | 
                            Iron: ${{res.iron?.toLocaleString() || 0}}
                        </div>
                        <div style="margin-top:5px;color:#00ff88;">Troops: ${{city.troops_total?.toLocaleString() || 0}}</div>
                    </div>
                `;
            }});
            
            document.getElementById('viewer-content').innerHTML = html;
        }}
        
        async function loadTroops() {{
            const email = document.getElementById('troops-account').value;
            if (!email) return;
            
            const resp = await fetch('/api/data/' + encodeURIComponent(email) + '/troops');
            const data = await resp.json();
            
            let html = '';
            data.troops?.forEach(city => {{
                const t = city.troops || {{}};
                html += `
                    <h3 style="margin:15px 0;color:#ff6600;">${{city.city_name}} @ ${{city.coords}}</h3>
                    <div class="troop-grid">
                        <div class="troop-item"><div class="troop-count">${{t.workers?.toLocaleString() || 0}}</div><div>Workers</div></div>
                        <div class="troop-item"><div class="troop-count">${{t.warriors?.toLocaleString() || 0}}</div><div>Warriors</div></div>
                        <div class="troop-item"><div class="troop-count">${{t.scouts?.toLocaleString() || 0}}</div><div>Scouts</div></div>
                        <div class="troop-item"><div class="troop-count">${{t.pikemen?.toLocaleString() || 0}}</div><div>Pikemen</div></div>
                        <div class="troop-item"><div class="troop-count">${{t.swordsmen?.toLocaleString() || 0}}</div><div>Swordsmen</div></div>
                        <div class="troop-item"><div class="troop-count">${{t.archers?.toLocaleString() || 0}}</div><div>Archers</div></div>
                        <div class="troop-item"><div class="troop-count">${{t.cavalry?.toLocaleString() || 0}}</div><div>Cavalry</div></div>
                        <div class="troop-item"><div class="troop-count">${{t.cataphracts?.toLocaleString() || 0}}</div><div>Cataphracts</div></div>
                        <div class="troop-item"><div class="troop-count">${{t.transporters?.toLocaleString() || 0}}</div><div>Transporters</div></div>
                        <div class="troop-item"><div class="troop-count">${{t.ballistas?.toLocaleString() || 0}}</div><div>Ballistas</div></div>
                        <div class="troop-item"><div class="troop-count">${{t.rams?.toLocaleString() || 0}}</div><div>Rams</div></div>
                        <div class="troop-item"><div class="troop-count">${{t.catapults?.toLocaleString() || 0}}</div><div>Catapults</div></div>
                    </div>
                `;
            }});
            
            document.getElementById('troops-content').innerHTML = html || '<p>No troop data</p>';
        }}
        
        async function loadHeroes() {{
            const email = document.getElementById('heroes-account').value;
            if (!email) return;
            
            const resp = await fetch('/api/data/' + encodeURIComponent(email) + '/heroes');
            const data = await resp.json();
            
            let html = '';
            data.heroes?.forEach(h => {{
                const isHistoric = h.is_historic ? 'hero-historic' : '';
                html += `
                    <div class="hero-card ${{isHistoric}}">
                        <strong style="color:#ffd700;">${{h.name}}</strong> ${{h.is_historic ? '⭐ HISTORIC' : ''}}
                        <div style="margin-top:10px;font-size:0.9em;">
                            Level: ${{h.level}} | ATK: ${{h.attack}} | DEF: ${{h.defense}} | POL: ${{h.politics}} | INT: ${{h.intelligence}}
                        </div>
                        <div style="color:#888;font-size:0.8em;">City: ${{h.city_name}} | Status: ${{h.status}}</div>
                    </div>
                `;
            }});
            
            document.getElementById('heroes-content').innerHTML = html || '<p>No heroes found</p>';
        }}
        
        async function refreshLog() {{
            const resp = await fetch('/api/log');
            const data = await resp.json();
            document.getElementById('log-content').innerHTML = data.log.map(l => `<div>${{l}}</div>`).join('');
        }}
        
        function exportJSON() {{
            window.location.href = '/api/export/json';
        }}
        
        function exportCSV() {{
            window.location.href = '/api/export/csv';
        }}
        
        // Initial load
        refreshAccounts();
        setInterval(refreshLog, 5000);
    </script>
</body>
</html>
        """
        return HTMLResponse(content=html)


# =============================================================================
# MAIN
# =============================================================================

def main():
    if not FASTAPI_AVAILABLE:
        print("ERROR: FastAPI not installed")
        print("Run: pip install fastapi uvicorn python-multipart")
        return
    
    uvicorn.run(app, host=HOST, port=PORT)


if __name__ == "__main__":
    main()
