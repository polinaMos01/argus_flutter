import os
import re

src_dir = '/Users/polinapogosyan/.gemini/antigravity/scratch/argus_flutter/lib/screens'

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
                        # Because child is usually the last parameter, it might have a trailing comma or not.
                        # Actually, wait. What if child is not the last parameter?
                        # In my code, child is always the last parameter in MainLayout.
                        if child_content.endswith(','):
                            child_content = child_content[:-1].strip()
                        
                        # Replace MainLayout(...) with child_content
                        content = content[:start_idx] + child_content + content[layout_end+1:]
                        count += 1
                    else:
                        # Should not happen, but break to avoid infinite loop
                        break
                else:
                    break

            with open(filepath, 'w') as f:
                f.write(content)
                
print(f"Total stripped: {count}")
