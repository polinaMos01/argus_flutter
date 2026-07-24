import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/app_button.dart';
import '../../widgets/check_loading_view.dart';

enum CheckState { idle, loading, completed }

class PhoneCheckScreen extends StatefulWidget {
  const PhoneCheckScreen({Key? key}) : super(key: key);

  @override
  State<PhoneCheckScreen> createState() => _PhoneCheckScreenState();
}

class _PhoneCheckScreenState extends State<PhoneCheckScreen> {
  CheckState _checkState = CheckState.idle;
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 96 * s),
            if (_checkState == CheckState.loading)
              Expanded(
                child: CheckLoadingView(
                  label: 'Проверка телефона...',
                  onComplete: () {
                    if (mounted) {
                      context.push('/phone-check-result', extra: _phoneController.text);
                      setState(() {
                        _checkState = CheckState.idle;
                      });
                    }
                  },
                ),
              )
            else
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16 * s),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32 * s),
                    Text(
                      'Введите номер телефона',
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: Colors.white,
                        fontSize: 16 * s,
                      ),
                    ),
                    SizedBox(height: 16 * s),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0x0CD9D9D9),
                        borderRadius: BorderRadius.circular(12 * s),
                        border: Border.all(color: Colors.white.withOpacity(0.08)),
                      ),
                      child: TextField(
                        controller: _phoneController..text = '+7 (999) 123-45-67',
                        readOnly: true,
                        enabled: false,
                        style: TextStyle(color: Colors.white.withOpacity(0.40), fontSize: 16 * s, fontFamily: 'GoogleSans'),
                        decoration: InputDecoration(
                          hintText: '+7 (900) 000-00-00',
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16 * s),
                        ),
                      ),
                    ),
                    SizedBox(height: 24 * s),
                    AppButton(
                      text: 'Проверить',
                      onTap: () {
                        setState(() {
                          _checkState = CheckState.loading;
                        });
                      },
                    ),
                    SizedBox(height: 48 * s),
                    Text(
                      'Как это работает',
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: Colors.white,
                        fontSize: 16 * s,
                      ),
                    ),
                    SizedBox(height: 16 * s),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20 * s),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0B1416),
                        borderRadius: BorderRadius.circular(12 * s),
                        border: Border.all(color: const Color(0xFF1E2C30)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 20 * s,
                            height: 20 * s,
                            decoration: BoxDecoration(
                              color: const Color(0xFF132A1C),
                              borderRadius: BorderRadius.circular(4 * s),
                            ),
                            child: Icon(Icons.check, color: const Color(0xFF6EAF91), size: 14 * s),
                          ),
                          SizedBox(width: 16 * s),
                          Expanded(
                            child: Text(
                              'Мы проверяем номер по базе из 50+ миллиардов записей из утечек данных по всему миру. Поиск занимает несколько секунд.',
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14 * s,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 60 * s),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}
