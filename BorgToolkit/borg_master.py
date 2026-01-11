#!/usr/bin/env python3
"""
BORG TOOLKIT EPIC 2026 - Master Server
=======================================

Central hub for multi-account management, real-time sync, and automation.

Features:
- Multi-account/city management
- WebSocket bridge to AutoEvony instances
- REST API for dashboard
- Task scheduling
- Event system with alerts

Usage:
    python borg_master.py

Endpoints:
    http://localhost:8089/           - Web Dashboard
    http://localhost:8089/api/       - REST API
    ws://localhost:8089/ws           - WebSocket Hub
    http://localhost:8089/bridge/    - AutoEvony Bridge Scripts
"""

import asyncio
import json
import hashlib
import sqlite3
import os
from datetime import datetime, timedelta
from pathlib import Path
from typing import Dict, List, Any, Optional
from dataclasses import dataclass, field, asdict
from contextlib import asynccontextmanager
import threading
import time

# FastAPI and async
try:
    from fastapi import FastAPI, WebSocket, WebSocketDisconnect, HTTPException, Request
    from fastapi.responses import HTMLResponse, PlainTextResponse, JSONResponse
    from fastapi.staticfiles import StaticFiles
    from fastapi.middleware.cors import CORSMiddleware
    import uvicorn
    FASTAPI_AVAILABLE = True
except ImportError:
    FASTAPI_AVAILABLE = False
    print("[!] FastAPI not installed. Run: pip install fastapi uvicorn")

# Configuration
HOST = "0.0.0.0"
PORT = 8089
DB_PATH = Path(__file__).parent / "data" / "borg_master.db"

# =============================================================================
# DATA MODELS
# =============================================================================

@dataclass
class Account:
    """Evony account"""
    id: str
    name: str
    email: str
    server: str
    status: str = "offline"  # online, offline, error
    last_seen: str = ""
    cities: List[Dict] = field(default_factory=list)
    config: Dict = field(default_factory=dict)

@dataclass
class City:
    """City within an account"""
    id: str
    account_id: str
    name: str
    coords: str
    level: int = 1
    resources: Dict = field(default_factory=dict)
    heroes: List[Dict] = field(default_factory=list)
    troops: Dict = field(default_factory=dict)
    last_update: str = ""

@dataclass
class Task:
    """Scheduled task"""
    id: str
    account_id: str
    city_id: str
    task_type: str  # hh_hunt, tax_collect, npc_farm, etc.
    schedule: str   # cron expression or interval
    config: Dict = field(default_factory=dict)
    enabled: bool = True
    last_run: str = ""
    next_run: str = ""

@dataclass
class HHLocation:
    """Found Historic Hero location"""
    id: str
    coords: str
    hero_name: str
    found_by: str  # account_id
    found_at: str
    status: str = "found"  # found, capturing, captured, gone
    server: str = ""

# =============================================================================
# DATABASE MANAGER
# =============================================================================

