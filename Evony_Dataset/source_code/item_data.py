"""
ETK SOL Manager - Item Data Model
Data structures for game items
"""

from dataclasses import dataclass, field
from typing import Dict, List, Any, Optional
from enum import Enum


class ItemCategory(Enum):
    """Item categories matching game UI"""
    ALL = "All"
    ITEMS = "Items"
    CHESTS = "Chests"
    RESOURCES = "Resources"
    ANGEL_DEVIL = "Angel & Devil Items"
    STRATAGEMS = "Stratagems"
    TELEPORTERS = "Teleporters"
    TROOP_PACKS = "Troop Packs"
    PRODUCE = "Produce"
    SPEED_UPS = "Speed Ups"
    MATERIALS = "Materials"
    MEDALS = "Medals"
    HH_QUESTS = "HH Quests"


# Important items to track
VALUABLE_ITEMS = {
    # High-value items
    "Thunder_Raid": {"category": ItemCategory.STRATAGEMS, "value": "high"},
    "Fleet_Feet": {"category": ItemCategory.STRATAGEMS, "value": "high"},
    "War_Ensign": {"category": ItemCategory.STRATAGEMS, "value": "high"},
    "City_Teleporter": {"category": ItemCategory.TELEPORTERS, "value": "high"},
    
    # Resources
    "Speaker": {"category": ItemCategory.ITEMS, "value": "medium"},
    "Delicate_gem": {"category": ItemCategory.ITEMS, "value": "medium"},
    
    # Speed ups
    "Beginner_Guidelines": {"category": ItemCategory.SPEED_UPS, "value": "low"},
    "Intermediate_Guidelines": {"category": ItemCategory.SPEED_UPS, "value": "low"},
    "Napoleon_Diary": {"category": ItemCategory.SPEED_UPS, "value": "medium"},
    
    # Medals
    "Courage_Medal": {"category": ItemCategory.MEDALS, "value": "low"},
    "Wisdom_Medal": {"category": ItemCategory.MEDALS, "value": "low"},
    "Freedom_Medal": {"category": ItemCategory.MEDALS, "value": "low"},
    "Honor_Medal": {"category": ItemCategory.MEDALS, "value": "low"},
    "Lion_Medal": {"category": ItemCategory.MEDALS, "value": "low"},
    "Nation_Medal": {"category": ItemCategory.MEDALS, "value": "low"},
    "Justice_Medal": {"category": ItemCategory.MEDALS, "value": "low"},
    
    # Scripts/Tools
    "Bernini_Hammer": {"category": ItemCategory.ITEMS, "value": "medium"},
    "Michelangelo_Script": {"category": ItemCategory.ITEMS, "value": "medium"},
    "The_Lost_Armor_Script": {"category": ItemCategory.ITEMS, "value": "medium"},
    
    # Gems
    "Flawless_gem": {"category": ItemCategory.ITEMS, "value": "medium"},
    "Crude_Gemstone": {"category": ItemCategory.MATERIALS, "value": "low"},
    
    # Hero items
    "Hero_Hunting": {"category": ItemCategory.ITEMS, "value": "medium"},
    "Holy_Water": {"category": ItemCategory.ITEMS, "value": "medium"},
    
    # Resources
    "Wood": {"category": ItemCategory.RESOURCES, "value": "low"},
    "Iron_Ore": {"category": ItemCategory.RESOURCES, "value": "low"},
    "Fabric": {"category": ItemCategory.RESOURCES, "value": "low"},
    "Thoroughbred": {"category": ItemCategory.MATERIALS, "value": "medium"},
}


@dataclass
class ItemData:
    """
    Single item data structure.
    """
    name: str
    item_id: int = 0
    count: int = 0
    description: str = ""
    category: ItemCategory = ItemCategory.ITEMS
    price: int = 0  # Cent price if applicable
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "name": self.name,
            "item_id": self.item_id,
            "count": self.count,
            "description": self.description,
            "category": self.category.value,
            "price": self.price
        }
    
    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> 'ItemData':
        item = cls(
            name=data.get("name", ""),
            item_id=data.get("item_id", 0),
            count=data.get("count", 0),
            description=data.get("description", ""),
            price=data.get("price", 0)
        )
        
        cat = data.get("category", "Items")
        try:
            item.category = ItemCategory(cat)
        except ValueError:
            item.category = ItemCategory.ITEMS
        
        return item
    
    @property
    def display_name(self) -> str:
        """Format name for display (replace underscores with spaces)"""
        return self.name.replace("_", " ")
    
    @property
    def is_valuable(self) -> bool:
        """Check if this is a high-value item"""
        return self.name in VALUABLE_ITEMS and VALUABLE_ITEMS[self.name]["value"] == "high"


@dataclass
class ItemInventory:
    """
    Complete item inventory for an account.
    Organized by category.
    """
    items: Dict[str, List[ItemData]] = field(default_factory=dict)
    
    def __post_init__(self):
        # Initialize all categories
        for cat in ItemCategory:
            if cat.value not in self.items:
                self.items[cat.value] = []
    
    def add_item(self, item: ItemData):
        """Add item to appropriate category"""
        cat_key = item.category.value
        if cat_key not in self.items:
            self.items[cat_key] = []
        
        # Check if item already exists, update count
        for existing in self.items[cat_key]:
            if existing.name == item.name:
                existing.count += item.count
                return
        
        self.items[cat_key].append(item)
    
    def get_by_category(self, category: ItemCategory) -> List[ItemData]:
        """Get all items in a category"""
        return self.items.get(category.value, [])
    
    def get_item(self, name: str) -> Optional[ItemData]:
        """Find item by name across all categories"""
        for cat_items in self.items.values():
            for item in cat_items:
                if item.name == name:
                    return item
        return None
    
    def get_count(self, name: str) -> int:
        """Get count of specific item"""
        item = self.get_item(name)
        return item.count if item else 0
    
    @property
    def total_items(self) -> int:
        """Total number of unique items"""
        return sum(len(items) for items in self.items.values())
    
    @property
    def thunder_raids(self) -> int:
        """Get Thunder Raid count"""
        return self.get_count("Thunder_Raid")
    
    @property
    def fleet_feet(self) -> int:
        """Get Fleet Feet count"""
        return self.get_count("Fleet_Feet")
    
    @property
    def speakers(self) -> int:
        """Get Speaker count"""
        return self.get_count("Speaker")
    
    def get_valuable_items(self) -> List[ItemData]:
        """Get all high-value items"""
        valuable = []
        for cat_items in self.items.values():
            for item in cat_items:
                if item.is_valuable and item.count > 0:
                    valuable.append(item)
        return sorted(valuable, key=lambda x: x.count, reverse=True)
    
    def to_dict(self) -> Dict[str, List[Dict]]:
        return {
            cat: [item.to_dict() for item in items]
            for cat, items in self.items.items()
        }
    
    @classmethod
    def from_dict(cls, data: Dict[str, List[Dict]]) -> 'ItemInventory':
        inventory = cls()
        for cat, items in data.items():
            inventory.items[cat] = [ItemData.from_dict(item) for item in items]
        return inventory
    
    def format_summary(self) -> str:
        """Format a brief summary of valuable items"""
        parts = []
        if self.thunder_raids:
            parts.append(f"TR:{self.thunder_raids:,}")
        if self.fleet_feet:
            parts.append(f"FF:{self.fleet_feet:,}")
        if self.speakers:
            parts.append(f"Sp:{self.speakers:,}")
        return " | ".join(parts) if parts else "No notable items"
