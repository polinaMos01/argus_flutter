import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/app_button.dart';
import '../../widgets/data_exposure_block.dart';

class PhoneCheckResultScreen extends StatelessWidget {
  final String phone;

  const PhoneCheckResultScreen({Key? key, required this.phone}) : super(key: key);

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
                  color: const Color(0xFF2A1111),
                  borderRadius: BorderRadius.circular(16 * s),
                  border: Border.all(color: const Color(0xFF4A1E1E)),
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
                              colors: [Color(0xFF600606), Color(0xFFFC1111)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(8 * s),
                          ),
                          child: Icon(Icons.close, color: Colors.black, size: 28 * s),
                        ),
                      ],
                    ),
                    SizedBox(height: 16 * s),
                    Text(
                      phone,
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
                        _buildStatColumn('Обнаружены\nнарушения', '46', Colors.white, s),
                        _buildDivider(s),
                        _buildStatColumn('Источники\nданных', '15', Colors.white, s),
                        _buildDivider(s),
                        _buildStatColumn('Степень\nтяжести', 'ВЫСОКИЙ', const Color(0xFFE53935), s),
                      ],
                    ),
                    SizedBox(height: 32 * s),
                    _buildInfoRow('Утечки', '46', s),
                    SizedBox(height: 16 * s),
                    _buildInfoRow('Тип данных', 'Телефон, ФИО, Адрес', s),
                    SizedBox(height: 16 * s),
                    _buildInfoRow('Риск фишинга', 'высокий', s, isWarning: true),
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
              SizedBox(height: 32 * s),

              // Block: Что знают о вас мошенники (Data Exposure)
              const DataExposureBlock(
                showTopCard: false,
                customHeader: 'Что знают о вас мошенники',
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
