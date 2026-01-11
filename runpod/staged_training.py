#!/usr/bin/env python3
"""
Staged Training Controller - Implements RUNBOOK workflow
H200 SXM QLoRA Training with 2-hour blocks

Stages:
  0: Smoke test (15 min) - validate speed
  1: Core learning (2 hours) - 4k-6k steps
  2: Evaluate (10-15 min) - compare vs baseline
  3: Polish (2 hours) - 7k-10k total steps
  4: Optional (2 hours) - if still improving
"""

import os
import sys
import time
import json
from pathlib import Path
from datetime import datetime, timedelta
from dataclasses import dataclass
from typing import Optional, Tuple
from enum import Enum

# Load environment
try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass


class Stage(Enum):
    SMOKE_TEST = 0
    CORE_LEARNING = 1
    EVALUATE = 2
    POLISH = 3
    OPTIONAL = 4
    COMPLETE = 5


@dataclass
class StageResult:
    stage: Stage
    success: bool
    steps_completed: int
    steps_per_sec: float
    duration_minutes: float
    message: str
    should_continue: bool = True


@dataclass 
class TrainingState:
    current_stage: Stage = Stage.SMOKE_TEST
    total_steps: int = 0
    total_minutes: float = 0
    best_checkpoint: Optional[str] = None
    stages_completed: list = None
    
    def __post_init__(self):
        if self.stages_completed is None:
            self.stages_completed = []


# RUNBOOK THRESHOLDS
THRESHOLDS = {
    "good_speed": 0.6,
    "borderline_speed": 0.3,
    "stop_speed": 0.25,
    "smoke_test_minutes": 15,
    "block_hours": 2.0,
    "min_useful_steps": 4000,
    "good_steps": 6000,
    "excellent_steps": 10000,
}


def print_stage_banner(stage: Stage, state: TrainingState):
    """Print stage banner"""
    banners = {
        Stage.SMOKE_TEST: """
================================================================================
  STAGE 0: SMOKE TEST (15 minutes)
================================================================================
  Purpose: Validate training speed before committing GPU hours
  
  Decision Rules:
    >= 0.6 steps/sec  -> PROCEED to Stage 1
    0.3-0.6 steps/sec -> ADJUST config and retry
    < 0.25 steps/sec  -> STOP immediately
================================================================================
""",
        Stage.CORE_LEARNING: f"""
================================================================================
  STAGE 1: CORE LEARNING (2 hours)
================================================================================
  Purpose: Lock in behavior changes
  Target: 4,000-6,000 steps
  
  Current total steps: {state.total_steps:,}
  Expected after this stage: {state.total_steps + 5000:,}
================================================================================
""",
        Stage.EVALUATE: f"""
================================================================================
  STAGE 2: EVALUATE (10-15 minutes)
================================================================================
  Purpose: Verify adapter beats baseline
  
  Compare:
    Base Model + RAG  vs  Adapter + RAG
  
  Total steps so far: {state.total_steps:,}
  
  Decision:
    Better    -> Continue to Stage 3
    Not better -> STOP, fix dataset/config
================================================================================
""",
        Stage.POLISH: f"""
================================================================================
  STAGE 3: POLISH (2 hours)
================================================================================
  Purpose: Improve consistency
  Target: 7,000-10,000 total steps
  
  Current total steps: {state.total_steps:,}
  Best checkpoint: {state.best_checkpoint or 'None yet'}
================================================================================
""",
        Stage.OPTIONAL: f"""
================================================================================
  STAGE 4: OPTIONAL FINAL BLOCK (2 hours)
================================================================================
  Only proceed if:
    [ ] Eval metrics still improving
    [ ] Loss trending down
    [ ] Outputs cleaner
  
  Current total steps: {state.total_steps:,}
  
  If plateau detected -> STOP and save credits
================================================================================
""",
    }
    
    print(banners.get(stage, f"Stage: {stage.name}"))


