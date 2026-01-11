
We need to create a comprehensive Evony training dataset by consolidating scattered files across multiple locations. The current estimate of 12GB is inaccurate due to extensive duplication. Here's the detailed action plan:

**Objective**: Build a clean, deduplicated Evony dataset for AI training from the existing Svony Studio codebase and external sources.

**Phase 1: Discovery and Analysis**
1. Use the existing `EvonyScanner` class from `src/evony_hub/scanner.py` to scan all known Evony data locations:
   - `D:\Svony_Studio`
   - `D:\Users\Admin\Desktop\evony_2024` 
   - `G:\Evony_CentOS`
   - `C:\Users\Admin\Downloads\Evony_Decrypted`
   - `G:\Local-Games-Projects\evony_scripts_collection`
   - `C:\Users\Admin\Documents\Windsurf_Projects\EvonyTools`
2. Generate MD5 hashes for all files to identify exact duplicates
3. Use the existing `EvonyIndexer` to categorize files by type (scripts, data, docs, assets, etc.)
4. Create a deduplication report showing file counts before/after cleanup

**Phase 2: Dataset Structure Creation**
1. Create a new `Evony_Dataset/` folder with the following structure:
   ```
   Evony_Dataset/
   ├── source_code/          # ActionScript, Python, batch files
   ├── game_data/            # JSON, XML, CSV files with game mechanics
   ├── documentation/        # MD files, protocol docs, guides  
   ├── network_captures/     # AMF packets, protocol samples
   ├── assets/              # SWF files, images, sounds
   ├── accounts/            # SOL files, account data (anonymized)
   ├── tools/               # Executables, utilities
   └── metadata/            # Index files, training labels
   ```

**Phase 3: Intelligent Deduplication**
1. Use the existing `EvonyOrganizer` class to move unique files to appropriate dataset folders
2. For near-duplicates (same content, different names), keep the most descriptive filename
3. Create a mapping file showing original locations → dataset locations
4. Preserve file modification dates and metadata

**Phase 4: Training Data Preparation**
1. Generate embeddings using the existing `CodeEmbedding` class from `src/ml/embeddings.py`
2. Create training labels based on file categories and Evony-specific keywords
3. Convert text files to tokenized format suitable for language model training
4. Generate a final dataset manifest with file counts, sizes, and content summaries

**Expected Outcome**: A clean, organized dataset likely under 2GB (after deduplication) ready for AI model training, with comprehensive metadata and no duplicate content.

**Tools to Use**: Leverage existing Svony Studio components (`EvonyScanner`, `EvonyOrganizer`, `EvonyIndexer`, `CodeEmbedding`) rather than building from scratch.