import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/app_toast.dart';

class PasswordCenterScreen extends StatefulWidget {
  const PasswordCenterScreen({super.key});

  @override
  State<PasswordCenterScreen> createState() => _PasswordCenterScreenState();
}

class _PasswordCenterScreenState extends State<PasswordCenterScreen> {
  double _passwordLength = 16;
  bool _useUppercase = true;
  bool _useLowercase = false;
  bool _useNumbers = true;
  bool _useSymbols = true;
  String _generatedPassword = 'Xk#9mP!vN2@qR7sL';

  void _generatePassword() {
    const uppercaseChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const lowercaseChars = 'abcdefghijklmnopqrstuvwxyz';
    const numberChars = '0123456789';
    const symbolChars = '!@#\$%^&*()_+-=[]{}|;:,.<>?';

    String allowedChars = '';
    if (_useUppercase) allowedChars += uppercaseChars;
    if (_useLowercase) allowedChars += lowercaseChars;
    if (_useNumbers) allowedChars += numberChars;
    if (_useSymbols) allowedChars += symbolChars;

    if (allowedChars.isEmpty) {
      allowedChars = uppercaseChars + lowercaseChars + numberChars;
    }

    final rand = Random();
    final result = List.generate(
      _passwordLength.toInt(),
      (_) => allowedChars[rand.nextInt(allowedChars.length)],
    ).join('');

    setState(() {
      _generatedPassword = result;
    });
  }

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
              SizedBox(height: 96 * s), // Header offset + top spacing

              // Top Generator Card
              Container(
                padding: EdgeInsets.all(20 * s),
                decoration: BoxDecoration(
                  color: const Color(0xFF101E17).withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20 * s),
                  border: Border.all(color: const Color(0xFF6EAF91).withOpacity(0.12), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Generated Password Output Field
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16 * s, vertical: 16 * s),
                      decoration: BoxDecoration(
                        color: const Color(0xFF091417),
                        borderRadius: BorderRadius.circular(14 * s),
                        border: Border.all(color: Colors.white.withOpacity(0.08)),
                      ),
                      child: Text(
                        _generatedPassword,
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          color: Colors.white,
                          fontSize: 16 * s,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    SizedBox(height: 16 * s),

                    // Action Buttons: [Refresh] Обновить & [Copy] Копировать (FontWeight.w400, thinner icons)
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: _generatePassword,
                            child: Container(
                              height: 48 * s,
                              decoration: BoxDecoration(
                                color: const Color(0xFF6EAF91),
                                borderRadius: BorderRadius.circular(24 * s),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.refresh_rounded, color: Colors.white, size: 16 * s),
                                  SizedBox(width: 8 * s),
                                  Text(
                                    'Обновить',
                                    style: TextStyle(
                                      fontFamily: 'GoogleSans',
                                      color: Colors.white,
                                      fontSize: 14 * s,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12 * s),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: _generatedPassword));
                              showAppToast(context, 'Пароль скопирован в буфер');
                            },
                            child: Container(
                              height: 48 * s,
                              decoration: BoxDecoration(
                                color: const Color(0xFF091417),
                                borderRadius: BorderRadius.circular(24 * s),
                                border: Border.all(color: Colors.white.withOpacity(0.3)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.copy_outlined, color: Colors.white, size: 16 * s),
                                  SizedBox(width: 8 * s),
                                  Text(
                                    'Копировать',
                                    style: TextStyle(
                                      fontFamily: 'GoogleSans',
                                      color: Colors.white,
                                      fontSize: 14 * s,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24 * s),

                    // Slider: Длина (16 символов)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Длина',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: const Color(0xFFACACAC),
                            fontSize: 14 * s,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '${_passwordLength.toInt()} символов',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white,
                            fontSize: 14 * s,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8 * s),

                    SliderTheme(
                      data: SliderThemeData(
                        activeTrackColor: const Color(0xFF6EAF91),
                        inactiveTrackColor: Colors.white24,
                        thumbColor: const Color(0xFF6EAF91),
                        overlayColor: const Color(0xFF6EAF91).withOpacity(0.2),
                        trackHeight: 4 * s,
                      ),
                      child: Slider(
                        value: _passwordLength,
                        min: 8,
                        max: 32,
                        divisions: 24,
                        onChanged: (val) {
                          setState(() {
                            _passwordLength = val;
                          });
                          _generatePassword();
                        },
                      ),
                    ),

                    SizedBox(height: 12 * s),

                    // Checkboxes: Options (-2px size, FontWeight.w400)
                    _buildCheckboxTile(
                      s,
                      title: 'Заглавные буквы',
                      value: _useUppercase,
                      onChanged: (v) {
                        setState(() => _useUppercase = v!);
                        _generatePassword();
                      },
                    ),
                    _buildCheckboxTile(
                      s,
                      title: 'Строчные буквы',
                      value: _useLowercase,
                      onChanged: (v) {
                        setState(() => _useLowercase = v!);
                        _generatePassword();
                      },
                    ),
                    _buildCheckboxTile(
                      s,
                      title: 'Цифры',
                      value: _useNumbers,
                      onChanged: (v) {
                        setState(() => _useNumbers = v!);
                        _generatePassword();
                      },
                    ),
                    _buildCheckboxTile(
                      s,
                      title: 'Спецсимволы',
                      value: _useSymbols,
                      onChanged: (v) {
                        setState(() => _useSymbols = v!);
                        _generatePassword();
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 28 * s),

              // Subtitle: Проверка
              Text(
                'Проверка',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w400,
                  height: 1.30,
                ),
              ),
              SizedBox(height: 14 * s),

              // Nav Item 1: Проверка силы пароля (FontWeight.w400)
              _buildNavTile(
                s,
                title: 'Проверка силы пароля',
                onTap: () => context.push('/password-strength'),
              ),
              SizedBox(height: 10 * s),

              // Nav Item 2: Утечки данных (FontWeight.w400)
              _buildNavTile(
                s,
                title: 'Утечки данных',
                onTap: () => context.push('/password-check'),
              ),

              SizedBox(height: 120 * s),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxTile(
    double s, {
    required String title,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8 * s),
        child: Row(
          children: [
            Container(
              width: 20 * s,
              height: 20 * s,
              decoration: BoxDecoration(
                color: value ? const Color(0xFF6EAF91) : Colors.transparent,
                borderRadius: BorderRadius.circular(5 * s),
                border: Border.all(
                  color: value ? const Color(0xFF6EAF91) : Colors.white38,
                  width: 1.0,
                ),
              ),
              child: value
                  ? Icon(Icons.check, color: const Color(0xFF060E11), size: 14 * s)
                  : null,
            ),
            SizedBox(width: 12 * s),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'GoogleSans',
                color: Colors.white,
                fontSize: 13 * s, // Reduced by 2px (from 15 to 13)
                fontWeight: FontWeight.w400, // No bold
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavTile(double s, {required String title, required VoidCallback onTap}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18 * s, vertical: 16 * s),
        decoration: BoxDecoration(
          color: const Color(0xFF101E17).withOpacity(0.4),
          borderRadius: BorderRadius.circular(16 * s),
          border: Border.all(color: const Color(0xFF6EAF91).withOpacity(0.12), width: 1.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'GoogleSans',
                color: Colors.white,
                fontSize: 14 * s,
                fontWeight: FontWeight.w400, // Removed bold weight
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.white70, size: 18 * s),
          ],
        ),
      ),
    );
  }
}
