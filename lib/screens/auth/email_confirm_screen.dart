import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../widgets/code_input.dart';

class EmailConfirmScreen extends StatefulWidget {
  final String email;

  const EmailConfirmScreen({Key? key, this.email = ''}) : super(key: key);

  @override
  State<EmailConfirmScreen> createState() => _EmailConfirmScreenState();
}

class _EmailConfirmScreenState extends State<EmailConfirmScreen> {
  String _code = '';
  int _secondsLeft = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _secondsLeft = 60;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        setState(() {
          _secondsLeft--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _resendCode() {
    if (_secondsLeft == 0) {
      _startTimer();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Код отправлен повторно')),
      );
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
                  'Подтверждение e-mail',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Dynamic Text
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: 'GoogleSans',
                      color: AppColors.textSecondary,
                      fontSize: 16,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      const TextSpan(text: 'Мы отправили Вам код для подтверждения на почту '),
                      TextSpan(
                        text: widget.email.isNotEmpty ? widget.email : 'example@mail.ru',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 48),
                
                CodeInputWidget(
                  length: 6,
                  onChanged: (val) {
                    setState(() {
                      _code = val;
                    });
                  },
                  onCompleted: (val) {
                    // Auto-submit
                    if (_code.length == 6) {
                      context.go('/dashboard');
                    }
                  },
                ),
                
                const SizedBox(height: 64),
                
                InkWell(
                  onTap: () {
                    if (_code.length == 6) {
                      context.go('/dashboard');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Пожалуйста, введите все 6 цифр')),
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(31),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      color: _code.length == 6 
                          ? const Color(0xFF132A1C).withOpacity(0.8) 
                          : Colors.transparent, 
                      borderRadius: BorderRadius.circular(31),
                      border: Border.all(
                        color: _code.length == 6 
                            ? const Color(0xFF2E5B3F).withOpacity(0.5) 
                            : AppColors.textMuted.withOpacity(0.2), 
                        width: 1.5,
                      ), 
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Подтвердить',
                          style: TextStyle(
                            color: _code.length == 6 ? Colors.white : AppColors.textMuted,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.chevron_right, 
                          color: _code.length == 6 ? Colors.white54 : AppColors.textMuted, 
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 48),
                
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'Не получили код?',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: _secondsLeft == 0 ? _resendCode : null,
                        child: Text(
                          _secondsLeft > 0 
                              ? 'Отправить код повторно через $_secondsLeft сек' 
                              : 'Отправить код повторно',
                          style: TextStyle(
                            color: _secondsLeft > 0 ? AppColors.textMuted : AppColors.colorGreenLight,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            decoration: _secondsLeft == 0 ? TextDecoration.underline : TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
