#!/usr/bin/env python3
"""
Quick Test Script - Compare Base vs Finetuned Evony Coder
Run after training to evaluate quality improvement

Usage:
    python test_model.py                    # Test latest model
    python test_model.py /path/to/model     # Test specific model
"""

import sys
import torch
from pathlib import Path

# Test prompts - Evony-specific knowledge (30+ prompts per Claude recommendation)
TEST_PROMPTS = [
    # === AS3 CODE UNDERSTANDING (8 prompts) ===
    {
        "category": "AS3 Code",
        "prompt": "Explain what this ActionScript 3 code does:\n```\npublic function TroopManager() {\n    _troops = new Dictionary();\n    _marchQueue = new Vector.<March>();\n}\n```",
        "expected_topics": ["constructor", "Dictionary", "Vector", "troops", "march"]
    },
    {
        "category": "AS3 Code",
        "prompt": "What does this Evony client code do?\n```\nprivate function onBuildComplete(e:TimerEvent):void {\n    _building.level++;\n    dispatchEvent(new BuildEvent(BuildEvent.COMPLETE));\n}\n```",
        "expected_topics": ["event", "timer", "level", "building", "dispatch"]
    },
    {
        "category": "AS3 Code",
        "prompt": "Explain the purpose of this packet handler:\n```\ncase CMD_CYCMD:\n    var data:ByteArray = packet.readBytes();\n    processCommand(data);\n    break;\n```",
        "expected_topics": ["packet", "ByteArray", "command", "switch", "case"]
    },
    {
        "category": "AS3 Code",
        "prompt": "What pattern is this code using?\n```\npublic static function getInstance():GameManager {\n    if (!_instance) _instance = new GameManager();\n    return _instance;\n}\n```",
        "expected_topics": ["singleton", "static", "instance", "pattern"]
    },
    {
        "category": "AS3 Code",
        "prompt": "Analyze this resource calculation:\n```\nvar cost:int = basePrice * Math.pow(1.25, level);\nif (cost > int.MAX_VALUE) cost = int.MAX_VALUE;\n```",
        "expected_topics": ["overflow", "cost", "level", "exponential", "MAX_VALUE"]
    },
    {
        "category": "AS3 Code",
        "prompt": "What does this encryption code do?\n```\nfor (var i:int = 0; i < data.length; i++) {\n    data[i] ^= 0xAA;\n}\n```",
        "expected_topics": ["XOR", "encryption", "byte", "loop", "decrypt"]
    },
    {
        "category": "AS3 Code",
        "prompt": "Explain this event listener setup:\n```\nstage.addEventListener(MouseEvent.CLICK, onMapClick);\nstage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);\n```",
        "expected_topics": ["event", "listener", "mouse", "keyboard", "stage"]
    },
    {
        "category": "AS3 Code",
        "prompt": "What is the purpose of this loader code?\n```\nvar loader:URLLoader = new URLLoader();\nloader.dataFormat = URLLoaderDataFormat.BINARY;\nloader.load(new URLRequest(API_URL + endpoint));\n```",
        "expected_topics": ["URLLoader", "binary", "request", "API", "load"]
    },
    
    # === PROTOCOL KNOWLEDGE (6 prompts) ===
    {
        "category": "Protocol",
        "prompt": "In Evony, what is the purpose of the CYCMD packet and what data does it typically contain?",
        "expected_topics": ["command", "packet", "server", "action"]
    },
    {
        "category": "Protocol",
        "prompt": "How does the Evony client authenticate with the game server?",
        "expected_topics": ["login", "token", "session", "password", "hash"]
    },
    {
        "category": "Protocol",
        "prompt": "What is the structure of a typical Evony network packet header?",
        "expected_topics": ["length", "command", "header", "bytes", "id"]
    },
    {
        "category": "Protocol",
        "prompt": "How does the client handle server push notifications for attacks?",
        "expected_topics": ["push", "notification", "attack", "event", "incoming"]
    },
    {
        "category": "Protocol",
        "prompt": "What encryption or obfuscation does Evony use for its network traffic?",
        "expected_topics": ["XOR", "encryption", "obfuscation", "key", "bytes"]
    },
    {
        "category": "Protocol",
        "prompt": "Describe the heartbeat/keepalive mechanism in the Evony protocol.",
        "expected_topics": ["heartbeat", "keepalive", "ping", "timeout", "connection"]
    },
    
    # === GAME MECHANICS (6 prompts) ===
    {
        "category": "Game Logic",
        "prompt": "How does the BuildingController class manage building upgrades in the Evony client?",
        "expected_topics": ["upgrade", "building", "queue", "resources", "time"]
    },
    {
        "category": "Game Logic",
        "prompt": "Explain how troop training works in the Evony client code.",
        "expected_topics": ["train", "queue", "barracks", "time", "troops"]
    },
    {
        "category": "Game Logic",
        "prompt": "How does the client calculate march time between two cities?",
        "expected_topics": ["distance", "speed", "march", "time", "calculate"]
    },
    {
        "category": "Game Logic",
        "prompt": "What determines resource production rates in Evony?",
        "expected_topics": ["production", "building", "level", "bonus", "rate"]
    },
    {
        "category": "Game Logic",
        "prompt": "How does the combat system calculate battle outcomes?",
        "expected_topics": ["attack", "defense", "troops", "damage", "combat"]
    },
    {
        "category": "Game Logic",
        "prompt": "Explain how the research/technology tree is implemented.",
        "expected_topics": ["research", "academy", "tech", "requirements", "time"]
    },
    
    # === AUTOEVONY BOT (4 prompts) ===
    {
        "category": "AutoEvony",
        "prompt": "What are the main automation features that AutoEvony provides for Evony gameplay?",
        "expected_topics": ["automation", "farming", "troops", "resources", "attack"]
    },
    {
        "category": "AutoEvony",
        "prompt": "How does AutoEvony's script system work with includeurl commands?",
        "expected_topics": ["script", "includeurl", "http", "command", "server"]
    },
    {
        "category": "AutoEvony",
        "prompt": "What is the overflow exploit in AutoEvony and how does it work?",
        "expected_topics": ["overflow", "integer", "troops", "cost", "MAX"]
    },
    {
        "category": "AutoEvony",
        "prompt": "How would you write an AutoEvony script for automatic resource farming?",
        "expected_topics": ["farm", "valley", "attack", "gather", "repeat"]
    },
    
    # === REVERSE ENGINEERING (4 prompts) ===
    {
        "category": "RE",
        "prompt": "How would you approach decompiling an Evony SWF file to understand its network protocol?",
        "expected_topics": ["decompile", "SWF", "FFDec", "AS3", "packets"]
    },
    {
        "category": "RE",
        "prompt": "What tools would you use to intercept and analyze Evony network traffic?",
        "expected_topics": ["proxy", "Wireshark", "Fiddler", "intercept", "packets"]
    },
    {
        "category": "RE",
        "prompt": "How can you extract encryption keys from the Evony client?",
        "expected_topics": ["decompile", "string", "key", "constant", "search"]
    },
    {
        "category": "RE",
        "prompt": "What are the main classes to look for when reverse engineering Evony?",
        "expected_topics": ["Manager", "Controller", "Handler", "Protocol", "Net"]
    },
    
    # === CODE GENERATION (4 prompts) ===
    {
        "category": "Code Gen",
        "prompt": "Write an ActionScript 3 class that manages a player's resource storage with gold, food, wood, iron, and stone.",
        "expected_topics": ["class", "public", "function", "Number", "resources"]
    },
    {
        "category": "Code Gen",
        "prompt": "Write a packet parser function for reading Evony server responses.",
        "expected_topics": ["ByteArray", "read", "parse", "packet", "function"]
    },
    {
        "category": "Code Gen",
        "prompt": "Create an event dispatcher for building completion notifications.",
        "expected_topics": ["Event", "dispatch", "listener", "class", "extends"]
    },
    {
        "category": "Code Gen",
        "prompt": "Write code to calculate the optimal troop composition for attacking an NPC.",
        "expected_topics": ["troops", "attack", "calculate", "array", "return"]
    },
    
    # === EXPLOIT ANALYSIS (4 prompts) ===
    {
        "category": "Exploit",
        "prompt": "What are common vulnerabilities in Flash-based games like Evony that could be exploited?",
        "expected_topics": ["packet", "memory", "timing", "validation", "client"]
    },
    {
        "category": "Exploit",
        "prompt": "How does the integer overflow exploit for troop training work?",
        "expected_topics": ["overflow", "int", "MAX", "cost", "negative"]
    },
    {
        "category": "Exploit",
        "prompt": "What race conditions exist in the Evony client that could be exploited?",
        "expected_topics": ["race", "timing", "simultaneous", "server", "validation"]
    },
    {
        "category": "Exploit",
        "prompt": "How could packet replay attacks be used against Evony?",
        "expected_topics": ["replay", "packet", "capture", "resend", "session"]
    },
    
    # === GUI UNDERSTANDING (2 prompts) ===
    {
        "category": "GUI",
        "prompt": "Describe the typical structure of a UI component class in the Evony client.",
        "expected_topics": ["Sprite", "addChild", "event", "listener", "display"]
    },
    {
        "category": "GUI",
        "prompt": "How does the Evony client handle popup dialogs and modal windows?",
        "expected_topics": ["popup", "modal", "layer", "close", "display"]
    },
]


