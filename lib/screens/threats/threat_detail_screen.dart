import 'dart:ui';
import 'package:flutter/material.dart';
import '../../models/threat_item.dart';

class ThreatDetailScreen extends StatelessWidget {
  final ThreatItem? threat;
  final String? titleParam;

  const ThreatDetailScreen({
    super.key,
    this.threat,
    this.titleParam,
  });

  Map<String, dynamic> _getLeakDataForTitle(String title) {
    final lower = title.toLowerCase();

    if (lower.contains('darkforum') || lower.contains('dark')) {
      return {
        'title': 'DarkForums',
        'subtitle': '15 мин назад ваши данные найдены в этой базе',
        'data': [
          {'label': 'Email', 'value': 'backup@gmail.com', 'isDanger': true},
          {'label': 'Username', 'value': '@dark_member', 'isDanger': true},
          {'label': 'IP-адрес', 'value': '192.168.1.***', 'isDanger': true},
          {'label': 'Имя', 'value': 'Алексей', 'isDanger': false},
        ],
        'recommendations': [
          {'icon': Icons.lock_outline, 'text': 'Смените пароль и логин на всех форумах'},
          {'icon': Icons.security_outlined, 'text': 'Проверьте связанный e-mail на повторные пароли'},
          {'icon': Icons.remove_red_eye_outlined, 'text': 'Используйте генератор паролей для защиты'},
        ],
      };
    } else if (lower.contains('canva')) {
      return {
        'title': 'Canva',
        'subtitle': 'Утечка графического сервиса Canva',
        'data': [
          {'label': 'Email', 'value': 'canva_design@gmail.com', 'isDanger': true},
          {'label': 'Имя', 'value': 'Анастасия', 'isDanger': true},
          {'label': 'Страна', 'value': 'Россия', 'isDanger': false},
          {'label': 'Пароль', 'value': 'Зашифрован (SHA-256)', 'isDanger': false},
        ],
        'recommendations': [
          {'icon': Icons.lock_outline, 'text': 'Обновите пароль от аккаунта Canva'},
          {'icon': Icons.credit_card_outlined, 'text': 'Проверьте сохраненные способы оплаты'},
          {'icon': Icons.link_off_outlined, 'text': 'Отвяжите сторонние сервисы от аккаунта'},
        ],
      };
    } else if (lower.contains('adobe')) {
      return {
        'title': 'Adobe',
        'subtitle': 'Утечка учетных записей Adobe Systems',
        'data': [
          {'label': 'Email', 'value': 'designer@adobe.ru', 'isDanger': true},
          {'label': 'Пароль', 'value': 'Подсказка скомпрометирована', 'isDanger': true},
          {'label': 'Подписка', 'value': 'Creative Cloud Pro', 'isDanger': false},
        ],
        'recommendations': [
          {'icon': Icons.lock_outline, 'text': 'Смените контрольный вопрос и пароль Adobe'},
          {'icon': Icons.security_outlined, 'text': 'Активируйте двухфакторный вход Adobe ID'},
        ],
      };
    } else if (lower.contains('dropbox')) {
      return {
        'title': 'Dropbox',
        'subtitle': 'Утечка облачного хранилища Dropbox',
        'data': [
          {'label': 'Email', 'value': 'cloud_storage@gmail.com', 'isDanger': true},
          {'label': 'Пароль', 'value': 'Bcrypt хэш скомпрометирован', 'isDanger': true},
          {'label': 'Сессии', 'value': '3 активных входа', 'isDanger': false},
        ],
        'recommendations': [
          {'icon': Icons.lock_outline, 'text': 'Смените главный пароль от Dropbox'},
          {'icon': Icons.devices_outlined, 'text': 'Завершите все активные сессии устройств'},
        ],
      };
    }

    // Default Collection #1234
    return {
      'title': title.isNotEmpty ? title : 'Collection #1234',
      'subtitle': 'Ваши данные найдены в этой базе',
      'data': [
        {'label': 'Телефон', 'value': '+7 999 *** **67', 'isDanger': true},
        {'label': 'Email', 'value': 'ghost_***@proton.com', 'isDanger': true},
        {'label': 'Пароль', 'value': 'Хэш найден', 'isDanger': true},
        {'label': 'Адрес', 'value': 'Частично', 'isDanger': false},
      ],
      'recommendations': [
        {'icon': Icons.lock_outline, 'text': 'Немедленно смените пароль во всех сервисах'},
        {'icon': Icons.security_outlined, 'text': 'Включите двухфакторную аутентификацию'},
        {'icon': Icons.remove_red_eye_outlined, 'text': 'Проверьте все аккаунты на подозрительную активность'},
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;

    final String title = threat?.serviceName.isNotEmpty == true
        ? threat!.serviceName
        : (titleParam ?? 'Collection #1234');

    final leakData = _getLeakDataForTitle(title);

    return Scaffold(
      backgroundColor: const Color(0xFF060E11),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24 * s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 96 * s), // Spacing below MainLayout header

              // 1. Top Card: Main Leak Summary (Red Tinted Glass, 70px)
              ClipRRect(
                borderRadius: BorderRadius.circular(12 * s),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.85, sigmaY: 3.85),
                  child: Container(
                    width: double.infinity,
                    height: 70 * s,
                    padding: EdgeInsets.symmetric(horizontal: 16 * s),
                    decoration: BoxDecoration(
                      color: const Color(0x56B20F0F),
                      borderRadius: BorderRadius.circular(12 * s),
                      border: Border.all(color: const Color(0x51D9D9D9)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          leakData['title'] as String,
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white,
                            fontSize: 14 * s,
                            fontWeight: FontWeight.w400,
                            height: 1.30,
                          ),
                        ),
                        SizedBox(height: 2 * s),
                        Text(
                          leakData['subtitle'] as String,
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white.withOpacity(0.40),
                            fontSize: 12 * s,
                            fontWeight: FontWeight.w400,
                            height: 1.30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 26 * s),

              // 2. Subtitle: Скомпрометированные данные
              Text(
                'Скомпрометированные данные',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w400,
                  height: 1.30,
                ),
              ),
              SizedBox(height: 12 * s),

              // Card 2: Compromised Data List
              ClipRRect(
                borderRadius: BorderRadius.circular(12 * s),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.85, sigmaY: 3.85),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16 * s, vertical: 14 * s),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12 * s),
                      border: Border.all(color: const Color(0x51D9D9D9)),
                    ),
                    child: Column(
                      children: (leakData['data'] as List<Map<String, dynamic>>).asMap().entries.map((entry) {
                        final idx = entry.key;
                        final item = entry.value;
                        final isLast = idx == (leakData['data'] as List).length - 1;
                        return Column(
                          children: [
                            _buildDataRow(
                              s,
                              label: item['label'] as String,
                              value: item['value'] as String,
                              valueColor: item['isDanger'] == true ? const Color(0xFFB20F0F) : Colors.white,
                              isBold: item['isDanger'] == true,
                            ),
                            if (!isLast) _buildDivider(),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 28 * s),

              // 3. Subtitle: Рекомендации
              Text(
                'Рекомендации',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w400,
                  height: 1.30,
                ),
              ),
              SizedBox(height: 12 * s),

              // Card 3: Recommendations
              ClipRRect(
                borderRadius: BorderRadius.circular(12 * s),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.85, sigmaY: 3.85),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16 * s, vertical: 16 * s),
                    decoration: BoxDecoration(
                      color: const Color(0x0CD9D9D9),
                      borderRadius: BorderRadius.circular(12 * s),
                      border: Border.all(color: const Color(0x51D9D9D9)),
                    ),
                    child: Column(
                      children: (leakData['recommendations'] as List<Map<String, dynamic>>).asMap().entries.map((entry) {
                        final idx = entry.key;
                        final item = entry.value;
                        final isLast = idx == (leakData['recommendations'] as List).length - 1;
                        return Column(
                          children: [
                            _buildRecommendationRow(
                              s,
                              icon: item['icon'] as IconData,
                              text: item['text'] as String,
                            ),
                            if (!isLast) _buildDivider(),
                          ],
                        );
                      }).toList(),
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

  Widget _buildDataRow(
    double s, {
    required String label,
    required String value,
    required Color valueColor,
    required bool isBold,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8 * s),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'GoogleSans',
              color: Colors.white,
              fontSize: 14 * s,
              fontWeight: FontWeight.w400,
              height: 1.30,
            ),
          ),
          Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: 'GoogleSans',
              color: valueColor,
              fontSize: 14 * s,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
              height: 1.30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationRow(
    double s, {
    required IconData icon,
    required String text,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8 * s),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20 * s,
          ),
          SizedBox(width: 14 * s),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'GoogleSans',
                color: Colors.white,
                fontSize: 12 * s,
                fontWeight: FontWeight.w400,
                height: 1.30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Divider(
        height: 1,
        color: Colors.white.withOpacity(0.12),
      ),
    );
  }
}
