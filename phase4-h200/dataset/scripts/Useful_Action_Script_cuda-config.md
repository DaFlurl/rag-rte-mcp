# CUDA Configuration for Multi-GPU Setup (RTX 3090 Ti + Tesla P40)

## System Configuration
CUDA_VERSION=12.1
PYTORCH_VERSION=2.2.0
PYTHON_VERSION=3.11

## GPU-Specific Settings
# config.json
{
    "gpu_settings": {
        "primary_gpu": {
            "name": "RTX 3090 Ti",
            "memory": 24576,
            "cuda_device_id": 0,
            "preferred_tasks": ["vision", "transformers", "real-time-processing"]
        },
        "secondary_gpu": {
            "name": "Tesla P40",
            "memory": 23552,
            "cuda_device_id": 1,
            "preferred_tasks": ["batch-processing", "training", "background-tasks"]
        }
    },
    "memory_settings": {
        "system_ram": 131072,  # 128GB in MB
        "gpu_memory_allocation": {
            "vision_processing": 8192,    # 8GB
            "language_models": 10240,     # 10GB
            "audio_processing": 4096,     # 4GB
            "cache": 4096                 # 4GB
        }
    },
    "performance_settings": {
        "batch_size": 32,
        "num_workers": 16,
        "prefetch_factor": 4,
        "pin_memory": true,
        "cuda_non_blocking": true
    }
}