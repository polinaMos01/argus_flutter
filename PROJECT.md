# Project: Argus Flutter App Development

## Architecture
- **State Management**: Simple stateful widgets or state parameters passed via GoRouter.
- **Routing**: `lib/router.dart` uses `GoRouter` to define all application routes, including transitions.
- **Layouts**: Standardized mobile layout matching 430 x 932 design coordinates (iPhone 15 Pro Max layout).
- **Themes**: App colors defined in `lib/theme/app_colors.dart` and app theme in `lib/theme/app_theme.dart`.

## Code Layout
- `lib/main.dart` - Entrypoint.
- `lib/router.dart` - Routing definitions.
- `lib/theme/` - Color scheme and global theme.
- `lib/widgets/` - Shared layouts and input widgets.
- `lib/mock/` - Mock data classes for screens.
- `lib/screens/`
  - `auth/` - Authentication screens.
  - `dashboard/` - Dashboard & bottom menu container.
  - `checks/` - Security check screens (email, phone, file).
  - `security/` - Security score overview.
  - `threats/` - Threat lists and detail views.
  - `tools/` - Cyber advisor, data exposure, password center, and weekly report.
  - `profile/` - Settings, profile edit, active sessions.
  - `premium/` - Subscription tariffs.
  - `notifications/` - Notification settings.

## Milestones

| # | Name | Scope | Dependencies | Status |
|---|---|---|---|---|
| M1 | Analyze Design & Codebase | Perform full figma analysis and map screens. | None | **DONE** |
| M2 | Authentication & Core | Finalize routing config, integrate existing welcome, splash, login, register, restore. | M1 | **DONE** |
| M3 | Security Checks Screens | Implement stubs/states for Email Check, Phone Check, and File Check. | M2 | **DONE** |
| M4 | Profile & Active Sessions | Implement Profile Settings, Profile Edit, and Active Devices/Sessions. | M2 | **DONE** |
| M5 | Monitoring & Threats | Implement Data Exposure overview, Leakage History (Threats List), and Leakage Detail Card. | M2 | **DONE** |
| M6 | Security Tools & Premium | Implement Cyber Advisor (AI Chat), Password Center, Weekly Report, Tariffs Premium, and Notification Settings. | M2 | **DONE** |
| M7 | Navigation Integration | Wire all 27 screens into GoRouter, set up bottom menu, and link all screens together. | M3, M4, M5, M6 | **DONE** |
| M8 | Final Verification & Audit | Run Forensic Auditor, verify build/tests pass, and claim victory. | M7 | **DONE** |

## Interface Contracts
### Main Layout (Bottom Navigation)
- Global bottom navigation bar matches Figma layout precisely.
- Links tabs: `Dashboard` (`/dashboard`), `Checks` (`/checks`), `Monitoring` (`/exposure`), `Advisor` (`/advisor`), `Profile` (`/profile`).

### Router & Navigation
- All routes must accept GoRouter state and transition parameter correctly.
- Return/Back buttons in headers must trigger `context.pop()` or `GoRouter.of(context).pop()`.
