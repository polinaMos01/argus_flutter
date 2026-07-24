import 'dart:ui';
import 'package:flutter/material.dart';
import '../../widgets/main_layout.dart';
import '../../widgets/custom_text_field.dart';
import '../../theme/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: 'ghost_user');
    _emailController = TextEditingController(text: 'g***@protonmail.com');
    _phoneController = TextEditingController(text: '+7 999 000-00-00');
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Widget _buildGlassCard(double Function(double) s, {required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(s(20)),
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9).withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.1)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    double s(double value) => value * (canvasWidth / 393);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Мой профиль',
          style: TextStyle(fontFamily: 'GoogleSans', fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0, left: 0, right: 0, height: s(400),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF6EAF91).withOpacity(0.20),
                    Colors.black.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: s(24)),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: s(20)),
                      Text(
                        'Личные данные',
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          color: Colors.white,
                          fontSize: s(18),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: s(16)),
                      _buildGlassCard(
                        s,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              label: 'Имя пользователя',
                              hint: 'ghost_user',
                              controller: _usernameController,
                            ),
                            SizedBox(height: s(16)),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CustomTextField(
                                  label: 'Email',
                                  hint: 'g***@protonmail.com',
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                Positioned(
                                  right: 0,
                                  top: s(10),
                                  child: Icon(Icons.error_outline, color: AppColors.warning, size: s(20)),
                                ),
                              ],
                            ),
                            SizedBox(height: s(4)),
                            Text(
                              'E-mail не подтвержден. Отправить код повторно',
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: AppColors.warning,
                                fontSize: s(12),
                              ),
                            ),
                            SizedBox(height: s(16)),
                            CustomTextField(
                              label: 'Телефон',
                              hint: '+7 999 000-00-00',
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: s(32)),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.colorGreen,
                            padding: EdgeInsets.symmetric(vertical: s(16)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Сохранить изменения',
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              fontSize: s(16),
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: s(120)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
