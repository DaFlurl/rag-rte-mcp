#!/usr/bin/env python3
"""
Prepare RAG-Native Multi-Task Dataset for Qwen2.5-VL Training
Implements 4 workflow patterns with 40/30/20/10 split:
- 40% GUI tasks (screenshot → widget map, action plan)
- 30% Evidence tasks (retrieved chunks → explain/cite)
- 20% Patch planning (evidence → diff/patch plan)
- 10% Query synthesis (what to retrieve next)
"""

import json
import re
import random
from pathlib import Path
from datetime import datetime
from collections import defaultdict

TRAINING_DIR = Path(__file__).parent.parent / "Evony_Training_Data"
OUTPUT_DIR = Path(__file__).parent / "data"

# RAG-Native Task Buckets (40/30/20/10 split)
TASK_BUCKETS = {
    # 40% - GUI Tasks (Vision → Structured Output)
    "gui_widget_map": {
        "weight": 0.20,
        "keywords": ["screen", "button", "ui", "interface", "click", "menu", "panel", "dialog", "window"],
        "prefix": "[GUI_MAP] ",
        "pattern": "A",  # Vision → Retrieve → Answer
        "description": "Screenshot → widget map (JSON)",
        "system": "You analyze game UI screenshots. Output structured JSON with widget names, types, and positions. If unsure, say 'Need screenshot' and suggest what to look for."
    },
    "gui_action_plan": {
        "weight": 0.20,
        "keywords": ["how to", "steps", "click", "navigate", "open", "access", "find", "where"],
        "prefix": "[GUI_STEPS] ",
        "pattern": "A",
        "description": "Screenshot → step-by-step action plan",
        "system": "You create step-by-step UI action plans. Output numbered steps with exact click targets. If no screenshot provided, request one and explain what you need to see."
    },
    
    # 30% - Evidence Tasks (Retrieved Chunks → Explain/Cite)
    "evidence_explain": {
        "weight": 0.15,
        "keywords": ["explain", "what is", "how does", "describe", "tell me about", "meaning"],
        "prefix": "[EVIDENCE] ",
        "pattern": "B",  # Retrieve → Vision
        "description": "Given retrieved code → explain with citations",
        "system": "You explain code and concepts using retrieved evidence. ALWAYS cite sources as `@filepath:line-range`. If no evidence provided, output: 'Need evidence. Suggested queries: [list 2-3 specific queries]'"
    },
    "evidence_summarize": {
        "weight": 0.15,
        "keywords": ["summarize", "overview", "list", "what are", "types of", "categories"],
        "prefix": "[SUMMARIZE] ",
        "pattern": "B",
        "description": "Given retrieved chunks → summarize with citations",
        "system": "You summarize retrieved information with proper citations. Format: `@filepath:line` for each fact. Without evidence, respond: 'Cannot summarize without evidence. Query suggestions: [specific queries]'"
    },
    
    # 20% - Patch Planning (Evidence → Diff/Patch)
    "patch_plan": {
        "weight": 0.10,
        "keywords": ["fix", "patch", "modify", "change", "update", "refactor", "bug"],
        "prefix": "[PATCH] ",
        "pattern": "C",  # Patch packet generation
        "description": "Evidence → patch plan + diff",
        "system": "You create patch plans from retrieved code. Output: 1) Analysis, 2) Files to modify with `@filepath`, 3) Unified diff format. Without sufficient context, list exactly what files/functions you need retrieved."
    },
    "patch_validate": {
        "weight": 0.10,
        "keywords": ["test", "validate", "check", "verify", "ensure", "correct"],
        "prefix": "[VALIDATE] ",
        "pattern": "C",
        "description": "Patch → validation plan + tests",
        "system": "You validate patches and suggest tests. Cite all referenced code as `@filepath:line`. If patch context incomplete, specify: 'Need to retrieve: [exact file/function names]'"
    },
    
    # 10% - Query Synthesis (Uncertainty Gate)
    "query_synthesis": {
        "weight": 0.10,
        "keywords": ["find", "search", "locate", "where is", "look for", "retrieve"],
        "prefix": "[QUERY] ",
        "pattern": "D",  # Uncertainty gate
        "description": "Synthesize retrieval queries",
        "system": "You help formulate precise RAG queries. When asked about something, output: 'To answer this, retrieve: [2-4 specific queries]'. Never guess without evidence - always request retrieval first."
    }
}

