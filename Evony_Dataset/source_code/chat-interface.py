import tkinter as tk
from tkinter import ttk, scrolledtext
import customtkinter as ctk
import threading
import queue
import json
import os
import pyaudio
import wave
import datetime
from PIL import Image, ImageTk
import win32com.client
import win32gui
import win32con
import sounddevice as sd
import soundfile as sf
import numpy as np

class ChatInterface:
    def __init__(self, root):
        self.root = root
        self.root.title("AI Assistant Chat Interface")
        
        # Set up message queue
        self.message_queue = queue.Queue()
        self.voice_queue = queue.Queue()
        
        # Set up Windows 11 audio
        self.setup_windows_audio()
        
        # Chat history
        self.chat_history = []
        
        # Create main container
        self.main_container = ctk.CTkFrame(self.root)
        self.main_container.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)
        
        # Create chat display
        self.create_chat_display()
        
        # Create input area
        self.create_input_area()
        
        # Create control buttons
        self.create_control_buttons()
        
        # Start message processing thread
        self.running = True
        self.message_thread = threading.Thread(target=self._process_messages)
        self.message_thread.start()
        
        # File handling
        self.upload_folder = "uploads"
        self.download_folder = "downloads"
        os.makedirs(self.upload_folder, exist_ok=True)
        os.makedirs(self.download_folder, exist_ok=True)

    def setup_windows_audio(self):
        """Setup Windows 11 audio system"""
        self.speaker = win32com.client.Dispatch("SAPI.SpVoice")
        self.recognizer = win32com.client.Dispatch("SAPI.SpSharedRecognizer")
        
    def create_chat_display(self):
        """Create the chat display area"""
        self.chat_frame = ctk.CTkFrame(self.main_container)
        self.chat_frame.pack(fill=tk.BOTH, expand=True, pady=(0, 10))
        
        self.chat_display = scrolledtext.ScrolledText(
            self.chat_frame,
            wrap=tk.WORD,
            width=50,
            height=20,
            font=("Arial", 10)
        )
        self.chat_display.pack(fill=tk.BOTH, expand=True)
        self.chat_display.config(state=tk.DISABLED)
        
    def create_input_area(self):
        """Create the input area"""
        self.input_frame = ctk.CTkFrame(self.main_container)
        self.input_frame.pack(fill=tk.X, pady=(0, 10))
        
        self.message_input = ctk.CTkTextbox(
            self.input_frame,
            height=60,
            font=("Arial", 10)
        )
        self.message_input.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        
        # Bind Enter key to send message
        self.message_input.bind("<Return>", self.send_message)
        
    def create_control_buttons(self):
        """Create control buttons"""
        self.button_frame = ctk.CTkFrame(self.main_container)
        self.button_frame.pack(fill=tk.X)
        
        # Send button
        self.send_button = ctk.CTkButton(
            self.button_frame,
            text="Send",
            command=lambda: self.send_message(None)
        )
        self.send_button.pack(side=tk.LEFT, padx=5)
        
        # Mic button
        self.mic_button = ctk.CTkButton(
            self.button_frame,
            text="🎤",
            width=40,
            command=self.toggle_mic
        )
        self.mic_button.pack(side=tk.LEFT, padx=5)
        
        # Upload button
        self.upload_button = ctk.CTkButton(
            self.button_frame,
            text="📎",
            width=40,
            command=self.upload_file
        )
        self.upload_button.pack(side=tk.LEFT, padx=5)
        
        # Copy button
        self.copy_button = ctk.CTkButton(
            self.button_frame,
            text="📋",
            width=40,
            command=self.copy_chat
        )
        self.copy_button.pack(side=tk.LEFT, padx=5)
        
    def send_message(self, event):
        """Send a message"""
        message = self.message_input.get("1.0", tk.END).strip()
        if message:
            self.message_queue.put({
                'type': 'user',
                'content': message,
                'timestamp': datetime.datetime.now().isoformat()
            })
            self.message_input.delete("1.0", tk.END)
            
    def toggle_mic(self):
        """Toggle microphone recording"""
        if not hasattr(self, 'recording'):
            self.recording = False
            
        if not self.recording:
            self.start_recording()
        else:
            self.stop_recording()
            
    def start_recording(self):
        """Start voice recording"""
        self.recording = True
        self.mic_button.configure(fg_color="red")
        
        # Start recording thread
        self.record_thread = threading.Thread(target=self._record_audio)
        self.record_thread.start()
        
    def stop_recording(self):
        """Stop voice recording"""
        self.recording = False
        self.mic_button.configure(fg_color=None)
        
    def _record_audio(self):
        """Record audio using Windows 11 audio system"""
        try:
            # Set up audio stream
            sample_rate = 44100
            channels = 1
            
            stream = sd.InputStream(
                samplerate=sample_rate,
                channels=channels,
                callback=self._audio_callback
            )
            
            with stream:
                while self.recording:
                    sd.sleep(100)
                    
        except Exception as e:
            print(f"Error recording audio: {e}")
            
    def _audio_callback(self, indata, frames, time, status):
        """Handle audio data"""
        if status:
            print(status)
        self.voice_queue.put(indata.copy())
        
    def upload_file(self):
        """Handle file upload"""
        from tkinter import filedialog
        
        filetypes = (
            ('All files', '*.*'),
            ('Images', '*.png *.jpg *.jpeg *.gif'),
            ('Text files', '*.txt'),
            ('Python files', '*.py')
        )
        
        filename = filedialog.askopenfilename(
            title='Upload a file',
            filetypes=filetypes
        )
        
        if filename:
            # Copy file to uploads folder
            import shutil
            dest = os.path.join(self.upload_folder, os.path.basename(filename))
            shutil.copy2(filename, dest)
            
            # Add message about upload
            self.message_queue.put({
                'type': 'system',
                'content': f'File uploaded: {os.path.basename(filename)}',
                'timestamp': datetime.datetime.now().isoformat()
            })
            
    def copy_chat(self):
        """Copy chat history to clipboard"""
        chat_text = ""
        for msg in self.chat_history:
            prefix = "User: " if msg['type'] == 'user' else "AI: "
            chat_text += f"{prefix}{msg['content']}\n"
            
        self.root.clipboard_clear()
        self.root.clipboard_append(chat_text)
        
    def _process_messages(self):
        """Process messages in queue"""
        while self.running:
            try:
                message = self.message_queue.get(timeout=0.1)
                self.chat_history.append(message)
                
                # Update chat display
                self.chat_display.config(state=tk.NORMAL)
                prefix = "You: " if message['type'] == 'user' else "AI: "
                self.chat_display.insert(tk.END, f"{prefix}{message['content']}\n\n")
                self.chat_display.config(state=tk.DISABLED)
                self.chat_display.see(tk.END)
                
            except queue.Empty:
                continue
                
    def save_chat_history(self):
        """Save chat history to file"""
        filename = f"chat_history_{datetime.datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
        filepath = os.path.join(self.download_folder, filename)
        
        with open(filepath, 'w') as f:
            json.dump(self.chat_history, f, indent=2)
            
    def cleanup(self):
        """Cleanup resources"""
        self.running = False
        self.save_chat_history()
        
def main():
    root = ctk.CTk()
    app = ChatInterface(root)
    
    def on_closing():
        app.cleanup()
        root.destroy()
        
    root.protocol("WM_DELETE_WINDOW", on_closing)
    root.mainloop()

if __name__ == "__main__":
    main()