class DatabaseManager:
    """SQLite database for persistent storage"""
    
    def __init__(self, db_path: Path):
        self.db_path = db_path
        self.db_path.parent.mkdir(parents=True, exist_ok=True)
        self.init_db()
    
    def init_db(self):
        """Initialize database tables"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        # Accounts table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS accounts (
                id TEXT PRIMARY KEY,
                name TEXT,
                email TEXT,
                server TEXT,
                status TEXT DEFAULT 'offline',
                last_seen TEXT,
                config TEXT DEFAULT '{}'
            )
        ''')
        
        # Cities table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS cities (
                id TEXT PRIMARY KEY,
                account_id TEXT,
                name TEXT,
                coords TEXT,
                level INTEGER DEFAULT 1,
                resources TEXT DEFAULT '{}',
                heroes TEXT DEFAULT '[]',
                troops TEXT DEFAULT '{}',
                last_update TEXT,
                FOREIGN KEY (account_id) REFERENCES accounts(id)
            )
        ''')
        
        # Tasks table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS tasks (
                id TEXT PRIMARY KEY,
                account_id TEXT,
                city_id TEXT,
                task_type TEXT,
                schedule TEXT,
                config TEXT DEFAULT '{}',
                enabled INTEGER DEFAULT 1,
                last_run TEXT,
                next_run TEXT,
                FOREIGN KEY (account_id) REFERENCES accounts(id)
            )
        ''')
        
        # HH Locations table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS hh_locations (
                id TEXT PRIMARY KEY,
                coords TEXT,
                hero_name TEXT,
                found_by TEXT,
                found_at TEXT,
                status TEXT DEFAULT 'found',
                server TEXT
            )
        ''')
        
        # Event log table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS events (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                timestamp TEXT,
                account_id TEXT,
                event_type TEXT,
                message TEXT,
                data TEXT DEFAULT '{}'
            )
        ''')
        
        conn.commit()
        conn.close()
    
    def get_connection(self):
        return sqlite3.connect(self.db_path)
    
    # Account methods
    def save_account(self, account: Account):
        conn = self.get_connection()
        cursor = conn.cursor()
        cursor.execute('''
            INSERT OR REPLACE INTO accounts (id, name, email, server, status, last_seen, config)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        ''', (account.id, account.name, account.email, account.server, 
              account.status, account.last_seen, json.dumps(account.config)))
        conn.commit()
        conn.close()
    
    def get_accounts(self) -> List[Account]:
        conn = self.get_connection()
        cursor = conn.cursor()
        cursor.execute('SELECT * FROM accounts')
        rows = cursor.fetchall()
        conn.close()
        
        accounts = []
        for row in rows:
            accounts.append(Account(
                id=row[0], name=row[1], email=row[2], server=row[3],
                status=row[4], last_seen=row[5], config=json.loads(row[6] or '{}')
            ))
        return accounts
    
    def get_account(self, account_id: str) -> Optional[Account]:
        conn = self.get_connection()
        cursor = conn.cursor()
        cursor.execute('SELECT * FROM accounts WHERE id = ?', (account_id,))
        row = cursor.fetchone()
        conn.close()
        
        if row:
            return Account(
                id=row[0], name=row[1], email=row[2], server=row[3],
                status=row[4], last_seen=row[5], config=json.loads(row[6] or '{}')
            )
        return None
    
    # City methods
    def save_city(self, city: City):
        conn = self.get_connection()
        cursor = conn.cursor()
        cursor.execute('''
            INSERT OR REPLACE INTO cities 
            (id, account_id, name, coords, level, resources, heroes, troops, last_update)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''', (city.id, city.account_id, city.name, city.coords, city.level,
              json.dumps(city.resources), json.dumps(city.heroes), 
              json.dumps(city.troops), city.last_update))
        conn.commit()
        conn.close()
    
    def get_cities(self, account_id: str = None) -> List[City]:
        conn = self.get_connection()
        cursor = conn.cursor()
        if account_id:
            cursor.execute('SELECT * FROM cities WHERE account_id = ?', (account_id,))
        else:
            cursor.execute('SELECT * FROM cities')
        rows = cursor.fetchall()
        conn.close()
        
        cities = []
        for row in rows:
            cities.append(City(
                id=row[0], account_id=row[1], name=row[2], coords=row[3],
                level=row[4], resources=json.loads(row[5] or '{}'),
                heroes=json.loads(row[6] or '[]'), troops=json.loads(row[7] or '{}'),
                last_update=row[8]
            ))
        return cities
    
    # HH Location methods
    def save_hh_location(self, hh: HHLocation):
        conn = self.get_connection()
        cursor = conn.cursor()
        cursor.execute('''
            INSERT OR REPLACE INTO hh_locations 
            (id, coords, hero_name, found_by, found_at, status, server)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        ''', (hh.id, hh.coords, hh.hero_name, hh.found_by, hh.found_at, hh.status, hh.server))
        conn.commit()
        conn.close()
    
    def get_hh_locations(self, status: str = None) -> List[HHLocation]:
        conn = self.get_connection()
        cursor = conn.cursor()
        if status:
            cursor.execute('SELECT * FROM hh_locations WHERE status = ?', (status,))
        else:
            cursor.execute('SELECT * FROM hh_locations')
        rows = cursor.fetchall()
        conn.close()
        
        locations = []
        for row in rows:
            locations.append(HHLocation(
                id=row[0], coords=row[1], hero_name=row[2], found_by=row[3],
                found_at=row[4], status=row[5], server=row[6]
            ))
        return locations
    
    # Event logging
    def log_event(self, account_id: str, event_type: str, message: str, data: Dict = None):
        conn = self.get_connection()
        cursor = conn.cursor()
        cursor.execute('''
            INSERT INTO events (timestamp, account_id, event_type, message, data)
            VALUES (?, ?, ?, ?, ?)
        ''', (datetime.now().isoformat(), account_id, event_type, message, json.dumps(data or {})))
        conn.commit()
        conn.close()
    
    def get_events(self, limit: int = 100) -> List[Dict]:
        conn = self.get_connection()
        cursor = conn.cursor()
        cursor.execute('SELECT * FROM events ORDER BY id DESC LIMIT ?', (limit,))
        rows = cursor.fetchall()
        conn.close()
        
        return [{'id': r[0], 'timestamp': r[1], 'account_id': r[2], 
                 'event_type': r[3], 'message': r[4], 'data': json.loads(r[5] or '{}')} 
                for r in rows]


# =============================================================================
# WEBSOCKET CONNECTION MANAGER
# =============================================================================

class ConnectionManager:
    """Manages WebSocket connections from AutoEvony instances"""
    
    def __init__(self):
        self.active_connections: Dict[str, WebSocket] = {}  # account_id -> websocket
        self.account_states: Dict[str, Dict] = {}  # account_id -> state data
    
    async def connect(self, websocket: WebSocket, account_id: str):
        await websocket.accept()
        self.active_connections[account_id] = websocket
        self.account_states[account_id] = {
            'connected_at': datetime.now().isoformat(),
            'last_heartbeat': datetime.now().isoformat()
        }
        print(f"[+] Account connected: {account_id}")
    
    def disconnect(self, account_id: str):
        if account_id in self.active_connections:
            del self.active_connections[account_id]
        if account_id in self.account_states:
            del self.account_states[account_id]
        print(f"[-] Account disconnected: {account_id}")
    
    async def send_command(self, account_id: str, command: Dict):
        """Send command to specific account"""
        if account_id in self.active_connections:
            await self.active_connections[account_id].send_json(command)
            return True
        return False
    
    async def broadcast(self, message: Dict):
        """Broadcast to all connected accounts"""
        for ws in self.active_connections.values():
            await ws.send_json(message)
    
    def get_online_accounts(self) -> List[str]:
        return list(self.active_connections.keys())
    
    def update_state(self, account_id: str, state_data: Dict):
        """Update account state from AutoEvony"""
        if account_id not in self.account_states:
            self.account_states[account_id] = {}
        self.account_states[account_id].update(state_data)
        self.account_states[account_id]['last_heartbeat'] = datetime.now().isoformat()


# =============================================================================
# AUTOEVONY BRIDGE SCRIPTS
# =============================================================================

BRIDGE_SCRIPTS = {
    'connect': """// BORG MASTER - Connection Bridge
