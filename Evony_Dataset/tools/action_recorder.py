"""
Action Recorder - Capture All User Interactions

Records button clicks, menu selections, form inputs, and all UI events
from the live Flash session. Enables replay, script generation, and
pattern analysis for automation.
"""

import logging
import json
import time
import threading
from dataclasses import dataclass, field
from enum import Enum
from pathlib import Path
from typing import List, Dict, Optional, Any, Callable
from collections import deque
import hashlib

logger = logging.getLogger(__name__)


class ActionType(Enum):
    """Types of recordable actions"""
    CLICK = "click"
    DOUBLE_CLICK = "double_click"
    RIGHT_CLICK = "right_click"
    KEY_PRESS = "key_press"
    KEY_RELEASE = "key_release"
    TEXT_INPUT = "text_input"
    SCROLL = "scroll"
    DRAG = "drag"
    DROP = "drop"
    FOCUS = "focus"
    BLUR = "blur"
    SELECT = "select"
    SUBMIT = "submit"
    MENU_OPEN = "menu_open"
    MENU_SELECT = "menu_select"
    TAB_SWITCH = "tab_switch"
    DIALOG_OPEN = "dialog_open"
    DIALOG_CLOSE = "dialog_close"
    PACKET_SENT = "packet_sent"
    PACKET_RECEIVED = "packet_received"
    COMMAND = "command"
    CUSTOM = "custom"


class RecordingState(Enum):
    """Recording state"""
    IDLE = "idle"
    RECORDING = "recording"
    PAUSED = "paused"
    PLAYING = "playing"


@dataclass
class RecordedAction:
    """A single recorded action"""
    action_id: str
    action_type: ActionType
    timestamp: float
    target: str  # Element ID or name
    coordinates: tuple = (0, 0)  # x, y
    value: Any = None  # Input value, key code, etc.
    context: Dict[str, Any] = field(default_factory=dict)
    duration: float = 0.0  # For drag, hold actions
    metadata: Dict[str, Any] = field(default_factory=dict)
    
    def to_dict(self) -> Dict:
        return {
            "action_id": self.action_id,
            "action_type": self.action_type.value,
            "timestamp": self.timestamp,
            "target": self.target,
            "coordinates": self.coordinates,
            "value": self.value,
            "context": self.context,
            "duration": self.duration,
            "metadata": self.metadata,
        }
        
    @classmethod
    def from_dict(cls, data: Dict) -> "RecordedAction":
        return cls(
            action_id=data["action_id"],
            action_type=ActionType(data["action_type"]),
            timestamp=data["timestamp"],
            target=data["target"],
            coordinates=tuple(data.get("coordinates", (0, 0))),
            value=data.get("value"),
            context=data.get("context", {}),
            duration=data.get("duration", 0.0),
            metadata=data.get("metadata", {}),
        )
        
    def to_script_line(self) -> str:
        """Convert action to bot script command"""
        if self.action_type == ActionType.CLICK:
            return f"click('{self.target}', x={self.coordinates[0]}, y={self.coordinates[1]})"
        elif self.action_type == ActionType.TEXT_INPUT:
            return f"input('{self.target}', '{self.value}')"
        elif self.action_type == ActionType.KEY_PRESS:
            return f"key_press('{self.value}')"
        elif self.action_type == ActionType.MENU_SELECT:
            return f"menu_select('{self.target}', '{self.value}')"
        elif self.action_type == ActionType.COMMAND:
            return f"send_command('{self.value}')"
        else:
            return f"# {self.action_type.value}: {self.target}"


@dataclass
class RecordingSession:
    """A recording session containing multiple actions"""
    session_id: str
    name: str
    started_at: float
    ended_at: float = 0.0
    actions: List[RecordedAction] = field(default_factory=list)
    metadata: Dict[str, Any] = field(default_factory=dict)
    
    @property
    def duration(self) -> float:
        if self.ended_at > 0:
            return self.ended_at - self.started_at
        return time.time() - self.started_at
        
    @property
    def action_count(self) -> int:
        return len(self.actions)
        
    def to_dict(self) -> Dict:
        return {
            "session_id": self.session_id,
            "name": self.name,
            "started_at": self.started_at,
            "ended_at": self.ended_at,
            "actions": [a.to_dict() for a in self.actions],
            "metadata": self.metadata,
        }
        
    @classmethod
    def from_dict(cls, data: Dict) -> "RecordingSession":
        session = cls(
            session_id=data["session_id"],
            name=data["name"],
            started_at=data["started_at"],
            ended_at=data.get("ended_at", 0.0),
            metadata=data.get("metadata", {}),
        )
        session.actions = [RecordedAction.from_dict(a) for a in data.get("actions", [])]
        return session
        
    def to_script(self) -> str:
        """Convert session to bot script"""
        lines = [
            f"# Recording: {self.name}",
            f"# Duration: {self.duration:.2f}s",
            f"# Actions: {self.action_count}",
            "",
            "from svony.bot import *",
            "",
            "def replay():",
        ]
        
        prev_time = self.started_at
        for action in self.actions:
            delay = action.timestamp - prev_time
            if delay > 0.1:  # Only add delay if > 100ms
                lines.append(f"    wait({delay:.2f})")
            lines.append(f"    {action.to_script_line()}")
            prev_time = action.timestamp
            
        lines.append("")
        lines.append("if __name__ == '__main__':")
        lines.append("    replay()")
        
        return "\n".join(lines)


