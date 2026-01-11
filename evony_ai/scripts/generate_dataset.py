"""
Evony AI Dataset Generator
===========================
Generates instruction-following Q&A pairs from collected data.
"""

import os
import json
import random
from pathlib import Path
from typing import Dict, List, Tuple
from tqdm import tqdm

# Template categories for Q&A generation
TEMPLATES = {
    'protocol': [
        ("What is the AMF command to {action}?", "The command is `{command}`. {details}"),
        ("How do I send a {action} request in Evony?", "Use the `{command}` command with parameters: {params}"),
        ("Explain the {command} protocol command.", "{explanation}"),
        ("What parameters does {command} require?", "The {command} command requires: {params}"),
    ],
    'exploit': [
        ("How does the {exploit_name} glitch work?", "{explanation}"),
        ("What is the overflow threshold for {troop_type}?", "The overflow threshold for {troop_type} is {threshold:,}. This is calculated as INT32_MAX / food_cost + 1."),
        ("How can I exploit {feature}?", "{exploit_details}"),
        ("What are the known glitches for {category}?", "{glitch_list}"),
    ],
    'scripting': [
        ("Write an AutoEvony script to {task}.", "Here's the script:\n```\n{script}\n```"),
        ("How do I automate {action} in AutoEvony?", "You can use this script:\n```\n{script}\n```\n{explanation}"),
        ("What commands are available for {category}?", "Available commands:\n{command_list}"),
    ],
    'encryption': [
        ("What is the ACTION_KEY for Evony?", "The ACTION_KEY is: `{key}`"),
        ("How do I calculate the {signature_type} signature?", "{algorithm}"),
        ("What encryption does Evony use for {purpose}?", "{encryption_details}"),
    ],
    'game_mechanics': [
        ("How much food does a {troop_type} consume?", "A {troop_type} consumes {food_cost} food per hour."),
        ("What are the resource costs for {item}?", "{resource_breakdown}"),
        ("Explain {mechanic} in Evony.", "{explanation}"),
    ],
    'code_understanding': [
        ("What does the {class_name} class do in EvonyClient?", "{explanation}"),
        ("How does {function_name} work?", "{code_explanation}"),
        ("Explain this code:\n```\n{code_snippet}\n```", "{explanation}"),
    ]
}

# Evony-specific knowledge base for generating diverse Q&A
KNOWLEDGE_BASE = {
    'commands': {
        'troop.produceTroop': {
            'action': 'train troops',
            'params': 'castleId, positionId, troopType, num, isShare, toIdle',
            'explanation': 'This command initiates troop training at a specified building.'
        },
        'troop.disbandTroop': {
            'action': 'disband troops',
            'params': 'castleId, troopType, num',
            'explanation': 'Dismisses the specified number of troops of a given type.'
        },
        'army.newArmy': {
            'action': 'create a new army',
            'params': 'castleId, newArmyBean (hero, troops, mission, target)',
            'explanation': 'Creates a new army with specified composition and mission.'
        },
        'shop.buy': {
            'action': 'purchase an item',
            'params': 'itemId, amount',
            'explanation': 'Purchases items from the in-game shop.'
        },
        'common.mapInfo': {
            'action': 'get map information',
            'params': 'x, y',
            'explanation': 'Retrieves information about a specific map coordinate.'
        },
    },
    'troops': {
        'worker': {'food_cost': 50, 'threshold': 42949673},
        'warrior': {'food_cost': 75, 'threshold': 28633116},
        'scout': {'food_cost': 100, 'threshold': 21474837},
        'pikeman': {'food_cost': 200, 'threshold': 10737419},
        'swordsman': {'food_cost': 250, 'threshold': 8589935},
        'archer': {'food_cost': 350, 'threshold': 6135037},
        'cavalry': {'food_cost': 800, 'threshold': 2684355},
        'cataphract': {'food_cost': 1500, 'threshold': 1431656},
        'transporter': {'food_cost': 300, 'threshold': 7158279},
        'ballista': {'food_cost': 2000, 'threshold': 1073742},
        'ram': {'food_cost': 2500, 'threshold': 858994},
        'catapult': {'food_cost': 3000, 'threshold': 715828},
    },
    'keys': {
        'ACTION_KEY': 'TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}',
        'API_KEY': '9f758e2deccbe6244f734371b9642eda',
        'USER_INFO_KEY': 'IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}',
        'XOR_KEY': '0xAA',
    }
}


