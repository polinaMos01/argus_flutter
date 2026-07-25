import 'dart:ui';
import 'package:flutter/material.dart';
import '../../widgets/app_toast.dart';

enum _ThinDeviceType { phone, pc, android, laptop, power }

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key});

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  final List<Map<String, dynamic>> _activeSessions = [
    {
      'id': '1',
      'title': 'Windows PC',
      'subtitle': 'Последний вход: 2 ч. назад\nРоссия, Москва',
      'deviceType': _ThinDeviceType.pc,
      'statusText': 'Безопасно',
      'statusColor': const Color(0xE23E7261),
      'badgeWidth': 71.0,
    },
    {
      'id': '2',
      'title': 'Android SM-G991B',
      'subtitle': 'Последний вход: 21.06.2026\nРоссия, Санкт-Петербург',
      'deviceType': _ThinDeviceType.android,
      'statusText': 'Подозрительно',
      'statusColor': const Color(0xFFCF5A00),
      'badgeWidth': 90.0,
    },
    {
      'id': '3',
      'title': 'MacBook Pro',
      'subtitle': 'Последний вход: 15.06.2026\nРоссия, Москва',
      'deviceType': _ThinDeviceType.laptop,
      'statusText': 'Неизвестно',
      'statusColor': const Color(0x1CE0E9E6),
      'badgeWidth': 71.0,
    },
  ];

  void _terminateAllOtherSessions() {
    if (_activeSessions.isEmpty) {
      showAppToast(context, 'Нет других активных сеансов');
      return;
    }
    setState(() {
      _activeSessions.clear();
    });
    showAppToast(context, 'Все сторонние сеансы завершены');
  }

  void _removeSession(int index) {
    final removed = _activeSessions[index];
    setState(() {
      _activeSessions.removeAt(index);
    });
    showAppToast(context, 'Сеанс "${removed['title']}" завершён');
  }

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
              SizedBox(height: 126 * s), // MainLayout top header padding

              // 1. Header: Это устройство
              Text(
                'Это устройство',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w400,
                  height: 1.30,
                ),
              ),
              SizedBox(height: 12 * s),

              // Card 1: This device (iPhone 15 Pro)
              _buildDeviceCard(
                s,
                title: 'iPhone 15 Pro',
                subtitle: 'Последний вход: сейчас \nРоссия, Москва',
                deviceType: _ThinDeviceType.phone,
                statusText: 'Безопасно',
                statusColor: const Color(0xE23E7261),
                badgeWidth: 71.0,
                onClose: null,
              ),

              SizedBox(height: 24 * s),

              // Action Link: Завершить все другие сеансы
              Center(
                child: GestureDetector(
                  onTap: _terminateAllOtherSessions,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomPaint(
                        size: Size(20 * s, 20 * s),
                        painter: _ThinDeviceIconPainter(
                          type: _ThinDeviceType.power,
                          color: const Color(0xFFB20F0F),
                        ),
                      ),
                      SizedBox(width: 8 * s),
                      Text(
                        'Завершить все другие сеансы',
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          color: const Color(0xFFB20F0F),
                          fontSize: 18 * s,
                          fontWeight: FontWeight.w400,
                          height: 1.30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 28 * s),

              // 2. Header: Активные сеансы
              Text(
                'Активные сеансы',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w400,
                  height: 1.30,
                ),
              ),
              SizedBox(height: 12 * s),

              // Active Sessions List
              if (_activeSessions.isEmpty)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20 * s),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12 * s),
                    border: Border.all(color: const Color(0x51D9D9D9)),
                  ),
                  child: Center(
                    child: Text(
                      'Нет других активных сеансов.\nВаш аккаунт открыт только на этом устройстве.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: Colors.white.withOpacity(0.40),
                        fontSize: 14 * s,
                        height: 1.30,
                      ),
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _activeSessions.length,
                  separatorBuilder: (ctx, idx) => SizedBox(height: 12 * s),
                  itemBuilder: (ctx, idx) {
                    final session = _activeSessions[idx];
                    return _buildDeviceCard(
                      s,
                      title: session['title'] as String,
                      subtitle: session['subtitle'] as String,
                      deviceType: session['deviceType'] as _ThinDeviceType,
                      statusText: session['statusText'] as String,
                      statusColor: session['statusColor'] as Color,
                      badgeWidth: session['badgeWidth'] as double,
                      onClose: () => _removeSession(idx),
                    );
                  },
                ),

              SizedBox(height: 120 * s),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceCard(
    double s, {
    required String title,
    required String subtitle,
    required _ThinDeviceType deviceType,
    required String statusText,
    required Color statusColor,
    required double badgeWidth,
    required VoidCallback? onClose,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12 * s),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.85, sigmaY: 3.85),
        child: Container(
          width: double.infinity,
          height: 76 * s,
          padding: EdgeInsets.symmetric(horizontal: 16 * s, vertical: 12 * s),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12 * s),
            border: Border.all(color: const Color(0x51D9D9D9)),
          ),
          child: Row(
            children: [
              // Icon Container (42x42) with 0.7px ultra-thin vector icon
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
                    size: Size(20 * s, 20 * s),
                    painter: _ThinDeviceIconPainter(
                      type: deviceType,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 14 * s),

              // Title & Subtitle
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
                        height: 1.30,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3 * s),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: Colors.white.withOpacity(0.40),
                        fontSize: 12 * s,
                        fontWeight: FontWeight.w400,
                        height: 1.30,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              SizedBox(width: 8 * s),

              // Status Badge
              Container(
                width: badgeWidth * s,
                height: 21 * s,
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(31 * s),
                ),
                alignment: Alignment.center,
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    color: Colors.white,
                    fontSize: 10 * s,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              if (onClose != null) ...[
                SizedBox(width: 6 * s),
                GestureDetector(
                  onTap: onClose,
                  child: Icon(
                    Icons.close_rounded,
                    color: Colors.white54,
                    size: 18 * s,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ThinDeviceIconPainter extends CustomPainter {
  final _ThinDeviceType type;
  final Color color;

  _ThinDeviceIconPainter({required this.type, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.7
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    switch (type) {
      case _ThinDeviceType.phone:
      case _ThinDeviceType.android:
        final rrect = RRect.fromLTRBR(
          w * 0.22, h * 0.12, w * 0.78, h * 0.88,
          Radius.circular(w * 0.1),
        );
        canvas.drawRRect(rrect, paint);
        canvas.drawLine(
          Offset(w * 0.42, h * 0.8),
          Offset(w * 0.58, h * 0.8),
          paint,
        );
        break;

      case _ThinDeviceType.pc:
        final screenRRect = RRect.fromLTRBR(
          w * 0.15, h * 0.18, w * 0.85, h * 0.7,
          Radius.circular(w * 0.05),
        );
        canvas.drawRRect(screenRRect, paint);
        canvas.drawLine(
          Offset(w * 0.5, h * 0.7),
          Offset(w * 0.5, h * 0.84),
          paint,
        );
        canvas.drawLine(
          Offset(w * 0.32, h * 0.84),
          Offset(w * 0.68, h * 0.84),
          paint,
        );
        break;

      case _ThinDeviceType.laptop:
        final laptopRRect = RRect.fromLTRBR(
          w * 0.2, h * 0.22, w * 0.8, h * 0.7,
          Radius.circular(w * 0.05),
        );
        canvas.drawRRect(laptopRRect, paint);
        canvas.drawLine(
          Offset(w * 0.1, h * 0.78),
          Offset(w * 0.9, h * 0.78),
          paint,
        );
        canvas.drawLine(
          Offset(w * 0.1, h * 0.78),
          Offset(w * 0.2, h * 0.7),
          paint,
        );
        canvas.drawLine(
          Offset(w * 0.9, h * 0.78),
          Offset(w * 0.8, h * 0.7),
          paint,
        );
        break;

      case _ThinDeviceType.power:
        final rect = Rect.fromLTRB(w * 0.2, h * 0.2, w * 0.8, h * 0.8);
        canvas.drawArc(rect, -1.1, 5.3, false, paint);
        canvas.drawLine(
          Offset(w * 0.5, h * 0.15),
          Offset(w * 0.5, h * 0.45),
          paint,
        );
        break;
    }
  }

  @override
  bool shouldRepaint(covariant _ThinDeviceIconPainter oldDelegate) =>
      oldDelegate.type != type || oldDelegate.color != color;
}
