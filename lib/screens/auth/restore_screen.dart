import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../widgets/custom_text_field.dart';

class RestoreScreen extends StatefulWidget {
  const RestoreScreen({Key? key}) : super(key: key);

  @override
  State<RestoreScreen> createState() => _RestoreScreenState();
}

class _RestoreScreenState extends State<RestoreScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
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
                'Восстановление пароля',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Введите ваш email — мы отправим ссылку для сброса пароля',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              
              CustomTextField(
                label: 'E-mail для которого будет выполнен сброс',
                hint: 'Введите ваш E-mail',
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              const SizedBox(height: 48),
              
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: _emailController,
                builder: (context, value, child) {
                  final bool isEnabled = value.text.trim().isNotEmpty;
                  return InkWell(
                    onTap: isEnabled ? () => context.push('/email-confirm') : null,
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: isEnabled ? const Color(0xFF1C3A27) : const Color(0xFF132A1C).withOpacity(0.5), 
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: isEnabled ? const Color(0xFF386851) : const Color(0xFF2E5B3F).withOpacity(0.3), 
                          width: 1.5
                        ), 
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Отправить ссылку',
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: isEnabled ? Colors.white : Colors.white.withOpacity(0.3),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.chevron_right, color: isEnabled ? Colors.white : Colors.white.withOpacity(0.3), size: 20),
                        ],
                      ),
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
