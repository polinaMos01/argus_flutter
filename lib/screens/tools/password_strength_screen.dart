import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_toast.dart';

class PasswordStrengthScreen extends StatefulWidget {
  const PasswordStrengthScreen({super.key});

  @override
  State<PasswordStrengthScreen> createState() => _PasswordStrengthScreenState();
}

class _PasswordStrengthScreenState extends State<PasswordStrengthScreen> {
  final _controller = TextEditingController();
  bool _obscurePassword = true;
  bool _hasAnalyzed = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Map<String, dynamic> _evaluateStrength(String pwd) {
    final hasUpper = pwd.contains(RegExp(r'[A-ZА-Я]'));
    final hasLower = pwd.contains(RegExp(r'[a-zа-я]'));
    final hasDigits = pwd.contains(RegExp(r'[0-9]'));
    final hasSpecial = pwd.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>\-_=+]'));
    final length = pwd.length;

    int points = 0;
    if (length >= 8) points++;
    if (length >= 12) points++;
    if (length >= 16) points++;
    if (hasUpper) points++;
    if (hasLower) points++;
    if (hasDigits) points++;
    if (hasSpecial) points++;

    String title;
    String time;
    Color color;
    double score;

    if (points <= 2 || length < 6) {
      title = 'Ненадёжный';
      time = 'Взлом займёт ~1 минуту';
      color = const Color(0xFFFF4B4B);
      score = 0.25;
    } else if (points <= 4) {
      title = 'Средний уровень';
      time = 'Взлом займёт ~3 дня';
      color = const Color(0xFFFFB74D);
      score = 0.50;
    } else if (points <= 6) {
      title = 'Надёжный';
      time = 'Взлом займёт ~10 лет';
      color = const Color(0xFF6EAF91);
      score = 0.80;
    } else {
      title = 'Очень надёжный';
      time = 'Взлом займёт ~1000+ лет';
      color = const Color(0xFF00FF88);
      score = 1.0;
    }

    return {
      'title': title,
      'time': time,
      'color': color,
      'score': score,
      'hasUpper': hasUpper,
      'hasLower': hasLower,
      'hasDigits': hasDigits,
      'hasSpecial': hasSpecial,
      'length': length,
    };
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;

    final eval = _evaluateStrength(_controller.text);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24 * s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 96 * s), // 114px header height + 48px exact Figma margin

              // Top Input Field
              Container(
                height: 52 * s,
                padding: EdgeInsets.symmetric(horizontal: 18 * s),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9).withOpacity(0.04),
                  borderRadius: BorderRadius.circular(16 * s),
                  border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.2)),
                ),
                child: TextField(
                  controller: _controller,
                  obscureText: _obscurePassword,
                  obscuringCharacter: '•',
                  onChanged: (_) {
                    if (_hasAnalyzed) {
                      setState(() {});
                    }
                  },
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    color: Colors.white,
                    fontSize: 20 * s,
                    letterSpacing: _obscurePassword ? 4.0 : 0.0,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Введите пароль',
                    hintStyle: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: Colors.white30,
                      fontSize: 16 * s,
                      letterSpacing: 0,
                    ),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: Colors.white.withOpacity(0.5),
                        size: 22 * s,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20 * s),

              // Button: Проверить силу
              AppButton(
                text: 'Проверить силу пароля',
                onTap: () {
                  if (_controller.text.isNotEmpty) {
                    setState(() {
                      _hasAnalyzed = true;
                    });
                  } else {
                    showAppToast(context, 'Введите пароль для проверки!');
                  }
                },
              ),

              SizedBox(height: 24 * s),

              // Strength Analysis Card (Appears only after pressing check button)
              if (_hasAnalyzed) ...[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24 * s),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9).withOpacity(0.03),
                    borderRadius: BorderRadius.circular(24 * s),
                    border: Border.all(color: (eval['color'] as Color).withOpacity(0.4), width: 1.5),
                  ),
                  child: Column(
                    children: [
                      Text(
                        eval['title'] as String,
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          color: eval['color'] as Color,
                          fontSize: 26 * s,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 6 * s),
                      Text(
                        eval['time'] as String,
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          color: const Color(0xFFACACAC),
                          fontSize: 14 * s,
                        ),
                      ),
                      SizedBox(height: 20 * s),

                      // Strength Indicator Bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3 * s),
                        child: Container(
                          height: 6 * s,
                          width: double.infinity,
                          color: Colors.white.withOpacity(0.1),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: eval['score'] as double,
                            child: Container(
                              color: eval['color'] as Color,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24 * s),

                      // Criteria Checklist
                      _buildCheckLine(
                        s,
                        icon: (eval['hasUpper'] && eval['hasLower']) ? Icons.check : Icons.close,
                        iconColor: (eval['hasUpper'] && eval['hasLower']) ? const Color(0xFF6EAF91) : const Color(0xFFFF4B4B),
                        text: 'Заглавные и строчные буквы',
                      ),
                      SizedBox(height: 12 * s),
                      _buildCheckLine(
                        s,
                        icon: eval['hasDigits'] ? Icons.check : Icons.close,
                        iconColor: eval['hasDigits'] ? const Color(0xFF6EAF91) : const Color(0xFFFF4B4B),
                        text: 'Цифры (0-9)',
                      ),
                      SizedBox(height: 12 * s),
                      _buildCheckLine(
                        s,
                        icon: eval['hasSpecial'] ? Icons.check : Icons.close,
                        iconColor: eval['hasSpecial'] ? const Color(0xFF6EAF91) : const Color(0xFFFF4B4B),
                        text: r'Специальные символы (!@#$%...)',
                      ),
                      SizedBox(height: 12 * s),
                      _buildCheckLine(
                        s,
                        icon: (eval['length'] as int) >= 12
                            ? Icons.check
                            : ((eval['length'] as int) >= 8 ? Icons.warning_amber_rounded : Icons.close),
                        iconColor: (eval['length'] as int) >= 12
                            ? const Color(0xFF6EAF91)
                            : ((eval['length'] as int) >= 8 ? const Color(0xFFFFB74D) : const Color(0xFFFF4B4B)),
                        text: 'Длина ${eval['length']} символов ${(eval['length'] as int) < 12 ? "(рекомендуется 12+)" : ""}',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24 * s),
                AppButton(
                  text: 'Сгенерировать лучший',
                  onTap: () {
                    showAppToast(context, 'Сгенерирован более надежный пароль!');
                    context.push('/password-center');
                  },
                ),
              ],

              SizedBox(height: 120 * s),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckLine(double s, {required IconData icon, required Color iconColor, required String text}) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 18 * s),
        SizedBox(width: 10 * s),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'GoogleSans',
              color: Colors.white.withOpacity(0.9),
              fontSize: 14 * s,
            ),
          ),
        ),
      ],
    );
  }
}
