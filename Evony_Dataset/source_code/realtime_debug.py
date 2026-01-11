"""
Real-Time Debug Panel - Live Game Data Visualization

Provides real-time debugging and visualization for:
- Live game state monitoring
- Bean value tracking
- Command execution logging
- Glitch progress visualization
- Multi-account status
- Visual debugging panel integration
"""

import logging
import time
import json
import threading
from dataclasses import dataclass, field
from datetime import datetime
from enum import Enum
from typing import Dict, Optional, List, Any, Callable
from queue import Queue

logger = logging.getLogger(__name__)


class EventType(Enum):
    """Debug event types"""
    COMMAND_SENT = "command_sent"
    COMMAND_RESPONSE = "command_response"
    STATE_UPDATE = "state_update"
    GLITCH_PROGRESS = "glitch_progress"
    ERROR = "error"
    WARNING = "warning"
    INFO = "info"
    BEAN_UPDATE = "bean_update"
    TROOP_CHANGE = "troop_change"
    RESOURCE_CHANGE = "resource_change"
    ACCOUNT_STATUS = "account_status"


@dataclass
class DebugEvent:
    """Single debug event"""
    event_type: EventType
    timestamp: datetime
    source: str
    data: Dict[str, Any]
    account: str = ""
    city: str = ""
    
    def to_dict(self) -> Dict:
        return {
            "type": self.event_type.value,
            "timestamp": self.timestamp.isoformat(),
            "source": self.source,
            "data": self.data,
            "account": self.account,
            "city": self.city,
        }


@dataclass
class BeanWatch:
    """Watched bean value"""
    bean_path: str
    current_value: Any = None
    previous_value: Any = None
    last_update: Optional[datetime] = None
    change_count: int = 0
    
    @property
    def has_changed(self) -> bool:
        return self.current_value != self.previous_value


@dataclass
class AccountStatus:
    """Live account status"""
    username: str
    server: str
    connected: bool = False
    last_activity: Optional[datetime] = None
    current_city: str = ""
    troops: Dict[str, int] = field(default_factory=dict)
    resources: Dict[str, int] = field(default_factory=dict)
    glitch_status: Dict[str, Any] = field(default_factory=dict)
    errors: List[str] = field(default_factory=list)


