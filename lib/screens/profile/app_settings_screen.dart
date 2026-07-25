import 'dart:ui';
import 'package:flutter/material.dart';
import '../../widgets/app_toast.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  bool _isDarkTheme = true;
  bool _autoCheck = true;
  bool _biometrics = true;
  String _location = 'При использовании';
  String _cacheSize = '48.5 МБ';

  void _showLocationPickerModal(BuildContext context, double s) {
    final options = [
      'При использовании',
      'Точная (GPS)',
      'Всегда',
      'Запрещена',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF060E11),
      builder: (modalContext) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20 * s)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: EdgeInsets.all(20 * s),
              decoration: BoxDecoration(
                color: const Color(0xFF0D1B16).withOpacity(0.95),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20 * s)),
                border: Border.all(color: const Color(0x51D9D9D9)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 36 * s,
                      height: 4 * s,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(2 * s),
                      ),
                    ),
                  ),
                  SizedBox(height: 16 * s),
                  Text(
                    'Доступ к геолокации',
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: Colors.white,
                      fontSize: 18 * s,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 14 * s),
                  Column(
                    children: options.map((opt) {
                      final isSelected = _location == opt;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _location = opt;
                          });
                          Navigator.pop(modalContext);
                          showAppToast(context, 'Геолокация: $opt');
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10 * s),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                opt,
                                style: TextStyle(
                                  fontFamily: 'GoogleSans',
                                  color: isSelected ? const Color(0xFF6EAF91) : Colors.white,
                                  fontSize: 16 * s,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              if (isSelected)
                                Icon(Icons.check, color: const Color(0xFF6EAF91), size: 18 * s),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16 * s),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;

    return Scaffold(
      backgroundColor: const Color(0xFF060E11),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24 * s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 126 * s), // MainLayout top header padding

              // SECTION 1: Тема & Автопроверка
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12 * s),
                  border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    // Item 1: Тема (Toggle with Sun & Moon icons)
                    _buildSettingTile(
                      s,
                      icon: Icons.wb_sunny_outlined,
                      title: 'Тема',
                      valueWidget: _buildThemeToggle(
                        s,
                        _isDarkTheme,
                        (val) {
                          setState(() {
                            _isDarkTheme = val;
                          });
                          showAppToast(context, _isDarkTheme ? 'Тёмная тема' : 'Светлая тема');
                        },
                      ),
                      onTap: () {},
                    ),
                    Divider(color: Colors.white.withOpacity(0.12), height: 1),

                    // Item 2: Автопроверка (Simple ON/OFF switch)
                    _buildSettingTile(
                      s,
                      icon: Icons.published_with_changes_rounded,
                      title: 'Автопроверка',
                      valueWidget: _buildSwitchToggle(
                        s,
                        _autoCheck,
                        (val) {
                          setState(() {
                            _autoCheck = val;
                          });
                          showAppToast(context, _autoCheck ? 'Автопроверка включена' : 'Автопроверка выключена');
                        },
                      ),
                      onTap: () {
                        setState(() {
                          _autoCheck = !_autoCheck;
                        });
                        showAppToast(context, _autoCheck ? 'Автопроверка включена' : 'Автопроверка выключена');
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24 * s),

              // SECTION 2: Конфиденциальность
              Text(
                'Конфиденциальность',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 13 * s),

              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12 * s),
                  border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    // Item 1: Face ID / Touch ID (Simple ON/OFF switch)
                    _buildSettingTile(
                      s,
                      icon: Icons.fingerprint_rounded,
                      title: 'Face ID / Touch ID',
                      valueWidget: _buildSwitchToggle(
                        s,
                        _biometrics,
                        (val) {
                          setState(() {
                            _biometrics = val;
                          });
                          showAppToast(context, _biometrics ? 'Face ID включен' : 'Face ID отключен');
                        },
                      ),
                      onTap: () {
                        setState(() {
                          _biometrics = !_biometrics;
                        });
                        showAppToast(context, _biometrics ? 'Face ID включен' : 'Face ID отключен');
                      },
                    ),
                    Divider(color: Colors.white.withOpacity(0.12), height: 1),

                    // Item 2: Геолокация (Opens Popup Modal Sheet)
                    _buildSettingTile(
                      s,
                      icon: Icons.location_on_outlined,
                      title: 'Геолокация',
                      valueWidget: Row(
                        children: [
                          Text(
                            _location,
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: const Color(0xFF6EAF91),
                              fontSize: 14 * s,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 4 * s),
                          Icon(Icons.chevron_right, color: Colors.white54, size: 16 * s),
                        ],
                      ),
                      onTap: () => _showLocationPickerModal(context, s),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24 * s),

              // SECTION 3: Данные
              Text(
                'Данные',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 13 * s),

              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12 * s),
                  border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.2)),
                ),
                child: _buildSettingTile(
                  s,
                  icon: Icons.cleaning_services_outlined,
                  title: 'Очистить кэш',
                  valueWidget: Text(
                    _cacheSize,
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: const Color(0xFFACACAC),
                      fontSize: 14 * s,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _cacheSize = '0.0 МБ';
                    });
                    showAppToast(context, 'Кэш приложения успешно очищен');
                  },
                ),
              ),

              SizedBox(height: 120 * s),
            ],
          ),
        ),
      ),
    );
  }

  // Theme Toggle: Sun ☀️ and Moon 🌙 Icons
  Widget _buildThemeToggle(double s, bool isDark, ValueChanged<bool> onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!isDark),
      child: Container(
        width: 58 * s,
        height: 30 * s,
        padding: EdgeInsets.all(3 * s),
        decoration: BoxDecoration(
          color: const Color(0xFF091417),
          borderRadius: BorderRadius.circular(15 * s),
          border: Border.all(color: const Color(0xFF6EAF91).withOpacity(0.3)),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 24 * s,
                height: 24 * s,
                decoration: const BoxDecoration(
                  color: Color(0xFF6EAF91),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    isDark ? Icons.nights_stay_outlined : Icons.wb_sunny_outlined,
                    color: Colors.white,
                    size: 13 * s,
                  ),
                ),
              ),
            ),
            Align(
              alignment: isDark ? Alignment.centerLeft : Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4 * s),
                child: Icon(
                  isDark ? Icons.wb_sunny_outlined : Icons.nights_stay_outlined,
                  color: Colors.white38,
                  size: 13 * s,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Simple ON/OFF Switch Toggle
  Widget _buildSwitchToggle(double s, bool value, ValueChanged<bool> onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 46 * s,
        height: 26 * s,
        padding: EdgeInsets.all(2 * s),
        decoration: BoxDecoration(
          color: value ? const Color(0xFF6EAF91) : const Color(0xFF091417),
          borderRadius: BorderRadius.circular(13 * s),
          border: Border.all(
            color: value ? const Color(0xFF6EAF91) : Colors.white24,
          ),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20 * s,
            height: 20 * s,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingTile(
    double s, {
    required IconData icon,
    required String title,
    required Widget valueWidget,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16 * s, vertical: 12 * s),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 38 * s,
                  height: 38 * s,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9).withOpacity(0.03),
                    borderRadius: BorderRadius.circular(9 * s),
                    border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.1)),
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: const Color(0xFF6EAF91),
                      size: 17 * s, // Thinner icon size
                    ),
                  ),
                ),
                SizedBox(width: 14 * s),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    color: Colors.white,
                    fontSize: 14 * s, // 14px matching Profile menu items
                    fontWeight: FontWeight.w400, // No bold
                  ),
                ),
              ],
            ),
            valueWidget,
          ],
        ),
      ),
    );
  }
}
