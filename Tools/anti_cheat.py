"""
Anti-Cheat Detection and Evasion System

Handles detection and evasion of game anti-cheat mechanisms:
- Rate limiting with human-like delays
- Request pattern randomization
- Behavior simulation
- Detection avoidance
- Fingerprint management
"""

import logging
import time
import random
import hashlib
import json
from dataclasses import dataclass, field
from enum import Enum
from typing import Dict, Optional, List, Any, Tuple, Callable
from collections import deque
import threading

logger = logging.getLogger(__name__)


class DetectionRisk(Enum):
    """Risk level for detection"""
    SAFE = "safe"
    LOW = "low"
    MEDIUM = "medium"
    HIGH = "high"
    CRITICAL = "critical"


class ActionType(Enum):
    """Types of actions for rate limiting"""
    LOGIN = "login"
    ATTACK = "attack"
    BUILD = "build"
    TRAIN = "train"
    RESEARCH = "research"
    TRADE = "trade"
    CHAT = "chat"
    SCOUT = "scout"
    MARCH = "march"
    TRANSPORT = "transport"
    COLLECT = "collect"
    QUEST = "quest"
    GENERIC = "generic"


@dataclass
class RateLimitConfig:
    """Rate limit configuration for an action type"""
    action_type: ActionType
    min_delay_ms: int
    max_delay_ms: int
    burst_limit: int
    burst_window_seconds: float
    cooldown_after_burst_ms: int
    
    def get_delay(self) -> float:
        """Get randomized delay in seconds"""
        delay_ms = random.randint(self.min_delay_ms, self.max_delay_ms)
        # Add human-like variance
        variance = random.gauss(0, delay_ms * 0.1)
        return max(self.min_delay_ms, delay_ms + variance) / 1000.0


@dataclass
class ActionRecord:
    """Record of an action for rate limiting"""
    action_type: ActionType
    timestamp: float
    success: bool
    response_code: Optional[int] = None


@dataclass
class BehaviorProfile:
    """Simulated human behavior profile"""
    profile_id: str
    avg_session_duration_minutes: float = 45.0
    avg_actions_per_minute: float = 2.5
    peak_hours: List[int] = field(default_factory=lambda: [10, 14, 20, 22])
    break_probability: float = 0.05
    typo_probability: float = 0.02
    mouse_speed_variance: float = 0.3
    think_time_base_ms: int = 500
    
    def get_think_time(self) -> float:
        """Get simulated human think time"""
        base = self.think_time_base_ms
        variance = random.gauss(0, base * 0.5)
        return max(100, base + variance) / 1000.0
        
    def should_take_break(self) -> bool:
        """Determine if should simulate a break"""
        return random.random() < self.break_probability


@dataclass
class ClientFingerprint:
    """Client fingerprint for anti-detection"""
    fingerprint_id: str
    user_agent: str
    flash_version: str
    screen_resolution: str
    timezone_offset: int
    language: str
    platform: str
    plugins: List[str]
    hardware_concurrency: int
    canvas_hash: str
    webgl_hash: str
    
    def to_headers(self) -> Dict[str, str]:
        return {
            "User-Agent": self.user_agent,
            "Accept-Language": self.language,
            "X-Flash-Version": self.flash_version,
            "X-Screen-Resolution": self.screen_resolution,
            "X-Timezone-Offset": str(self.timezone_offset),
        }
        
    def to_dict(self) -> Dict:
        return {
            "fingerprint_id": self.fingerprint_id,
            "user_agent": self.user_agent,
            "flash_version": self.flash_version,
            "screen_resolution": self.screen_resolution,
            "timezone_offset": self.timezone_offset,
            "language": self.language,
            "platform": self.platform,
        }


