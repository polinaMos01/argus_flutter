import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ThreatsListScreen extends StatelessWidget {
  const ThreatsListScreen({super.key});

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
              SizedBox(height: 126 * s), // MainLayout header offset + 48px margin

              // SECTION 1: Сегодня (Figma Node 115-2132)
              Text(
                'Сегодня',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 14 * s),

              _buildLeakCard(
                s,
                context: context,
                title: 'Collection #1234',
                subtitle: '5 мин назад ваши данные найдены в этой базе',
                leakCount: 47,
              ),
              SizedBox(height: 12 * s),
              _buildLeakCard(
                s,
                context: context,
                title: 'DarkForums',
                subtitle: '15 мин назад ваши данные найдены в этой базе',
                leakCount: 23,
              ),

              SizedBox(height: 28 * s),

              // SECTION 2: Ранее (Figma Node 115-2132)
              Text(
                'Ранее',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 14 * s),

              _buildLeakCard(
                s,
                context: context,
                title: 'Collection #1234',
                subtitle: '5 мин назад ваши данные найдены в этой базе',
                leakCount: 47,
              ),
              SizedBox(height: 12 * s),
              _buildLeakCard(
                s,
                context: context,
                title: 'DarkForums',
                subtitle: '15 мин назад ваши данные найдены в этой базе',
                leakCount: 23,
              ),

              SizedBox(height: 120 * s),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeakCard(
    double s, {
    required BuildContext context,
    required String title,
    required String subtitle,
    required int leakCount,
  }) {
    return GestureDetector(
      onTap: () {
        context.push('/threat-detail');
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 18 * s, vertical: 16 * s),
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9).withOpacity(0.03),
          borderRadius: BorderRadius.circular(16 * s),
          border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                      fontWeight: FontWeight.w500,
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
            SizedBox(width: 14 * s),
            Text(
              '$leakCount',
              style: TextStyle(
                fontFamily: 'GoogleSans',
                color: const Color(0xFFFF4B4B),
                fontSize: 22 * s,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
