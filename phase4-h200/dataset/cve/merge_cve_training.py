import os

# Define all CVE training files
cve_files = [
    r'C:\Users\Admin\Downloads\Evony_Decrypted\CVE_Research\evony_cve_training.jsonl',           # 28 original
    r'C:\Users\Admin\Downloads\Evony_Decrypted\CVE_Research\evony_cve_expanded_training.jsonl',  # 880 new expanded
    r'C:\Users\Admin\Downloads\Evony_Decrypted\training\train_cve_validated.jsonl',              # 489 NVD fetcher
    r'C:\Users\Admin\Downloads\Evony_Decrypted\training\train_cve_security.jsonl',               # 14 manual
]

output_file = r'C:\Users\Admin\Downloads\Evony_Decrypted\training\train_cve_all_expanded.jsonl'

total = 0
seen_lines = set()  # For deduplication

with open(output_file, 'w') as out:
    for fpath in cve_files:
        if os.path.exists(fpath):
            count = 0
            with open(fpath, 'r') as f:
                for line in f:
                    line = line.strip()
                    if line and line not in seen_lines:
                        out.write(line + '\n')
                        seen_lines.add(line)
                        count += 1
            print(f"Added {count} from {os.path.basename(fpath)}")
            total += count
        else:
            print(f"MISSING: {fpath}")

print(f"\nTotal CVE training examples (deduplicated): {total}")
print(f"Saved to: {output_file}")
