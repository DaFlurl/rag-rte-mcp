#!/usr/bin/env python3
"""
BORG TOOLKIT - Account Import Manager
=====================================
Web UI for importing, validating, and managing accounts from multiple sources
"""

import json
import asyncio
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional
import threading
import time

try:
    from fastapi import FastAPI, Request, UploadFile, File, Form, BackgroundTasks
    from fastapi.responses import HTMLResponse, JSONResponse, FileResponse
    from fastapi.middleware.cors import CORSMiddleware
    import uvicorn
    FASTAPI_AVAILABLE = True
except ImportError:
    FASTAPI_AVAILABLE = False
    print("[!] FastAPI not installed. Run: pip install fastapi uvicorn python-multipart")

from src.account_importer import AccountImporter, LoginValidator, AccountCredential

# Configuration
HOST = "0.0.0.0"
PORT = 8091
DATA_DIR = Path(__file__).parent / "data" / "accounts"
DATA_DIR.mkdir(parents=True, exist_ok=True)

# Known account directories to scan
ACCOUNT_DIRECTORIES = [
    Path(r"C:\Users\Admin\Downloads\Evony_Decrypted\Accounts"),
    Path(r"C:\Users\Admin\Downloads\Evony_Decrypted\Scripts\khan_Accounts_556"),
    Path(r"C:\Users\Admin\Downloads\Evony_Decrypted\SOL_Accounts"),
    Path(r"C:\Users\Admin\Downloads\Evony_Decrypted\checkme"),
]

# Global state
importer: Optional[AccountImporter] = None
validator: Optional[LoginValidator] = None
validation_progress = {"running": False, "current": "", "progress": 0, "total": 0, "done": 0}

app = FastAPI(title="Borg Import Manager", version="2026.1.0")
app.add_middleware(CORSMiddleware, allow_origins=["*"], allow_methods=["*"], allow_headers=["*"])


