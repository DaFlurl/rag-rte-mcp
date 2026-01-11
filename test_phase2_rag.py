#!/usr/bin/env python3
"""
Quick test: Phase 2 model + RAG
"""

import torch
from transformers import AutoModelForCausalLM, AutoTokenizer, BitsAndBytesConfig

MODEL_PATH = "./phase3-3090"  # Phase 2 model

print("=" * 60)
print("🎮 EVONY PHASE 2 MODEL TEST")
print("=" * 60)

# Check GPU
if torch.cuda.is_available():
    print(f"✅ GPU: {torch.cuda.get_device_name(0)}")
else:
    print("⚠️ No GPU - using CPU (slow)")

print("\nLoading model...")

# 4-bit for memory
bnb_config = BitsAndBytesConfig(
    load_in_4bit=True,
    bnb_4bit_quant_type="nf4",
    bnb_4bit_compute_dtype=torch.float16,
)

tokenizer = AutoTokenizer.from_pretrained(MODEL_PATH)
model = AutoModelForCausalLM.from_pretrained(
    MODEL_PATH,
    quantization_config=bnb_config,
    device_map="auto",
    trust_remote_code=True,
)

print("✅ Model loaded!")

def ask(question, max_tokens=512):
    """Ask the model a question"""
    messages = [{"role": "user", "content": question}]
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
    
    response = tokenizer.decode(outputs[0], skip_special_tokens=True)
    # Extract assistant response
    if "assistant" in response.lower():
        response = response.split("assistant")[-1].strip()
    return response

print("\n" + "=" * 60)
print("💬 INTERACTIVE CHAT")
print("=" * 60)
print("Type your questions about Evony. Type 'quit' to exit.\n")

# Test questions
test_questions = [
    "What is the ACTION_KEY used for in Evony?",
    "How do I train troops in Evony using the protocol?",
    "What encryption does Evony use for client-server communication?",
]

print("Sample questions to try:")
for i, q in enumerate(test_questions, 1):
    print(f"  {i}. {q}")
print()

while True:
    try:
        question = input("You: ").strip()
        if question.lower() in ['quit', 'exit', 'q']:
            break
        if not question:
            continue
        
        print("\nThinking...")
        answer = ask(question)
        print(f"\n🤖 Assistant: {answer}\n")
        
    except KeyboardInterrupt:
        break

print("\nGoodbye!")
