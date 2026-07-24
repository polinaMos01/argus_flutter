import os
import re

src_dir = '/Users/polinapogosyan/.gemini/antigravity/scratch/argus_flutter/lib/screens'

count = 0
for root, _, files in os.walk(src_dir):
    for file in files:
        if file.endswith('.dart'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r') as f:
                content = f.read()

            if 'return MainLayout(' in content:
                start_idx = content.find('return MainLayout(')
                
                open_parens = 0
                layout_end = -1
                for j in range(start_idx + len('return MainLayout'), len(content)):
                    if content[j] == '(':
                        open_parens += 1
                    elif content[j] == ')':
                        open_parens -= 1
                        if open_parens == 0:
                            layout_end = j
                            break
                            
                if layout_end != -1:
                    inner_content = content[start_idx + len('return MainLayout(') : layout_end]
                    
                    # Instead of regex, let's just find `child:` at the same brace level.
                    # Actually, the regex `child:\s*([\s\S]+)` works if it's the last parameter, which it usually is.
                    child_match = re.search(r'child:\s*([\s\S]+)', inner_content)
                    if child_match:
                        child_content = child_match.group(1).strip()
                        if child_content.endswith(','):
                            child_content = child_content[:-1].strip()
                        
                        semi_idx = content.find(';', layout_end)
                        if semi_idx != -1:
                            new_content = content[:start_idx] + 'return ' + child_content + content[semi_idx:]
                            
                            with open(filepath, 'w') as f:
                                f.write(new_content)
                            count += 1
                            print(f"Stripped from {filepath}")
                            
print(f"Total stripped: {count}")