def load_model(model_path: str):
    """Load model for inference"""
    print(f"\n[LOAD] Loading model from: {model_path}")
    
    try:
        from unsloth import FastLanguageModel
        
        model, tokenizer = FastLanguageModel.from_pretrained(
            model_name=model_path,
            max_seq_length=4096,
            load_in_4bit=True,
            dtype=None,
        )
        
        FastLanguageModel.for_inference(model)
        print("[LOAD] ✓ Model loaded successfully")
        return model, tokenizer
        
    except Exception as e:
        print(f"[LOAD] ✗ Failed: {e}")
        return None, None


def generate_response(model, tokenizer, prompt: str, max_tokens: int = 512):
    """Generate a response"""
    messages = [
        {"role": "system", "content": "You are an expert on Evony game client development, ActionScript 3, and game reverse engineering."},
        {"role": "user", "content": prompt}
    ]
    
    # Format as ChatML
    text = ""
    for msg in messages:
        text += f"<|im_start|>{msg['role']}\n{msg['content']}<|im_end|>\n"
    text += "<|im_start|>assistant\n"
    
    inputs = tokenizer(text, return_tensors="pt").to(model.device)
    
    with torch.no_grad():
        outputs = model.generate(
            **inputs,
            max_new_tokens=max_tokens,
            temperature=0.7,
            top_p=0.9,
            do_sample=True,
            pad_token_id=tokenizer.pad_token_id,
        )
    
    response = tokenizer.decode(outputs[0], skip_special_tokens=False)
    
    # Extract assistant response
    if "<|im_start|>assistant" in response:
        response = response.split("<|im_start|>assistant")[-1]
        if "<|im_end|>" in response:
            response = response.split("<|im_end|>")[0]
    
    return response.strip()


