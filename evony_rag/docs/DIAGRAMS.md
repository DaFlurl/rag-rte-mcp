# Evony Knowledge RAG - System Diagrams

## 1. High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                     EVONY KNOWLEDGE SYSTEM                       │
│                                                                  │
│  ┌──────────┐   ┌──────────┐   ┌──────────┐   ┌──────────────┐ │
│  │ Windsurf │   │LM Studio │   │   CLI    │   │  HTTP Client │ │
│  │   IDE    │   │   Chat   │   │ Terminal │   │   (curl)     │ │
│  └────┬─────┘   └────┬─────┘   └────┬─────┘   └──────┬───────┘ │
│       │              │              │                │          │
│       │ MCP          │ API          │ Direct         │ API      │
│       │ :8765        │ :8766        │                │ :8766    │
│       ▼              ▼              ▼                ▼          │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │                    INTERFACE LAYER                        │  │
│  │                                                           │  │
│  │  mcp_server_v2.py  │  api_v2.py  │  cli_v2.py            │  │
│  └───────────────────────────┬───────────────────────────────┘  │
│                              │                                   │
│                              ▼                                   │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │                     RAG ENGINE v2                         │  │
│  │                      rag_v2.py                            │  │
│  │                                                           │  │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────────┐   │  │
│  │  │   Policy    │  │   Hybrid    │  │    Response     │   │  │
│  │  │   Engine    │  │   Search    │  │    Generator    │   │  │
│  │  │ policy.py   │  │hybrid_search│  │                 │   │  │
│  │  └─────────────┘  └─────────────┘  └─────────────────┘   │  │
│  └──────────────────────────────────────────────────────────┘  │
│                              │                                   │
│                              ▼                                   │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │                     INDEX LAYER                           │  │
│  │                                                           │  │
│  │  embeddings.npy │ chunks.json │ bm25_index │ symbol_index │  │
│  │    (166k×384)   │  metadata   │  inverted  │   55k syms   │  │
│  └──────────────────────────────────────────────────────────┘  │
│                              │                                   │
│                              ▼                                   │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │                   CURATED DATASET                         │  │
│  │              Evony_Training_Dataset/                      │  │
│  │                                                           │  │
│  │  source_code/ │ protocol/ │ keys/ │ scripts/ │ exploits/ │  │
│  │    7,469      │    85     │ 1,230 │   106    │    26     │  │
│  └──────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

## 2. Query Processing Flow

```
                    User Query
                        │
                        ▼
            ┌───────────────────────┐
            │     Query Router      │
            │  - Intent detection   │
            │  - Keyword extraction │
            └───────────┬───────────┘
                        │
                        ▼
            ┌───────────────────────┐
            │    Policy Engine      │
            │  - Mode check         │
            │  - Category filter    │
            │  - Safety filter      │
            └───────────┬───────────┘
                        │
           ┌────────────┴────────────┐
           │                         │
           ▼                         ▼
┌─────────────────────┐   ┌─────────────────────┐
│    BM25 Search      │   │  Embedding Search   │
│                     │   │                     │
│  - Tokenize query   │   │  - Encode query     │
│  - IDF weighting    │   │  - Cosine similarity│
│  - Top-k results    │   │  - Top-k results    │
│                     │   │                     │
│  k=20 lexical       │   │  k=20 semantic      │
└─────────┬───────────┘   └───────────┬─────────┘
          │                           │
          └─────────────┬─────────────┘
                        │
                        ▼
            ┌───────────────────────┐
            │  Reciprocal Rank      │
            │      Fusion           │
            │                       │
            │  score = Σ(1/(k+rank))│
            │  final_k = 8          │
            └───────────┬───────────┘
                        │
                        ▼
            ┌───────────────────────┐
            │  Response Generator   │
            │                       │
            │  - Format context     │
            │  - Call LM Studio     │
            │  - Add citations      │
            └───────────┬───────────┘
                        │
                        ▼
                   Response
              (answer + citations)
```

## 3. Index Structure

```
evony_rag/index/
│
├── embeddings.npy
│   │
│   └── Shape: (166043, 384)
│       │
│       ├── Each row = one chunk
│       └── 384 dimensions (MiniLM)
│
├── chunks.json
│   │
│   └── Array of chunk metadata
│       │
│       ├── id: "source_code/Client.as:45-89"
│       ├── file_path: relative path
│       ├── category: source_code|protocol|keys|...
│       ├── start_line: int
│       ├── end_line: int
│       └── content: text content
│
├── bm25_index.json
│   │
│   └── Inverted index
│       │
│       ├── doc_lengths: [len1, len2, ...]
│       ├── avg_doc_length: float
│       ├── doc_freqs: {term: count}
│       └── inverted_index: {term: [(doc_id, freq), ...]}
│
├── symbol_index.json
│   │
│   └── Symbol → occurrences mapping
│       │
│       └── {symbol: [{file, line, context}, ...]}
│
└── metadata.json
    │
    └── Index metadata
        │
        ├── model: embedding model name
        ├── num_chunks: 166043
        ├── embedding_dim: 384
        └── categories: {cat: count}
```

