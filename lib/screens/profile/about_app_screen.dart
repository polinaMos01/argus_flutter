import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/app_toast.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 96 * s), // MainLayout header space

              // Logo & App Name Hero
              Container(
                width: 80 * s,
                height: 80 * s,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF0F3A2A),
                      Color(0xFF072118),
                    ],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF6EAF91), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6EAF91).withOpacity(0.3),
                      blurRadius: 20 * s,
                      offset: Offset(0, 4 * s),
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/crown.svg',
                    width: 38 * s,
                    height: 38 * s,
                    colorFilter: const ColorFilter.mode(Color(0xFF6EAF91), BlendMode.srcIn),
                  ),
                ),
              ),
              SizedBox(height: 16 * s),

              Text(
                'ARGUS CYBER SECURITY',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 20 * s,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 6 * s),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 12 * s, vertical: 4 * s),
                decoration: BoxDecoration(
                  color: const Color(0xFF6EAF91).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12 * s),
                  border: Border.all(color: const Color(0xFF6EAF91).withOpacity(0.4)),
                ),
                child: Text(
                  'Версия 1.0.0 (Сборка 42)',
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    color: const Color(0xFF6EAF91),
                    fontSize: 12 * s,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              SizedBox(height: 28 * s),

              // Information Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20 * s),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9).withOpacity(0.03),
                  borderRadius: BorderRadius.circular(20 * s),
                  border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.15)),
                ),
                child: Column(
                  children: [
                    _buildInfoRow(s, label: 'Дата первого релиза', value: '15 июня 2025 г.'),
                    SizedBox(height: 14 * s),
                    _buildInfoRow(s, label: 'Команда разработки', value: 'Argus Security Labs'),
                    SizedBox(height: 14 * s),
                    _buildInfoRow(s, label: 'Главный архитектор', value: 'Cyber Defense Team'),
                    SizedBox(height: 14 * s),
                    _buildInfoRow(s, label: 'Платформа', value: 'Flutter Cross-Platform Engine'),
                    SizedBox(height: 14 * s),
                    _buildInfoRow(s, label: 'Протокол защиты', value: 'AES-256 / SHA-512'),
                  ],
                ),
              ),

              SizedBox(height: 24 * s),

              // Legal Links Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9).withOpacity(0.03),
                  borderRadius: BorderRadius.circular(20 * s),
                  border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.15)),
                ),
                child: Column(
                  children: [
                    _buildLegalTile(
                      s,
                      title: 'Условия использования',
                      onTap: () => showAppToast(context, 'Открытие Условий использования...'),
                    ),
                    Divider(color: Colors.white.withOpacity(0.08), height: 1),
                    _buildLegalTile(
                      s,
                      title: 'Политика конфиденциальности',
                      onTap: () => showAppToast(context, 'Открытие Политики конфиденциальности...'),
                    ),
                    Divider(color: Colors.white.withOpacity(0.08), height: 1),
                    _buildLegalTile(
                      s,
                      title: 'Лицензии открытого ПО',
                      onTap: () => showAppToast(context, 'Открытие Лицензий...'),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32 * s),

              Text(
                '© 2025 Argus Cyber Security Inc.\nВсе права защищены.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: const Color(0xFFACACAC),
                  fontSize: 12 * s,
                  height: 1.4,
                ),
              ),

              SizedBox(height: 120 * s),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(double s, {required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'GoogleSans',
            color: const Color(0xFFACACAC),
            fontSize: 13 * s,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'GoogleSans',
            color: Colors.white,
            fontSize: 13 * s,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildLegalTile(double s, {required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20 * s, vertical: 16 * s),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'GoogleSans',
                color: Colors.white,
                fontSize: 15 * s,
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.white38, size: 18 * s),
          ],
        ),
      ),
    );
  }
}