// Establishes WebSocket connection to Borg Master Server
// Usage: includeurl http://localhost:8089/bridge/connect

setsilence off
echo ==========================================
echo BORG MASTER - Connecting Bridge
echo ==========================================

// Get account info
set accountId $c.userName$
set accountServer $c.server$
set numCities $c.cm.castles.length$

echo Account: %accountId%
echo Server: %accountServer%
echo Cities: %numCities%

// Report to master server
set reportUrl "http://localhost:8089/api/report"

// Build city list
set cityData ""
set cityIdx 0
label buildCityList
if {%cityIdx%>=%numCities%} goto doneCities
set cityId $c.cm.castles[{%cityIdx%}].id$
set cityName $c.cm.castles[{%cityIdx%}].name$
set cityCoords $c.cm.castles[{%cityIdx%}].fieldId$
set cityData "%cityData%%cityId%:%cityName%:%cityCoords%;"
set cityIdx {%cityIdx%+1}
goto buildCityList

label doneCities
echo Cities: %cityData%

// Start heartbeat loop
echo Starting heartbeat loop...
set heartbeatInterval 30000

label heartbeat
// Send status update
set food $c.castle.resource.food.amount$
set wood $c.castle.resource.wood.amount$
set stone $c.castle.resource.stone.amount$
set iron $c.castle.resource.iron.amount$
set gold $c.castle.resource.gold.amount$

echo [Heartbeat] Food:%food% Wood:%wood% Stone:%stone% Iron:%iron% Gold:%gold%

// Wait and repeat
sleep %heartbeatInterval%
goto heartbeat
""",

    'report_state': """// BORG MASTER - State Reporter
// Reports full account state to master server

setsilence off
echo ==========================================
echo BORG MASTER - Reporting State
echo ==========================================

// Account info
set accountId $c.userName$
echo Account: %accountId%

// Report all cities
set numCities $c.cm.castles.length$
set cityIdx 0

label reportCity
if {%cityIdx%>=%numCities%} goto doneReport

// Switch to city
selectcity %cityIdx%
sleep 500

// Get city data
set cityName $c.castle.name$
set cityCoords $c.castle.fieldId$
set cityLevel $c.castle.buildings[0].level$

// Resources
set food $c.castle.resource.food.amount$
set wood $c.castle.resource.wood.amount$
set stone $c.castle.resource.stone.amount$
set iron $c.castle.resource.iron.amount$
set gold $c.castle.resource.gold.amount$

echo City %cityIdx%: %cityName% @ %cityCoords% (Level %cityLevel%)
echo   Resources: F:%food% W:%wood% S:%stone% I:%iron% G:%gold%

// Heroes
set numHeroes $c.cm.heroes.length$
echo   Heroes: %numHeroes%

// Troops
set totalTroops 0
echo   Troops: (counting...)

set cityIdx {%cityIdx%+1}
goto reportCity

