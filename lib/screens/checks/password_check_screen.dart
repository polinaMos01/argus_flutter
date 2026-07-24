import 'dart:ui';
import 'package:flutter/material.dart';

class PasswordCheckScreen extends StatefulWidget {
  const PasswordCheckScreen({Key? key}) : super(key: key);

  @override
  State<PasswordCheckScreen> createState() => _PasswordCheckScreenState();
}

class _PasswordCheckScreenState extends State<PasswordCheckScreen> {
  bool _isChecked = false;
  bool _obscurePassword = true;
  final TextEditingController _passwordController = TextEditingController();

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
      backgroundColor: Colors.transparent, // Handled by MainLayout
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24 * s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 96 * s), // Spacing for MainLayout header
              
              // Input Card
              ClipRRect(
                borderRadius: BorderRadius.circular(20 * s),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24 * s),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D9D9).withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20 * s),
                      border: Border.all(color: const Color(0xFF6EAF91).withOpacity(0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Введите пароль. Мы проверим только хэш — сам пароль никуда не передаётся.',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: const Color(0xFFACACAC),
                            fontSize: 15 * s,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 16 * s),
                        Container(
                          height: 56 * s,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(12 * s),
                            border: Border.all(color: Colors.white.withOpacity(0.37)),
                          ),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: Colors.white,
                              fontSize: 16 * s,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Введите пароль',
                              hintStyle: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: Colors.white.withOpacity(0.37),
                                fontSize: 16 * s,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20 * s, vertical: 16 * s),
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
                ),
              ),

              SizedBox(height: 24 * s),

              // Check Button
              GestureDetector(
                onTap: () {
                  if (_passwordController.text.isNotEmpty) {
                    setState(() {
                      _isChecked = true;
                    });
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(31 * s),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6.85, sigmaY: 6.85),
                    child: Container(
                      width: double.infinity,
                      height: 62 * s,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3E7261).withOpacity(0.34),
                        borderRadius: BorderRadius.circular(31 * s),
                        border: Border.all(
                          color: const Color(0xFF194832).withOpacity(0.35),
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Проверить бесплатно',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white,
                            fontSize: 16 * s,
                            letterSpacing: 0.32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              if (_isChecked) ...[
                SizedBox(height: 24 * s),
                
                // Result Card
                ClipRRect(
                  borderRadius: BorderRadius.circular(20 * s),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(24 * s),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9).withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20 * s),
                        border: Border.all(color: const Color(0xFFFF4D4D).withOpacity(0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40 * s,
                                    height: 40 * s,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFF4D4D).withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20 * s),
                                    ),
                                    child: Center(
                                      child: Icon(Icons.error_outline, color: const Color(0xFFFF4D4D), size: 24 * s),
                                    ),
                                  ),
                                  SizedBox(width: 12 * s),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'НАЙДЕН В УТЕЧКАХ',
                                        style: TextStyle(
                                          fontFamily: 'GoogleSans',
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFFFF4D4D),
                                          fontSize: 18 * s,
                                        ),
                                      ),
                                      SizedBox(height: 2 * s),
                                      Text(
                                        'Пароль скомпрометирован',
                                        style: TextStyle(
                                          fontFamily: 'GoogleSans',
                                          color: const Color(0xFFFF4D4D),
                                          fontSize: 13 * s,
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
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFFF4D4D),
                                  fontSize: 32 * s,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20 * s),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.white.withOpacity(0.1),
                          ),
                          SizedBox(height: 20 * s),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Встречался раз',
                                style: TextStyle(
                                  fontFamily: 'GoogleSans',
                                  color: Colors.white,
                                  fontSize: 16 * s,
                                ),
                              ),
                              Text(
                                '847',
                                style: TextStyle(
                                  fontFamily: 'GoogleSans',
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFFF4D4D),
                                  fontSize: 16 * s,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12 * s),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Первая утечка',
                                style: TextStyle(
                                  fontFamily: 'GoogleSans',
                                  color: Colors.white,
                                  fontSize: 16 * s,
                                ),
                              ),
                              Text(
                                '2019',
                                style: TextStyle(
                                  fontFamily: 'GoogleSans',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16 * s,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20 * s),
                          Text(
                            'Немедленно смените этот пароль везде.',
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: const Color(0xFFACACAC),
                              fontSize: 14 * s,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 24 * s),

                // Generate New Button
                GestureDetector(
                  onTap: () {
                    // Logic to generate new password
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(31 * s),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6.85, sigmaY: 6.85),
                      child: Container(
                        width: double.infinity,
                        height: 62 * s,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3E7261).withOpacity(0.34),
                          borderRadius: BorderRadius.circular(31 * s),
                          border: Border.all(
                            color: const Color(0xFF194832).withOpacity(0.35),
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Сгенерировать новый',
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: Colors.white,
                              fontSize: 16 * s,
                              letterSpacing: 0.32,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              
              SizedBox(height: 120 * s),
            ],
          ),
        ),
      ),
    );
  }
}
