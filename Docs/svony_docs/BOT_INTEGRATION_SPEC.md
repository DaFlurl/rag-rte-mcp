# BOT INTEGRATION SPECIFICATION
## Connecting Svony Studio to Live Game Servers

**Purpose:** Enable real-time bot control, testing, and debugging through Svony Studio  
**Target:** Full RoboEvony/AutoEvony feature parity + enhanced debugging

---

## 🎯 ARCHITECTURE OVERVIEW

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         SVONY STUDIO BOT ARCHITECTURE                        │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────────┐     ┌─────────────┐     ┌─────────────┐                   │
│  │   SVONY     │     │    BOT      │     │   EVONY     │                   │
│  │   STUDIO    │◀───▶│   ENGINE    │◀───▶│   SERVER    │                   │
│  │    (UI)     │     │  (Python)   │     │   (AMF)     │                   │
│  └─────────────┘     └─────────────┘     └─────────────┘                   │
│        │                   │                   │                            │
│        │                   │                   │                            │
│        ▼                   ▼                   ▼                            │
│  ┌─────────────┐     ┌─────────────┐     ┌─────────────┐                   │
│  │   SCRIPT    │     │   DEBUG     │     │    TOR      │                   │
│  │   EDITOR    │     │   PROXY     │     │   PROXY     │                   │
│  └─────────────┘     └─────────────┘     └─────────────┘                   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 🔌 AMF PROTOCOL INTEGRATION

### AMF Connection Handler

```python
class EvonyAMFClient:
    """
    AMF3 client for connecting to Evony game servers.
    Handles authentication, session management, and command execution.
    """
    
    def __init__(self, server: str, port: int = 443):
        self.server = server
        self.port = port
        self.session_id = None
        self.player_data = None
        self.cities = {}
        self.callbacks = {}
        
    async def connect(self, username: str, password: str) -> bool:
        """
        Connect to game server:
        1. Establish AMF connection
        2. Send login command
        3. Receive session token
        4. Load initial game state
        """
        # Create AMF connection
        self.connection = AMFConnection(self.server, self.port)
        await self.connection.connect()
        
        # Login
        login_response = await self.send_command("login.login", {
            "username": username,
            "password": self._hash_password(password)
        })
        
        if login_response.get("ok"):
            self.session_id = login_response["sessionId"]
            await self._load_initial_state()
            return True
        
        return False
    
    async def send_command(self, command: str, params: dict) -> dict:
        """Send AMF command and wait for response"""
        request = AMFRequest(
            command=command,
            params=params,
            session_id=self.session_id
        )
        
        # Notify interceptors
        for callback in self.callbacks.get("on_request", []):
            callback(request)
        
        response = await self.connection.send(request)
        
        # Notify interceptors
        for callback in self.callbacks.get("on_response", []):
            callback(response)
        
        return response.data
    
    async def _load_initial_state(self):
        """Load all cities and player data"""
        # Get player info
        self.player_data = await self.send_command("castle.getPlayerInfo", {})
        
        # Get all cities
        cities_data = await self.send_command("castle.getAllCastles", {})
        for city in cities_data["castles"]:
            self.cities[city["id"]] = City(city)
    
    # === GAME COMMANDS ===
    
    async def get_troops(self, city_id: int) -> dict:
        """Get troop counts for a city"""
        return await self.send_command("castle.getTroops", {"castleId": city_id})
    
    async def get_resources(self, city_id: int) -> dict:
        """Get resource counts for a city"""
        return await self.send_command("castle.getResources", {"castleId": city_id})
    
    async def train_troops(self, city_id: int, troop_type: str, amount: int) -> dict:
        """Start troop training"""
        return await self.send_command("castle.trainTroops", {
            "castleId": city_id,
            "troopType": troop_type,
            "amount": amount
        })
    
    async def send_army(self, city_id: int, target: tuple, troops: dict, 
                        mission: str, hero_id: int = None) -> dict:
        """Deploy army to target"""
        return await self.send_command("army.sendArmy", {
            "castleId": city_id,
            "targetX": target[0],
            "targetY": target[1],
            "troops": troops,
            "mission": mission,
            "heroId": hero_id
        })
    
    async def get_map_data(self, x: int, y: int, radius: int = 10) -> dict:
        """Get map tiles around coordinates"""
        return await self.send_command("map.getRegion", {
            "x": x,
            "y": y,
            "radius": radius
        })
```