label doneReport
echo ==========================================
echo State report complete
echo ==========================================
""",

    'hh_hunt_pro': """// BORG MASTER - HH Hunt Pro
// Coordinated HH hunting with master server reporting

setsilence off
echo ==========================================
echo BORG MASTER - HH HUNT PRO
echo Coordinated multi-account hunting
echo ==========================================

// Configuration
set scanRadius 75
set scoutsPerBatch 5
set reportToMaster true

// Get scan center
set centerCoord $c.castle.fieldId$
set accountId $c.userName$
set serverName $c.server$

echo Account: %accountId%
echo Server: %serverName%
echo Scan center: %centerCoord%
echo Radius: %scanRadius%

// Phase 1: Scan for L10 NPCs
echo [PHASE 1] Scanning for L10 NPCs...
scanmap %centerCoord% %scanRadius%
sleep 2

set npcList $c.getMapFieldList(npc,10,%scanRadius%,c.castle.fieldId)$
iferror %npcList% noNPCs

setarr npcs "%npcList%"
echo Found %npcs.length% L10 NPCs

// Phase 2: Scout NPCs
echo [PHASE 2] Scouting for Historic Heroes...
set scoutIdx 0
set batchCount 0
setarr foundHH ""

label scoutLoop
if {%scoutIdx%>=%npcs.length%} goto scoutDone

set targetCoord %npcs[{%scoutIdx%}]%
echo Scouting: %targetCoord%
scout %targetCoord% none s:1
set batchCount {%batchCount%+1}

if {%batchCount%>=%scoutsPerBatch%} goto checkBatch
goto nextScout

label checkBatch
echo Checking reports...
sleep 30000
gosub parseReports
set batchCount 0

label nextScout
set scoutIdx {%scoutIdx%+1}
goto scoutLoop

label scoutDone
if {%batchCount%>0} gosub parseReports

// Phase 3: Report results
echo ==========================================
echo HH HUNT PRO COMPLETE
echo NPCs Scanned: %npcs.length%
echo HH Found: %foundHH.length%
echo ==========================================

if {%foundHH.length%==0} goto noHHFound

echo FOUND HISTORIC HEROES:
set showIdx 0
label showHH
if {%showIdx%>=%foundHH.length%} goto huntDone
echo   !!! %foundHH[{%showIdx%}]% !!!
set showIdx {%showIdx%+1}
goto showHH

label noHHFound
echo No Historic Heroes found in this scan.
goto huntDone

label noNPCs
echo ERROR: No L10 NPCs in range!

label huntDone
echo Hunt finished.
goto exitScript

// Subroutine: Parse scout reports
label parseReports
set rpts $c.af.getReportCommands().receiveReportList(0,30,3)$
sleep 1
iferror $%rpts%.reportsArray$ gosubreturn

set rptIdx 0
label rptLoop
iferror $%rpts%.reportsArray[{%rptIdx%}]$ gosubreturn

set rptId $%rpts%.reportsArray[{%rptIdx%}].id$
set readRpt $c.af.getReportCommands().markAsRead(%rptId%)$
sleep 0.2

iferror $%readRpt%.report.content$ goto nextRpt
set content $%readRpt%.report.content$
set coord $%readRpt%.report.targetPos$

// Check for HH indicator
set hhCheck $c.getValue(String,%content%).indexOf(isHero="1")$
if {%hhCheck%>0} goto foundHHReport
goto nextRpt

label foundHHReport
echo !!! HH FOUND at %coord% !!!
addtoarray foundHH %foundHH.length% %coord%

label nextRpt
set rptIdx {%rptIdx%+1}
goto rptLoop

label exitScript
""",

    'run_task': """// BORG MASTER - Task Runner
// Executes scheduled tasks from master server
// Usage: includeurl http://localhost:8089/bridge/run_task?task=TAX_COLLECT

setsilence off
echo ==========================================
echo BORG MASTER - Task Runner
echo ==========================================

// Task configuration (set by URL params)
iferror %taskType% set taskType "unknown"

echo Running task: %taskType%

if {%taskType%==TAX_COLLECT} goto doTaxCollect
if {%taskType%==QUEST_COMPLETE} goto doQuestComplete
if {%taskType%==COLONY_LEVY} goto doColonyLevy
if {%taskType%==HH_HUNT} goto doHHHunt
if {%taskType%==OVERFLOW} goto doOverflow
goto unknownTask

label doTaxCollect
echo Collecting taxes from all cities...
set numCities $c.cm.castles.length$
set i 0
label taxLoop
if {%i%>=%numCities%} goto taskDone
selectcity %i%
sleep 500
settaxrate 100
levy tax
comfort disaster
echo Collected from city %i%
set i {%i%+1}
goto taxLoop