class RealTimeDebugPanel:
    """
    Real-time debug panel for Svony Studio.
    
    Features:
    - Live game state monitoring
    - Bean value watching
    - Command logging
    - Glitch progress tracking
    - Multi-account status
    - Event streaming for UI
    """
    
    # Max events to keep in memory
    MAX_EVENTS = 1000
    
    # Common beans to watch
    DEFAULT_BEANS = [
        "c.castle.troop.archer",
        "c.castle.troop.cavalry",
        "c.castle.troop.cataphract",
        "c.cm.resource.food",
        "c.cm.resource.gold",
        "c.cm.resource.troopCostFood",
        "c.cm.resource.foodProduction",
        "m_city.allCities.length",
    ]
    
    def __init__(self):
        self._events: List[DebugEvent] = []
        self._event_queue: Queue = Queue()
        self._watches: Dict[str, BeanWatch] = {}
        self._accounts: Dict[str, AccountStatus] = {}
        self._listeners: List[Callable] = []
        self._running = False
        self._thread: Optional[threading.Thread] = None
        self._lock = threading.RLock()
        
        # Initialize default watches
        for bean in self.DEFAULT_BEANS:
            self.add_watch(bean)
            
    def start(self):
        """Start the debug panel background thread"""
        self._running = True
        self._thread = threading.Thread(target=self._process_loop, daemon=True)
        self._thread.start()
        logger.info("Real-time debug panel started")
        
    def stop(self):
        """Stop the debug panel"""
        self._running = False
        if self._thread:
            self._thread.join(timeout=2)
        logger.info("Real-time debug panel stopped")
        
    # ========== Event Logging ==========
    
    def log_event(self, event_type: EventType, source: str, data: Dict,
                  account: str = "", city: str = ""):
        """Log a debug event"""
        event = DebugEvent(
            event_type=event_type,
            timestamp=datetime.now(),
            source=source,
            data=data,
            account=account,
            city=city,
        )
        
        self._event_queue.put(event)
        
    def log_command(self, command: str, params: Dict, account: str = ""):
        """Log a command being sent"""
        self.log_event(
            EventType.COMMAND_SENT,
            "AMFCommander",
            {"command": command, "params": params},
            account=account,
        )
        
    def log_response(self, command: str, response: Dict, success: bool,
                     account: str = ""):
        """Log a command response"""
        self.log_event(
            EventType.COMMAND_RESPONSE,
            "AMFCommander",
            {"command": command, "response": response, "success": success},
            account=account,
        )
        
    def log_error(self, source: str, error: str, account: str = ""):
        """Log an error"""
        self.log_event(
            EventType.ERROR,
            source,
            {"error": error},
            account=account,
        )
        
    def log_glitch_progress(self, troop_type: str, city_glitches: int,
                            valley_glitches: int, progress: float,
                            is_generating: bool, account: str = "", city: str = ""):
        """Log glitch progress update"""
        self.log_event(
            EventType.GLITCH_PROGRESS,
            "TroopGlitchManager",
            {
                "troop_type": troop_type,
                "city_glitches": city_glitches,
                "valley_glitches": valley_glitches,
                "progress_percent": progress,
                "is_generating_food": is_generating,
            },
            account=account,
            city=city,
        )
        
    # ========== Bean Watching ==========
    
    def add_watch(self, bean_path: str):
        """Add a bean to watch"""
        if bean_path not in self._watches:
            self._watches[bean_path] = BeanWatch(bean_path=bean_path)
            
    def remove_watch(self, bean_path: str):
        """Remove a watched bean"""
        if bean_path in self._watches:
            del self._watches[bean_path]
            
    def update_bean(self, bean_path: str, value: Any, account: str = ""):
        """Update a watched bean value"""
        if bean_path not in self._watches:
            self.add_watch(bean_path)
            
        watch = self._watches[bean_path]
        watch.previous_value = watch.current_value
        watch.current_value = value
        watch.last_update = datetime.now()
        watch.change_count += 1
        
        if watch.has_changed:
            self.log_event(
                EventType.BEAN_UPDATE,
                "BeanWatcher",
                {
                    "bean": bean_path,
                    "old_value": watch.previous_value,
                    "new_value": value,
                },
                account=account,
            )
            
    def get_watched_beans(self) -> Dict[str, BeanWatch]:
        """Get all watched beans"""
        return dict(self._watches)
        
    # ========== Account Status ==========
    
    def update_account_status(self, username: str, server: str, **kwargs):
        """Update account status"""
        key = f"{username}@{server}"
        
        if key not in self._accounts:
            self._accounts[key] = AccountStatus(username=username, server=server)
            
        status = self._accounts[key]
        
        for k, v in kwargs.items():
            if hasattr(status, k):
                setattr(status, k, v)
                
        status.last_activity = datetime.now()
        
        self.log_event(
            EventType.ACCOUNT_STATUS,
            "AccountManager",
            {"status": kwargs},
            account=username,
        )
        
    def get_account_status(self, username: str, server: str) -> Optional[AccountStatus]:
        """Get account status"""
        key = f"{username}@{server}"
        return self._accounts.get(key)
        
    def get_all_accounts(self) -> Dict[str, AccountStatus]:
        """Get all account statuses"""
        return dict(self._accounts)
        
    # ========== Event Listeners ==========
    
    def add_listener(self, callback: Callable[[DebugEvent], None]):
        """Add event listener for UI updates"""
        self._listeners.append(callback)
        
    def remove_listener(self, callback: Callable):
        """Remove event listener"""
        if callback in self._listeners:
            self._listeners.remove(callback)
            
    def _notify_listeners(self, event: DebugEvent):
        """Notify all listeners of new event"""
        for listener in self._listeners:
            try:
                listener(event)
            except Exception as e:
                logger.error(f"Listener error: {e}")
                
    # ========== Background Processing ==========
    
    def _process_loop(self):
        """Background event processing loop"""
        while self._running:
            try:
                # Process queued events
                while not self._event_queue.empty():
                    event = self._event_queue.get_nowait()
                    
                    with self._lock:
                        self._events.append(event)
                        
                        # Trim old events
                        if len(self._events) > self.MAX_EVENTS:
                            self._events = self._events[-self.MAX_EVENTS:]
                            
                    # Notify listeners
                    self._notify_listeners(event)
                    
                time.sleep(0.1)  # Small delay
                
            except Exception as e:
                logger.error(f"Debug panel error: {e}")
                time.sleep(1)
                
    # ========== Data Access ==========
    
    def get_events(self, count: int = 100, event_type: EventType = None,
                   account: str = None) -> List[DebugEvent]:
        """Get recent events with optional filtering"""
        with self._lock:
            events = list(self._events)
            
        # Filter by type
        if event_type:
            events = [e for e in events if e.event_type == event_type]
            
        # Filter by account
        if account:
            events = [e for e in events if e.account == account]
            
        # Return most recent
        return events[-count:]
        
    def get_events_json(self, count: int = 100) -> str:
        """Get events as JSON for UI"""
        events = self.get_events(count)
        return json.dumps([e.to_dict() for e in events], indent=2)
        
    def get_summary(self) -> Dict:
        """Get debug panel summary"""
        with self._lock:
            event_counts = {}
            for event in self._events:
                event_type = event.event_type.value
                event_counts[event_type] = event_counts.get(event_type, 0) + 1
                
        return {
            "running": self._running,
            "total_events": len(self._events),
            "event_counts": event_counts,
            "watched_beans": len(self._watches),
            "tracked_accounts": len(self._accounts),
            "listeners": len(self._listeners),
        }
        
    def clear_events(self):
        """Clear all events"""
        with self._lock:
            self._events.clear()
            
    # ========== UI Data Formatting ==========
    
    def get_glitch_display_data(self, account: str = None) -> List[Dict]:
        """Get formatted glitch data for UI display"""
        events = self.get_events(100, EventType.GLITCH_PROGRESS, account)
        
        # Group by troop type, get latest
        latest = {}
        for event in events:
            troop = event.data.get("troop_type")
            if troop:
                latest[troop] = event.data
                
        return [
            {
                "troop": troop,
                "city_glitches": data.get("city_glitches", 0),
                "valley_glitches": data.get("valley_glitches", 0),
                "progress": data.get("progress_percent", 0),
                "generating": data.get("is_generating_food", False),
            }
            for troop, data in latest.items()
        ]
        
    def get_resource_display_data(self, account: str = None) -> Dict:
        """Get formatted resource data for UI display"""
        # Get latest bean values for resources
        resources = {}
        for bean_path, watch in self._watches.items():
            if "resource" in bean_path:
                key = bean_path.split(".")[-1]
                resources[key] = watch.current_value
                
        return resources
        
    def get_troop_display_data(self, account: str = None) -> Dict:
        """Get formatted troop data for UI display"""
        troops = {}
        for bean_path, watch in self._watches.items():
            if "troop" in bean_path:
                key = bean_path.split(".")[-1]
                troops[key] = watch.current_value
                
        return troops


# Singleton
_debug_panel: Optional[RealTimeDebugPanel] = None

def get_debug_panel() -> RealTimeDebugPanel:
    """Get singleton debug panel"""
    global _debug_panel
    if _debug_panel is None:
        _debug_panel = RealTimeDebugPanel()
    return _debug_panel
