import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'app_toast.dart';
import 'bouncy_button.dart';

import '../screens/notifications/notifications_screen.dart';
import '../screens/tools/cyber_advisor_screen.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final String? currentPath;

  const MainLayout({
    super.key,
    required this.child,
    this.currentPath,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  Timer? _notificationTimer;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _notificationTimer?.cancel();
    _removeOverlay();
    super.dispose();
  }

  void _startNotificationTimer() {
    _notificationTimer = Timer.periodic(const Duration(seconds: 90), (timer) {
      _showGlobalNotification();
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showGlobalNotification() {
    if (_overlayEntry != null) return;
    
    final overlayState = Overlay.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    double s(double value) => value * (canvasWidth / 393);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: s(54 + 20), // Place below status bar with some padding
        left: s(16),
        right: s(16),
        child: Material(
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(s(16)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                padding: EdgeInsets.all(s(16)),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(s(16)),
                  border: Border.all(color: const Color(0xFFEB5757).withOpacity(0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(s(8)),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEB5757).withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.warning_amber_rounded, color: const Color(0xFFEB5757), size: s(24)),
                    ),
                    SizedBox(width: s(12)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Новая угроза',
                            style: TextStyle(color: Colors.white, fontSize: s(16), fontWeight: FontWeight.w600, fontFamily: 'GoogleSans'),
                          ),
                          SizedBox(height: s(4)),
                          Text(
                            'Ваш email найден в недавней утечке',
                            style: TextStyle(color: Colors.white70, fontSize: s(14), fontFamily: 'GoogleSans', height: 1.2),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlayState.insert(_overlayEntry!);
    
    Future.delayed(const Duration(seconds: 4), () {
      _removeOverlay();
    });
  }

  void _showNotificationsSheet(BuildContext context, double Function(double) s) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: EdgeInsets.all(s(24)),
          decoration: BoxDecoration(
            color: const Color(0xFF060E11).withOpacity(0.95),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(s(24)),
              topRight: Radius.circular(s(24)),
            ),
            border: Border.all(color: const Color(0xFF6EAF91).withOpacity(0.4), width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: s(40),
                  height: s(4),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(s(2)),
                  ),
                ),
              ),
              SizedBox(height: s(16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Уведомления',
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: Colors.white,
                      fontSize: s(20),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      showAppToast(context, 'Все уведомления прочитаны');
                    },
                    child: Text(
                      'Прочитано',
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: const Color(0xFF6EAF91),
                        fontSize: s(13),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: s(16)),
              _buildNotificationItem(
                s,
                title: 'Новая утечка данных',
                time: '10 мин назад',
                desc: 'Ваш email ghost_user@protonmail.com обнаружен в базе данных "ComboList 2025".',
                color: const Color(0xFFFF4B4B),
                icon: Icons.warning_amber_rounded,
              ),
              SizedBox(height: s(12)),
              _buildNotificationItem(
                s,
                title: 'Подозрительный вход',
                time: '2 часа назад',
                desc: 'Выполнен вход с нового устройства Android SM-G991B (Москва, Россия).',
                color: const Color(0xFFE65100),
                icon: Icons.devices_other,
              ),
              SizedBox(height: s(12)),
              _buildNotificationItem(
                s,
                title: 'Security Score обновлён',
                time: 'Вчера',
                desc: 'Ваш рейтинг безопасности повысился до 85/100.',
                color: const Color(0xFF6EAF91),
                icon: Icons.shield_outlined,
              ),
              SizedBox(height: s(20)),
              GestureDetector(
                onTap: () {
                  Navigator.pop(ctx);
                  context.push('/notifications');
                },
                child: Container(
                  height: s(48),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6EAF91).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(s(24)),
                    border: Border.all(color: const Color(0xFF6EAF91).withOpacity(0.4)),
                  ),
                  child: Center(
                    child: Text(
                      'Настройка уведомлений',
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: Colors.white,
                        fontSize: s(15),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: s(16)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
    double Function(double) s, {
    required String title,
    required String time,
    required String desc,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(s(14)),
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9).withOpacity(0.03),
        borderRadius: BorderRadius.circular(s(12)),
        border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(s(8)),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: s(18)),
          ),
          SizedBox(width: s(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: Colors.white,
                        fontSize: s(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: const Color(0xFFACACAC),
                        fontSize: s(11),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: s(4)),
                Text(
                  desc,
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    color: Colors.white70,
                    fontSize: s(13),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  int get activeIndex {
    if (widget.currentPath == null) return 0;
    if (widget.currentPath == '/dashboard') return 0;
    if (widget.currentPath!.startsWith('/checks') || widget.currentPath!.startsWith('/email-check') || widget.currentPath!.startsWith('/phone-check') || widget.currentPath!.startsWith('/file-check') || widget.currentPath!.startsWith('/link-check') || widget.currentPath!.startsWith('/password-check')) return 1;
    if (widget.currentPath!.startsWith('/security') || widget.currentPath!.startsWith('/tools') || widget.currentPath!.startsWith('/threats')) return 2;
    if (widget.currentPath!.startsWith('/profile') || widget.currentPath!.startsWith('/premium') || widget.currentPath!.startsWith('/notifications')) return 3;
    return -1;
  }

  String _getTitle() {
    switch (widget.currentPath) {
      case '/checks': return 'Все Проверки';
      case '/email-check': return 'Проверка e-mail';
      case '/email-check-result': return 'Проверка e-mail';
      case '/phone-check': return 'Проверка номера';
      case '/phone-check-result': return 'Проверка номера';
      case '/file-check': return 'Проверка файла';
      case '/file-check-result': return 'Проверка файла';
      case '/link-check': return 'Проверка ссылки';
      case '/link-check-result': return 'Проверка ссылки';
      case '/password-check': return 'Утечки данных';
      case '/profile': return 'Мой профиль';
      case '/profile/edit': return 'Личные данные';
      case '/profile/app-settings': return 'Настройка';
      case '/profile/security': return 'Безопасность';
      case '/profile/active-sessions': return 'Устройства';
      case '/profile/change-password': return 'Пароль';
      case '/profile/backup-codes': return 'Резервные коды';
      case '/profile/payment-methods': return 'Способы оплаты';
      case '/profile/add-card': return 'Добавить карту';
      case '/profile/payment-history': return 'История оплаты';
      case '/profile/payment-receipt': return 'Чек по операции';
      case '/profile/support': return 'Поддержка';
      case '/profile/about': return 'О приложении';
      case '/monitoring': return 'Data Exposure';
      case '/threats': return 'История утечек';
      case '/threat-detail': return 'Карточка утечки';
      case '/advisor': return 'Cyber Advisor';
      case '/password-center': return 'Password Center';
      case '/password-strength': return 'Сила пароля';
      case '/password-check': return 'Утечки данных';
      case '/weekly-report': return 'Weekly Report';
      case '/tariffs': return 'Подписка и тарифы';
      case '/premium': return 'Подписка и тарифы';
      case '/notifications': return 'Уведомления';
      case '/notifications/settings': return 'Настройка уведомлений';
      case '/security-score': return 'Рейтинг безопасности';
      default: return '';
    }
  }

  bool _showBackButton() {
    if (widget.currentPath == '/dashboard') return false;
    return true;
  }

  int? _getActiveIndex() {
    if (widget.currentPath == '/dashboard') return 0;
    if (widget.currentPath == '/checks' || widget.currentPath?.startsWith('/email-check') == true || widget.currentPath?.startsWith('/phone-check') == true || widget.currentPath?.startsWith('/file-check') == true || widget.currentPath?.startsWith('/link-check') == true || widget.currentPath?.startsWith('/password-check') == true) return 1;
    if (widget.currentPath == '/security-score') return 2;
    if (widget.currentPath == '/profile' || widget.currentPath?.startsWith('/profile/') == true || widget.currentPath == '/tariffs' || widget.currentPath == '/payment-methods' || widget.currentPath == '/payment-history') return 3;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final title = _getTitle();
    final showBackButton = _showBackButton();
    final activeIndex = _getActiveIndex();
    final screenWidth = MediaQuery.of(context).size.width;
    final canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    double s(double value) => value * (canvasWidth / 393);
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF060E11),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF060E11),
        child: Center(
          child: Container(
            width: canvasWidth,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF060E11),
              gradient: LinearGradient(
                begin: Alignment(0.0, 1.0),
                end: Alignment(0.0, -0.1),
                colors: [
                  Color(0x476EAF91),
                  Colors.transparent,
                ],
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
              // Main content
              Positioned.fill(
                bottom: s(96) + bottomPadding,
                child: widget.child,
              ),
              
              // Fixed Bottom Navigation Bar
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: s(96) + bottomPadding,
                child: _buildBottomNavigationBar(context, s, bottomPadding),
              ),
              // Fixed Top Header (Title)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF060E11),
                        const Color(0xFF060E11).withOpacity(0.9),
                        const Color(0xFF060E11).withOpacity(0.0),
                      ],
                      stops: const [0.5, 0.8, 1.0],
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Top Padding for status bar / safe area
                      SizedBox(height: MediaQuery.of(context).padding.top > 0 ? MediaQuery.of(context).padding.top + s(4) : s(8)),
                      
                      // Title and Back Button
                      if (title.isNotEmpty)
                        Container(
                          padding: EdgeInsets.only(top: s(4), bottom: s(4)),
                          height: s(40),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: s(24)),
                            child: Row(
                              children: [
                                showBackButton
                                    ? Expanded(
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            if (context.canPop()) {
                                              context.pop();
                                            } else {
                                              context.go('/dashboard');
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.arrow_back_ios_new,
                                                color: Colors.white,
                                                size: s(20),
                                              ),
                                              SizedBox(width: s(8)),
                                              Expanded(
                                                child: Text(
                                                  title,
                                                  style: TextStyle(
                                                    fontFamily: 'GoogleSans',
                                                    color: Colors.white,
                                                    fontSize: s(20),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                     : Expanded(
                                         child: Text(
                                           title,
                                           style: TextStyle(
                                             fontFamily: 'GoogleSans',
                                             color: Colors.white,
                                             fontSize: s(20),
                                             fontWeight: FontWeight.w400,
                                           ),
                                           overflow: TextOverflow.ellipsis,
                                         ),
                                       ),
                                 if (widget.currentPath != '/dashboard' && widget.currentPath != '/notifications')
                                   GestureDetector(
                                     behavior: HitTestBehavior.opaque,
                                     onTap: () {
                                       context.push('/notifications');
                                     },
                                     child: SvgPicture.asset(
                                       'assets/images/bell.svg',
                                       width: s(24),
                                       colorFilter: const ColorFilter.mode(Color(0xFF6EAF91), BlendMode.srcIn),
                                     ),
                                   ),
                              ],
                            ),
                          ),
                        )
                      else
                        SizedBox(height: s(20)), // Give Dashboard some gradient background too
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  }

  Widget _buildStatusBar(double Function(double) s) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: s(24)),
      height: s(54),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '1:47',
            style: TextStyle(
              fontFamily: 'GoogleSans',
              color: Colors.white,
              fontSize: s(16),
              fontWeight: FontWeight.w600,
              letterSpacing: -0.44,
            ),
          ),
          Row(
            children: [
              Icon(Icons.signal_cellular_4_bar, color: Colors.white, size: s(16)),
              SizedBox(width: s(6)),
              Icon(Icons.wifi, color: Colors.white, size: s(16)),
              SizedBox(width: s(6)),
              Icon(Icons.battery_full, color: Colors.white, size: s(18)),
            ],
          ),
        ],
      ),
    );
  }

  // _buildStatusBar removed

  Widget _buildBottomNavigationBar(BuildContext context, double Function(double) s, double bottomPadding) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: s(96) + bottomPadding,
          decoration: BoxDecoration(
            color: const Color(0xFF060E11).withOpacity(0.38),
            border: Border(
              top: BorderSide(
                color: const Color(0xFF6EAF91).withOpacity(0.10),
                width: 1,
              ),
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            height: s(96),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: s(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildNavItem(context, 0, 'assets/images/material-symbols_home-rounded.svg', 'Дом', s, activeIndex),
                  _buildNavItem(context, 1, 'assets/images/ep_menu.svg', 'проверки', s, activeIndex),
                  SizedBox(width: s(80)), // Center gap for the FAB
                  _buildNavItem(context, 2, 'assets/images/mage_security-shield-fill.svg', 'Score', s, activeIndex),
                  _buildNavItem(context, 3, 'assets/images/iconamoon_profile-fill.svg', 'Профиль', s, activeIndex),
                ],
              ),
            ),
          ),
          Positioned(
            top: s(8), // Centers the 80px FAB vertically within the 96px toolbar height
            left: 0,
            right: 0,
            child: Center(
              child: _buildFabItem(context, s),
            ),
          ),
        ],
      ),
    ),
  ),
);
  }

  Widget _buildNavItem(BuildContext context, int index, String iconPath, String label, double Function(double) s, int? activeIndex) {
    final isSelected = index == activeIndex;
    final color = isSelected ? const Color(0xFFD1FFEA) : Colors.white.withOpacity(0.4);
    return BouncyButton(
      onTap: () {
        if (index == 0) {
          context.go('/dashboard');
        } else if (index == 1) {
          context.go('/checks');
        } else if (index == 2) {
          context.go('/security-score');
        } else if (index == 3) {
          context.go('/profile');
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: s(4)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: s(28),
              height: s(28),
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            SizedBox(height: s(4)),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.visible,
              style: TextStyle(
                fontFamily: 'GoogleSans',
                color: color,
                fontSize: s(10),
                fontWeight: FontWeight.w400,
                height: 1.30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFabItem(BuildContext context, double Function(double) s) {
    return BouncyButton(
      pressedScale: 0.92,
      onTap: () {
        if (widget.currentPath != '/advisor') {
          context.push('/advisor');
        }
      },
      child: Container(
        width: s(80),
        height: s(80),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(s(32)),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6EAF91),
              Color(0xFFD1FFEA),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00FF88).withOpacity(0.25),
              blurRadius: 18,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: const Color(0xFF00FF88),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
          border: Border.all(
            color: const Color(0xFFD1FFEA),
            width: 2,
          ),
        ),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(s(9)),
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/images/cyber-advisor-icon.png',
                width: s(41),
                height: s(46),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
