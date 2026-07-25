import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LinkCheckResultScreen extends StatelessWidget {
  final String link;

  const LinkCheckResultScreen({Key? key, required this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;

    return Scaffold(
      backgroundColor: const Color(0xFF060E11), // Handled by MainLayout
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24 * s),
          child: Column(
            children: [
              SizedBox(height: 96 * s), // Spacing for MainLayout header
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24 * s),
                decoration: BoxDecoration(
                  color: const Color(0xFF112A1B),
                  borderRadius: BorderRadius.circular(16 * s),
                  border: Border.all(color: const Color(0xFF1E4A30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Результаты сканирования',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white,
                            fontSize: 16 * s,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          width: 40 * s,
                          height: 40 * s,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF066033), Color(0xFF11FC85)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(8 * s),
                          ),
                          child: Icon(Icons.check, color: Colors.black, size: 28 * s),
                        ),
                      ],
                    ),
                    SizedBox(height: 16 * s),
                    Text(
                      link,
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: Colors.white,
                        fontSize: 20 * s,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4 * s),
                    Text(
                      'Завершено только что',
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 13 * s,
                      ),
                    ),
                    SizedBox(height: 24 * s),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatColumn('Обнаружены\nугрозы', '0', Colors.white, s),
                        _buildDivider(s),
                        _buildStatColumn('Проверено\nбаз', '12', Colors.white, s),
                        _buildDivider(s),
                        _buildStatColumn('Степень\nтяжести', 'БЕЗОПАСНО', const Color(0xFF6EAF91), s),
                      ],
                    ),
                    SizedBox(height: 32 * s),
                    _buildInfoRow('Вредоносный код', 'не обнаружено', s),
                    SizedBox(height: 16 * s),
                    _buildInfoRow('Тип ссылки', 'URL', s),
                    SizedBox(height: 16 * s),
                    _buildInfoRow('Риск фишинга', 'низкий', s, isWarning: false),
                  ],
                ),
              ),
              SizedBox(height: 48 * s),
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 18 * s),
                  decoration: BoxDecoration(
                    color: const Color(0xFF386851),
                    borderRadius: BorderRadius.circular(30 * s),
                  ),
                  child: Center(
                    child: Text(
                      'Новое сканирование',
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: Colors.white,
                        fontSize: 16 * s,
                        fontWeight: FontWeight.w500,
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

  Widget _buildStatColumn(String label, String value, Color valueColor, double s) {
    bool isLong = value.length > 4;
    return Column(
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'GoogleSans',
            color: Colors.white.withOpacity(0.6),
            fontSize: 12 * s,
            height: 1.2,
          ),
        ),
        SizedBox(height: 8 * s),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'GoogleSans',
            color: valueColor,
            fontSize: (isLong ? 14 : 24) * s,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(double s) {
    return Container(
      width: 1,
      height: 40 * s,
      color: Colors.white.withOpacity(0.1),
    );
  }

  Widget _buildInfoRow(String label, String value, double s, {bool isWarning = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'GoogleSans',
            color: Colors.white.withOpacity(0.9),
            fontSize: 14 * s,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12 * s, vertical: 6 * s),
          decoration: BoxDecoration(
            color: isWarning ? const Color(0xFFB71C1C) : Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16 * s),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'GoogleSans',
              color: Colors.white.withOpacity(0.8),
              fontSize: 12 * s,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
