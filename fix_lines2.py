import os

files_to_fix = [
    'lib/screens/dashboard/dashboard_screen.dart',
    'lib/screens/checks/email_check_screen.dart',
    'lib/screens/checks/phone_check_screen.dart',
    'lib/screens/checks/file_check_screen.dart'
]

base_dir = '/Users/polinapogosyan/.gemini/antigravity/scratch/argus_flutter/'

for file in files_to_fix:
    full_path = base_dir + file
    with open(full_path, 'r') as f:
        content = f.read()
    
    new_content = content.replace('        ),\n    );\n  }', '    );\n  }')
    if new_content != content:
        print(f"Fixed {full_path}")
        with open(full_path, 'w') as f:
            f.write(new_content)
