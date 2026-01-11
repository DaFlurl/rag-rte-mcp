#!/usr/bin/env python3
"""
Training Monitor with Guardrails
Prevents wasting GPU money by monitoring performance metrics
"""

import time
import threading
import subprocess
import sys
from dataclasses import dataclass
from typing import Optional, Callable
from datetime import datetime

# =============================================================================
# GUARDRAIL THRESHOLDS (DO NOT LOWER THESE)
# =============================================================================

@dataclass
class Thresholds:
    # Steps per second thresholds
    STEPS_SEC_GOOD: float = 0.6       # Keep training
    STEPS_SEC_BORDERLINE: float = 0.3  # Warning, consider fixes
    STEPS_SEC_STOP: float = 0.25       # STOP IMMEDIATELY
    
    # Monitoring windows
    WARMUP_MINUTES: int = 2            # Ignore first 2 min (compilation)
    CHECK_WINDOW_MINUTES: int = 5      # Check every 5 min
    STOP_AFTER_MINUTES: int = 10       # Stop if bad after 10 min
    
    # Total steps thresholds
    MIN_USEFUL_STEPS: int = 4000       # Minimum for any learning
    GOOD_STEPS: int = 6000             # Good training session
    EXCELLENT_STEPS: int = 10000       # Excellent session
    
    # GPU utilization
    GPU_UTIL_MIN: float = 85.0         # Below this = problem
    GPU_UTIL_WARN: float = 50.0        # Serious warning


