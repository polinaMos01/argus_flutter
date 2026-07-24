# Changes Made

## New Files
- `lib/screens/profile/profile_settings_screen.dart`: Main profile settings screen displaying username, email, phone, premium subscription info, and menu options to edit profile, change password, view active sessions, or view premium tariffs.
- `lib/screens/profile/edit_profile_screen.dart`: Form to edit profile information. Supports both normal and unconfirmed email states, displaying warning alerts and navigation links dynamically to verify the email.
- `lib/screens/profile/active_sessions_screen.dart`: List of active sessions displaying device name, OS, location, IP address, and active status. Features a functional button to terminate other active sessions.
- `lib/screens/profile/change_password_screen.dart`: Sub-screen allowing the user to update their account password, containing form validation fields.

## Modified Files
- `lib/router.dart`: Integrated the new profile screen with GoRouter route configurations.
- `lib/widgets/main_layout.dart`: Enabled bottom navigation bar interactions to route to the `/profile` page, and resolved an unused import warning.
- `lib/theme/app_theme.dart`: Removed an unused `google_fonts` import to clean up build compilation warnings.