# Uncertainty gate responses (Pattern D enforcement)
UNCERTAINTY_TEMPLATES = [
    "Need evidence. Suggested retrieval queries:\n1. {q1}\n2. {q2}",
    "Cannot answer without retrieved context. Please query:\n- {q1}\n- {q2}",
    "Insufficient evidence. To answer accurately, retrieve:\n1. {q1}\n2. {q2}\n3. {q3}",
]

# Citation format examples
CITATION_EXAMPLES = [
    "@source_code/CommonCommands.as:45-52",
    "@source_code/CastleBean.as:120",
    "@protocol/army_commands.json:15-30",
]


def classify_example(example):
    """Classify example into a task bucket based on keywords and weights"""
    instruction = example.get("instruction", "").lower()
    output = example.get("output", "").lower()
    combined = instruction + " " + output
    
    scores = {}
    for bucket_name, bucket_info in TASK_BUCKETS.items():
        score = sum(1 for kw in bucket_info["keywords"] if kw in combined)
        # Weight the score by bucket target percentage
        scores[bucket_name] = score * bucket_info["weight"]
    
    # Return bucket with highest weighted score
    if max(scores.values()) == 0:
        # Random assignment based on target weights
        buckets = list(TASK_BUCKETS.keys())
        weights = [TASK_BUCKETS[b]["weight"] for b in buckets]
        return random.choices(buckets, weights=weights)[0]
    return max(scores, key=scores.get)


def add_citation_to_output(output, bucket_name):
    """Add citation format to outputs that reference code/files"""
    # If output mentions files or code, add citation format
    file_patterns = [
        (r"(\w+\.as)", r"`@source_code/\1`"),
        (r"(\w+\.json)", r"`@data/\1`"),
        (r"(Commands\.as)", r"`@source_code/\1:1-50`"),
    ]
    
    enhanced = output
    for pattern, replacement in file_patterns:
        if re.search(pattern, output) and "@" not in output:
            enhanced = re.sub(pattern, replacement, enhanced, count=1)
    
    return enhanced


def generate_uncertainty_response(instruction):
    """Generate Pattern D uncertainty gate response"""
    # Extract likely search terms from instruction
    words = instruction.lower().split()
    key_terms = [w for w in words if len(w) > 4 and w not in ["what", "how", "does", "the", "this", "that", "about"]][:3]
    
    if len(key_terms) >= 2:
        q1 = f"{key_terms[0]} definition site:source_code"
        q2 = f"{key_terms[1]} usage example"
        q3 = f"{key_terms[0]} {key_terms[1]} implementation"
    else:
        q1 = "relevant command definition"
        q2 = "related bean class fields"
        q3 = "protocol handler implementation"
    
    template = random.choice(UNCERTAINTY_TEMPLATES)
    return template.format(q1=q1, q2=q2, q3=q3)


def format_for_qwen_vl(example, bucket_name):
    """Format example for Qwen2.5-VL RAG-native multi-task training"""
    bucket = TASK_BUCKETS[bucket_name]
    instruction = example.get("instruction", "")
    input_text = example.get("input", "")
    output = example.get("output", "")
    
    # Enhance output with citations for evidence-based buckets
    if bucket["pattern"] in ["B", "C"]:
        output = add_citation_to_output(output, bucket_name)
    
    # For query synthesis bucket, sometimes generate uncertainty responses
    if bucket_name == "query_synthesis" and random.random() < 0.3:
        output = generate_uncertainty_response(instruction)
    
    # Build user message with task prefix
    if input_text:
        user_content = f"{bucket['prefix']}{instruction}\n\nInput: {input_text}"
    else:
        user_content = f"{bucket['prefix']}{instruction}"
    
    # Qwen VL format
    return {
        "messages": [
            {
                "role": "system",
                "content": "You are an expert Evony assistant. You understand game protocols, code, mechanics, and can troubleshoot issues. Provide accurate, detailed responses."
            },
            {
                "role": "user",
                "content": user_content
            },
            {
                "role": "assistant", 
                "content": output
            }
        ],
        "task": bucket_name
    }


