#!/usr/bin/env python3
"""
Evaluate Fine-tuned Model vs Base Model
Compares: Base Qwen2.5-VL vs Fine-tuned on Evony tasks
"""

import json
import torch
from pathlib import Path
from datetime import datetime

WORKSPACE = Path("/workspace")
OUTPUT_DIR = WORKSPACE / "output"

# Test prompts for each task bucket
TEST_PROMPTS = {
    "gui_widget_map": [
        "[GUI_MAP] What UI elements would be visible on the main city screen?",
        "[GUI_MAP] Describe the layout of the barracks training interface.",
    ],
    "gui_action_plan": [
        "[GUI_STEPS] How do I navigate to train archers?",
        "[GUI_STEPS] What are the steps to upgrade my town hall?",
    ],
    "evidence_explain": [
        "[EVIDENCE] Explain the army.newArmy command and its parameters.",
        "[EVIDENCE] What does troop.produceTroop do?",
    ],
    "evidence_summarize": [
        "[SUMMARIZE] List all building types in Evony.",
        "[SUMMARIZE] What are the main protocol command categories?",
    ],
    "patch_plan": [
        "[PATCH] How would I fix error code -3 in troop training?",
        "[PATCH] What changes are needed to handle alliance.join failures?",
    ],
    "query_synthesis": [
        "[QUERY] I want to understand the combat formula. What should I retrieve?",
        "[QUERY] How do I find where resource production is calculated?",
    ],
}


def load_model(model_path, is_base=False):
    """Load model for evaluation"""
    from transformers import AutoModelForCausalLM, AutoTokenizer
    
    if is_base:
        model = AutoModelForCausalLM.from_pretrained(
            "Qwen/Qwen2.5-VL-7B-Instruct",
            torch_dtype=torch.float16,
            device_map="auto",
        )
        tokenizer = AutoTokenizer.from_pretrained("Qwen/Qwen2.5-VL-7B-Instruct")
    else:
        # Load fine-tuned (merged)
        model = AutoModelForCausalLM.from_pretrained(
            model_path,
            torch_dtype=torch.float16,
            device_map="auto",
        )
        tokenizer = AutoTokenizer.from_pretrained(model_path)
    
    return model, tokenizer


def generate_response(model, tokenizer, prompt, max_tokens=512):
    """Generate response from model"""
    messages = [
        {"role": "system", "content": "You are an Evony expert assistant."},
        {"role": "user", "content": prompt}
    ]
    
    text = tokenizer.apply_chat_template(messages, tokenize=False, add_generation_prompt=True)
    inputs = tokenizer(text, return_tensors="pt").to(model.device)
    
    with torch.no_grad():
        outputs = model.generate(
            **inputs,
            max_new_tokens=max_tokens,
            temperature=0.7,
            do_sample=True,
            pad_token_id=tokenizer.eos_token_id,
        )
    
    response = tokenizer.decode(outputs[0][inputs.input_ids.shape[1]:], skip_special_tokens=True)
    return response


def score_response(response, task_type):
    """Score response quality (0-100)"""
    score = 50  # Base score
    
    # Check for citations (RAG-native behavior)
    if "@" in response and ":" in response:
        score += 20
    
    # Check for structured output (JSON-like)
    if "{" in response and "}" in response:
        score += 10
    
    # Check for uncertainty acknowledgment
    if "need evidence" in response.lower() or "retrieve" in response.lower():
        if task_type == "query_synthesis":
            score += 20  # Good for query synthesis
        else:
            score += 5   # Acceptable for others
    
    # Check for step-by-step format
    if any(f"{i}." in response or f"{i})" in response for i in range(1, 6)):
        score += 10
    
    # Penalize very short responses
    if len(response) < 50:
        score -= 20
    
    # Penalize hallucination indicators
    if "i don't know" in response.lower() and task_type != "query_synthesis":
        score -= 10
    
    return min(100, max(0, score))


def evaluate():
    """Run full evaluation"""
    print("="*60)
    print("MODEL EVALUATION")
    print(f"Started: {datetime.now()}")
    print("="*60)
    
    results = {
        "base_model": {},
        "fine_tuned": {},
        "comparison": {},
    }
    
    merged_path = OUTPUT_DIR / "merged"
    
    if not merged_path.exists():
        print("ERROR: Fine-tuned model not found!")
        print(f"Expected: {merged_path}")
        return
    
    # Load models
    print("\nLoading base model...")
    base_model, base_tokenizer = load_model(None, is_base=True)
    
    print("Loading fine-tuned model...")
    ft_model, ft_tokenizer = load_model(str(merged_path))
    
    # Evaluate each task
    print("\n" + "-"*60)
    print("RUNNING EVALUATIONS")
    print("-"*60)
    
    for task_type, prompts in TEST_PROMPTS.items():
        print(f"\n{task_type}:")
        
        base_scores = []
        ft_scores = []
        
        for prompt in prompts:
            # Base model
            base_response = generate_response(base_model, base_tokenizer, prompt)
            base_score = score_response(base_response, task_type)
            base_scores.append(base_score)
            
            # Fine-tuned
            ft_response = generate_response(ft_model, ft_tokenizer, prompt)
            ft_score = score_response(ft_response, task_type)
            ft_scores.append(ft_score)
            
            print(f"  Base: {base_score} | Fine-tuned: {ft_score} | Δ: {ft_score - base_score:+d}")
        
        results["base_model"][task_type] = sum(base_scores) / len(base_scores)
        results["fine_tuned"][task_type] = sum(ft_scores) / len(ft_scores)
        results["comparison"][task_type] = results["fine_tuned"][task_type] - results["base_model"][task_type]
    
    # Summary
    print("\n" + "="*60)
    print("EVALUATION SUMMARY")
    print("="*60)
    
    avg_base = sum(results["base_model"].values()) / len(results["base_model"])
    avg_ft = sum(results["fine_tuned"].values()) / len(results["fine_tuned"])
    
    print(f"\nOverall Scores:")
    print(f"  Base Model:    {avg_base:.1f}")
    print(f"  Fine-tuned:    {avg_ft:.1f}")
    print(f"  Improvement:   {avg_ft - avg_base:+.1f}")
    
    print(f"\nBy Task:")
    for task in results["comparison"]:
        delta = results["comparison"][task]
        indicator = "✓" if delta > 0 else "✗" if delta < 0 else "="
        print(f"  {task}: {delta:+.1f} {indicator}")
    
    # Save results
    results["summary"] = {
        "base_average": avg_base,
        "fine_tuned_average": avg_ft,
        "improvement": avg_ft - avg_base,
        "evaluated_at": datetime.now().isoformat(),
    }
    
    with open(OUTPUT_DIR / "eval_results.json", "w") as f:
        json.dump(results, f, indent=2)
    
    print(f"\nResults saved: {OUTPUT_DIR / 'eval_results.json'}")
    
    return results


if __name__ == "__main__":
    evaluate()
