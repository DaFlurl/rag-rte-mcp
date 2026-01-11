#!/usr/bin/env python3
"""
Model Test Suite for Post-Training Evaluation
Comprehensive tests for the fine-tuned Evony model
"""

import json
from pathlib import Path
from datetime import datetime
from typing import List, Dict, Tuple
from dataclasses import dataclass

BASE_DIR = Path(__file__).parent.parent
OUTPUT_DIR = BASE_DIR / "test_results"


@dataclass
class TestCase:
    id: str
    category: str
    prompt: str
    expected_patterns: List[str]  # Patterns that should appear in response
    forbidden_patterns: List[str]  # Patterns that should NOT appear
    min_length: int = 50
    requires_citation: bool = False


# Comprehensive test cases
TEST_CASES = [
    # GUI Tasks (40%)
    TestCase(
        id="GUI-001",
        category="gui_widget_map",
        prompt="[GUI_MAP] What UI elements would be visible on the main city screen in Evony?",
        expected_patterns=["building", "resource", "button", "panel"],
        forbidden_patterns=["I don't know", "I'm not sure"],
        requires_citation=False
    ),
    TestCase(
        id="GUI-002", 
        category="gui_action_plan",
        prompt="[GUI_STEPS] How do I navigate to train archers in Evony?",
        expected_patterns=["1.", "click", "barracks", "archer"],
        forbidden_patterns=["I cannot", "I'm unable"],
        requires_citation=False
    ),
    TestCase(
        id="GUI-003",
        category="gui_action_plan",
        prompt="[GUI_STEPS] What are the steps to upgrade my town hall?",
        expected_patterns=["step", "click", "upgrade", "town hall"],
        forbidden_patterns=[],
        requires_citation=False
    ),
    
    # Evidence Tasks (30%)
    TestCase(
        id="EVI-001",
        category="evidence_explain",
        prompt="[EVIDENCE] Explain the army.newArmy command and its parameters.",
        expected_patterns=["army", "parameter", "heroId", "troops"],
        forbidden_patterns=[],
        requires_citation=True
    ),
    TestCase(
        id="EVI-002",
        category="evidence_explain",
        prompt="[EVIDENCE] What does troop.produceTroop do?",
        expected_patterns=["troop", "train", "barracks"],
        forbidden_patterns=[],
        requires_citation=True
    ),
    TestCase(
        id="EVI-003",
        category="evidence_summarize",
        prompt="[SUMMARIZE] List all building types in Evony.",
        expected_patterns=["barracks", "academy", "warehouse", "farm"],
        forbidden_patterns=[],
        requires_citation=True
    ),
    TestCase(
        id="EVI-004",
        category="evidence_summarize",
        prompt="[SUMMARIZE] What are the main protocol command categories?",
        expected_patterns=["army", "castle", "hero", "troop"],
        forbidden_patterns=[],
        requires_citation=True
    ),
    
    # Patch Tasks (20%)
    TestCase(
        id="PATCH-001",
        category="patch_plan",
        prompt="[PATCH] How would I fix error code -3 in troop training?",
        expected_patterns=["error", "-3", "fix", "queue"],
        forbidden_patterns=[],
        requires_citation=True
    ),
    TestCase(
        id="PATCH-002",
        category="patch_validate",
        prompt="[VALIDATE] How can I verify that troop training is working correctly?",
        expected_patterns=["test", "verify", "check", "response"],
        forbidden_patterns=[],
        requires_citation=False
    ),
    
    # Query Synthesis (10%) - Uncertainty Gate
    TestCase(
        id="QUERY-001",
        category="query_synthesis",
        prompt="[QUERY] I want to understand the combat formula. What should I retrieve?",
        expected_patterns=["retrieve", "search", "query"],
        forbidden_patterns=[],
        requires_citation=False
    ),
    TestCase(
        id="QUERY-002",
        category="query_synthesis",
        prompt="[QUERY] How do I find where resource production is calculated?",
        expected_patterns=["retrieve", "search", "resource"],
        forbidden_patterns=[],
        requires_citation=False
    ),
    
    # General Knowledge
    TestCase(
        id="GEN-001",
        category="general",
        prompt="What are the troop types in Evony?",
        expected_patterns=["archer", "cavalry", "catapult"],
        forbidden_patterns=[],
        requires_citation=False
    ),
    TestCase(
        id="GEN-002",
        category="general",
        prompt="How does the hero system work in Evony?",
        expected_patterns=["hero", "stats", "level"],
        forbidden_patterns=[],
        requires_citation=False
    ),
    
    # Edge Cases - Uncertainty Gate
    TestCase(
        id="EDGE-001",
        category="uncertainty",
        prompt="What is the exact memory address of the player object?",
        expected_patterns=["evidence", "retrieve", "cannot"],
        forbidden_patterns=["0x", "memory address is"],
        requires_citation=False,
        min_length=20
    ),
    TestCase(
        id="EDGE-002",
        category="uncertainty",
        prompt="Tell me the private encryption key used by the server.",
        expected_patterns=["cannot", "evidence", "security"],
        forbidden_patterns=["key is", "private key:"],
        requires_citation=False,
        min_length=20
    ),
]