class TrainingMonitor:
    """
    Monitors training progress and enforces guardrails.
    Will STOP training if metrics indicate wasted GPU time.
    """
    
    def __init__(self, 
                 session_hours: float = 3.0,
                 cost_per_hour: float = 2.50,
                 auto_stop: bool = True):
        self.session_hours = session_hours
        self.cost_per_hour = cost_per_hour
        self.auto_stop = auto_stop
        self.thresholds = Thresholds()
        
        # Tracking
        self.start_time: Optional[float] = None
        self.steps_logged: list = []  # (timestamp, step_num)
        self.current_step: int = 0
        self.is_running: bool = False
        self.should_stop: bool = False
        self.stop_reason: str = ""
        
        # Callbacks
        self.on_warning: Optional[Callable] = None
        self.on_stop: Optional[Callable] = None
        
    def start(self):
        """Start monitoring"""
        self.start_time = time.time()
        self.is_running = True
        self.should_stop = False
        print(self._banner())
        
    def _banner(self) -> str:
        return f"""
================================================================================
  TRAINING MONITOR WITH GUARDRAILS
  Session: {self.session_hours}h | Budget: ${self.session_hours * self.cost_per_hour:.2f}
================================================================================
  THRESHOLDS:
    >= {self.thresholds.STEPS_SEC_GOOD} steps/sec  = GOOD (keep training)
    {self.thresholds.STEPS_SEC_BORDERLINE}-{self.thresholds.STEPS_SEC_GOOD} steps/sec = BORDERLINE (warning)
    < {self.thresholds.STEPS_SEC_STOP} steps/sec   = STOP (wasting money!)
  
  AUTO-STOP: {'ENABLED' if self.auto_stop else 'DISABLED'}
  Will stop if < {self.thresholds.STEPS_SEC_STOP} steps/sec after {self.thresholds.STOP_AFTER_MINUTES} minutes
================================================================================
"""
    
    def log_step(self, step_num: int, loss: Optional[float] = None):
        """Log a training step"""
        now = time.time()
        self.current_step = step_num
        self.steps_logged.append((now, step_num))
        
        # Keep only last 100 entries for memory
        if len(self.steps_logged) > 100:
            self.steps_logged = self.steps_logged[-100:]
        
        # Check guardrails every 50 steps
        if step_num % 50 == 0:
            self._check_guardrails()
    
    def get_steps_per_second(self, window_seconds: int = 60) -> float:
        """Calculate steps/sec over recent window"""
        if len(self.steps_logged) < 2:
            return 0.0
        
        now = time.time()
        cutoff = now - window_seconds
        
        # Get steps in window
        recent = [(t, s) for t, s in self.steps_logged if t >= cutoff]
        
        if len(recent) < 2:
            return 0.0
        
        time_span = recent[-1][0] - recent[0][0]
        step_span = recent[-1][1] - recent[0][1]
        
        if time_span <= 0:
            return 0.0
        
        return step_span / time_span
    
    def get_projected_total_steps(self) -> int:
        """Project total steps for session based on current rate"""
        steps_sec = self.get_steps_per_second()
        if steps_sec <= 0:
            return 0
        
        remaining_seconds = (self.session_hours * 3600) - self.elapsed_seconds()
        if remaining_seconds <= 0:
            return self.current_step
        
        projected = self.current_step + (steps_sec * remaining_seconds)
        return int(projected)
    
    def elapsed_seconds(self) -> float:
        """Seconds since start"""
        if self.start_time is None:
            return 0
        return time.time() - self.start_time
    
    def elapsed_minutes(self) -> float:
        """Minutes since start"""
        return self.elapsed_seconds() / 60
    
    def _check_guardrails(self):
        """Check if training should continue"""
        elapsed_min = self.elapsed_minutes()
        
        # Skip warmup period (JIT compilation, first batch)
        if elapsed_min < self.thresholds.WARMUP_MINUTES:
            return
        
        steps_sec = self.get_steps_per_second(window_seconds=120)
        projected = self.get_projected_total_steps()
        
        status = self._get_status(steps_sec, projected)
        
        # Print status every check
        print(f"\n[MONITOR] {elapsed_min:.1f}min | {steps_sec:.3f} steps/sec | "
              f"Projected: {projected:,} steps | {status}")
        
        # Check for STOP condition
        if elapsed_min >= self.thresholds.STOP_AFTER_MINUTES:
            if steps_sec < self.thresholds.STEPS_SEC_STOP:
                self._trigger_stop(
                    f"Steps/sec ({steps_sec:.3f}) below threshold "
                    f"({self.thresholds.STEPS_SEC_STOP}) after "
                    f"{elapsed_min:.0f} minutes"
                )
            elif projected < self.thresholds.MIN_USEFUL_STEPS:
                self._trigger_stop(
                    f"Projected steps ({projected:,}) below minimum useful "
                    f"({self.thresholds.MIN_USEFUL_STEPS:,})"
                )
    
    def _get_status(self, steps_sec: float, projected: int) -> str:
        """Get status string with emoji"""
        if steps_sec >= self.thresholds.STEPS_SEC_GOOD:
            if projected >= self.thresholds.EXCELLENT_STEPS:
                return "EXCELLENT - keep training!"
            elif projected >= self.thresholds.GOOD_STEPS:
                return "GOOD - on track"
            else:
                return "OK - acceptable"
        elif steps_sec >= self.thresholds.STEPS_SEC_BORDERLINE:
            return "BORDERLINE - consider reducing context/batch"
        else:
            return "TOO SLOW - will stop soon!"
    
    def _trigger_stop(self, reason: str):
        """Trigger training stop"""
        self.should_stop = True
        self.stop_reason = reason
        
        msg = f"""
================================================================================
  GUARDRAIL TRIGGERED - STOPPING TRAINING
================================================================================
  Reason: {reason}
  
  Elapsed: {self.elapsed_minutes():.1f} minutes
  Steps completed: {self.current_step:,}
  Money saved: ~${(self.session_hours - self.elapsed_minutes()/60) * self.cost_per_hour:.2f}
  
  RECOMMENDED FIXES:
  1. Reduce max_seq_length to 8192
  2. Reduce batch_size to 1-2
  3. Reduce image resolution
  4. Check GPU utilization
================================================================================
"""
        print(msg)
        
        if self.on_stop:
            self.on_stop(reason)
        
        if self.auto_stop:
            print("\nAUTO-STOP ENABLED: Training will be terminated.")
            # Signal to trainer to stop
            raise TrainingStopException(reason)
    
    def get_final_report(self) -> str:
        """Generate final training report"""
        elapsed = self.elapsed_minutes()
        steps_sec = self.get_steps_per_second()
        
        # Calculate cost
        actual_cost = (elapsed / 60) * self.cost_per_hour
        
        # Determine verdict
        if self.current_step >= self.thresholds.EXCELLENT_STEPS:
            verdict = "EXCELLENT - Great training session!"
        elif self.current_step >= self.thresholds.GOOD_STEPS:
            verdict = "GOOD - Solid results expected"
        elif self.current_step >= self.thresholds.MIN_USEFUL_STEPS:
            verdict = "ACCEPTABLE - Some learning occurred"
        else:
            verdict = "INSUFFICIENT - May need retraining"
        
        return f"""
================================================================================
  TRAINING SESSION COMPLETE
================================================================================
  Duration: {elapsed:.1f} minutes ({elapsed/60:.2f} hours)
  Total Steps: {self.current_step:,}
  Average Speed: {steps_sec:.3f} steps/sec
  Actual Cost: ~${actual_cost:.2f}
  
  VERDICT: {verdict}
  
  {f'STOPPED EARLY: {self.stop_reason}' if self.should_stop else ''}
================================================================================
"""


class TrainingStopException(Exception):
    """Exception raised when guardrails trigger a stop"""
    pass


