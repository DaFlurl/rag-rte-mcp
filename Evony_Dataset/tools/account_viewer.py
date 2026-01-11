"""
Professional Evony Account Viewer
Real-time online viewing + Offline dump viewer
"""

import json
import os
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Optional
import asyncio

from fastapi import FastAPI, Request, WebSocket, WebSocketDisconnect
from fastapi.responses import HTMLResponse, JSONResponse
from fastapi.staticfiles import StaticFiles
import uvicorn

# Try to import extractor for live mode
try:
    from src.complete_extractor import CompleteExtractor
    EXTRACTOR_AVAILABLE = True
except:
    EXTRACTOR_AVAILABLE = False

app = FastAPI(title="Evony Account Viewer", version="1.0.0")

# Data paths
DUMPS_DIR = Path("data/dumps")
DUMPS_DIR.mkdir(parents=True, exist_ok=True)

# Active connections for real-time updates
active_connections: List[WebSocket] = []

# Current loaded data
current_account = None
current_data = None


def get_viewer_html():
    return '''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Evony Account Viewer</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
            color: #e8e8e8;
            min-height: 100vh;
        }
        
        /* Header */
        .header {
            background: rgba(0,0,0,0.4);
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #4ecca3;
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .header h1 { color: #4ecca3; font-size: 1.8em; }
        .header-controls { display: flex; gap: 15px; align-items: center; }
        
        /* Main Layout */
        .main-container {
            display: grid;
            grid-template-columns: 280px 1fr;
            min-height: calc(100vh - 70px);
        }
        
        /* Sidebar */
        .sidebar {
            background: rgba(0,0,0,0.3);
            padding: 20px;
            border-right: 1px solid rgba(78,204,163,0.3);
            overflow-y: auto;
            max-height: calc(100vh - 70px);
        }
        .sidebar h3 { color: #4ecca3; margin-bottom: 15px; font-size: 1em; }
        .nav-section { margin-bottom: 25px; }
        .nav-item {
            padding: 10px 15px;
            margin: 3px 0;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .nav-item:hover { background: rgba(78,204,163,0.2); }
        .nav-item.active { background: rgba(78,204,163,0.3); border-left: 3px solid #4ecca3; }
        .nav-item .count { 
            background: rgba(78,204,163,0.3); 
            padding: 2px 8px; 
            border-radius: 10px; 
            font-size: 0.8em; 
        }
        
        /* Content Area */
        .content {
            padding: 25px;
            overflow-y: auto;
            max-height: calc(100vh - 70px);
        }
        
        /* Cards */
        .card {
            background: rgba(255,255,255,0.05);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            border: 1px solid rgba(78,204,163,0.2);
        }
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .card-title { color: #4ecca3; font-size: 1.2em; }
        
        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 15px;
        }
        .stat-box {
            background: rgba(0,0,0,0.3);
            padding: 15px;
            border-radius: 8px;
            text-align: center;
        }
        .stat-value { font-size: 1.8em; color: #4ecca3; font-weight: bold; }
        .stat-label { color: #888; font-size: 0.85em; margin-top: 5px; }
        
        /* Data Table */
        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        .data-table th, .data-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .data-table th {
            background: rgba(78,204,163,0.2);
            color: #4ecca3;
            font-weight: 600;
            position: sticky;
            top: 0;
        }
        .data-table tr:hover { background: rgba(255,255,255,0.05); }
        
        /* Buttons */
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.95em;
            transition: all 0.2s;
        }
        .btn-primary { background: #4ecca3; color: #000; }
        .btn-primary:hover { background: #3db892; }
        .btn-secondary { background: rgba(255,255,255,0.1); color: #fff; }
        .btn-secondary:hover { background: rgba(255,255,255,0.2); }
        
        /* File Select */
        .file-select {
            background: rgba(0,0,0,0.3);
            padding: 8px 15px;
            border: 1px solid rgba(78,204,163,0.3);
            border-radius: 6px;
            color: #fff;
            min-width: 250px;
        }
        
        /* Search */
        .search-box {
            padding: 10px 15px;
            border: 1px solid rgba(78,204,163,0.3);
            border-radius: 6px;
            background: rgba(0,0,0,0.3);
            color: #fff;
            width: 100%;
            margin-bottom: 15px;
        }
        
        /* Tabs */
        .tabs {
            display: flex;
            gap: 5px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }
        .tab {
            padding: 8px 16px;
            background: rgba(0,0,0,0.3);
            border: none;
            border-radius: 6px 6px 0 0;
            color: #888;
            cursor: pointer;
            transition: all 0.2s;
        }
        .tab:hover { color: #fff; }
        .tab.active { background: rgba(78,204,163,0.3); color: #4ecca3; }
        
        /* Status Badge */
        .badge {
            padding: 3px 10px;
            border-radius: 12px;
            font-size: 0.8em;
        }
        .badge-success { background: #28a745; }
        .badge-warning { background: #ffc107; color: #000; }
        .badge-danger { background: #dc3545; }
        .badge-info { background: #17a2b8; }
        
        /* Tree View */
        .tree-item {
            padding: 8px 12px;
            margin: 2px 0;
            border-radius: 4px;
            cursor: pointer;
        }
        .tree-item:hover { background: rgba(78,204,163,0.1); }
        .tree-children { margin-left: 20px; }
        .tree-toggle { margin-right: 8px; }
        
        /* Loading */
        .loading {
            text-align: center;
            padding: 50px;
            color: #888;
        }
        .spinner {
            border: 3px solid rgba(78,204,163,0.3);
            border-top: 3px solid #4ecca3;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
            margin: 0 auto 20px;
        }
        @keyframes spin { to { transform: rotate(360deg); } }
        
        /* Scrollbar */
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: rgba(0,0,0,0.2); }
        ::-webkit-scrollbar-thumb { background: rgba(78,204,163,0.5); border-radius: 4px; }
        ::-webkit-scrollbar-thumb:hover { background: rgba(78,204,163,0.7); }
        
        /* JSON Viewer */
        .json-viewer {
            background: rgba(0,0,0,0.4);
            padding: 15px;
            border-radius: 8px;
            font-family: 'Consolas', monospace;
            font-size: 0.9em;
            max-height: 400px;
            overflow: auto;
            white-space: pre-wrap;
            word-break: break-all;
        }
        .json-key { color: #4ecca3; }
        .json-string { color: #e6db74; }
        .json-number { color: #ae81ff; }
        .json-boolean { color: #66d9ef; }
        
        /* Resource Bar */
        .resource-bar {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }
        .resource-item {
            display: flex;
            align-items: center;
            gap: 8px;
            background: rgba(0,0,0,0.3);
            padding: 8px 15px;
            border-radius: 20px;
        }
        .resource-icon { font-size: 1.2em; }
        
        /* City Card */
        .city-card {
            background: rgba(0,0,0,0.3);
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
        }
        .city-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .city-name { font-size: 1.1em; color: #4ecca3; }
        .city-coords { color: #888; font-size: 0.9em; }
        
        /* Hero Card */
        .hero-card {
            background: rgba(0,0,0,0.3);
            border-radius: 10px;
            padding: 15px;
            display: flex;
            gap: 15px;
            margin-bottom: 10px;
        }
        .hero-level {
            background: #4ecca3;
            color: #000;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1.2em;
        }
        .hero-info { flex: 1; }
        .hero-name { font-size: 1.1em; margin-bottom: 5px; }
        .hero-stats { display: flex; gap: 15px; color: #888; font-size: 0.9em; }
        
        /* Pagination */
        .pagination {
            display: flex;
            gap: 5px;
            justify-content: center;
            margin-top: 20px;
        }
        .pagination button {
            padding: 8px 15px;
            background: rgba(0,0,0,0.3);
            border: 1px solid rgba(78,204,163,0.3);
            color: #fff;
            border-radius: 4px;
            cursor: pointer;
        }
        .pagination button:hover { background: rgba(78,204,163,0.2); }
        .pagination button.active { background: #4ecca3; color: #000; }
        
        /* Mode indicator */
        .mode-indicator {
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 0.85em;
        }
        .mode-online { background: #28a745; }
        .mode-offline { background: #6c757d; }
    </style>
</head>
<body>
    <div class="header">
        <h1>🏰 Evony Account Viewer</h1>
        <div class="header-controls">
            <select class="file-select" id="dumpSelect" onchange="loadDump()">
                <option value="">-- Select Account Dump --</option>
            </select>
            <span class="mode-indicator mode-offline" id="modeIndicator">Offline</span>
            <button class="btn btn-primary" onclick="refreshData()">🔄 Refresh</button>
            <button class="btn btn-secondary" onclick="connectLive()">📡 Live Mode</button>
        </div>
    </div>
    
    <div class="main-container">
        <div class="sidebar">
            <div class="nav-section">
                <h3>📊 OVERVIEW</h3>
                <div class="nav-item active" onclick="showSection('overview')">
                    <span>Dashboard</span>
                </div>
                <div class="nav-item" onclick="showSection('player')">
                    <span>Player Info</span>
                </div>
                <div class="nav-item" onclick="showSection('stats')">
                    <span>Statistics</span>
                </div>
            </div>
            
            <div class="nav-section">
                <h3>🏰 CITIES</h3>
                <div class="nav-item" onclick="showSection('cities')">
                    <span>All Cities</span>
                    <span class="count" id="cityCount">0</span>
                </div>
                <div class="nav-item" onclick="showSection('buildings')">
                    <span>Buildings</span>
                </div>
                <div class="nav-item" onclick="showSection('research')">
                    <span>Research</span>
                </div>
            </div>
            
            <div class="nav-section">
                <h3>⚔️ MILITARY</h3>
                <div class="nav-item" onclick="showSection('armies')">
                    <span>Armies</span>
                    <span class="count" id="armyCount">0</span>
                </div>
                <div class="nav-item" onclick="showSection('troops')">
                    <span>Troops</span>
                </div>
                <div class="nav-item" onclick="showSection('heroes')">
                    <span>Heroes</span>
                    <span class="count" id="heroCount">0</span>
                </div>
            </div>
            
            <div class="nav-section">
                <h3>📦 INVENTORY</h3>
                <div class="nav-item" onclick="showSection('items')">
                    <span>Items</span>
                    <span class="count" id="itemCount">0</span>
                </div>
                <div class="nav-item" onclick="showSection('equipment')">
                    <span>Equipment</span>
                    <span class="count" id="equipCount">0</span>
                </div>
            </div>
            
            <div class="nav-section">
                <h3>👥 SOCIAL</h3>
                <div class="nav-item" onclick="showSection('alliance')">
                    <span>Alliance</span>
                </div>
                <div class="nav-item" onclick="showSection('mail')">
                    <span>Mail</span>
                    <span class="count" id="mailCount">0</span>
                </div>
                <div class="nav-item" onclick="showSection('reports')">
                    <span>Reports</span>
                    <span class="count" id="reportCount">0</span>
                </div>
            </div>
            
            <div class="nav-section">
                <h3>📋 RAW DATA</h3>
                <div class="nav-item" onclick="showSection('rawjson')">
                    <span>JSON Viewer</span>
                </div>
                <div class="nav-item" onclick="exportData()">
                    <span>Export Data</span>
                </div>
            </div>
        </div>
        
        <div class="content" id="mainContent">
            <div class="loading" id="loadingState">
                <div class="spinner"></div>
                <p>Select an account dump to view...</p>
            </div>
            
            <div id="contentArea" style="display:none;"></div>
        </div>
    </div>
    
    <script>
        let accountData = null;
        let currentSection = 'overview';
        let ws = null;
        
        // Load available dumps on page load
        async function loadDumpList() {
            const resp = await fetch('/api/dumps');
            const data = await resp.json();
            const select = document.getElementById('dumpSelect');
            select.innerHTML = '<option value="">-- Select Account Dump --</option>';
            data.dumps.forEach(d => {
                const opt = document.createElement('option');
                opt.value = d.filename;
                opt.textContent = `${d.email} (${formatBytes(d.size)})`;
                select.appendChild(opt);
            });
        }
        
        // Load selected dump
        async function loadDump() {
            const filename = document.getElementById('dumpSelect').value;
            if (!filename) return;
            
            document.getElementById('loadingState').innerHTML = '<div class="spinner"></div><p>Loading account data...</p>';
            document.getElementById('loadingState').style.display = 'block';
            document.getElementById('contentArea').style.display = 'none';
            
            const resp = await fetch(`/api/dump/${filename}`);
            accountData = await resp.json();
            
            updateCounts();
            showSection(currentSection);
            
            document.getElementById('loadingState').style.display = 'none';
            document.getElementById('contentArea').style.display = 'block';
        }
        
        // Update sidebar counts
        function updateCounts() {
            if (!accountData) return;
            
            const login = accountData.login_data || {};
            const player = login.player || accountData.player || {};
            const raw = accountData.raw_responses?.login?.data || {};
            
            document.getElementById('cityCount').textContent = player.castles?.length || 0;
            document.getElementById('armyCount').textContent = raw.selfArmys?.length || 0;
            document.getElementById('heroCount').textContent = player.heroesArray?.length || raw.heroesArray?.length || 0;
            document.getElementById('itemCount').textContent = raw.items?.length || 0;
            document.getElementById('equipCount').textContent = player.equipments?.length || 0;
            document.getElementById('mailCount').textContent = accountData.mail?.length || 0;
            document.getElementById('reportCount').textContent = accountData.reports?.length || 0;
        }
        
        // Show section
        function showSection(section) {
            currentSection = section;
            
            // Update nav
            document.querySelectorAll('.nav-item').forEach(el => el.classList.remove('active'));
            event?.target?.classList?.add('active');
            
            const content = document.getElementById('contentArea');
            
            switch(section) {
                case 'overview': content.innerHTML = renderOverview(); break;
                case 'player': content.innerHTML = renderPlayer(); break;
                case 'stats': content.innerHTML = renderStats(); break;
                case 'cities': content.innerHTML = renderCities(); break;
                case 'buildings': content.innerHTML = renderBuildings(); break;
                case 'research': content.innerHTML = renderResearch(); break;
                case 'armies': content.innerHTML = renderArmies(); break;
                case 'troops': content.innerHTML = renderTroops(); break;
                case 'heroes': content.innerHTML = renderHeroes(); break;
                case 'items': content.innerHTML = renderItems(); break;
                case 'equipment': content.innerHTML = renderEquipment(); break;
                case 'alliance': content.innerHTML = renderAlliance(); break;
                case 'mail': content.innerHTML = renderMail(); break;
                case 'reports': content.innerHTML = renderReports(); break;
                case 'rawjson': content.innerHTML = renderRawJson(); break;
                default: content.innerHTML = '<p>Section not found</p>';
            }
        }
        
        // Render functions
        function renderOverview() {
            if (!accountData) return '<p>No data loaded</p>';
            
            const login = accountData.login_data || {};
            const player = login.player || {};
            const raw = accountData.raw_responses?.login?.data || {};
            
            // Find player name
            let playerName = 'Unknown';
            if (raw.selfArmys?.[0]?.king) playerName = raw.selfArmys[0].king;
            
            return `
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">👤 Account Overview</span>
                        <span class="badge badge-success">Active</span>
                    </div>
                    <div class="stats-grid">
                        <div class="stat-box">
                            <div class="stat-value">${playerName}</div>
                            <div class="stat-label">Player Name</div>
                        </div>
                        <div class="stat-box">
                            <div class="stat-value">${accountData.server || 'cc2'}</div>
                            <div class="stat-label">Server</div>
                        </div>
                        <div class="stat-box">
                            <div class="stat-value">${player.castles?.length || 0}</div>
                            <div class="stat-label">Cities</div>
                        </div>
                        <div class="stat-box">
                            <div class="stat-value">${player.equipments?.length || 0}</div>
                            <div class="stat-label">Equipment</div>
                        </div>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">📊 Quick Stats</span>
                    </div>
                    <div class="stats-grid">
                        <div class="stat-box">
                            <div class="stat-value">${raw.selfArmys?.length || 0}</div>
                            <div class="stat-label">Active Armies</div>
                        </div>
                        <div class="stat-box">
                            <div class="stat-value">${raw.items?.length || 0}</div>
                            <div class="stat-label">Items</div>
                        </div>
                        <div class="stat-box">
                            <div class="stat-value">${player.buffs?.length || 0}</div>
                            <div class="stat-label">Active Buffs</div>
                        </div>
                        <div class="stat-box">
                            <div class="stat-value">${raw.troopConfigBeans?.length || 0}</div>
                            <div class="stat-label">Troop Configs</div>
                        </div>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">📅 Extraction Info</span>
                    </div>
                    <p><strong>Email:</strong> ${accountData.email}</p>
                    <p><strong>Extracted:</strong> ${accountData.extracted_at}</p>
                    <p><strong>Version:</strong> ${accountData.extraction_version || '1.0'}</p>
                </div>
            `;
        }
        
        function renderPlayer() {
            if (!accountData) return '<p>No data</p>';
            const player = accountData.login_data?.player || {};
            
            return `
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">👤 Player Details</span>
                    </div>
                    <table class="data-table">
                        <tr><th>Property</th><th>Value</th></tr>
                        <tr><td>Auto Heal</td><td>${player.autoHeal ? 'Yes' : 'No'}</td></tr>
                        <tr><td>Auto Furlough</td><td>${player.autoFurlough ? 'Yes' : 'No'}</td></tr>
                        <tr><td>Changed Face</td><td>${player.changedFace || 'No'}</td></tr>
                        <tr><td>Effort Points</td><td>${player.effortPoint || 0}</td></tr>
                        <tr><td>Finished Quests</td><td>${player.finishedQuestCount || 0}</td></tr>
                        <tr><td>Fresh Man</td><td>${player.freshMan ? 'Yes' : 'No'}</td></tr>
                        <tr><td>Current Time</td><td>${new Date(player.currentTime).toLocaleString()}</td></tr>
                    </table>
                </div>
                
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">🛡️ Buffs (${player.buffs?.length || 0})</span>
                    </div>
                    ${player.buffs?.length ? `
                        <table class="data-table">
                            <tr><th>Buff ID</th><th>Details</th></tr>
                            ${player.buffs.map(b => `<tr><td>${b.id || b}</td><td>${JSON.stringify(b)}</td></tr>`).join('')}
                        </table>
                    ` : '<p>No active buffs</p>'}
                </div>
            `;
        }
        
        function renderStats() {
            const login = accountData?.login_data || {};
            const player = login.player || {};
            const raw = accountData?.raw_responses?.login?.data || {};
            
            return `
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">📈 Game Statistics</span>
                    </div>
                    <div class="stats-grid">
                        <div class="stat-box">
                            <div class="stat-value">${raw.tutorialStepId || 999}</div>
                            <div class="stat-label">Tutorial Step</div>
                        </div>
                        <div class="stat-box">
                            <div class="stat-value">${raw.redCount || 0}</div>
                            <div class="stat-label">Red Count</div>
                        </div>
                        <div class="stat-box">
                            <div class="stat-value">${raw.returnReport ? 'Yes' : 'No'}</div>
                            <div class="stat-label">Return Reports</div>
                        </div>
                        <div class="stat-box">
                            <div class="stat-value">${player.disconnectvotes || 0}</div>
                            <div class="stat-label">Disconnect Votes</div>
                        </div>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">⏱️ Timing Data</span>
                    </div>
                    <table class="data-table">
                        <tr><th>Metric</th><th>Value</th></tr>
                        <tr><td>Server Date/Time</td><td>${player.currentDateTime || 'N/A'}</td></tr>
                        <tr><td>Current Time (ms)</td><td>${player.currentTime || 0}</td></tr>
                        <tr><td>Extraction Time</td><td>${accountData.extracted_at}</td></tr>
                    </table>
                </div>
            `;
        }
        
        function renderCities() {
            const player = accountData?.login_data?.player || {};
            const castles = player.castles || [];
            
            return `
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">🏰 Cities (${castles.length})</span>
                    </div>
                    <input type="text" class="search-box" placeholder="Search cities..." onkeyup="filterCities(this.value)">
                    <div id="citiesList">
                        ${castles.map((c, i) => `
                            <div class="city-card" data-name="${(c.name || c.n || '').toLowerCase()}">
                                <div class="city-header">
                                    <span class="city-name">${c.name || c.n || 'City ' + (i+1)}</span>
                                    <span class="city-coords">(${c.x || '?'}, ${c.y || '?'})</span>
                                </div>
                                <div style="display:flex;gap:20px;flex-wrap:wrap;font-size:0.9em;color:#888;">
                                    <span>ID: ${c.id || 'N/A'}</span>
                                    <span>Field: ${c.fieldId || 'N/A'}</span>
                                    <span>Status: ${c.status || 'Active'}</span>
                                </div>
                                <button class="btn btn-secondary" style="margin-top:10px;" onclick="showCityDetail(${i})">View Details</button>
                            </div>
                        `).join('')}
                    </div>
                </div>
            `;
        }
        
        function renderBuildings() {
            const details = accountData?.castle_details || {};
            return `
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">🏗️ Buildings</span>
                    </div>
                    ${Object.keys(details).length ? 
                        Object.entries(details).map(([id, data]) => `
                            <h4 style="margin:15px 0;">Castle ${id}</h4>
                            <div class="json-viewer">${JSON.stringify(data.buildings_inside || data, null, 2)}</div>
                        `).join('') : 
                        '<p>No building data available. Run full extraction.</p>'
                    }
                </div>
            `;
        }
        
        function renderResearch() {
            const details = accountData?.castle_details || {};
            return `
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">🔬 Research</span>
                    </div>
                    ${Object.keys(details).length && Object.values(details).some(d => d.research) ? 
                        Object.entries(details).map(([id, data]) => 
                            data.research ? `
                                <h4 style="margin:15px 0;">Castle ${id}</h4>
                                <div class="json-viewer">${JSON.stringify(data.research, null, 2)}</div>
                            ` : ''
                        ).join('') : 
                        '<p>No research data available.</p>'
                    }
                </div>
            `;
        }
        
        function renderArmies() {
            const raw = accountData?.raw_responses?.login?.data || {};
            const armies = raw.selfArmys || [];
            
            return `
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">⚔️ Active Armies (${armies.length})</span>
                    </div>
                    ${armies.length ? armies.map(a => `
                        <div class="city-card">
                            <div class="city-header">
                                <span class="city-name">${a.startPosName || 'Unknown'} → ${a.targetPosName || 'Unknown'}</span>
                                <span class="badge badge-info">Mission: ${a.missionType}</span>
                            </div>
                            <p><strong>King:</strong> ${a.king}</p>
                            <p><strong>Army ID:</strong> ${a.armyId}</p>
                            <p><strong>Resources:</strong> Food: ${formatNumber(a.resource?.food || 0)}</p>
                            <details style="margin-top:10px;">
                                <summary style="cursor:pointer;color:#4ecca3;">View Troops</summary>
                                <div class="json-viewer" style="margin-top:10px;">${JSON.stringify(a.troop, null, 2)}</div>
                            </details>
                        </div>
                    `).join('') : '<p>No active armies</p>'}
                </div>
            `;
        }
        
        function renderTroops() {
            const raw = accountData?.raw_responses?.login?.data || {};
            const configs = raw.troopConfigBeans || [];
            
            return `
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">🪖 Troop Configurations (${configs.length})</span>
                    </div>
                    ${configs.map(c => `
                        <div class="city-card">
                            <h4>${c.name}</h4>
                            <table class="data-table">
                                <tr><th>Unit</th><th>Count</th></tr>
                                ${Object.entries(c.troop || {}).map(([unit, count]) => 
                                    `<tr><td>${unit}</td><td>${formatNumber(count)}</td></tr>`
                                ).join('')}
                            </table>
                        </div>
                    `).join('')}
                </div>
            `;
        }
        
        function renderHeroes() {
            const player = accountData?.login_data?.player || {};
            const heroes = player.heroesArray || accountData?.raw_responses?.login?.data?.heroesArray || [];
            
            return `
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">🦸 Heroes (${heroes.length})</span>
                    </div>
                    <input type="text" class="search-box" placeholder="Search heroes...">
                    ${heroes.length ? heroes.map(h => `
                        <div class="hero-card">
                            <div class="hero-level">${h.level || h.lv || '?'}</div>
                            <div class="hero-info">
                                <div class="hero-name">${h.name || h.n || 'Unknown Hero'}</div>
                                <div class="hero-stats">
                                    <span>ATK: ${h.attack || h.atk || '?'}</span>
                                    <span>DEF: ${h.defense || h.def || '?'}</span>
                                    <span>INT: ${h.intelligence || h.int || '?'}</span>
                                    <span>POL: ${h.politics || h.pol || '?'}</span>
                                </div>
                            </div>
                        </div>
                    `).join('') : '<p>No heroes found</p>'}
                </div>
            `;
        }
        
        function renderItems() {
            const raw = accountData?.raw_responses?.login?.data || {};
            const items = raw.items || [];
            
            return `
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">📦 Items (${items.length})</span>
                    </div>
                    <input type="text" class="search-box" placeholder="Search items..." onkeyup="filterTable(this.value, 'itemsTable')">
                    <div style="max-height:500px;overflow:auto;">
                        <table class="data-table" id="itemsTable">
                            <tr><th>Item ID</th><th>Count</th><th>Details</th></tr>
                            ${items.slice(0, 500).map(item => `
                                <tr>
                                    <td>${item.id || item}</td>
                                    <td>${item.count || item.amount || 1}</td>
                                    <td>${typeof item === 'object' ? JSON.stringify(item) : ''}</td>
                                </tr>
                            `).join('')}
                            ${items.length > 500 ? `<tr><td colspan="3">... and ${items.length - 500} more items</td></tr>` : ''}
                        </table>
                    </div>
                </div>
            `;
        }
        
        function renderEquipment() {
            const player = accountData?.login_data?.player || {};
            const equip = player.equipments || [];
            
            return `
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">🛡️ Equipment (${equip.length})</span>
                    </div>
                    <div style="max-height:500px;overflow:auto;">
                        <table class="data-table">
                            <tr><th>ID</th><th>Type</th><th>Level</th><th>Details</th></tr>
                            ${equip.map(e => `
                                <tr>
                                    <td>${e.id || 'N/A'}</td>
                                    <td>${e.type || e.typeId || 'N/A'}</td>
                                    <td>${e.level || e.lv || 'N/A'}</td>
                                    <td><button class="btn btn-secondary" onclick="alert(JSON.stringify(${JSON.stringify(e).replace(/"/g, '&quot;')}, null, 2))">View</button></td>
                                </tr>
                            `).join('')}
                        </table>
                    </div>
                </div>
            `;
        }
        
        function renderAlliance() {
            const alliance = accountData?.alliance || accountData?.login_data?.player?.allianceBean || {};
            const members = accountData?.alliance_members || [];
            
            return `
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">👥 Alliance</span>
                    </div>
                    ${Object.keys(alliance).length ? `
                        <table class="data-table">
                            ${Object.entries(alliance).map(([k, v]) => `<tr><td>${k}</td><td>${v}</td></tr>`).join('')}
                        </table>
                    ` : '<p>No alliance data</p>'}
                </div>
                
                ${members.length ? `
                    <div class="card">
                        <div class="card-header">
                            <span class="card-title">👥 Members (${members.length})</span>
                        </div>
                        <table class="data-table">
                            <tr><th>Name</th><th>Rank</th><th>Prestige</th></tr>
                            ${members.map(m => `<tr><td>${m.name || m.n}</td><td>${m.rank}</td><td>${m.prestige}</td></tr>`).join('')}
                        </table>
                    </div>
                ` : ''}
            `;
        }
        
        function renderMail() {
            const mail = accountData?.mail || [];
            return `
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">✉️ Mail (${mail.length})</span>
                    </div>
                    ${mail.length ? `
                        <table class="data-table">
                            <tr><th>From</th><th>Subject</th><th>Date</th></tr>
                            ${mail.slice(0, 100).map(m => `
                                <tr>
                                    <td>${m.sender || m.from || 'System'}</td>
                                    <td>${m.title || m.subject || 'No subject'}</td>
                                    <td>${m.time ? new Date(m.time).toLocaleString() : 'N/A'}</td>
                                </tr>
                            `).join('')}
                        </table>
                    ` : '<p>No mail</p>'}
                </div>
            `;
        }
        
        function renderReports() {
            const reports = accountData?.reports || [];
            return `
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">📜 Reports (${reports.length})</span>
                    </div>
                    ${reports.length ? `
                        <table class="data-table">
                            <tr><th>Type</th><th>Title</th><th>Date</th></tr>
                            ${reports.slice(0, 100).map(r => `
                                <tr>
                                    <td>${r.type || r.reportType || 'N/A'}</td>
                                    <td>${r.title || r.subject || 'Report'}</td>
                                    <td>${r.time ? new Date(r.time).toLocaleString() : 'N/A'}</td>
                                </tr>
                            `).join('')}
                        </table>
                    ` : '<p>No reports</p>'}
                </div>
            `;
        }
        
        function renderRawJson() {
            return `
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">📋 Raw JSON Data</span>
                        <button class="btn btn-primary" onclick="copyJson()">Copy All</button>
                    </div>
                    <div class="tabs">
                        <button class="tab active" onclick="showJsonTab('full')">Full Dump</button>
                        <button class="tab" onclick="showJsonTab('login')">Login Data</button>
                        <button class="tab" onclick="showJsonTab('player')">Player</button>
                        <button class="tab" onclick="showJsonTab('raw')">Raw Responses</button>
                    </div>
                    <div class="json-viewer" id="jsonViewer" style="max-height:600px;">
                        ${JSON.stringify(accountData, null, 2)}
                    </div>
                </div>
            `;
        }
        
        function showJsonTab(tab) {
            document.querySelectorAll('.tabs .tab').forEach(t => t.classList.remove('active'));
            event.target.classList.add('active');
            
            let data;
            switch(tab) {
                case 'login': data = accountData.login_data; break;
                case 'player': data = accountData.login_data?.player; break;
                case 'raw': data = accountData.raw_responses; break;
                default: data = accountData;
            }
            document.getElementById('jsonViewer').textContent = JSON.stringify(data, null, 2);
        }
        
        function copyJson() {
            navigator.clipboard.writeText(JSON.stringify(accountData, null, 2));
            alert('JSON copied to clipboard!');
        }
        
        // Utility functions
        function formatNumber(n) {
            if (n >= 1e12) return (n/1e12).toFixed(2) + 'T';
            if (n >= 1e9) return (n/1e9).toFixed(2) + 'B';
            if (n >= 1e6) return (n/1e6).toFixed(2) + 'M';
            if (n >= 1e3) return (n/1e3).toFixed(2) + 'K';
            return n?.toLocaleString() || '0';
        }
        
        function formatBytes(bytes) {
            if (bytes >= 1e6) return (bytes/1e6).toFixed(2) + ' MB';
            if (bytes >= 1e3) return (bytes/1e3).toFixed(2) + ' KB';
            return bytes + ' B';
        }
        
        function filterCities(query) {
            const cards = document.querySelectorAll('#citiesList .city-card');
            cards.forEach(card => {
                const name = card.dataset.name;
                card.style.display = name.includes(query.toLowerCase()) ? 'block' : 'none';
            });
        }
        
        function filterTable(query, tableId) {
            const rows = document.querySelectorAll(`#${tableId} tr`);
            rows.forEach((row, i) => {
                if (i === 0) return; // Skip header
                row.style.display = row.textContent.toLowerCase().includes(query.toLowerCase()) ? '' : 'none';
            });
        }
        
        function refreshData() {
            loadDump();
        }
        
        function exportData() {
            if (!accountData) return alert('No data loaded');
            const blob = new Blob([JSON.stringify(accountData, null, 2)], {type: 'application/json'});
            const url = URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = `${accountData.email}_export.json`;
            a.click();
        }
        
        async function connectLive() {
            // Live mode - connect to server for real-time updates
            const email = prompt('Enter email for live connection:');
            const password = prompt('Enter password:');
            if (!email || !password) return;
            
            document.getElementById('modeIndicator').className = 'mode-indicator mode-online';
            document.getElementById('modeIndicator').textContent = 'Live';
            
            const resp = await fetch('/api/live/connect', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({email, password, server: 'cc2'})
            });
            const data = await resp.json();
            
            if (data.success) {
                accountData = data.data;
                updateCounts();
                showSection('overview');
                document.getElementById('loadingState').style.display = 'none';
                document.getElementById('contentArea').style.display = 'block';
            } else {
                alert('Connection failed: ' + data.error);
                document.getElementById('modeIndicator').className = 'mode-indicator mode-offline';
                document.getElementById('modeIndicator').textContent = 'Offline';
            }
        }
        
        // Initialize
        loadDumpList();
    </script>
</body>
</html>'''


