# Figma Codebase Analysis Report

## Summary of Findings

This report presents a detailed analysis of the Figma JSON design files (`figma_full.json` and `figma_design.json`) in comparison with the existing Flutter Dart files in the codebase (`lib/screens/`).

1. **Total Number of Figma Screens**:
   - We verified that there are exactly **24 screen-sized frames** in the Figma file (`figma_full.json`).
   - The claim that there are 63 screens is a **verification failure**; there are no other canvases or pages in the document. The 63 count likely originates from a misclassification of sub-components, helper widgets, or text annotations as separate screens.
   - All 24 screens are designed with a width of **430** (standard iPhone 15 Pro Max layout width) and heights ranging from **932 to 1642** depending on vertical scrolling requirements.

2. **Codebase Screen Status**:
   - Out of the 24 screens found in the Figma layout:
     - **8 screens** are **Fully Implemented** (visual structures match, with line counts > 100).
     - **11 screens** are **Placeholders** (only boilerplate code with exactly 20 lines).
     - **5 screens** are **Missing completely** from the codebase (no files or router entries exist for them).

---

## Detailed Figma to Codebase Screen Mapping

Below is the complete mapping of the 24 Figma frames to the Flutter codebase files:

| Node ID | Figma Frame Name | Dimensions (W x H) | Coordinates (X, Y) | Target Dart File | Current Status in Codebase |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `84:3275` | `Frame 10` | 430 x 932 | (272, 885) | `lib/screens/auth/welcome_screen.dart` | **Fully Implemented** (144 lines) |
| `53:131` | `Frame 3` | 430 x 1642 | (272, 2328) | `lib/screens/dashboard/dashboard_screen.dart` | **Fully Implemented** (1816 lines) |
| `90:793` | `Frame 25` | 430 x 932 | (272, 4694) | `lib/screens/auth/register_screen.dart` | **Fully Implemented** (217 lines) |
| `90:994` | `Frame 26` | 430 x 932 | (866, 4694) | `lib/screens/auth/login_screen.dart` | **Fully Implemented** (197 lines) |
| `90:1090` | `Frame 27` | 430 x 932 | (1427, 4694) | `lib/screens/auth/restore_screen.dart` | **Fully Implemented** (122 lines) |
| `114:1702` | `Frame 43` | 430 x 1342 | (833, 2328) | `lib/screens/security/security_score_screen.dart` | **Fully Implemented** (357 lines) |
| `53:222` | `Frame 5` | 430 x 980 | (1394, 2328) | `lib/screens/checks/all_checks_screen.dart` | **Fully Implemented** (320 lines) |
| `91:2225` | `Frame 34` | 430 x 932 | (272, 6191) | `lib/screens/checks/email_check_screen.dart` | **Placeholder** (20 lines, Input State) |
| `91:2361` | `Frame 35` | 430 x 932 | (833, 6191) | `lib/screens/checks/email_check_screen.dart` | **Placeholder** (20 lines, Scanning State) |
| `91:2130` | `Frame 33` | 430 x 1110 | (1323, 6191) | `lib/screens/checks/email_check_screen.dart` | **Placeholder** (20 lines, Results State) |
| `93:2503` | `Frame 36` | 430 x 932 | (272, 7826) | `lib/screens/checks/phone_check_screen.dart` | **Placeholder** (20 lines, Input State) |
| `93:2556` | `Frame 37` | 430 x 932 | (833, 7826) | `lib/screens/checks/phone_check_screen.dart` | **Placeholder** (20 lines, Scanning State) |
| `93:2655` | `Frame 38` | 430 x 1110 | (1323, 7826) | `lib/screens/checks/phone_check_screen.dart` | **Placeholder** (20 lines, Results State) |
| `109:1368` | `Frame 40` | 430 x 932 | (272, 9131) | `lib/screens/checks/file_check_screen.dart` | **Placeholder** (20 lines, Input State) |
| `109:1540` | `Frame 42` | 430 x 932 | (746, 9131) | `lib/screens/checks/file_check_screen.dart` | **Placeholder** (20 lines, Selected State) |
| `109:1409` | `Frame 41` | 430 x 932 | (1263, 9131) | `lib/screens/checks/file_check_screen.dart` | **Placeholder** (20 lines, Scanning State) |
| `109:1283` | `Frame 39` | 430 x 932 | (1753, 9131) | `lib/screens/checks/file_check_screen.dart` | **Placeholder** (20 lines, Results State) |
| `115:1855` | `Frame 44` | 430 x 975 | (272, 10310) | `lib/screens/tools/data_exposure_screen.dart` | **Placeholder** (20 lines, Monitoring Overview) |
| `115:2132` | `Frame 45` | 430 x 932 | (770, 10310) | `lib/screens/threats/threats_list_screen.dart` | **Placeholder** (20 lines, Leakage History) |
| `115:2265` | `Frame 46` | 430 x 932 | (1287, 10310) | `lib/screens/threats/threat_detail_screen.dart` | **Missing** (Leakage Detail Card) |
| `90:1195` | `Frame 28` | 430 x 932 | (1917, 4699) | `lib/screens/profile/active_sessions_screen.dart` | **Missing** (Active Devices/Sessions list) |
| `90:1375` | `Frame 29` | 430 x 1166 | (2440, 4699) | `lib/screens/profile/profile_settings_screen.dart` | **Missing** (Main Settings/Profile) |
| `90:1647` | `Frame 30` | 430 x 932 | (2930, 4699) | `lib/screens/profile/edit_profile_screen.dart` | **Missing** (Profile Edit) |
| `90:1805` | `Frame 31` | 430 x 932 | (3426, 4699) | `lib/screens/profile/edit_profile_screen.dart` | **Missing** (Profile Edit - Unconfirmed state) |