label doQuestComplete
echo Completing all quests...
completequests all
goto taskDone

label doColonyLevy
echo Levying from colonies...
colony levyfood all
sleep 500
colony levytax all
sleep 500
colony levyarmy all
goto taskDone

label doHHHunt
echo Starting HH Hunt...
includeurl http://localhost:8089/bridge/hh_hunt_pro
goto taskDone

label doOverflow
echo Running overflow exploit...
train a:6135037
sleep 500
cleartroopqueues
goto taskDone

label unknownTask
echo ERROR: Unknown task type: %taskType%

label taskDone
echo ==========================================
echo Task complete: %taskType%
echo ==========================================
""",

    'help': """// BORG MASTER - Bridge Scripts
// Available at http://localhost:8089/bridge/NAME
//
// SCRIPTS:
//   connect       - Establish connection to master server
//   report_state  - Report full account state
//   hh_hunt_pro   - Coordinated HH hunting
//   run_task      - Execute scheduled task
//   help          - This help message
//
// Usage in AutoEvony:
//   includeurl http://localhost:8089/bridge/connect
//   includeurl http://localhost:8089/bridge/hh_hunt_pro

echo Use: includeurl http://localhost:8089/bridge/SCRIPT_NAME
""",
}


# =============================================================================
# FASTAPI APPLICATION
# =============================================================================

if FASTAPI_AVAILABLE:
    
    # Initialize components
    db = DatabaseManager(DB_PATH)
    connections = ConnectionManager()
    
    @asynccontextmanager
    async def lifespan(app: FastAPI):
        print("=" * 70)
        print("BORG TOOLKIT EPIC 2026 - Master Server")
        print("=" * 70)
        print(f"\nServer: http://{HOST}:{PORT}")
        print(f"Dashboard: http://localhost:{PORT}/")
        print(f"API: http://localhost:{PORT}/api/")
        print(f"Bridge: http://localhost:{PORT}/bridge/")
        print("\nBridge Scripts for AutoEvony:")
        for name in BRIDGE_SCRIPTS.keys():
            print(f"  http://localhost:{PORT}/bridge/{name}")
        print("\n" + "=" * 70)
        yield
        print("\nServer shutting down...")
    
    app = FastAPI(
        title="Borg Toolkit Epic 2026",
        description="Multi-account Evony automation platform",
        version="2026.1.0",
        lifespan=lifespan
    )
    
    # CORS
    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )
    
    # =========================================================================
    # BRIDGE ENDPOINTS (AutoEvony scripts)
    # =========================================================================
    
    @app.get("/bridge/{script_name}")
    async def get_bridge_script(script_name: str, request: Request):
        """Serve bridge scripts to AutoEvony"""
        script_name = script_name.lower()
        if script_name in BRIDGE_SCRIPTS:
            script = BRIDGE_SCRIPTS[script_name]
            
            # Substitute URL parameters into script
            for key, value in request.query_params.items():
                script = f"set {key} {value}\n" + script
            
            return PlainTextResponse(script)
        return PlainTextResponse(BRIDGE_SCRIPTS['help'])
    
    # =========================================================================
    # REST API ENDPOINTS
    # =========================================================================
    
    @app.get("/api/accounts")
    async def list_accounts():
        """List all registered accounts"""
        accounts = db.get_accounts()
        online = connections.get_online_accounts()
        
        result = []
        for acc in accounts:
            acc_dict = asdict(acc)
            acc_dict['is_online'] = acc.id in online
            result.append(acc_dict)
        
        return {"accounts": result, "total": len(result), "online": len(online)}
    
    @app.post("/api/accounts")
    async def register_account(data: Dict):
        """Register new account"""
        account_id = data.get('id') or hashlib.md5(data.get('email', '').encode()).hexdigest()[:8]
        account = Account(
            id=account_id,
            name=data.get('name', 'Unknown'),
            email=data.get('email', ''),
            server=data.get('server', 'na1'),
            config=data.get('config', {})
        )
        db.save_account(account)
        db.log_event(account_id, 'ACCOUNT_REGISTERED', f"Account {account.name} registered")
        return {"success": True, "account": asdict(account)}
    
    @app.get("/api/accounts/{account_id}")
    async def get_account(account_id: str):
        """Get account details"""
        account = db.get_account(account_id)
        if not account:
            raise HTTPException(status_code=404, detail="Account not found")
        
        cities = db.get_cities(account_id)
        return {
            "account": asdict(account),
            "cities": [asdict(c) for c in cities],
            "is_online": account_id in connections.get_online_accounts()
        }
    
    @app.get("/api/cities")
    async def list_cities(account_id: str = None):
        """List cities"""
        cities = db.get_cities(account_id)
        return {"cities": [asdict(c) for c in cities], "total": len(cities)}
    
    @app.post("/api/report")
    async def receive_report(data: Dict):
        """Receive state report from AutoEvony"""
        account_id = data.get('account_id')
        if not account_id:
            return {"error": "Missing account_id"}
        
        # Update account status
        account = db.get_account(account_id)
        if account:
            account.status = "online"
            account.last_seen = datetime.now().isoformat()
            db.save_account(account)
        else:
            # Auto-register account
            account = Account(
                id=account_id,
                name=data.get('account_name', account_id),
                email="",
                server=data.get('server', 'unknown'),
                status="online",
                last_seen=datetime.now().isoformat()
            )
            db.save_account(account)
        
        # Update cities
        cities_data = data.get('cities', [])
        for city_data in cities_data:
            city = City(
                id=city_data.get('id', ''),
                account_id=account_id,
                name=city_data.get('name', ''),
                coords=city_data.get('coords', ''),
                level=city_data.get('level', 1),
                resources=city_data.get('resources', {}),
                heroes=city_data.get('heroes', []),
                troops=city_data.get('troops', {}),
                last_update=datetime.now().isoformat()
            )
            db.save_city(city)
        
        connections.update_state(account_id, data)
        db.log_event(account_id, 'STATE_REPORT', f"State report received")
        
        return {"success": True, "account_id": account_id}
    
    @app.post("/api/hh/report")
    async def report_hh_location(data: Dict):
        """Report found HH location"""
        hh = HHLocation(
            id=hashlib.md5(f"{data.get('coords')}{datetime.now()}".encode()).hexdigest()[:8],
            coords=data.get('coords', ''),
            hero_name=data.get('hero_name', 'Unknown'),
            found_by=data.get('account_id', 'unknown'),
            found_at=datetime.now().isoformat(),
            status='found',
            server=data.get('server', '')
        )
        db.save_hh_location(hh)
        db.log_event(hh.found_by, 'HH_FOUND', f"HH found at {hh.coords}: {hh.hero_name}")
        
        # Broadcast to all connected accounts
        await connections.broadcast({
            'type': 'HH_ALERT',
            'coords': hh.coords,
            'hero_name': hh.hero_name,
            'found_by': hh.found_by
        })
        
        return {"success": True, "hh": asdict(hh)}
    
    @app.get("/api/hh")
    async def list_hh_locations(status: str = None):
        """List HH locations"""
        locations = db.get_hh_locations(status)
        return {"locations": [asdict(loc) for loc in locations], "total": len(locations)}
    
    @app.get("/api/events")
    async def list_events(limit: int = 100):
        """Get recent events"""
        events = db.get_events(limit)
        return {"events": events, "total": len(events)}
    
    @app.post("/api/command/{account_id}")
    async def send_command(account_id: str, data: Dict):
        """Send command to specific account"""
        success = await connections.send_command(account_id, data)
        if not success:
            raise HTTPException(status_code=404, detail="Account not online")
        return {"success": True}
    
    @app.get("/api/status")
    async def server_status():
        """Get server status"""
        return {
            "status": "online",
            "version": "2026.1.0",
            "accounts_registered": len(db.get_accounts()),
            "accounts_online": len(connections.get_online_accounts()),
            "cities_tracked": len(db.get_cities()),
            "hh_found": len(db.get_hh_locations())
        }
    
    # =========================================================================
    # WEBSOCKET ENDPOINT
    # =========================================================================
    
    @app.websocket("/ws/{account_id}")
    async def websocket_endpoint(websocket: WebSocket, account_id: str):
        """WebSocket connection for real-time sync"""
        await connections.connect(websocket, account_id)
        
        # Update account status
        account = db.get_account(account_id)
        if account:
            account.status = "online"
            account.last_seen = datetime.now().isoformat()
            db.save_account(account)
        
        try:
            while True:
                data = await websocket.receive_json()
                
                # Handle different message types
                msg_type = data.get('type', '')
                
                if msg_type == 'heartbeat':
                    connections.update_state(account_id, data)
                    await websocket.send_json({"type": "heartbeat_ack"})
                
                elif msg_type == 'state_update':
                    connections.update_state(account_id, data)
                    # Save to database
                    for city_data in data.get('cities', []):
                        city = City(
                            id=city_data.get('id'),
                            account_id=account_id,
                            name=city_data.get('name'),
                            coords=city_data.get('coords'),
                            resources=city_data.get('resources', {}),
                            last_update=datetime.now().isoformat()
                        )
                        db.save_city(city)
                
                elif msg_type == 'hh_found':
                    # Report HH location
                    hh = HHLocation(
                        id=hashlib.md5(f"{data.get('coords')}{datetime.now()}".encode()).hexdigest()[:8],
                        coords=data.get('coords'),
                        hero_name=data.get('hero_name', 'Unknown'),
                        found_by=account_id,
                        found_at=datetime.now().isoformat(),
                        server=data.get('server', '')
                    )
                    db.save_hh_location(hh)
                    # Alert all accounts
                    await connections.broadcast({
                        'type': 'HH_ALERT',
                        'coords': hh.coords,
                        'hero_name': hh.hero_name
                    })
                
                elif msg_type == 'event':
                    db.log_event(account_id, data.get('event_type', 'UNKNOWN'), 
                                data.get('message', ''), data.get('data'))
                
        except WebSocketDisconnect:
            connections.disconnect(account_id)
            # Update account status
            account = db.get_account(account_id)
            if account:
                account.status = "offline"
                db.save_account(account)
    
    # =========================================================================
    # WEB DASHBOARD
    # =========================================================================
    
    @app.get("/", response_class=HTMLResponse)
    async def dashboard():
        """Web dashboard"""
        accounts = db.get_accounts()
        online = connections.get_online_accounts()
        cities = db.get_cities()
        hh_locs = db.get_hh_locations()
        events = db.get_events(20)
        
        html = f"""