def run_smoke_test() -> StageResult:
    """
    Stage 0: Run 15-minute smoke test
    Returns whether to proceed based on steps/sec
    """
    print_stage_banner(Stage.SMOKE_TEST, TrainingState())
    
    # In actual implementation, this would:
    # 1. Start training process
    # 2. Monitor for 15 minutes
    # 3. Check steps/sec
    # 4. Return decision
    
    # Placeholder - actual implementation calls train_runpod.py with time limit
    print("Starting smoke test...")
    print("Monitoring steps/sec for 15 minutes...")
    
    # This would be replaced with actual monitoring
    # For now, simulate checking the guardrail output
    
    return StageResult(
        stage=Stage.SMOKE_TEST,
        success=True,
        steps_completed=0,
        steps_per_sec=0.0,
        duration_minutes=15,
        message="Smoke test - check guardrail output",
        should_continue=True
    )


def run_training_block(stage: Stage, state: TrainingState, hours: float = 2.0) -> StageResult:
    """
    Run a training block for specified hours
    """
    print_stage_banner(stage, state)
    
    start_time = time.time()
    
    # In actual implementation:
    # 1. Resume from checkpoint if available
    # 2. Run training for specified hours
    # 3. Monitor steps/sec continuously
    # 4. Return results
    
    print(f"Running {hours}-hour training block...")
    print(f"Starting from step {state.total_steps:,}")
    
    # This would call the actual training
    # subprocess.run(["python", "train_runpod.py"])
    
    return StageResult(
        stage=stage,
        success=True,
        steps_completed=5000,  # Placeholder
        steps_per_sec=0.7,     # Placeholder
        duration_minutes=hours * 60,
        message=f"Training block complete",
        should_continue=True
    )


def run_evaluation(state: TrainingState) -> StageResult:
    """
    Stage 2: Run evaluation comparing adapter vs base
    """
    print_stage_banner(Stage.EVALUATE, state)
    
    print("Running evaluation...")
    print("Comparing: Base Model + RAG vs Adapter + RAG")
    
    # In actual implementation:
    # subprocess.run(["python", "evaluate.py"])
    
    return StageResult(
        stage=Stage.EVALUATE,
        success=True,
        steps_completed=0,
        steps_per_sec=0,
        duration_minutes=15,
        message="Evaluation complete - check results",
        should_continue=True
    )


def should_continue_to_optional(state: TrainingState) -> bool:
    """
    Determine if Stage 4 (optional) should run
    Based on: eval improving, loss down, outputs cleaner
    """
    # Check criteria
    checks = [
        ("Eval metrics improving", True),  # Would check actual metrics
        ("Loss trending down", True),       # Would check loss curve
        ("Outputs cleaner", True),          # Would check output quality
    ]
    
    print("\nStage 4 Decision Check:")
    all_pass = True
    for check, passed in checks:
        status = "PASS" if passed else "FAIL"
        print(f"  [{status}] {check}")
        if not passed:
            all_pass = False
    
    return all_pass


def save_training_state(state: TrainingState, filepath: str = "training_state.json"):
    """Save training state for resume"""
    data = {
        "current_stage": state.current_stage.name,
        "total_steps": state.total_steps,
        "total_minutes": state.total_minutes,
        "best_checkpoint": state.best_checkpoint,
        "stages_completed": [s.name for s in state.stages_completed] if state.stages_completed else [],
        "saved_at": datetime.now().isoformat(),
    }
    
    with open(filepath, "w") as f:
        json.dump(data, f, indent=2)
    
    print(f"State saved to {filepath}")


def load_training_state(filepath: str = "training_state.json") -> Optional[TrainingState]:
    """Load training state for resume"""
    if not os.path.exists(filepath):
        return None
    
    with open(filepath) as f:
        data = json.load(f)
    
    state = TrainingState(
        current_stage=Stage[data["current_stage"]],
        total_steps=data["total_steps"],
        total_minutes=data["total_minutes"],
        best_checkpoint=data.get("best_checkpoint"),
        stages_completed=[Stage[s] for s in data.get("stages_completed", [])],
    )
    
    print(f"Resumed from {filepath}")
    print(f"  Stage: {state.current_stage.name}")
    print(f"  Total steps: {state.total_steps:,}")
    
    return state


