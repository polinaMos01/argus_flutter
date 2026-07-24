## 2026-07-15T11:24:48Z
You are the Tools & Premium Screens Builder (archetype: worker).
Your working directory is /Users/polinapogosyan/.gemini/antigravity/scratch/argus_flutter/.agents/worker_tools_premium_builder.

Your task is to implement the Security Tools, Premium Subscription, and Settings screens in the Flutter project:
- lib/screens/tools/cyber_advisor_screen.dart (AI Chat Assistant)
- lib/screens/tools/password_center_screen.dart (Password Strength Analyzer)
- lib/screens/tools/weekly_report_screen.dart (Weekly Scans & Threats Report Summary)
- lib/screens/premium/tariffs_screen.dart (Premium plans, Pricing cards, Cancellation dialog)
- lib/screens/notifications/notifications_screen.dart (Notification toggle configs)
- Add sub-screens in lib/screens/profile/:
  - backup_codes_screen.dart (Backup Codes display, copy, generate actions)
  - payment_methods_screen.dart (Payment cards display/methods)
  - payment_history_screen.dart (Receipts / payments list)

Requirements:
1. View the React counterparts in /Users/polinapogosyan/.gemini/antigravity/scratch/argus-app/src/screens/ for functional layouts:
   - SubscriptionScreen.jsx -> tariffs_screen.dart
   - BackupCodesScreen.jsx -> backup_codes_screen.dart
   - ActiveDevicesScreen.jsx -> active_sessions_screen.dart
   - NotificationsScreen.jsx -> notifications_screen.dart
   - WeeklyReportScreen.jsx -> weekly_report_screen.dart
   - CyberAdvisorScreen.jsx -> cyber_advisor_screen.dart
   - PaymentMethodsScreen.jsx -> payment_methods_screen.dart
   - PaymentHistoryScreen.jsx -> payment_history_screen.dart
2. Implement each screen using appropriate widgets matching the Flutter dark/accent theme colors (from app_colors.dart) and typography.
3. For cyber_advisor_screen.dart, implement an interactive message list where the user can type and send questions, and get realistic mock security advisor replies.
4. For password_center_screen.dart, implement a real-time password strength checker. As the user types, update the strength label (weak, medium, strong), color (red, orange, green), entropy percentage, and detail checklist (length, capitals, numbers, symbols).
5. For weekly_report_screen.dart, show statistics of scans, leaks found, and delta security improvements.
6. For tariffs_screen.dart, display Free vs Premium Monthly vs Premium Yearly cards. Implement the "Cancel Premium" dialog modal overlay.
7. Wire up the sub-screens (Backup Codes, Payments) to transition correctly using Navigator.push.
8. Run 'PATH="../flutter/bin:$PATH" flutter analyze' to check for compilation issues.
9. Record changes in 'changes.md' and write a 'handoff.md' with the analyze output.
10. When complete, send a message back to the parent (project_orchestrator, conversation ID: 8cedf99c-cbb7-48a9-963e-8c6c1c0de7a1).

MANDATORY INTEGRITY WARNING:
DO NOT CHEAT. All implementations must be genuine. DO NOT hardcode test results, create dummy/facade implementations, or circumvent the intended task. A Forensic Auditor will independently verify your work. Integrity violations WILL be detected and your work WILL be rejected.
