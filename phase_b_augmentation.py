#!/usr/bin/env python3
"""
Phase B: Data Augmentation
Expand dataset from 5,001 to 10,000+ examples
"""

import json
import random
from pathlib import Path
from datetime import datetime
from typing import List, Dict

TRAINING_DIR = Path(__file__).parent / "Evony_Training_Data"
OUTPUT_DIR = Path(__file__).parent / "Evony_Training_Data"


def load_dataset():
    """Load current dataset"""
    path = TRAINING_DIR / "evony_final_5k.json"
    with open(path) as f:
        return json.load(f)


def instruction_variations(instruction: str) -> List[str]:
    """Generate variations of an instruction"""
    variations = []
    
    # Question format variations
    prefixes = [
        "What is", "Explain", "Describe", "Tell me about",
        "How does", "Can you explain", "What does", "Help me understand"
    ]
    
    suffixes = [
        "", "?", " in Evony?", " in the Evony game?",
        " - explain in detail", " (Evony)"
    ]
    
    # Extract core topic
    core = instruction.lower()
    for prefix in ["what is the ", "what is ", "how do i ", "how does ", "explain ", "what are "]:
        if core.startswith(prefix):
            core = core[len(prefix):]
            break
    core = core.rstrip("?").strip()
    
    if core:
        for prefix in random.sample(prefixes, min(3, len(prefixes))):
            for suffix in random.sample(suffixes, min(2, len(suffixes))):
                new_inst = f"{prefix} {core}{suffix}"
                if new_inst != instruction:
                    variations.append(new_inst)
    
    return variations[:3]  # Limit to 3 variations


def generate_follow_up_questions(example: Dict) -> List[Dict]:
    """Generate follow-up questions based on an example"""
    augmented = []
    instruction = example.get("instruction", "")
    output = example.get("output", "")
    
    # Extract key terms from output
    key_terms = []
    for term in ["command", "parameter", "field", "type", "level", "cost", "error", "ID"]:
        if term.lower() in output.lower():
            key_terms.append(term)
    
    follow_ups = {
        "command": [
            ("What parameters does this command require?", "See the command definition for required parameters."),
            ("What errors can this command return?", "Common errors include -1 (general), -2 (invalid params), -3 (resources), -4 (troops)."),
        ],
        "parameter": [
            ("What type should this parameter be?", "Check the command signature for parameter types (int, String, Object, Array)."),
            ("Is this parameter required or optional?", "Required parameters must be provided; optional ones have default values."),
        ],
        "field": [
            ("What type is this field?", "Common types: int, String, Number, Array, Object, Boolean."),
            ("How do I access this field?", "Access bean fields via dot notation: bean.fieldName"),
        ],
        "level": [
            ("What is the maximum level?", "Most buildings/research max at level 10. Town Hall determines city limits."),
            ("What unlocks at higher levels?", "Higher levels unlock new features, troops, research options."),
        ],
        "cost": [
            ("How can I reduce this cost?", "Research Construction/relevant techs, use mayor with high politics."),
            ("What resources are needed?", "Common resources: Food, Wood, Stone, Iron, Gold."),
        ],
        "error": [
            ("How do I fix this error?", "Check the error code meaning and verify your parameters/resources."),
            ("What causes this error?", "Each error code has specific causes - check ErrorCode.as."),
        ],
        "ID": [
            ("Where do I find this ID?", "IDs are defined in Constants files or returned by server responses."),
            ("Is this ID unique?", "Most IDs (hero, army, building position) are unique per player/city."),
        ],
    }
    
    for term in key_terms[:2]:
        if term in follow_ups:
            for q, a in follow_ups[term][:1]:
                augmented.append({
                    "instruction": f"Regarding: {instruction[:50]}... {q}",
                    "input": "",
                    "output": a
                })
    
    return augmented


