"""
Evony Training Data Generator
==============================
Converts curated dataset files into instruction/response pairs
suitable for LLM fine-tuning (Alpaca format).
"""

import os
import json
import re
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Tuple
import random

from .config import HUB_ROOT


class TrainingDataGenerator:
    """Generates instruction/response training pairs from curated dataset."""
    
    # Question templates by content type
    TEMPLATES = {
        'source_code': [
            ("What does the {name} class/function do in Evony?", "explain"),
            ("Explain this Evony code:\n```\n{preview}\n```", "explain"),
            ("How does {name} work in the Evony client?", "explain"),
            ("What parameters does {name} accept?", "params"),
            ("Show me an example of using {name} in Evony", "example"),
        ],
        'protocol': [
            ("What is the {name} command in Evony's protocol?", "explain"),
            ("How do I send a {name} request to the Evony server?", "howto"),
            ("What parameters are needed for the {name} AMF command?", "params"),
            ("Explain the Evony protocol for {name}", "explain"),
        ],
        'exploits': [
            ("How does the {name} exploit work in Evony?", "explain"),
            ("What is the integer overflow glitch for troops in Evony?", "explain"),
            ("Explain the {name} vulnerability in Evony", "explain"),
            ("How can I use the {name} glitch?", "howto"),
        ],
        'scripts': [
            ("What does this Evony bot script do?\n{preview}", "explain"),
            ("How do I automate {name} in Evony?", "howto"),
            ("Create a script to {name} in Evony", "create"),
        ],
        'keys': [
            ("What is the {name} encryption key used for in Evony?", "explain"),
            ("How does Evony encrypt {name}?", "explain"),
            ("What hashing algorithm does Evony use for {name}?", "explain"),
        ],
        'documentation': [
            ("Explain {name} in Evony", "explain"),
            ("What does the documentation say about {name}?", "explain"),
            ("How does {name} work according to the Evony docs?", "explain"),
        ],
    }
    
    def __init__(self, dataset_path: Path = None):
        self.dataset_path = dataset_path or (HUB_ROOT / "Evony_Training_Dataset")
        self.output_path = HUB_ROOT / "Evony_Training_Data"
        
        self.training_pairs: List[dict] = []
        self.stats = {
            'files_processed': 0,
            'pairs_generated': 0,
            'by_category': {},
        }
    
    def _read_file(self, path: Path) -> str:
        """Read file content."""
        try:
            with open(path, 'r', encoding='utf-8', errors='replace') as f:
                return f.read()
        except:
            return ""
    
    def _extract_code_elements(self, content: str, ext: str) -> List[dict]:
        """Extract functions, classes, and key elements from code."""
        elements = []
        
        if ext == '.as':
            # ActionScript class
            class_match = re.search(r'class\s+(\w+)', content)
            if class_match:
                elements.append({
                    'type': 'class',
                    'name': class_match.group(1),
                    'content': content[:2000],
                })
            
            # ActionScript functions
            func_matches = re.finditer(
                r'(public|private|protected)?\s*function\s+(\w+)\s*\([^)]*\)',
                content
            )
            for match in func_matches:
                func_name = match.group(2)
                start = match.start()
                # Get function body (approximate)
                end = min(start + 500, len(content))
                elements.append({
                    'type': 'function',
                    'name': func_name,
                    'content': content[start:end],
                })
        
        elif ext == '.py':
            # Python class
            class_matches = re.finditer(r'class\s+(\w+)', content)
            for match in class_matches:
                elements.append({
                    'type': 'class',
                    'name': match.group(1),
                    'content': content[match.start():match.start()+1000],
                })
            
            # Python functions
            func_matches = re.finditer(r'def\s+(\w+)\s*\([^)]*\):', content)
            for match in func_matches:
                func_name = match.group(1)
                if not func_name.startswith('_'):
                    start = match.start()
                    end = min(start + 400, len(content))
                    elements.append({
                        'type': 'function',
                        'name': func_name,
                        'content': content[start:end],
                    })
        
        return elements[:10]  # Limit elements per file
    
    def _extract_protocol_commands(self, content: str) -> List[dict]:
        """Extract protocol commands from content."""
        commands = []
        
        # Match patterns like: command.action or 'command.action'
        cmd_matches = re.finditer(
            r'["\']?(\w+\.\w+)["\']?\s*[:|,\s]',
            content
        )
        
        seen = set()
        for match in cmd_matches:
            cmd = match.group(1)
            if cmd not in seen and '.' in cmd:
                seen.add(cmd)
                # Get surrounding context
                start = max(0, match.start() - 100)
                end = min(len(content), match.end() + 200)
                commands.append({
                    'type': 'command',
                    'name': cmd,
                    'content': content[start:end],
                })
        
        return commands[:15]
    
    def _extract_key_info(self, content: str) -> List[dict]:
        """Extract encryption keys and constants."""
        keys = []
        
        # Match KEY = "value" patterns
        key_matches = re.finditer(
            r'(\w*KEY\w*|\w*SECRET\w*|\w*SALT\w*)\s*[=:]\s*["\']([^"\']+)["\']',
            content, re.IGNORECASE
        )
        
        for match in key_matches:
            keys.append({
                'type': 'key',
                'name': match.group(1),
                'value': match.group(2),
                'content': content[max(0, match.start()-50):match.end()+50],
            })
        
        return keys
    
    def _generate_pairs_from_code(self, path: Path, content: str, category: str) -> List[dict]:
        """Generate Q&A pairs from code file."""
        pairs = []
        ext = path.suffix.lower()
        filename = path.stem
        
        # File-level question
        pairs.append({
            'instruction': f"What is the purpose of {path.name} in Evony?",
            'input': "",
            'output': f"The file `{path.name}` is part of the Evony game system. Here's what it contains:\n\n```{ext[1:]}\n{content[:1500]}\n```\n\nThis code handles {category} functionality in the Evony client/bot system.",
            'category': category,
        })
        
        # Extract and generate from code elements
        elements = self._extract_code_elements(content, ext)
        templates = self.TEMPLATES.get(category, self.TEMPLATES['source_code'])
        
        for element in elements[:5]:
            template = random.choice(templates)
            question = template[0].format(
                name=element['name'],
                preview=element['content'][:300]
            )
            
            pairs.append({
                'instruction': question,
                'input': "",
                'output': f"The `{element['name']}` {element['type']} in Evony:\n\n```{ext[1:]}\n{element['content']}\n```\n\nThis {element['type']} is used for {category} operations in the Evony system.",
                'category': category,
            })
        
        return pairs
    
    def _generate_pairs_from_protocol(self, path: Path, content: str) -> List[dict]:
        """Generate Q&A pairs from protocol documentation."""
        pairs = []
        
        commands = self._extract_protocol_commands(content)
        
        for cmd in commands[:10]:
            pairs.append({
                'instruction': f"How do I use the {cmd['name']} command in Evony?",
                'input': "",
                'output': f"The `{cmd['name']}` command is part of Evony's AMF protocol. Here's the context:\n\n```\n{cmd['content']}\n```\n\nTo use this command, send an AMF request to the game server with the appropriate parameters.",
                'category': 'protocol',
            })
        
        return pairs
    
    def _generate_pairs_from_keys(self, path: Path, content: str) -> List[dict]:
        """Generate Q&A pairs from encryption keys."""
        pairs = []
        
        keys = self._extract_key_info(content)
        
        for key in keys:
            pairs.append({
                'instruction': f"What is the {key['name']} used for in Evony?",
                'input': "",
                'output': f"The `{key['name']}` in Evony is an encryption/authentication constant:\n\n```\n{key['name']} = \"{key['value']}\"\n```\n\nThis key is used for secure communication between the client and server, specifically for {key['name'].lower().replace('_', ' ')} operations.",
                'category': 'keys',
            })
        
        return pairs
    
    def _generate_pairs_from_doc(self, path: Path, content: str) -> List[dict]:
        """Generate Q&A pairs from documentation."""
        pairs = []
        
        # Extract headers and sections
        headers = re.finditer(r'^#+\s+(.+)$', content, re.MULTILINE)
        
        for match in headers:
            header = match.group(1)
            start = match.end()
            # Get section content
            next_header = re.search(r'^#+\s+', content[start:], re.MULTILINE)
            end = start + (next_header.start() if next_header else 1000)
            section = content[start:end].strip()[:800]
            
            if len(section) > 50:
                pairs.append({
                    'instruction': f"Explain {header} in Evony",
                    'input': "",
                    'output': f"## {header}\n\n{section}",
                    'category': 'documentation',
                })
        
        return pairs[:10]
    
    def process_file(self, path: Path, category: str) -> List[dict]:
        """Process a single file and generate training pairs."""
        content = self._read_file(path)
        if len(content) < 50:
            return []
        
        pairs = []
        
        if category in ['source_code', 'tools']:
            pairs.extend(self._generate_pairs_from_code(path, content, category))
        elif category == 'protocol':
            pairs.extend(self._generate_pairs_from_protocol(path, content))
        elif category == 'keys':
            pairs.extend(self._generate_pairs_from_keys(path, content))
        elif category == 'documentation':
            pairs.extend(self._generate_pairs_from_doc(path, content))
        elif category == 'exploits':
            pairs.extend(self._generate_pairs_from_code(path, content, 'exploits'))
        elif category == 'scripts':
            # Simple script explanation
            pairs.append({
                'instruction': f"What does this Evony script do?\n```\n{content[:500]}\n```",
                'input': "",
                'output': f"This Evony bot script from `{path.name}` performs automation tasks. The script:\n\n```\n{content[:1000]}\n```\n\nIt automates game actions using the AutoEvony/RoboEvony scripting system.",
                'category': 'scripts',
            })
        
        return pairs
    
    def process_dataset(self):
        """Process all files in the curated dataset."""
        print("\n" + "="*60)
        print("GENERATING TRAINING DATA")
        print("="*60)
        
        for category_dir in self.dataset_path.iterdir():
            if not category_dir.is_dir():
                continue
            if category_dir.name in ['manifest.json', 'README.md']:
                continue
            
            category = category_dir.name
            print(f"\nProcessing {category}...")
            
            files = list(category_dir.glob('*'))
            for path in files:
                if not path.is_file():
                    continue
                
                pairs = self.process_file(path, category)
                self.training_pairs.extend(pairs)
                
                self.stats['files_processed'] += 1
                self.stats['by_category'][category] = \
                    self.stats['by_category'].get(category, 0) + len(pairs)
            
            print(f"  Generated {self.stats['by_category'].get(category, 0)} pairs")
        
        self.stats['pairs_generated'] = len(self.training_pairs)
        print(f"\nTotal pairs generated: {self.stats['pairs_generated']}")
    
    def save_training_data(self):
        """Save training data in multiple formats."""
        self.output_path.mkdir(parents=True, exist_ok=True)
        
        # Shuffle pairs
        random.shuffle(self.training_pairs)
        
        # Split train/val (90/10)
        split_idx = int(len(self.training_pairs) * 0.9)
        train_data = self.training_pairs[:split_idx]
        val_data = self.training_pairs[split_idx:]
        
        # Save Alpaca format (JSON)
        train_path = self.output_path / "train.json"
        with open(train_path, 'w', encoding='utf-8') as f:
            json.dump(train_data, f, indent=2, ensure_ascii=False)
        
        val_path = self.output_path / "val.json"
        with open(val_path, 'w', encoding='utf-8') as f:
            json.dump(val_data, f, indent=2, ensure_ascii=False)
        
        # Save JSONL format (for some training frameworks)
        train_jsonl = self.output_path / "train.jsonl"
        with open(train_jsonl, 'w', encoding='utf-8') as f:
            for item in train_data:
                f.write(json.dumps(item, ensure_ascii=False) + '\n')
        
        val_jsonl = self.output_path / "val.jsonl"
        with open(val_jsonl, 'w', encoding='utf-8') as f:
            for item in val_data:
                f.write(json.dumps(item, ensure_ascii=False) + '\n')
        
        # Save stats
        stats_path = self.output_path / "stats.json"
        with open(stats_path, 'w', encoding='utf-8') as f:
            json.dump({
                **self.stats,
                'train_size': len(train_data),
                'val_size': len(val_data),
                'generated': datetime.now().isoformat(),
            }, f, indent=2)
        
        print(f"\nSaved training data to: {self.output_path}")
        print(f"  train.json: {len(train_data)} examples")
        print(f"  val.json: {len(val_data)} examples")
    
    def generate_readme(self):
        """Generate README for training data."""
        readme = f"""# Evony Training Data

**Generated**: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}

## Summary

| Metric | Value |
|--------|-------|
| Total Examples | {self.stats['pairs_generated']:,} |
| Training Set | {int(self.stats['pairs_generated'] * 0.9):,} |
| Validation Set | {int(self.stats['pairs_generated'] * 0.1):,} |
| Files Processed | {self.stats['files_processed']:,} |

## Examples by Category

| Category | Examples |
|----------|----------|
"""
        for cat, count in sorted(self.stats['by_category'].items(), key=lambda x: -x[1]):
            readme += f"| {cat} | {count:,} |\n"
        
        readme += """
## Format

Each example is in Alpaca format:
```json
{
  "instruction": "Question about Evony",
  "input": "",
  "output": "Detailed answer with code examples",
  "category": "source_code"
}
```

## Files

- `train.json` - Training set (90%)
- `val.json` - Validation set (10%)
- `train.jsonl` - JSONL format for some frameworks
- `val.jsonl` - JSONL validation
- `stats.json` - Generation statistics

## Usage

### With Hugging Face Transformers
```python
from datasets import load_dataset
dataset = load_dataset('json', data_files={
    'train': 'train.json',
    'validation': 'val.json'
})
```

### With Axolotl
```yaml
datasets:
  - path: ./Evony_Training_Data/train.json
    type: alpaca
```
"""
        
        readme_path = self.output_path / "README.md"
        with open(readme_path, 'w', encoding='utf-8') as f:
            f.write(readme)
    
    def print_summary(self):
        """Print generation summary."""
        print("\n" + "="*60)
        print("TRAINING DATA GENERATION COMPLETE")
        print("="*60)
        print(f"\nOutput: {self.output_path}")
        print(f"Total examples: {self.stats['pairs_generated']:,}")
        print(f"Files processed: {self.stats['files_processed']:,}")
        
        print(f"\nBy Category:")
        for cat, count in sorted(self.stats['by_category'].items(), key=lambda x: -x[1]):
            print(f"  {cat:15s}: {count:,}")
        
        print(f"\n{'='*60}\n")
    
    def generate(self):
        """Run full generation pipeline."""
        self.process_dataset()
        self.save_training_data()
        self.generate_readme()
        self.print_summary()
        return self.stats


def generate_training_data():
    """Generate training data from curated dataset."""
    generator = TrainingDataGenerator()
    return generator.generate()


if __name__ == "__main__":
    generate_training_data()