def get_html():
    return '''<!DOCTYPE html>
<html><head>
<meta charset="UTF-8"><title>Borg Import Manager</title>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:'Segoe UI',sans-serif;background:linear-gradient(135deg,#0f0f23,#1a1a3e);color:#eee;min-height:100vh}
.header{background:rgba(0,0,0,0.5);padding:20px;text-align:center;border-bottom:3px solid #4ecca3}
.header h1{color:#4ecca3;font-size:2em}
.container{max-width:1400px;margin:0 auto;padding:20px}
.grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(400px,1fr));gap:20px}
.card{background:rgba(255,255,255,0.05);border-radius:10px;padding:20px;border:1px solid rgba(78,204,163,0.2)}
.card h2{color:#4ecca3;margin-bottom:15px;font-size:1.2em}
.stat-grid{display:grid;grid-template-columns:repeat(5,1fr);gap:10px;margin-bottom:20px}
.stat{background:rgba(0,0,0,0.3);padding:15px;border-radius:8px;text-align:center}
.stat .val{font-size:2em;color:#4ecca3;font-weight:bold}
.stat .label{color:#888;font-size:0.85em}
.stat.pending .val{color:#f0ad4e}
.stat.active .val{color:#5cb85c}
.stat.failed .val{color:#d9534f}
button{padding:10px 20px;border:none;border-radius:5px;cursor:pointer;font-size:1em;margin:5px}
.btn-primary{background:#4ecca3;color:#000}
.btn-primary:hover{background:#3db892}
.btn-danger{background:#d9534f;color:#fff}
.btn-warning{background:#f0ad4e;color:#000}
.btn-secondary{background:#555;color:#fff}
input,select,textarea{padding:10px;border:1px solid #333;border-radius:5px;background:#1a1a2e;color:#eee;width:100%;margin-bottom:10px}
table{width:100%;border-collapse:collapse;margin-top:10px}
th,td{padding:10px;text-align:left;border-bottom:1px solid rgba(255,255,255,0.1)}
th{background:rgba(78,204,163,0.2);color:#4ecca3}
tr:hover{background:rgba(255,255,255,0.05)}
.status{padding:3px 8px;border-radius:10px;font-size:0.8em}
.status.pending{background:#f0ad4e;color:#000}
.status.active{background:#5cb85c;color:#fff}
.status.failed{background:#d9534f;color:#fff}
.status.extracted{background:#5bc0de;color:#000}
.progress-bar{height:20px;background:#333;border-radius:10px;overflow:hidden;margin:10px 0}
.progress-fill{height:100%;background:linear-gradient(90deg,#4ecca3,#3db892);transition:width 0.3s}
.log{background:#000;padding:10px;border-radius:5px;max-height:200px;overflow-y:auto;font-family:monospace;font-size:0.85em}
.dirs{display:flex;flex-wrap:wrap;gap:5px;margin-bottom:10px}
.dir-chip{background:rgba(78,204,163,0.2);padding:5px 10px;border-radius:15px;font-size:0.85em}
.tabs{display:flex;gap:5px;margin-bottom:15px}
.tab{padding:10px 20px;background:rgba(0,0,0,0.3);border:none;color:#888;cursor:pointer;border-radius:5px 5px 0 0}
.tab.active{background:rgba(78,204,163,0.2);color:#4ecca3}
.tab-content{display:none}
.tab-content.active{display:block}
.upload-zone{border:2px dashed #4ecca3;padding:30px;text-align:center;border-radius:10px;margin-bottom:15px}
.upload-zone:hover{background:rgba(78,204,163,0.1)}
#accountsTable{max-height:400px;overflow-y:auto}
</style>
</head>
<body>
<div class="header">
<h1>🔐 Borg Account Import Manager</h1>
<div style="color:#888">Multi-format importer with login validation</div>
</div>
<div class="container">

<div class="stat-grid">
<div class="stat"><div class="val" id="statTotal">0</div><div class="label">Total</div></div>
<div class="stat pending"><div class="val" id="statPending">0</div><div class="label">Pending</div></div>
<div class="stat active"><div class="val" id="statActive">0</div><div class="label">Active</div></div>
<div class="stat failed"><div class="val" id="statFailed">0</div><div class="label">Failed</div></div>
<div class="stat"><div class="val" id="statExtracted">0</div><div class="label">Extracted</div></div>
</div>

<div class="grid">
<div class="card">
<h2>📁 Import Sources</h2>
<div class="dirs" id="knownDirs"></div>
<button class="btn-primary" onclick="scanAll()">🔍 Scan All Known Directories</button>
<button class="btn-secondary" onclick="scanCustom()">📂 Scan Custom Directory</button>
<hr style="margin:15px 0;border-color:#333">
<div class="upload-zone" onclick="document.getElementById('fileInput').click()">
<div style="font-size:2em">📄</div>
<div>Click to upload account files</div>
<div style="color:#888;font-size:0.85em">CSV, TXT, JSON, XLSX, RTF, PDF</div>
<input type="file" id="fileInput" style="display:none" multiple accept=".csv,.txt,.json,.xlsx,.xls,.rtf,.pdf" onchange="uploadFiles(this.files)">
</div>
</div>

<div class="card">
<h2>✅ Login Validation</h2>
<div id="validationStatus">
<p>Validates pending accounts with retry logic (3-5 attempts per account)</p>
</div>
<div class="progress-bar"><div class="progress-fill" id="progressFill" style="width:0%"></div></div>
<div id="progressText" style="text-align:center;color:#888">Ready</div>
<div style="margin-top:15px">
<button class="btn-primary" onclick="startValidation()" id="btnValidate">▶️ Start Validation</button>
<button class="btn-danger" onclick="stopValidation()" id="btnStop" disabled>⏹️ Stop</button>
<select id="retryCount" style="width:auto;display:inline-block">
<option value="3">3 retries</option>
<option value="5" selected>5 retries</option>
<option value="7">7 retries</option>
</select>
</div>
</div>
</div>

<div class="card" style="margin-top:20px">
<div class="tabs">
<button class="tab active" onclick="showTab('all')">All Accounts</button>
<button class="tab" onclick="showTab('pending')">Pending</button>
<button class="tab" onclick="showTab('active')">Active</button>
<button class="tab" onclick="showTab('failed')">Failed</button>
</div>
<div style="margin-bottom:10px">
<input type="text" id="searchInput" placeholder="Search accounts..." onkeyup="filterTable()">
</div>
<div id="accountsTable">
<table id="accTable">
<thead><tr><th>Email</th><th>Password</th><th>Status</th><th>Player</th><th>Attempts</th><th>Actions</th></tr></thead>
<tbody id="accBody"></tbody>
</table>
</div>
<div style="margin-top:15px">
<button class="btn-secondary" onclick="exportActive()">📥 Export Active CSV</button>
<button class="btn-secondary" onclick="exportFailed()">📥 Export Failed TXT</button>
<button class="btn-secondary" onclick="exportAll()">📥 Export All CSV</button>
</div>
</div>

<div class="card" style="margin-top:20px">
<h2>📝 Import Log</h2>
<div class="log" id="logOutput"></div>
</div>

</div>

<script>
let currentFilter = 'all';
let accounts = [];

async function api(endpoint, method='GET', body=null) {
    const opts = {method, headers: {'Content-Type': 'application/json'}};
    if (body) opts.body = JSON.stringify(body);
    const res = await fetch('/api/' + endpoint, opts);
    return res.json();
}

async function refreshStats() {
    const stats = await api('stats');
    document.getElementById('statTotal').textContent = stats.total;
    document.getElementById('statPending').textContent = stats.pending;
    document.getElementById('statActive').textContent = stats.active;
    document.getElementById('statFailed').textContent = stats.failed;
    document.getElementById('statExtracted').textContent = stats.extracted;
}

async function refreshAccounts() {
    accounts = await api('accounts');
    renderTable();
}

function renderTable() {
    const search = document.getElementById('searchInput').value.toLowerCase();
    const filtered = accounts.filter(a => {
        if (currentFilter !== 'all' && a.status !== currentFilter) return false;
        if (search && !a.email.toLowerCase().includes(search)) return false;
        return true;
    });
    
    const tbody = document.getElementById('accBody');
    tbody.innerHTML = filtered.slice(0, 200).map(a => `
        <tr>
            <td>${a.email}</td>
            <td><input type="text" value="${a.password}" style="width:150px" onchange="updatePassword('${a.email}', this.value)"></td>
            <td><span class="status ${a.status}">${a.status}</span></td>
            <td>${a.player_name || '-'}</td>
            <td>${a.login_attempts}</td>
            <td>
                <button class="btn-secondary" style="padding:5px 10px" onclick="retryAccount('${a.email}')">🔄</button>
                <button class="btn-danger" style="padding:5px 10px" onclick="deleteAccount('${a.email}')">🗑️</button>
            </td>
        </tr>
    `).join('');
}

function showTab(filter) {
    currentFilter = filter;
    document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
    event.target.classList.add('active');
    renderTable();
}

function filterTable() { renderTable(); }

async function scanAll() {
    addLog('Scanning all known directories...');
    const result = await api('scan-all', 'POST');
    addLog(`Imported ${result.imported} accounts (${result.duplicates} duplicates)`);
    refreshStats();
    refreshAccounts();
}

async function scanCustom() {
    const dir = prompt('Enter directory path to scan:');
    if (dir) {
        addLog(`Scanning ${dir}...`);
        const result = await api('scan', 'POST', {directory: dir});
        addLog(`Imported ${result.imported} accounts (${result.duplicates} duplicates)`);
        refreshStats();
        refreshAccounts();
    }
}

async function uploadFiles(files) {
    for (const file of files) {
        const formData = new FormData();
        formData.append('file', file);
        addLog(`Uploading ${file.name}...`);
        const res = await fetch('/api/upload', {method: 'POST', body: formData});
        const result = await res.json();
        addLog(`Imported ${result.imported} accounts from ${file.name}`);
    }
    refreshStats();
    refreshAccounts();
}

async function startValidation() {
    const retries = document.getElementById('retryCount').value;
    document.getElementById('btnValidate').disabled = true;
    document.getElementById('btnStop').disabled = false;
    addLog('Starting validation...');
    await api('validate/start', 'POST', {max_retries: parseInt(retries)});
    pollProgress();
}

async function stopValidation() {
    await api('validate/stop', 'POST');
    document.getElementById('btnValidate').disabled = false;
    document.getElementById('btnStop').disabled = true;
    addLog('Validation stopped');
}

async function pollProgress() {
    const p = await api('validate/progress');
    document.getElementById('progressFill').style.width = (p.progress * 100) + '%';
    document.getElementById('progressText').textContent = p.running ? 
        `${p.done}/${p.total} - ${p.current}` : 'Complete';
    
    if (p.running) {
        setTimeout(pollProgress, 1000);
    } else {
        document.getElementById('btnValidate').disabled = false;
        document.getElementById('btnStop').disabled = true;
        refreshStats();
        refreshAccounts();
    }
}

async function updatePassword(email, password) {
    await api('account/update', 'POST', {email, password});
    addLog(`Updated password for ${email}`);
}

async function retryAccount(email) {
    await api('account/retry', 'POST', {email});
    addLog(`Reset ${email} for retry`);
    refreshAccounts();
}

async function deleteAccount(email) {
    if (confirm(`Delete ${email}?`)) {
        await api('account/delete', 'POST', {email});
        refreshAccounts();
    }
}

async function exportActive() {
    window.location.href = '/api/export/active';
}

async function exportFailed() {
    window.location.href = '/api/export/failed';
}

async function exportAll() {
    window.location.href = '/api/export/all';
}

function addLog(msg) {
    const log = document.getElementById('logOutput');
    const ts = new Date().toLocaleTimeString();
    log.innerHTML += `[${ts}] ${msg}\\n`;
    log.scrollTop = log.scrollHeight;
}

async function loadKnownDirs() {
    const dirs = await api('directories');
    document.getElementById('knownDirs').innerHTML = dirs.map(d => 
        `<span class="dir-chip" title="${d.path}">${d.name} (${d.exists ? '✓' : '✗'})</span>`
    ).join('');
}

// Init
refreshStats();
refreshAccounts();
loadKnownDirs();
setInterval(refreshStats, 10000);
</script>
</body></html>'''


