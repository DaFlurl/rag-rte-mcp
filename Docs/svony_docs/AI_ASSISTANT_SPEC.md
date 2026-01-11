# SVONY STUDIO - AI ASSISTANT TAB SPECIFICATION
## Windsurf-Style AI Integration with Local Models

**Version:** 1.0  
**Date:** January 2, 2026  

---

## 🎯 OVERVIEW

The AI Assistant Tab provides an integrated development environment similar to Windsurf/Cursor IDE, but designed specifically for Evony reverse engineering tasks. Uses local Qwen models via LM Studio or Ollama for privacy and unlimited token usage.

---

## 🏗️ ARCHITECTURE

```
┌─────────────────────────────────────────────────────────────────┐
│                     AI ASSISTANT TAB                            │
├─────────────────────────────────────────────────────────────────┤
│ ┌──────────────────────┐  ┌──────────────────────────────────┐ │
│ │   CHAT PANEL         │  │   CODE PANEL                     │ │
│ │                      │  │                                  │ │
│ │ [User Message]       │  │   ┌─────────────────────────┐    │ │
│ │ [AI Response]        │  │   │ // Generated Code       │    │ │
│ │ [User Message]       │  │   │ function login() {      │    │ │
│ │                      │  │   │   // ...                │    │ │
│ │ ┌──────────────────┐ │  │   └─────────────────────────┘    │ │
│ │ │ Type message...  │ │  │                                  │ │
│ │ └──────────────────┘ │  │   [Apply] [Copy] [Save]          │ │
│ └──────────────────────┘  └──────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────┤
│ [Model: Qwen2.5-Coder-32B ▼] [Context: 32K] [GPU: 12GB] [⚙️]   │
└─────────────────────────────────────────────────────────────────┘
```

---

## 📋 FEATURES

### 1. Chat Panel
- Markdown rendering for AI responses
- Code block syntax highlighting
- Copy/Apply buttons on code blocks
- Message history with search
- Context-aware suggestions

### 2. Code Panel (Resizable/Detachable)
- Full syntax highlighting (AS3, Python, JSON)
- Line numbers
- Search/Replace
- Diff view for changes
- Apply to current file
- Can pop out as separate window

### 3. Model Configuration
- LM Studio integration (HTTP API)
- Ollama integration
- Model selection dropdown
- Temperature/Top-P controls
- Context length adjustment
- GPU memory monitoring

### 4. Agentic Capabilities
- Autonomous task execution
- Multi-step workflows
- Tool calling (search, edit, run)
- NO auto-continue (user controlled)
- Unlimited local tokens

---

## 🛠️ IMPLEMENTATION

### File: src/ui/panels/ai_assistant_panel.py

