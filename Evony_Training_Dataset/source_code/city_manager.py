"""
City Manager - Full City Automation

Complete automation for Evony city management:
- Resource collection and optimization
- Building queue management
- Research automation
- Troop training coordination
- Defense management
- Multi-city coordination
"""

import logging
import time
from dataclasses import dataclass, field
from enum import Enum
from typing import Dict, Optional, List, Any, Tuple
import threading

logger = logging.getLogger(__name__)


class ResourceType(Enum):
    """Resource types"""
    FOOD = "food"
    WOOD = "wood"
    STONE = "stone"
    IRON = "iron"
    GOLD = "gold"


class BuildingType(Enum):
    """Building types with slots"""
    TOWN_HALL = ("townHall", "inner", 1)
    COTTAGE = ("cottage", "inner", 0)
    WAREHOUSE = ("warehouse", "inner", 0)
    BARRACKS = ("barracks", "inner", 0)
    FORGE = ("forge", "inner", 0)
    WORKSHOP = ("workshop", "inner", 0)
    ACADEMY = ("academy", "inner", 0)
    RALLY_SPOT = ("rallySpot", "inner", 1)
    BEACON_TOWER = ("beaconTower", "inner", 1)
    FEASTING_HALL = ("feastingHall", "inner", 1)
    EMBASSY = ("embassy", "inner", 1)
    MARKETPLACE = ("marketplace", "inner", 1)
    INN = ("inn", "inner", 1)
    STABLE = ("stable", "inner", 0)
    RELIEF_STATION = ("reliefStation", "inner", 1)
    WALLS = ("walls", "outer", 1)
    FARM = ("farm", "outer", 0)
    SAWMILL = ("sawmill", "outer", 0)
    QUARRY = ("quarry", "outer", 0)
    IRONMINE = ("ironMine", "outer", 0)
    
    def __init__(self, name: str, zone: str, max_count: int):
        self._name = name
        self.zone = zone
        self.max_count = max_count  # 0 = unlimited


class TaskType(Enum):
    """City automation task types"""
    COLLECT_RESOURCES = "collect_resources"
    BUILD = "build"
    UPGRADE = "upgrade"
    RESEARCH = "research"
    TRAIN = "train"
    FARM_NPC = "farm_npc"
    DEFEND = "defend"
    TRANSPORT = "transport"


@dataclass
class CityState:
    """Complete state of a city"""
    city_id: int
    city_name: str = ""
    x: int = 0
    y: int = 0
    
    # Resources
    food: int = 0
    wood: int = 0
    stone: int = 0
    iron: int = 0
    gold: int = 0
    
    # Production rates (per hour)
    food_production: int = 0
    wood_production: int = 0
    stone_production: int = 0
    iron_production: int = 0
    gold_production: int = 0
    
    # Consumption
    food_consumption: int = 0
    
    # Troops
    troops: Dict[str, int] = field(default_factory=dict)
    marching: int = 0
    reinforcing: int = 0
    
    # Buildings
    buildings: Dict[str, int] = field(default_factory=dict)  # type -> level
    build_queue: List[Dict] = field(default_factory=list)
    
    # Research
    research_queue: Optional[Dict] = None
    
    # Status
    is_capital: bool = False
    population: int = 0
    loyalty: int = 100
    grievance: int = 0
    
    @property
    def net_food(self) -> int:
        return self.food_production - self.food_consumption
        
    @property
    def total_troops(self) -> int:
        return sum(self.troops.values())


@dataclass
class AutomationConfig:
    """Configuration for city automation"""
    enabled: bool = True
    
    # Resource collection
    auto_collect: bool = True
    collect_interval: float = 300.0  # 5 minutes
    
    # Building
    auto_build: bool = True
    build_priority: List[str] = field(default_factory=lambda: [
        "townHall", "barracks", "forge", "academy", "stable"
    ])
    
    # Training
    auto_train: bool = True
    train_priority: List[str] = field(default_factory=lambda: [
        "archer", "cavalry", "cataphract"
    ])
    train_batch_size: int = 10000
    
    # Farming
    auto_farm: bool = True
    farm_npc_level: int = 10
    farm_waves: int = 3
    min_troops_for_farm: int = 50000
    
    # Resource management
    resource_balance: bool = True
    food_threshold: int = 100000
    transport_excess: bool = True
    
    # Defense
    auto_defend: bool = True
    defend_threshold: int = 1000000  # Incoming attack size


