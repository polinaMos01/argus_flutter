# Changes Made

### 1. lib/mock/mock_data.dart
- Created the `ThreatItem` data model class to represent a security threat / leakage item.
- Added a static list `threats` to the `MockData` class containing 4 mock services (Canva, Adobe Creative Cloud, Dropbox, Kickstarter) with different levels of severity, leaked fields, detail maps, recommendations, and URLs.
- This serves as the single source of truth for the screens, enabling true shared state changes.

### 2. lib/router.dart
- Imported `screens/tools/data_exposure_screen.dart`.
- Added a GoRoute for `/monitoring` pointing to `DataExposureScreen()`.

### 3. lib/widgets/main_layout.dart
- Updated the navigation item tap handler (`onTap` in `_buildNavItem`) to navigate using `context.go('/monitoring')` when index 2 (Мониторинг) is tapped.

### 4. lib/screens/dashboard/dashboard_screen.dart
- Updated the navigation bar tap handler (`_buildNavItem`'s `onTap`) to perform actual route changes (e.g. `context.go('/monitoring')`) instead of just modifying local `_currentTab` state, preventing deadlocks or incorrect visual selection when returning from sub-pages.

### 5. lib/screens/tools/data_exposure_screen.dart
- Rewrote this screen to match Figma Frame 44 (Data Exposure Overview).
- Implemented a status overview header card displaying monitoring status, count of active threats, and description.
- Implemented a mock scanning mechanism ("Проверить базы утечек") that shows a loading indicator for 2 seconds and updates the status to "Обновлено только что".
- Created tracking category cards for E-mail, Phone, and Passwords showing real-time leakage counts.
- Linked "История утечек" card to the `ThreatsListScreen` showing total incidents count.

### 6. lib/screens/threats/threats_list_screen.dart
- Rewrote this screen to match Figma Frame 45 (Leakage History).
- Displays a scrollable list of all threats retrieved from `MockData.threats`.
- Renders colored circles with initials representing service logos (Canva, Adobe, Dropbox, Kickstarter).
- Renders severity status badges ("Критическая", "Предупреждение", "Устранено") using the exact Figma styling.
- Configured tap callbacks to navigate to `ThreatDetailScreen`, passing the tapped `ThreatItem`.

### 7. lib/screens/threats/threat_detail_screen.dart
- Created this screen from scratch to match Figma Frame 46 (Leakage Detail Card).
- Renders the service details: logo, name, date, and warning status badge.
- Displays key-value entries of the leaked data fields (e.g., Email, Password, Hash, ID) with interactive icons:
  - Copy to Clipboard button for each field.
  - Show/hide toggle (eye icon) for password fields.
- Lists recommended actions for remediation.
- Implemented state-based action buttons:
  - "Решено" / "Вернуть в работу" button toggles `threat.isResolved` in-place, modifying the global state dynamically and triggering a rebuild.
  - "Сменить пароль" button opens a confirmation dialog offering to navigate to the service website (simulated).