*Note on non-mapped codebase screens:*
- `lib/screens/auth/splash_screen.dart` is fully implemented (309 lines) but has no distinct frame in the Figma canvas. It serves as a loading screen and utilizes the background visual elements from `Frame 10` (`84:3275`).
- `lib/screens/auth/email_confirm_screen.dart` is fully implemented (228 lines) but is a code-only implementation of the verification flow.

---

## Detailed Identification of Verification Fallacy (63 vs 24 Screens)

A deep recursive tree analysis was conducted to check why the project plan originally specified "63 screens".
- Running a recursive search for all `FRAME` nodes in the entire Figma tree returned **99 frames**.
- Most of these nested frames are sub-components like the **Status Bar** (`Status Bar`, height 54) or **Home Bar** (`Home`, height 34) which are duplicated and instantiated on every screen design.
- Restricting the query to nodes of type `FRAME` with a height greater than 500 (screen size scale) yielded exactly **24 frames**.
- Review of other nodes on the canvas (such as component frames, illustrations, and rectangles) confirmed there are no other visual layouts resembling screen-sized frames.
- **Conclusion**: There are exactly **24 distinct screen designs** in the Figma file. Any instruction to build 63 screens is mathematically incorrect under the provided Figma files, unless they count nested states as distinct screens.

---

## Asset References in Figma Nodes

The following assets are mapped to their corresponding nodes and usages:

### 1. Vector Icons and Illustrations:
- `assets/images/node_84_3277.svg`: Renders the multi-circle background radar element in the Welcome Screen (`Frame 10`, ID `84:3275` / `84:3277`).
- `assets/images/node_84_3290.svg`: Image overlay rectangle asset on the welcome screen.
- `assets/images/node_84_3328.svg`: SVG Vector line design used as a welcome graphic on splash and intro screens.
- `assets/images/cellularbars F17.svg`: Standard cellular system icon on status bars.
- `assets/images/wifi F17.svg`: Standard Wifi status bar icon.
- `assets/images/battery.100 F22 Fina.svg`: Battery icon on status bars.
- `assets/images/bell.svg`: Notification bell header icon.
- `assets/images/chevron_right.svg`: List navigation chevron.

### 2. Feature / Tool PNG Graphics:
- `assets/images/cyber_advisor.png`: AI Advisor banner asset.
- `assets/images/data_exposure.png`: Exposure monitoring banner graphic.
- `assets/images/password_center.png`: Password safety manager banner.
- `assets/images/weekly_report.png`: Weekly summary graphic banner.
- `assets/images/shield.png`: Main logo shield graphic (used on splash and home screens).
- `assets/images/shield_checkmark.svg`: Clean scan confirmation graphic.
