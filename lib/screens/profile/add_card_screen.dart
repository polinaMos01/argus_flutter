import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/app_toast.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _numberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvcController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isDefault = true;

  @override
  void dispose() {
    _numberController.dispose();
    _expiryController.dispose();
    _cvcController.dispose();
    _nameController.dispose();
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
              SizedBox(height: 126 * s), // MainLayout header padding

              // Interactive Credit Card Graphic Preview (Figma Node 159-1825)
              AnimatedBuilder(
                animation: Listenable.merge([
                  _numberController,
                  _expiryController,
                  _nameController,
                ]),
                builder: (context, child) {
                  final numberText = _numberController.text.isEmpty
                      ? '•••• •••• •••• ••••'
                      : _numberController.text;
                  final expiryText = _expiryController.text.isEmpty
                      ? 'ММ/ГГ'
                      : _expiryController.text;
                  final nameText = _nameController.text.isEmpty
                      ? 'ALEX THOMSON'
                      : _nameController.text.toUpperCase();

                  return Container(
                    width: double.infinity,
                    height: 200 * s,
                    padding: EdgeInsets.all(22 * s),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF1E3C2F),
                          Color(0xFF091812),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20 * s),
                      border: Border.all(color: const Color(0xFF6EAF91).withOpacity(0.4), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6EAF91).withOpacity(0.2),
                          blurRadius: 20 * s,
                          offset: Offset(0, 8 * s),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ARGUS CARD',
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: const Color(0xFF6EAF91),
                                fontSize: 13 * s,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/images/credit-card.svg',
                              width: 24 * s,
                              height: 24 * s,
                              colorFilter: const ColorFilter.mode(Color(0xFF6EAF91), BlendMode.srcIn),
                            ),
                          ],
                        ),

                        // Card Number
                        Text(
                          numberText,
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white,
                            fontSize: 19 * s,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2.0,
                          ),
                        ),

                        // Expiry & Name Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ДЕРЖАТЕЛЬ',
                                  style: TextStyle(
                                    fontFamily: 'GoogleSans',
                                    color: const Color(0xFFACACAC),
                                    fontSize: 10 * s,
                                  ),
                                ),
                                SizedBox(height: 2 * s),
                                Text(
                                  nameText,
                                  style: TextStyle(
                                    fontFamily: 'GoogleSans',
                                    color: Colors.white,
                                    fontSize: 13 * s,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'СРОК',
                                  style: TextStyle(
                                    fontFamily: 'GoogleSans',
                                    color: const Color(0xFFACACAC),
                                    fontSize: 10 * s,
                                  ),
                                ),
                                SizedBox(height: 2 * s),
                                Text(
                                  expiryText,
                                  style: TextStyle(
                                    fontFamily: 'GoogleSans',
                                    color: Colors.white,
                                    fontSize: 13 * s,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),

              SizedBox(height: 28 * s),

              // Form Input Fields
              _buildInputField(
                s,
                label: 'Номер карты',
                hint: '0000 0000 0000 0000',
                controller: _numberController,
                keyboardType: TextInputType.number,
                icon: Icons.credit_card,
              ),
              SizedBox(height: 16 * s),

              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      s,
                      label: 'Срок действия',
                      hint: 'ММ / ГГ',
                      controller: _expiryController,
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                  SizedBox(width: 14 * s),
                  Expanded(
                    child: _buildInputField(
                      s,
                      label: 'CVC / CVV',
                      hint: '•••',
                      controller: _cvcController,
                      obscure: true,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16 * s),

              _buildInputField(
                s,
                label: 'Имя на карте',
                hint: 'ALEX THOMSON',
                controller: _nameController,
                icon: Icons.person_outline,
              ),
              SizedBox(height: 20 * s),

              // Checkbox: Сделать основной картой
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isDefault = !_isDefault;
                  });
                },
                child: Row(
                  children: [
                    Container(
                      width: 22 * s,
                      height: 22 * s,
                      decoration: BoxDecoration(
                        color: _isDefault ? const Color(0xFF6EAF91) : Colors.transparent,
                        borderRadius: BorderRadius.circular(6 * s),
                        border: Border.all(
                          color: _isDefault ? const Color(0xFF6EAF91) : Colors.white38,
                        ),
                      ),
                      child: _isDefault
                          ? Icon(Icons.check, color: const Color(0xFF060E11), size: 16 * s)
                          : null,
                    ),
                    SizedBox(width: 12 * s),
                    Text(
                      'Сделать основной картой',
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14 * s,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32 * s),

              // Submit Button: Сохранить карту
              GestureDetector(
                onTap: () {
                  if (_numberController.text.isEmpty) {
                    showAppToast(context, 'Введите номер карты');
                    return;
                  }
                  showAppToast(context, 'Карта успешно сохранена');
                  context.pop();
                },
                child: Container(
                  height: 52 * s,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6EAF91),
                    borderRadius: BorderRadius.circular(26 * s),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6EAF91).withOpacity(0.35),
                        blurRadius: 16 * s,
                        offset: Offset(0, 4 * s),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Сохранить карту',
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: const Color(0xFF060E11),
                        fontSize: 16 * s,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 120 * s),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    double s, {
    required String label,
    required String hint,
    required TextEditingController controller,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'GoogleSans',
            color: const Color(0xFFACACAC),
            fontSize: 13 * s,
          ),
        ),
        SizedBox(height: 6 * s),
        Container(
          height: 50 * s,
          padding: EdgeInsets.symmetric(horizontal: 16 * s),
          decoration: BoxDecoration(
            color: const Color(0xFFD9D9D9).withOpacity(0.04),
            borderRadius: BorderRadius.circular(14 * s),
            border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.2)),
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: const Color(0xFF6EAF91), size: 20 * s),
                SizedBox(width: 12 * s),
              ],
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: obscure,
                  keyboardType: keyboardType,
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    color: Colors.white,
                    fontSize: 15 * s,
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: Colors.white24,
                      fontSize: 15 * s,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
