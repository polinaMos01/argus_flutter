## 2026-07-15T11:08:50Z

You are the Checks Screens Builder (archetype: worker).
Your working directory is /Users/polinapogosyan/.gemini/antigravity/scratch/argus_flutter/.agents/worker_checks_builder.

Your task is to implement the three Security Check screens in the Flutter project:
- lib/screens/checks/email_check_screen.dart
- lib/screens/checks/phone_check_screen.dart
- lib/screens/checks/file_check_screen.dart

Requirements:
1. Analyze the corresponding frames in /Users/polinapogosyan/.gemini/antigravity/scratch/figma_full.json:
   - Email Check: Frame 34 (91:2225 - Input), Frame 35 (91:2361 - Scanning), Frame 33 (91:2130 - Results)
   - Phone Check: Frame 36 (93:2503 - Input), Frame 37 (93:2556 - Scanning), Frame 38 (93:2655 - Results)
   - File Check: Frame 40 (109:1368 - Input), Frame 42 (109:1540 - Selected), Frame 41 (109:1409 - Scanning), Frame 39 (109:1283 - Results)
2. Implement each screen as a StatefulWidget that handles its own state transitions (e.g. using a State enum or internal integer state):
   - Input State: Renders input fields (e.g., text fields, file pickers) and buttons with custom styled containers.
   - Scanning State: Renders a progress/loader or radar animation representing checking/scanning.
   - Results State: Renders the results (e.g., safe/leak count cards, recommendation lists) with pixel-perfect details from the design. Use mock data or real status logic.
3. Ensure visual alignment with Figma coordinates, fonts, and colors (retrieve them from the JSON properties).
4. Run 'PATH="../flutter/bin:$PATH" flutter analyze' to verify that the newly implemented code compiles cleanly.
5. Record changes in 'changes.md' and write a 'handoff.md' with the verification output.
6. When complete, send a message back to the parent (project_orchestrator, conversation ID: 8cedf99c-cbb7-48a9-963e-8c6c1c0de7a1).

MANDATORY INTEGRITY WARNING:
DO NOT CHEAT. All implementations must be genuine. DO NOT hardcode test results, create dummy/facade implementations, or circumvent the intended task. A Forensic Auditor will independently verify your work. Integrity violations WILL be detected and your work WILL be rejected.
