import torch
import torch.cuda
import torch.backends.cudnn as cudnn
import psutil
import GPUtil

class GPUManager:
    def __init__(self):
        self.setup_cuda()
        self.optimize_cuda()
        self.detect_gpus()
        
    def setup_cuda(self):
        """Setup CUDA environment"""
        # Enable CUDA
        torch.cuda.init()
        cudnn.enabled = True
        
        # Optimize cuDNN
        cudnn.benchmark = True
        cudnn.deterministic = False
        
        # Allow TF32 on Ampere
        torch.backends.cuda.matmul.allow_tf32 = True
        torch.backends.cudnn.allow_tf32 = True
        
    def optimize_cuda(self):
        """Optimize CUDA settings"""
        # Set memory allocation settings
        torch.cuda.set_per_process_memory_fraction(0.8)  # Reserve 20% for system
        torch.cuda.empty_cache()
        
        # Enable memory caching
        torch.cuda.memory.set_memory_fraction(0.8)
        
    def detect_gpus(self):
        """Detect and configure available GPUs"""
        self.num_gpus = torch.cuda.device_count()
        self.gpus = []
        
        for i in range(self.num_gpus):
            gpu_info = {
                'index': i,
                'name': torch.cuda.get_device_name(i),
                'memory_total': torch.cuda.get_device_properties(i).total_memory,
                'memory_free': torch.cuda.memory_allocated(i),
                'compute_capability': torch.cuda.get_device_capability(i)
            }
            self.gpus.append(gpu_info)
            
    def get_optimal_device(self, task_type='vision'):
        """Get optimal GPU for specific task"""
        if task_type == 'vision':
            # Use RTX 3090 Ti for vision tasks
            return torch.device('cuda:0')
        elif task_type == 'batch':
            # Use Tesla P40 for batch processing
            return torch.device('cuda:1')
        return torch.device('cuda:0')  # Default to primary GPU
        
    def monitor_gpu_usage(self):
        """Monitor GPU usage"""
        gpu_stats = []
        for gpu in GPUtil.getGPUs():
            stats = {
                'id': gpu.id,
                'name': gpu.name,
                'load': gpu.load * 100,
                'memory_used': gpu.memoryUsed,
                'memory_total': gpu.memoryTotal,
                'temperature': gpu.temperature
            }
            gpu_stats.append(stats)
        return gpu_stats
        
    def optimize_tensor_placement(self, tensor_size, task_type='vision'):
        """Optimize tensor placement across GPUs"""
        if tensor_size > 10 * 1024 * 1024 * 1024:  # If > 10GB
            # Use Tesla P40 for large tensors
            return torch.device('cuda:1')
        # Use RTX 3090 Ti for smaller tensors
        return torch.device('cuda:0')
        
    def get_memory_info(self):
        """Get memory information for all GPUs"""
        memory_info = {}
        for i in range(self.num_gpus):
            memory_info[f'gpu_{i}'] = {
                'total': torch.cuda.get_device_properties(i).total_memory,
                'allocated': torch.cuda.memory_allocated(i),
                'cached': torch.cuda.memory_reserved(i)
            }
        return memory_info

# Example usage
if __name__ == "__main__":
    gpu_manager = GPUManager()
    
    # Print GPU information
    print("Available GPUs:")
    for gpu in gpu_manager.gpus:
        print(f"GPU {gpu['index']}: {gpu['name']}")
        print(f"Memory: {gpu['memory_total'] / 1024**3:.2f} GB")
        print(f"Compute Capability: {gpu['compute_capability']}")
        
    # Monitor usage
    print("\nGPU Usage:")
    for stats in gpu_manager.monitor_gpu_usage():
        print(f"GPU {stats['id']}: {stats['load']:.1f}% Load, "
              f"{stats['temperature']}°C")