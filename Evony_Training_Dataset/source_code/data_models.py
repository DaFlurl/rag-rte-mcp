#!/usr/bin/env python3
"""
BORG TOOLKIT - Complete Data Models for 1:1 Extraction
All data structures for complete account extraction.
"""

from dataclasses import dataclass, field
from typing import Dict, List

@dataclass
class TroopInfo:
    workers: int = 0
    warriors: int = 0
    scouts: int = 0
    pikemen: int = 0
    swordsmen: int = 0
    archers: int = 0
    cavalry: int = 0
    cataphracts: int = 0
    transporters: int = 0
    ballistas: int = 0
    rams: int = 0
    catapults: int = 0
    training_queues: List[Dict] = field(default_factory=list)
    
    def total(self) -> int:
        return sum([self.workers, self.warriors, self.scouts, self.pikemen,
                   self.swordsmen, self.archers, self.cavalry, self.cataphracts,
                   self.transporters, self.ballistas, self.rams, self.catapults])
    
    def to_string(self) -> str:
        abbr = ['wo','wa','sc','pi','sw','ar','ca','cp','tr','ba','ra','ct']
        vals = [self.workers, self.warriors, self.scouts, self.pikemen,
                self.swordsmen, self.archers, self.cavalry, self.cataphracts,
                self.transporters, self.ballistas, self.rams, self.catapults]
        return ", ".join(f"{a}:{v:,}" for a,v in zip(abbr,vals) if v > 0) or "none"

@dataclass
class ResourceInfo:
    gold: int = 0
    food: int = 0
    wood: int = 0
    stone: int = 0
    iron: int = 0
    population: int = 0
    max_population: int = 0
    idle_population: int = 0
    gold_rate: int = 0
    food_rate: int = 0
    wood_rate: int = 0
    stone_rate: int = 0
    iron_rate: int = 0
    gold_capacity: int = 0
    food_capacity: int = 0
    wood_capacity: int = 0
    stone_capacity: int = 0
    iron_capacity: int = 0
    tax_rate: int = 0
    loyalty: int = 0
    grievance: int = 0

@dataclass
class HeroInfo:
    id: int = 0
    name: str = ""
    level: int = 0
    experience: int = 0
    base_attack: int = 0
    base_defense: int = 0
    base_politics: int = 0
    base_intelligence: int = 0
    attack: int = 0
    defense: int = 0
    politics: int = 0
    intelligence: int = 0
    management: int = 0
    status: str = ""
    loyalty: int = 100
    city_id: int = 0
    city_name: str = ""
    is_mayor: bool = False
    is_marshal: bool = False
    is_historic: bool = False
    is_captured: bool = False
    equipment: List[Dict] = field(default_factory=list)
    remaining_points: int = 0

@dataclass
class BuildingInfo:
    id: int = 0
    type_id: int = 0
    type_name: str = ""
    position_id: int = 0
    level: int = 0
    status: str = ""
    end_time: int = 0

@dataclass
class FortificationInfo:
    traps: int = 0
    abatis: int = 0
    archer_towers: int = 0
    rolling_logs: int = 0
    defensive_trebuchet: int = 0
    wall_protection: int = 0
    production_queues: List[Dict] = field(default_factory=list)

@dataclass
class ArmyInfo:
    id: int = 0
    hero_id: int = 0
    hero_name: str = ""
    mission_type: int = 0
    mission_name: str = ""
    from_castle_id: int = 0
    from_coords: str = ""
    target_coords: str = ""
    target_name: str = ""
    start_time: int = 0
    arrival_time: int = 0
    return_time: int = 0
    troops: TroopInfo = field(default_factory=TroopInfo)
    resources: Dict = field(default_factory=dict)
    direction: str = ""

@dataclass
class CityInfo:
    id: int = 0
    name: str = ""
    coords: str = ""
    x: int = 0
    y: int = 0
    level: int = 0
    is_main: bool = False
    resources: ResourceInfo = field(default_factory=ResourceInfo)
    troops: TroopInfo = field(default_factory=TroopInfo)
    fortifications: FortificationInfo = field(default_factory=FortificationInfo)
    buildings_inside: List[BuildingInfo] = field(default_factory=list)
    buildings_outside: List[BuildingInfo] = field(default_factory=list)
    heroes: List[HeroInfo] = field(default_factory=list)
    armies: List[ArmyInfo] = field(default_factory=list)
    research: List[Dict] = field(default_factory=list)
    injured_troops: TroopInfo = field(default_factory=TroopInfo)
    fled_troops: TroopInfo = field(default_factory=TroopInfo)
    buffs: List[Dict] = field(default_factory=list)

@dataclass
class ColonyInfo:
    id: int = 0
    name: str = ""
    coords: str = ""
    level: int = 0
    loyalty: int = 0
    tax_rate: int = 0
    mayor_name: str = ""
    resources: ResourceInfo = field(default_factory=ResourceInfo)
    troops: TroopInfo = field(default_factory=TroopInfo)

@dataclass
class ItemInfo:
    id: str = ""
    name: str = ""
    count: int = 0
    category: str = ""
    description: str = ""

@dataclass
class ReportInfo:
    id: int = 0
    type_id: int = 0
    type_name: str = ""
    title: str = ""
    content: str = ""
    target_coords: str = ""
    target_name: str = ""
    is_success: bool = False
    is_read: bool = False
    time: str = ""

@dataclass
class MailInfo:
    id: int = 0
    type_name: str = ""
    sender: str = ""
    title: str = ""
    content: str = ""
    is_read: bool = False
    time: str = ""

@dataclass
class PlayerInfo:
    id: int = 0
    name: str = ""
    email: str = ""
    server: str = ""
    prestige: int = 0
    honor: int = 0
    title: str = ""
    level: int = 0
    coins: int = 0
    buffs: List[Dict] = field(default_factory=list)

@dataclass
class AllianceInfo:
    id: int = 0
    name: str = ""
    rank: str = ""
    position: str = ""
    prestige: int = 0
    member_count: int = 0
    leader: str = ""
    members: List[Dict] = field(default_factory=list)

@dataclass
class CompleteAccountData:
    extraction_time: str = ""
    extraction_success: bool = False
    extraction_errors: List[str] = field(default_factory=list)
    login_email: str = ""
    login_password: str = ""
    login_server: str = ""
    player: PlayerInfo = field(default_factory=PlayerInfo)
    alliance: AllianceInfo = field(default_factory=AllianceInfo)
    cities: List[CityInfo] = field(default_factory=list)
    colonies: List[ColonyInfo] = field(default_factory=list)
    items: List[ItemInfo] = field(default_factory=list)
    equipment: List[Dict] = field(default_factory=list)
    packages: List[Dict] = field(default_factory=list)
    quests: List[Dict] = field(default_factory=list)
    reports: List[ReportInfo] = field(default_factory=list)
    mail: List[MailInfo] = field(default_factory=list)
    trades: List[Dict] = field(default_factory=list)
    friends: List[Dict] = field(default_factory=list)
    total_cities: int = 0
    total_troops: int = 0
    total_heroes: int = 0
    total_historic_heroes: int = 0
