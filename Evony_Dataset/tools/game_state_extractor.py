"""
Game State Extractor - Extract Live Game Data from Packets

Extracts real-time game state from intercepted traffic:
- Resources (gold, food, wood, stone, iron, population)
- Troops (counts by type, training queues)
- Buildings (levels, upgrade status)
- Technologies (research progress)
"""

import logging
import time
import json
from dataclasses import dataclass, field
from enum import Enum
from typing import Dict, Optional, List, Any, Callable
from collections import defaultdict
import threading

logger = logging.getLogger(__name__)


class ResourceType(Enum):
    """Game resource types"""
    GOLD = "gold"
    FOOD = "food"
    WOOD = "wood"
    STONE = "stone"
    IRON = "iron"
    POPULATION = "population"
    IDLE_POPULATION = "idle_population"
    CENTS = "cents"  # Premium currency
    AMULETS = "amulets"


class TroopType(Enum):
    """Game troop types"""
    WORKER = "worker"
    WARRIOR = "warrior"
    SCOUT = "scout"
    PIKEMAN = "pikeman"
    SWORDSMAN = "swordsman"
    ARCHER = "archer"
    CAVALRY = "cavalry"
    CATAPHRACT = "cataphract"
    TRANSPORTER = "transporter"
    BALLISTA = "ballista"
    BATTERING_RAM = "battering_ram"
    CATAPULT = "catapult"


class BuildingType(Enum):
    """Game building types"""
    TOWN_HALL = "town_hall"
    COTTAGE = "cottage"
    BARRACKS = "barracks"
    INN = "inn"
    FEASTING_HALL = "feasting_hall"
    EMBASSY = "embassy"
    MARKETPLACE = "marketplace"
    ACADEMY = "academy"
    RALLY_SPOT = "rally_spot"
    BEACON_TOWER = "beacon_tower"
    FORGE = "forge"
    WORKSHOP = "workshop"
    RELIEF_STATION = "relief_station"
    STABLE = "stable"
    WALLS = "walls"
    WAREHOUSE = "warehouse"
    FARM = "farm"
    SAWMILL = "sawmill"
    QUARRY = "quarry"
    IRONMINE = "ironmine"


@dataclass
class ResourceData:
    """Resource data for a city"""
    city_id: int
    resources: Dict[str, int] = field(default_factory=dict)
    production: Dict[str, float] = field(default_factory=dict)
    capacity: Dict[str, int] = field(default_factory=dict)
    last_updated: float = field(default_factory=time.time)
    
    def get(self, resource_type: ResourceType) -> int:
        return self.resources.get(resource_type.value, 0)
        
    def to_dict(self) -> Dict:
        return {
            "city_id": self.city_id,
            "resources": self.resources,
            "production": self.production,
            "capacity": self.capacity,
            "last_updated": self.last_updated,
        }


@dataclass
class TroopData:
    """Troop data for a city"""
    city_id: int
    troops: Dict[str, int] = field(default_factory=dict)
    training: Dict[str, List[Dict]] = field(default_factory=dict)
    wounded: Dict[str, int] = field(default_factory=dict)
    marching: Dict[str, int] = field(default_factory=dict)
    last_updated: float = field(default_factory=time.time)
    
    def get_count(self, troop_type: TroopType) -> int:
        return self.troops.get(troop_type.value, 0)
        
    def get_total(self) -> int:
        return sum(self.troops.values())
        
    def to_dict(self) -> Dict:
        return {
            "city_id": self.city_id,
            "troops": self.troops,
            "training": self.training,
            "wounded": self.wounded,
            "marching": self.marching,
            "total": self.get_total(),
            "last_updated": self.last_updated,
        }


@dataclass
class BuildingData:
    """Building data for a city"""
    city_id: int
    buildings: Dict[int, Dict] = field(default_factory=dict)  # slot -> info
    upgrading: List[Dict] = field(default_factory=list)
    last_updated: float = field(default_factory=time.time)
    
    def get_level(self, building_type: BuildingType) -> int:
        for slot, info in self.buildings.items():
            if info.get("type") == building_type.value:
                return info.get("level", 0)
        return 0
        
    def to_dict(self) -> Dict:
        return {
            "city_id": self.city_id,
            "buildings": self.buildings,
            "upgrading": self.upgrading,
            "last_updated": self.last_updated,
        }


