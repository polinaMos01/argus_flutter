import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/app_toast.dart';
import '../auth/email_confirm_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  bool _isEmailConfirmed = false;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: 'Алекс Томсон');
    _emailController = TextEditingController(text: 'ghost_user@protonmail.com');
    _phoneController = TextEditingController(text: '+7 999 123-45-67');
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
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
              SizedBox(height: 96 * s), // MainLayout header offset

              Text(
                'Личные данные',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 20 * s,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 24 * s),

              // Username Field
              _buildFieldLabel(s, 'Имя пользователя'),
              SizedBox(height: 8 * s),
              _buildInputField(s, controller: _usernameController),
              SizedBox(height: 20 * s),

              // Email Field
              _buildFieldLabel(s, 'Email'),
              SizedBox(height: 8 * s),
              _buildInputField(
                s,
                controller: _emailController,
                isReadOnly: true,
                showErrorIcon: !_isEmailConfirmed,
              ),
              if (!_isEmailConfirmed) ...[
                SizedBox(height: 8 * s),
                Row(
                  children: [
                    Text(
                      'E-mail не подтверждён. ',
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: const Color(0xFFFF4B4B),
                        fontSize: 13 * s,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push('/email-confirm', extra: _emailController.text);
                      },
                      child: Text(
                        'Отправить код повторно',
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          color: const Color(0xFFFF4B4B),
                          fontSize: 13 * s,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: const Color(0xFFFF4B4B),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(height: 20 * s),

              // Phone Field
              _buildFieldLabel(s, 'Телефон'),
              SizedBox(height: 8 * s),
              _buildInputField(s, controller: _phoneController),
              SizedBox(height: 40 * s),

              // Submit / Save Button
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isSaved = true;
                  });
                  showAppToast(context, 'Данные успешно сохранены');
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(31 * s),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6.85, sigmaY: 6.85),
                    child: Container(
                      width: double.infinity,
                      height: 56 * s,
                      padding: EdgeInsets.symmetric(horizontal: 24 * s),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6EAF91).withOpacity(0.20),
                        borderRadius: BorderRadius.circular(31 * s),
                        border: Border.all(
                          color: const Color(0xFF6EAF91).withOpacity(0.48),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Text(
                            !_isEmailConfirmed ? 'Сохранить изменения' : 'Изменить данные',
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: Colors.white,
                              fontSize: 16 * s,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios, color: Colors.white.withOpacity(0.6), size: 14 * s),
                        ],
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

  Widget _buildFieldLabel(double s, String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'GoogleSans',
        color: const Color(0xFFACACAC),
        fontSize: 14 * s,
      ),
    );
  }

  Widget _buildInputField(
    double s, {
    required TextEditingController controller,
    bool showErrorIcon = false,
    bool isReadOnly = false,
  }) {
    return Container(
      height: 54 * s,
      padding: EdgeInsets.symmetric(horizontal: 16 * s),
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9).withOpacity(0.03),
        borderRadius: BorderRadius.circular(12 * s),
        border: Border.all(
          color: showErrorIcon
              ? const Color(0xFFFF4B4B).withOpacity(0.48)
              : const Color(0xFFD9D9D9).withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: isReadOnly,
              style: TextStyle(
                fontFamily: 'GoogleSans',
                color: isReadOnly ? Colors.white.withOpacity(0.5) : Colors.white,
                fontSize: 15 * s,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (showErrorIcon)
            Icon(
              Icons.error_outline,
              color: const Color(0xFFFF4B4B),
              size: 20 * s,
            )
          else if (isReadOnly)
            Icon(Icons.lock_outline, color: const Color(0xFFACACAC).withOpacity(0.4), size: 18 * s),
        ],
      ),
    );
  }
}
