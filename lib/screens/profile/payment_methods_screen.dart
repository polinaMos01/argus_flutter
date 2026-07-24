import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/app_toast.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  int _selectedCardIndex = 0;

  final List<Map<String, String>> _cards = [
    {
      'type': 'МИР',
      'number': '•••• 4589',
      'expiry': '12/26',
      'isDefault': 'true',
    },
    {
      'type': 'Visa',
      'number': '•••• 8812',
      'expiry': '08/25',
      'isDefault': 'false',
    },
    {
      'type': 'Mastercard',
      'number': '•••• 1042',
      'expiry': '05/27',
      'isDefault': 'false',
    },
  ];

  void _showAddCardModal(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;

    final numberController = TextEditingController();
    final expiryController = TextEditingController();
    final cvcController = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.all(24 * s),
            decoration: BoxDecoration(
              color: const Color(0xFF060E11).withOpacity(0.95),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24 * s),
                topRight: Radius.circular(24 * s),
              ),
              border: Border.all(color: const Color(0xFF6EAF91).withOpacity(0.4), width: 1.5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40 * s,
                    height: 4 * s,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2 * s),
                    ),
                  ),
                ),
                SizedBox(height: 20 * s),

                Text(
                  'Добавить новую карту',
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    color: Colors.white,
                    fontSize: 20 * s,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20 * s),

                // Card Number Field
                _buildModalTextField(s, label: 'Номер карты', hint: '0000 0000 0000 0000', controller: numberController),
                SizedBox(height: 14 * s),

                Row(
                  children: [
                    Expanded(
                      child: _buildModalTextField(s, label: 'Срок действия', hint: 'ММ/ГГ', controller: expiryController),
                    ),
                    SizedBox(width: 14 * s),
                    Expanded(
                      child: _buildModalTextField(s, label: 'CVC / CVV', hint: '•••', controller: cvcController, obscure: true),
                    ),
                  ],
                ),
                SizedBox(height: 24 * s),

                // Save Card Button
                GestureDetector(
                  onTap: () {
                    if (numberController.text.isEmpty) {
                      showAppToast(context, 'Введите номер карты');
                      return;
                    }
                    Navigator.pop(ctx);
                    setState(() {
                      _cards.add({
                        'type': 'Карта',
                        'number': '•••• ${numberController.text.length >= 4 ? numberController.text.substring(numberController.text.length - 4) : '0000'}',
                        'expiry': expiryController.text.isEmpty ? '12/28' : expiryController.text,
                        'isDefault': 'false',
                      });
                    });
                    showAppToast(context, 'Новая карта успешно привязана');
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
                        'Привязать карту',
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
                SizedBox(height: 24 * s),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModalTextField(
    double s, {
    required String label,
    required String hint,
    required TextEditingController controller,
    bool obscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'GoogleSans',
            color: const Color(0xFFACACAC),
            fontSize: 12 * s,
          ),
        ),
        SizedBox(height: 6 * s),
        Container(
          height: 48 * s,
          padding: EdgeInsets.symmetric(horizontal: 14 * s),
          decoration: BoxDecoration(
            color: const Color(0xFFD9D9D9).withOpacity(0.04),
            borderRadius: BorderRadius.circular(12 * s),
            border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.2)),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            style: TextStyle(
              fontFamily: 'GoogleSans',
              color: Colors.white,
              fontSize: 14 * s,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontFamily: 'GoogleSans',
                color: Colors.white24,
                fontSize: 14 * s,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
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
              SizedBox(height: 96 * s), // MainLayout header padding

              Text(
                'Сохранённые карты',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 16 * s),

              // Saved Cards List (Figma Node 159-1739)
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _cards.length,
                separatorBuilder: (ctx, idx) => SizedBox(height: 12 * s),
                itemBuilder: (ctx, idx) {
                  final card = _cards[idx];
                  final isSelected = _selectedCardIndex == idx;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCardIndex = idx;
                      });
                      showAppToast(context, 'Основная карта: ${card['type']} ${card['number']}');
                    },
                    child: Container(
                      padding: EdgeInsets.all(16 * s),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF6EAF91).withOpacity(0.08)
                            : const Color(0xFFD9D9D9).withOpacity(0.03),
                        borderRadius: BorderRadius.circular(16 * s),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF6EAF91)
                              : const Color(0xFFD9D9D9).withOpacity(0.15),
                          width: isSelected ? 1.5 : 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44 * s,
                            height: 44 * s,
                            decoration: BoxDecoration(
                              color: const Color(0xFFD9D9D9).withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12 * s),
                              border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.2)),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/images/credit-card.svg',
                                width: 22 * s,
                                height: 22 * s,
                                colorFilter: ColorFilter.mode(
                                  isSelected ? const Color(0xFF6EAF91) : Colors.white70,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 14 * s),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${card['type']} ${card['number']}',
                                      style: TextStyle(
                                        fontFamily: 'GoogleSans',
                                        color: Colors.white,
                                        fontSize: 15 * s,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (card['isDefault'] == 'true') ...[
                                      SizedBox(width: 8 * s),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8 * s, vertical: 2 * s),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF6EAF91).withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(6 * s),
                                        ),
                                        child: Text(
                                          'Основная',
                                          style: TextStyle(
                                            fontFamily: 'GoogleSans',
                                            color: const Color(0xFF6EAF91),
                                            fontSize: 10 * s,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                SizedBox(height: 4 * s),
                                Text(
                                  'Срок: ${card['expiry']}',
                                  style: TextStyle(
                                    fontFamily: 'GoogleSans',
                                    color: const Color(0xFFACACAC),
                                    fontSize: 12 * s,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Radio check icon
                          Icon(
                            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                            color: isSelected ? const Color(0xFF6EAF91) : Colors.white30,
                            size: 22 * s,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 28 * s),

              // Button: Добавить карту (Figma Node 159-1739)
              GestureDetector(
                onTap: () => context.push('/profile/add-card'),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_rounded, color: const Color(0xFF060E11), size: 22 * s),
                      SizedBox(width: 8 * s),
                      Text(
                        'Добавить карту',
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          color: const Color(0xFF060E11),
                          fontSize: 16 * s,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
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
}
