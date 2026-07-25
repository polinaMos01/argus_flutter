import 'dart:ui';
import 'package:flutter/material.dart';
import '../../widgets/app_toast.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  bool _hasAttemptedSave = false;

  bool get _hasMin8 => _newPasswordController.text.length >= 8;
  bool get _hasDigitsAndSpec {
    final pwd = _newPasswordController.text;
    final hasDigit = RegExp(r'[0-9]').hasMatch(pwd);
    final hasSpec = RegExp(r'[!@#$%^&*(),.?":{}|<>_\-\+]').hasMatch(pwd);
    return hasDigit && hasSpec;
  }
  bool get _hasUpperAndLower {
    final pwd = _newPasswordController.text;
    final hasUpper = RegExp(r'[A-ZА-Я]').hasMatch(pwd);
    final hasLower = RegExp(r'[a-zа-я]').hasMatch(pwd);
    return hasUpper && hasLower;
  }
  bool get _passwordsMatch =>
      _newPasswordController.text.isNotEmpty &&
      _newPasswordController.text == _confirmPasswordController.text;

  bool get _isValid => _hasMin8 && _hasDigitsAndSpec && _hasUpperAndLower && _passwordsMatch && _currentPasswordController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_onPasswordChanged);
    _confirmPasswordController.addListener(_onPasswordChanged);
    _currentPasswordController.addListener(_onPasswordChanged);
  }

  void _onPasswordChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _newPasswordController.removeListener(_onPasswordChanged);
    _confirmPasswordController.removeListener(_onPasswordChanged);
    _currentPasswordController.removeListener(_onPasswordChanged);
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _savePassword() {
    setState(() {
      _hasAttemptedSave = true;
    });

    if (_currentPasswordController.text.isEmpty) {
      showAppToast(context, 'Введите текущий пароль', isError: true);
      return;
    }

    if (!_hasMin8) {
      showAppToast(context, 'Пароль должен содержать не менее 8 символов', isError: true);
      return;
    }

    if (!_hasDigitsAndSpec) {
      showAppToast(context, 'Добавьте цифры и спецсимволы (!@#\$...)', isError: true);
      return;
    }

    if (!_hasUpperAndLower) {
      showAppToast(context, 'Добавьте заглавные и строчные буквы', isError: true);
      return;
    }

    if (!_passwordsMatch) {
      showAppToast(context, 'Пароли не совпадают', isError: true);
      return;
    }

    showAppToast(context, 'Пароль успешно изменен!');
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;

    final currentHasError = _hasAttemptedSave && _currentPasswordController.text.isEmpty;
    final newHasError = _hasAttemptedSave && (!_hasMin8 || !_hasDigitsAndSpec || !_hasUpperAndLower);
    final confirmHasError = _hasAttemptedSave && !_passwordsMatch;

    return Scaffold(
      backgroundColor: const Color(0xFF060E11),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24 * s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 126 * s), // MainLayout header offset

              // Form Container
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9).withOpacity(0.03),
                  borderRadius: BorderRadius.circular(16 * s),
                  border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    _buildPasswordField(
                      s,
                      label: 'Текущий пароль',
                      hint: 'Введите текущий пароль',
                      controller: _currentPasswordController,
                      obscureText: _obscureCurrent,
                      onToggleObscure: () => setState(() => _obscureCurrent = !_obscureCurrent),
                      hasError: currentHasError,
                    ),
                    _buildPasswordField(
                      s,
                      label: 'Новый пароль',
                      hint: 'Придумайте новый пароль',
                      controller: _newPasswordController,
                      obscureText: _obscureNew,
                      onToggleObscure: () => setState(() => _obscureNew = !_obscureNew),
                      hasError: newHasError,
                    ),
                    _buildPasswordField(
                      s,
                      label: 'Повторите новый пароль',
                      hint: 'Повторите пароль',
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirm,
                      onToggleObscure: () => setState(() => _obscureConfirm = !_obscureConfirm),
                      hasError: confirmHasError,
                      isLast: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24 * s),

              // Dynamic Validation Criteria Checkmarks
              _buildCriterionRow(s, 'Минимум 8 символов', isValid: _hasMin8),
              SizedBox(height: 12 * s),
              _buildCriterionRow(s, 'Цифры и спецсимволы', isValid: _hasDigitsAndSpec),
              SizedBox(height: 12 * s),
              _buildCriterionRow(s, 'Заглавные и строчные буквы', isValid: _hasUpperAndLower),
              SizedBox(height: 48 * s),

              // Save Button
              GestureDetector(
                onTap: _savePassword,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(31 * s),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6.85, sigmaY: 6.85),
                    child: Container(
                      width: double.infinity,
                      height: 56 * s,
                      padding: EdgeInsets.symmetric(horizontal: 24 * s),
                      decoration: BoxDecoration(
                        color: _isValid
                            ? const Color(0xFF6EAF91).withOpacity(0.20)
                            : const Color(0xFFD9D9D9).withOpacity(0.05),
                        borderRadius: BorderRadius.circular(31 * s),
                        border: Border.all(
                          color: _isValid
                              ? const Color(0xFF6EAF91).withOpacity(0.48)
                              : const Color(0xFFD9D9D9).withOpacity(0.2),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Text(
                            'Сохранить пароль',
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: _isValid ? Colors.white : Colors.white38,
                              fontSize: 16 * s,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: _isValid ? Colors.white.withOpacity(0.6) : Colors.white24,
                            size: 14 * s,
                          ),
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

  Widget _buildPasswordField(
    double s, {
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onToggleObscure,
    bool hasError = false,
    bool isLast = false,
  }) {
    return Container(
      padding: EdgeInsets.all(16 * s),
      decoration: isLast
          ? null
          : BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white.withOpacity(0.03)),
              ),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'GoogleSans',
              color: Colors.white,
              fontSize: 15 * s,
            ),
          ),
          SizedBox(height: 8 * s),
          Container(
            height: 48 * s,
            padding: EdgeInsets.symmetric(horizontal: 16 * s),
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9).withOpacity(0.03),
              borderRadius: BorderRadius.circular(12 * s),
              border: Border.all(
                color: hasError
                    ? const Color(0xFFFF4B4B)
                    : const Color(0xFFD9D9D9).withOpacity(0.2),
                width: hasError ? 1.5 : 1.0,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    obscureText: obscureText,
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: Colors.white,
                      fontSize: 14 * s,
                    ),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: const Color(0xFFACACAC).withOpacity(0.5),
                        fontSize: 14 * s,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onToggleObscure,
                  child: Icon(
                    obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: const Color(0xFFACACAC),
                    size: 20 * s,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCriterionRow(double s, String text, {required bool isValid}) {
    return Row(
      children: [
        Container(
          width: 20 * s,
          height: 20 * s,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isValid ? const Color(0xFF6EAF91).withOpacity(0.2) : Colors.transparent,
            border: Border.all(
              color: isValid ? const Color(0xFF6EAF91) : Colors.white24,
              width: 1.5,
            ),
          ),
          child: Icon(
            isValid ? Icons.check : Icons.close,
            color: isValid ? const Color(0xFF6EAF91) : Colors.white24,
            size: 13 * s,
          ),
        ),
        SizedBox(width: 12 * s),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'GoogleSans',
            color: isValid ? Colors.white : const Color(0xFFACACAC).withOpacity(0.6),
            fontSize: 14 * s,
          ),
        ),
      ],
    );
  }
}
