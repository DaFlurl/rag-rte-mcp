"""
ETK SOL Manager - Hero Data Model
Data structures for hero information
"""

from dataclasses import dataclass, field
from typing import Dict, List, Any, Optional
from enum import Enum


class HeroType(Enum):
    REGULAR = "regular"
    RING = "ring"  # Level 120 ring heroes
    HISTORIC = "historic"  # HH - Historic Heroes


@dataclass
class HeroData:
    """
    Complete hero data structure.
    
    Contains:
    - Basic info (name, level, experience)
    - Stats (attack, politics, intelligence)
    - Status (loyalty, energy, speed)
    - Type (regular, ring hero 120, HH)
    - Equipment/buffs
    """
    name: str
    hero_id: int = 0
    
    # Level & Experience
    level: int = 1
    experience: int = 0
    exp_to_next: int = 0
    
    # Core Stats
    attack: float = 0.0
    politics: int = 0
    intelligence: int = 0
    
    # Status
    loyalty: int = 100
    energy: int = 100
    max_energy: int = 100
    speed: int = 100
    leadership: int = 0
    salary: int = 0  # Gold per hour
    
    # Remaining attribute points
    remain_points: int = 0
    
    # Type classification
    hero_type: HeroType = HeroType.REGULAR
    
    # Location
    city_id: int = 0
    city_name: str = ""
    is_mayor: bool = False
    
    # Buffs
    buffs: List[Dict[str, Any]] = field(default_factory=list)
    
    # Equipment slots
    equipment: Dict[str, str] = field(default_factory=dict)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "name": self.name,
            "hero_id": self.hero_id,
            "level": self.level,
            "experience": self.experience,
            "exp_to_next": self.exp_to_next,
            "attack": self.attack,
            "politics": self.politics,
            "intelligence": self.intelligence,
            "loyalty": self.loyalty,
            "energy": self.energy,
            "max_energy": self.max_energy,
            "speed": self.speed,
            "leadership": self.leadership,
            "salary": self.salary,
            "remain_points": self.remain_points,
            "hero_type": self.hero_type.value,
            "city_id": self.city_id,
            "city_name": self.city_name,
            "is_mayor": self.is_mayor,
            "buffs": self.buffs,
            "equipment": self.equipment
        }
    
    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> 'HeroData':
        hero = cls(
            name=data.get("name", ""),
            hero_id=data.get("hero_id", 0),
            level=data.get("level", 1),
            experience=data.get("experience", 0),
            exp_to_next=data.get("exp_to_next", 0),
            attack=data.get("attack", 0.0),
            politics=data.get("politics", 0),
            intelligence=data.get("intelligence", 0),
            loyalty=data.get("loyalty", 100),
            energy=data.get("energy", 100),
            max_energy=data.get("max_energy", 100),
            speed=data.get("speed", 100),
            leadership=data.get("leadership", 0),
            salary=data.get("salary", 0),
            remain_points=data.get("remain_points", 0),
            city_id=data.get("city_id", 0),
            city_name=data.get("city_name", ""),
            is_mayor=data.get("is_mayor", False)
        )
        
        hero_type = data.get("hero_type", "regular")
        hero.hero_type = HeroType(hero_type) if isinstance(hero_type, str) else HeroType.REGULAR
        hero.buffs = data.get("buffs", [])
        hero.equipment = data.get("equipment", {})
        
        return hero
    
    @property
    def is_ring_hero(self) -> bool:
        """Check if this is a level 120 ring hero"""
        return self.level >= 120 or self.hero_type == HeroType.RING
    
    @property
    def is_hh(self) -> bool:
        """Check if this is a Historic Hero"""
        return self.hero_type == HeroType.HISTORIC
    
    @property
    def total_stats(self) -> float:
        """Sum of all main stats"""
        return self.attack + self.politics + self.intelligence
    
    def classify_type(self):
        """Auto-classify hero type based on level"""
        if self.level >= 120:
            self.hero_type = HeroType.RING
        # HH heroes are typically identified by special names or attributes
        # This would need game-specific logic


# Known Historic Heroes (HH) names for identification
HISTORIC_HEROES = [
    "Napoleon", "Alexander", "Caesar", "Genghis Khan", "Attila",
    "Hannibal", "Charlemagne", "Richard", "Saladin", "Frederick",
    "Joan of Arc", "Elizabeth", "Catherine", "Cleopatra", "Wu Zetian",
    "Sun Tzu", "Leonidas", "Spartacus", "William Wallace", "Robin Hood"
]

# Ring hero base stats at level 120
RING_HERO_BASE_STATS = {
    "min_attack": 700,
    "min_politics": 70,
    "min_intelligence": 70,
    "level": 120
}
