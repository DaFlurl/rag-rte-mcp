# Core AI and Deep Learning with CUDA support
--extra-index-url https://download.pytorch.org/whl/cu121
torch==2.2.0+cu121
torchvision==0.17.0+cu121
torchaudio==2.2.0+cu121
transformers==4.37.0
accelerate==0.27.0  # For optimized transformer operations
bitsandbytes==0.41.0  # For 8-bit optimization
einops==0.7.0  # For tensor operations optimization

# Computer Vision
opencv-python-headless==4.9.0.80  # Headless version for better performance
Pillow==10.2.0
pytesseract==0.3.10
nvidia-cudnn==8.9.2.26  # CUDA Deep Neural Network library

# Audio Processing
pyaudio==0.2.14
SpeechRecognition==3.10.1
gTTS==2.5.0
sounddevice==0.4.6
soundfile==0.12.1
openai-whisper==20231117

# Numerical Processing
numpy==1.26.0
cupy-cuda12x==12.3.0  # CUDA-accelerated NumPy-compatible array library

# UI and System
customtkinter==5.2.2
pywin32==306

# Performance Optimization
ninja==1.11.1  # For faster PyTorch builds
pytorch-lightning==2.1.3  # For distributed training
ray[default]==2.9.0  # For distributed computing
numba==0.58.1  # For JIT compilation

# Memory Management
psutil==5.9.8  # For system resource monitoring

# Optional Development Tools
tensorboard==2.15.1  # For monitoring training
gputil==1.4.0  # For GPU monitoring