def main():
    print("="*60)
    print("PREPARING MULTI-TASK DATASET")
    print(f"Started: {datetime.now()}")
    print("="*60)
    
    OUTPUT_DIR.mkdir(exist_ok=True)
    
    # Load dataset
    datasets = ["evony_filtered_quality.json", "evony_augmented_10k.json", "evony_final_5k.json"]
    data = None
    
    for ds in datasets:
        path = TRAINING_DIR / ds
        if path.exists():
            print(f"\nLoading: {ds}")
            with open(path) as f:
                data = json.load(f)
            print(f"Loaded {len(data)} examples")
            break
    
    if not data:
        print("ERROR: No dataset found!")
        return
    
    # Classify into buckets
    print("\nClassifying into task buckets...")
    buckets = defaultdict(list)
    
    for example in data:
        bucket = classify_example(example)
        formatted = format_for_qwen_vl(example, bucket)
        buckets[bucket].append(formatted)
    
    # Print distribution
    print("\n--- TASK DISTRIBUTION ---")
    total = 0
    for bucket_name, examples in sorted(buckets.items(), key=lambda x: -len(x[1])):
        desc = TASK_BUCKETS[bucket_name]["description"]
        print(f"  {bucket_name}: {len(examples)} examples ({desc})")
        total += len(examples)
    print(f"  TOTAL: {total}")
    
    # Combine all for training
    all_examples = []
    for examples in buckets.values():
        all_examples.extend(examples)
    
    # Shuffle
    import random
    random.seed(42)
    random.shuffle(all_examples)
    
    # Split train/val (90/10)
    split_idx = int(len(all_examples) * 0.9)
    train_data = all_examples[:split_idx]
    val_data = all_examples[split_idx:]
    
    print(f"\nTrain: {len(train_data)} examples")
    print(f"Val: {len(val_data)} examples")
    
    # Save in multiple formats
    
    # 1. Full JSON
    with open(OUTPUT_DIR / "train_multitask.json", "w") as f:
        json.dump(train_data, f, indent=2)
    
    with open(OUTPUT_DIR / "val_multitask.json", "w") as f:
        json.dump(val_data, f, indent=2)
    
    # 2. JSONL
    with open(OUTPUT_DIR / "train_multitask.jsonl", "w") as f:
        for ex in train_data:
            f.write(json.dumps(ex) + "\n")
    
    with open(OUTPUT_DIR / "val_multitask.jsonl", "w") as f:
        for ex in val_data:
            f.write(json.dumps(ex) + "\n")
    
    # 3. Per-bucket files (for analysis)
    for bucket_name, examples in buckets.items():
        with open(OUTPUT_DIR / f"bucket_{bucket_name}.jsonl", "w") as f:
            for ex in examples:
                f.write(json.dumps(ex) + "\n")
    
    # Save stats
    stats = {
        "total_examples": total,
        "train_examples": len(train_data),
        "val_examples": len(val_data),
        "bucket_distribution": {k: len(v) for k, v in buckets.items()},
        "generated_at": datetime.now().isoformat()
    }
    
    with open(OUTPUT_DIR / "multitask_stats.json", "w") as f:
        json.dump(stats, f, indent=2)
    
    print(f"\n✅ MULTI-TASK DATASET READY")
    print(f"Output: {OUTPUT_DIR}")
    print(f"Completed: {datetime.now()}")


if __name__ == "__main__":
    main()
