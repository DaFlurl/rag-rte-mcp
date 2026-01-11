import logging
import datetime
import os
import json
from pathlib import Path

class GameLogger:
    def __init__(self, log_dir="./logs"):
        self.log_dir = Path(log_dir)
        self.log_dir.mkdir(parents=True, exist_ok=True)
        
        # Create timestamp for this session
        self.timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
        
        # Set up file handlers
        self.setup_logging()
        
        # Initialize game state history
        self.state_history = []
        
    def setup_logging(self):
        """Set up logging configuration"""
        # Main log file
        log_file = self.log_dir / f"game_log_{self.timestamp}.log"
        
        # Configure logging
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
            handlers=[
                logging.FileHandler(log_file),
                logging.StreamHandler()
            ]
        )
        
        self.logger = logging.getLogger("GameAssistant")
        
    def log_game_state(self, state):
        """Log game state"""
        self.state_history.append({
            'timestamp': datetime.datetime.now().isoformat(),
            'state': state
        })
        
        self.logger.info(f"Game State Updated: Health={state.get('health', 'N/A')}")
        
    def log_action(self, action, result=None):
        """Log game action"""
        self.logger.info(f"Action: {action}, Result: {result}")
        
    def log_error(self, error, context=None):
        """Log error with context"""
        self.logger.error(f"Error: {error}, Context: {context}")
        
    def log_analysis(self, analysis_data):
        """Log analysis results"""
        self.logger.info(f"Analysis: {analysis_data}")
        
    def save_session_data(self):
        """Save complete session data"""
        session_file = self.log_dir / f"session_{self.timestamp}.json"
        
        session_data = {
            'timestamp': self.timestamp,
            'state_history': self.state_history
        }
        
        with open(session_file, 'w') as f:
            json.dump(session_data, f, indent=2)
            
    def log_model_prediction(self, prediction, confidence):
        """Log model predictions"""
        self.logger.info(f"Model Prediction: {prediction}, Confidence: {confidence}")
        
    def log_voice_command(self, command):
        """Log voice commands"""
        self.logger.info(f"Voice Command Received: {command}")
        
    def log_system_status(self, status):
        """Log system status updates"""
        self.logger.info(f"System Status: {status}")
        
    def cleanup(self):
        """Cleanup and save session data"""
        self.save_session_data()
        
        # Remove old log files if needed
        self.cleanup_old_logs()
        
    def cleanup_old_logs(self, max_age_days=7):
        """Remove log files older than max_age_days"""
        current_time = datetime.datetime.now()
        
        for log_file in self.log_dir.glob("*.log"):
            file_time = datetime.datetime.fromtimestamp(log_file.stat().st_mtime)
            if (current_time - file_time).days > max_age_days:
                log_file.unlink()

# Example usage
if __name__ == "__main__":
    logger = GameLogger()
    
    # Log some example data
    logger.log_game_state({"health": 100, "position": (100, 200)})
    logger.log_action("attack", "success")
    logger.log_voice_command("status check")
    
    # Cleanup at end of session
    logger.cleanup()