---

## 🤖 BOT ENGINE

### Bot Controller

```python
class BotController:
    """
    High-level bot controller that manages automated actions.
    Coordinates between AMF client, scripts, and UI.
    """
    
    def __init__(self, client: EvonyAMFClient):
        self.client = client
        self.scripts = {}
        self.active_scripts = []
        self.city_managers = {}
        self.running = False
        self.paused = False
        
    def add_city(self, city_id: int):
        """Add city to bot management"""
        city = self.client.cities[city_id]
        self.city_managers[city_id] = CityManager(city, self.client)
    
    def load_script(self, script_path: str) -> Script:
        """Load and parse bot script"""
        with open(script_path) as f:
            content = f.read()
        
        script = ScriptParser.parse(content)
        self.scripts[script.name] = script
        return script
    
    def run_script(self, script_name: str, city_id: int = None):
        """Execute script for specific city or all cities"""
        script = self.scripts[script_name]
        
        if city_id:
            cities = [city_id]
        else:
            cities = list(self.city_managers.keys())
        
        for cid in cities:
            executor = ScriptExecutor(script, self.city_managers[cid])
            self.active_scripts.append(executor)
            executor.start()
    
    def pause_all(self):
        """Pause all running scripts"""
        self.paused = True
        for script in self.active_scripts:
            script.pause()
    
    def resume_all(self):
        """Resume paused scripts"""
        self.paused = False
        for script in self.active_scripts:
            script.resume()
    
    def stop_all(self):
        """Stop all scripts"""
        self.running = False
        for script in self.active_scripts:
            script.stop()
        self.active_scripts.clear()


class CityManager:
    """
    Manages automation for a single city.
    Handles resource management, troop training, building upgrades.
    """
    
    def __init__(self, city: City, client: EvonyAMFClient):
        self.city = city
        self.client = client
        self.goals = {}
        self.config = CityConfig()
        
    async def update_state(self):
        """Refresh city state from server"""
        self.city.troops = await self.client.get_troops(self.city.id)
        self.city.resources = await self.client.get_resources(self.city.id)
    
    def set_goal(self, goal_type: str, value):
        """Set automation goal"""
        self.goals[goal_type] = value
    
    async def run_automation_cycle(self):
        """Execute one automation cycle"""
        await self.update_state()
        
        # Check goals and execute actions
        for goal_type, target in self.goals.items():
            if goal_type == "troops":
                await self._manage_troop_training(target)
            elif goal_type == "resources":
                await self._manage_resources(target)
            elif goal_type == "buildings":
                await self._manage_buildings(target)
```

---

## 📜 SCRIPT ENGINE

### Script Language Specification

```
# Bot Script Language Specification
# Compatible with RoboEvony/AutoEvony scripts

# Variable Declaration
set variable_name value
setarray array_name ["val1", "val2", "val3"]

# Labels and Goto
label my_label
goto my_label

# Conditionals
if {condition} action
if {%variable%>100} goto loop

# Loops
loop count action
loop 10 train worker 100

# City Commands
train troop_type amount
build building_type
upgrade building_name
march target_x target_y mission troops

# Resource Commands
comfort level
tax_rate level
trade resource_type amount

# Hero Commands
hero_assign hero_name city_name
hero_recall hero_name

# Timing
wait seconds
wait_until time

# Logging
log "message"
logmsg "color" "message"

# Special Variables
%city%          - Current city name
%troops.worker% - Worker count
%resources.food% - Food amount
%time%          - Current time
```

### Script Parser

