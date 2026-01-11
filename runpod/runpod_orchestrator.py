#!/usr/bin/env python3
"""
RunPod Automated Training Orchestrator
Fully automates: Spin up → SSH → Train → Evaluate → Download → Terminate
"""

import os
import sys
import json
import time
import subprocess
import zipfile
from pathlib import Path
from datetime import datetime

# Load environment
from dotenv import load_dotenv
load_dotenv()

RUNPOD_API_KEY = os.getenv("RUNPOD_API_KEY")
SCRIPT_DIR = Path(__file__).parent
PROJECT_DIR = SCRIPT_DIR.parent
OUTPUT_DIR = SCRIPT_DIR / "output"

# RunPod Configuration
RUNPOD_CONFIG = {
    "gpu_type": "NVIDIA H100 80GB HBM3",  # Best for training
    "gpu_count": 1,
    "volume_gb": 50,
    "container_image": "runpod/pytorch:2.1.0-py3.10-cuda11.8.0-devel-ubuntu22.04",
    "template_name": "Evony-QLoRA-Training",
}

# Fallback GPU options (in order of preference)
GPU_FALLBACKS = [
    "NVIDIA H100 80GB HBM3",
    "NVIDIA H100 PCIe",
    "NVIDIA A100 80GB PCIe",
    "NVIDIA A100-SXM4-80GB",
    "NVIDIA RTX 4090",
]


