"""Fix chunks.json content field from list to string."""
import json

print('Loading chunks.json...')
with open(r'C:\Users\Admin\Downloads\Evony_Decrypted\evony_rag\index\chunks.json', 'r', encoding='utf-8') as f:
    chunks = json.load(f)

print(f'Loaded {len(chunks)} chunks')
print('Fixing content format (list -> string)...')

for chunk in chunks:
    content = chunk.get('content', '')
    if isinstance(content, list):
        chunk['content'] = ' '.join(str(x) for x in content)

# Save fixed chunks
print('Saving fixed chunks...')
with open(r'C:\Users\Admin\Downloads\Evony_Decrypted\evony_rag\index\chunks.json', 'w', encoding='utf-8') as f:
    json.dump(chunks, f)

print('Done!')