class AntiCheatManager:
    """
    Manages anti-cheat detection and evasion.
    
    Features:
    - Intelligent rate limiting
    - Human behavior simulation
    - Request pattern randomization
    - Detection risk assessment
    - Fingerprint rotation
    """
    
    # Default rate limits per action type
    DEFAULT_RATE_LIMITS = {
        ActionType.LOGIN: RateLimitConfig(ActionType.LOGIN, 5000, 10000, 3, 60, 30000),
        ActionType.ATTACK: RateLimitConfig(ActionType.ATTACK, 1000, 3000, 10, 60, 5000),
        ActionType.BUILD: RateLimitConfig(ActionType.BUILD, 500, 1500, 20, 60, 2000),
        ActionType.TRAIN: RateLimitConfig(ActionType.TRAIN, 300, 1000, 30, 60, 1500),
        ActionType.RESEARCH: RateLimitConfig(ActionType.RESEARCH, 500, 2000, 10, 60, 3000),
        ActionType.TRADE: RateLimitConfig(ActionType.TRADE, 1000, 3000, 15, 60, 5000),
        ActionType.CHAT: RateLimitConfig(ActionType.CHAT, 500, 2000, 20, 60, 3000),
        ActionType.SCOUT: RateLimitConfig(ActionType.SCOUT, 500, 1500, 20, 60, 2000),
        ActionType.MARCH: RateLimitConfig(ActionType.MARCH, 800, 2000, 15, 60, 3000),
        ActionType.TRANSPORT: RateLimitConfig(ActionType.TRANSPORT, 1000, 3000, 10, 60, 5000),
        ActionType.COLLECT: RateLimitConfig(ActionType.COLLECT, 200, 800, 50, 60, 1000),
        ActionType.QUEST: RateLimitConfig(ActionType.QUEST, 500, 1500, 20, 60, 2000),
        ActionType.GENERIC: RateLimitConfig(ActionType.GENERIC, 300, 1000, 30, 60, 1500),
    }
    
    # Detection patterns to watch for
    DETECTION_PATTERNS = {
        "rapid_actions": {"threshold": 100, "window": 60, "risk": DetectionRisk.HIGH},
        "identical_timing": {"threshold": 10, "window": 300, "risk": DetectionRisk.MEDIUM},
        "impossible_sequence": {"threshold": 1, "window": 1, "risk": DetectionRisk.CRITICAL},
        "abnormal_hours": {"threshold": 4, "window": 3600, "risk": DetectionRisk.LOW},
    }
    
    def __init__(self):
        # Rate limit configs
        self._rate_limits = dict(self.DEFAULT_RATE_LIMITS)
        
        # Action history
        self._action_history: deque = deque(maxlen=10000)
        self._action_by_type: Dict[ActionType, deque] = {
            t: deque(maxlen=1000) for t in ActionType
        }
        
        # Current risk assessment
        self._current_risk = DetectionRisk.SAFE
        self._risk_factors: List[str] = []
        
        # Behavior profiles
        self._profiles: Dict[str, BehaviorProfile] = {}
        self._active_profile: Optional[BehaviorProfile] = None
        
        # Fingerprints
        self._fingerprints: List[ClientFingerprint] = []
        self._current_fingerprint: Optional[ClientFingerprint] = None
        
        # Lock
        self._lock = threading.RLock()
        
        # Initialize
        self._init_default_profiles()
        self._init_default_fingerprints()
        
    def can_execute(self, action_type: ActionType) -> Tuple[bool, float]:
        """
        Check if action can be executed safely.
        Returns (can_execute, wait_time_if_no)
        """
        with self._lock:
            rate_limit = self._rate_limits.get(action_type, self._rate_limits[ActionType.GENERIC])
            history = self._action_by_type[action_type]
            
            now = time.time()
            
            # Check burst limit
            recent_count = sum(1 for r in history 
                             if now - r.timestamp < rate_limit.burst_window_seconds)
                             
            if recent_count >= rate_limit.burst_limit:
                # Need to wait for cooldown
                wait_time = rate_limit.cooldown_after_burst_ms / 1000.0
                return False, wait_time
                
            # Check last action time
            if history:
                last_action = history[-1]
                elapsed_ms = (now - last_action.timestamp) * 1000
                
                if elapsed_ms < rate_limit.min_delay_ms:
                    wait_time = (rate_limit.min_delay_ms - elapsed_ms) / 1000.0
                    return False, wait_time
                    
            return True, 0.0
            
    def get_safe_delay(self, action_type: ActionType) -> float:
        """Get a safe delay before executing action"""
        with self._lock:
            rate_limit = self._rate_limits.get(action_type, self._rate_limits[ActionType.GENERIC])
            
            # Base delay from rate limit
            delay = rate_limit.get_delay()
            
            # Add behavior-based think time
            if self._active_profile:
                delay += self._active_profile.get_think_time()
                
            # Add extra delay if risk is elevated
            if self._current_risk in [DetectionRisk.MEDIUM, DetectionRisk.HIGH]:
                delay *= 1.5
            elif self._current_risk == DetectionRisk.CRITICAL:
                delay *= 3.0
                
            return delay
            
    def record_action(self, action_type: ActionType, success: bool = True,
                      response_code: Optional[int] = None):
        """Record an action for rate limiting"""
        with self._lock:
            record = ActionRecord(
                action_type=action_type,
                timestamp=time.time(),
                success=success,
                response_code=response_code,
            )
            
            self._action_history.append(record)
            self._action_by_type[action_type].append(record)
            
            # Update risk assessment
            self._assess_risk()
            
    def assess_risk(self) -> Tuple[DetectionRisk, List[str]]:
        """Assess current detection risk"""
        with self._lock:
            self._assess_risk()
            return self._current_risk, self._risk_factors.copy()
            
    def get_fingerprint(self) -> ClientFingerprint:
        """Get current client fingerprint"""
        if not self._current_fingerprint:
            self.rotate_fingerprint()
        return self._current_fingerprint
        
    def rotate_fingerprint(self):
        """Rotate to a new fingerprint"""
        with self._lock:
            if self._fingerprints:
                self._current_fingerprint = random.choice(self._fingerprints)
            else:
                self._current_fingerprint = self._generate_fingerprint()
                
    def set_behavior_profile(self, profile_id: str):
        """Set active behavior profile"""
        with self._lock:
            if profile_id in self._profiles:
                self._active_profile = self._profiles[profile_id]
                
    def should_take_break(self) -> Tuple[bool, float]:
        """Check if should simulate a break, returns (should_break, duration)"""
        if self._active_profile and self._active_profile.should_take_break():
            duration = random.uniform(30, 300)  # 30 seconds to 5 minutes
            return True, duration
        return False, 0.0
        
    def add_jitter(self, value: float, max_percent: float = 0.2) -> float:
        """Add random jitter to a value"""
        jitter = random.uniform(-max_percent, max_percent) * value
        return value + jitter
        
    def get_statistics(self) -> Dict:
        """Get anti-cheat statistics"""
        with self._lock:
            action_counts = {t.value: len(self._action_by_type[t]) for t in ActionType}
            
            return {
                "current_risk": self._current_risk.value,
                "risk_factors": self._risk_factors,
                "total_actions": len(self._action_history),
                "action_counts": action_counts,
                "active_profile": self._active_profile.profile_id if self._active_profile else None,
                "current_fingerprint": self._current_fingerprint.fingerprint_id if self._current_fingerprint else None,
            }
            
    # ========== Private Methods ==========
    
    def _assess_risk(self):
        """Assess detection risk based on action patterns"""
        self._risk_factors = []
        max_risk = DetectionRisk.SAFE
        now = time.time()
        
        # Check rapid actions
        recent_actions = sum(1 for r in self._action_history if now - r.timestamp < 60)
        if recent_actions > self.DETECTION_PATTERNS["rapid_actions"]["threshold"]:
            self._risk_factors.append(f"Rapid actions: {recent_actions}/60s")
            max_risk = max(max_risk, DetectionRisk.HIGH, key=lambda x: list(DetectionRisk).index(x))
            
        # Check for failed requests (possible detection)
        recent_failures = sum(1 for r in self._action_history 
                            if now - r.timestamp < 300 and not r.success)
        if recent_failures > 5:
            self._risk_factors.append(f"Multiple failures: {recent_failures}")
            max_risk = max(max_risk, DetectionRisk.MEDIUM, key=lambda x: list(DetectionRisk).index(x))
            
        # Check for suspicious response codes
        suspicious_codes = [429, 403, 401]  # Rate limit, forbidden, unauthorized
        recent_suspicious = sum(1 for r in self._action_history
                               if now - r.timestamp < 300 and r.response_code in suspicious_codes)
        if recent_suspicious > 0:
            self._risk_factors.append(f"Suspicious responses: {recent_suspicious}")
            max_risk = max(max_risk, DetectionRisk.HIGH, key=lambda x: list(DetectionRisk).index(x))
            
        # Check for abnormal hours activity
        current_hour = time.localtime().tm_hour
        if self._active_profile and current_hour not in self._active_profile.peak_hours:
            if recent_actions > 50:
                self._risk_factors.append(f"High activity in off-peak hour: {current_hour}")
                max_risk = max(max_risk, DetectionRisk.LOW, key=lambda x: list(DetectionRisk).index(x))
                
        self._current_risk = max_risk
        
    def _init_default_profiles(self):
        """Initialize default behavior profiles"""
        self._profiles = {
            "casual": BehaviorProfile(
                profile_id="casual",
                avg_session_duration_minutes=30,
                avg_actions_per_minute=1.5,
                peak_hours=[12, 18, 20, 21],
                break_probability=0.08,
                think_time_base_ms=800,
            ),
            "active": BehaviorProfile(
                profile_id="active",
                avg_session_duration_minutes=60,
                avg_actions_per_minute=3.0,
                peak_hours=[10, 14, 18, 20, 22],
                break_probability=0.04,
                think_time_base_ms=400,
            ),
            "hardcore": BehaviorProfile(
                profile_id="hardcore",
                avg_session_duration_minutes=120,
                avg_actions_per_minute=5.0,
                peak_hours=list(range(8, 24)),
                break_probability=0.02,
                think_time_base_ms=250,
            ),
        }
        self._active_profile = self._profiles["active"]
        
    def _init_default_fingerprints(self):
        """Initialize default fingerprints"""
        user_agents = [
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
            "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36",
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36",
        ]
        
        for i, ua in enumerate(user_agents):
            fp = ClientFingerprint(
                fingerprint_id=f"fp_{i:03d}",
                user_agent=ua,
                flash_version="32.0.0.465",
                screen_resolution=random.choice(["1920x1080", "2560x1440", "1366x768"]),
                timezone_offset=random.choice([-8, -5, 0, 1, 8]),
                language=random.choice(["en-US", "en-GB", "de-DE"]),
                platform="Win32",
                plugins=["Shockwave Flash", "Chrome PDF Viewer"],
                hardware_concurrency=random.choice([4, 8, 16]),
                canvas_hash=hashlib.md5(f"canvas_{i}".encode()).hexdigest(),
                webgl_hash=hashlib.md5(f"webgl_{i}".encode()).hexdigest(),
            )
            self._fingerprints.append(fp)
            
        self._current_fingerprint = self._fingerprints[0]
        
    def _generate_fingerprint(self) -> ClientFingerprint:
        """Generate a new random fingerprint"""
        return ClientFingerprint(
            fingerprint_id=f"fp_{hashlib.md5(str(time.time()).encode()).hexdigest()[:8]}",
            user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
            flash_version="32.0.0.465",
            screen_resolution="1920x1080",
            timezone_offset=-8,
            language="en-US",
            platform="Win32",
            plugins=["Shockwave Flash"],
            hardware_concurrency=8,
            canvas_hash=hashlib.md5(str(random.random()).encode()).hexdigest(),
            webgl_hash=hashlib.md5(str(random.random()).encode()).hexdigest(),
        )


# Singleton
_anti_cheat: Optional[AntiCheatManager] = None

def get_anti_cheat_manager() -> AntiCheatManager:
    """Get singleton anti-cheat manager"""
    global _anti_cheat
    if _anti_cheat is None:
        _anti_cheat = AntiCheatManager()
    return _anti_cheat
