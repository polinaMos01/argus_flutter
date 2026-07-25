import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/app_button.dart';
import '../../widgets/check_loading_view.dart';

enum CheckState { idle, loading, completed }

class EmailCheckScreen extends StatefulWidget {
  const EmailCheckScreen({Key? key}) : super(key: key);

  @override
  State<EmailCheckScreen> createState() => _EmailCheckScreenState();
}

class _EmailCheckScreenState extends State<EmailCheckScreen> {
  CheckState _checkState = CheckState.idle;
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;
    
    return Scaffold(
      backgroundColor: const Color(0xFF060E11),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 126 * s),
            if (_checkState == CheckState.loading)
              Expanded(
                child: CheckLoadingView(
                  label: 'Проверка email...',
                  onComplete: () {
                    if (mounted) {
                      context.push('/email-check-result', extra: _emailController.text);
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
                      'Введите E-mail',
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
                        controller: _emailController..text = 'ghost_user@protonmail.com',
                        readOnly: true,
                        enabled: false,
                        style: TextStyle(color: Colors.white.withOpacity(0.40), fontSize: 16 * s, fontFamily: 'GoogleSans'),
                        decoration: InputDecoration(
                          hintText: 'example@mail.com',
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
                      'Что мы проверяем',
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: Colors.white,
                        fontSize: 16 * s,
                        fontWeight: FontWeight.w500,
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
                      child: Column(
                        children: [
                          _buildCheckItem('Базы данных утечек', s),
                          SizedBox(height: 16 * s),
                          _buildCheckItem('Даркнет-форумы', s),
                          SizedBox(height: 16 * s),
                          _buildCheckItem('Скомпрометированные сервисы', s),
                          SizedBox(height: 16 * s),
                          _buildCheckItem('Посты и публичные сливы', s),
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

  Widget _buildCheckItem(String text, double s) {
    return Row(
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
        Text(
          text,
          style: TextStyle(
            fontFamily: 'GoogleSans',
            color: Colors.white.withOpacity(0.7),
            fontSize: 15 * s,
          ),
        ),
      ],
    );
  }
}
