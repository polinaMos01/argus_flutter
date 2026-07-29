import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.push('/email-confirm', extra: _emailController.text);
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
              Color(0xFF132A1C),
              Color(0xFF0A0A0F),
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
                    'Создать аккаунт',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Начните бесплатную защиту прямо сейчас',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  CustomTextField(
                    label: 'Имя*',
                    hint: 'Как к вам обращаться',
                    controller: _nameController,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Поле обязательно для заполнения';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  
                  CustomTextField(
                    label: 'E-mail*',
                    hint: 'Введите ваш E-mail',
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Поле обязательно для заполнения';
                      }
                      if (!val.contains('@')) {
                        return 'Неверный формат email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  
                  CustomTextField(
                    label: 'Новый пароль',
                    hint: 'Придумайте пароль',
                    isPassword: true,
                    controller: _passwordController,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Поле обязательно для заполнения';
                      }
                      if (val.length < 8 || val.length > 128) {
                        return 'Пароль должен содержать от 8 до 128 символов';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  
                  CustomTextField(
                    label: 'Повторите пароль',
                    hint: 'Введите пароль ещё раз',
                    isPassword: true,
                    controller: _confirmController,
                    validator: (val) {
                      if (val != _passwordController.text) {
                        return 'Пароли не совпадают';
                      }
                      return null;
                    },
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
                            'Подтвердить e-mail',
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
                      onTap: () => context.push('/login'),
                      child: RichText(
                        text: const TextSpan(
                          text: 'Уже есть аккаунт? ',
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
                              text: 'Войти',
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
