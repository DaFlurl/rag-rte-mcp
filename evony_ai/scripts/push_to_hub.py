"""
Push Evony AI Dataset/Model to HuggingFace Hub
===============================================
Upload dataset for cloud training or share your trained model.
"""

import os
import argparse
from pathlib import Path
from huggingface_hub import HfApi, create_repo, upload_folder
from datasets import load_dataset
from rich.console import Console

console = Console()


def push_dataset(data_path: str, repo_name: str, private: bool = True):
    """Push training dataset to HuggingFace Hub."""
    console.print(f"\n[bold cyan]Pushing dataset to HuggingFace Hub...[/]")
    console.print(f"Dataset path: {data_path}")
    console.print(f"Repository: {repo_name}")
    
    data_path = Path(data_path)
    train_file = data_path / "train.json"
    val_file = data_path / "val.json"
    
    if not train_file.exists():
        console.print(f"[bold red]ERROR: Training data not found at {train_file}[/]")
        return
    
    # Load dataset
    dataset = load_dataset(
        'json',
        data_files={
            'train': str(train_file),
            'validation': str(val_file) if val_file.exists() else str(train_file)
        }
    )
    
    # Push to hub
    dataset.push_to_hub(repo_name, private=private)
    
    console.print(f"[bold green]Dataset pushed successfully![/]")
    console.print(f"View at: https://huggingface.co/datasets/{repo_name}")


def push_model(model_path: str, repo_name: str, private: bool = True):
    """Push trained model to HuggingFace Hub."""
    console.print(f"\n[bold cyan]Pushing model to HuggingFace Hub...[/]")
    console.print(f"Model path: {model_path}")
    console.print(f"Repository: {repo_name}")
    
    model_path = Path(model_path)
    
    if not model_path.exists():
        console.print(f"[bold red]ERROR: Model not found at {model_path}[/]")
        return
    
    api = HfApi()
    
    # Create repo if it doesn't exist
    try:
        create_repo(repo_name, private=private, exist_ok=True)
    except Exception as e:
        console.print(f"[yellow]Note: {e}[/]")
    
    # Upload
    upload_folder(
        folder_path=str(model_path),
        repo_id=repo_name,
        repo_type="model",
    )
    
    console.print(f"[bold green]Model pushed successfully![/]")
    console.print(f"View at: https://huggingface.co/{repo_name}")


def main():
    parser = argparse.ArgumentParser(description="Push Evony AI to HuggingFace Hub")
    parser.add_argument("--type", choices=["dataset", "model"], required=True,
                        help="What to push: dataset or model")
    parser.add_argument("--path", type=str, required=True,
                        help="Path to dataset or model")
    parser.add_argument("--repo", type=str, required=True,
                        help="HuggingFace repo name (e.g., username/evony-ai)")
    parser.add_argument("--public", action="store_true",
                        help="Make the repository public")
    
    args = parser.parse_args()
    
    # Check for HF token
    if not os.environ.get("HF_TOKEN") and not os.path.exists(Path.home() / ".huggingface" / "token"):
        console.print("[bold yellow]Note: You may need to login first:[/]")
        console.print("  huggingface-cli login")
        console.print()
    
    if args.type == "dataset":
        push_dataset(args.path, args.repo, private=not args.public)
    else:
        push_model(args.path, args.repo, private=not args.public)


if __name__ == "__main__":
    main()
