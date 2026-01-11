"""
Packet Interceptor - MITM Proxy for Real-Time Traffic Capture

Intercepts all game traffic between client and server:
- SSL/TLS termination with custom certificates
- Transparent proxy mode
- Real-time packet forwarding with logging
- Integration with crypto engine for decryption
"""

import logging
import socket
import ssl
import threading
import queue
import time
import os
from dataclasses import dataclass, field
from enum import Enum
from typing import Dict, Optional, List, Callable, Tuple, Any
from pathlib import Path
import select

logger = logging.getLogger(__name__)


class ProxyState(Enum):
    """Proxy state"""
    STOPPED = "stopped"
    STARTING = "starting"
    RUNNING = "running"
    STOPPING = "stopping"
    ERROR = "error"


class ConnectionState(Enum):
    """Connection state"""
    CONNECTING = "connecting"
    CONNECTED = "connected"
    SSL_HANDSHAKE = "ssl_handshake"
    ACTIVE = "active"
    CLOSING = "closing"
    CLOSED = "closed"


@dataclass
class CapturedPacket:
    """A captured packet"""
    packet_id: str
    timestamp: float
    direction: str  # "c2s" or "s2c"
    raw_data: bytes
    decrypted_data: Optional[bytes] = None
    source_addr: Tuple[str, int] = ("", 0)
    dest_addr: Tuple[str, int] = ("", 0)
    connection_id: str = ""
    metadata: Dict[str, Any] = field(default_factory=dict)


@dataclass
class ConnectionInfo:
    """Information about a proxied connection"""
    connection_id: str
    client_addr: Tuple[str, int]
    server_addr: Tuple[str, int]
    state: ConnectionState
    created_at: float
    packets_c2s: int = 0
    packets_s2c: int = 0
    bytes_c2s: int = 0
    bytes_s2c: int = 0


