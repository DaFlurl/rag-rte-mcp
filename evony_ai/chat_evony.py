"""
Evony AI - Chat Interface
==========================
Interactive chat with your trained Evony AI model.
"""

import torch
from pathlib import Path

from unsloth import FastLanguageModel

# Configuration
MODEL_PATH = Path("c:/Users/Admin/Downloads/Evony_Decrypted/evony_ai/output/final_model")
BASE_MODEL = "unsloth/Qwen2.5-3B-Instruct"
MAX_SEQ_LENGTH = 2048


def load_model():
    """Load the trained model."""
    print("Loading Evony AI model...")
    
    if MODEL_PATH.exists():
        # Load fine-tuned model
        model, tokenizer = FastLanguageModel.from_pretrained(
            model_name=str(MODEL_PATH),
            max_seq_length=MAX_SEQ_LENGTH,
            dtype=None,
            load_in_4bit=True,
        )
        print(f"Loaded fine-tuned model from: {MODEL_PATH}")
    else:
        # Load base model (for testing before training)
        model, tokenizer = FastLanguageModel.from_pretrained(
            model_name=BASE_MODEL,
            max_seq_length=MAX_SEQ_LENGTH,
            dtype=None,
            load_in_4bit=True,
        )
        print(f"Loaded base model: {BASE_MODEL}")
        print("(Fine-tuned model not found - run training first)")
    
    # Enable inference mode
    FastLanguageModel.for_inference(model)
    
    return model, tokenizer


def generate_response(model, tokenizer, question: str) -> str:
    """Generate response to a question."""
    prompt = f"""### Instruction:
{question}

### Response:
"""
    
    inputs = tokenizer(prompt, return_tensors="pt").to("cuda")
    
    with torch.no_grad():
        outputs = model.generate(
            **inputs,
            max_new_tokens=512,
            temperature=0.7,
            top_p=0.9,
            do_sample=True,
            pad_token_id=tokenizer.eos_token_id,
        )
    
    response = tokenizer.decode(outputs[0], skip_special_tokens=True)
    
    # Extract just the response part
    if "### Response:" in response:
        response = response.split("### Response:")[-1].strip()
    
    return response


def chat():
    """Interactive chat loop."""
    print("\n" + "="*60)
    print("EVONY AI - CHAT INTERFACE")
    print("="*60)
    print("Ask questions about Evony protocols, exploits, code, etc.")
    print("Type 'quit' to exit.\n")
    
    model, tokenizer = load_model()
    
    while True:
        try:
            question = input("\n[You]: ").strip()
            
            if not question:
                continue
            
            if question.lower() in ['quit', 'exit', 'q']:
                print("Goodbye!")
                break
            
            print("\n[Evony AI]: ", end="", flush=True)
            response = generate_response(model, tokenizer, question)
            print(response)
            
        except KeyboardInterrupt:
            print("\n\nGoodbye!")
            break
        except Exception as e:
            print(f"\nError: {e}")


def main():
    chat()


if __name__ == "__main__":
    main()