```python
class ScriptParser:
    """
    Parse RoboEvony-compatible bot scripts.
    Supports variables, labels, conditionals, loops.
    """
    
    COMMANDS = {
        "set": SetCommand,
        "setarray": SetArrayCommand,
        "label": LabelCommand,
        "goto": GotoCommand,
        "if": IfCommand,
        "loop": LoopCommand,
        "train": TrainCommand,
        "build": BuildCommand,
        "march": MarchCommand,
        "wait": WaitCommand,
        "log": LogCommand,
    }
    
    @classmethod
    def parse(cls, content: str) -> Script:
        """Parse script content into executable Script object"""
        lines = content.strip().split("\n")
        script = Script()
        
        for line_num, line in enumerate(lines, 1):
            line = line.strip()
            
            # Skip empty lines and comments
            if not line or line.startswith("#"):
                continue
            
            # Parse command
            parts = cls._tokenize(line)
            command_name = parts[0].lower()
            
            if command_name in cls.COMMANDS:
                command = cls.COMMANDS[command_name](parts[1:], line_num)
                script.add_command(command)
            else:
                raise ScriptSyntaxError(f"Unknown command: {command_name}", line_num)
        
        return script


class ScriptExecutor:
    """
    Execute parsed scripts with debugging support.
    """
    
    def __init__(self, script: Script, city_manager: CityManager):
        self.script = script
        self.city = city_manager
        self.variables = {}
        self.instruction_pointer = 0
        self.running = False
        self.paused = False
        self.breakpoints = set()
        self.step_mode = False
        
    async def run(self):
        """Execute script"""
        self.running = True
        
        while self.running and self.instruction_pointer < len(self.script.commands):
            # Check breakpoints
            if self.instruction_pointer in self.breakpoints:
                self.paused = True
                await self._wait_for_resume()
            
            # Check step mode
            if self.step_mode:
                self.paused = True
                await self._wait_for_resume()
            
            # Execute current command
            command = self.script.commands[self.instruction_pointer]
            await self._execute_command(command)
            
            self.instruction_pointer += 1
    
    async def _execute_command(self, command: Command):
        """Execute single command"""
        # Substitute variables
        resolved_command = self._resolve_variables(command)
        
        # Execute based on type
        if isinstance(command, TrainCommand):
            await self.city.client.train_troops(
                self.city.city.id,
                resolved_command.troop_type,
                resolved_command.amount
            )
        elif isinstance(command, MarchCommand):
            await self.city.client.send_army(
                self.city.city.id,
                (resolved_command.target_x, resolved_command.target_y),
                resolved_command.troops,
                resolved_command.mission
            )
        # ... other command types
```

---

## 🖥️ UI COMPONENTS FOR BOT

### Multi-City Tab Panel