@app.get("/", response_class=HTMLResponse)
async def index():
    return get_html()


@app.get("/api/stats")
async def get_stats():
    return importer.get_stats()


@app.get("/api/accounts")
async def get_accounts():
    return [acc.to_dict() for acc in importer.accounts.values()]


@app.get("/api/directories")
async def get_directories():
    return [{"name": d.name, "path": str(d), "exists": d.exists()} for d in ACCOUNT_DIRECTORIES]


@app.post("/api/scan-all")
async def scan_all():
    total_imported = 0
    total_dupes = 0
    for directory in ACCOUNT_DIRECTORIES:
        if directory.exists():
            imported, dupes = importer.import_directory(directory)
            total_imported += imported
            total_dupes += dupes
    return {"imported": total_imported, "duplicates": total_dupes}


@app.post("/api/scan")
async def scan_directory(data: dict):
    directory = Path(data.get("directory", ""))
    if directory.exists():
        imported, dupes = importer.import_directory(directory)
        return {"imported": imported, "duplicates": dupes}
    return {"imported": 0, "duplicates": 0, "error": "Directory not found"}


@app.post("/api/upload")
async def upload_file(file: UploadFile = File(...)):
    temp_path = DATA_DIR / file.filename
    content = await file.read()
    temp_path.write_bytes(content)
    imported, dupes = importer.import_file(temp_path)
    return {"imported": imported, "duplicates": dupes}


