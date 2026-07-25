import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/app_toast.dart';

class ActiveSessionsScreen extends StatefulWidget {
  const ActiveSessionsScreen({super.key});

  @override
  State<ActiveSessionsScreen> createState() => _ActiveSessionsScreenState();
}

class _ActiveSessionsScreenState extends State<ActiveSessionsScreen> {
  bool _hasMultipleSessions = true;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;

    return Scaffold(
      backgroundColor: const Color(0xFF060E11),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24 * s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 126 * s), // MainLayout header offset

              // Section 1: Это устройство
              Text(
                'Это устройство',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 16 * s),
              _buildDeviceCard(
                s,
                iconPath: 'assets/images/smartphone.svg',
                title: 'iPhone 15 Pro',
                subtitle: 'Последний вход: сейчас\nРоссия, Москва',
                statusText: 'Безопасно',
                statusColor: const Color(0xFF2E493C),
                statusBg: const Color(0xFFD1FFEA).withOpacity(0.3),
              ),

              if (_hasMultipleSessions) ...[
                SizedBox(height: 24 * s),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _hasMultipleSessions = false;
                    });
                    showAppToast(context, 'Все другие сеансы завершены');
                  },
                  child: Row(
                    children: [
                      Icon(Icons.block, color: const Color(0xFFFF4B4B), size: 20 * s),
                      SizedBox(width: 12 * s),
                      Text(
                        'Завершить все другие сеансы',
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          color: const Color(0xFFFF4B4B),
                          fontSize: 16 * s,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32 * s),

                // Section 2: Активные сеансы
                Text(
                  'Активные сеансы',
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    color: Colors.white,
                    fontSize: 18 * s,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 16 * s),
                _buildDeviceCard(
                  s,
                  iconPath: 'assets/images/file-text.svg', // PC icon placeholder
                  title: 'Windows PC',
                  subtitle: 'Последний вход: 2 ч. назад\nРоссия, Москва',
                  statusText: 'Безопасно',
                  statusColor: const Color(0xFF2E493C),
                  statusBg: const Color(0xFFD1FFEA).withOpacity(0.3),
                ),
                SizedBox(height: 12 * s),
                _buildDeviceCard(
                  s,
                  iconPath: 'assets/images/smartphone.svg',
                  title: 'Android SM-G991B',
                  subtitle: 'Последний вход: 21.06.2026\nРоссия, Санкт-Петербург',
                  statusText: 'Подозрительно',
                  statusColor: Colors.white,
                  statusBg: const Color(0xFFE65100),
                ),
                SizedBox(height: 12 * s),
                _buildDeviceCard(
                  s,
                  iconPath: 'assets/images/file-text.svg',
                  title: 'MacBook Pro',
                  subtitle: 'Последний вход: 15.06.2026\nРоссия, Москва',
                  statusText: 'Неизвестно',
                  statusColor: Colors.white70,
                  statusBg: const Color(0xFF424242),
                ),
              ],

              SizedBox(height: 120 * s),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceCard(
    double s, {
    required String iconPath,
    required String title,
    required String subtitle,
    required String statusText,
    required Color statusColor,
    required Color statusBg,
  }) {
    return Container(
      padding: EdgeInsets.all(16 * s),
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9).withOpacity(0.03),
        borderRadius: BorderRadius.circular(16 * s),
        border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 48 * s,
            height: 48 * s,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12 * s),
              border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.2)),
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: 24 * s,
                height: 24 * s,
                colorFilter: const ColorFilter.mode(Color(0xFF6EAF91), BlendMode.srcIn),
              ),
            ),
          ),
          SizedBox(width: 16 * s),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    color: Colors.white,
                    fontSize: 16 * s,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 4 * s),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    color: const Color(0xFFACACAC),
                    fontSize: 12 * s,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8 * s),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10 * s, vertical: 4 * s),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(12 * s),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    color: statusColor,
                    fontSize: 11 * s,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 8 * s),
              Icon(Icons.delete_outline, color: Colors.white38, size: 18 * s),
            ],
          ),
        ],
      ),
    );
  }
}
