import os

files_to_fix = [
    'lib/screens/profile/profile_settings_screen.dart',
    'lib/screens/profile/edit_profile_screen.dart',
    'lib/screens/profile/active_sessions_screen.dart',
    'lib/screens/profile/change_password_screen.dart',
    'lib/screens/profile/payment_methods_screen.dart',
    'lib/screens/tools/data_exposure_screen.dart',
    'lib/screens/threats/threat_detail_screen.dart',
    'lib/screens/tools/password_center_screen.dart',
    'lib/screens/premium/tariffs_screen.dart',
    'lib/screens/security/security_score_screen.dart'
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