<!DOCTYPE html>
<html>
<head>
    <title>Borg Toolkit Epic 2026</title>
    <style>
        * {{ margin: 0; padding: 0; box-sizing: border-box; }}
        body {{ 
            font-family: 'Segoe UI', sans-serif; 
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: #e0e0e0;
            min-height: 100vh;
        }}
        .header {{
            background: rgba(0,0,0,0.3);
            padding: 20px;
            text-align: center;
            border-bottom: 2px solid #00d4ff;
        }}
        .header h1 {{
            color: #00d4ff;
            font-size: 2.5em;
            text-shadow: 0 0 20px rgba(0,212,255,0.5);
        }}
        .header .subtitle {{ color: #888; margin-top: 5px; }}
        .container {{ 
            max-width: 1400px; 
            margin: 0 auto; 
            padding: 20px;
        }}
        .grid {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }}
        .card {{
            background: rgba(255,255,255,0.05);
            border-radius: 15px;
            padding: 20px;
            border: 1px solid rgba(0,212,255,0.2);
            backdrop-filter: blur(10px);
        }}
        .card h2 {{
            color: #00d4ff;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid rgba(0,212,255,0.3);
        }}
        .stat {{
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }}
        .stat-value {{
            color: #00ff88;
            font-weight: bold;
            font-size: 1.2em;
        }}
        .status-online {{ color: #00ff88; }}
        .status-offline {{ color: #ff6b6b; }}
        .account-item {{
            background: rgba(0,0,0,0.2);
            padding: 12px;
            margin: 8px 0;
            border-radius: 8px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }}
        .hh-item {{
            background: linear-gradient(135deg, rgba(255,215,0,0.1), rgba(255,165,0,0.1));
            border: 1px solid rgba(255,215,0,0.3);
            padding: 12px;
            margin: 8px 0;
            border-radius: 8px;
        }}
        .hh-item .coords {{ color: #ffd700; font-weight: bold; }}
        .event-item {{
            padding: 8px 0;
            border-bottom: 1px solid rgba(255,255,255,0.05);
            font-size: 0.9em;
        }}
        .event-time {{ color: #666; font-size: 0.8em; }}
        .btn {{
            background: linear-gradient(135deg, #00d4ff, #0099cc);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            margin: 5px;
        }}
        .btn:hover {{ opacity: 0.8; }}
        .quick-actions {{
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 15px;
        }}
        .refresh {{ 
            position: fixed; 
            bottom: 20px; 
            right: 20px; 
            background: #00d4ff;
            padding: 15px 25px;
            border-radius: 50px;
            cursor: pointer;
            box-shadow: 0 5px 20px rgba(0,212,255,0.4);
        }}
    </style>
</head>
<body>
    <div class="header">
        <h1>⚡ BORG TOOLKIT EPIC 2026</h1>
        <div class="subtitle">Multi-Account Evony Automation Platform</div>
    </div>
    
    <div class="container">
        <div class="grid">
            <!-- Status Overview -->
            <div class="card">
                <h2>📊 System Status</h2>
                <div class="stat">
                    <span>Accounts Registered</span>
                    <span class="stat-value">{len(accounts)}</span>
                </div>
                <div class="stat">
                    <span>Accounts Online</span>
                    <span class="stat-value status-online">{len(online)}</span>
                </div>
                <div class="stat">
                    <span>Cities Tracked</span>
                    <span class="stat-value">{len(cities)}</span>
                </div>
                <div class="stat">
                    <span>HH Found</span>
                    <span class="stat-value" style="color: #ffd700;">{len(hh_locs)}</span>
                </div>
            </div>
            
            <!-- Accounts -->
            <div class="card">
                <h2>👥 Accounts</h2>
                {"".join(f'''
                <div class="account-item">
                    <div>
                        <strong>{acc.name}</strong>
                        <div style="font-size:0.8em;color:#666;">{acc.server}</div>
                    </div>
                    <span class="{"status-online" if acc.id in online else "status-offline"}">
                        {"● ONLINE" if acc.id in online else "○ OFFLINE"}
                    </span>
                </div>
                ''' for acc in accounts) or '<p style="color:#666;">No accounts registered</p>'}
            </div>
            
            <!-- HH Locations -->
            <div class="card">
                <h2>🏆 Historic Heroes Found</h2>
                {"".join(f'''
                <div class="hh-item">
                    <div class="coords">📍 {hh.coords}</div>
                    <div>{hh.hero_name}</div>
                    <div style="font-size:0.8em;color:#888;">Found by {hh.found_by}</div>
                </div>
                ''' for hh in hh_locs[:5]) or '<p style="color:#666;">No HH found yet</p>'}
            </div>
            
            <!-- Quick Actions -->
            <div class="card">
                <h2>⚡ Quick Actions</h2>
                <p style="margin-bottom:15px;color:#888;">Run on all online accounts:</p>
                <div class="quick-actions">
                    <button class="btn" onclick="runTask('TAX_COLLECT')">💰 Collect Taxes</button>
                    <button class="btn" onclick="runTask('QUEST_COMPLETE')">📜 Complete Quests</button>
                    <button class="btn" onclick="runTask('HH_HUNT')">🏆 HH Hunt</button>
                    <button class="btn" onclick="runTask('COLONY_LEVY')">🏰 Colony Levy</button>
                </div>
            </div>
            
            <!-- Recent Events -->
            <div class="card" style="grid-column: span 2;">
                <h2>📋 Recent Events</h2>
                {"".join(f'''
                <div class="event-item">
                    <span class="event-time">{evt["timestamp"][:19]}</span>
                    <strong>[{evt["event_type"]}]</strong> {evt["message"]}
                </div>
                ''' for evt in events[:10]) or '<p style="color:#666;">No events yet</p>'}
            </div>
            
            <!-- Bridge Scripts -->
            <div class="card">
                <h2>🔗 AutoEvony Bridge</h2>
                <p style="margin-bottom:15px;color:#888;">Use in AutoEvony:</p>
                <div style="background:rgba(0,0,0,0.3);padding:15px;border-radius:8px;font-family:monospace;font-size:0.9em;">
                    includeurl http://localhost:{PORT}/bridge/connect<br><br>
                    includeurl http://localhost:{PORT}/bridge/hh_hunt_pro<br><br>
                    includeurl http://localhost:{PORT}/bridge/report_state
                </div>
            </div>
            
            <!-- API Info -->
            <div class="card">
                <h2>🔌 API Endpoints</h2>
                <div style="font-family:monospace;font-size:0.9em;">
                    <div class="stat"><span>GET</span><span>/api/accounts</span></div>
                    <div class="stat"><span>GET</span><span>/api/cities</span></div>
                    <div class="stat"><span>GET</span><span>/api/hh</span></div>
                    <div class="stat"><span>GET</span><span>/api/events</span></div>
                    <div class="stat"><span>POST</span><span>/api/report</span></div>
                    <div class="stat"><span>WS</span><span>/ws/{{account_id}}</span></div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="refresh" onclick="location.reload()">🔄 Refresh</div>
    
    <script>
        function runTask(taskType) {{
            fetch('/api/broadcast', {{
                method: 'POST',
                headers: {{'Content-Type': 'application/json'}},
                body: JSON.stringify({{task: taskType}})
            }}).then(() => alert('Task ' + taskType + ' sent to all online accounts'));
        }}
        
        // Auto-refresh every 30 seconds
        setTimeout(() => location.reload(), 30000);
    </script>
</body>
</html>
        """
        return HTMLResponse(content=html)
    
    @app.post("/api/broadcast")
    async def broadcast_task(data: Dict):
        """Broadcast task to all online accounts"""
        task = data.get('task', '')
        await connections.broadcast({'type': 'RUN_TASK', 'task': task})
        return {"success": True, "task": task, "recipients": len(connections.get_online_accounts())}


# =============================================================================
# MAIN
# =============================================================================

def main():
    if not FASTAPI_AVAILABLE:
        print("ERROR: FastAPI not installed")
        print("Run: pip install fastapi uvicorn")
        return
    
    uvicorn.run(app, host=HOST, port=PORT)


if __name__ == "__main__":
    main()
