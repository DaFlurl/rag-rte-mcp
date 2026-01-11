"""Repair corrupted chunks JSON and restore full 166K dataset."""
import json

print("Loading corrupted chunks2.json...")
with open(r'C:\Users\Admin\Downloads\Evony_Decrypted\chunks2.json', 'r', encoding='utf-8') as f:
    content = f.read()

print(f'Total file size: {len(content):,} chars')

# Incremental JSON parsing to recover chunks
decoder = json.JSONDecoder()
chunks = []
pos = 1  # Skip opening [
errors = 0

while pos < len(content) - 1:
    # Skip whitespace and commas
    while pos < len(content) and content[pos] in ' \n\r\t,':
        pos += 1
    if pos >= len(content) - 1 or content[pos] == ']':
        break
    try:
        obj, end_pos = decoder.raw_decode(content, pos)
        chunks.append(obj)
        pos = end_pos
        if len(chunks) % 50000 == 0:
            print(f'Parsed {len(chunks):,} chunks...')
    except json.JSONDecodeError as e:
        errors += 1
        if errors > 10:
            print(f'Stopping at {len(chunks):,} chunks due to {errors} errors')
            break
        # Skip to next {
        next_brace = content.find('{', pos + 1)
        if next_brace == -1:
            break
        pos = next_brace

print(f'\nRecovered {len(chunks):,} chunks')

# Save to index folder
output_path = r'C:\Users\Admin\Downloads\Evony_Decrypted\evony_rag\index\chunks.json'
print(f'Saving to {output_path}...')
with open(output_path, 'w', encoding='utf-8') as f:
    json.dump(chunks, f)

print(f'Done! Saved {len(chunks):,} chunks')
