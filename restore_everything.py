import os
import shutil
import subprocess
import re

zip_path = '/Users/polinapogosyan/.gemini/antigravity/brain/786727cf-c97b-454b-ba59-4fa0b6d3e77a/argus_flutter_source.zip'
tmp_dir = '/tmp/argus_restore_full'
target_screens = '/Users/polinapogosyan/.gemini/antigravity/scratch/argus_flutter/lib/screens'

# 1. Unzip
subprocess.run(['rm', '-rf', tmp_dir])
os.makedirs(tmp_dir, exist_ok=True)
subprocess.run(['unzip', '-q', zip_path, '-d', tmp_dir])

# The zip contains `argus_flutter_source` ? Actually earlier `ls /tmp/argus_restore` showed NO `argus_flutter_source` directory, it just had `lib/`, `pubspec.yaml`, etc.
src_screens = os.path.join(tmp_dir, 'lib', 'screens')

# 2. Delete and replace screens
subprocess.run(['rm', '-rf', target_screens])
shutil.copytree(src_screens, target_screens)
print("Copied all screens cleanly.")

# 3. Strip MainLayout correctly
count = 0
for root, _, files in os.walk(target_screens):
    for file in files:
        if file.endswith('.dart'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r') as f:
                content = f.read()

            while 'MainLayout(' in content:
                start_idx = content.find('MainLayout(')
                
                open_parens = 0
                layout_end = -1
                for j in range(start_idx + len('MainLayout'), len(content)):
                    if content[j] == '(':
                        open_parens += 1
                    elif content[j] == ')':
                        open_parens -= 1
                        if open_parens == 0:
                            layout_end = j
                            break
                            
                if layout_end != -1:
                    inner_content = content[start_idx + len('MainLayout(') : layout_end]
                    
                    child_match = re.search(r'child:\s*([\s\S]+)', inner_content)
                    if child_match:
                        child_content = child_match.group(1).strip()
                        if child_content.endswith(','):
                            child_content = child_content[:-1].strip()
                        
                        content = content[:start_idx] + child_content + content[layout_end+1:]
                        count += 1
                    else:
                        break
                else:
                    break

            with open(filepath, 'w') as f:
                f.write(content)

print(f"Stripped {count} MainLayouts")
