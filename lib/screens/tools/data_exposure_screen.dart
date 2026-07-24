import 'dart:ui';
import 'package:flutter/material.dart';

enum ExposureIconType {
  email,
  phone,
  name,
  username,
  passwords,
  address,
  city,
  ip,
  other,
}

class DataExposureScreen extends StatelessWidget {
  const DataExposureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;

    final List<Map<String, dynamic>> exposureCategories = [
      {'title': 'Email', 'isExposed': true, 'type': ExposureIconType.email},
      {'title': 'Телефон', 'isExposed': false, 'type': ExposureIconType.phone},
      {'title': 'Имя', 'isExposed': true, 'type': ExposureIconType.name},
      {'title': 'Username', 'isExposed': true, 'type': ExposureIconType.username},
      {'title': 'Пароли', 'isExposed': false, 'type': ExposureIconType.passwords},
      {'title': 'Адрес', 'isExposed': false, 'type': ExposureIconType.address},
      {'title': 'Город', 'isExposed': true, 'type': ExposureIconType.city},
      {'title': 'IP=адреса', 'isExposed': true, 'type': ExposureIconType.ip},
      {'title': 'Другие категории', 'isExposed': false, 'type': ExposureIconType.other},
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24 * s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 96 * s), // Spacing below MainLayout header

