import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/app_toast.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  int? _expandedFaqIndex;

  final List<Map<String, String>> _faqItems = [
    {
      'question': 'Как отменить подписку?',
      'answer':
          'Перейдите в Профиль ➔ Подписка и тарифы ➔ нажмите "Отменить подписку". Ваша текущая подписка сохранится до конца оплаченного периода.',
    },
    {
      'question': 'Что делать при обнаружении утечки пароля?',
      'answer':
          'Срочно смените пароль на скомпрометированном сервисе. Включите двухфакторную аутентификацию (2FA) и воспользуйтесь Нашим Центром Паролей.',
    },
    {
      'question': 'Как изменить привязанный e-mail или номер?',
      'answer':
          'В разделе Профиль ➔ Личные данные вы можете изменить вашу почту и телефон. Для подтверждения потребуется SMS или e-mail код.',
    },
    {
      'question': 'Безопасны ли мои данные в Argus?',
      'answer':
          'Да! Argus использует сквозное шифрование AES-256. Мы не храним ваши пароли в открытом виде и проверяем только хэши в защищенной базе.',
    },
  ];

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
              SizedBox(height: 96 * s), // MainLayout header offset

              // Top Hero Card: Нужна помощь? (Figma Node 165-1796)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20 * s),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF0F3A2A),
                      Color(0xFF072118),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20 * s),
                  border: Border.all(color: const Color(0xFF6EAF91).withOpacity(0.4), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6EAF91).withOpacity(0.15),
                      blurRadius: 16 * s,
                      offset: Offset(0, 4 * s),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 52 * s,
                      height: 52 * s,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6EAF91).withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(Icons.headset_mic_outlined, color: const Color(0xFF6EAF91), size: 26 * s),
                      ),
                    ),
                    SizedBox(width: 16 * s),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Служба поддержки Argus',
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: Colors.white,
                              fontSize: 16 * s,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 4 * s),
                          Text(
                            'Среднее время ответа — 5 минут. Работаем 24/7.',
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: const Color(0xFFACACAC),
                              fontSize: 12 * s,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24 * s),

              Text(
                'Каналы связи',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 14 * s),

              // Channel 1: Telegram Bot
              _buildContactTile(
                s,
                icon: Icons.send_rounded,
                iconColor: const Color(0xFF2AABEE),
                title: 'Написать в Telegram',
                subtitle: '@argus_support_bot',
                onTap: () => showAppToast(context, 'Открытие Telegram бота...'),
              ),
              SizedBox(height: 10 * s),

              // Channel 2: Online Chat
              _buildContactTile(
                s,
                icon: Icons.chat_bubble_outline_rounded,
                iconColor: const Color(0xFF6EAF91),
                title: 'Онлайн-чат в приложении',
                subtitle: 'Быстрый диалог со специалистом',
                onTap: () => showAppToast(context, 'Соединение с оператором поддержки...'),
              ),
              SizedBox(height: 10 * s),

              // Channel 3: Email
              _buildContactTile(
                s,
                icon: Icons.email_outlined,
                iconColor: const Color(0xFFFFB74D),
                title: 'Отправить сообщение на Email',
                subtitle: 'support@argus-security.ru',
                onTap: () => showAppToast(context, 'Email адрес скопирован в буфер'),
              ),

              SizedBox(height: 28 * s),

              Text(
                'Часто задаваемые вопросы',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 14 * s),

              // FAQ List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _faqItems.length,
                separatorBuilder: (ctx, idx) => SizedBox(height: 10 * s),
                itemBuilder: (ctx, idx) {
                  final isExpanded = _expandedFaqIndex == idx;
                  final item = _faqItems[idx];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _expandedFaqIndex = isExpanded ? null : idx;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: EdgeInsets.all(16 * s),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9).withOpacity(0.03),
                        borderRadius: BorderRadius.circular(16 * s),
                        border: Border.all(
                          color: isExpanded
                              ? const Color(0xFF6EAF91).withOpacity(0.5)
                              : const Color(0xFFD9D9D9).withOpacity(0.15),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item['question']!,
                                  style: TextStyle(
                                    fontFamily: 'GoogleSans',
                                    color: Colors.white,
                                    fontSize: 15 * s,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Icon(
                                isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                color: isExpanded ? const Color(0xFF6EAF91) : Colors.white54,
                                size: 20 * s,
                              ),
                            ],
                          ),
                          if (isExpanded) ...[
                            SizedBox(height: 12 * s),
                            Divider(color: Colors.white.withOpacity(0.08), height: 1),
                            SizedBox(height: 12 * s),
                            Text(
                              item['answer']!,
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: const Color(0xFFACACAC),
                                fontSize: 13 * s,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
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

  Widget _buildContactTile(
    double s, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16 * s),
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9).withOpacity(0.03),
          borderRadius: BorderRadius.circular(16 * s),
          border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.15)),
        ),
        child: Row(
          children: [
            Container(
              width: 42 * s,
              height: 42 * s,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12 * s),
                border: Border.all(color: iconColor.withOpacity(0.3)),
              ),
              child: Center(
                child: Icon(icon, color: iconColor, size: 20 * s),
              ),
            ),
            SizedBox(width: 14 * s),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: Colors.white,
                      fontSize: 15 * s,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 3 * s),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: const Color(0xFFACACAC),
                      fontSize: 12 * s,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.white38, size: 18 * s),
          ],
        ),
      ),
    );
  }
}
