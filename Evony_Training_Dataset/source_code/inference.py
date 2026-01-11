"""
Evony AI Inference Script
==========================
Run inference with the trained Evony assistant model.
"""

import argparse
import torch
from pathlib import Path
from transformers import AutoModelForCausalLM, AutoTokenizer, BitsAndBytesConfig
from peft import PeftModel
from rich.console import Console
from rich.markdown import Markdown
from rich.panel import Panel

console = Console()


class EvonyAssistant:
    def __init__(self, model_path: str, base_model: str = None):
        self.model_path = Path(model_path)
        self.base_model = base_model
        self.model = None
        self.tokenizer = None
        self.device = "cuda" if torch.cuda.is_available() else "cpu"
    
    def load(self):
        """Load the trained model."""
        console.print(f"\n[bold cyan]Loading Evony Assistant...[/]")
        console.print(f"Model path: {self.model_path}")
        console.print(f"Device: {self.device}")
        
        # Check if this is a LoRA adapter or full model
        adapter_config = self.model_path / "adapter_config.json"
        
        if adapter_config.exists() and self.base_model:
            # Load base model with LoRA adapter
            console.print("Loading base model with LoRA adapter...")
            
            bnb_config = BitsAndBytesConfig(
                load_in_4bit=True,
                bnb_4bit_quant_type="nf4",
                bnb_4bit_compute_dtype=torch.bfloat16,
                bnb_4bit_use_double_quant=True,
            )
            
            base = AutoModelForCausalLM.from_pretrained(
                self.base_model,
                quantization_config=bnb_config,
                device_map="auto",
                trust_remote_code=True,
            )
            
            self.model = PeftModel.from_pretrained(base, str(self.model_path))
            self.tokenizer = AutoTokenizer.from_pretrained(self.base_model, trust_remote_code=True)
        else:
            # Load full model or merged model
            console.print("Loading model...")
            
            self.model = AutoModelForCausalLM.from_pretrained(
                str(self.model_path),
                device_map="auto",
                trust_remote_code=True,
                torch_dtype=torch.bfloat16,
            )
            self.tokenizer = AutoTokenizer.from_pretrained(str(self.model_path), trust_remote_code=True)
        
        if self.tokenizer.pad_token is None:
            self.tokenizer.pad_token = self.tokenizer.eos_token
        
        self.model.eval()
        console.print("[bold green]Model loaded successfully![/]")
    
    def generate(self, instruction: str, max_tokens: int = 512, temperature: float = 0.7) -> str:
        """Generate response for an instruction."""
        prompt = f"""### Instruction:
{instruction}

### Response:
"""
        
        inputs = self.tokenizer(prompt, return_tensors="pt").to(self.device)
        
        with torch.no_grad():
            outputs = self.model.generate(
                **inputs,
                max_new_tokens=max_tokens,
                temperature=temperature,
                top_p=0.9,
                do_sample=True,
                pad_token_id=self.tokenizer.pad_token_id,
                eos_token_id=self.tokenizer.eos_token_id,
            )
        
        response = self.tokenizer.decode(outputs[0], skip_special_tokens=True)
        
        # Extract just the response part
        if "### Response:" in response:
            response = response.split("### Response:")[-1].strip()
        
        return response
    
    def chat(self):
        """Interactive chat mode."""
        console.print("\n" + "="*60)
        console.print(Panel.fit(
            "[bold magenta]EVONY AI ASSISTANT[/]\n"
            "Ask questions about Evony protocols, exploits, scripts, and more!\n"
            "Type 'quit' or 'exit' to end the session.",
            title="Welcome"
        ))
        console.print("="*60 + "\n")
        
        while True:
            try:
                user_input = console.input("[bold green]You:[/] ")
                
                if user_input.lower() in ['quit', 'exit', 'q']:
                    console.print("\n[bold cyan]Goodbye![/]")
                    break
                
                if not user_input.strip():
                    continue
                
                console.print("\n[bold cyan]Evony AI:[/]")
                with console.status("[bold yellow]Thinking...[/]"):
                    response = self.generate(user_input)
                
                console.print(Markdown(response))
                console.print()
                
            except KeyboardInterrupt:
                console.print("\n\n[bold cyan]Session interrupted. Goodbye![/]")
                break


def main():
    parser = argparse.ArgumentParser(description="Evony AI Inference")
    parser.add_argument("--model", type=str, required=True, help="Path to trained model")
    parser.add_argument("--base-model", type=str, default="Qwen/Qwen2.5-3B-Instruct", 
                        help="Base model (for LoRA adapters)")
    parser.add_argument("--query", type=str, help="Single query mode")
    parser.add_argument("--max-tokens", type=int, default=512, help="Max tokens to generate")
    parser.add_argument("--temperature", type=float, default=0.7, help="Sampling temperature")
    
    args = parser.parse_args()
    
    assistant = EvonyAssistant(args.model, args.base_model)
    assistant.load()
    
    if args.query:
        # Single query mode
        response = assistant.generate(args.query, args.max_tokens, args.temperature)
        console.print(f"\n[bold cyan]Response:[/]\n{response}")
    else:
        # Interactive chat mode
        assistant.chat()


if __name__ == "__main__":
    main()
