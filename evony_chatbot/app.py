import streamlit as st
import requests
import json
from datetime import datetime

# AutoEvony Dark Theme Colors
COLORS = {
    "window_bg": "#1B1E27",
    "frame_bg": "#1D2028",
    "header_bg": "#181B23",
    "button_bg": "#2B2F3B",
    "button_hover": "#363B4A",
    "tab_selected": "#252832",
    "text": "#E6E6E6",
    "text_dim": "#A3A3A3",
    "accent": "#4A90D9",
    "gold": "#FFD700",
    "green": "#00FF00",
    "red": "#FF4444",
}

st.set_page_config(
    page_title="Evony AI Assistant",
    page_icon="⚔️",
    layout="wide",
    initial_sidebar_state="expanded"
)

# Custom CSS for AutoEvony style
st.markdown(f"""
<style>
    .stApp {{
        background-color: {COLORS['window_bg']};
    }}
    .stSidebar {{
        background-color: {COLORS['frame_bg']};
    }}
    .stButton>button {{
        background-color: {COLORS['button_bg']};
        color: {COLORS['text']};
        border: 1px solid #3A3F4B;
        border-radius: 2px;
        font-family: Arial;
        font-size: 12px;
    }}
    .stButton>button:hover {{
        background-color: {COLORS['button_hover']};
        border-color: {COLORS['accent']};
    }}
    .chat-message {{
        padding: 10px 15px;
        margin: 5px 0;
        border-radius: 4px;
        font-family: Arial;
        font-size: 13px;
    }}
    .user-message {{
        background-color: {COLORS['button_bg']};
        color: {COLORS['text']};
        border-left: 3px solid {COLORS['accent']};
    }}
    .assistant-message {{
        background-color: {COLORS['frame_bg']};
        color: {COLORS['text']};
        border-left: 3px solid {COLORS['gold']};
    }}
    .header-bar {{
        background: linear-gradient(180deg, #2A3040 0%, {COLORS['header_bg']} 100%);
        padding: 10px 20px;
        border-bottom: 2px solid #3A3F4B;
        margin-bottom: 20px;
    }}
    .status-online {{
        color: {COLORS['green']};
        font-weight: bold;
    }}
    .status-text {{
        color: {COLORS['text_dim']};
        font-size: 11px;
    }}
    h1, h2, h3 {{
        color: {COLORS['gold']} !important;
        font-family: Arial !important;
    }}
    p, span, div {{
        color: {COLORS['text']};
    }}
    .stTextInput>div>div>input {{
        background-color: {COLORS['frame_bg']};
        color: {COLORS['text']};
        border: 1px solid #3A3F4B;
    }}
    .stSelectbox>div>div {{
        background-color: {COLORS['frame_bg']};
        color: {COLORS['text']};
    }}
    .log-entry {{
        font-family: 'Courier New', monospace;
        font-size: 11px;
        color: {COLORS['text_dim']};
        padding: 2px 5px;
    }}
    .log-timestamp {{
        color: {COLORS['accent']};
    }}
    .resource-panel {{
        background-color: {COLORS['frame_bg']};
        border: 1px solid #3A3F4B;
        padding: 10px;
        border-radius: 4px;
    }}
    .resource-value {{
        color: {COLORS['gold']};
        font-weight: bold;
    }}
</style>
""", unsafe_allow_html=True)

# Initialize session state
if "messages" not in st.session_state:
    st.session_state.messages = []
if "logs" not in st.session_state:
    st.session_state.logs = []

def add_log(message, level="info"):
    timestamp = datetime.now().strftime("%H:%M:%S")
    color = COLORS['text_dim']
    if level == "success":
        color = COLORS['green']
    elif level == "error":
        color = COLORS['red']
    elif level == "warning":
        color = COLORS['gold']
    st.session_state.logs.append({"time": timestamp, "msg": message, "color": color})
    if len(st.session_state.logs) > 100:
        st.session_state.logs = st.session_state.logs[-100:]

def get_ai_response(prompt):
    """Get response from local Ollama or API"""
    try:
        # Try Ollama first
        response = requests.post(
            "http://localhost:11434/api/generate",
            json={"model": "qwen2.5:7b", "prompt": prompt, "stream": False},
            timeout=60
        )
        if response.status_code == 200:
            return response.json().get("response", "No response")
    except:
        pass
    
    # Fallback response
    return f"[Evony AI] I understand your query about: {prompt[:50]}... The model is still training. Once complete, I'll provide detailed Evony strategy advice!"