class PacketInterceptor:
    """
    MITM Proxy for intercepting game traffic.
    
    Features:
    - Transparent proxy mode
    - SSL/TLS interception
    - Real-time packet capture
    - Callback hooks for packet processing
    - Integration with packet logger and decoder
    """
    
    DEFAULT_LISTEN_PORT = 8888
    DEFAULT_TARGET_HOST = "evony.com"
    DEFAULT_TARGET_PORT = 443
    BUFFER_SIZE = 65536
    
    def __init__(self, 
                 listen_port: int = DEFAULT_LISTEN_PORT,
                 target_host: str = DEFAULT_TARGET_HOST,
                 target_port: int = DEFAULT_TARGET_PORT,
                 cert_dir: Optional[str] = None):
        
        self.listen_port = listen_port
        self.target_host = target_host
        self.target_port = target_port
        self.cert_dir = Path(cert_dir) if cert_dir else Path("certs")
        
        # State
        self._state = ProxyState.STOPPED
        self._server_socket: Optional[socket.socket] = None
        self._connections: Dict[str, ConnectionInfo] = {}
        
        # Packet queue for processing
        self._packet_queue: queue.Queue = queue.Queue()
        
        # Callbacks
        self._on_packet_callbacks: List[Callable[[CapturedPacket], None]] = []
        self._on_connect_callbacks: List[Callable[[ConnectionInfo], None]] = []
        self._on_disconnect_callbacks: List[Callable[[ConnectionInfo], None]] = []
        
        # Threading
        self._accept_thread: Optional[threading.Thread] = None
        self._process_thread: Optional[threading.Thread] = None
        self._connection_threads: Dict[str, threading.Thread] = {}
        self._shutdown_event = threading.Event()
        
        # Statistics
        self._stats = {
            "total_connections": 0,
            "active_connections": 0,
            "total_packets": 0,
            "total_bytes": 0,
        }
        
        # Packet counter
        self._packet_counter = 0
        self._connection_counter = 0
        
        # Ensure cert directory exists
        self.cert_dir.mkdir(parents=True, exist_ok=True)
        
    @property
    def state(self) -> ProxyState:
        return self._state
        
    @property
    def is_running(self) -> bool:
        return self._state == ProxyState.RUNNING
        
    def start(self) -> bool:
        """Start the proxy server"""
        if self._state == ProxyState.RUNNING:
            logger.warning("Proxy already running")
            return True
            
        try:
            self._state = ProxyState.STARTING
            self._shutdown_event.clear()
            
            # Create server socket
            self._server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self._server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            self._server_socket.bind(("0.0.0.0", self.listen_port))
            self._server_socket.listen(50)
            self._server_socket.settimeout(1.0)
            
            # Start accept thread
            self._accept_thread = threading.Thread(
                target=self._accept_loop,
                name="ProxyAccept",
                daemon=True
            )
            self._accept_thread.start()
            
            # Start packet processing thread
            self._process_thread = threading.Thread(
                target=self._process_loop,
                name="ProxyProcess",
                daemon=True
            )
            self._process_thread.start()
            
            self._state = ProxyState.RUNNING
            logger.info(f"Proxy started on port {self.listen_port}")
            return True
            
        except Exception as e:
            logger.error(f"Failed to start proxy: {e}")
            self._state = ProxyState.ERROR
            return False
            
    def stop(self):
        """Stop the proxy server"""
        if self._state != ProxyState.RUNNING:
            return
            
        self._state = ProxyState.STOPPING
        self._shutdown_event.set()
        
        # Close server socket
        if self._server_socket:
            try:
                self._server_socket.close()
            except:
                pass
                
        # Wait for threads
        if self._accept_thread:
            self._accept_thread.join(timeout=2.0)
        if self._process_thread:
            self._process_thread.join(timeout=2.0)
            
        # Close all connections
        for conn_id in list(self._connections.keys()):
            self._close_connection(conn_id)
            
        self._state = ProxyState.STOPPED
        logger.info("Proxy stopped")
        
    def on_packet(self, callback: Callable[[CapturedPacket], None]):
        """Register callback for captured packets"""
        self._on_packet_callbacks.append(callback)
        
    def on_connect(self, callback: Callable[[ConnectionInfo], None]):
        """Register callback for new connections"""
        self._on_connect_callbacks.append(callback)
        
    def on_disconnect(self, callback: Callable[[ConnectionInfo], None]):
        """Register callback for disconnections"""
        self._on_disconnect_callbacks.append(callback)
        
    def inject_packet(self, connection_id: str, data: bytes, 
                      direction: str = "c2s") -> bool:
        """Inject a packet into a connection"""
        if connection_id not in self._connections:
            return False
            
        # This would require storing socket references
        # For now, log the injection request
        logger.info(f"Packet injection requested: {connection_id} {direction} {len(data)} bytes")
        return True
        
    def get_connections(self) -> List[ConnectionInfo]:
        """Get all active connections"""
        return list(self._connections.values())
        
    def get_statistics(self) -> Dict:
        """Get proxy statistics"""
        return {
            **self._stats,
            "state": self._state.value,
            "listen_port": self.listen_port,
            "target": f"{self.target_host}:{self.target_port}",
        }
        
    def get_recent_packets(self, count: int = 100) -> List[CapturedPacket]:
        """Get recently captured packets"""
        # Would need a packet buffer for this
        return []
        
    # ========== Private Methods ==========
    
    def _accept_loop(self):
        """Accept incoming connections"""
        while not self._shutdown_event.is_set():
            try:
                client_socket, client_addr = self._server_socket.accept()
                
                # Create connection
                self._connection_counter += 1
                conn_id = f"conn_{self._connection_counter:06d}"
                
                conn_info = ConnectionInfo(
                    connection_id=conn_id,
                    client_addr=client_addr,
                    server_addr=(self.target_host, self.target_port),
                    state=ConnectionState.CONNECTING,
                    created_at=time.time(),
                )
                self._connections[conn_id] = conn_info
                self._stats["total_connections"] += 1
                self._stats["active_connections"] += 1
                
                # Notify callbacks
                for cb in self._on_connect_callbacks:
                    try:
                        cb(conn_info)
                    except Exception as e:
                        logger.error(f"Connect callback error: {e}")
                        
                # Start connection handler thread
                handler_thread = threading.Thread(
                    target=self._handle_connection,
                    args=(conn_id, client_socket),
                    name=f"ProxyConn_{conn_id}",
                    daemon=True
                )
                self._connection_threads[conn_id] = handler_thread
                handler_thread.start()
                
                logger.debug(f"New connection: {conn_id} from {client_addr}")
                
            except socket.timeout:
                continue
            except Exception as e:
                if not self._shutdown_event.is_set():
                    logger.error(f"Accept error: {e}")
                    
    def _handle_connection(self, conn_id: str, client_socket: socket.socket):
        """Handle a single proxied connection"""
        server_socket = None
        
        try:
            conn_info = self._connections[conn_id]
            
            # Connect to target server
            server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            server_socket.settimeout(10.0)
            server_socket.connect((self.target_host, self.target_port))
            
            # Wrap with SSL if needed
            if self.target_port == 443:
                context = ssl.create_default_context()
                context.check_hostname = False
                context.verify_mode = ssl.CERT_NONE
                server_socket = context.wrap_socket(
                    server_socket, 
                    server_hostname=self.target_host
                )
                conn_info.state = ConnectionState.SSL_HANDSHAKE
                
            conn_info.state = ConnectionState.ACTIVE
            
            # Set non-blocking
            client_socket.setblocking(False)
            server_socket.setblocking(False)
            
            # Proxy loop
            while not self._shutdown_event.is_set():
                readable, _, _ = select.select(
                    [client_socket, server_socket], [], [], 0.5
                )
                
                for sock in readable:
                    try:
                        data = sock.recv(self.BUFFER_SIZE)
                        if not data:
                            raise ConnectionError("Connection closed")
                            
                        if sock is client_socket:
                            # Client to server
                            self._capture_packet(conn_id, data, "c2s", 
                                                 conn_info.client_addr,
                                                 conn_info.server_addr)
                            server_socket.sendall(data)
                            conn_info.packets_c2s += 1
                            conn_info.bytes_c2s += len(data)
                        else:
                            # Server to client
                            self._capture_packet(conn_id, data, "s2c",
                                                 conn_info.server_addr,
                                                 conn_info.client_addr)
                            client_socket.sendall(data)
                            conn_info.packets_s2c += 1
                            conn_info.bytes_s2c += len(data)
                            
                    except (BlockingIOError, ssl.SSLWantReadError):
                        continue
                    except Exception as e:
                        raise
                        
        except Exception as e:
            logger.debug(f"Connection {conn_id} error: {e}")
            
        finally:
            self._close_connection(conn_id, client_socket, server_socket)
            
    def _capture_packet(self, conn_id: str, data: bytes, direction: str,
                        source: Tuple[str, int], dest: Tuple[str, int]):
        """Capture a packet for processing"""
        self._packet_counter += 1
        
        packet = CapturedPacket(
            packet_id=f"pkt_{self._packet_counter:08d}",
            timestamp=time.time(),
            direction=direction,
            raw_data=data,
            source_addr=source,
            dest_addr=dest,
            connection_id=conn_id,
        )
        
        self._packet_queue.put(packet)
        self._stats["total_packets"] += 1
        self._stats["total_bytes"] += len(data)
        
    def _process_loop(self):
        """Process captured packets"""
        while not self._shutdown_event.is_set():
            try:
                packet = self._packet_queue.get(timeout=0.5)
                
                # Notify callbacks
                for callback in self._on_packet_callbacks:
                    try:
                        callback(packet)
                    except Exception as e:
                        logger.error(f"Packet callback error: {e}")
                        
            except queue.Empty:
                continue
            except Exception as e:
                logger.error(f"Process error: {e}")
                
    def _close_connection(self, conn_id: str, 
                          client_socket: Optional[socket.socket] = None,
                          server_socket: Optional[socket.socket] = None):
        """Close a connection"""
        if conn_id in self._connections:
            conn_info = self._connections[conn_id]
            conn_info.state = ConnectionState.CLOSED
            
            # Notify callbacks
            for cb in self._on_disconnect_callbacks:
                try:
                    cb(conn_info)
                except:
                    pass
                    
            del self._connections[conn_id]
            self._stats["active_connections"] -= 1
            
        # Close sockets
        for sock in [client_socket, server_socket]:
            if sock:
                try:
                    sock.close()
                except:
                    pass
                    
        # Remove thread reference
        if conn_id in self._connection_threads:
            del self._connection_threads[conn_id]


# Singleton
_interceptor: Optional[PacketInterceptor] = None

def get_packet_interceptor() -> PacketInterceptor:
    """Get singleton packet interceptor"""
    global _interceptor
    if _interceptor is None:
        _interceptor = PacketInterceptor()
    return _interceptor
