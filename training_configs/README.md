# Evony Knowledge Model Training Configuration

## Overview
This directory contains configuration files for fine-tuning language models on the Evony Knowledge Dataset.

## Supported Frameworks

### 1. HuggingFace Transformers
```bash
pip install -r requirements.txt
python train_huggingface.py
```

### 2. Axolotl
```bash
pip install axolotl
accelerate launch -m axolotl.cli.train axolotl_config.yaml
```

### 3. LLaMA-Factory
```bash
git clone https://github.com/hiyouga/LLaMA-Factory
cd LLaMA-Factory
pip install -e .
llamafactory-cli train llama_factory_config.yaml
```

## Dataset
- **Location**: `../Evony_Training_Data/evony_final_5k.json`
- **Format**: Alpaca (instruction, input, output)
- **Examples**: 5,001+
- **Topics**: Protocol commands, beans, game mechanics, scripting, security

## Hardware Requirements
| Config | VRAM | GPU Examples |
|--------|------|--------------|
| QLoRA 4-bit | 16GB | RTX 3090, RTX 4080 |
| LoRA 8-bit | 24GB | RTX 4090, A5000 |
| Full Fine-tune | 48GB+ | A100, H100 |

## Training Time Estimates
| Dataset Size | Epochs | Time (RTX 4090) |
|--------------|--------|-----------------|
| 5,000 | 3 | ~2 hours |
| 10,000 | 3 | ~4 hours |
| 20,000 | 3 | ~8 hours |

## Output
Models are saved to `./evony_model_output/` with:
- `adapter_model.safetensors` - LoRA weights
- `adapter_config.json` - LoRA config
- `tokenizer.json` - Tokenizer

## Inference
```python
from peft import PeftModel
from transformers import AutoModelForCausalLM, AutoTokenizer

base = AutoModelForCausalLM.from_pretrained("mistralai/Mistral-7B-Instruct-v0.2")
model = PeftModel.from_pretrained(base, "./evony_model_output")
tokenizer = AutoTokenizer.from_pretrained("./evony_model_output")

prompt = "What is the army.newArmy command in Evony?"
inputs = tokenizer(prompt, return_tensors="pt")
outputs = model.generate(**inputs, max_new_tokens=256)
print(tokenizer.decode(outputs[0]))
```