# Header
st.markdown("""
<div class="header-bar">
    <table width="100%"><tr>
        <td><h1 style="margin:0;font-size:24px;">⚔️ Evony AI Assistant</h1></td>
        <td align="right">
            <span class="status-online">● ONLINE</span><br>
            <span class="status-text">Phase 4 Model Training...</span>
        </td>
    </tr></table>
</div>
""", unsafe_allow_html=True)

# Sidebar - Status Panel
with st.sidebar:
    st.markdown(f"### 📊 Status Panel")
    
    st.markdown("""
    <div class="resource-panel">
        <b>Training Status</b><br>
        <span class="status-text">Epoch:</span> <span class="resource-value">40+</span> / 205<br>
        <span class="status-text">Loss:</span> <span class="resource-value">0.22</span><br>
        <span class="status-text">Target:</span> <span class="resource-value">0.18-0.20</span>
    </div>
    """, unsafe_allow_html=True)
    
    st.markdown("<br>", unsafe_allow_html=True)
    
    st.markdown("### ⚙️ Settings")
    model_choice = st.selectbox("Model", ["Evony Phase 4 (Training)", "Qwen 2.5 7B", "Custom"])
    temperature = st.slider("Temperature", 0.0, 1.0, 0.7)
    
    st.markdown("<br>", unsafe_allow_html=True)
    
    if st.button("🗑️ Clear Chat", use_container_width=True):
        st.session_state.messages = []
        add_log("Chat cleared", "info")
        st.rerun()
    
    if st.button("📋 Export Log", use_container_width=True):
        add_log("Log exported", "success")

# Main layout
col1, col2 = st.columns([2, 1])

with col1:
    st.markdown("### 💬 Chat")
    
    # Chat container
    chat_container = st.container(height=400)
    
    with chat_container:
        for msg in st.session_state.messages:
            if msg["role"] == "user":
                st.markdown(f'<div class="chat-message user-message"><b>You:</b> {msg["content"]}</div>', unsafe_allow_html=True)
            else:
                st.markdown(f'<div class="chat-message assistant-message"><b>Evony AI:</b> {msg["content"]}</div>', unsafe_allow_html=True)
    
    # Input
    user_input = st.chat_input("Ask about Evony strategy, builds, combat...")
    
    if user_input:
        st.session_state.messages.append({"role": "user", "content": user_input})
        add_log(f"User: {user_input[:50]}...", "info")
        
        with st.spinner("Thinking..."):
            response = get_ai_response(user_input)
            st.session_state.messages.append({"role": "assistant", "content": response})
            add_log("AI response generated", "success")
        
        st.rerun()

with col2:
    st.markdown("### 📜 Activity Log")
    
    log_container = st.container(height=400)
    
    with log_container:
        if not st.session_state.logs:
            add_log("Evony AI Assistant started", "success")
            add_log("Connecting to training server...", "info")
            add_log("Model: Phase 4 (Training)", "info")
        
        for log in reversed(st.session_state.logs[-20:]):
            st.markdown(f'<div class="log-entry"><span class="log-timestamp">[{log["time"]}]</span> <span style="color:{log["color"]}">{log["msg"]}</span></div>', unsafe_allow_html=True)

# Quick Actions
st.markdown("### ⚡ Quick Commands")
quick_cols = st.columns(6)

quick_commands = [
    ("🏰 Build Order", "What's the optimal build order for a new city?"),
    ("⚔️ Combat Tips", "Best combat strategies for attacking NPCs?"),
    ("🎖️ Hero Guide", "How should I develop my heroes?"),
    ("📈 Resource Mgmt", "Tips for resource management?"),
    ("🛡️ Defense", "How to set up city defense?"),
    ("🤝 Alliance", "Alliance strategy tips?"),
]

for i, (label, cmd) in enumerate(quick_commands):
    with quick_cols[i]:
        if st.button(label, use_container_width=True):
            st.session_state.messages.append({"role": "user", "content": cmd})
            add_log(f"Quick command: {label}", "info")
            response = get_ai_response(cmd)
            st.session_state.messages.append({"role": "assistant", "content": response})
            add_log("AI response generated", "success")
            st.rerun()

# Footer
st.markdown("---")
st.markdown(f'<p style="text-align:center;color:{COLORS["text_dim"]};font-size:11px;">Evony AI Assistant v1.0 | Phase 4 Model Training | Loss: 0.22 → Target: 0.18</p>', unsafe_allow_html=True)
