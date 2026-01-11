import sqlite3
import json
from datetime import datetime
import threading
from pathlib import Path

class DatabaseManager:
    def __init__(self, db_path="./data/assistant.db"):
        self.db_path = Path(db_path)
        self.db_path.parent.mkdir(parents=True, exist_ok=True)
        self.lock = threading.Lock()
        self.setup_database()
        
    def setup_database(self):
        """Initialize database tables"""
        with self.get_connection() as conn:
            cursor = conn.cursor()
            
            # Chat history table
            cursor.execute('''
                CREATE TABLE IF NOT EXISTS chat_history (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
                    user_id TEXT,
                    message_type TEXT,
                    content TEXT,
                    metadata JSON
                )
            ''')
            
            # Game state table
            cursor.execute('''
                CREATE TABLE IF NOT EXISTS game_states (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
                    game_state JSON,
                    analysis_result JSON
                )
            ''')
            
            # Training data table
            cursor.execute('''
                CREATE TABLE IF NOT EXISTS training_data (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
                    data_type TEXT,
                    content BLOB,
                    labels JSON,
                    metadata JSON
                )
            ''')
            
            # Model states table
            cursor.execute('''
                CREATE TABLE IF NOT EXISTS model_states (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
                    model_name TEXT,
                    model_version TEXT,
                    model_parameters JSON,
                    performance_metrics JSON
                )
            ''')
            
            # User settings table
            cursor.execute('''
                CREATE TABLE IF NOT EXISTS user_settings (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    user_id TEXT UNIQUE,
                    settings JSON,
                    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP
                )
            ''')
            
            conn.commit()
    
    def get_connection(self):
        """Get database connection"""
        return sqlite3.connect(self.db_path)
    
    def save_chat_message(self, user_id, message_type, content, metadata=None):
        """Save chat message to database"""
        with self.lock:
            with self.get_connection() as conn:
                cursor = conn.cursor()
                cursor.execute('''
                    INSERT INTO chat_history (user_id, message_type, content, metadata)
                    VALUES (?, ?, ?, ?)
                ''', (user_id, message_type, content, json.dumps(metadata or {})))
                conn.commit()
    
    def save_game_state(self, game_state, analysis_result=None):
        """Save game state and analysis"""
        with self.lock:
            with self.get_connection() as conn:
                cursor = conn.cursor()
                cursor.execute('''
                    INSERT INTO game_states (game_state, analysis_result)
                    VALUES (?, ?)
                ''', (json.dumps(game_state), json.dumps(analysis_result or {})))
                conn.commit()
    
    def save_training_data(self, data_type, content, labels=None, metadata=None):
        """Save training data"""
        with self.lock:
            with self.get_connection() as conn:
                cursor = conn.cursor()
                cursor.execute('''
                    INSERT INTO training_data (data_type, content, labels, metadata)
                    VALUES (?, ?, ?, ?)
                ''', (data_type, content, json.dumps(labels or {}), json.dumps(metadata or {})))
                conn.commit()
    
    def update_model_state(self, model_name, model_version, parameters, metrics):
        """Update model state and performance metrics"""
        with self.lock:
            with self.get_connection() as conn:
                cursor = conn.cursor()
                cursor.execute('''
                    INSERT INTO model_states 
                    (model_name, model_version, model_parameters, performance_metrics)
                    VALUES (?, ?, ?, ?)
                ''', (model_name, model_version, json.dumps(parameters), json.dumps(metrics)))
                conn.commit()
    
    def get_chat_history(self, user_id, limit=100):
        """Get chat history for user"""
        with self.get_connection() as conn:
            cursor = conn.cursor()
            cursor.execute('''
                SELECT timestamp, message_type, content, metadata
                FROM chat_history
                WHERE user_id = ?
                ORDER BY timestamp DESC
                LIMIT ?
            ''', (user_id, limit))
            return cursor.fetchall()
    
    def get_recent_game_states(self, limit=10):
        """Get recent game states"""
        with self.get_connection() as conn:
            cursor = conn.cursor()
            cursor.execute('''
                SELECT timestamp, game_state, analysis_result
                FROM game_states
                ORDER BY timestamp DESC
                LIMIT ?
            ''', (limit,))
            return cursor.fetchall()
    
    def get_training_data(self, data_type, limit=1000):
        """Get training data by type"""
        with self.get_connection() as conn:
            cursor = conn.cursor()
            cursor.execute('''
                SELECT content, labels, metadata
                FROM training_data
                WHERE data_type = ?
                ORDER BY timestamp DESC
                LIMIT ?
            ''', (data_type, limit))
            return cursor.fetchall()
    
    def get_model_performance(self, model_name):
        """Get model performance history"""
        with self.get_connection() as conn:
            cursor = conn.cursor()
            cursor.execute('''
                SELECT timestamp, model_version, performance_metrics
                FROM model_states
                WHERE model_name = ?
                ORDER BY timestamp DESC
            ''', (model_name,))
            return cursor.fetchall()
    
    def cleanup_old_data(self, days_to_keep=30):
        """Clean up old data"""
        with self.lock:
            with self.get_connection() as conn:
                cursor = conn.cursor()
                cutoff_date = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
                
                for table in ['chat_history', 'game_states', 'training_data']:
                    cursor.execute(f'''
                        DELETE FROM {table}
                        WHERE timestamp < datetime('now', '-{days_to_keep} days')
                    ''')
                
                conn.commit()
