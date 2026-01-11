import yaml
import json
import os

class ConfigManager:
    def __init__(self, config_path="config.yaml"):
        self.config_path = config_path
        self.config = self.load_config()
        
        # Game-specific settings
        self.game_settings = {
            "screen_regions": {
                "health_bar": {"x1": 50, "y1": 50, "x2": 200, "y2": 70},
                "minimap": {"x1": 800, "y1": 50, "x2": 950, "y2": 200},
                "inventory": {"x1": 600, "y1": 400, "x2": 800, "y2": 600}
            },
            "model_settings": {
                "vision_confidence": 0.7,
                "speech_threshold": 0.6,
                "analysis_fps": 30
            },
            "ui_elements": {
                "health_color": [0, 100, 100],
                "mana_color": [120, 100, 100],
                "stamina_color": [60, 100, 100]
            }
        }
        
        # OCR settings
        self.ocr_settings = {
            "language": "eng",
            "config": "--oem 3 --psm 6",
            "whitelist": "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        }
        
        # Audio settings
        self.audio_settings = {
            "sample_rate": 44100,
            "channels": 1,
            "chunk_size": 1024,
            "format": "float32"
        }
    
    def load_config(self):
        """Load configuration from file"""
        if os.path.exists(self.config_path):
            with open(self.config_path, 'r') as f:
                return yaml.safe_load(f)
        return self.create_default_config()
    
    def create_default_config(self):
        """Create and save default configuration"""
        default_config = {
            "game_settings": self.game_settings,
            "ocr_settings": self.ocr_settings,
            "audio_settings": self.audio_settings,
            "paths": {
                "models": "./models",
                "logs": "./logs",
                "temp": "./temp"
            }
        }
        
        # Create directories
        for path in default_config["paths"].values():
            os.makedirs(path, exist_ok=True)
        
        # Save default config
        with open(self.config_path, 'w') as f:
            yaml.dump(default_config, f)
        
        return default_config
    
    def update_game_regions(self, new_regions):
        """Update screen region coordinates"""
        self.game_settings["screen_regions"].update(new_regions)
        self.save_config()
    
    def update_model_settings(self, new_settings):
        """Update AI model settings"""
        self.game_settings["model_settings"].update(new_settings)
        self.save_config()
    
    def save_config(self):
        """Save current configuration to file"""
        with open(self.config_path, 'w') as f:
            yaml.dump(self.config, f)
    
    def get_screen_region(self, region_name):
        """Get coordinates for a specific screen region"""
        return self.game_settings["screen_regions"].get(region_name)
    
    def get_model_setting(self, setting_name):
        """Get specific model setting"""
        return self.game_settings["model_settings"].get(setting_name)
    
    def get_ocr_config(self):
        """Get OCR configuration"""
        return self.ocr_settings
    
    def get_audio_config(self):
        """Get audio configuration"""
        return self.audio_settings

# Example usage
if __name__ == "__main__":
    config = ConfigManager()
    
    # Update screen regions if needed
    new_regions = {
        "health_bar": {"x1": 60, "y1": 60, "x2": 210, "y2": 80}
    }
    config.update_game_regions(new_regions)
    
    # Get configuration
    print("Health bar region:", config.get_screen_region("health_bar"))
    print("Vision confidence threshold:", config.get_model_setting("vision_confidence"))