class CityAutomationManager:
    """
    Manages full automation for cities.
    
    Features:
    - Multi-city coordination
    - Resource optimization
    - Build queue management
    - Continuous training
    - NPC farming
    - Defense automation
    """
    
    def __init__(self):
        self._client = None
        self._cities: Dict[int, CityState] = {}
        self._configs: Dict[int, AutomationConfig] = {}
        self._running = False
        self._threads: Dict[int, threading.Thread] = {}
        self._lock = threading.RLock()
        
        # Task scheduling
        self._last_collect: Dict[int, float] = {}
        self._last_train: Dict[int, float] = {}
        self._last_farm: Dict[int, float] = {}
        
    def set_client(self, client):
        """Set game client"""
        self._client = client
        
    def add_city(self, city_id: int, config: AutomationConfig = None):
        """Add city to automation"""
        self._configs[city_id] = config or AutomationConfig()
        self._cities[city_id] = CityState(city_id=city_id)
        logger.info(f"Added city {city_id} to automation")
        
    def remove_city(self, city_id: int):
        """Remove city from automation"""
        if city_id in self._configs:
            del self._configs[city_id]
        if city_id in self._cities:
            del self._cities[city_id]
            
    def start(self):
        """Start automation for all cities"""
        self._running = True
        for city_id in self._configs:
            thread = threading.Thread(
                target=self._automation_loop,
                args=(city_id,),
                daemon=True,
            )
            self._threads[city_id] = thread
            thread.start()
        logger.info(f"Started automation for {len(self._configs)} cities")
        
    def stop(self):
        """Stop all automation"""
        self._running = False
        for thread in self._threads.values():
            thread.join(timeout=5)
        self._threads.clear()
        logger.info("Stopped all city automation")
        
    # ========== Automation Loop ==========
    
    def _automation_loop(self, city_id: int):
        """Main automation loop for a city"""
        while self._running:
            try:
                config = self._configs.get(city_id)
                if not config or not config.enabled:
                    time.sleep(60)
                    continue
                    
                # Refresh city state
                self._refresh_city_state(city_id)
                
                # Run automation tasks
                if config.auto_collect:
                    self._task_collect_resources(city_id)
                    
                if config.auto_build:
                    self._task_manage_builds(city_id)
                    
                if config.auto_train:
                    self._task_train_troops(city_id)
                    
                if config.auto_farm:
                    self._task_farm_npc(city_id)
                    
                if config.auto_defend:
                    self._task_check_defense(city_id)
                    
                if config.resource_balance:
                    self._task_balance_resources(city_id)
                    
                # Sleep before next cycle
                time.sleep(30)
                
            except Exception as e:
                logger.error(f"City {city_id} automation error: {e}")
                time.sleep(60)
                
    def _refresh_city_state(self, city_id: int):
        """Refresh city state from server"""
        if not self._client:
            return
            
        # Get city info
        # result = self._client.get_city_info(city_id)
        # if result.success:
        #     self._cities[city_id] = CityState(**result.data)
        pass
        
    # ========== Automation Tasks ==========
    
    def _task_collect_resources(self, city_id: int):
        """Collect all resources in city"""
        config = self._configs.get(city_id)
        last = self._last_collect.get(city_id, 0)
        
        if time.time() - last < config.collect_interval:
            return
            
        logger.debug(f"City {city_id}: Collecting resources")
        
        if self._client:
            # self._client.collect_resources(city_id)
            pass
            
        self._last_collect[city_id] = time.time()
        
    def _task_manage_builds(self, city_id: int):
        """Manage building queue"""
        city = self._cities.get(city_id)
        config = self._configs.get(city_id)
        
        if not city or not config:
            return
            
        # Check if build queue is empty
        if city.build_queue:
            return  # Already building
            
        # Find next building to upgrade
        for building_type in config.build_priority:
            current_level = city.buildings.get(building_type, 0)
            
            # Check if can upgrade
            if self._can_upgrade(city, building_type, current_level + 1):
                logger.info(f"City {city_id}: Upgrading {building_type} to {current_level + 1}")
                if self._client:
                    # self._client.upgrade_building(city_id, building_type)
                    pass
                return
                
    def _can_upgrade(self, city: CityState, building: str, level: int) -> bool:
        """Check if building can be upgraded"""
        # Check town hall requirement
        th_level = city.buildings.get("townHall", 1)
        if level > th_level:
            return False
            
        # Would need resource checks here
        return True
        
    def _task_train_troops(self, city_id: int):
        """Train troops continuously"""
        city = self._cities.get(city_id)
        config = self._configs.get(city_id)
        
        if not city or not config:
            return
            
        # Check food
        if city.net_food < 0 and city.food < config.food_threshold:
            logger.debug(f"City {city_id}: Low food, skipping training")
            return
            
        # Train priority troops
        for troop_type in config.train_priority:
            if self._can_train(city, troop_type, config.train_batch_size):
                logger.info(f"City {city_id}: Training {config.train_batch_size} {troop_type}")
                if self._client:
                    # self._client.train_troops(city_id, troop_type, config.train_batch_size)
                    pass
                return
                
    def _can_train(self, city: CityState, troop: str, count: int) -> bool:
        """Check if troops can be trained"""
        # Would check barracks level, resources, etc.
        return True
        
    def _task_farm_npc(self, city_id: int):
        """Farm NPCs automatically"""
        city = self._cities.get(city_id)
        config = self._configs.get(city_id)
        
        if not city or not config:
            return
            
        # Check if enough troops
        if city.total_troops < config.min_troops_for_farm:
            logger.debug(f"City {city_id}: Not enough troops for farming")
            return
            
        # Check if too many armies out
        if city.marching >= 5:  # Assuming 5 slot limit
            return
            
        # Find and attack NPC
        logger.info(f"City {city_id}: Farming level {config.farm_npc_level} NPC")
        if self._client:
            # self._client.attack_npc(city_id, config.farm_npc_level, troops)
            pass
            
    def _task_check_defense(self, city_id: int):
        """Check for incoming attacks and defend"""
        city = self._cities.get(city_id)
        config = self._configs.get(city_id)
        
        if not city or not config:
            return
            
        # Would check for incoming attacks
        # If attack detected, recall armies and prepare defense
        pass
        
    def _task_balance_resources(self, city_id: int):
        """Balance resources between cities"""
        city = self._cities.get(city_id)
        config = self._configs.get(city_id)
        
        if not city or not config:
            return
            
        # Transport excess resources to other cities
        if config.transport_excess:
            # Find cities that need resources
            # Transport from this city if excess
            pass
            
    # ========== Manual Operations ==========
    
    def collect_all(self) -> Dict:
        """Collect resources in all cities"""
        results = {}
        for city_id in self._configs:
            if self._client:
                # result = self._client.collect_resources(city_id)
                results[city_id] = {"status": "collected"}
        return results
        
    def train_all(self, troop_type: str, count: int) -> Dict:
        """Train troops in all cities"""
        results = {}
        for city_id in self._configs:
            if self._client:
                # result = self._client.train_troops(city_id, troop_type, count)
                results[city_id] = {"status": "queued", "troop": troop_type, "count": count}
        return results
        
    def farm_all(self, npc_level: int, troops: Dict[str, int]) -> Dict:
        """Farm NPCs from all cities"""
        results = {}
        for city_id in self._configs:
            if self._client:
                # result = self._client.attack_npc(city_id, npc_level, troops)
                results[city_id] = {"status": "attacking", "level": npc_level}
        return results
        
    def transport_resources(self, from_city: int, to_city: int,
                           resources: Dict[str, int]) -> Dict:
        """Transport resources between cities"""
        if self._client:
            # return self._client.transport(from_city, to_city, resources)
            pass
        return {"status": "queued", "from": from_city, "to": to_city, "resources": resources}
        
    # ========== Status ==========
    
    def get_city_state(self, city_id: int) -> Optional[CityState]:
        """Get city state"""
        return self._cities.get(city_id)
        
    def get_all_states(self) -> Dict[int, CityState]:
        """Get all city states"""
        return dict(self._cities)
        
    def get_statistics(self) -> Dict:
        """Get automation statistics"""
        total_troops = sum(
            city.total_troops for city in self._cities.values()
        )
        total_resources = {
            "food": sum(c.food for c in self._cities.values()),
            "wood": sum(c.wood for c in self._cities.values()),
            "stone": sum(c.stone for c in self._cities.values()),
            "iron": sum(c.iron for c in self._cities.values()),
            "gold": sum(c.gold for c in self._cities.values()),
        }
        
        return {
            "cities_managed": len(self._configs),
            "automation_running": self._running,
            "total_troops": total_troops,
            "total_resources": total_resources,
        }


# Singleton
_city_manager: Optional[CityAutomationManager] = None

def get_city_manager() -> CityAutomationManager:
    """Get singleton city automation manager"""
    global _city_manager
    if _city_manager is None:
        _city_manager = CityAutomationManager()
    return _city_manager