              // Top Description Card: Что известно о вас
              ClipRRect(
                borderRadius: BorderRadius.circular(12 * s),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.85, sigmaY: 3.85),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20 * s, vertical: 18 * s),
                    decoration: BoxDecoration(
                      color: const Color(0x0CD9D9D9),
                      borderRadius: BorderRadius.circular(12 * s),
                      border: Border.all(color: const Color(0x51D9D9D9)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Что известно о вас',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white,
                            fontSize: 18 * s,
                            fontWeight: FontWeight.w400,
                            height: 1.30,
                          ),
                        ),
                        SizedBox(height: 10 * s),
                        Text(
                          'Ниже представлены категории данных, которые были найдены в публичных утечках. Сырые данные скрыты в целях безопасности.',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: const Color(0xFFABABAB),
                            fontSize: 16 * s,
                            fontWeight: FontWeight.w400,
                            height: 1.30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16 * s),

              // Categories Container Card
              ClipRRect(
                borderRadius: BorderRadius.circular(12 * s),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.85, sigmaY: 3.85),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16 * s, vertical: 16 * s),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12 * s),
                      border: Border.all(color: const Color(0x51D9D9D9)),
                    ),
                    child: Column(
                      children: exposureCategories.map((item) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 7 * s),
                          child: _buildExposureRow(
                            s,
                            type: item['type'] as ExposureIconType,
                            title: item['title'] as String,
                            isExposed: item['isExposed'] as bool,
                          ),
                        );
                      }).toList(),
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

  Widget _buildExposureRow(
    double s, {
    required ExposureIconType type,
    required String title,
    required bool isExposed,
  }) {
    return Row(
      children: [
        // Icon Container (42x42px) with Ultra-Thin 1px Line Custom Painter
        Container(
          width: 42 * s,
          height: 42 * s,
          decoration: BoxDecoration(
            color: const Color(0x07D9D9D9),
            borderRadius: BorderRadius.circular(9 * s),
            border: Border.all(color: const Color(0x19D9D9D9)),
          ),
          child: Center(
            child: CustomPaint(
              size: Size(18 * s, 18 * s),
              painter: _ThinIconPainter(
                type: type,
                color: const Color(0xFF6EAF91),
              ),
            ),
          ),
        ),
        SizedBox(width: 18 * s),

        // Title Text
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'GoogleSans',
              color: Colors.white,
              fontSize: 14 * s,
              fontWeight: FontWeight.w400,
              height: 1.30,
            ),
          ),
        ),

        // Badge: ОБНАРУЖЕНО (#B20F0F) or БЕЗОПАСНО (#6EAF91)
        Container(
          width: 95 * s,
          height: 21 * s,
          decoration: BoxDecoration(
            color: isExposed ? const Color(0xFFB20F0F) : const Color(0xFF6EAF91),
            borderRadius: BorderRadius.circular(31 * s),
          ),
          child: Center(
            child: Text(
              isExposed ? 'ОБНАРУЖЕНО' : 'БЕЗОПАСНО',
              style: TextStyle(
                fontFamily: 'GoogleSans',
                color: Colors.white,
                fontSize: 10 * s,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ThinIconPainter extends CustomPainter {
  final ExposureIconType type;
  final Color color;

  _ThinIconPainter({required this.type, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    switch (type) {
      case ExposureIconType.email:
        // Thin Envelope
        final rect = RRect.fromRectAndRadius(
          Rect.fromLTWH(1, 3, w - 2, h - 6),
          const Radius.circular(2),
        );
        canvas.drawRRect(rect, paint);
        final path = Path()
          ..moveTo(1, 4)
          ..lineTo(w / 2, h / 2 + 1)
          ..lineTo(w - 1, 4);
        canvas.drawPath(path, paint);
        break;

      case ExposureIconType.phone:
        // Thin Smartphone
        final rect = RRect.fromRectAndRadius(
          Rect.fromLTWH(3, 1, w - 6, h - 2),
          const Radius.circular(3),
        );
        canvas.drawRRect(rect, paint);
        canvas.drawLine(Offset(w / 2 - 2, 4), Offset(w / 2 + 2, 4), paint);
        canvas.drawCircle(Offset(w / 2, h - 4), 0.8, paint);
        break;

      case ExposureIconType.name:
      case ExposureIconType.username:
        // Thin User Head & Shoulders
        canvas.drawCircle(Offset(w / 2, h / 3), 3.0, paint);
        final bodyPath = Path()
          ..arcTo(
            Rect.fromLTWH(2, h / 2 - 1, w - 4, h / 2),
            3.14,
            3.14,
            false,
          );
        canvas.drawPath(bodyPath, paint);
        break;

      case ExposureIconType.passwords:
        // Thin Lock
        final shackle = Path()
          ..addArc(Rect.fromLTWH(w / 2 - 3.5, 1, 7, 7), 3.14, 3.14);
        canvas.drawPath(shackle, paint);
        final lockRect = RRect.fromRectAndRadius(
          Rect.fromLTWH(2.5, 7, w - 5, h - 8),
          const Radius.circular(2),
        );
        canvas.drawRRect(lockRect, paint);
        canvas.drawCircle(Offset(w / 2, h / 2 + 2), 1.0, paint);
        break;

      case ExposureIconType.address:
        // Thin Map Pin
        final pinPath = Path()
          ..moveTo(w / 2, h - 1)
          ..cubicTo(1, h / 2 + 2, 1, 3, w / 2, 1)
          ..cubicTo(w - 1, 3, w - 1, h / 2 + 2, w / 2, h - 1);
        canvas.drawPath(pinPath, paint);
        canvas.drawCircle(Offset(w / 2, h / 3 + 1), 1.8, paint);
        break;

      case ExposureIconType.city:
        // Thin Location Arrow
        final arrow = Path()
          ..moveTo(w - 1, 1)
          ..lineTo(2, h / 2 + 1)
          ..lineTo(w / 2 - 1, h / 2 + 1)
          ..lineTo(w / 2 - 1, h - 2)
          ..close();
        canvas.drawPath(arrow, paint);
        break;

      case ExposureIconType.ip:
        // Thin IP Box
        final rect = RRect.fromRectAndRadius(
          Rect.fromLTWH(1, 3, w - 2, h - 6),
          const Radius.circular(3),
        );
        canvas.drawRRect(rect, paint);
        canvas.drawCircle(Offset(w / 3.5, h / 2), 0.9, paint);
        canvas.drawCircle(Offset(w / 2, h / 2), 0.9, paint);
        canvas.drawCircle(Offset(w - w / 3.5, h / 2), 0.9, paint);
        break;

      case ExposureIconType.other:
        // Thin Shield
        final shield = Path()
          ..moveTo(w / 2, 1)
          ..lineTo(w - 2, 4)
          ..quadraticBezierTo(w - 2, h - 5, w / 2, h - 1)
          ..quadraticBezierTo(2, h - 5, 2, 4)
          ..close();
        canvas.drawPath(shield, paint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
