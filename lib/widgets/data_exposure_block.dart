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

class DataExposureBlock extends StatelessWidget {
  final String? customHeader;
  final bool showTopCard;

  const DataExposureBlock({
    super.key,
    this.customHeader = 'Что знают о вас мошенники',
    this.showTopCard = false,
  });

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
      {'title': 'IP-адреса', 'isExposed': true, 'type': ExposureIconType.ip},
      {'title': 'Другие категории', 'isExposed': false, 'type': ExposureIconType.other},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTopCard) ...[
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
          SizedBox(height: 24 * s),
        ],

        if (customHeader != null && customHeader!.isNotEmpty) ...[
          Text(
            customHeader!,
            style: TextStyle(
              fontFamily: 'GoogleSans',
              color: Colors.white,
              fontSize: 18 * s,
              fontWeight: FontWeight.w400,
              height: 1.30,
            ),
          ),
          SizedBox(height: 16 * s),
        ],

        // Categories Container Card
        ClipRRect(
          borderRadius: BorderRadius.circular(12 * s),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.85, sigmaY: 3.85),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16 * s, vertical: 16 * s),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.12),
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
      ],
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
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'GoogleSans',
              color: Colors.white,
              fontSize: 16 * s,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12 * s, vertical: 4 * s),
          decoration: BoxDecoration(
            color: isExposed ? const Color(0xFF590C0C) : const Color(0x116EAF91),
            borderRadius: BorderRadius.circular(8 * s),
            border: Border.all(
              color: isExposed ? const Color(0xFFFF4B4B) : const Color(0xFF6EAF91),
              width: 1,
            ),
          ),
          child: Text(
            isExposed ? 'Обнаружено' : 'Безопасно',
            style: TextStyle(
              fontFamily: 'GoogleSans',
              color: isExposed ? const Color(0xFFFF4B4B) : const Color(0xFF6EAF91),
              fontSize: 12 * s,
              fontWeight: FontWeight.w500,
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
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double w = size.width;
    final double h = size.height;

    switch (type) {
      case ExposureIconType.email:
        final Rect rect = Rect.fromLTWH(0, h * 0.15, w, h * 0.7);
        canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(2)), paint);
        final Path path = Path()
          ..moveTo(0, h * 0.15)
          ..lineTo(w * 0.5, h * 0.55)
          ..lineTo(w, h * 0.15);
        canvas.drawPath(path, paint);
        break;

      case ExposureIconType.phone:
        final Rect rect = Rect.fromLTWH(w * 0.2, 0, w * 0.6, h);
        canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(3)), paint);
        canvas.drawLine(Offset(w * 0.4, h * 0.88), Offset(w * 0.6, h * 0.88), paint);
        break;

      case ExposureIconType.name:
        canvas.drawCircle(Offset(w * 0.5, h * 0.3), w * 0.25, paint);
        final Path bodyPath = Path()
          ..arcTo(Rect.fromLTWH(w * 0.1, h * 0.55, w * 0.8, h * 0.45), 3.14, 3.14, false);
        canvas.drawPath(bodyPath, paint);
        break;

      case ExposureIconType.username:
        canvas.drawCircle(Offset(w * 0.5, h * 0.5), w * 0.4, paint);
        final Path path = Path()
          ..moveTo(w * 0.35, h * 0.65)
          ..cubicTo(w * 0.35, h * 0.35, w * 0.65, h * 0.35, w * 0.65, h * 0.5)
          ..cubicTo(w * 0.65, h * 0.65, w * 0.45, h * 0.65, w * 0.45, h * 0.5);
        canvas.drawPath(path, paint);
        break;

      case ExposureIconType.passwords:
        canvas.drawCircle(Offset(w * 0.2, h * 0.5), w * 0.15, paint);
        canvas.drawCircle(Offset(w * 0.5, h * 0.5), w * 0.15, paint);
        canvas.drawCircle(Offset(w * 0.8, h * 0.5), w * 0.15, paint);
        break;

      case ExposureIconType.address:
        final Path path = Path()
          ..moveTo(w * 0.5, h)
          ..cubicTo(w * 0.1, h * 0.6, w * 0.1, h * 0.3, w * 0.5, h * 0.1)
          ..cubicTo(w * 0.9, h * 0.3, w * 0.9, h * 0.6, w * 0.5, h);
        canvas.drawPath(path, paint);
        canvas.drawCircle(Offset(w * 0.5, h * 0.4), w * 0.15, paint);
        break;

      case ExposureIconType.city:
        final Path path = Path()
          ..moveTo(w * 0.1, h)
          ..lineTo(w * 0.1, h * 0.3)
          ..lineTo(w * 0.5, h * 0.1)
          ..lineTo(w * 0.9, h * 0.3)
          ..lineTo(w * 0.9, h);
        canvas.drawPath(path, paint);
        canvas.drawRect(Rect.fromLTWH(w * 0.3, h * 0.5, w * 0.4, h * 0.5), paint);
        break;

      case ExposureIconType.ip:
        canvas.drawCircle(Offset(w * 0.5, h * 0.5), w * 0.4, paint);
        canvas.drawOval(Rect.fromLTWH(w * 0.3, h * 0.1, w * 0.4, h * 0.8), paint);
        canvas.drawLine(Offset(w * 0.1, h * 0.5), Offset(w * 0.9, h * 0.5), paint);
        break;

      case ExposureIconType.other:
        canvas.drawCircle(Offset(w * 0.5, h * 0.5), w * 0.4, paint);
        canvas.drawLine(Offset(w * 0.5, h * 0.25), Offset(w * 0.5, h * 0.55), paint);
        canvas.drawCircle(Offset(w * 0.5, h * 0.72), 1.0, paint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
