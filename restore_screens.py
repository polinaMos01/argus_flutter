import os
import shutil

src_dir = '/tmp/argus_restore/lib/screens'
dst_dir = '/Users/polinapogosyan/.gemini/antigravity/scratch/argus_flutter/lib/screens'

skip_files = [
    'dashboard_screen.dart',
    'email_check_screen.dart',
    'phone_check_screen.dart',
    'file_check_screen.dart'
]

count = 0
for root, _, files in os.walk(src_dir):
    for file in files:
        if file.endswith('.dart') and file not in skip_files:
            src_path = os.path.join(root, file)
            rel_path = os.path.relpath(src_path, src_dir)
            dst_path = os.path.join(dst_dir, rel_path)
            
            os.makedirs(os.path.dirname(dst_path), exist_ok=True)
            shutil.copy2(src_path, dst_path)
            count += 1

print(f"Restored {count} files from original zip.")