```python
"""
AI Assistant Panel - Windsurf-style AI integration
Supports local models via LM Studio and Ollama
"""

import customtkinter as ctk
import tkinter as tk
from tkinter import ttk
import threading
import json
import requests
from typing import Optional, List, Dict, Callable
from dataclasses import dataclass
from datetime import datetime


@dataclass
class ChatMessage:
    role: str  # "user", "assistant", "system"
    content: str
    timestamp: datetime
    code_blocks: List[Dict] = None


class AIAssistantPanel(ctk.CTkFrame):
    """AI Assistant with chat and code generation"""
    
    # Supported model providers
    PROVIDERS = {
        "lmstudio": {
            "name": "LM Studio",
            "base_url": "http://localhost:1234/v1",
            "models_endpoint": "/models",
            "chat_endpoint": "/chat/completions"
        },
        "ollama": {
            "name": "Ollama",
            "base_url": "http://localhost:11434",
            "models_endpoint": "/api/tags",
            "chat_endpoint": "/api/chat"
        }
    }
    
    # Recommended models for Evony RE
    RECOMMENDED_MODELS = [
        "qwen2.5-coder:32b",
        "qwen2.5:32b",
        "deepseek-coder-v2:16b",
        "codellama:34b",
        "mistral:7b-instruct"
    ]
    
    def __init__(self, parent, colors: Dict, **kwargs):
        super().__init__(parent, fg_color=colors["bg_dark"], **kwargs)
        
        self.colors = colors
        self.messages: List[ChatMessage] = []
        self.current_provider = "lmstudio"
        self.current_model = None
        self.is_generating = False
        
        # System prompt for Evony RE
        self.system_prompt = """You are an expert reverse engineer specializing in:
- Flash/SWF decompilation and ActionScript 3
- AMF protocol analysis and modification
- Game client patching and modification
- Python scripting for automation
- Network protocol analysis

You are integrated into Svony Studio, a tool for Evony Age II reverse engineering.
You have access to:
- Decompiled ActionScript code
- AMF message captures
- SOL (SharedObject) data
- Game protocol documentation

Provide detailed, actionable code and explanations. When generating code,
use proper ActionScript 3 or Python syntax with full implementations."""
        
        self._build_ui()
        self._load_models()
    
    def _build_ui(self):
        """Build the AI Assistant interface"""
        # Main container with horizontal split
        self.paned = ttk.PanedWindow(self, orient="horizontal")
        self.paned.pack(fill="both", expand=True)
        
        # Left: Chat Panel
        self.chat_frame = ctk.CTkFrame(self.paned, fg_color=self.colors["bg_medium"])
        self.paned.add(self.chat_frame, weight=1)
        
        # Chat header
        chat_header = ctk.CTkFrame(self.chat_frame, fg_color=self.colors["bg_dark"])
        chat_header.pack(fill="x", padx=5, pady=5)
        
        ctk.CTkLabel(chat_header, text="💬 AI CHAT",
                     font=ctk.CTkFont(size=14, weight="bold"),
                     text_color=self.colors["accent_green"]).pack(side="left", padx=10)
        
        ctk.CTkButton(chat_header, text="Clear", width=60,
                      fg_color=self.colors["bg_light"],
                      command=self._clear_chat).pack(side="right", padx=5)
        
        # Chat messages area
        self.chat_container = ctk.CTkScrollableFrame(
            self.chat_frame, 
            fg_color=self.colors["bg_light"]
        )
        self.chat_container.pack(fill="both", expand=True, padx=5, pady=5)
        
        # Input area
        input_frame = ctk.CTkFrame(self.chat_frame, fg_color=self.colors["bg_dark"])
        input_frame.pack(fill="x", padx=5, pady=5)
        
        self.input_text = ctk.CTkTextbox(input_frame, height=80,
                                          fg_color=self.colors["bg_light"])
        self.input_text.pack(fill="x", padx=5, pady=5)
        self.input_text.bind("<Shift-Return>", self._on_shift_enter)
        self.input_text.bind("<Return>", self._on_enter)
        
        btn_frame = ctk.CTkFrame(input_frame, fg_color="transparent")
        btn_frame.pack(fill="x", padx=5, pady=5)
        
        self.send_btn = ctk.CTkButton(btn_frame, text="Send", width=80,
                                       fg_color=self.colors["accent_green"],
                                       command=self._send_message)
        self.send_btn.pack(side="right", padx=5)
        
        self.stop_btn = ctk.CTkButton(btn_frame, text="Stop", width=60,
                                       fg_color=self.colors["error"],
                                       command=self._stop_generation,
                                       state="disabled")
        self.stop_btn.pack(side="right", padx=5)
        
        # Right: Code Panel
        self.code_frame = ctk.CTkFrame(self.paned, fg_color=self.colors["bg_medium"])
        self.paned.add(self.code_frame, weight=1)
        
        # Code header
        code_header = ctk.CTkFrame(self.code_frame, fg_color=self.colors["bg_dark"])
        code_header.pack(fill="x", padx=5, pady=5)
        
        ctk.CTkLabel(code_header, text="📝 CODE",
                     font=ctk.CTkFont(size=14, weight="bold"),
                     text_color=self.colors["accent_green"]).pack(side="left", padx=10)
        
        ctk.CTkButton(code_header, text="📋", width=30,
                      fg_color=self.colors["bg_light"],
                      command=self._copy_code).pack(side="right", padx=2)
        
        ctk.CTkButton(code_header, text="💾", width=30,
                      fg_color=self.colors["bg_light"],
                      command=self._save_code).pack(side="right", padx=2)
        
        ctk.CTkButton(code_header, text="🔧", width=30,
                      fg_color=self.colors["bg_light"],
                      command=self._apply_code).pack(side="right", padx=2)
        
        ctk.CTkButton(code_header, text="⇱", width=30,
                      fg_color=self.colors["bg_light"],
                      command=self._detach_code_panel).pack(side="right", padx=2)
        
        # Code editor
        self.code_editor = ctk.CTkTextbox(self.code_frame,
                                           fg_color=self.colors["bg_light"],
                                           font=ctk.CTkFont(family="Consolas", size=12))
        self.code_editor.pack(fill="both", expand=True, padx=5, pady=5)
        
        # Bottom: Model settings
        self._build_settings_bar()
    
    def _build_settings_bar(self):
        """Build model settings bar"""
        settings_bar = ctk.CTkFrame(self, fg_color=self.colors["bg_medium"], height=40)
        settings_bar.pack(fill="x", padx=5, pady=5)
        settings_bar.pack_propagate(False)
        
        # Provider selection
        ctk.CTkLabel(settings_bar, text="Provider:",
                     text_color=self.colors["text_secondary"]).pack(side="left", padx=5)
        
        self.provider_var = ctk.StringVar(value="lmstudio")
        provider_menu = ctk.CTkOptionMenu(settings_bar, variable=self.provider_var,
                                          values=["lmstudio", "ollama"],
                                          width=100, command=self._on_provider_change)
        provider_menu.pack(side="left", padx=5)
        
        # Model selection
        ctk.CTkLabel(settings_bar, text="Model:",
                     text_color=self.colors["text_secondary"]).pack(side="left", padx=5)
        
        self.model_var = ctk.StringVar(value="Select model...")
        self.model_menu = ctk.CTkOptionMenu(settings_bar, variable=self.model_var,
                                             values=["Loading..."], width=200,
                                             command=self._on_model_change)
        self.model_menu.pack(side="left", padx=5)
        
        # Context length
        ctk.CTkLabel(settings_bar, text="Context:",
                     text_color=self.colors["text_secondary"]).pack(side="left", padx=5)
        
        self.context_slider = ctk.CTkSlider(settings_bar, from_=4096, to=131072,
                                             width=100, number_of_steps=10)
        self.context_slider.set(32768)
        self.context_slider.pack(side="left", padx=5)
        
        self.context_label = ctk.CTkLabel(settings_bar, text="32K",
                                           text_color=self.colors["text_primary"])
        self.context_label.pack(side="left", padx=5)
        
        # GPU status
        self.gpu_label = ctk.CTkLabel(settings_bar, text="GPU: --",
                                       text_color=self.colors["text_secondary"])
        self.gpu_label.pack(side="right", padx=10)
        
        # Settings button
        ctk.CTkButton(settings_bar, text="⚙️", width=30,
                      fg_color=self.colors["bg_light"],
                      command=self._show_settings).pack(side="right", padx=5)
    
    def _load_models(self):
        """Load available models from provider"""
        def load():
            provider = self.PROVIDERS[self.current_provider]
            try:
                if self.current_provider == "lmstudio":
                    response = requests.get(f"{provider['base_url']}{provider['models_endpoint']}")
                    models = [m["id"] for m in response.json().get("data", [])]
                elif self.current_provider == "ollama":
                    response = requests.get(f"{provider['base_url']}{provider['models_endpoint']}")
                    models = [m["name"] for m in response.json().get("models", [])]
                else:
                    models = []
                
                if models:
                    self.model_menu.configure(values=models)
                    self.model_var.set(models[0])
                    self.current_model = models[0]
                else:
                    self.model_menu.configure(values=["No models found"])
                    
            except Exception as e:
                self.model_menu.configure(values=[f"Error: {str(e)[:20]}"])
        
        threading.Thread(target=load, daemon=True).start()
    
    def _send_message(self):
        """Send user message to AI"""
        message = self.input_text.get("1.0", "end-1c").strip()
        if not message or self.is_generating:
            return
        
        # Add user message
        self._add_message("user", message)
        self.input_text.delete("1.0", "end")
        
        # Start generation
        self.is_generating = True
        self.send_btn.configure(state="disabled")
        self.stop_btn.configure(state="normal")
        
        threading.Thread(target=self._generate_response, args=(message,), daemon=True).start()
    
    def _generate_response(self, user_message: str):
        """Generate AI response"""
        provider = self.PROVIDERS[self.current_provider]
        
        try:
            # Build messages
            messages = [{"role": "system", "content": self.system_prompt}]
            for msg in self.messages[-10:]:  # Last 10 messages for context
                messages.append({"role": msg.role, "content": msg.content})
            messages.append({"role": "user", "content": user_message})
            
            # Make API call
            if self.current_provider == "lmstudio":
                response = requests.post(
                    f"{provider['base_url']}{provider['chat_endpoint']}",
                    json={
                        "model": self.current_model,
                        "messages": messages,
                        "temperature": 0.7,
                        "max_tokens": 4096,
                        "stream": True
                    },
                    stream=True
                )
                
                full_response = ""
                for line in response.iter_lines():
                    if not self.is_generating:
                        break
                    if line:
                        try:
                            data = json.loads(line.decode().replace("data: ", ""))
                            chunk = data.get("choices", [{}])[0].get("delta", {}).get("content", "")
                            full_response += chunk
                            self._update_response(full_response)
                        except:
                            pass
                
                self._add_message("assistant", full_response)
                self._extract_code_blocks(full_response)
                
            elif self.current_provider == "ollama":
                response = requests.post(
                    f"{provider['base_url']}{provider['chat_endpoint']}",
                    json={
                        "model": self.current_model,
                        "messages": messages,
                        "stream": True
                    },
                    stream=True
                )
                
                full_response = ""
                for line in response.iter_lines():
                    if not self.is_generating:
                        break
                    if line:
                        try:
                            data = json.loads(line)
                            chunk = data.get("message", {}).get("content", "")
                            full_response += chunk
                            self._update_response(full_response)
                        except:
                            pass
                
                self._add_message("assistant", full_response)
                self._extract_code_blocks(full_response)
                
        except Exception as e:
            self._add_message("assistant", f"Error: {str(e)}")
        
        finally:
            self.is_generating = False
            self.send_btn.configure(state="normal")
            self.stop_btn.configure(state="disabled")
    
    def _add_message(self, role: str, content: str):
        """Add message to chat"""
        msg = ChatMessage(role=role, content=content, timestamp=datetime.now())
        self.messages.append(msg)
        
        # Create message widget
        frame = ctk.CTkFrame(self.chat_container, 
                             fg_color=self.colors["bg_medium"] if role == "user" else self.colors["bg_dark"])
        frame.pack(fill="x", padx=5, pady=5)
        
        label = "👤 You" if role == "user" else "🤖 AI"
        ctk.CTkLabel(frame, text=label,
                     font=ctk.CTkFont(weight="bold"),
                     text_color=self.colors["accent_green"]).pack(anchor="w", padx=10, pady=(5,0))
        
        text = ctk.CTkLabel(frame, text=content,
                            text_color=self.colors["text_primary"],
                            wraplength=400, justify="left")
        text.pack(anchor="w", padx=10, pady=5)
    
    def _extract_code_blocks(self, content: str):
        """Extract code blocks and show in code panel"""
        import re
        code_pattern = r"```(?:\w+)?\n(.*?)```"
        matches = re.findall(code_pattern, content, re.DOTALL)
        
        if matches:
            # Show latest code block
            self.code_editor.delete("1.0", "end")
            self.code_editor.insert("1.0", matches[-1])
    
    def _stop_generation(self):
        """Stop AI generation"""
        self.is_generating = False
    
    def _update_response(self, content: str):
        """Update response in real-time (streaming)"""
        # This would update a temporary response widget
        pass
    
    def _clear_chat(self):
        """Clear chat history"""
        self.messages.clear()
        for widget in self.chat_container.winfo_children():
            widget.destroy()
    
    def _copy_code(self):
        """Copy code to clipboard"""
        code = self.code_editor.get("1.0", "end-1c")
        self.clipboard_clear()
        self.clipboard_append(code)
    
    def _save_code(self):
        """Save code to file"""
        from tkinter import filedialog
        filepath = filedialog.asksaveasfilename(
            defaultextension=".py",
            filetypes=[("Python", "*.py"), ("ActionScript", "*.as"), ("All", "*.*")]
        )
        if filepath:
            with open(filepath, "w") as f:
                f.write(self.code_editor.get("1.0", "end-1c"))
    
    def _apply_code(self):
        """Apply code to current file"""
        # This would integrate with the script editor
        pass
    
    def _detach_code_panel(self):
        """Detach code panel to separate window"""
        code = self.code_editor.get("1.0", "end-1c")
        
        window = ctk.CTkToplevel(self)
        window.title("Code Editor - Detached")
        window.geometry("800x600")
        window.configure(fg_color=self.colors["bg_dark"])
        
        editor = ctk.CTkTextbox(window, fg_color=self.colors["bg_light"],
                                 font=ctk.CTkFont(family="Consolas", size=12))
        editor.pack(fill="both", expand=True, padx=10, pady=10)
        editor.insert("1.0", code)
    
    def _on_provider_change(self, value: str):
        """Handle provider change"""
        self.current_provider = value
        self._load_models()
    
    def _on_model_change(self, value: str):
        """Handle model change"""
        self.current_model = value
    
    def _on_enter(self, event):
        """Handle Enter key"""
        if not event.state & 1:  # No Shift
            self._send_message()
            return "break"
    
    def _on_shift_enter(self, event):
        """Handle Shift+Enter for newline"""
        return None  # Allow default behavior
    
    def _show_settings(self):
        """Show AI settings dialog"""
        # This would open a comprehensive settings dialog
        pass


# Export for use in main application
__all__ = ['AIAssistantPanel']
```

