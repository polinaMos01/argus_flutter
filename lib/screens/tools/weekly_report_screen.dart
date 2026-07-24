import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WeeklyReportScreen extends StatelessWidget {
  const WeeklyReportScreen({super.key});

  void _showLeakDetailModal(
    BuildContext context,
    double s, {
    required String title,
    required String leaksCount,
    required String subtitle,
  }) {
    final GoRouter router = GoRouter.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (modalContext) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24 * s)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: EdgeInsets.all(24 * s),
              decoration: BoxDecoration(
                color: const Color(0xFF0D1B16).withOpacity(0.95),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24 * s)),
                border: Border.all(color: const Color(0x51D9D9D9)),
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          color: Colors.white,
                          fontSize: 20 * s,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12 * s, vertical: 4 * s),
                        decoration: BoxDecoration(
                          color: const Color(0xFFB20F0F).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12 * s),
                          border: Border.all(color: const Color(0xFFB20F0F)),
                        ),
                        child: Text(
                          '$leaksCount утечек',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: const Color(0xFFFF4B4B),
                            fontSize: 12 * s,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12 * s),

                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: Colors.white70,
                      fontSize: 14 * s,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 20 * s),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16 * s),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(12 * s),
                      border: Border.all(color: Colors.white.withOpacity(0.08)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Обнаруженные данные:',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: const Color(0xFF6EAF91),
                            fontSize: 13 * s,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8 * s),
                        Text(
                          '• Электронная почта\n• Хэши паролей\n• IP-адрес входа\n• Устройство и геолокация',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white,
                            fontSize: 13 * s,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24 * s),

                  GestureDetector(
                    onTap: () {
                      Navigator.of(modalContext).pop();
                      router.push('/threat-detail?title=${Uri.encodeComponent(title)}');
                    },
                    child: Container(
                      width: double.infinity,
                      height: 48 * s,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6EAF91),
                        borderRadius: BorderRadius.circular(24 * s),
                      ),
                      child: Center(
                        child: Text(
                          'Перейти к полной утечке',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white,
                            fontSize: 15 * s,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16 * s),
                ],
              ),
            ),
          ),
        );
      },
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
              SizedBox(height: 96 * s), // Spacing below MainLayout header

              // 1. Hero Summary Card (Figma Node 115-1855)
              ClipRRect(
                borderRadius: BorderRadius.circular(12 * s),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.85, sigmaY: 3.85),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 20 * s, horizontal: 20 * s),
                    decoration: BoxDecoration(
                      color: const Color(0x0CD9D9D9),
                      borderRadius: BorderRadius.circular(12 * s),
                      border: Border.all(color: const Color(0x51D9D9D9)),
                    ),
                    child: Column(
                      children: [
                        // Centered Badge: Мониторинг активен
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 14 * s, vertical: 4 * s),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD1FFE9),
                            borderRadius: BorderRadius.circular(31 * s),
                          ),
                          child: Text(
                            'Мониторинг активен',
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: const Color(0xFF2D493C),
                              fontSize: 10 * s,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: 12 * s),

                        // Large Number: 24
                        Text(
                          '24',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white,
                            fontSize: 53.2 * s,
                            fontWeight: FontWeight.w400,
                            height: 1.1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 4 * s),

                        // Subtitle
                        Text(
                          'сервиса под наблюдением',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white,
                            fontSize: 14 * s,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20 * s),

              // 2. Three Metric Columns (3 новых утечки | 24 сервиса | 4 устройства)
              Row(
                children: [
                  // Metric 1: 3 новых утечки
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '3',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white,
                            fontSize: 32 * s,
                            fontWeight: FontWeight.w400,
                            height: 1.0,
                          ),
                        ),
                        SizedBox(width: 8 * s),
                        Text(
                          'новых\nутечки',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white.withOpacity(0.40),
                            fontSize: 12 * s,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Divider 1
                  Container(
                    width: 1,
                    height: 24 * s,
                    color: const Color(0x6B6EAF91),
                  ),

                  // Metric 2: 24 сервиса
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '24',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white,
                            fontSize: 32 * s,
                            fontWeight: FontWeight.w400,
                            height: 1.0,
                          ),
                        ),
                        SizedBox(width: 8 * s),
                        Text(
                          'сервиса',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white.withOpacity(0.40),
                            fontSize: 12 * s,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Divider 2
                  Container(
                    width: 1,
                    height: 24 * s,
                    color: const Color(0x6B6EAF91),
                  ),

                  // Metric 3: 4 устройства
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '4',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white,
                            fontSize: 32 * s,
                            fontWeight: FontWeight.w400,
                            height: 1.0,
                          ),
                        ),
                        SizedBox(width: 8 * s),
                        Text(
                          'устройства',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white.withOpacity(0.40),
                            fontSize: 12 * s,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 28 * s),

              // 3. Subtitle: Активный e-mail
              Text(
                'Активный e-mail',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w400,
                  height: 1.30,
                ),
              ),
              SizedBox(height: 12 * s),

              // Email Item Card (70px height) -> Navigates to Email Check
              _buildIdentifierTile(
                s,
                icon: Icons.mail_outline,
                iconBgColor: const Color(0x07D9D9D9),
                iconBorderColor: const Color(0x19D9D9D9),
                iconColor: const Color(0xFF6EAF91),
                title: 'backup@gmail.com',
                subtitle: '0 утечек',
                hasWarning: false,
                onTap: () => context.push('/email-check'),
              ),

              SizedBox(height: 24 * s),

              // 4. Subtitle: Активный номер
              Text(
                'Активный номер',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w400,
                  height: 1.30,
                ),
              ),
              SizedBox(height: 12 * s),

              // Phone Item Card (70px height with warning) -> Navigates to Phone Check
              _buildIdentifierTile(
                s,
                icon: Icons.smartphone_outlined,
                iconBgColor: const Color(0x21E24848),
                iconBorderColor: const Color(0x19E24848),
                iconColor: const Color(0xFFE24848),
                title: '+7 999 123-45-67',
                subtitle: '47 утечек',
                hasWarning: true,
                onTap: () => context.push('/phone-check'),
              ),

              SizedBox(height: 28 * s),

              // 5. Section: Новые утечки & Посмотреть все
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Новые утечки',
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: Colors.white,
                      fontSize: 18 * s,
                      fontWeight: FontWeight.w400,
                      height: 1.30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push('/data-exposure'),
                    child: Text(
                      'Посмотреть все',
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: const Color(0xFFABABAB),
                        fontSize: 14 * s,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12 * s),

              // Leak Card 1: Collection #1234
              _buildLeakTile(
                context,
                s,
                title: 'Collection #1234',
                subtitle: '5 мин назад ваши данные найдены в этой базе',
                leaksCount: '47',
              ),
              SizedBox(height: 12 * s),

              // Leak Card 2: DarkForums
              _buildLeakTile(
                context,
                s,
                title: 'DarkForums',
                subtitle: '15 мин назад ваши данные найдены в этой базе',
                leaksCount: '23',
              ),

              SizedBox(height: 120 * s),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIdentifierTile(
    double s, {
    required IconData icon,
    required Color iconBgColor,
    required Color iconBorderColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool hasWarning,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12 * s),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.85, sigmaY: 3.85),
          child: Container(
            width: double.infinity,
            height: 70 * s,
            padding: EdgeInsets.symmetric(horizontal: 16 * s),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12 * s),
              border: Border.all(color: const Color(0x51D9D9D9)),
            ),
            child: Row(
              children: [
                // Icon Box
                Container(
                  width: 42 * s,
                  height: 42 * s,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(9 * s),
                    border: Border.all(color: iconBorderColor),
                  ),
                  child: Center(
                    child: Icon(icon, color: iconColor, size: 20 * s),
                  ),
                ),
                SizedBox(width: 14 * s),

                // Title and Subtitle
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          color: Colors.white,
                          fontSize: 14 * s,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 2 * s),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          color: Colors.white.withOpacity(0.40),
                          fontSize: 12 * s,
                        ),
                      ),
                    ],
                  ),
                ),

                // Right Warning Icon if applicable
                if (hasWarning)
                  Icon(
                    Icons.error_outline,
                    color: const Color(0xFFE24848),
                    size: 20 * s,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeakTile(
    BuildContext context,
    double s, {
    required String title,
    required String subtitle,
    required String leaksCount,
  }) {
    return GestureDetector(
      onTap: () => _showLeakDetailModal(
        context,
        s,
        title: title,
        leaksCount: leaksCount,
        subtitle: subtitle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12 * s),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.85, sigmaY: 3.85),
          child: Container(
            width: double.infinity,
            height: 70 * s,
            padding: EdgeInsets.symmetric(horizontal: 16 * s),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12 * s),
              border: Border.all(color: const Color(0x51D9D9D9)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          color: Colors.white,
                          fontSize: 14 * s,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 2 * s),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          color: Colors.white.withOpacity(0.40),
                          fontSize: 12 * s,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  leaksCount,
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    color: const Color(0xFFB20F0F),
                    fontSize: 20 * s,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
