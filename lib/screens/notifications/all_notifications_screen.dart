import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/app_toast.dart';

class AllNotificationsScreen extends StatefulWidget {
  const AllNotificationsScreen({super.key});

  @override
  State<AllNotificationsScreen> createState() => _AllNotificationsScreenState();
}

class _AllNotificationsScreenState extends State<AllNotificationsScreen> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['Все', 'Непрочитанные', 'Угрозы', 'Системные'];

  final List<Map<String, dynamic>> _allNotifications = [
    {
      'id': '1',
      'title': 'Новая утечка данных',
      'time': '10 мин назад',
      'desc': 'Ваш email ghost_user@protonmail.com обнаружен в недавней базе данных "ComboList 2025".',
      'category': 'Угрозы',
      'badgeText': 'Высокий риск',
      'badgeColor': Color(0xFFFF4B4B),
      'icon': Icons.warning_amber_rounded,
      'isRead': false,
    },
    {
      'id': '2',
      'title': 'Подозрительный вход',
      'time': '2 часа назад',
      'desc': 'Выполнен вход в ваш аккаунт с нового устройства Android SM-G991B (Москва, Россия).',
      'category': 'Угрозы',
      'badgeText': 'Внимание',
      'badgeColor': Color(0xFFE65100),
      'icon': Icons.devices_other,
      'isRead': false,
    },
    {
      'id': '3',
      'title': 'Security Score обновлён',
      'time': 'Вчера',
      'desc': 'Ваш индекс безопасности повысился до 85 из 100 благодаря включенной защите.',
      'category': 'Системные',
      'badgeText': 'Успешно',
      'badgeColor': Color(0xFF6EAF91),
      'icon': Icons.shield_outlined,
      'isRead': true,
    },
    {
      'id': '4',
      'title': 'Сканирование завершено',
      'time': '2 дня назад',
      'desc': 'Проверено 14 параметров безопасности. Все критические сервисы защищены.',
      'category': 'Системные',
      'badgeText': 'Информация',
      'badgeColor': Color(0xFF4A90E2),
      'icon': Icons.check_circle_outline,
      'isRead': true,
    },
    {
      'id': '5',
      'title': 'Рекомендация по защите 2FA',
      'time': '3 дня назад',
      'desc': 'Подключите резервные коды 2FA в профиле, чтобы не потерять доступ к аккаунту.',
      'category': 'Системные',
      'badgeText': 'Рекомендация',
      'badgeColor': Color(0xFF9B51E0),
      'icon': Icons.lock_outline,
      'isRead': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;

    final filteredList = _allNotifications.where((item) {
      if (_selectedFilterIndex == 1) return item['isRead'] == false;
      if (_selectedFilterIndex == 2) return item['category'] == 'Угрозы';
      if (_selectedFilterIndex == 3) return item['category'] == 'Системные';
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24 * s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 96 * s), // MainLayout header padding

              // Top Action Row: Header Settings Icon Link
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Все события',
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: Colors.white,
                      fontSize: 18 * s,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        for (var item in _allNotifications) {
                          item['isRead'] = true;
                        }
                      });
                      showAppToast(context, 'Все уведомления прочитаны');
                    },
                    child: Text(
                      'Прочитать все',
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: const Color(0xFF6EAF91),
                        fontSize: 13 * s,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16 * s),

              // Filter Chips Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(_filters.length, (idx) {
                    final isSelected = _selectedFilterIndex == idx;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFilterIndex = idx;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10 * s),
                        padding: EdgeInsets.symmetric(horizontal: 16 * s, vertical: 8 * s),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF6EAF91)
                              : const Color(0xFFD9D9D9).withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20 * s),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF6EAF91)
                                : const Color(0xFFD9D9D9).withOpacity(0.15),
                          ),
                        ),
                        child: Text(
                          _filters[idx],
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: isSelected ? const Color(0xFF060E11) : Colors.white,
                            fontSize: 13 * s,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 24 * s),

              // Notifications List Cards
              if (filteredList.isEmpty)
                Container(
                  padding: EdgeInsets.all(32 * s),
                  alignment: Alignment.center,
                  child: Text(
                    'Нет уведомлений в этой категории',
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: const Color(0xFFACACAC),
                      fontSize: 14 * s,
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredList.length,
                  separatorBuilder: (ctx, idx) => SizedBox(height: 12 * s),
                  itemBuilder: (ctx, idx) {
                    final item = filteredList[idx];
                    final Color badgeColor = item['badgeColor'] as Color;
                    final bool isUnread = item['isRead'] == false;

                    return Container(
                      padding: EdgeInsets.all(16 * s),
                      decoration: BoxDecoration(
                        color: isUnread
                            ? const Color(0xFF6EAF91).withOpacity(0.04)
                            : const Color(0xFFD9D9D9).withOpacity(0.03),
                        borderRadius: BorderRadius.circular(16 * s),
                        border: Border.all(
                          color: isUnread
                              ? const Color(0xFF6EAF91).withOpacity(0.3)
                              : const Color(0xFFD9D9D9).withOpacity(0.12),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8 * s),
                                decoration: BoxDecoration(
                                  color: badgeColor.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  item['icon'] as IconData,
                                  color: badgeColor,
                                  size: 18 * s,
                                ),
                              ),
                              SizedBox(width: 12 * s),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item['title'] as String,
                                            style: TextStyle(
                                              fontFamily: 'GoogleSans',
                                              color: Colors.white,
                                              fontSize: 15 * s,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        if (isUnread)
                                          Container(
                                            width: 8 * s,
                                            height: 8 * s,
                                            margin: EdgeInsets.only(right: 6 * s),
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF6EAF91),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        Text(
                                          item['time'] as String,
                                          style: TextStyle(
                                            fontFamily: 'GoogleSans',
                                            color: const Color(0xFFACACAC),
                                            fontSize: 11 * s,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4 * s),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8 * s, vertical: 2 * s),
                                      decoration: BoxDecoration(
                                        color: badgeColor.withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(6 * s),
                                      ),
                                      child: Text(
                                        item['badgeText'] as String,
                                        style: TextStyle(
                                          fontFamily: 'GoogleSans',
                                          color: badgeColor,
                                          fontSize: 10 * s,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12 * s),
                          Text(
                            item['desc'] as String,
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: Colors.white70,
                              fontSize: 13 * s,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

              SizedBox(height: 32 * s),

              // Button to Go to Notification Settings
              GestureDetector(
                onTap: () => context.push('/notifications/settings'),
                child: Container(
                  height: 52 * s,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9).withOpacity(0.04),
                    borderRadius: BorderRadius.circular(26 * s),
                    border: Border.all(color: const Color(0xFF6EAF91).withOpacity(0.4)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/Group-3.svg',
                        width: 20 * s,
                        height: 20 * s,
                        colorFilter: const ColorFilter.mode(Color(0xFF6EAF91), BlendMode.srcIn),
                      ),
                      SizedBox(width: 10 * s),
                      Text(
                        'Настройка уведомлений',
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          color: Colors.white,
                          fontSize: 15 * s,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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
}
