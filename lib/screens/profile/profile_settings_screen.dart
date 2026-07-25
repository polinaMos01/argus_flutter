import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;

    return Scaffold(
      backgroundColor: Colors.transparent, // Handled by MainLayout gradient
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24 * s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 126 * s), // Space for MainLayout header (110) + offset
              
              // User Info Block (Matching Screenshot 5)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Добро пожаловать',
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          color: const Color(0xFFACACAC),
                          fontSize: 14 * s,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10 * s, vertical: 4 * s),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD1FFEA),
                          borderRadius: BorderRadius.circular(20 * s),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.workspace_premium, color: const Color(0xFF2E493C), size: 12 * s),
                            SizedBox(width: 4 * s),
                            Text(
                              'до 15.08.2026',
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: const Color(0xFF2E493C),
                                fontSize: 10 * s,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4 * s),
                  Text(
                    'Алекс Томсон',
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: Colors.white,
                      fontSize: 24 * s,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4 * s),
                  Text(
                    'ghost_user@protonmail.com',
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: const Color(0xFFACACAC),
                      fontSize: 14 * s,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 32 * s),
              
              // Аккаунт
              Text(
                'Аккаунт',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                ),
              ),
              SizedBox(height: 16 * s),
              _buildSectionBlock(
                s,
                children: [
                  _buildListTile(
                    s,
                    svgPath: 'assets/images/profile_user.svg',
                    title: 'Мой профиль',
                    onTap: () => context.push('/profile/edit'),
                  ),
                  _buildListTile(
                    s,
                    svgPath: 'assets/images/Group-1.svg',
                    title: 'Подписка и тарифы',
                    onTap: () => context.push('/tariffs'),
                  ),
                  _buildListTile(
                    s,
                    svgPath: 'assets/images/Group-3.svg',
                    title: 'Настройка',
                    onTap: () => context.push('/profile/app-settings'),
                  ),
                  _buildListTile(
                    s,
                    svgPath: 'assets/images/smartphone.svg',
                    title: 'Устройства',
                    onTap: () => context.push('/profile/active-sessions'),
                  ),
                  _buildListTile(
                    s,
                    svgPath: 'assets/images/Vector-2.svg',
                    title: 'Уведомления',
                    onTap: () => context.push('/notifications/settings'),
                  ),
                  _buildListTile(
                    s,
                    svgPath: 'assets/images/shield.svg',
                    title: 'Безопасность аккаунта',
                    onTap: () => context.push('/profile/security'),
                    isLast: true,
                  ),
                ],
              ),
              
              SizedBox(height: 32 * s),
              
              // Помощь
              Text(
                'Помощь',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                ),
              ),
              SizedBox(height: 16 * s),
              _buildSectionBlock(
                s,
                children: [
                  _buildListTile(
                    s,
                    svgPath: 'assets/images/Vector.svg',
                    title: 'Поддержка',
                    onTap: () => context.push('/profile/support'),
                  ),
                  _buildListTile(
                    s,
                    svgPath: 'assets/images/Vector-1.svg',
                    title: 'О приложении',
                    onTap: () => context.push('/profile/about'),
                    isLast: true,
                  ),
                ],
              ),
              
              SizedBox(height: 32 * s),
              
              // Выйти
              GestureDetector(
                onTap: () {
                  context.go('/login');
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
                        color: const Color(0xFFB21010).withOpacity(0.34),
                        borderRadius: BorderRadius.circular(31 * s),
                        border: Border.all(
                          color: const Color(0xFF194832).withOpacity(0.35),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Text(
                            'Выйти',
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: Colors.white,
                              fontSize: 16 * s,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios, color: Colors.white.withOpacity(0.5), size: 14 * s),
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

  Widget _buildSectionBlock(double s, {required List<Widget> children}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12 * s),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.85, sigmaY: 3.85),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12 * s),
            border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.10)),
          ),
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(
    double s, {
    required String svgPath,
    required String title,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20 * s, vertical: 16 * s),
        child: Row(
          children: [
            Container(
              width: 40 * s,
              height: 40 * s,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10 * s),
                border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.10)),
              ),
              child: Center(
                child: SvgPicture.asset(
                  svgPath,
                  width: 20 * s,
                  height: 20 * s,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: 16 * s),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 14 * s,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white.withOpacity(0.5), size: 14 * s),
          ],
        ),
      ),
    );
  }
}
