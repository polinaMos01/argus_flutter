import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SecurityScoreScreen extends StatefulWidget {
  const SecurityScoreScreen({super.key});

  @override
  State<SecurityScoreScreen> createState() => _SecurityScoreScreenState();
}

class _SecurityScoreScreenState extends State<SecurityScoreScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scoreAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _scoreAnimation = Tween<double>(begin: 0, end: 86).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
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
              SizedBox(height: 126 * s), // MainLayout header offset + 48px margin

              // HERO CARD (Top Gauge & Score) - Figma 114-1702
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 24 * s, horizontal: 20 * s),
                decoration: ShapeDecoration(
                  color: const Color(0x0CD9D9D9),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Colors.white.withOpacity(0.12)),
                    borderRadius: BorderRadius.circular(12 * s),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: 138 * s,
                      height: 138 * s,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Circular Arc Progress Gauge Ring
                          AnimatedBuilder(
                            animation: _scoreAnimation,
                            builder: (context, child) {
                              return CustomPaint(
                                size: Size(138 * s, 138 * s),
                                painter: _GaugeArcPainter(
                                  progress: _scoreAnimation.value / 100.0,
                                  strokeWidth: 8 * s,
                                ),
                              );
                            },
                          ),

                          // Shield icon positioned at the top of the ring
                          Positioned(
                            top: 30 * s,
                            child: Container(
                              padding: EdgeInsets.all(4 * s),
                              decoration: const BoxDecoration(
                                color: Color(0xFF091417),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                'assets/images/shield_checkmark.svg',
                                width: 18 * s,
                                height: 18 * s,
                                colorFilter: const ColorFilter.mode(Color(0xFF6EAF91), BlendMode.srcIn),
                              ),
                            ),
                          ),

                          // Centered Number & Subtext (Figma 114-1702 specs)
                          AnimatedBuilder(
                            animation: _scoreAnimation,
                            builder: (context, child) {
                              return Padding(
                                padding: EdgeInsets.only(top: 32 * s),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 8 * s),
                                    Text(
                                      '${_scoreAnimation.value.toInt()}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'GoogleSans',
                                        color: Colors.white,
                                        fontSize: 53.2 * s,
                                        fontWeight: FontWeight.w400,
                                        height: 1.20,
                                      ),
                                    ),
                                    Text(
                                      '/100',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'GoogleSans',
                                        color: Colors.white.withOpacity(0.37),
                                        fontSize: 11.64 * s,
                                        fontWeight: FontWeight.w400,
                                        height: 1.20,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16 * s),

                    // Title: Хороший уровень
                    Text(
                      'Хороший уровень',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: const Color(0xFF6EAF91),
                        fontSize: 20 * s,
                        fontWeight: FontWeight.w400,
                        height: 1.30,
                      ),
                    ),
                    SizedBox(height: 4 * s),
                    Text(
                      'Обновлено 2 мин назад',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: Colors.white.withOpacity(0.40),
                        fontSize: 12 * s,
                        fontWeight: FontWeight.w400,
                        height: 1.30,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 28 * s),

              // SECTION 1: Факторы риска
              Text(
                'Факторы риска',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w400,
                  height: 1.30,
                ),
              ),
              SizedBox(height: 14 * s),

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20 * s, vertical: 16 * s),
                decoration: ShapeDecoration(
                  color: const Color(0x0CD9D9D9),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Colors.white.withOpacity(0.12)),
                    borderRadius: BorderRadius.circular(12 * s),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Утечки данных',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white,
                            fontSize: 12 * s,
                            fontWeight: FontWeight.w400,
                            height: 1.30,
                          ),
                        ),
                        SizedBox(height: 4 * s),
                        Text(
                          '47 утечек обнаружено в базах данных',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white.withOpacity(0.40),
                            fontSize: 12 * s,
                            fontWeight: FontWeight.w400,
                            height: 1.30,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '71%',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: Colors.white.withOpacity(0.40),
                        fontSize: 12 * s,
                        fontWeight: FontWeight.w400,
                        height: 1.30,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 28 * s),

              // SECTION 2: История изменения
              Text(
                'История изменения',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w400,
                  height: 1.30,
                ),
              ),
              SizedBox(height: 14 * s),

              Container(
                decoration: ShapeDecoration(
                  color: const Color(0x0CD9D9D9),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Colors.white.withOpacity(0.12)),
                    borderRadius: BorderRadius.circular(12 * s),
                  ),
                ),
                child: Column(
                  children: [
                    _buildHistoryRow(
                      s,
                      dotColor: const Color(0x91FF0000),
                      pointsText: '-4 балла',
                      subtitle: 'Новая утечка данных обнаружена',
                      timeText: 'Сегодня',
                    ),
                    const Divider(color: Color(0x1ED9D9D9), height: 1, thickness: 1),
                    _buildHistoryRow(
                      s,
                      dotColor: const Color(0xFF99FFD0),
                      pointsText: '+6 баллов',
                      subtitle: 'Пароль сменён в 2 сервисах',
                      timeText: 'Вчера',
                    ),
                    const Divider(color: Color(0x1ED9D9D9), height: 1, thickness: 1),
                    _buildHistoryRow(
                      s,
                      dotColor: const Color(0xFF99FFD0),
                      pointsText: '+2 балла',
                      subtitle: 'Включена двухфакторная защита',
                      timeText: '3 дня',
                    ),
                  ],
                ),
              ),

              SizedBox(height: 28 * s),

              // SECTION 3: Что улучшить
              Text(
                'Что улучшить',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w400,
                  height: 1.30,
                ),
              ),
              SizedBox(height: 14 * s),

              GestureDetector(
                onTap: () => context.push('/password-center'),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 18 * s, vertical: 16 * s),
                  decoration: ShapeDecoration(
                    color: const Color(0x0CD9D9D9),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Colors.white.withOpacity(0.12)),
                      borderRadius: BorderRadius.circular(12 * s),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24 * s,
                        height: 24 * s,
                        decoration: const BoxDecoration(
                          color: Color(0x26EB5757),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(Icons.error_outline_rounded, color: const Color(0xFFEB5757), size: 16 * s),
                        ),
                      ),
                      SizedBox(width: 12 * s),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Смените пароль в утёкших сервисах',
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: Colors.white,
                                fontSize: 12 * s,
                                fontWeight: FontWeight.w400,
                                height: 1.30,
                              ),
                            ),
                            SizedBox(height: 2 * s),
                            Text(
                              '+8 баллов к рейтингу',
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: Colors.white.withOpacity(0.40),
                                fontSize: 12 * s,
                                fontWeight: FontWeight.w400,
                                height: 1.30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

  Widget _buildHistoryRow(
    double s, {
    required Color dotColor,
    required String pointsText,
    required String subtitle,
    required String timeText,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * s, vertical: 14 * s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4 * s),
            child: Container(
              width: 8 * s,
              height: 8 * s,
              decoration: ShapeDecoration(
                color: dotColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24 * s),
                ),
              ),
            ),
          ),
          SizedBox(width: 12 * s),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      pointsText,
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: Colors.white,
                        fontSize: 12 * s,
                        fontWeight: FontWeight.w400,
                        height: 1.30,
                      ),
                    ),
                    Text(
                      timeText,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: Colors.white.withOpacity(0.40),
                        fontSize: 12 * s,
                        fontWeight: FontWeight.w400,
                        height: 1.30,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2 * s),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    color: Colors.white.withOpacity(0.40),
                    fontSize: 12 * s,
                    fontWeight: FontWeight.w400,
                    height: 1.30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for the Circular Ring Progress Gauge
class _GaugeArcPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;

  _GaugeArcPainter({required this.progress, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Background track ring (Figma 0x19D9D9D9)
    final bgPaint = Paint()
      ..color = const Color(0x19D9D9D9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Active progress gradient ring (Exact Figma colors)
    final activePaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFFD1FFEA),
          Color(0xFFA5DDC4),
          Color(0xFF84BCA0),
          Color(0xFF66997F),
          Color(0xFF517F6B),
          Color(0xFF3F6654),
          Color(0xFF335142),
          Color(0xFF2D483C),
        ],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const startAngle = -3.14159 * 1.25;
    const sweepAngle = 3.14159 * 1.5;

    canvas.drawArc(
      rect,
      startAngle,
      sweepAngle,
      false,
      bgPaint,
    );

    canvas.drawArc(
      rect,
      startAngle,
      sweepAngle * progress,
      false,
      activePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _GaugeArcPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
