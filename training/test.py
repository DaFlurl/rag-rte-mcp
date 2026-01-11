#!/usr/bin/env python3
"""
Test/Inference Script for Trained Evony Model
"""

import torch
from pathlib import Path
from transformers import AutoModelForCausalLM, AutoTokenizer
from peft import PeftModel

SCRIPT_DIR = Path(__file__).parent
MODEL_DIR = SCRIPT_DIR / "output" / "final"
BASE_MODEL_DIR = SCRIPT_DIR / "models" / "qwen2.5-vl-7b"


def load_model():
    """Load the fine-tuned model"""
    print("Loading model...")
    
    # Load tokenizer
    tokenizer = AutoTokenizer.from_pretrained(
        str(MODEL_DIR),
        trust_remote_code=True,
    )
    
    # Try loading as PEFT model first
    try:
        base_model = AutoModelForCausalLM.from_pretrained(
            str(BASE_MODEL_DIR),
            device_map="auto",
            torch_dtype=torch.bfloat16,
            trust_remote_code=True,
        )
        model = PeftModel.from_pretrained(base_model, str(MODEL_DIR))
        print("Loaded as LoRA adapter")
    except:
        # Fall back to full model
        model = AutoModelForCausalLM.from_pretrained(
            str(MODEL_DIR),
            device_map="auto",
            torch_dtype=torch.bfloat16,
            trust_remote_code=True,
        )
        print("Loaded as full model")
    
    model.eval()
    return model, tokenizer


def generate_response(model, tokenizer, question):
    """Generate a response to a question"""
    
    # Format as chat
    messages = [
        {"role": "system", "content": "You are an expert on the Evony game, specializing in protocol commands, data structures, game mechanics, scripting, and security."},
        {"role": "user", "content": question}
    ]
    
    # Build prompt
    prompt = ""
    for msg in messages:
        role = msg["role"]
        content = msg["content"]
        prompt += f"<|im_start|>{role}\n{content}<|im_end|>\n"
    prompt += "<|im_start|>assistant\n"
    
    # Tokenize
    inputs = tokenizer(prompt, return_tensors="pt").to(model.device)
    
    # Generate
    with torch.no_grad():
        outputs = model.generate(
            **inputs,
            max_new_tokens=512,
            temperature=0.7,
            top_p=0.9,
            do_sample=True,
            pad_token_id=tokenizer.pad_token_id,
            eos_token_id=tokenizer.eos_token_id,
        )
    
    # Decode
    response = tokenizer.decode(outputs[0], skip_special_tokens=False)
    
    # Extract assistant response
    if "<|im_start|>assistant" in response:
        response = response.split("<|im_start|>assistant")[-1]
        if "<|im_end|>" in response:
            response = response.split("<|im_end|>")[0]
    
    return response.strip()


def run_tests():
    """Run test questions"""
    
    test_questions = [
        "What is the army.newArmy command in Evony?",
        "How do I train archers?",
        "What is error code -3?",
        "What are the troop types in Evony?",
        "How does combat damage work?",
        "What is CastleBean?",
        "How do I write an AutoEvony script to train troops?",
        "What is the XOR encryption key?",
    ]
    
    model, tokenizer = load_model()
    
    print("\n" + "="*60)
    print("TESTING EVONY MODEL")
    print("="*60)
    
    for q in test_questions:
        print(f"\n{'='*60}")
        print(f"Q: {q}")
        print("-"*60)
        
        response = generate_response(model, tokenizer, q)
        print(f"A: {response}")
    
    print("\n" + "="*60)
    print("TESTS COMPLETE")
    print("="*60)


def interactive_mode():
    """Interactive chat mode"""
    
    model, tokenizer = load_model()
    
    print("\n" + "="*60)
    print("EVONY MODEL - INTERACTIVE MODE")
    print("Type 'quit' to exit")
    print("="*60)
    
    while True:
        print()
        question = input("You: ").strip()
        
        if question.lower() in ["quit", "exit", "q"]:
            break
        
        if not question:
            continue
        
        response = generate_response(model, tokenizer, question)
        print(f"\nEvony Expert: {response}")
    
    print("\nGoodbye!")


def main():
    import sys
    
    if len(sys.argv) > 1 and sys.argv[1] == "--interactive":
        interactive_mode()
    else:
        run_tests()


if __name__ == "__main__":
    main()