@dataclass
class GameState:
    """Complete game state for an account"""
    player_id: int
    player_name: str = ""
    alliance_id: int = 0
    alliance_name: str = ""
    cities: Dict[int, Dict] = field(default_factory=dict)
    resources: Dict[int, ResourceData] = field(default_factory=dict)
    troops: Dict[int, TroopData] = field(default_factory=dict)
    buildings: Dict[int, BuildingData] = field(default_factory=dict)
    heroes: List[Dict] = field(default_factory=list)
    items: List[Dict] = field(default_factory=list)
    quests: List[Dict] = field(default_factory=list)
    buffs: List[Dict] = field(default_factory=list)
    last_updated: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict:
        return {
            "player_id": self.player_id,
            "player_name": self.player_name,
            "alliance": {"id": self.alliance_id, "name": self.alliance_name},
            "cities": self.cities,
            "resources": {k: v.to_dict() for k, v in self.resources.items()},
            "troops": {k: v.to_dict() for k, v in self.troops.items()},
            "buildings": {k: v.to_dict() for k, v in self.buildings.items()},
            "heroes": self.heroes,
            "items": self.items,
            "quests": self.quests,
            "buffs": self.buffs,
            "last_updated": self.last_updated,
        }


class GameStateExtractor:
    """
    Extracts game state from intercepted packets.
    
    Features:
    - Real-time resource tracking
    - Troop count monitoring
    - Building level tracking
    - Hero and item inventory
    - Quest and buff status
    """
    
    # Packet command IDs that contain game state data
    STATE_COMMANDS = {
        0x8001: "login_response",      # Initial state on login
        0x9002: "player_update",       # Player info changes
        0x9003: "resource_update",     # Resource changes
        0x8301: "troop_update",        # Troop changes
        0x8101: "building_update",     # Building changes
        0x9001: "world_update",        # Map/world changes
    }
    
    def __init__(self):
        self._states: Dict[int, GameState] = {}  # player_id -> state
        self._lock = threading.RLock()
        
        # Callbacks
        self._on_update_callbacks: List[Callable[[int, str, Any], None]] = []
        
        # Statistics
        self._stats = defaultdict(int)
        
    def extract_from_packet(self, packet_data: Dict, 
                           command_id: int = 0) -> Optional[Dict]:
        """Extract game state from a decoded packet"""
        with self._lock:
            try:
                # Determine extraction method
                if command_id in self.STATE_COMMANDS:
                    method_name = f"_extract_{self.STATE_COMMANDS[command_id]}"
                    if hasattr(self, method_name):
                        return getattr(self, method_name)(packet_data)
                        
                # Try generic extraction
                return self._extract_generic(packet_data)
                
            except Exception as e:
                logger.error(f"Extraction error: {e}")
                return None
                
    def get_state(self, player_id: int) -> Optional[GameState]:
        """Get current state for a player"""
        return self._states.get(player_id)
        
    def get_all_states(self) -> Dict[int, GameState]:
        """Get all tracked states"""
        return dict(self._states)
        
    def on_update(self, callback: Callable[[int, str, Any], None]):
        """Register callback for state updates"""
        self._on_update_callbacks.append(callback)
        
    def get_statistics(self) -> Dict:
        """Get extraction statistics"""
        return {
            "tracked_players": len(self._states),
            "extractions": dict(self._stats),
        }
        
    def export_state(self, player_id: int, path: str):
        """Export state to JSON file"""
        state = self.get_state(player_id)
        if state:
            with open(path, "w") as f:
                json.dump(state.to_dict(), f, indent=2)
                
    # ========== Extraction Methods ==========
    
    def _extract_login_response(self, data: Dict) -> Dict:
        """Extract initial state from login response"""
        player_id = data.get("playerId") or data.get("player_id") or data.get("uid", 0)
        
        if not player_id:
            return {}
            
        # Create or update state
        if player_id not in self._states:
            self._states[player_id] = GameState(player_id=player_id)
            
        state = self._states[player_id]
        
        # Extract player info
        player_info = data.get("player", {})
        state.player_name = player_info.get("name", "")
        state.alliance_id = player_info.get("allianceId", 0)
        state.alliance_name = player_info.get("allianceName", "")
        
        # Extract cities
        cities = data.get("cities", [])
        for city in cities:
            city_id = city.get("id", 0)
            state.cities[city_id] = {
                "id": city_id,
                "name": city.get("name", ""),
                "x": city.get("x", 0),
                "y": city.get("y", 0),
                "level": city.get("level", 1),
            }
            
            # Extract resources for city
            if "resource" in city:
                state.resources[city_id] = self._parse_resources(city_id, city["resource"])
                
            # Extract troops for city
            if "troops" in city or "troop" in city:
                state.troops[city_id] = self._parse_troops(city_id, city.get("troops") or city.get("troop", {}))
                
            # Extract buildings for city
            if "buildings" in city:
                state.buildings[city_id] = self._parse_buildings(city_id, city["buildings"])
                
        # Extract heroes
        state.heroes = data.get("heroes", [])
        
        # Extract items
        state.items = data.get("items", [])
        
        state.last_updated = time.time()
        self._stats["login_extractions"] += 1
        
        self._notify_update(player_id, "login", state.to_dict())
        
        return state.to_dict()
        
    def _extract_resource_update(self, data: Dict) -> Dict:
        """Extract resource update"""
        player_id = data.get("playerId", 0)
        city_id = data.get("cityId", 0)
        
        if player_id not in self._states:
            return {}
            
        state = self._states[player_id]
        
        if "resource" in data:
            state.resources[city_id] = self._parse_resources(city_id, data["resource"])
            state.last_updated = time.time()
            self._stats["resource_extractions"] += 1
            
            self._notify_update(player_id, "resource", state.resources[city_id].to_dict())
            
        return state.resources.get(city_id, ResourceData(city_id)).to_dict()
        
    def _extract_troop_update(self, data: Dict) -> Dict:
        """Extract troop update"""
        player_id = data.get("playerId", 0)
        city_id = data.get("cityId", 0)
        
        if player_id not in self._states:
            return {}
            
        state = self._states[player_id]
        
        if "troops" in data or "troop" in data:
            troop_data = data.get("troops") or data.get("troop", {})
            state.troops[city_id] = self._parse_troops(city_id, troop_data)
            state.last_updated = time.time()
            self._stats["troop_extractions"] += 1
            
            self._notify_update(player_id, "troops", state.troops[city_id].to_dict())
            
        return state.troops.get(city_id, TroopData(city_id)).to_dict()
        
    def _extract_building_update(self, data: Dict) -> Dict:
        """Extract building update"""
        player_id = data.get("playerId", 0)
        city_id = data.get("cityId", 0)
        
        if player_id not in self._states:
            return {}
            
        state = self._states[player_id]
        
        if "building" in data:
            building = data["building"]
            slot = building.get("slot", 0)
            
            if city_id not in state.buildings:
                state.buildings[city_id] = BuildingData(city_id=city_id)
                
            state.buildings[city_id].buildings[slot] = {
                "type": building.get("type", ""),
                "level": building.get("level", 0),
                "status": building.get("status", "idle"),
            }
            state.buildings[city_id].last_updated = time.time()
            self._stats["building_extractions"] += 1
            
            self._notify_update(player_id, "building", state.buildings[city_id].to_dict())
            
        return state.buildings.get(city_id, BuildingData(city_id)).to_dict()
        
    def _extract_player_update(self, data: Dict) -> Dict:
        """Extract player info update"""
        player_id = data.get("playerId", 0)
        
        if player_id not in self._states:
            return {}
            
        state = self._states[player_id]
        
        if "name" in data:
            state.player_name = data["name"]
        if "allianceId" in data:
            state.alliance_id = data["allianceId"]
        if "allianceName" in data:
            state.alliance_name = data["allianceName"]
            
        state.last_updated = time.time()
        self._stats["player_extractions"] += 1
        
        self._notify_update(player_id, "player", {
            "name": state.player_name,
            "alliance_id": state.alliance_id,
            "alliance_name": state.alliance_name,
        })
        
        return state.to_dict()
        
    def _extract_generic(self, data: Dict) -> Dict:
        """Generic extraction for unknown packet types"""
        extracted = {}
        
        # Look for common resource patterns
        for key in ["gold", "food", "wood", "stone", "iron"]:
            if key in data:
                extracted[f"resource_{key}"] = data[key]
                
        # Look for troop patterns
        for troop in TroopType:
            if troop.value in data:
                extracted[f"troop_{troop.value}"] = data[troop.value]
                
        self._stats["generic_extractions"] += 1
        return extracted
        
    # ========== Parsing Helpers ==========
    
    def _parse_resources(self, city_id: int, data: Dict) -> ResourceData:
        """Parse resource data"""
        rd = ResourceData(city_id=city_id)
        
        # Map various field names to standard names
        field_maps = {
            "gold": ["gold", "g"],
            "food": ["food", "f"],
            "wood": ["wood", "w", "lumber"],
            "stone": ["stone", "s"],
            "iron": ["iron", "i", "ore"],
            "population": ["population", "pop", "p"],
        }
        
        for std_name, aliases in field_maps.items():
            for alias in aliases:
                if alias in data:
                    rd.resources[std_name] = int(data[alias])
                    break
                    
        # Production rates
        if "production" in data:
            rd.production = data["production"]
            
        # Capacity
        if "capacity" in data or "max" in data:
            rd.capacity = data.get("capacity") or data.get("max", {})
            
        rd.last_updated = time.time()
        return rd
        
    def _parse_troops(self, city_id: int, data: Dict) -> TroopData:
        """Parse troop data"""
        td = TroopData(city_id=city_id)
        
        # Map troop type aliases
        troop_maps = {
            "worker": ["worker", "workers", "peasant"],
            "warrior": ["warrior", "warriors", "militia"],
            "scout": ["scout", "scouts"],
            "pikeman": ["pikeman", "pikemen", "pike"],
            "swordsman": ["swordsman", "swordsmen", "sword"],
            "archer": ["archer", "archers", "bow"],
            "cavalry": ["cavalry", "lightcavalry", "lcav"],
            "cataphract": ["cataphract", "cataphracts", "heavycavalry", "hcav"],
            "transporter": ["transporter", "transporters", "trans"],
            "ballista": ["ballista", "ballistas", "bal"],
            "battering_ram": ["ram", "rams", "batteringram"],
            "catapult": ["catapult", "catapults", "cat"],
        }
        
        for std_name, aliases in troop_maps.items():
            for alias in aliases:
                if alias in data:
                    td.troops[std_name] = int(data[alias])
                    break
                    
        # Training queue
        if "training" in data:
            td.training = data["training"]
            
        # Wounded
        if "wounded" in data:
            td.wounded = data["wounded"]
            
        td.last_updated = time.time()
        return td
        
    def _parse_buildings(self, city_id: int, data: List) -> BuildingData:
        """Parse building data"""
        bd = BuildingData(city_id=city_id)
        
        for building in data:
            slot = building.get("slot", building.get("position", 0))
            bd.buildings[slot] = {
                "type": building.get("type", building.get("typeId", "")),
                "level": building.get("level", building.get("lv", 0)),
                "status": building.get("status", "idle"),
            }
            
        bd.last_updated = time.time()
        return bd
        
    def _notify_update(self, player_id: int, update_type: str, data: Any):
        """Notify callbacks of state update"""
        for callback in self._on_update_callbacks:
            try:
                callback(player_id, update_type, data)
            except Exception as e:
                logger.error(f"Update callback error: {e}")


# Singleton
_extractor: Optional[GameStateExtractor] = None

def get_game_state_extractor() -> GameStateExtractor:
    """Get singleton game state extractor"""
    global _extractor
    if _extractor is None:
        _extractor = GameStateExtractor()
    return _extractor