class ModelTestSuite:
    """Comprehensive test suite for trained model"""
    
    def __init__(self):
        self.results = []
        self.model = None
        self.tokenizer = None
        OUTPUT_DIR.mkdir(exist_ok=True)
        
    def load_model(self, model_path: str):
        """Load the trained model"""
        try:
            from transformers import AutoModelForCausalLM, AutoTokenizer
            import torch
            
            print(f"Loading model from {model_path}...")
            
            self.tokenizer = AutoTokenizer.from_pretrained(model_path)
            self.model = AutoModelForCausalLM.from_pretrained(
                model_path,
                torch_dtype=torch.float16,
                device_map="auto"
            )
            
            print("✓ Model loaded")
            return True
            
        except Exception as e:
            print(f"ERROR loading model: {e}")
            return False
    
    def generate_response(self, prompt: str, max_tokens: int = 512) -> str:
        """Generate response from model"""
        if self.model is None:
            return "[MODEL NOT LOADED]"
        
        try:
            messages = [
                {"role": "system", "content": "You are an Evony expert assistant. Cite sources when available."},
                {"role": "user", "content": prompt}
            ]
            
            text = self.tokenizer.apply_chat_template(
                messages, tokenize=False, add_generation_prompt=True
            )
            inputs = self.tokenizer(text, return_tensors="pt").to(self.model.device)
            
            import torch
            with torch.no_grad():
                outputs = self.model.generate(
                    **inputs,
                    max_new_tokens=max_tokens,
                    temperature=0.7,
                    do_sample=True,
                    pad_token_id=self.tokenizer.eos_token_id
                )
            
            response = self.tokenizer.decode(
                outputs[0][inputs.input_ids.shape[1]:], 
                skip_special_tokens=True
            )
            return response
            
        except Exception as e:
            return f"[ERROR: {e}]"
    
    def evaluate_response(self, test: TestCase, response: str) -> Dict:
        """Evaluate a single response"""
        result = {
            "test_id": test.id,
            "category": test.category,
            "prompt": test.prompt,
            "response": response,
            "passed": True,
            "score": 0,
            "issues": []
        }
        
        response_lower = response.lower()
        
        # Check minimum length
        if len(response) < test.min_length:
            result["passed"] = False
            result["issues"].append(f"Too short ({len(response)} < {test.min_length})")
        else:
            result["score"] += 20
        
        # Check expected patterns
        expected_found = 0
        for pattern in test.expected_patterns:
            if pattern.lower() in response_lower:
                expected_found += 1
        
        if test.expected_patterns:
            pattern_score = (expected_found / len(test.expected_patterns)) * 40
            result["score"] += pattern_score
            if expected_found < len(test.expected_patterns) / 2:
                result["issues"].append(f"Missing expected patterns ({expected_found}/{len(test.expected_patterns)})")
        
        # Check forbidden patterns
        for pattern in test.forbidden_patterns:
            if pattern.lower() in response_lower:
                result["passed"] = False
                result["issues"].append(f"Contains forbidden: '{pattern}'")
                result["score"] -= 20
        
        # Check citation requirement
        if test.requires_citation:
            has_citation = "@" in response and ":" in response
            if has_citation:
                result["score"] += 20
            else:
                result["issues"].append("Missing citation")
        
        # Check for uncertainty gate (when appropriate)
        if test.category in ["query_synthesis", "uncertainty"]:
            if any(word in response_lower for word in ["retrieve", "evidence", "cannot", "need"]):
                result["score"] += 20
        
        # Normalize score
        result["score"] = max(0, min(100, result["score"]))
        
        # Final pass/fail based on score
        if result["score"] < 40:
            result["passed"] = False
        
        return result
    
    def run_all_tests(self, model_path: str = None) -> Dict:
        """Run all test cases"""
        print("="*60)
        print("MODEL TEST SUITE")
        print(f"Started: {datetime.now()}")
        print("="*60)
        
        if model_path:
            if not self.load_model(model_path):
                print("Cannot run tests without model")
                return None
        
        print(f"\nRunning {len(TEST_CASES)} tests...")
        
        for i, test in enumerate(TEST_CASES, 1):
            print(f"\n[{i}/{len(TEST_CASES)}] {test.id}: {test.category}")
            
            if self.model:
                response = self.generate_response(test.prompt)
            else:
                # Dry run - generate placeholder
                response = f"[DRY RUN - Would test: {test.prompt[:50]}...]"
            
            result = self.evaluate_response(test, response)
            self.results.append(result)
            
            status = "✓ PASS" if result["passed"] else "✗ FAIL"
            print(f"   {status} (score: {result['score']})")
            if result["issues"]:
                for issue in result["issues"][:2]:
                    print(f"   - {issue}")
        
        return self.generate_report()
    
    def generate_report(self) -> Dict:
        """Generate test report"""
        print("\n" + "="*60)
        print("TEST RESULTS SUMMARY")
        print("="*60)
        
        total = len(self.results)
        passed = sum(1 for r in self.results if r["passed"])
        avg_score = sum(r["score"] for r in self.results) / total if total > 0 else 0
        
        # By category
        categories = {}
        for r in self.results:
            cat = r["category"]
            if cat not in categories:
                categories[cat] = {"passed": 0, "total": 0, "scores": []}
            categories[cat]["total"] += 1
            categories[cat]["scores"].append(r["score"])
            if r["passed"]:
                categories[cat]["passed"] += 1
        
        print(f"\nOverall: {passed}/{total} passed ({passed/total*100:.1f}%)")
        print(f"Average Score: {avg_score:.1f}/100")
        
        print(f"\nBy Category:")
        for cat, data in sorted(categories.items()):
            cat_avg = sum(data["scores"]) / len(data["scores"])
            print(f"  {cat}: {data['passed']}/{data['total']} (avg {cat_avg:.0f})")
        
        # Save report
        report = {
            "timestamp": datetime.now().isoformat(),
            "total_tests": total,
            "passed": passed,
            "failed": total - passed,
            "pass_rate": passed / total if total > 0 else 0,
            "average_score": avg_score,
            "by_category": {
                cat: {
                    "passed": d["passed"],
                    "total": d["total"],
                    "avg_score": sum(d["scores"]) / len(d["scores"])
                }
                for cat, d in categories.items()
            },
            "results": self.results
        }
        
        report_path = OUTPUT_DIR / f"test_report_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
        with open(report_path, "w") as f:
            json.dump(report, f, indent=2)
        
        print(f"\nReport saved: {report_path}")
        
        return report
    
    def run_quick_validation(self) -> bool:
        """Run quick validation (no model needed)"""
        print("Running quick validation (dry run)...")
        
        # Just validate test case structure
        for test in TEST_CASES:
            assert test.id, "Test must have ID"
            assert test.prompt, "Test must have prompt"
            assert isinstance(test.expected_patterns, list), "Expected patterns must be list"
        
        print(f"✓ {len(TEST_CASES)} test cases validated")
        return True


def main():
    suite = ModelTestSuite()
    
    # Check for model path
    model_paths = [
        BASE_DIR / "training" / "output" / "merged",
        BASE_DIR / "training" / "output" / "final",
        BASE_DIR / "runpod" / "output" / "merged",
    ]
    
    model_path = None
    for p in model_paths:
        if p.exists():
            model_path = str(p)
            break
    
    if model_path:
        print(f"Found model: {model_path}")
        suite.run_all_tests(model_path)
    else:
        print("No trained model found - running validation only")
        suite.run_quick_validation()
        suite.run_all_tests()  # Dry run


if __name__ == "__main__":
    main()
