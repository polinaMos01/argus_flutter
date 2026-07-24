import os
import re

directory = '/Users/polinapogosyan/.gemini/antigravity/scratch/argus_flutter/lib/screens'

count = 0
for root, _, files in os.walk(directory):
    for file in files:
        if file.endswith('.dart'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r') as f:
                content = f.read()
            
            # Find an extra `),` before `);` at the end of the file.
            new_content = re.sub(r'[ \t]*\),\n[ \t]*\);\n  }', '    );\n  }', content)
            
            if new_content != content:
                count += 1
                print(f"Fixed {filepath}")
                with open(filepath, 'w') as f:
                    f.write(new_content)
print(f"Fixed {count} files.")