@app.post("/api/validate/start")
async def start_validation(data: dict, background_tasks: BackgroundTasks):
    global validator, validation_progress
    
    max_retries = data.get("max_retries", 5)
    validator = LoginValidator(importer, max_retries=max_retries, retry_delay=3.0)
    
    def run_validation():
        global validation_progress
        validation_progress["running"] = True
        pending = importer.get_pending_accounts()
        validation_progress["total"] = len(pending)
        validation_progress["done"] = 0
        
        for acc in pending:
            if not validator.running:
                validator._stop_event.set()
            if validator._stop_event.is_set():
                break
            validation_progress["current"] = acc.email
            validator.validate_account(acc)
            validation_progress["done"] += 1
            validation_progress["progress"] = validation_progress["done"] / validation_progress["total"]
        
        validation_progress["running"] = False
    
    validator.running = True
    background_tasks.add_task(run_validation)
    return {"status": "started"}


@app.post("/api/validate/stop")
async def stop_validation():
    global validator
    if validator:
        validator.stop()
    return {"status": "stopped"}


@app.get("/api/validate/progress")
async def get_progress():
    return validation_progress


@app.post("/api/account/update")
async def update_account(data: dict):
    email = data.get("email", "").lower()
    password = data.get("password", "")
    if email in importer.accounts:
        importer.accounts[email].password = password
        importer._save_master()
    return {"status": "ok"}


