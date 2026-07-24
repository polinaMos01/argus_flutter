import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/app_toast.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool _isSmsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24 * s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 96 * s), // MainLayout header padding

              // Top Status Card: Аккаунт защищён (Figma Node 131-1327)
              ClipRRect(
                borderRadius: BorderRadius.circular(14 * s),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.85, sigmaY: 3.85),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20 * s),
                    decoration: BoxDecoration(
                      color: const Color(0x08D9D9D9),
                      borderRadius: BorderRadius.circular(14 * s),
                      border: Border.all(color: const Color(0xFF6EAF91)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 32 * s,
                              height: 32 * s,
                              decoration: BoxDecoration(
                                color: const Color(0x306EAF91),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.shield_outlined,
                                  color: const Color(0xFF6EAF91),
                                  size: 16 * s,
                                ),
                              ),
                            ),
                            SizedBox(width: 10 * s),
                            Text(
                              'Аккаунт защищён',
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: const Color(0xFF6EAF91),
                                fontSize: 18 * s,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6 * s),
                        Text(
                          '2FA включена',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white.withOpacity(0.67),
                            fontSize: 14 * s,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 26 * s),

              // Section 1 Header: Двухфакторная защита
              Text(
                'Двухфакторная защита',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w400,
                  height: 1.30,
                ),
              ),
              SizedBox(height: 12 * s),

              // Item 1: SMS-код
              Container(
                width: double.infinity,
                height: 56 * s,
                padding: EdgeInsets.symmetric(horizontal: 16 * s),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 36 * s,
                          height: 36 * s,
                          decoration: BoxDecoration(
                            color: const Color(0x186EAF91),
                            borderRadius: BorderRadius.circular(8 * s),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.sms_outlined,
                              color: const Color(0xFF6EAF91),
                              size: 18 * s,
                            ),
                          ),
                        ),
                        SizedBox(width: 14 * s),
                        Text(
                          'SMS-код',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white,
                            fontSize: 16 * s,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),

                    // Unified Switch Toggle (Matching Figma Node 131-1327)
                    _buildSwitchToggle(
                      s,
                      _isSmsEnabled,
                      (val) {
                        setState(() {
                          _isSmsEnabled = val;
                        });
                        showAppToast(
                          context,
                          _isSmsEnabled ? 'SMS-код включён' : 'SMS-код отключён',
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 28 * s),

              // Section 2 Header: Сессии и пароль
              Text(
                'Сессии и пароль',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w400,
                  height: 1.30,
                ),
              ),
              SizedBox(height: 12 * s),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0x12D9D9D9),
                  borderRadius: BorderRadius.circular(14 * s),
                ),
                child: Column(
                  children: [
                    // Item 1: Завершить все сессии
                    GestureDetector(
                      onTap: () {
                        showAppToast(context, 'Все сессии успешно завершены');
                      },
                      child: Container(
                        width: double.infinity,
                        height: 56 * s,
                        padding: EdgeInsets.symmetric(horizontal: 16 * s),
                        child: Row(
                          children: [
                            Container(
                              width: 36 * s,
                              height: 36 * s,
                              decoration: BoxDecoration(
                                color: const Color(0x18B21010),
                                borderRadius: BorderRadius.circular(8 * s),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.logout_rounded,
                                  color: const Color(0xFFB20F0F),
                                  size: 18 * s,
                                ),
                              ),
                            ),
                            SizedBox(width: 14 * s),
                            Text(
                              'Завершить все сессии',
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: const Color(0xFFB20F0F),
                                fontSize: 16 * s,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Divider(color: Colors.white.withOpacity(0.07), height: 1),

                    // Item 2: Изменить пароль
                    GestureDetector(
                      onTap: () => context.push('/profile/change-password'),
                      child: Container(
                        width: double.infinity,
                        height: 56 * s,
                        padding: EdgeInsets.symmetric(horizontal: 16 * s),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 36 * s,
                                  height: 36 * s,
                                  decoration: BoxDecoration(
                                    color: const Color(0x186EAF91),
                                    borderRadius: BorderRadius.circular(8 * s),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.lock_outline_rounded,
                                      color: const Color(0xFF6EAF91),
                                      size: 18 * s,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 14 * s),
                                Text(
                                  'Изменить пароль',
                                  style: TextStyle(
                                    fontFamily: 'GoogleSans',
                                    color: Colors.white,
                                    fontSize: 16 * s,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.white54,
                              size: 18 * s,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 120 * s),
            ],
          ),
        ),
      ),
    );
  }

  // Unified Custom Toggle Switch
  Widget _buildSwitchToggle(double s, bool value, ValueChanged<bool> onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 50 * s,
        height: 28 * s,
        padding: EdgeInsets.all(2 * s),
        decoration: BoxDecoration(
          color: value ? const Color(0xFF6EAF91) : const Color(0xFF091417),
          borderRadius: BorderRadius.circular(14 * s),
          border: Border.all(
            color: value ? const Color(0xFF6EAF91) : Colors.white24,
          ),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 24 * s,
            height: 24 * s,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