def run_staged_training():
    """
    Main staged training controller
    Implements the RUNBOOK workflow
    """
    print("""
================================================================================
  RUNPOD STAGED TRAINING CONTROLLER
  H200 SXM | QLoRA | 2-Hour Blocks | RUNBOOK Protocol
================================================================================
""")
    
    # Try to resume or start fresh
    state = load_training_state() or TrainingState()
    
    results = []
    
    try:
        # Stage 0: Smoke Test
        if state.current_stage == Stage.SMOKE_TEST:
            result = run_smoke_test()
            results.append(result)
            
            if not result.should_continue:
                print("\nSmoke test failed - stopping")
                return False
            
            state.current_stage = Stage.CORE_LEARNING
            save_training_state(state)
        
        # Stage 1: Core Learning (2 hours)
        if state.current_stage == Stage.CORE_LEARNING:
            result = run_training_block(Stage.CORE_LEARNING, state, hours=2.0)
            results.append(result)
            
            state.total_steps += result.steps_completed
            state.total_minutes += result.duration_minutes
            state.stages_completed.append(Stage.CORE_LEARNING)
            state.current_stage = Stage.EVALUATE
            save_training_state(state)
        
        # Stage 2: Evaluate
        if state.current_stage == Stage.EVALUATE:
            result = run_evaluation(state)
            results.append(result)
            
            if not result.should_continue:
                print("\nEvaluation shows no improvement - stopping")
                print("Fix dataset or config before continuing")
                return False
            
            state.stages_completed.append(Stage.EVALUATE)
            state.current_stage = Stage.POLISH
            save_training_state(state)
        
        # Stage 3: Polish (2 hours)
        if state.current_stage == Stage.POLISH:
            result = run_training_block(Stage.POLISH, state, hours=2.0)
            results.append(result)
            
            state.total_steps += result.steps_completed
            state.total_minutes += result.duration_minutes
            state.stages_completed.append(Stage.POLISH)
            state.current_stage = Stage.OPTIONAL
            save_training_state(state)
        
        # Stage 4: Optional (2 hours) - only if still improving
        if state.current_stage == Stage.OPTIONAL:
            if should_continue_to_optional(state):
                result = run_training_block(Stage.OPTIONAL, state, hours=2.0)
                results.append(result)
                
                state.total_steps += result.steps_completed
                state.total_minutes += result.duration_minutes
                state.stages_completed.append(Stage.OPTIONAL)
            else:
                print("\nGains have plateaued - skipping Stage 4 to save credits")
            
            state.current_stage = Stage.COMPLETE
            save_training_state(state)
        
        # Complete
        print(f"""
================================================================================
  TRAINING COMPLETE
================================================================================
  Total Steps: {state.total_steps:,}
  Total Time: {state.total_minutes:.0f} minutes ({state.total_minutes/60:.1f} hours)
  Stages Completed: {', '.join(s.name for s in state.stages_completed)}
  
  Estimated Cost: ~${(state.total_minutes / 60) * 3.59:.2f}
  
  Output:
    - Best checkpoint: {state.best_checkpoint or 'outputs/checkpoint-*'}
    - Final adapter: outputs/final/
================================================================================
""")
        
        return True
        
    except KeyboardInterrupt:
        print("\n\nTraining interrupted by user")
        save_training_state(state)
        print("State saved - can resume later")
        return False
    
    except Exception as e:
        print(f"\n\nError during training: {e}")
        save_training_state(state)
        print("State saved - can resume later")
        raise


def print_runbook_summary():
    """Print quick reference"""
    print("""
================================================================================
  RUNBOOK QUICK REFERENCE
================================================================================
  
  Stage 0: Smoke Test (15 min)
    - Validate >= 0.6 steps/sec
    - STOP if < 0.25 steps/sec
  
  Stage 1: Core Learning (2 hours)
    - Target: 4k-6k steps
    - Lock in behavior changes
  
  Stage 2: Evaluate (10-15 min)
    - Compare adapter vs base
    - STOP if not better
  
  Stage 3: Polish (2 hours)
    - Target: 7k-10k total steps
    - Improve consistency
  
  Stage 4: Optional (2 hours)
    - Only if still improving
    - Skip if plateau
  
  Config: seq_len=8192, batch=2, grad_accum=8, image=336, packing=OFF
  
================================================================================
""")


if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "--help":
        print_runbook_summary()
    else:
        run_staged_training()