class ActionRecorder:
    """
    Records all user interactions for replay and automation.
    
    Features:
    - Record clicks, inputs, menu selections
    - Capture packet sends (commands)
    - Generate bot scripts from recordings
    - Playback with timing
    - Pattern detection for automation
    """
    
    def __init__(self, recordings_dir: Optional[str] = None):
        self.recordings_dir = Path(recordings_dir) if recordings_dir else Path("recordings")
        self.recordings_dir.mkdir(exist_ok=True)
        
        # State
        self._state = RecordingState.IDLE
        self._current_session: Optional[RecordingSession] = None
        self._sessions: Dict[str, RecordingSession] = {}
        
        # Real-time buffer for live view
        self._action_buffer: deque = deque(maxlen=1000)
        
        # Callbacks
        self._on_action_callbacks: List[Callable[[RecordedAction], None]] = []
        
        # Thread safety
        self._lock = threading.RLock()
        
        # Action counter for IDs
        self._action_counter = 0
        
        # Load existing sessions
        self._load_sessions()
        
    @property
    def state(self) -> RecordingState:
        return self._state
        
    @property
    def is_recording(self) -> bool:
        return self._state == RecordingState.RECORDING
        
    @property
    def current_session(self) -> Optional[RecordingSession]:
        return self._current_session
        
    def start_recording(self, name: str = "") -> RecordingSession:
        """Start a new recording session"""
        with self._lock:
            if self._state == RecordingState.RECORDING:
                self.stop_recording()
                
            session_id = hashlib.md5(f"{time.time()}".encode()).hexdigest()[:8]
            
            self._current_session = RecordingSession(
                session_id=session_id,
                name=name or f"Recording_{session_id}",
                started_at=time.time(),
            )
            
            self._state = RecordingState.RECORDING
            self._action_buffer.clear()
            
            logger.info(f"Started recording: {self._current_session.name}")
            return self._current_session
            
    def stop_recording(self) -> Optional[RecordingSession]:
        """Stop current recording"""
        with self._lock:
            if not self._current_session:
                return None
                
            self._current_session.ended_at = time.time()
            self._sessions[self._current_session.session_id] = self._current_session
            
            # Save to disk
            self._save_session(self._current_session)
            
            session = self._current_session
            self._current_session = None
            self._state = RecordingState.IDLE
            
            logger.info(f"Stopped recording: {session.name} ({session.action_count} actions)")
            return session
            
    def pause_recording(self):
        """Pause recording"""
        with self._lock:
            if self._state == RecordingState.RECORDING:
                self._state = RecordingState.PAUSED
                
    def resume_recording(self):
        """Resume paused recording"""
        with self._lock:
            if self._state == RecordingState.PAUSED:
                self._state = RecordingState.RECORDING
                
    def record_action(self, action_type: ActionType, target: str,
                      coordinates: tuple = (0, 0),
                      value: Any = None,
                      context: Optional[Dict] = None) -> Optional[RecordedAction]:
        """Record a single action"""
        with self._lock:
            if self._state != RecordingState.RECORDING:
                return None
                
            self._action_counter += 1
            action_id = f"act_{self._action_counter:06d}"
            
            action = RecordedAction(
                action_id=action_id,
                action_type=action_type,
                timestamp=time.time(),
                target=target,
                coordinates=coordinates,
                value=value,
                context=context or {},
            )
            
            if self._current_session:
                self._current_session.actions.append(action)
                
            self._action_buffer.append(action)
            
            # Notify callbacks
            for callback in self._on_action_callbacks:
                try:
                    callback(action)
                except Exception as e:
                    logger.error(f"Callback error: {e}")
                    
            return action
            
    def record_click(self, target: str, x: int, y: int,
                     button: str = "left") -> Optional[RecordedAction]:
        """Convenience method to record a click"""
        action_type = {
            "left": ActionType.CLICK,
            "right": ActionType.RIGHT_CLICK,
            "double": ActionType.DOUBLE_CLICK,
        }.get(button, ActionType.CLICK)
        
        return self.record_action(
            action_type=action_type,
            target=target,
            coordinates=(x, y),
            context={"button": button},
        )
        
    def record_input(self, target: str, value: str) -> Optional[RecordedAction]:
        """Convenience method to record text input"""
        return self.record_action(
            action_type=ActionType.TEXT_INPUT,
            target=target,
            value=value,
        )
        
    def record_key(self, key: str, pressed: bool = True) -> Optional[RecordedAction]:
        """Convenience method to record key press/release"""
        return self.record_action(
            action_type=ActionType.KEY_PRESS if pressed else ActionType.KEY_RELEASE,
            target="keyboard",
            value=key,
        )
        
    def record_command(self, command: str, params: Dict = None) -> Optional[RecordedAction]:
        """Record a game command (packet sent)"""
        return self.record_action(
            action_type=ActionType.COMMAND,
            target="server",
            value=command,
            context={"params": params or {}},
        )
        
    def record_packet(self, direction: str, data: bytes,
                      decoded: Optional[Dict] = None) -> Optional[RecordedAction]:
        """Record a network packet"""
        action_type = ActionType.PACKET_SENT if direction == "out" else ActionType.PACKET_RECEIVED
        
        return self.record_action(
            action_type=action_type,
            target="network",
            value=decoded or {"raw_length": len(data)},
            context={"direction": direction},
        )
        
    def get_session(self, session_id: str) -> Optional[RecordingSession]:
        """Get a session by ID"""
        return self._sessions.get(session_id)
        
    def get_all_sessions(self) -> List[RecordingSession]:
        """Get all sessions"""
        return list(self._sessions.values())
        
    def get_recent_actions(self, count: int = 100) -> List[RecordedAction]:
        """Get recent actions from buffer"""
        with self._lock:
            return list(self._action_buffer)[-count:]
            
    def delete_session(self, session_id: str) -> bool:
        """Delete a recording session"""
        with self._lock:
            if session_id in self._sessions:
                session = self._sessions.pop(session_id)
                
                # Delete file
                session_file = self.recordings_dir / f"{session_id}.json"
                if session_file.exists():
                    session_file.unlink()
                    
                return True
            return False
            
    def export_to_script(self, session_id: str, 
                         output_path: Optional[str] = None) -> Optional[str]:
        """Export session to bot script"""
        session = self.get_session(session_id)
        if not session:
            return None
            
        script = session.to_script()
        
        if output_path:
            Path(output_path).write_text(script)
            
        return script
        
    def on_action(self, callback: Callable[[RecordedAction], None]):
        """Register callback for new actions"""
        self._on_action_callbacks.append(callback)
        
    def get_statistics(self) -> Dict[str, Any]:
        """Get recorder statistics"""
        with self._lock:
            total_actions = sum(s.action_count for s in self._sessions.values())
            
            action_types = {}
            for session in self._sessions.values():
                for action in session.actions:
                    t = action.action_type.value
                    action_types[t] = action_types.get(t, 0) + 1
                    
            return {
                "state": self._state.value,
                "total_sessions": len(self._sessions),
                "total_actions": total_actions,
                "buffer_size": len(self._action_buffer),
                "action_types": action_types,
            }
            
    def _save_session(self, session: RecordingSession):
        """Save session to disk"""
        try:
            session_file = self.recordings_dir / f"{session.session_id}.json"
            with open(session_file, "w") as f:
                json.dump(session.to_dict(), f, indent=2)
        except Exception as e:
            logger.error(f"Failed to save session: {e}")
            
    def _load_sessions(self):
        """Load sessions from disk"""
        try:
            for session_file in self.recordings_dir.glob("*.json"):
                with open(session_file, "r") as f:
                    data = json.load(f)
                session = RecordingSession.from_dict(data)
                self._sessions[session.session_id] = session
                
            logger.info(f"Loaded {len(self._sessions)} recording sessions")
        except Exception as e:
            logger.error(f"Failed to load sessions: {e}")


# Singleton
_recorder: Optional[ActionRecorder] = None

def get_action_recorder() -> ActionRecorder:
    """Get singleton action recorder instance"""
    global _recorder
    if _recorder is None:
        _recorder = ActionRecorder()
    return _recorder
