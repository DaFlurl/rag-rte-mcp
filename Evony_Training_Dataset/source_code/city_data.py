"""
ETK SOL Manager - City Data Model
Data structures for city information
"""

from dataclasses import dataclass, field
from typing import Dict, List, Any, Optional


@dataclass
class CityResources:
    """Resource counts for a city"""
    gold: int = 0
    food: int = 0
    lumber: int = 0
    stone: int = 0
    iron: int = 0
    population: int = 0
    
    # Production rates (per hour)
    gold_rate: int = 0
    food_rate: int = 0
    lumber_rate: int = 0
    stone_rate: int = 0
    iron_rate: int = 0
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "gold": self.gold,
            "food": self.food,
            "lumber": self.lumber,
            "stone": self.stone,
            "iron": self.iron,
            "population": self.population,
            "gold_rate": self.gold_rate,
            "food_rate": self.food_rate,
            "lumber_rate": self.lumber_rate,
            "stone_rate": self.stone_rate,
            "iron_rate": self.iron_rate
        }
    
    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> 'CityResources':
        return cls(
            gold=data.get("gold", 0),
            food=data.get("food", 0),
            lumber=data.get("lumber", 0),
            stone=data.get("stone", 0),
            iron=data.get("iron", 0),
            population=data.get("population", 0),
            gold_rate=data.get("gold_rate", 0),
            food_rate=data.get("food_rate", 0),
            lumber_rate=data.get("lumber_rate", 0),
            stone_rate=data.get("stone_rate", 0),
            iron_rate=data.get("iron_rate", 0)
        )


@dataclass
class CityData:
    """
    Complete city data structure.
    
    Contains:
    - Basic info (name, coordinates, state)
    - Resources (gold, food, lumber, stone, iron)
    - Buildings (level info)
    - Mayor info
    - Troop counts
    """
    name: str
    city_id: int = 0
    
    # Location
    x: int = 0
    y: int = 0
    state: str = ""  # State/region name
    
    # Status
    is_capital: bool = False
    loyalty: int = 100
    grievance: int = 0
    
    # Mayor
    mayor_name: str = ""
    mayor_id: int = 0
    
    # Resources
    resources: CityResources = field(default_factory=CityResources)
    
    # Buildings (name: level)
    buildings: Dict[str, int] = field(default_factory=dict)
    
    # Troops in this city
    troops: Dict[str, int] = field(default_factory=dict)
    
    # Heroes in this city
    hero_ids: List[int] = field(default_factory=list)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "name": self.name,
            "city_id": self.city_id,
            "x": self.x,
            "y": self.y,
            "state": self.state,
            "is_capital": self.is_capital,
            "loyalty": self.loyalty,
            "grievance": self.grievance,
            "mayor_name": self.mayor_name,
            "mayor_id": self.mayor_id,
            "resources": self.resources.to_dict(),
            "buildings": self.buildings,
            "troops": self.troops,
            "hero_ids": self.hero_ids
        }
    
    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> 'CityData':
        city = cls(
            name=data.get("name", ""),
            city_id=data.get("city_id", 0),
            x=data.get("x", 0),
            y=data.get("y", 0),
            state=data.get("state", ""),
            is_capital=data.get("is_capital", False),
            loyalty=data.get("loyalty", 100),
            grievance=data.get("grievance", 0),
            mayor_name=data.get("mayor_name", ""),
            mayor_id=data.get("mayor_id", 0)
        )
        
        if data.get("resources"):
            city.resources = CityResources.from_dict(data["resources"])
        
        city.buildings = data.get("buildings", {})
        city.troops = data.get("troops", {})
        city.hero_ids = data.get("hero_ids", [])
        
        return city
    
    @property
    def coordinates(self) -> str:
        """Return formatted coordinates string"""
        return f"({self.x}, {self.y})"
    
    @property
    def total_troops(self) -> int:
        """Total troop count in this city"""
        return sum(self.troops.values())
