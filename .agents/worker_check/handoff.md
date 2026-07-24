# Handoff Report — Compilation and Test Status

## 1. Observation
- **Tool Commands Executed**:
  - `PATH="../flutter/bin:$PATH" flutter analyze`
    - Result: Exit code 1. Output showed 80 issues, including 4 compilation errors and 76 warnings/info items.
    - Verbatim Errors:
      ```
      error • The named parameter 'activeIndex' isn't defined. Try correcting the name to an existing named parameter's name, or defining a named parameter with the name 'activeIndex' • lib/screens/checks/all_checks_screen.dart:15:7 • undefined_named_parameter
      error • Undefined name 'activeIndex'. Try correcting the name to one that is defined, or defining the name • lib/widgets/main_layout.dart:234:33 • undefined_identifier
      error • Undefined name 'activeIndex'. Try correcting the name to one that is defined, or defining the name • lib/widgets/main_layout.dart:239:27 • undefined_identifier
      error • Undefined name 'activeIndex'. Try correcting the name to one that is defined, or defining the name • lib/widgets/main_layout.dart:241:34 • undefined_identifier
      ```
  - `PATH="../flutter/bin:$PATH" flutter test`
    - Result: Exit code 1.
    - Verbatim Output:
      ```
      Test directory "test" not found.
      ```

- **File Inspections**:
  - `lib/widgets/main_layout.dart` (lines 9-21):
    ```dart
    class MainLayout extends StatelessWidget {
      final Widget child;
      final String title;
      final bool showBackButton;
      final VoidCallback? onBackPressed;

      const MainLayout({
        super.key,
        required this.child,
        this.title = '',
        this.showBackButton = true,
        this.onBackPressed,
      });
    ```
    No `activeIndex` field or constructor parameter is defined.
  - `lib/widgets/main_layout.dart` (lines 234-244):
    ```dart
    Widget _buildNavItem(BuildContext context, int index, String iconPath, String label, double Function(double) s) {
      final isSelected = index == activeIndex;
      final color = isSelected ? const Color(0xFFD1FFEA) : Colors.white.withOpacity(0.4);
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (index == 0 && activeIndex != 0) {
            context.go('/dashboard');
          } else if (index == 1 && activeIndex != 1) {
            context.go('/checks');
          }
        },
    ```
    Attempts to reference `activeIndex` which is undefined in the class scope.
  - `lib/screens/checks/all_checks_screen.dart` (lines 14-16):
    ```dart
    return MainLayout(
      activeIndex: 1, // 'Проверки' active
      child: Scaffold(
    ```
    Attempts to pass `activeIndex` as a named parameter to `MainLayout`.

## 2. Logic Chain
1. Based on the file inspection of `lib/widgets/main_layout.dart`, there is no `activeIndex` field or constructor parameter, but it is referenced on lines 234, 239, and 241.
2. Based on the file inspection of `lib/screens/checks/all_checks_screen.dart`, it passes `activeIndex` to the `MainLayout` constructor on line 15.
3. Therefore, running `flutter analyze` reports 4 compile errors because `activeIndex` is used but not defined.
4. Based on the directory listing of the workspace, there is no `test` folder or `*test*.dart` files.
5. Therefore, running `flutter test` fails with the error `Test directory "test" not found.`

## 3. Caveats
- Checked compile errors using `flutter analyze` inside the local Flutter SDK `../flutter` environment.
- No unit tests have been written or configured in the repository yet.
- Only compilation errors were examined in detail. Warning issues (e.g. deprecated `withOpacity` calls) were not individually checked but do not block compilation.

## 4. Conclusion
- The project currently has **4 compile errors** making it build-broken.
- The root cause is that `lib/widgets/main_layout.dart` uses `activeIndex` internally and `lib/screens/checks/all_checks_screen.dart` passes it in, but `MainLayout` does not declare `activeIndex` as a field or constructor parameter.
- There are **no unit tests** in the project, so `flutter test` cannot run.

## 5. Verification Method
To verify compilation issues:
1. Prepend the local Flutter SDK path: `PATH="../flutter/bin:$PATH" flutter analyze`
2. Inspect the file `lib/widgets/main_layout.dart` and confirm there is no declaration of `activeIndex`.