## 4. Policy Mode Flow

```
                    Query
                      │
                      ▼
              ┌───────────────┐
              │  Check Mode   │
              └───────┬───────┘
                      │
        ┌─────────────┼─────────────┐
        │             │             │
        ▼             ▼             ▼
  ┌──────────┐  ┌──────────┐  ┌──────────┐
  │ research │  │forensics │  │full_access│
  │ (default)│  │          │  │          │
  └────┬─────┘  └────┬─────┘  └────┬─────┘
       │             │             │
       ▼             ▼             ▼
  ┌──────────┐  ┌──────────┐  ┌──────────┐
  │ Include: │  │ Include: │  │ Include: │
  │ - code   │  │ - code   │  │ - ALL    │
  │ - proto  │  │ - proto  │  │          │
  │ - keys   │  │ - docs   │  │ Exclude: │
  │ - scripts│  │          │  │ - none   │
  │ - docs   │  │ Exclude: │  │          │
  │          │  │ - keys   │  │          │
  │ Exclude: │  │ - scripts│  │          │
  │ - exploit│  │ - exploit│  │          │
  └──────────┘  └──────────┘  └──────────┘
```

## 5. MCP Tool Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                      WINDSURF IDE                                │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                    MCP Client                             │   │
│  │                                                           │   │
│  │  @evony-knowledge [query]                                 │   │
│  └──────────────────────────┬────────────────────────────────┘   │
│                             │                                    │
└─────────────────────────────┼────────────────────────────────────┘
                              │ JSON-RPC
                              │ port 8765
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    MCP SERVER (mcp_server_v2.py)                 │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                    Tool Router                            │   │
│  └────┬────────┬────────┬────────┬────────┬────────┬────────┘   │
│       │        │        │        │        │        │            │
│       ▼        ▼        ▼        ▼        ▼        ▼            │
│  ┌────────┐┌────────┐┌────────┐┌────────┐┌────────┐┌────────┐   │
│  │search  ││answer  ││open    ││symbol  ││trace   ││mode    │   │
│  │        ││        ││        ││        ││        ││        │   │
│  │Hybrid  ││RAG +   ││File    ││Def     ││Multi-  ││Get/Set │   │
│  │search  ││LLM     ││content ││lookup  ││hop     ││mode    │   │
│  └────────┘└────────┘└────────┘└────────┘└────────┘└────────┘   │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

## 6. Training Pipeline

```
┌─────────────────────────────────────────────────────────────────┐
│                    TRAINING PIPELINE                             │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │              Evony_Training_Data/                         │   │
│  │              training_data.json                           │   │
│  │              36,370 Alpaca examples                       │   │
│  └──────────────────────────┬────────────────────────────────┘   │
│                             │                                    │
│                             ▼                                    │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │              SETUP_EVONY_AI.bat                           │   │
│  │              - Install PyTorch CUDA                       │   │
│  │              - Install Unsloth                            │   │
│  │              - Install transformers, trl, peft            │   │
│  └──────────────────────────┬────────────────────────────────┘   │
│                             │                                    │
│                             ▼                                    │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │              TRAIN_EVONY_AI.bat                           │   │
│  │              train_unsloth.py                             │   │
│  │                                                           │   │
│  │  Model: Qwen2.5-3B-Instruct                              │   │
│  │  Method: LoRA (4-bit)                                    │   │
│  │  Rank: 64, Alpha: 16                                     │   │
│  │  Epochs: 3                                               │   │
│  │  Time: ~2-3 hours (RTX 3090 Ti)                          │   │
│  └──────────────────────────┬────────────────────────────────┘   │
│                             │                                    │
│                             ▼                                    │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │              evony_ai/evony_lora_adapter/                 │   │
│  │              LoRA weights (~100MB)                        │   │
│  └──────────────────────────┬────────────────────────────────┘   │
│                             │                                    │
│                             ▼                                    │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │              CHAT_EVONY_AI.bat                            │   │
│  │              chat_evony.py                                │   │
│  │              Test trained model                           │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                  │
│  Optional: Export to GGUF for LM Studio                         │
└─────────────────────────────────────────────────────────────────┘
```

## 7. Data Flow Summary

```
Raw Files (48k)
     │
     ▼ Curation
Approved Files (8,957)
     │
     ├─────────────────────┐
     ▼                     ▼
RAG Index              Training Data
(166k chunks)          (36k examples)
     │                     │
     ▼                     ▼
Hybrid Search          LoRA Training
     │                     │
     ▼                     ▼
Citations +            Fine-tuned
Answers                Model
     │                     │
     └─────────┬───────────┘
               │
               ▼
        Combined System
     (RAG + Fine-tuned LLM)
```
