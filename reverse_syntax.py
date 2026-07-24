import os

files_to_fix = [
    'lib/screens/tools/weekly_report_screen.dart',
    'lib/screens/tools/cyber_advisor_screen.dart',
    'lib/screens/tools/password_center_screen.dart',
    'lib/screens/tools/data_exposure_screen.dart',
    'lib/screens/security/security_score_screen.dart',
    'lib/screens/auth/register_screen.dart',
    'lib/screens/auth/restore_screen.dart',
    'lib/screens/auth/login_screen.dart',
    'lib/screens/auth/email_confirm_screen.dart',
    'lib/screens/auth/welcome_screen.dart',
    'lib/screens/threats/threats_list_screen.dart',
    'lib/screens/threats/threat_detail_screen.dart',
    'lib/screens/checks/email_check_screen.dart',
    'lib/screens/checks/file_check_screen.dart',
    'lib/screens/checks/all_checks_screen.dart',
    'lib/screens/checks/phone_check_screen.dart',
    'lib/screens/dashboard/dashboard_screen.dart',
    'lib/screens/profile/security_screen.dart',
    'lib/screens/profile/payment_methods_screen.dart',
    'lib/screens/profile/backup_codes_screen.dart',
    'lib/screens/profile/profile_settings_screen.dart',
    'lib/screens/profile/devices_screen.dart',
    'lib/screens/profile/profile_screen.dart',
    'lib/screens/profile/change_password_screen.dart',
    'lib/screens/profile/active_sessions_screen.dart',
    'lib/screens/profile/edit_profile_screen.dart',
    'lib/screens/profile/payment_history_screen.dart',
    'lib/screens/premium/tariffs_screen.dart',
    'lib/screens/notifications/notifications_screen.dart'
]

count = 0
for file in files_to_fix:
    filepath = '/Users/polinapogosyan/.gemini/antigravity/scratch/argus_flutter/' + file
    if os.path.exists(filepath):
        with open(filepath, 'r') as f:
            content = f.read()
        
        new_content = content.replace('    );\n  }', '        ),\n    );\n  }')
        
        if new_content != content:
            count += 1
            print(f"Reversed {filepath}")
            with open(filepath, 'w') as f:
                f.write(new_content)
                
print(f"Reversed {count} files")