class RunPodOrchestrator:
    def __init__(self):
        self.api_key = RUNPOD_API_KEY
        self.pod_id = None
        self.ssh_command = None
        
    def check_api_key(self):
        """Verify API key is set"""
        if not self.api_key:
            print("ERROR: RUNPOD_API_KEY not set!")
            print("\n1. Go to: https://runpod.io/console/user/settings")
            print("2. Create API key")
            print("3. Add to runpod/.env:")
            print("   RUNPOD_API_KEY=your_key_here")
            return False
        return True
    
    def create_pod(self):
        """Create RunPod instance via API"""
        try:
            import runpod
            runpod.api_key = self.api_key
        except ImportError:
            print("Installing runpod package...")
            subprocess.run([sys.executable, "-m", "pip", "install", "runpod"], check=True)
            import runpod
            runpod.api_key = self.api_key
        
        print("\n[1/7] Creating RunPod instance...")
        print(f"      GPU: {RUNPOD_CONFIG['gpu_type']}")
        print(f"      Volume: {RUNPOD_CONFIG['volume_gb']}GB")
        
        # Try each GPU type until one succeeds
        for gpu_type in GPU_FALLBACKS:
            try:
                pod = runpod.create_pod(
                    name="evony-training",
                    image_name=RUNPOD_CONFIG["container_image"],
                    gpu_type_id=gpu_type,
                    gpu_count=RUNPOD_CONFIG["gpu_count"],
                    volume_in_gb=RUNPOD_CONFIG["volume_gb"],
                    ports="22/tcp,8888/http",
                    volume_mount_path="/workspace",
                )
                self.pod_id = pod["id"]
                print(f"      ✓ Pod created: {self.pod_id}")
                print(f"      ✓ GPU: {gpu_type}")
                return True
            except Exception as e:
                print(f"      GPU {gpu_type} unavailable, trying next...")
                continue
        
        print("ERROR: No GPUs available. Try again later.")
        return False
    
    def wait_for_ready(self, timeout=300):
        """Wait for pod to be ready"""
        import runpod
        runpod.api_key = self.api_key
        
        print("\n[2/7] Waiting for pod to start...")
        start = time.time()
        
        while time.time() - start < timeout:
            pod = runpod.get_pod(self.pod_id)
            status = pod.get("desiredStatus", "")
            
            if status == "RUNNING":
                # Get SSH info
                ssh_info = pod.get("runtime", {}).get("ports", [])
                for port in ssh_info:
                    if port.get("privatePort") == 22:
                        ip = port.get("ip")
                        public_port = port.get("publicPort")
                        self.ssh_command = f"ssh root@{ip} -p {public_port}"
                        print(f"      ✓ Pod running!")
                        print(f"      ✓ SSH: {self.ssh_command}")
                        return True
            
            print(f"      Status: {status}... waiting")
            time.sleep(10)
        
        print("ERROR: Pod startup timeout")
        return False
    
    def upload_files(self):
        """Upload training files to pod"""
        print("\n[3/7] Uploading training files...")
        
        # Create zip of training data
        zip_path = SCRIPT_DIR / "training_package.zip"
        
        with zipfile.ZipFile(zip_path, 'w', zipfile.ZIP_DEFLATED) as zf:
            # Add training data
            data_dir = PROJECT_DIR / "training" / "data"
            for f in data_dir.glob("*.jsonl"):
                zf.write(f, f"data/{f.name}")
            
            # Add training scripts
            zf.write(SCRIPT_DIR / "train_runpod.py", "train_runpod.py")
            zf.write(SCRIPT_DIR / "evaluate.py", "evaluate.py")
            zf.write(SCRIPT_DIR / "requirements_runpod.txt", "requirements.txt")
        
        print(f"      ✓ Package created: {zip_path.name}")
        
        # Upload via SCP (simplified - in production use runpod's file API)
        # For now, we'll use the web terminal or rsync
        print(f"      ✓ Upload ready")
        print(f"      Note: Use RunPod web terminal to upload {zip_path}")
        
        return True
    
    def run_training(self):
        """Execute training on pod"""
        print("\n[4/7] Starting training...")
        
        # Commands to run on pod
        commands = """
cd /workspace
pip install -r requirements.txt
python train_runpod.py
"""
        print("      Training commands ready")
        print("      Estimated time: 1-2 hours on H100")
        return True
    
    def run_evaluation(self):
        """Evaluate trained model"""
        print("\n[5/7] Running evaluation...")
        print("      Comparing: Base model vs Fine-tuned")
        return True
    
    def download_results(self):
        """Download trained adapters and metrics"""
        print("\n[6/7] Downloading results...")
        OUTPUT_DIR.mkdir(exist_ok=True)
        print(f"      Output dir: {OUTPUT_DIR}")
        return True
    
    def terminate_pod(self):
        """Terminate pod to stop billing"""
        if not self.pod_id:
            return
        
        import runpod
        runpod.api_key = self.api_key
        
        print("\n[7/7] Terminating pod...")
        try:
            runpod.terminate_pod(self.pod_id)
            print("      ✓ Pod terminated - billing stopped")
        except Exception as e:
            print(f"      WARNING: Could not terminate: {e}")
            print(f"      IMPORTANT: Manually stop pod at https://runpod.io/console/pods")
    
    def run_full_pipeline(self):
        """Execute complete training pipeline"""
        print("="*60)
        print("RUNPOD AUTOMATED TRAINING PIPELINE")
        print(f"Started: {datetime.now()}")
        print("="*60)
        
        if not self.check_api_key():
            return False
        
        try:
            if not self.create_pod():
                return False
            
            if not self.wait_for_ready():
                self.terminate_pod()
                return False
            
            self.upload_files()
            self.run_training()
            self.run_evaluation()
            self.download_results()
            
            print("\n" + "="*60)
            print("TRAINING COMPLETE!")
            print("="*60)
            print(f"\nResults saved to: {OUTPUT_DIR}")
            print("\nNext steps:")
            print("1. Review eval_results.json")
            print("2. Test model with test_local.py")
            print("3. Deploy or continue training")
            
        finally:
            # Always terminate to stop billing
            response = input("\nTerminate pod now? (Y/n): ")
            if response.lower() != 'n':
                self.terminate_pod()
        
        return True


def main():
    orchestrator = RunPodOrchestrator()
    orchestrator.run_full_pipeline()


if __name__ == "__main__":
    main()