class DatasetGenerator:
    def __init__(self, raw_data_path: str, output_path: str):
        self.raw_data_path = Path(raw_data_path)
        self.output_path = Path(output_path)
        self.output_path.mkdir(parents=True, exist_ok=True)
        
        self.raw_data = []
        self.qa_pairs = []
        self.stats = {'total_qa': 0, 'by_category': {}}
    
    def load_raw_data(self):
        """Load collected raw data."""
        print("Loading raw data...")
        for data_file in sorted(self.raw_data_path.glob("raw_data_*.json")):
            with open(data_file, 'r', encoding='utf-8') as f:
                self.raw_data.extend(json.load(f))
        print(f"Loaded {len(self.raw_data)} records")
    
    def generate_from_knowledge_base(self):
        """Generate Q&A pairs from knowledge base."""
        print("\nGenerating from knowledge base...")
        
        # Command Q&A
        for cmd, info in KNOWLEDGE_BASE['commands'].items():
            self.qa_pairs.append({
                'category': 'protocol',
                'instruction': f"What is the AMF command to {info['action']}?",
                'response': f"The command is `{cmd}`. {info['explanation']}",
                'source': 'knowledge_base'
            })
            self.qa_pairs.append({
                'category': 'protocol',
                'instruction': f"What parameters does {cmd} require?",
                'response': f"The `{cmd}` command requires these parameters: {info['params']}",
                'source': 'knowledge_base'
            })
        
        # Troop Q&A
        for troop, info in KNOWLEDGE_BASE['troops'].items():
            self.qa_pairs.append({
                'category': 'game_mechanics',
                'instruction': f"How much food does a {troop} consume?",
                'response': f"A {troop} consumes {info['food_cost']} food per hour.",
                'source': 'knowledge_base'
            })
            self.qa_pairs.append({
                'category': 'exploit',
                'instruction': f"What is the overflow threshold for {troop}?",
                'response': f"The overflow threshold for {troop} is {info['threshold']:,}. This is calculated as INT32_MAX ({2147483647:,}) divided by the food cost ({info['food_cost']}) plus 1. Training more than this amount causes an integer overflow glitch.",
                'source': 'knowledge_base'
            })
        
        # Key Q&A
        for key_name, key_value in KNOWLEDGE_BASE['keys'].items():
            self.qa_pairs.append({
                'category': 'encryption',
                'instruction': f"What is the {key_name} for Evony?",
                'response': f"The {key_name} is: `{key_value}`",
                'source': 'knowledge_base'
            })
    
    def generate_from_source_code(self):
        """Generate Q&A pairs from source code files."""
        print("\nGenerating from source code...")
        
        for record in tqdm(self.raw_data, desc="Processing source code"):
            if 'source_code' not in record.get('categories', []):
                continue
            
            content = record.get('content', '')
            metadata = record.get('metadata', {})
            
            if not content or len(content) < 100:
                continue
            
            # Extract class/function names for AS3 files
            if metadata.get('extension') == '.as':
                self._process_actionscript(record)
            elif metadata.get('extension') == '.py':
                self._process_python(record)
    
    def _process_actionscript(self, record):
        """Extract Q&A from ActionScript files."""
        content = record['content']
        path = record['metadata']['path']
        
        # Extract class name
        import re
        class_match = re.search(r'public\s+class\s+(\w+)', content)
        if class_match:
            class_name = class_match.group(1)
            
            # Create explanation from file content
            functions = re.findall(r'public\s+function\s+(\w+)\s*\(', content)
            
            if functions:
                func_list = ', '.join(functions[:10])
                self.qa_pairs.append({
                    'category': 'code_understanding',
                    'instruction': f"What does the {class_name} class do in EvonyClient?",
                    'response': f"The `{class_name}` class is located at `{path}`. It contains the following public functions: {func_list}. This is part of the Evony Flash client implementation.",
                    'source': path
                })
    
    def _process_python(self, record):
        """Extract Q&A from Python files."""
        content = record['content']
        path = record['metadata']['path']
        
        # Look for docstrings
        import re
        docstring_match = re.search(r'"""(.+?)"""', content, re.DOTALL)
        
        if docstring_match:
            docstring = docstring_match.group(1).strip()[:500]
            filename = record['metadata']['filename']
            
            self.qa_pairs.append({
                'category': 'code_understanding',
                'instruction': f"What does {filename} do?",
                'response': docstring,
                'source': path
            })
    
    def generate_from_scripts(self):
        """Generate Q&A pairs from AutoEvony scripts."""
        print("\nGenerating from scripts...")
        
        for record in tqdm(self.raw_data, desc="Processing scripts"):
            if 'scripts' not in record.get('categories', []):
                continue
            
            content = record.get('content', '')
            metadata = record.get('metadata', {})
            
            if not content or len(content) < 50:
                continue
            
            filename = metadata.get('filename', '')
            
            # Skip if not an actual script
            if not any(kw in filename.lower() for kw in ['script', 'glitch', 'attack', 'troop', 'quest']):
                continue
            
            # Create Q&A about the script
            script_preview = content[:1000] if len(content) > 1000 else content
            
            self.qa_pairs.append({
                'category': 'scripting',
                'instruction': f"Show me the {filename.replace('.txt', '')} AutoEvony script.",
                'response': f"Here's the script:\n```\n{script_preview}\n```",
                'source': metadata['path']
            })
    
    def generate_from_documentation(self):
        """Generate Q&A pairs from documentation files."""
        print("\nGenerating from documentation...")
        
        for record in tqdm(self.raw_data, desc="Processing documentation"):
            if 'documentation' not in record.get('categories', []):
                continue
            
            content = record.get('content', '')
            metadata = record.get('metadata', {})
            
            if not content or len(content) < 200:
                continue
            
            # Extract sections from markdown
            import re
            sections = re.split(r'^##\s+', content, flags=re.MULTILINE)
            
            for section in sections[1:]:  # Skip first (before any ##)
                lines = section.split('\n')
                if not lines:
                    continue
                
                title = lines[0].strip()
                body = '\n'.join(lines[1:]).strip()[:1500]
                
                if len(body) > 100:
                    self.qa_pairs.append({
                        'category': 'documentation',
                        'instruction': f"Explain {title} in Evony.",
                        'response': body,
                        'source': metadata['path']
                    })
    
    def format_for_training(self):
        """Format Q&A pairs for model training."""
        print("\nFormatting for training...")
        
        training_data = []
        
        for qa in self.qa_pairs:
            # Alpaca format
            training_data.append({
                'instruction': qa['instruction'],
                'input': '',
                'output': qa['response'],
                'category': qa['category'],
                'source': qa.get('source', 'generated')
            })
        
        # Shuffle
        random.shuffle(training_data)
        
        # Split into train/val
        split_idx = int(len(training_data) * 0.9)
        train_data = training_data[:split_idx]
        val_data = training_data[split_idx:]
        
        # Save
        train_file = self.output_path / "train.json"
        val_file = self.output_path / "val.json"
        
        with open(train_file, 'w', encoding='utf-8') as f:
            json.dump(train_data, f, indent=2, ensure_ascii=False)
        
        with open(val_file, 'w', encoding='utf-8') as f:
            json.dump(val_data, f, indent=2, ensure_ascii=False)
        
        print(f"Saved {len(train_data)} training samples")
        print(f"Saved {len(val_data)} validation samples")
        
        # Update stats
        self.stats['total_qa'] = len(training_data)
        for qa in training_data:
            cat = qa['category']
            self.stats['by_category'][cat] = self.stats['by_category'].get(cat, 0) + 1
    
    def generate_all(self):
        """Run full dataset generation pipeline."""
        print(f"\n{'='*60}")
        print("EVONY AI DATASET GENERATOR")
        print(f"{'='*60}\n")
        
        self.load_raw_data()
        self.generate_from_knowledge_base()
        self.generate_from_source_code()
        self.generate_from_scripts()
        self.generate_from_documentation()
        self.format_for_training()
        
        print(f"\n{'='*60}")
        print("GENERATION SUMMARY")
        print(f"{'='*60}")
        print(f"Total Q&A pairs: {self.stats['total_qa']:,}")
        print("\nBy category:")
        for cat, count in sorted(self.stats['by_category'].items(), key=lambda x: -x[1]):
            print(f"  {cat:20s}: {count:,}")
        print(f"{'='*60}\n")


def main():
    raw_data_path = Path(__file__).parent.parent / "data" / "raw"
    output_path = Path(__file__).parent.parent / "data" / "training"
    
    generator = DatasetGenerator(str(raw_data_path), str(output_path))
    generator.generate_all()
    
    print("Dataset generation complete!")
    print(f"Output saved to: {output_path}")


if __name__ == "__main__":
    main()
