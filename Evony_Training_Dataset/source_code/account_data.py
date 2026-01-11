"""
ETK SOL Manager - Account Data Model
Comprehensive account data structure for Evony accounts
"""

from dataclasses import dataclass, field
from typing import Dict, List, Optional, Any
from datetime import datetime
from enum import Enum


class AccountStatus(Enum):
    UNKNOWN = "unknown"
    VALID = "valid"
    INVALID = "invalid"
    BANNED = "banned"
    EXPIRED = "expired"


@dataclass
class AccountCredentials:
    """Login credentials for an account"""
    email: str
    password: str
    server: str = "cc2"
    server_ip: str = "216.66.17.35"
    server_alias: str = "Parapet"
    proxy_host: str = "127.0.0.1"
    proxy_port: int = 8080
    proxy_type: str = "ss5"
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "email": self.email,
            "password": self.password,
            "server": self.server,
            "server_ip": self.server_ip,
            "server_alias": self.server_alias,
            "proxy_host": self.proxy_host,
            "proxy_port": self.proxy_port,
            "proxy_type": self.proxy_type
        }
    
    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> 'AccountCredentials':
        return cls(
            email=data.get("email", ""),
            password=data.get("password", ""),
            server=data.get("server", "cc2"),
            server_ip=data.get("server_ip", data.get("serverIP", "216.66.17.35")),
            server_alias=data.get("server_alias", data.get("strserverAlias", "Parapet")),
            proxy_host=data.get("proxy_host", data.get("proxyHost", "127.0.0.1")),
            proxy_port=int(data.get("proxy_port", data.get("proxyPort", 8080))),
            proxy_type=data.get("proxy_type", data.get("proxyType", "ss5"))
        )


@dataclass
class AccountSummary:
    """Summary statistics for an account"""
    total_gold: int = 0
    total_food: int = 0
    total_lumber: int = 0
    total_stone: int = 0
    total_iron: int = 0
    total_cities: int = 0
    total_heroes: int = 0
    total_troops: int = 0
    hh_heroes: int = 0  # Historic Heroes count
    ring_heroes: int = 0  # Level 120 ring heroes count
    prestige: int = 0
    honor: int = 0
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "total_gold": self.total_gold,
            "total_food": self.total_food,
            "total_lumber": self.total_lumber,
            "total_stone": self.total_stone,
            "total_iron": self.total_iron,
            "total_cities": self.total_cities,
            "total_heroes": self.total_heroes,
            "total_troops": self.total_troops,
            "hh_heroes": self.hh_heroes,
            "ring_heroes": self.ring_heroes,
            "prestige": self.prestige,
            "honor": self.honor
        }


@dataclass
class AccountData:
    """
    Complete account data structure containing all extractable information.
    
    This is the master data class that holds everything about an account:
    - Credentials (email, password, server)
    - Player info (name, alliance, rank)
    - Summary stats (gold, food, troops, heroes)
    - Cities list
    - Heroes list
    - Items inventory
    - Extraction metadata
    """
    # Identity
    email: str
    player_name: str = ""
    alliance: str = ""
    rank: str = ""
    
    # Credentials
    credentials: Optional[AccountCredentials] = None
    
    # Summary statistics
    summary: AccountSummary = field(default_factory=AccountSummary)
    
    # Status
    status: AccountStatus = AccountStatus.UNKNOWN
    last_validated: Optional[datetime] = None
    last_extracted: Optional[datetime] = None
    
    # Detailed data (populated by extraction)
    cities: List[Any] = field(default_factory=list)  # List[CityData]
    heroes: List[Any] = field(default_factory=list)  # List[HeroData]
    items: Dict[str, List[Any]] = field(default_factory=dict)  # {category: List[ItemData]}
    
    # Metadata
    sol_paths: List[str] = field(default_factory=list)  # Paths to config.sol files
    notes: str = ""
    tags: List[str] = field(default_factory=list)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "email": self.email,
            "player_name": self.player_name,
            "alliance": self.alliance,
            "rank": self.rank,
            "credentials": self.credentials.to_dict() if self.credentials else None,
            "summary": self.summary.to_dict(),
            "status": self.status.value,
            "last_validated": self.last_validated.isoformat() if self.last_validated else None,
            "last_extracted": self.last_extracted.isoformat() if self.last_extracted else None,
            "cities": [c.to_dict() if hasattr(c, 'to_dict') else c for c in self.cities],
            "heroes": [h.to_dict() if hasattr(h, 'to_dict') else h for h in self.heroes],
            "items": self.items,
            "sol_paths": self.sol_paths,
            "notes": self.notes,
            "tags": self.tags
        }
    
    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> 'AccountData':
        account = cls(
            email=data.get("email", ""),
            player_name=data.get("player_name", ""),
            alliance=data.get("alliance", ""),
            rank=data.get("rank", "")
        )
        
        if data.get("credentials"):
            account.credentials = AccountCredentials.from_dict(data["credentials"])
        
        if data.get("summary"):
            s = data["summary"]
            account.summary = AccountSummary(
                total_gold=s.get("total_gold", 0),
                total_food=s.get("total_food", 0),
                total_lumber=s.get("total_lumber", 0),
                total_stone=s.get("total_stone", 0),
                total_iron=s.get("total_iron", 0),
                total_cities=s.get("total_cities", 0),
                total_heroes=s.get("total_heroes", 0),
                total_troops=s.get("total_troops", 0),
                hh_heroes=s.get("hh_heroes", 0),
                ring_heroes=s.get("ring_heroes", 0),
                prestige=s.get("prestige", 0),
                honor=s.get("honor", 0)
            )
        
        account.status = AccountStatus(data.get("status", "unknown"))
        account.sol_paths = data.get("sol_paths", [])
        account.notes = data.get("notes", "")
        account.tags = data.get("tags", [])
        
        return account
    
    @classmethod
    def from_config_sol(cls, sol_data: Dict[str, Any], sol_path: str = "") -> 'AccountData':
        """Create AccountData from config.sol data"""
        now = sol_data.get("now", {})
        
        credentials = AccountCredentials(
            email=now.get("username", ""),
            password=now.get("password", ""),
            server=now.get("server", "cc2"),
            server_ip=now.get("serverIP", "216.66.17.35"),
            server_alias=now.get("strserverAlias", "Parapet"),
            proxy_host=now.get("proxyHost", "127.0.0.1"),
            proxy_port=int(now.get("proxyPort", 8080) or 8080),
            proxy_type=now.get("proxyType", "ss5")
        )
        
        account = cls(
            email=credentials.email,
            credentials=credentials,
            status=AccountStatus.VALID if credentials.password else AccountStatus.UNKNOWN
        )
        
        if sol_path:
            account.sol_paths.append(sol_path)
        
        return account