def score_response(response: str, expected_topics: list) -> dict:
    """Score response based on expected topic coverage"""
    response_lower = response.lower()
    
    found = []
    missing = []
    
    for topic in expected_topics:
        if topic.lower() in response_lower:
            found.append(topic)
        else:
            missing.append(topic)
    
    score = len(found) / len(expected_topics) if expected_topics else 0
    
    return {
        "score": score,
        "found": found,
        "missing": missing,
        "length": len(response),
    }


def run_tests(model, tokenizer):
    """Run all test prompts"""
    print("\n" + "=" * 70)
    print("  EVONY CODER MODEL EVALUATION")
    print("=" * 70)
    
    results = []
    total_score = 0
    
    for i, test in enumerate(TEST_PROMPTS, 1):
        print(f"\n[TEST {i}/{len(TEST_PROMPTS)}] {test['category']}")
        print("-" * 50)
        print(f"Prompt: {test['prompt'][:80]}...")
        
        response = generate_response(model, tokenizer, test['prompt'])
        scores = score_response(response, test['expected_topics'])
        
        print(f"Response length: {scores['length']} chars")
        print(f"Topic coverage: {scores['score']*100:.0f}%")
        print(f"Found: {scores['found']}")
        print(f"Missing: {scores['missing']}")
        
        # Show snippet of response
        snippet = response[:200] + "..." if len(response) > 200 else response
        print(f"Response: {snippet}")
        
        results.append({
            "category": test['category'],
            "score": scores['score'],
            "response_length": scores['length'],
        })
        total_score += scores['score']
    
    # Summary
    avg_score = total_score / len(TEST_PROMPTS)
    
    print("\n" + "=" * 70)
    print("  EVALUATION SUMMARY")
    print("=" * 70)
    print(f"\n  Overall Score: {avg_score*100:.1f}%")
    print(f"\n  By Category:")
    
    for r in results:
        bar = "█" * int(r['score'] * 10) + "░" * (10 - int(r['score'] * 10))
        print(f"    {r['category']:12} [{bar}] {r['score']*100:.0f}%")
    
    print("\n" + "=" * 70)
    
    return avg_score, results


def main():
    # Determine model path
    if len(sys.argv) > 1:
        model_path = sys.argv[1]
    else:
        # Try common locations
        candidates = [
            "/workspace/output_phase2/merged",
            "/workspace/output/merged",
            "/workspace/output_v2/merged",
        ]
        
        model_path = None
        for c in candidates:
            if Path(c).exists():
                model_path = c
                break
        
        if model_path is None:
            print("Usage: python test_model.py /path/to/model")
            print("\nNo model found in default locations:")
            for c in candidates:
                print(f"  - {c}")
            sys.exit(1)
    
    # Load and test
    model, tokenizer = load_model(model_path)
    if model is None:
        sys.exit(1)
    
    score, results = run_tests(model, tokenizer)
    
    # Interpretation
    print("\n  Interpretation:")
    if score >= 0.8:
        print("  ✅ EXCELLENT - Model has strong Evony domain knowledge")
    elif score >= 0.6:
        print("  ✓ GOOD - Model understands Evony concepts well")
    elif score >= 0.4:
        print("  ○ FAIR - Model has some Evony knowledge, more training may help")
    else:
        print("  ✗ NEEDS WORK - Consider more epochs or better data")


if __name__ == "__main__":
    main()