def generate_negation_examples(example: Dict) -> List[Dict]:
    """Generate 'what NOT to do' examples"""
    augmented = []
    instruction = example.get("instruction", "")
    output = example.get("output", "")
    
    negation_templates = [
        ("What are common mistakes with {topic}?", 
         "Common mistakes: Not validating parameters, ignoring error codes, not checking resources first."),
        ("What should I avoid when {action}?",
         "Avoid: Sending too many requests (rate limiting), using invalid IDs, ignoring server responses."),
    ]
    
    # Extract topic
    topic = instruction.replace("What is ", "").replace("How do I ", "").replace("?", "").strip()[:30]
    action = "using " + topic
    
    for template_q, template_a in negation_templates[:1]:
        augmented.append({
            "instruction": template_q.format(topic=topic, action=action),
            "input": "",
            "output": template_a
        })
    
    return augmented


def generate_comparison_examples(examples: List[Dict]) -> List[Dict]:
    """Generate comparison examples between related items"""
    augmented = []
    
    # Group by topic
    protocol_examples = [e for e in examples if "command" in e.get("instruction", "").lower()]
    troop_examples = [e for e in examples if any(t in e.get("instruction", "").lower() for t in ["troop", "warrior", "archer", "cavalry"])]
    building_examples = [e for e in examples if "building" in e.get("instruction", "").lower() or "barracks" in e.get("instruction", "").lower()]
    
    # Protocol comparisons
    if len(protocol_examples) >= 2:
        for i in range(min(20, len(protocol_examples) - 1)):
            e1, e2 = protocol_examples[i], protocol_examples[i + 1]
            topic1 = e1.get("instruction", "")[:30]
            topic2 = e2.get("instruction", "")[:30]
            augmented.append({
                "instruction": f"Compare: {topic1} vs {topic2}",
                "input": "",
                "output": f"First: {e1.get('output', '')[:100]}... Second: {e2.get('output', '')[:100]}..."
            })
    
    return augmented[:50]


