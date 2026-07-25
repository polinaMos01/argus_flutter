import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/check_loading_view.dart';

enum CheckState { idle, loading, completed }

class LinkCheckScreen extends StatefulWidget {
  const LinkCheckScreen({Key? key}) : super(key: key);

  @override
  State<LinkCheckScreen> createState() => _LinkCheckScreenState();
}

class _LinkCheckScreenState extends State<LinkCheckScreen> {
  CheckState _checkState = CheckState.idle;
  final TextEditingController _linkController = TextEditingController();

  @override
  void dispose() {
    _linkController.dispose();
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
            SizedBox(height: 96 * s),
            if (_checkState == CheckState.loading)
              Expanded(
                child: CheckLoadingView(
                  label: 'Проверка ссылки...',
                  onComplete: () {
                    if (mounted) {
                      context.push('/link-check-result', extra: _linkController.text);
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
                      'Введите ссылку',
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: Colors.white,
                        fontSize: 16 * s,
                      ),
                    ),
                    SizedBox(height: 16 * s),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0B1416),
                        borderRadius: BorderRadius.circular(12 * s),
                        border: Border.all(color: const Color(0xFF1E2C30)),
                      ),
                      child: TextField(
                        controller: _linkController,
                        style: TextStyle(color: Colors.white, fontSize: 16 * s, fontFamily: 'GoogleSans'),
                        decoration: InputDecoration(
                          hintText: 'https://example.com',
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16 * s),
                        ),
                      ),
                    ),
                    SizedBox(height: 24 * s),
                    GestureDetector(
                      onTap: () {
                        if (_linkController.text.trim().isEmpty) return;
                        setState(() {
                          _checkState = CheckState.loading;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 18 * s),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6EAF91),
                          borderRadius: BorderRadius.circular(30 * s),
                          border: Border.all(color: const Color(0xFF2E5B3F).withOpacity(0.5), width: 1.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Проверить',
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: Colors.white,
                                fontSize: 16 * s,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 8 * s),
                            Icon(Icons.chevron_right, color: Colors.white, size: 20 * s),
                          ],
                        ),
                      ),
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
                              'Мы анализируем ссылку по базам фишинговых, вредоносных и спам-сайтов. Проверка занимает несколько секунд.',
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
