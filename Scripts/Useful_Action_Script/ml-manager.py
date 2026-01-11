import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import Dataset, DataLoader
import numpy as np
from pathlib import Path
import json
import pickle
from transformers import AutoModel, AutoTokenizer
import os

class GameStateDataset(Dataset):
    def __init__(self, data_path, transform=None):
        self.data_path = Path(data_path)
        self.transform = transform
        self.data = []
        self.load_data()
        
    def load_data(self):
        """Load training data"""
        if self.data_path.exists():
            with open(self.data_path, 'rb') as f:
                self.data = pickle.load(f)
                
    def __len__(self):
        return len(self.data)
        
    def __getitem__(self, idx):
        item = self.data[idx]
        if self.transform:
            item = self.transform(item)
        return item

class GameStateAnalyzer(nn.Module):
    def __init__(self, input_size, hidden_size, num_classes):
        super(GameStateAnalyzer, self).__init__()
        self.features = nn.Sequential(
            nn.Linear(input_size, hidden_size),
            nn.ReLU(),
            nn.Dropout(0.5),
            nn.Linear(hidden_size, hidden_size // 2),
            nn.ReLU(),
            nn.Dropout(0.5),
            nn.Linear(hidden_size // 2, num_classes)
        )
        
    def forward(self, x):
        return self.features(x)

class MLManager:
    def __init__(self, model_dir="./models"):
        self.model_dir = Path(model_dir)
        self.model_dir.mkdir(parents=True, exist_ok=True)
        
        # Initialize models
        self.models = {}
        self.tokenizers = {}
        self.load_models()
        
    def load_models(self):
        """Load pre-trained models"""
        # Game state analyzer
        self.models['game_analyzer'] = GameStateAnalyzer(
            input_size=512,
            hidden_size=256,
            num_classes=10
        ).to(self.get_device())
        
        # Load language model for text analysis
        model_name = "bert-base-uncased"
        self.models['text_analyzer'] = AutoModel.from_pretrained(model_name)
        self.tokenizers['text_analyzer'] = AutoTokenizer.from_pretrained(model_name)
        
        # Load saved weights if available
        self.load_saved_weights()
        
    def load_saved_weights(self):
        """Load saved model weights"""
        for model_name in self.models:
            weight_path = self.model_dir / f"{model_name}.pth"
            if weight_path.exists():
                self.models[model_name].load_state_dict(
                    torch.load(weight_path, map_location=self.get_device())
                )
                
    def save_model_weights(self):
        """Save model weights"""
        for model_name, model in self.models.items():
            weight_path = self.model_dir / f"{model_name}.pth"
            torch.save(model.state_dict(), weight_path)
            
    def get_device(self):
        """Get appropriate device (GPU/CPU)"""
        return torch.device("cuda" if torch.cuda.is_available() else "cpu")
        
    def train_game_analyzer(self, train_data, epochs=10, batch_size=32):
        """Train game state analyzer"""
        model = self.models['game_analyzer']
        device = self.get_device()
        
        # Prepare data
        dataset = GameStateDataset(train_data)
        dataloader = DataLoader(dataset, batch_size=batch_size, shuffle=True)
        
        # Training setup
        criterion = nn.CrossEntropyLoss()
        optimizer = optim.Adam(model.parameters())
        
        # Training loop
        model.train()
        for epoch in range(epochs):
            running_loss = 0.0
            for i, data in enumerate(dataloader):
                inputs, labels = data[0].to(device), data[1].to(device)
                
                optimizer.zero_grad()
                outputs = model(inputs)
                loss = criterion(outputs, labels)
                loss.backward()
                optimizer.step()
                
                running_loss += loss.item()
                
            print(f'Epoch {epoch + 1}, Loss: {running_loss / len(dataloader)}')
            
        self.save_model_weights()
        
    def analyze_game_state(self, state_data):
        """Analyze game state using trained model"""
        model = self.models['game_analyzer']
        device = self.get_device()
        
        model.eval()
        with torch.no_grad():
            input_tensor = torch.FloatTensor(state_data).unsqueeze(0).to(device)
            output = model(input_tensor)
            return torch.softmax(output, dim=1).cpu().numpy()
            
    def analyze_text(self, text):
        """Analyze text using language model"""
        model = self.models['text_analyzer']
        tokenizer = self.tokenizers['text_analyzer']
        device = self.get_device()
        
        inputs = tokenizer(text, return_tensors="pt", padding=True, truncation=True)
        inputs = {k: v.to(device) for k, v in inputs.items()}
        
        model.eval()
        with torch.no_grad():
            outputs = model(**inputs)
            return outputs.last_hidden_state.mean(dim=1).cpu().numpy()
            
    def save_training_data(self, data, filename):
        """Save training data"""
        data_path = self.model_dir / "training_data" / filename
        data_path.parent.mkdir(parents=True, exist_ok=True)
        
        with open(data_path, 'wb') as f:
            pickle.dump(data, f)
            
    def load_training_data(self, filename):
        """Load training data"""
        data_path = self.model_dir / "training_data" / filename
        if data_path.exists():
            with open(data_path, 'rb') as f:
                return pickle.load(f)
        return None
        
    def cleanup(self):
        """Cleanup and save models"""
        self.save_model_weights()
        
# Example usage
if __name__ == "__main__":
    ml_manager = MLManager()
    
    # Example game state analysis
    sample_state = np.random.rand(512)  # Example game state vector
    analysis = ml_manager.analyze_game_state(sample_state)
    print("Game State Analysis:", analysis)
    
    # Example text analysis
    text = "Player is moving towards the objective"
    text_analysis = ml_manager.analyze_text(text)
    print("Text Analysis:", text_analysis.shape)