def generate_scenario_examples() -> List[Dict]:
    """Generate scenario-based examples"""
    scenarios = [
        # Attack scenarios
        {
            "instruction": "I'm a beginner and want to attack my first NPC. What should I do?",
            "input": "",
            "output": "For your first NPC attack: 1) Train 2-3k archers, 2) Assign a hero with attack stat, 3) Scout the NPC first (level 1-2), 4) Send attack with army.newArmy (missionType=5). Start with level 1 NPCs to minimize losses."
        },
        {
            "instruction": "My attack failed with error -4. What went wrong?",
            "input": "",
            "output": "Error -4 is TROOP_NOT_ENOUGH. You tried to send more troops than available. Check your troop counts before sending. Solution: Reduce troop numbers in the army.newArmy command or train more troops first."
        },
        {
            "instruction": "How do I set up an automated farming script?",
            "input": "",
            "output": "AutoEvony farming script example:\n```\nlabel start\nscout 100 200\nsleep 5000\nif %scoutResult% == success attack 100 200\nsleep 300000\ngoto start\n```\nThis scouts, attacks if clear, waits 5 minutes, repeats. Adjust coordinates and timing as needed."
        },
        # Building scenarios
        {
            "instruction": "What's the optimal build order for a new city?",
            "input": "",
            "output": "Optimal build order: 1) Town Hall to 4, 2) Cottages (population), 3) Resource buildings (farms priority), 4) Barracks + Rally Spot, 5) Academy, 6) Forge/Workshop. Focus resources on Town Hall early - it unlocks everything else."
        },
        {
            "instruction": "I can't upgrade my Academy. What's blocking it?",
            "input": "",
            "output": "Academy upgrade blockers: 1) Town Hall level (Academy max = TH level), 2) Insufficient resources, 3) Build queue full, 4) Another building upgrading (unless you have multiple builders). Check error code for specific cause."
        },
        # Hero scenarios
        {
            "instruction": "How should I allocate my hero stat points?",
            "input": "",
            "output": "Hero stat allocation depends on role: Combat hero - max Attack (each point = ~1% damage). Mayor - max Politics (resource production). Strategist - Intelligence (stratagems). Most players focus on Attack heroes first."
        },
        {
            "instruction": "My hero is stuck with status 3. How do I free them?",
            "input": "",
            "output": "Status 3 = MARCHING. The hero is leading an army. Options: 1) Wait for march to complete, 2) Use army.callBackArmy to recall, 3) Speed up with items. Check army list to find which army the hero is leading."
        },
        # Resource scenarios
        {
            "instruction": "I'm always running out of food. How do I fix this?",
            "input": "",
            "output": "Food shortage solutions: 1) Build more farms (all 40 outside slots if needed), 2) Research Agriculture, 3) Assign high-politics mayor, 4) Reduce troop count (troops consume food), 5) Capture food valleys for bonus, 6) Trade wood/stone for food."
        },
        {
            "instruction": "How do I protect my resources from being plundered?",
            "input": "",
            "output": "Resource protection: 1) Upgrade Warehouse (protects 90% of capacity), 2) Spend excess resources before logout, 3) Use resource boxes (stored as items), 4) Keep resources below protection cap, 5) Online shield items prevent attacks."
        },
        # Alliance scenarios
        {
            "instruction": "How do I request reinforcements from alliance members?",
            "input": "",
            "output": "To receive reinforcements: 1) Build Embassy (determines capacity), 2) Share coordinates with allies, 3) Allies use army.newArmy with missionType=2 (REINFORCE) to your city. Reinforced troops defend your city but consume your food."
        },
        # Script scenarios
        {
            "instruction": "My script keeps getting errors. How do I debug it?",
            "input": "",
            "output": "Script debugging: 1) Add 'echo' statements to trace execution, 2) Use 'iferror goto errorhandler' after commands, 3) Check variable values with 'echo %varname%', 4) Add 'sleep' to slow execution, 5) Test small sections independently."
        },
        {
            "instruction": "How do I make my script wait for a condition?",
            "input": "",
            "output": "Conditional waiting in scripts:\n```\nlabel waitloop\nif $c.resource.food$ > 10000 goto continue\nsleep 60000\ngoto waitloop\nlabel continue\necho Resources ready!\n```\nThis checks every minute until food > 10k."
        },
        # Security scenarios
        {
            "instruction": "How do I know if my bot is being detected?",
            "input": "",
            "output": "Bot detection signs: 1) Frequent disconnections, 2) Error -200 (signature issues), 3) Account warnings, 4) Rate limiting (commands failing). Prevention: Randomize timing, add human-like delays, don't spam commands, vary action patterns."
        },
        {
            "instruction": "What encryption does Evony use?",
            "input": "",
            "output": "Evony encryption: 1) MD5 signatures with ACTION_KEY for request validation, 2) XOR with 0xAA for packet obfuscation (weak), 3) MD5(password+'evony') for password hashing. AMF3 binary format over HTTP/HTTPS for data serialization."
        },
        # Combat mechanics
        {
            "instruction": "Why do my archers keep dying even with more troops?",
            "input": "",
            "output": "Archer casualties causes: 1) Enemy cavalry reached your archers (cavalry counters archers), 2) Not enough defensive troops (add pikemen for cavalry defense), 3) Enemy has range advantage (catapults), 4) Hero stat difference. Add cavalry screen and pikemen to protect archers."
        },
        {
            "instruction": "How is damage calculated in Evony combat?",
            "input": "",
            "output": "Damage formula: damage = attack * count * (1 - defense/(defense+500)) * modifiers. Modifiers include: hero bonus (attack stat %), tech bonus (2% per level), terrain (0.7x to 1.2x), wall defense (1 + level*0.1). Higher attack and count = more damage."
        },
    ]
    
    return scenarios


