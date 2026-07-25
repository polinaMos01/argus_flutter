import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AllChecksScreen extends StatelessWidget {
  const AllChecksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Figma screen size reference: 430 x 932
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    double s(double value) => value * (canvasWidth / 430);

    return Scaffold(
        backgroundColor: Colors.transparent, // Background handled by MainLayout
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: s(26)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: s(126)), // Top padding matching MainLayout header

                    // Big Container for all checks
                    ClipRRect(
                      borderRadius: BorderRadius.circular(s(12)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3.85, sigmaY: 3.85),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                            top: s(20),
                            bottom: s(20),
                            left: s(16),
                            right: s(20),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.05),
                            border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.1)),
                            borderRadius: BorderRadius.circular(s(12)),
                          ),
                          child: Column(
                            children: [
                              _buildCheckItem(
                                s,
                                title: 'Проверка электронной почты',
                                subtitle: 'Проверьте, не произошла ли утечка вашего электронного письма.',
                                iconPath: 'assets/images/mail.svg',
                                onTap: () => context.push('/email-check'),
                              ),
                              _buildDivider(s),
                              _buildCheckItem(
                                s,
                                title: 'Проверка номера телефона',
                                subtitle: 'Проверьте, не произошла ли утечка вашего номера телефона.',
                                iconPath: 'assets/images/smartphone.svg',
                                onTap: () => context.push('/phone-check'),
                              ),
                              _buildDivider(s),
                              _buildCheckItem(
                                s,
                                title: 'Проверка файла',
                                subtitle: 'Проверяйте документы на вирусы и угрозы',
                                iconPath: 'assets/images/file-text.svg',
                                onTap: () => context.push('/file-check'),
                              ),
                              _buildDivider(s),
                              _buildCheckItem(
                                s,
                                title: 'Проверка ссылки',
                                subtitle: 'Анализ надежности ссылки',
                                iconPath: 'assets/images/lock.svg',
                                onTap: () => context.push('/link-check'),
                              ),
                              _buildDivider(s),
                              _buildCheckItem(
                                s,
                                title: 'Проверка пароля',
                                subtitle: 'Анализ надежности паролей',
                                iconPath: 'assets/images/lock.svg',
                                onTap: () => context.push('/password-check'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: s(41)),
                    Padding(
                      padding: EdgeInsets.only(left: s(5)),
                      child: Text(
                        'История проверок',
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          fontSize: s(18),
                          color: Colors.white,
                          height: 1.3,
                        ),
                      ),
                    ),
                    SizedBox(height: s(16)),

                    // History Item 1
                    _buildHistoryItem(
                      s,
                      emailOrPhone: 'ba********@gmail.com',
                      leaksCount: '0 утечек',
                      iconPath: 'assets/images/mail.svg',
                      hasWarning: false,
                    ),
                    SizedBox(height: s(10)),
                    // History Item 2
                    _buildHistoryItem(
                      s,
                      emailOrPhone: '+7 *** ***-**-67',
                      leaksCount: '47 утечек',
                      iconPath: 'assets/images/smartphone.svg',
                      hasWarning: true,
                    ),
                    
                    SizedBox(height: s(120)), // Space for bottom nav
                  ],
                ),
              ),
            ),
          );
  }

  Widget _buildCheckItem(
    double Function(double) s, {
    required String title,
    required String subtitle,
    required String iconPath,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(s(9)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.85, sigmaY: 3.85),
              child: Container(
                width: s(42),
                height: s(42),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9).withOpacity(0.03),
                  borderRadius: BorderRadius.circular(s(9)),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    iconPath,
                    width: s(23),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: s(14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    fontSize: s(14),
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: s(5)),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    fontSize: s(12),
                    color: Colors.white.withOpacity(0.4),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: s(14)),
          SvgPicture.asset(
            'assets/images/chevron_right.svg',
            width: s(14),
            height: s(14),
            colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.4), BlendMode.srcIn),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(
    double Function(double) s, {
    required String emailOrPhone,
    required String leaksCount,
    required String iconPath,
    required bool hasWarning,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(s(12)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.85, sigmaY: 3.85),
        child: Container(
          width: double.infinity,
          height: s(70),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05),
            border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.1)),
            borderRadius: BorderRadius.circular(s(12)),
          ),
          child: Row(
            children: [
              SizedBox(width: s(14)),
              ClipRRect(
                borderRadius: BorderRadius.circular(s(9)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.85, sigmaY: 3.85),
                  child: Container(
                    width: s(42),
                    height: s(42),
                    decoration: BoxDecoration(
                      color: hasWarning
                          ? const Color(0xFFE34848).withOpacity(0.13)
                          : const Color(0xFFD9D9D9).withOpacity(0.03),
                      borderRadius: BorderRadius.circular(s(9)),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        iconPath,
                        width: s(23),
                        colorFilter: hasWarning ? const ColorFilter.mode(Color(0xFFE34848), BlendMode.srcIn) : null,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: s(14)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      emailOrPhone,
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        fontSize: s(14),
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: s(2)),
                    Text(
                      leaksCount,
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        fontSize: s(12),
                        color: Colors.white.withOpacity(0.4),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              if (hasWarning)
                Padding(
                  padding: EdgeInsets.only(right: s(14)),
                  child: Icon(Icons.error_outline, color: const Color(0xFFE34848), size: s(18)),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(double Function(double) s) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: s(14)),
      child: Container(
        height: 1,
        width: double.infinity,
        color: Colors.white.withOpacity(0.10),
      ),
    );
  }
}