---

## 🔧 INTEGRATION WITH MAIN.PY

### Add to main.py imports:
```python
from src.ui.panels.ai_assistant_panel import AIAssistantPanel
```

### Create AI Tab in notebook:
```python
# In _create_main_layout() or similar:
ai_tab = ctk.CTkFrame(self.main_notebook)
self.main_notebook.add(ai_tab, text="🤖 AI Assistant")

self.ai_panel = AIAssistantPanel(ai_tab, colors=self.COLORS)
self.ai_panel.pack(fill="both", expand=True)
```

---

## 📦 REQUIREMENTS

Add to requirements.txt:
```
requests>=2.31.0
markdown>=3.5.0
pygments>=2.17.0
```

---

## 🚀 USAGE EXAMPLES

### 1. Analyze Decompiled Code
```
User: Analyze this ActionScript class and find the login function:
[paste code]

AI: [Analyzes and highlights login logic, suggests modifications]
```

### 2. Generate Patch
```
User: Create a Python script to patch the server URL in EvonyClient.swf

AI: [Generates complete patching script with FFDec integration]
```

### 3. Protocol Analysis
```
User: This AMF message was captured during login. What does it contain?
[paste AMF hex]

AI: [Decodes and explains the protocol structure]
```

---

**Document Version:** 1.0  
**Status:** SPECIFICATION - NOT YET IMPLEMENTED