@app.post("/api/account/retry")
async def retry_account(data: dict):
    email = data.get("email", "").lower()
    if email in importer.accounts:
        importer.accounts[email].status = "pending"
        importer.accounts[email].login_attempts = 0
        importer._save_master()
    return {"status": "ok"}


@app.post("/api/account/delete")
async def delete_account(data: dict):
    email = data.get("email", "").lower()
    if email in importer.accounts:
        del importer.accounts[email]
        importer._save_master()
    return {"status": "ok"}


@app.get("/api/export/active")
async def export_active():
    filepath = DATA_DIR / f"active_accounts_{datetime.now().strftime('%Y%m%d_%H%M%S')}.csv"
    importer.export_active_csv(filepath)
    return FileResponse(filepath, filename=filepath.name, media_type="text/csv")


@app.get("/api/export/failed")
async def export_failed():
    importer._save_failed()
    return FileResponse(importer.failed_file, filename="failed_accounts.txt", media_type="text/plain")


@app.get("/api/export/all")
async def export_all():
    filepath = DATA_DIR / f"all_accounts_{datetime.now().strftime('%Y%m%d_%H%M%S')}.csv"
    importer.export_all_csv(filepath)
    return FileResponse(filepath, filename=filepath.name, media_type="text/csv")


def main():
    global importer
    
    print("=" * 60)
    print("  BORG TOOLKIT - Account Import Manager")
    print("=" * 60)
    
    importer = AccountImporter(DATA_DIR)
    stats = importer.get_stats()
    print(f"\nLoaded {stats['total']} existing accounts")
    print(f"  Pending: {stats['pending']}")
    print(f"  Active:  {stats['active']}")
    print(f"  Failed:  {stats['failed']}")
    
    print(f"\n🌐 Dashboard: http://localhost:{PORT}/")
    print("\nKnown account directories:")
    for d in ACCOUNT_DIRECTORIES:
        status = "✓" if d.exists() else "✗"
        print(f"  {status} {d}")
    
    print("\n" + "=" * 60)
    
    uvicorn.run(app, host=HOST, port=PORT, log_level="warning")


if __name__ == "__main__":
    main()
