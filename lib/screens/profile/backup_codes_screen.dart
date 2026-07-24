import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/main_layout.dart';
import '../../theme/app_colors.dart';

class BackupCodesScreen extends StatefulWidget {
  const BackupCodesScreen({super.key});

  @override
  State<BackupCodesScreen> createState() => _BackupCodesScreenState();
}

class _BackupCodesScreenState extends State<BackupCodesScreen> {
  late List<String> _codes;

  @override
  void initState() {
    super.initState();
    _generateCodes();
  }

  void _generateCodes() {
    final random = math.Random();
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    
    String generatePart() {
      return List.generate(4, (index) => chars[random.nextInt(chars.length)]).join();
    }

    setState(() {
      _codes = List.generate(8, (index) => '${generatePart()}-${generatePart()}');
    });
  }

  Widget _buildGlassCard(double Function(double) s, {double? height, EdgeInsetsGeometry? padding, required Widget child}) {
    return Container(
      width: double.infinity,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9).withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.1)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    double s(double value) => value * (canvasWidth / 393);

    return Scaffold(
      backgroundColor: const Color(0xFF060E11),
      body: Stack(
          children: [
            // Top Glow
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: s(300),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF6EAF91).withOpacity(0.12),
                      Colors.black.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              top: s(100),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: s(24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGlassCard(
                      s,
                      padding: EdgeInsets.all(s(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Сохраните эти коды в надежном месте. Если вы потеряете доступ к телефону, вы сможете использовать их для входа. Каждый код можно использовать только один раз.',
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: AppColors.textSecondary,
                              fontSize: s(14),
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: s(20)),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: s(12),
                              mainAxisSpacing: s(12),
                              childAspectRatio: 2.8,
                            ),
                            itemCount: _codes.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  _codes[index],
                                  style: TextStyle(
                                    fontFamily: 'monospace',
                                    color: Colors.white,
                                    fontSize: s(15),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: s(20)),

                    // Copy All Action Card
                    _buildGlassCard(
                      s,
                      padding: EdgeInsets.all(s(16)),
                      child: Column(
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: _codes.join('\n')));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Все коды скопированы в буфер обмена.',
                                    style: TextStyle(fontFamily: 'GoogleSans'),
                                  ),
                                  backgroundColor: AppColors.success,
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.white.withOpacity(0.1)),
                              minimumSize: Size(double.infinity, s(50)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.copy, color: Colors.white, size: s(18)),
                                SizedBox(width: s(8)),
                                const Text(
                                  'Скопировать все',
                                  style: TextStyle(
                                    fontFamily: 'GoogleSans',
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: s(12)),
                          OutlinedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Файл argus_backup_codes.txt сохранён.',
                                    style: TextStyle(fontFamily: 'GoogleSans'),
                                  ),
                                  backgroundColor: AppColors.success,
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.white.withOpacity(0.1)),
                              minimumSize: Size(double.infinity, s(50)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.download, color: Colors.white, size: s(18)),
                                SizedBox(width: s(8)),
                                const Text(
                                  'Сохранить как TXT',
                                  style: TextStyle(
                                    fontFamily: 'GoogleSans',
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: s(12)),
                          TextButton(
                            onPressed: _generateCodes,
                            style: TextButton.styleFrom(
                              minimumSize: Size(double.infinity, s(50)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.refresh, color: AppColors.error, size: s(18)),
                                SizedBox(width: s(8)),
                                Text(
                                  'Сгенерировать новые',
                                  style: TextStyle(
                                    fontFamily: 'GoogleSans',
                                    color: AppColors.error,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: s(32)),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}
