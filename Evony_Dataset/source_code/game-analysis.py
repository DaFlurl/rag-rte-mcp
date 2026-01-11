import cv2
import numpy as np
import pytesseract
from PIL import Image
import torch
import time
from transformers import DetrImageProcessor, DetrForObjectDetection

class GameAnalyzer:
    def __init__(self):
        # Initialize OCR
        self.tesseract_config = r'--oem 3 --psm 6'
        
        # Initialize object detection
        self.processor = DetrImageProcessor.from_pretrained("facebook/detr-resnet-50")
        self.model = DetrForObjectDetection.from_pretrained("facebook/detr-resnet-50")
        
        # Game state tracking
        self.current_state = {
            'health': 100,
            'position': None,
            'enemies': [],
            'resources': {},
            'current_objective': None
        }
        
        # Define regions of interest for UI elements
        self.roi_regions = {
            'health_bar': (50, 50, 200, 70),
            'minimap': (800, 50, 950, 200),
            'inventory': (600, 400, 800, 600)
        }
        
    def analyze_frame(self, frame):
        """Analyze a single frame of gameplay"""
        # Update game state based on frame analysis
        self._update_health(frame)
        self._detect_objects(frame)
        self._read_ui_text(frame)
        return self.current_state
    
    def _update_health(self, frame):
        """Extract health information from health bar"""
        health_roi = frame[
            self.roi_regions['health_bar'][1]:self.roi_regions['health_bar'][3],
            self.roi_regions['health_bar'][0]:self.roi_regions['health_bar'][2]
        ]
        
        # Convert to HSV for better color detection
        hsv = cv2.cvtColor(health_roi, cv2.COLOR_BGR2HSV)
        
        # Detect red color (health bar)
        lower_red = np.array([0, 100, 100])
        upper_red = np.array([10, 255, 255])
        mask = cv2.inRange(hsv, lower_red, upper_red)
        
        # Calculate health percentage
        health_percentage = (np.sum(mask > 0) / mask.size) * 100
        self.current_state['health'] = health_percentage
    
    def _detect_objects(self, frame):
        """Detect important objects in the frame"""
        # Prepare image for DETR
        inputs = self.processor(images=frame, return_tensors="pt")
        outputs = self.model(**inputs)
        
        # Convert outputs to detections
        target_sizes = torch.tensor([frame.shape[:2]])
        results = self.processor.post_process_object_detection(
            outputs, target_sizes=target_sizes, threshold=0.7
        )[0]
        
        # Clear previous detections
        self.current_state['enemies'] = []
        
        # Process detections
        for score, label, box in zip(
            results["scores"], results["labels"], results["boxes"]
        ):
            box = [round(i, 2) for i in box.tolist()]
            # Add detected objects to game state
            if score > 0.7:  # Confidence threshold
                self.current_state['enemies'].append({
                    'position': box,
                    'confidence': round(score.item(), 3)
                })
    
    def _read_ui_text(self, frame):
        """Extract text from UI elements"""
        # Process each ROI region
        for region_name, coords in self.roi_regions.items():
            roi = frame[coords[1]:coords[3], coords[0]:coords[2]]
            
            # Prepare image for OCR
            gray = cv2.cvtColor(roi, cv2.COLOR_BGR2GRAY)
            thresh = cv2.threshold(gray, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)[1]
            
            # Extract text
            text = pytesseract.image_to_string(thresh, config=self.tesseract_config)
            
            # Update game state based on extracted text
            if region_name == 'inventory':
                self.current_state['resources'] = self._parse_inventory_text(text)
    
    def _parse_inventory_text(self, text):
        """Parse inventory text into structured data"""
        resources = {}
        lines = text.split('\n')
        for line in lines:
            if ':' in line:
                item, amount = line.split(':')
                try:
                    resources[item.strip()] = int(amount.strip())
                except ValueError:
                    continue
        return resources
    
    def get_game_state(self):
        """Return current game state"""
        return self.current_state
    
    def suggest_action(self):
        """Generate action suggestions based on current game state"""
        suggestions = []
        
        # Health-based suggestions
        if self.current_state['health'] < 30:
            suggestions.append("Health is low - consider retreating or using healing items")
        
        # Enemy-based suggestions
        if len(self.current_state['enemies']) > 2:
            suggestions.append("Multiple enemies detected - defensive positioning recommended")
        
        return suggestions

def main():
    # Initialize screen capture (from previous example)
    from screen_capture import ScreenCapture
    
    capturer = ScreenCapture(fps=30)
    analyzer = GameAnalyzer()
    
    capturer.start_capture()
    
    try:
        while True:
            frame = capturer.get_frame()
            if frame is not None:
                # Analyze frame
                game_state = analyzer.analyze_frame(frame)
                suggestions = analyzer.suggest_action()
                
                # Print analysis results
                print("Game State:", game_state)
                print("Suggestions:", suggestions)
                
                # Display frame with annotations
                cv2.imshow('Game Analysis', frame)
                
                if cv2.waitKey(1) & 0xFF == ord('q'):
                    break
    finally:
        capturer.stop_capture()
        cv2.destroyAllWindows()

if __name__ == "__main__":
    main()