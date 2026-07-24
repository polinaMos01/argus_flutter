import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'router.dart';
import 'theme/app_theme.dart';

void main() {
  usePathUrlStrategy();
  runApp(const ArgusApp());
}

class NoScrollbarBehavior extends ScrollBehavior {
  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class ArgusApp extends StatelessWidget {
  const ArgusApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ARGUS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      scrollBehavior: NoScrollbarBehavior(),
      routerConfig: appRouter,
      builder: (context, child) {
        return Container(
          color: Colors.black, // Dark background outside the mobile preview
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: ClipRect(
                child: GlobalNotificationOverlay(child: child!),
              ),
            ),
          ),
        );
      },
    );
  }
}

class GlobalNotificationOverlay extends StatefulWidget {
  final Widget child;
  const GlobalNotificationOverlay({Key? key, required this.child}) : super(key: key);

  @override
  State<GlobalNotificationOverlay> createState() => _GlobalNotificationOverlayState();
}

class _GlobalNotificationOverlayState extends State<GlobalNotificationOverlay> {
  bool _showToast = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Show toast every 90 seconds - REMOVED
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;

    return Stack(
      children: [
        widget.child,
        if (_showToast)
          Positioned(
            top: 67 * s, // 67 pixels from top as requested
            left: 24 * s,
            right: 24 * s,
            child: Material(
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 9, sigmaY: 9),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6EAF91).withOpacity(0.14),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF6EAF91).withOpacity(0.42),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40 * s,
                          height: 40 * s,
                          decoration: BoxDecoration(
                            color: const Color(0xFF6EAF91),
                            borderRadius: BorderRadius.circular(12),
                          ),
                            child: SvgPicture.asset(
                              'assets/images/shield_checkmark.svg',
                              width: 22 * s,
                              height: 22 * s,
                              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Security Alert',
                                    style: TextStyle(
                                      fontFamily: 'GoogleSans',
                                      color: Colors.white,
                                      fontSize: 14 * s,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'только что',
                                    style: TextStyle(
                                      fontFamily: 'GoogleSans',
                                      color: Colors.white.withOpacity(0.4),
                                      fontSize: 11 * s,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Обнаружен новый слив данных. Проверьте аккаунты и обновите пароли.',
                                style: TextStyle(
                                  fontFamily: 'GoogleSans',
                                  color: Colors.white,
                                  fontSize: 12 * s,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showToast = false;
                            });
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.white.withOpacity(0.6),
                            size: 16 * s,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
