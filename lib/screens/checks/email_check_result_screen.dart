import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/app_button.dart';

class EmailCheckResultScreen extends StatelessWidget {
  final String email;

  const EmailCheckResultScreen({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;

    return Scaffold(
      backgroundColor: Colors.transparent, // Handled by MainLayout
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
                  color: const Color(0xFF13181A),
                  borderRadius: BorderRadius.circular(16 * s),
                  border: Border.all(color: const Color(0xFF1E282C)),
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
                        SvgPicture.asset(
                          'assets/images/shield_checkmark.svg',
                          width: 40 * s,
                          height: 40 * s,
                        ),
                      ],
                    ),
                    SizedBox(height: 16 * s),
                    Text(
                      email,
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: Colors.white,
                        fontSize: 20 * s,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4 * s),
                    Text(
                      'Завершено 1 минуту назад',
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
                        _buildStatColumn('Обнаружены\nнарушения', '2', Colors.white, s),
                        _buildDivider(s),
                        _buildStatColumn('Источники\nданных', '18', Colors.white, s),
                        _buildDivider(s),
                        _buildStatColumn('Степень\nтяжести', 'Средний', const Color(0xFFE2C076), s),
                      ],
                    ),
                    SizedBox(height: 32 * s),
                    _buildInfoRow('Утечки', '23', s),
                    SizedBox(height: 16 * s),
                    _buildInfoRow('Тип данных', 'Email, Пароли', s),
                    SizedBox(height: 16 * s),
                    _buildInfoRow('Риск взлома', 'СРЕДНИЙ', s, isWarning: true),
                  ],
                ),
              ),
              SizedBox(height: 48 * s),
              AppButton(
                text: 'Повторное сканирование',
                onTap: () {
                  context.pop();
                },
              ),
              SizedBox(height: 120 * s),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value, Color valueColor, double s) {
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
            fontSize: 24 * s,
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
            color: isWarning ? const Color(0xFF8B6B23).withOpacity(0.5) : Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16 * s),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'GoogleSans',
              color: isWarning ? const Color(0xFFE2C076) : Colors.white.withOpacity(0.7),
              fontSize: 12 * s,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
