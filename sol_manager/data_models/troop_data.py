"""
ETK SOL Manager - Troop Data Model
Data structures for troop information
"""

from dataclasses import dataclass, field
from typing import Dict, List, Any
from enum import Enum


# Troop type definitions with game codes
TROOP_TYPES = {
    "worker": {"code": "wo", "name": "Workers", "tier": 0},
    "warrior": {"code": "w", "name": "Warriors", "tier": 1},
    "scout": {"code": "s", "name": "Scouts", "tier": 1},
    "pikeman": {"code": "p", "name": "Pikemen", "tier": 2},
    "swordsman": {"code": "sw", "name": "Swordsmen", "tier": 2},
    "archer": {"code": "a", "name": "Archers", "tier": 3},
    "cavalry": {"code": "c", "name": "Cavalry", "tier": 3},
    "cataphract": {"code": "cata", "name": "Cataphracts", "tier": 4},
    "transporter": {"code": "t", "name": "Transporters", "tier": 0},
    "ram": {"code": "r", "name": "Battering Rams", "tier": 4},
    "ballista": {"code": "b", "name": "Ballistas", "tier": 4},
    "catapult": {"code": "cp", "name": "Catapults", "tier": 4}
}

# Reverse lookup: code -> type
TROOP_CODE_MAP = {v["code"]: k for k, v in TROOP_TYPES.items()}


@dataclass
class TroopData:
    """
    Troop counts for a city or account total.
    """
    # Tier 0 - Support
    workers: int = 0
    transporters: int = 0
    
    # Tier 1 - Basic
    warriors: int = 0
    scouts: int = 0
    
    # Tier 2 - Infantry
    pikemen: int = 0
    swordsmen: int = 0
    
    # Tier 3 - Ranged/Mounted
    archers: int = 0
    cavalry: int = 0
    
    # Tier 4 - Elite/Siege
    cataphracts: int = 0
    rams: int = 0
    ballistas: int = 0
    catapults: int = 0
    
    def to_dict(self) -> Dict[str, int]:
        return {
            "workers": self.workers,
            "transporters": self.transporters,
            "warriors": self.warriors,
            "scouts": self.scouts,
            "pikemen": self.pikemen,
            "swordsmen": self.swordsmen,
            "archers": self.archers,
            "cavalry": self.cavalry,
            "cataphracts": self.cataphracts,
            "rams": self.rams,
            "ballistas": self.ballistas,
            "catapults": self.catapults
        }
    
    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> 'TroopData':
        return cls(
            workers=data.get("workers", data.get("wo", 0)),
            transporters=data.get("transporters", data.get("t", 0)),
            warriors=data.get("warriors", data.get("w", 0)),
            scouts=data.get("scouts", data.get("s", 0)),
            pikemen=data.get("pikemen", data.get("p", 0)),
            swordsmen=data.get("swordsmen", data.get("sw", 0)),
            archers=data.get("archers", data.get("a", 0)),
            cavalry=data.get("cavalry", data.get("c", 0)),
            cataphracts=data.get("cataphracts", data.get("cata", 0)),
            rams=data.get("rams", data.get("r", 0)),
            ballistas=data.get("ballistas", data.get("b", 0)),
            catapults=data.get("catapults", data.get("cp", 0))
        )
    
    @property
    def total(self) -> int:
        """Total troop count"""
        return (self.workers + self.transporters + self.warriors + 
                self.scouts + self.pikemen + self.swordsmen + 
                self.archers + self.cavalry + self.cataphracts + 
                self.rams + self.ballistas + self.catapults)
    
    @property
    def combat_troops(self) -> int:
        """Total combat troops (excluding workers/transporters)"""
        return (self.warriors + self.scouts + self.pikemen + 
                self.swordsmen + self.archers + self.cavalry + 
                self.cataphracts + self.rams + self.ballistas + self.catapults)
    
    @property
    def tier4_troops(self) -> int:
        """Total tier 4 troops"""
        return self.cataphracts + self.rams + self.ballistas + self.catapults
    
    def get_by_code(self, code: str) -> int:
        """Get troop count by game code"""
        code_map = {
            "wo": self.workers,
            "t": self.transporters,
            "w": self.warriors,
            "s": self.scouts,
            "p": self.pikemen,
            "sw": self.swordsmen,
            "a": self.archers,
            "c": self.cavalry,
            "cata": self.cataphracts,
            "r": self.rams,
            "b": self.ballistas,
            "cp": self.catapults
        }
        return code_map.get(code.lower(), 0)
    
    def set_by_code(self, code: str, count: int):
        """Set troop count by game code"""
        code_lower = code.lower()
        if code_lower == "wo":
            self.workers = count
        elif code_lower == "t":
            self.transporters = count
        elif code_lower == "w":
            self.warriors = count
        elif code_lower == "s":
            self.scouts = count
        elif code_lower == "p":
            self.pikemen = count
        elif code_lower == "sw":
            self.swordsmen = count
        elif code_lower == "a":
            self.archers = count
        elif code_lower == "c":
            self.cavalry = count
        elif code_lower == "cata":
            self.cataphracts = count
        elif code_lower == "r":
            self.rams = count
        elif code_lower == "b":
            self.ballistas = count
        elif code_lower == "cp":
            self.catapults = count
    
    def add(self, other: 'TroopData') -> 'TroopData':
        """Add another TroopData to this one"""
        return TroopData(
            workers=self.workers + other.workers,
            transporters=self.transporters + other.transporters,
            warriors=self.warriors + other.warriors,
            scouts=self.scouts + other.scouts,
            pikemen=self.pikemen + other.pikemen,
            swordsmen=self.swordsmen + other.swordsmen,
            archers=self.archers + other.archers,
            cavalry=self.cavalry + other.cavalry,
            cataphracts=self.cataphracts + other.cataphracts,
            rams=self.rams + other.rams,
            ballistas=self.ballistas + other.ballistas,
            catapults=self.catapults + other.catapults
        )
    
    def format_summary(self) -> str:
        """Format a brief summary string"""
        parts = []
        if self.archers:
            parts.append(f"a:{self.archers:,}")
        if self.cataphracts:
            parts.append(f"cata:{self.cataphracts:,}")
        if self.cavalry:
            parts.append(f"c:{self.cavalry:,}")
        if self.ballistas:
            parts.append(f"b:{self.ballistas:,}")
        return " | ".join(parts) if parts else "No troops"
