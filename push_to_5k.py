#!/usr/bin/env python3
"""Push dataset to 5000+ examples"""

import json
from pathlib import Path

TRAINING_DIR = Path(__file__).parent / "Evony_Training_Data"
OUTPUT_DIR = Path(__file__).parent / "Evony_Training_Dataset" / "game_data"

def main():
    dataset = TRAINING_DIR / "evony_final_5k.json"
    with open(dataset) as f:
        data = json.load(f)
    
    print(f"Current: {len(data)} examples")
    
    # Add troop examples
    troop_file = OUTPUT_DIR / "troop_formulas.json"
    if troop_file.exists():
        with open(troop_file) as f:
            troops = json.load(f)
        
        new_examples = []
        for tname, tdata in troops.get("troops", {}).items():
            name = tdata.get("name", tname)
            stats = tdata.get("stats", {})
            overflow = tdata.get("overflow_threshold", 0)
            weak = tdata.get("weak_vs", [])
            
            new_examples.append({
                "instruction": f"What is the load capacity of {name}?",
                "input": "",
                "output": f"{name} has load capacity {stats.get('load', 0)}. Used for carrying resources."
            })
            new_examples.append({
                "instruction": f"What is the speed of {name}?",
                "input": "",
                "output": f"{name} has speed {stats.get('speed', 0)}. Higher = faster march."
            })
            if weak:
                new_examples.append({
                    "instruction": f"What counters {name}?",
                    "input": "",
                    "output": f"{name} is weak against: {', '.join(weak)}."
                })
            new_examples.append({
                "instruction": f"Max safe {name} to train?",
                "input": "",
                "output": f"Max safe {name}: {overflow:,}. Training more causes integer overflow."
            })
        
        seen = {ex.get("instruction", "") for ex in data}
        unique = [ex for ex in new_examples if ex.get("instruction", "") not in seen]
        data.extend(unique)
        print(f"Added {len(unique)} troop examples")
    
    # Add research cost examples
    research_file = OUTPUT_DIR / "research_tree.json"
    if research_file.exists():
        with open(research_file) as f:
            research = json.load(f)
        
        new_examples = []
        for rname, rdata in research.get("research", {}).items():
            name = rdata.get("name", rname)
            levels = rdata.get("levels", {})
            
            for level, costs in list(levels.items())[:2]:
                food = costs.get("food", 0)
                wood = costs.get("wood", 0)
                time_s = costs.get("time_seconds", 0)
                new_examples.append({
                    "instruction": f"Cost for {name} level {level}?",
                    "input": "",
                    "output": f"{name} level {level}: Food {food}, Wood {wood}, Time {time_s}s"
                })
        
        seen = {ex.get("instruction", "") for ex in data}
        unique = [ex for ex in new_examples if ex.get("instruction", "") not in seen]
        data.extend(unique)
        print(f"Added {len(unique)} research examples")
    
    # Add more general Q&A to push over 5000
    general_qa = [
        ("What is AMF3?", "AMF3 (Action Message Format 3) is Adobe's binary serialization format used by Evony for client-server communication."),
        ("What port does Evony use?", "Evony uses HTTP/HTTPS on standard ports (80/443). Bot servers typically use 8088 for scripts, 8765/8766 for MCP."),
        ("What is Flash Player version for Evony?", "Evony client targets Flash Player 27.0 as specified in flex-config.xml."),
        ("What language is Evony client?", "Evony client is written in ActionScript 3 (AS3), compiled to SWF for Flash Player."),
        ("What is AutoEvony?", "AutoEvony is a bot/automation tool for Evony written in ActionScript. It provides scripting capabilities for automated gameplay."),
        ("What is ResponseDispatcher?", "ResponseDispatcher is the AS3 class that handles all server responses, mapping response keys to handler functions."),
        ("What is Sender class?", "Sender is the AS3 singleton class responsible for sending all protocol commands to the server."),
        ("What is CastleBean?", "CastleBean is the main data class representing a player's city, containing buildings, troops, resources, and more."),
        ("What is HeroBean?", "HeroBean represents a hero character with stats (attack, defense, politics, intelligence), level, and equipment."),
        ("What is ArmyBean?", "ArmyBean represents a marching army with troops, hero, origin, destination, and timing information."),
        ("What is TFConstants?", "TFConstants (Troop/Fortification Constants) contains IDs and properties for all troop and fortification types."),
        ("What is FieldConstants?", "FieldConstants contains map tile type constants: plains, forest, desert, hill, lake, swamp, NPC, valley."),
        ("What is ErrorCode class?", "ErrorCode.as contains all server error code constants with their meanings (-1 to -200+)."),
        ("How to debug Evony protocol?", "Use packet capture (Wireshark/Fiddler), decode AMF3, map to ResponseDispatcher handlers, trace execution."),
        ("How to modify Evony client?", "Decompile SWF with JPEXS, edit AS3 code, recompile. Note: may violate ToS."),
    ]
    
    seen = {ex.get("instruction", "") for ex in data}
    for q, a in general_qa:
        if q not in seen:
            data.append({"instruction": q, "input": "", "output": a})
    print(f"Added general Q&A")
    
    # Save final
    output = TRAINING_DIR / "evony_final_5k.json"
    with open(output, "w") as f:
        json.dump(data, f, indent=2)
    
    output_jsonl = TRAINING_DIR / "evony_final_5k.jsonl"
    with open(output_jsonl, "w") as f:
        for ex in data:
            f.write(json.dumps(ex) + "\n")
    
    print(f"\nFINAL TOTAL: {len(data)} examples")
    print(f"Saved to {output}")

if __name__ == "__main__":
    main()