```python
class MultiCityTabPanel(ttk.Frame):
    """
    Tabbed interface for managing multiple cities.
    Each tab shows city info, troops, and controls.
    """
    
    def __init__(self, parent, bot_controller: BotController):
        super().__init__(parent)
        self.bot = bot_controller
        self.city_tabs = {}
        self._create_ui()
    
    def _create_ui(self):
        # Tab container
        self.notebook = ttk.Notebook(self)
        self.notebook.pack(fill="both", expand=True)
        
        # Add tab for each city
        for city_id, manager in self.bot.city_managers.items():
            tab = CityTab(self.notebook, manager)
            self.notebook.add(tab, text=f"{manager.city.name}({manager.city.coords})")
            self.city_tabs[city_id] = tab
    
    def update_all(self):
        """Refresh all city tabs"""
        for tab in self.city_tabs.values():
            tab.update()


class CityTab(ttk.Frame):
    """
    Single city management tab.
    Shows troops, resources, and city-specific controls.
    """
    
    def __init__(self, parent, city_manager: CityManager):
        super().__init__(parent)
        self.manager = city_manager
        self._create_ui()
    
    def _create_ui(self):
        # === TOP: City Info ===
        info_frame = ttk.Frame(self)
        info_frame.pack(fill="x", padx=5, pady=5)
        
        self.name_label = ttk.Label(info_frame, text=self.manager.city.name, 
                                     font=("Arial", 14, "bold"))
        self.name_label.pack(side="left")
        
        self.coords_label = ttk.Label(info_frame, text=f"({self.manager.city.x}, {self.manager.city.y})")
        self.coords_label.pack(side="left", padx=10)
        
        # Resource bars
        self.resources_frame = ResourceBarsFrame(self)
        self.resources_frame.pack(fill="x", padx=5)
        
        # === MIDDLE: Troop Table ===
        self.troop_table = TroopTableWidget(self)
        self.troop_table.pack(fill="both", expand=True, padx=5, pady=5)
        
        # === BOTTOM: Quick Actions ===
        actions_frame = ttk.Frame(self)
        actions_frame.pack(fill="x", padx=5, pady=5)
        
        ttk.Button(actions_frame, text="March", command=self._show_march_dialog).pack(side="left")
        ttk.Button(actions_frame, text="Set Goals", command=self._show_goals_dialog).pack(side="left")
        ttk.Button(actions_frame, text="Save", command=self._save_config).pack(side="left")
        ttk.Button(actions_frame, text="Load", command=self._load_config).pack(side="left")


class TroopTableWidget(ttk.Frame):
    """
    Troop count table matching RoboEvony layout.
    """
    
    TROOP_TYPES = [
        ("worker", "Worker (wo)"),
        ("warrior", "Warrior (w)"),
        ("scout", "Scout (s)"),
        ("pikemen", "Pikemen (p)"),
        ("swordsmen", "Swordsmen (sw)"),
        ("archer", "Archer (a)"),
        ("cavalry", "Cavalry (c)"),
        ("cataphract", "Cataphract (cata)"),
        ("transport", "Transport (t)"),
        ("ballista", "Ballista (b)"),
        ("battering_ram", "Battering Ram (r)"),
        ("catapult", "Catapult (cp)"),
    ]
    
    COLUMNS = ["Troop", "Avail", "Total", "All", "Queue", "Goal", "Remain", "Reinf."]
    
    def __init__(self, parent):
        super().__init__(parent)
        self._create_table()
    
    def _create_table(self):
        # Create treeview
        self.tree = ttk.Treeview(self, columns=self.COLUMNS[1:], show="headings")
        
        for col in self.COLUMNS:
            self.tree.heading(col, text=col)
            self.tree.column(col, width=80)
        
        self.tree.pack(fill="both", expand=True)
        
        # Add scrollbar
        scrollbar = ttk.Scrollbar(self, orient="vertical", command=self.tree.yview)
        self.tree.configure(yscrollcommand=scrollbar.set)
        scrollbar.pack(side="right", fill="y")
    
    def update_troops(self, troops_data: dict):
        """Update table with troop data"""
        self.tree.delete(*self.tree.get_children())
        
        for troop_id, troop_name in self.TROOP_TYPES:
            data = troops_data.get(troop_id, {})
            self.tree.insert("", "end", values=(
                troop_name,
                self._format_number(data.get("available", 0)),
                self._format_number(data.get("total", 0)),
                self._format_number(data.get("all", 0)),
                data.get("queue", 0),
                data.get("goal", 0),
                data.get("remaining", 0),
                data.get("reinforcing", 0)
            ))
    
    def _format_number(self, num: int) -> str:
        """Format large numbers (e.g., 1.5b, 500m, 10k)"""
        if num >= 1_000_000_000:
            return f"{num/1_000_000_000:.2f}b"
        elif num >= 1_000_000:
            return f"{num/1_000_000:.2f}m"
        elif num >= 1_000:
            return f"{num/1_000:.1f}k"
        return str(num)
```

---

## 🔧 IMPLEMENTATION PRIORITY

### Phase 1: Core Connection (Week 1-2)
1. AMF protocol implementation
2. Login/authentication
3. Basic city data retrieval
4. Troop table display
5. Resource monitoring

### Phase 2: Bot Engine (Week 3-4)
6. Script parser
7. Script executor
8. City manager
9. Goal system
10. Basic automation

### Phase 3: Full UI (Week 5-6)
11. Multi-city tabs
12. Army deployment dialog
13. Hero management
14. Map viewer
15. Chat integration

### Phase 4: Advanced Features (Week 7-8)
16. Script debugging
17. Protocol replay
18. Real-time editing
19. Performance optimization
20. Error recovery

---

**This specification provides the complete architecture for integrating bot functionality into Svony Studio with full RoboEvony feature parity.**
