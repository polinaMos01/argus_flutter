## 2026-07-15T11:27:40Z

You are the Navigation & Router Builder (archetype: worker).
Your working directory is /Users/polinapogosyan/.gemini/antigravity/scratch/argus_flutter/.agents/worker_router_builder.

Your task is to wire all 27 screens into GoRouter in lib/router.dart and ensure navigation linkages are set up:
1. Examine the 27 screen files under lib/screens/ and their current routing setup in lib/router.dart.
2. Update lib/router.dart to:
   - Import all 27 screens.
   - Define a GoRoute path for every single one of them. The paths should be:
     - '/' -> SplashScreen
     - '/welcome' -> WelcomeScreen
     - '/login' -> LoginScreen
     - '/register' -> RegisterScreen
     - '/restore' -> RestoreScreen
     - '/email-confirm' -> EmailConfirmScreen (accept extra for email if needed)
     - '/dashboard' -> DashboardScreen
     - '/checks' -> AllChecksScreen
     - '/email-check' -> EmailCheckScreen
     - '/phone-check' -> PhoneCheckScreen
     - '/file-check' -> FileCheckScreen
     - '/profile' -> ProfileSettingsScreen
     - '/profile/edit' -> EditProfileScreen
     - '/profile/active-sessions' -> ActiveSessionsScreen
     - '/profile/change-password' -> ChangePasswordScreen
     - '/profile/backup-codes' -> BackupCodesScreen
     - '/profile/payment-methods' -> PaymentMethodsScreen
     - '/profile/payment-history' -> PaymentHistoryScreen
     - '/monitoring' -> DataExposureScreen
     - '/threats' -> ThreatsListScreen
     - '/threat-detail' -> ThreatDetailScreen (accept state/extra for threat if needed, or pass empty)
     - '/advisor' -> CyberAdvisorScreen
     - '/password-center' -> PasswordCenterScreen
     - '/weekly-report' -> WeeklyReportScreen
     - '/tariffs' -> TariffsScreen
     - '/notifications' -> NotificationsScreen
     - '/security-score' -> SecurityScoreScreen
3. Verify that the project compiles cleanly after these router additions by running:
   'PATH="../flutter/bin:$PATH" flutter analyze'
4. Record your changes in 'changes.md' and write a 'handoff.md' with the analyze output.
5. When complete, send a message back to the parent (project_orchestrator, conversation ID: 8cedf99c-cbb7-48a9-963e-8c6c1c0de7a1).

MANDATORY INTEGRITY WARNING:
DO NOT CHEAT. All implementations must be genuine. DO NOT hardcode test results, create dummy/facade implementations, or circumvent the intended task. A Forensic Auditor will independently verify your work. Integrity violations WILL be detected and your work WILL be rejected.
