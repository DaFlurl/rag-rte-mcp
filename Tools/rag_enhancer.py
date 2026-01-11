#!/usr/bin/env python3
"""
RAG System Enhancer
Improves the existing Evony RAG with:
- Better query routing
- Enhanced reranking
- Citation formatting
- Confidence scoring
"""

import os
import sys
import json
from pathlib import Path
from datetime import datetime
from typing import List, Dict, Optional, Tuple

BASE_DIR = Path(__file__).parent.parent
RAG_DIR = BASE_DIR / "evony_rag"

# Add RAG to path
sys.path.insert(0, str(RAG_DIR))


class RAGEnhancer:
    """Enhances RAG system capabilities"""
    
    def __init__(self):
        self.enhancements = []
        
    def create_query_classifier(self):
        """Create query type classifier for better routing"""
        
        classifier_code = '''#!/usr/bin/env python3
"""Query Classifier for RAG-Native Routing"""

import re
from typing import Tuple

class QueryClassifier:
    """Classifies queries into task types for optimal routing"""
    
    TASK_PATTERNS = {
        "gui_map": [
            r"screen|button|ui|interface|click|menu|panel|widget",
            r"what.*visible|layout|position|element"
        ],
        "gui_action": [
            r"how (do i|to)|steps|navigate|open|access|find where",
            r"click.*to|guide me|show me how"
        ],
        "code_explain": [
            r"explain|what (is|does)|describe|tell me about",
            r"how does.*work|meaning of|purpose of"
        ],
        "patch_plan": [
            r"fix|patch|modify|change|update|bug|error",
            r"refactor|improve|optimize"
        ],
        "query_synthesis": [
            r"find|search|locate|where is|look for|retrieve",
            r"what files|which class|source of"
        ],
        "evidence_cite": [
            r"cite|reference|source|proof|evidence",
            r"show me.*code|actual implementation"
        ]
    }
    
    def classify(self, query: str) -> Tuple[str, float]:
        """
        Classify query and return (task_type, confidence)
        """
        query_lower = query.lower()
        scores = {}
        
        for task_type, patterns in self.TASK_PATTERNS.items():
            score = 0
            for pattern in patterns:
                if re.search(pattern, query_lower):
                    score += 1
            scores[task_type] = score
        
        if max(scores.values()) == 0:
            return ("general", 0.5)
        
        best_task = max(scores, key=scores.get)
        confidence = min(1.0, scores[best_task] / 2)
        
        return (best_task, confidence)
    
    def get_search_strategy(self, task_type: str) -> dict:
        """Get optimal search strategy for task type"""
        
        strategies = {
            "gui_map": {
                "k_lexical": 10,
                "k_semantic": 20,
                "prefer": "semantic",
                "file_types": [".as", ".xml", ".json"]
            },
            "gui_action": {
                "k_lexical": 15,
                "k_semantic": 15,
                "prefer": "hybrid",
                "file_types": [".as", ".md"]
            },
            "code_explain": {
                "k_lexical": 20,
                "k_semantic": 10,
                "prefer": "lexical",
                "file_types": [".as", ".py"]
            },
            "patch_plan": {
                "k_lexical": 25,
                "k_semantic": 10,
                "prefer": "lexical",
                "file_types": [".as", ".py", ".js"]
            },
            "query_synthesis": {
                "k_lexical": 10,
                "k_semantic": 10,
                "prefer": "hybrid",
                "file_types": ["*"]
            },
            "evidence_cite": {
                "k_lexical": 30,
                "k_semantic": 5,
                "prefer": "lexical",
                "file_types": [".as", ".py"]
            },
            "general": {
                "k_lexical": 15,
                "k_semantic": 15,
                "prefer": "hybrid",
                "file_types": ["*"]
            }
        }
        
        return strategies.get(task_type, strategies["general"])


# Singleton instance
_classifier = None

def get_classifier() -> QueryClassifier:
    global _classifier
    if _classifier is None:
        _classifier = QueryClassifier()
    return _classifier
'''
        
        output_path = RAG_DIR / "query_classifier.py"
        with open(output_path, "w", encoding="utf-8") as f:
            f.write(classifier_code)
        
        self.enhancements.append(f"Created query_classifier.py")
        return output_path
    
    def create_citation_formatter(self):
        """Create citation formatting utilities"""
        
        formatter_code = '''#!/usr/bin/env python3
"""Citation Formatter for RAG-Native Responses"""

import re
from typing import List, Dict
from pathlib import Path

class CitationFormatter:
    """Formats citations in RAG-native style"""
    
    def __init__(self, base_path: str = ""):
        self.base_path = base_path
        
    def format_citation(self, file_path: str, line_start: int, line_end: int = None) -> str:
        """Format a single citation"""
        # Clean path
        clean_path = file_path.replace("\\\\", "/")
        if self.base_path and clean_path.startswith(self.base_path):
            clean_path = clean_path[len(self.base_path):]
        if clean_path.startswith("/"):
            clean_path = clean_path[1:]
            
        if line_end and line_end != line_start:
            return f"`@{clean_path}:{line_start}-{line_end}`"
        return f"`@{clean_path}:{line_start}`"
    
    def format_evidence_block(self, results: List[Dict]) -> str:
        """Format multiple search results as evidence block"""
        if not results:
            return "No evidence found."
        
        output = "**Evidence:**\\n"
        for i, result in enumerate(results[:5], 1):
            file_path = result.get("file", result.get("path", "unknown"))
            line = result.get("line", result.get("line_start", 1))
            snippet = result.get("snippet", result.get("content", ""))[:200]
            
            citation = self.format_citation(file_path, line)
            output += f"\\n{i}. {citation}\\n```\\n{snippet}\\n```\\n"
        
        return output
    
    def inject_citations(self, text: str, results: List[Dict]) -> str:
        """Inject citations into response text"""
        # Find file references and add citations
        file_pattern = r"(\\w+\\.as|\\w+\\.py|\\w+\\.json)"
        
        def add_citation(match):
            filename = match.group(1)
            for result in results:
                if filename in result.get("file", ""):
                    line = result.get("line", 1)
                    return f"`@source_code/{filename}:{line}`"
            return match.group(0)
        
        return re.sub(file_pattern, add_citation, text)
    
    def format_uncertainty_response(self, query: str) -> str:
        """Format response when evidence is insufficient"""
        # Extract key terms
        words = query.lower().split()
        key_terms = [w for w in words if len(w) > 4][:3]
        
        suggestions = []
        if key_terms:
            suggestions.append(f"{key_terms[0]} definition source_code")
            suggestions.append(f"{key_terms[0]} implementation")
            if len(key_terms) > 1:
                suggestions.append(f"{key_terms[0]} {key_terms[1]} handler")
        else:
            suggestions = [
                "command implementation",
                "bean class definition",
                "response handler"
            ]
        
        return f"""**Need Evidence**

To answer this accurately, please retrieve:
1. {suggestions[0]}
2. {suggestions[1]}
{f"3. {suggestions[2]}" if len(suggestions) > 2 else ""}

I cannot provide a reliable answer without evidence from the codebase."""


# Singleton
_formatter = None

def get_formatter(base_path: str = "") -> CitationFormatter:
    global _formatter
    if _formatter is None:
        _formatter = CitationFormatter(base_path)
    return _formatter
'''
        
        output_path = RAG_DIR / "citation_formatter.py"
        with open(output_path, "w", encoding="utf-8") as f:
            f.write(formatter_code)
        
        self.enhancements.append(f"Created citation_formatter.py")
        return output_path
    
    def create_confidence_scorer(self):
        """Create confidence scoring for RAG responses"""
        
        scorer_code = '''#!/usr/bin/env python3
"""Confidence Scorer for RAG Responses"""

from typing import List, Dict, Tuple

class ConfidenceScorer:
    """Scores confidence of RAG responses"""
    
    def score_results(self, results: List[Dict], query: str) -> Tuple[float, str]:
        """
        Score search results confidence.
        Returns (score 0-1, explanation)
        """
        if not results:
            return (0.0, "No results found")
        
        score = 0.0
        reasons = []
        
        # Factor 1: Number of results (max 0.2)
        result_score = min(0.2, len(results) * 0.04)
        score += result_score
        reasons.append(f"{len(results)} results")
        
        # Factor 2: Relevance scores (max 0.3)
        if results:
            avg_relevance = sum(r.get("score", 0) for r in results) / len(results)
            relevance_score = min(0.3, avg_relevance * 0.3)
            score += relevance_score
            reasons.append(f"avg relevance {avg_relevance:.2f}")
        
        # Factor 3: Query term matches (max 0.3)
        query_terms = set(query.lower().split())
        matches = 0
        for result in results[:5]:
            content = result.get("snippet", result.get("content", "")).lower()
            matches += sum(1 for term in query_terms if term in content)
        
        match_score = min(0.3, matches * 0.05)
        score += match_score
        reasons.append(f"{matches} term matches")
        
        # Factor 4: Source diversity (max 0.2)
        files = set(r.get("file", "") for r in results[:10])
        diversity_score = min(0.2, len(files) * 0.04)
        score += diversity_score
        reasons.append(f"{len(files)} unique files")
        
        explanation = ", ".join(reasons)
        return (min(1.0, score), explanation)
    
    def should_answer(self, score: float) -> Tuple[bool, str]:
        """Determine if confidence is high enough to answer"""
        if score >= 0.7:
            return (True, "High confidence - proceed with answer")
        elif score >= 0.4:
            return (True, "Medium confidence - answer with caveats")
        else:
            return (False, "Low confidence - request more evidence")
    
    def format_confidence_indicator(self, score: float) -> str:
        """Format confidence as visual indicator"""
        if score >= 0.8:
            return "🟢 High Confidence"
        elif score >= 0.6:
            return "🟡 Medium Confidence"
        elif score >= 0.4:
            return "🟠 Low Confidence"
        else:
            return "🔴 Insufficient Evidence"


# Singleton
_scorer = None

def get_scorer() -> ConfidenceScorer:
    global _scorer
    if _scorer is None:
        _scorer = ConfidenceScorer()
    return _scorer
'''
        
        output_path = RAG_DIR / "confidence_scorer.py"
        with open(output_path, "w", encoding="utf-8") as f:
            f.write(scorer_code)
        
        self.enhancements.append(f"Created confidence_scorer.py")
        return output_path
    
    def create_reranker(self):
        """Create result reranker"""
        
        reranker_code = '''#!/usr/bin/env python3
"""Result Reranker for improved RAG precision"""

from typing import List, Dict
import re

class ResultReranker:
    """Reranks search results for better relevance"""
    
    def __init__(self):
        self.boost_patterns = {
            # Boost exact matches
            "exact_match": 2.0,
            # Boost code definitions
            "definition": 1.5,
            # Boost public APIs
            "public_api": 1.3,
            # Boost documentation
            "documentation": 1.2,
        }
    
    def rerank(self, results: List[Dict], query: str) -> List[Dict]:
        """Rerank results based on query relevance"""
        query_lower = query.lower()
        query_terms = set(query_lower.split())
        
        scored_results = []
        for result in results:
            score = result.get("score", 0.5)
            content = result.get("snippet", result.get("content", "")).lower()
            file_path = result.get("file", "").lower()
            
            # Boost exact term matches
            for term in query_terms:
                if len(term) > 3 and term in content:
                    score *= 1.2
                if term in file_path:
                    score *= 1.1
            
            # Boost definitions
            if re.search(r"(public|private|protected)\\s+(static\\s+)?(const|var|function)", content):
                score *= self.boost_patterns["definition"]
            
            # Boost public APIs
            if "public static" in content or "public function" in content:
                score *= self.boost_patterns["public_api"]
            
            # Boost .as files for ActionScript queries
            if ".as" in file_path and any(kw in query_lower for kw in ["command", "bean", "constant"]):
                score *= 1.3
            
            # Penalize very short snippets
            if len(content) < 50:
                score *= 0.7
            
            result["reranked_score"] = score
            scored_results.append(result)
        
        # Sort by reranked score
        scored_results.sort(key=lambda x: x.get("reranked_score", 0), reverse=True)
        
        return scored_results
    
    def deduplicate(self, results: List[Dict]) -> List[Dict]:
        """Remove duplicate or near-duplicate results"""
        seen_content = set()
        unique_results = []
        
        for result in results:
            content = result.get("snippet", result.get("content", ""))[:100]
            content_hash = hash(content.strip())
            
            if content_hash not in seen_content:
                seen_content.add(content_hash)
                unique_results.append(result)
        
        return unique_results


# Singleton
_reranker = None

def get_reranker() -> ResultReranker:
    global _reranker
    if _reranker is None:
        _reranker = ResultReranker()
    return _reranker
'''
        
        output_path = RAG_DIR / "reranker.py"
        with open(output_path, "w", encoding="utf-8") as f:
            f.write(reranker_code)
        
        self.enhancements.append(f"Created reranker.py")
        return output_path
    
    def run_all(self):
        """Run all enhancements"""
        print("="*60)
        print("RAG SYSTEM ENHANCEMENTS")
        print(f"Started: {datetime.now()}")
        print("="*60)
        
        if not RAG_DIR.exists():
            print(f"ERROR: RAG directory not found: {RAG_DIR}")
            return
        
        print(f"\nRAG Directory: {RAG_DIR}")
        
        self.create_query_classifier()
        print("✓ Query classifier created")
        
        self.create_citation_formatter()
        print("✓ Citation formatter created")
        
        self.create_confidence_scorer()
        print("✓ Confidence scorer created")
        
        self.create_reranker()
        print("✓ Result reranker created")
        
        print(f"\n✅ RAG enhancements complete!")
        print(f"New modules added: {len(self.enhancements)}")
        
        return self.enhancements


def main():
    enhancer = RAGEnhancer()
    enhancer.run_all()


if __name__ == "__main__":
    main()
