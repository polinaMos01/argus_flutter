import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/app_button.dart';

class FileCheckResultScreen extends StatefulWidget {
  final String fileName;
  static int checkCounter = 0;

  const FileCheckResultScreen({Key? key, required this.fileName}) : super(key: key);

  @override
  State<FileCheckResultScreen> createState() => _FileCheckResultScreenState();
}

class _FileCheckResultScreenState extends State<FileCheckResultScreen> {
  late bool _hasThreat;

  @override
  void initState() {
    super.initState();
    _hasThreat = (FileCheckResultScreen.checkCounter % 2) != 0;
    FileCheckResultScreen.checkCounter++;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;

    final cardBg = _hasThreat ? const Color(0xFF2A1111) : const Color(0xFF101E17);
    final cardBorder = _hasThreat ? const Color(0xFF4A1E1E) : const Color(0xFF1B3125);
    final badgeColor = _hasThreat ? const Color(0xFFEB5757) : const Color(0xFF6EAF91);
    final statusText = _hasThreat ? 'ОБНАРУЖЕНА УГРОЗА' : 'ФАЙЛ ЧИСТ';
    final descText = _hasThreat
        ? '3 из 89 антивирусных движков обнаружили вредоносный код (Trojan.Win32)'
        : '89 антивирусных движков не обнаружили угроз';

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
                  color: cardBg,
                  borderRadius: BorderRadius.circular(16 * s),
                  border: Border.all(color: cardBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    SizedBox(height: 24 * s),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: widget.fileName,
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: Colors.white,
                              fontSize: 20 * s,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: ' 2,4 MB - PDF',
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 18 * s,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
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
                    SizedBox(height: 32 * s),
                    _buildInfoRow('Тип файла', 'PDF документ', s),
                    SizedBox(height: 16 * s),
                    _buildInfoRow('Размер', '2.4 MB', s),
                    SizedBox(height: 16 * s),
                    _buildInfoRow('Проверено', '1 мин назад', s),
                    SizedBox(height: 16 * s),
                    _buildInfoRow('Проверка', 'ClamAV, MalwareBazaar', s),
                    if (_hasThreat) ...[
                      SizedBox(height: 16 * s),
                      _buildInfoRow('Статус', '3 угрозы найдено', s, isWarning: true),
                    ],
                    
                    SizedBox(height: 40 * s),
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 64 * s,
                            height: 64 * s,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  badgeColor,
                                  badgeColor.withOpacity(0.1),
                                ],
                              ),
                            ),
                            child: Center(
                              child: _hasThreat
                                  ? Icon(Icons.error_outline_rounded, color: Colors.white, size: 36 * s)
                                  : SvgPicture.asset(
                                      'assets/images/shield_checkmark.svg',
                                      width: 36 * s,
                                      height: 36 * s,
                                    ),
                            ),
                          ),
                          SizedBox(height: 16 * s),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16 * s, vertical: 8 * s),
                            decoration: BoxDecoration(
                              color: badgeColor,
                              borderRadius: BorderRadius.circular(20 * s),
                            ),
                            child: Text(
                              statusText,
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: Colors.white,
                                fontSize: 12 * s,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: 24 * s),
                          Text(
                            descText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 13 * s,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24 * s),

              // Design System Action Button: Проверить другой файл
              AppButton(
                text: 'Проверить другой файл',
                onTap: () {
                  context.push('/file-check');
                },
              ),

              SizedBox(height: 16 * s),
              Center(
                child: Text(
                  'Проверено через VirusTotal',
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 13 * s,
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
            color: isWarning ? const Color(0xFFEB5757).withOpacity(0.2) : Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16 * s),
            border: isWarning ? Border.all(color: const Color(0xFFEB5757).withOpacity(0.4)) : null,
          ),
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'GoogleSans',
              color: isWarning ? const Color(0xFFEB5757) : Colors.white.withOpacity(0.7),
              fontSize: 12 * s,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