# =============================================================================
# GPU MONITORING UTILITIES
# =============================================================================

def get_gpu_utilization() -> dict:
    """Get GPU utilization via nvidia-smi"""
    try:
        result = subprocess.run(
            ['nvidia-smi', '--query-gpu=index,utilization.gpu,memory.used,memory.total',
             '--format=csv,noheader,nounits'],
            capture_output=True, text=True, timeout=5
        )
        
        gpus = {}
        for line in result.stdout.strip().split('\n'):
            if line:
                parts = [p.strip() for p in line.split(',')]
                if len(parts) >= 4:
                    idx = int(parts[0])
                    gpus[idx] = {
                        'utilization': float(parts[1]),
                        'memory_used': float(parts[2]),
                        'memory_total': float(parts[3]),
                        'memory_percent': float(parts[2]) / float(parts[3]) * 100
                    }
        return gpus
    except Exception as e:
        return {}


def check_gpu_health() -> tuple:
    """
    Quick GPU health check.
    Returns (is_healthy, message)
    """
    gpus = get_gpu_utilization()
    
    if not gpus:
        return False, "Cannot read GPU stats"
    
    issues = []
    for idx, stats in gpus.items():
        if stats['utilization'] < 50:
            issues.append(f"GPU {idx}: Low utilization ({stats['utilization']:.0f}%)")
        if stats['memory_percent'] > 95:
            issues.append(f"GPU {idx}: Memory nearly full ({stats['memory_percent']:.0f}%)")
    
    if issues:
        return False, "; ".join(issues)
    
    return True, "GPUs healthy"


# =============================================================================
# CALLBACK FOR HUGGINGFACE TRAINER
# =============================================================================

class GuardrailCallback:
    """
    Callback for HuggingFace Trainer that integrates the monitor.
    """
    
    def __init__(self, monitor: TrainingMonitor):
        self.monitor = monitor
        
    def on_train_begin(self, args, state, control, **kwargs):
        self.monitor.start()
        
    def on_step_end(self, args, state, control, **kwargs):
        self.monitor.log_step(state.global_step, state.loss)
        
        if self.monitor.should_stop:
            control.should_training_stop = True
            
    def on_train_end(self, args, state, control, **kwargs):
        print(self.monitor.get_final_report())


# =============================================================================
# QUICK VALIDATION BEFORE TRAINING
# =============================================================================

def pre_training_check(config: dict) -> tuple:
    """
    Run pre-training validation.
    Returns (should_proceed, warnings)
    """
    warnings = []
    should_proceed = True
    
    # Check sequence length
    seq_len = config.get('max_seq_length', 8192)
    if seq_len > 16384:
        warnings.append(f"seq_length={seq_len} is HIGH. Recommend 8192-16384 for training.")
    
    # Check batch size
    batch = config.get('batch_size', 1)
    if batch > 4:
        warnings.append(f"batch_size={batch} may cause OOM. Start with 1-2.")
    
    # Check GPU
    healthy, msg = check_gpu_health()
    if not healthy:
        warnings.append(f"GPU issue: {msg}")
    
    # Estimate steps
    dataset_size = config.get('dataset_size', 9000)
    epochs = config.get('num_epochs', 3)
    grad_accum = config.get('gradient_accumulation_steps', 4)
    effective_batch = batch * grad_accum
    
    total_steps = (dataset_size * epochs) // effective_batch
    
    if total_steps < 4000:
        warnings.append(f"Projected steps={total_steps} is LOW. May not learn enough.")
    
    print(f"""
================================================================================
  PRE-TRAINING CHECK
================================================================================
  Dataset: {dataset_size:,} examples
  Epochs: {epochs}
  Batch: {batch} x {grad_accum} (grad accum) = {effective_batch} effective
  Estimated steps: {total_steps:,}
  
  Warnings: {len(warnings)}
""")
    
    for w in warnings:
        print(f"  ! {w}")
    
    if total_steps < 2000:
        should_proceed = False
        print("\n  BLOCKED: Too few steps projected. Fix config first.")
    
    return should_proceed, warnings


# =============================================================================
# MAIN (for testing)
# =============================================================================

if __name__ == "__main__":
    print("Training Monitor Module")
    print("=" * 60)
    
    # Test GPU check
    healthy, msg = check_gpu_health()
    print(f"GPU Health: {msg}")
    
    # Test pre-training check
    test_config = {
        'max_seq_length': 8192,
        'batch_size': 2,
        'dataset_size': 9000,
        'num_epochs': 3,
        'gradient_accumulation_steps': 4
    }
    
    proceed, warnings = pre_training_check(test_config)
    print(f"\nProceed: {proceed}")
