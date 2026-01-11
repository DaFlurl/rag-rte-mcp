"""Rebuild BM25 index to match current chunks.json (16,963 chunks)."""
import json
import sys
sys.path.insert(0, '.')

from evony_rag.hybrid_search import BM25Index

print("Loading chunks.json...")
with open(r'C:\Users\Admin\Downloads\Evony_Decrypted\evony_rag\index\chunks.json', 'r', encoding='utf-8') as f:
    chunks = json.load(f)

print(f"Loaded {len(chunks):,} chunks")

print("Building BM25 index...")
bm25 = BM25Index()

# Build index from chunks - BM25.build expects List[Dict] with 'content' key
bm25.build(chunks)

print(f"BM25 index built with {len(bm25.doc_lengths):,} documents")

# Save index
index_data = {
    'doc_freqs': bm25.doc_freqs,
    'doc_lengths': bm25.doc_lengths,
    'avg_doc_length': bm25.avg_doc_length,
    'k1': bm25.k1,
    'b': bm25.b
}

output_path = r'C:\Users\Admin\Downloads\Evony_Decrypted\evony_rag\index\bm25_index.json'
print(f"Saving to {output_path}...")
with open(output_path, 'w', encoding='utf-8') as f:
    json.dump(index_data, f)

print(f"Done! BM25 index now matches {len(chunks):,} chunks")