def generate_multi_turn_conversations() -> List[Dict]:
    """Generate multi-turn conversation examples"""
    conversations = []
    
    multi_turn = [
        [
            ("How do I send an army?", "Use army.newArmy with cityId, heroId, troops object, targetX, targetY, and missionType parameters."),
            ("What are the mission types?", "Mission types: 1=Transport, 2=Reinforce, 3=Occupy, 4=Scout, 5=Attack, 6=Colonize."),
            ("What troops object format?", "Troops object format: {archer: 1000, cavalry: 500, cataphract: 100} - key is troop type name, value is count."),
        ],
        [
            ("How do I train troops?", "Use troop.produceTroop with cityId, troopType (2-13), and num (count) parameters."),
            ("What are the troop type IDs?", "Troop IDs: 2=Worker, 3=Warrior, 4=Scout, 5=Pike, 6=Sword, 7=Archer, 8=Cavalry, 9=Cataphract, 10=Transport, 11=Ballista, 12=Ram, 13=Catapult."),
            ("Which is best for attacking?", "Archers (7) are best for most attacks - high damage, range advantage. Add cavalry (8) for speed and archer protection."),
        ],
        [
            ("My command returned error -3", "Error -3 is RESOURCE_NOT_ENOUGH. Check your food, wood, stone, iron before the action."),
            ("How do I check resources?", "Access via CastleBean.resource or use $c.resource.food$ in scripts. Server response also includes current resources."),
            ("How do I get more resources?", "Build resource buildings, research production techs, assign high-politics mayor, capture valleys, trade in marketplace."),
        ],
    ]
    
    for conv in multi_turn:
        context = ""
        for i, (q, a) in enumerate(conv):
            conversations.append({
                "instruction": f"{context}User: {q}" if context else q,
                "input": "",
                "output": a
            })
            context += f"User: {q}\nAssistant: {a}\n"
    
    return conversations


def main():
    print("="*60)
    print("PHASE B: DATA AUGMENTATION")
    print(f"Started: {datetime.now()}")
    print("="*60)
    
    # Load existing
    data = load_dataset()
    original_count = len(data)
    print(f"\nOriginal dataset: {original_count} examples")
    
    augmented = []
    
    # 1. Instruction variations
    print("\n1. Generating instruction variations...")
    for example in data[:500]:  # Process subset for speed
        variations = instruction_variations(example.get("instruction", ""))
        for var in variations:
            augmented.append({
                "instruction": var,
                "input": example.get("input", ""),
                "output": example.get("output", "")
            })
    print(f"   Added {len(augmented)} variations")
    
    # 2. Follow-up questions
    print("\n2. Generating follow-up questions...")
    follow_ups = []
    for example in data[:300]:
        follow_ups.extend(generate_follow_up_questions(example))
    augmented.extend(follow_ups)
    print(f"   Added {len(follow_ups)} follow-ups")
    
    # 3. Negation examples
    print("\n3. Generating negation examples...")
    negations = []
    for example in data[:200]:
        negations.extend(generate_negation_examples(example))
    augmented.extend(negations)
    print(f"   Added {len(negations)} negations")
    
    # 4. Comparison examples
    print("\n4. Generating comparison examples...")
    comparisons = generate_comparison_examples(data)
    augmented.extend(comparisons)
    print(f"   Added {len(comparisons)} comparisons")
    
    # 5. Scenario examples
    print("\n5. Generating scenario examples...")
    scenarios = generate_scenario_examples()
    augmented.extend(scenarios)
    print(f"   Added {len(scenarios)} scenarios")
    
    # 6. Multi-turn conversations
    print("\n6. Generating multi-turn conversations...")
    multi_turn = generate_multi_turn_conversations()
    augmented.extend(multi_turn)
    print(f"   Added {len(multi_turn)} multi-turn examples")
    
    # Deduplicate
    print("\n7. Deduplicating...")
    seen = {ex.get("instruction", "") for ex in data}
    unique_augmented = [ex for ex in augmented if ex.get("instruction", "") not in seen]
    
    # Combine
    combined = data + unique_augmented
    print(f"\nFinal dataset: {len(combined)} examples")
    print(f"Added: {len(combined) - original_count} new examples")
    
    # Save
    output = OUTPUT_DIR / "evony_augmented_10k.json"
    with open(output, "w") as f:
        json.dump(combined, f, indent=2)
    
    output_jsonl = OUTPUT_DIR / "evony_augmented_10k.jsonl"
    with open(output_jsonl, "w") as f:
        for ex in combined:
            f.write(json.dumps(ex) + "\n")
    
    print(f"\nSaved to {output}")
    print(f"Completed: {datetime.now()}")


if __name__ == "__main__":
    main()
