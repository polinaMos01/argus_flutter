# Changes Record - Fix Layout Compilation Errors

## Modified Files
### `lib/widgets/main_layout.dart`
- Added the `final int activeIndex;` field to the `MainLayout` class.
- Updated the `MainLayout` constructor to accept `this.activeIndex = 0` as an optional named parameter.

## Rationale
The `MainLayout` widget referenced the identifier `activeIndex` in the bottom navigation bar builder (`_buildNavItem` method) to determine the styling and behavior of the selected navigation item. However, the `activeIndex` field was missing from the widget definition, leading to a compilation error. Adding this field and initializing it in the constructor resolves the issue and allows optional configuration of the active tab.

## Code Diff
```diff
@@ -11,6 +11,7 @@
   final String title;
   final bool showBackButton;
   final VoidCallback? onBackPressed;
+  final int activeIndex;
 
   const MainLayout({
     super.key,
@@ -17,6 +17,7 @@
     this.title = '',
     this.showBackButton = true,
     this.onBackPressed,
+    this.activeIndex = 0,
   });
```
