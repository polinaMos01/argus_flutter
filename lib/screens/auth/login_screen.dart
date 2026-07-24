import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.go('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, 1.2),
            radius: 1.5,
            colors: [
              Color(0xFF132A1C), // Deep green glow at bottom
              Color(0xFF0A0A0F), // Dark background
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 64),
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Row(
                      children: const [
                        Icon(Icons.arrow_back_ios, color: Colors.white, size: 16),
                        SizedBox(width: 8),
                        Text(
                          'Назад',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'С возвращением!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Войдите, чтобы продолжить защиту',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  CustomTextField(
                    label: 'E-mail или телефон',
                    hint: 'Введите ваш E-mail или номер телефона',
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Поле обязательно для заполнения';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  
                  CustomTextField(
                    label: 'Ваш пароль',
                    hint: 'Введите ваш пароль',
                    isPassword: true,
                    controller: _passwordController,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Поле обязательно для заполнения';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => context.push('/restore'),
                      child: const Text(
                        'Забыли пароль? Восстановить!',
                        style: TextStyle(
                          color: AppColors.colorGreenLight,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  
                  InkWell(
                    onTap: _submit,
                    borderRadius: BorderRadius.circular(31),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF132A1C).withOpacity(0.8), 
                        borderRadius: BorderRadius.circular(31),
                        border: Border.all(color: const Color(0xFF2E5B3F).withOpacity(0.5), width: 1.5), 
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Войти',
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.chevron_right, color: Colors.white54, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  Center(
                    child: GestureDetector(
                      onTap: () => context.push('/register'),
                      child: RichText(
                        text: const TextSpan(
                          text: 'Ещё нет аккаунта? ',
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
                              text: 'Зарегистрироваться',
                              style: TextStyle(
                                color: AppColors.colorGreenLight,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
