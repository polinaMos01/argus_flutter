import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_toast.dart';

class PasswordCheckScreen extends StatefulWidget {
  const PasswordCheckScreen({super.key});

  @override
  State<PasswordCheckScreen> createState() => _PasswordCheckScreenState();
}

class _PasswordCheckScreenState extends State<PasswordCheckScreen> {
  final _passwordController = TextEditingController();
  bool _hasChecked = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
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
              SizedBox(height: 96 * s), // 114px header height + 48px exact Figma margin

              // Top Instruction & Input Box (Figma Screenshot 2 - Node 277-2072)
              Container(
                padding: EdgeInsets.all(20 * s),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9).withOpacity(0.03),
                  borderRadius: BorderRadius.circular(20 * s),
                  border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Введите пароль. Мы проверим только хэш — сам пароль никуда не передаётся.',
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: const Color(0xFFACACAC),
                        fontSize: 14 * s,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 16 * s),

                    Container(
                      height: 52 * s,
                      padding: EdgeInsets.symmetric(horizontal: 16 * s),
                      decoration: BoxDecoration(
                        color: const Color(0xFF091417),
                        borderRadius: BorderRadius.circular(14 * s),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        obscuringCharacter: '•',
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          color: Colors.white,
                          fontSize: 16 * s,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Введите пароль',
                          hintStyle: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white30,
                            fontSize: 15 * s,
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
                  ],
                ),
              ),

              SizedBox(height: 20 * s),

              // Design System Action Button: Проверить бесплатно
              AppButton(
                text: 'Проверить бесплатно',
                onTap: () {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    _hasChecked = true;
                  });
                  showAppToast(context, 'Пароль найден в 847 базах утечек!');
                },
              ),

              // Leak Result Red Card (Figma Screenshot 1 - Node 365-5568)
              if (_hasChecked) ...[
                SizedBox(height: 24 * s),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20 * s),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E1517).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(24 * s),
                    border: Border.all(color: const Color(0xFFFF4B4B).withOpacity(0.5), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF4B4B).withOpacity(0.15),
                        blurRadius: 20 * s,
                        offset: Offset(0, 4 * s),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 44 * s,
                                height: 44 * s,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF4B4B).withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(Icons.error_outline_rounded, color: const Color(0xFFFF4B4B), size: 24 * s),
                                ),
                              ),
                              SizedBox(width: 14 * s),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'НАЙДЕН В УТЕЧКАХ',
                                    style: TextStyle(
                                      fontFamily: 'GoogleSans',
                                      color: const Color(0xFFFF4B4B),
                                      fontSize: 15 * s,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                  SizedBox(height: 2 * s),
                                  Text(
                                    'Пароль скомпрометирован',
                                    style: TextStyle(
                                      fontFamily: 'GoogleSans',
                                      color: const Color(0xFFFF4B4B).withOpacity(0.8),
                                      fontSize: 12 * s,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            '847',
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: const Color(0xFFFF4B4B),
                              fontSize: 32 * s,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16 * s),
                      Divider(color: Colors.white.withOpacity(0.08), height: 1),
                      SizedBox(height: 16 * s),

                      _buildDetailRow(s, label: 'Встречался раз', value: '847', isRedValue: true),
                      SizedBox(height: 10 * s),
                      _buildDetailRow(s, label: 'Первая утечка', value: '2019', isRedValue: false),
                      SizedBox(height: 16 * s),

                      Text(
                        'Немедленно смените этот пароль везде.',
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          color: const Color(0xFFACACAC),
                          fontSize: 13 * s,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24 * s),

                // Design System Action Button: Сгенерировать новый
                AppButton(
                  text: 'Сгенерировать новый',
                  onTap: () {
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

  Widget _buildDetailRow(double s, {required String label, required String value, required bool isRedValue}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'GoogleSans',
            color: Colors.white.withOpacity(0.9),
            fontSize: 14 * s,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'GoogleSans',
            color: isRedValue ? const Color(0xFFFF4B4B) : Colors.white,
            fontSize: 14 * s,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
