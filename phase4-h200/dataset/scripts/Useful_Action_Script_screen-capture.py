import cv2
import numpy as np
import pyautogui
import time
from PIL import ImageGrab
import threading
import queue

class ScreenCapture:
    def __init__(self, fps=30):
        self.fps = fps
        self.frame_time = 1/fps
        self.frame_queue = queue.Queue(maxsize=30)  # Buffer 30 frames max
        self.running = False
        
    def start_capture(self):
        self.running = True
        self.capture_thread = threading.Thread(target=self._capture_loop)
        self.capture_thread.start()
        
    def stop_capture(self):
        self.running = False
        if hasattr(self, 'capture_thread'):
            self.capture_thread.join()
            
    def _capture_loop(self):
        last_time = time.time()
        
        while self.running:
            # Capture screen
            screen = np.array(ImageGrab.grab())
            # Convert from BGR to RGB
            frame = cv2.cvtColor(screen, cv2.COLOR_BGR2RGB)
            
            # Try to add to queue, drop frame if queue is full
            try:
                self.frame_queue.put_nowait(frame)
            except queue.Full:
                _ = self.frame_queue.get()  # Remove oldest frame
                self.frame_queue.put(frame)  # Add new frame
                
            # Maintain consistent FPS
            current_time = time.time()
            sleep_time = self.frame_time - (current_time - last_time)
            if sleep_time > 0:
                time.sleep(sleep_time)
            last_time = time.time()
            
    def get_frame(self):
        """Get the most recent frame, returns None if no frames available"""
        try:
            return self.frame_queue.get_nowait()
        except queue.Empty:
            return None

def process_frame(frame):
    """Example frame processing function"""
    # Convert to grayscale for simpler processing
    gray = cv2.cvtColor(frame, cv2.COLOR_RGB2GRAY)
    
    # Basic edge detection
    edges = cv2.Canny(gray, 100, 200)
    
    # You can add more processing here
    # For example: object detection, text recognition, etc.
    
    return edges

def main():
    # Initialize screen capture
    capturer = ScreenCapture(fps=30)
    capturer.start_capture()
    
    try:
        while True:
            frame = capturer.get_frame()
            if frame is not None:
                # Process the frame
                processed = process_frame(frame)
                
                # Display the original and processed frames
                cv2.imshow('Original', cv2.cvtColor(frame, cv2.COLOR_RGB2BGR))
                cv2.imshow('Processed', processed)
                
                # Break loop on 'q' press
                if cv2.waitKey(1) & 0xFF == ord('q'):
                    break
    finally:
        capturer.stop_capture()
        cv2.destroyAllWindows()

if __name__ == "__main__":
    main()