@app.get("/", response_class=HTMLResponse)
async def index():
    return get_viewer_html()


@app.get("/api/dumps")
async def list_dumps():
    """List available dump files"""
    dumps = []
    for f in DUMPS_DIR.glob("*.json"):
        try:
            with open(f, 'r') as fp:
                data = json.load(fp)
            dumps.append({
                'filename': f.name,
                'email': data.get('email', 'Unknown'),
                'size': f.stat().st_size,
                'extracted': data.get('extracted_at', '')
            })
        except:
            pass
    return {"dumps": sorted(dumps, key=lambda x: x['extracted'], reverse=True)}


@app.get("/api/dump/{filename}")
async def get_dump(filename: str):
    """Get dump file contents"""
    filepath = DUMPS_DIR / filename
    if not filepath.exists():
        return JSONResponse({"error": "File not found"}, status_code=404)
    
    with open(filepath, 'r', encoding='utf-8') as f:
        return json.load(f)


@app.post("/api/live/connect")
async def live_connect(request: Request):
    """Connect live to extract real-time data"""
    if not EXTRACTOR_AVAILABLE:
        return {"success": False, "error": "Extractor not available"}
    
    body = await request.json()
    email = body.get('email')
    password = body.get('password')
    server = body.get('server', 'cc2')
    
    try:
        extractor = CompleteExtractor(server)
        
        if not extractor.connect():
            return {"success": False, "error": "Connection failed"}
        
        if not extractor.login(email, password):
            extractor.disconnect()
            return {"success": False, "error": "Login failed"}
        
        # Get data
        dump = extractor.extract_all()
        extractor.disconnect()
        
        if dump:
            from dataclasses import asdict
            return {"success": True, "data": asdict(dump)}
        
        return {"success": False, "error": "No data"}
        
    except Exception as e:
        return {"success": False, "error": str(e)}


if __name__ == "__main__":
    print("=" * 60)
    print("  Evony Account Viewer")
    print("  http://localhost:8095")
    print("=" * 60)
    uvicorn.run(app, host="0.0.0.0", port=8095)
