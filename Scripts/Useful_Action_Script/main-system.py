import threading
import queue
import time
from screen_capture import ScreenCapture
from audio_system import AudioSystem
from game_analysis import GameAnalyzer

class AIGameAssistant:
    def __init__(self):
        self.screen_capture = ScreenCapture(fps=30)
        self.audio_system = AudioSystem()
        self.game_analyzer = GameAnalyzer()
        
        self.command_queue = queue.Queue()
        self.running = False
        
        # State management
        self.current_state = {
            'game_state': None,
            'last_command': None,
            'last_analysis': None,
            'last_speech': None
        }
    
    def start(self):
        """Start all systems"""
        self.running = True
        
        # Start core systems
        self.screen_capture.start_capture()
        self.audio_system.start()
        
        # Start processing threads
        self.analysis_thread = threading.Thread(target=self._analysis_loop)
        self.command_thread = threading.Thread(target=self._command_loop)
        
        self.analysis_thread.start()
        self.command_thread.start()
    
    def stop(self):
        """Stop all systems"""
        self.running = False
        
        # Stop core systems
        self.screen_capture.stop_capture()
        self.audio_system.stop()
        
        # Wait for threads to finish
        self.analysis_thread.join()
        self.command_thread.join()
    
    def _analysis_loop(self):
        """Main analysis loop"""
        last_analysis_time = time.time()
        
        while self.running:
            current_time = time.time()
            
            # Analyze at most every 100ms
            if current_time - last_analysis_time < 0.1:
                time.sleep(0.01)
                continue
            
            frame = self.screen_capture.get_frame()
            if frame is not None:
                # Perform game state analysis
                game_state = self.game_analyzer.analyze_frame(frame)
                self.current_state['game_state'] = game_state
                
                # Generate suggestions
                suggestions = self.game_analyzer.suggest_action()
                
                # If important suggestions, add to command queue
                for suggestion in suggestions:
                    self.command_queue.put({
                        'type': 'suggestion',
                        'content': suggestion
                    })
                
                last_analysis_time = current_time
    
    def _command_loop(self):
        """Process and execute commands"""
        while self.running:
            try:
                command = self.command_queue.get(timeout=0.1)
            except queue.Empty:
                continue
            
            self._handle_command(command)
    
    def _handle_command(self, command):
        """Handle different types of commands"""
        command_type = command.get('type')
        content = command.get('content')
        
        if command_type == 'suggestion':
            # Speak suggestion through audio system
            self.audio_system.speak(content)
            self.current_state['last_speech'] = content
        
        elif command_type == 'speech_command':
            # Handle voice commands from user
            self._handle_speech_command(content)
    
    def _handle_speech_command(self, speech):
        """Handle voice commands from user"""
        speech = speech.lower()
        
        # Example command handling
        if "status" in speech:
            if self.current_state['game_state']:
                status = f"Health at {self.current_state['game_state']['health']}%. "
                if self.current_state['game_state']['enemies']:
                    status += f"