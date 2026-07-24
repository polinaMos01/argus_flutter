import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

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
          child: Column(
            children: [
              const SizedBox(height: 64),
              const Spacer(flex: 2),
              
              SvgPicture.asset('assets/images/node_84_3328.svg', width: 260),
              
              const SizedBox(height: 24),
              
              const Text(
                'Добро пожаловать в систему',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              
              const SizedBox(height: 12),
              
              const Text(
                'Надёжная защита ваших данных\nи контроль цифрового следа',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFACACAC),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                ),
              ),
              
              const Spacer(flex: 3),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => context.push('/register'),
                      borderRadius: BorderRadius.circular(31),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(31),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6.85, sigmaY: 6.85),
                          child: Container(
                            width: double.infinity,
                            height: 62,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(62, 114, 97, 0.34),
                              borderRadius: BorderRadius.circular(31),
                              border: Border.all(
                                color: const Color.fromRGBO(25, 72, 50, 0.35),
                                width: 1.5,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Создать аккаунт',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.32,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    InkWell(
                      onTap: () => context.push('/login'),
                      borderRadius: BorderRadius.circular(31),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(31),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6.85, sigmaY: 6.85),
                          child: Container(
                            width: double.infinity,
                            height: 62,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(31),
                              border: Border.all(
                                color: const Color.fromRGBO(25, 72, 50, 0.35),
                                width: 1.5,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Войти',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.32,
                              ),
                            ),
                          ),
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
    );
  }
}
