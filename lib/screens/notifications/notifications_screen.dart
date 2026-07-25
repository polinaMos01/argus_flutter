import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/app_toast.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _newLeaks = true;
  bool _riskIncrease = true;
  bool _scoreChange = true;
  bool _monitorEvents = true;

  bool _pushDelivery = true;
  bool _emailDelivery = true;

  bool _sound = true;
  bool _vibration = true;

  String _quietMode = '23:00 - 08:00';
  String _frequency = 'Еженедельно';

  final List<String> _quietModeOptions = [
    '23:00 - 08:00',
    '22:00 - 07:00',
    '00:00 - 09:00',
    'Выключен',
  ];

  final List<String> _frequencyOptions = [
    'Ежедневно',
    'Еженедельно',
    'Ежемесячно',
    'Никогда',
  ];

  void _showSelectionModal(
    BuildContext context, {
    required String title,
    required List<String> options,
    required String selectedValue,
    required ValueChanged<String> onSelected,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF060E11),
      isScrollControlled: true,
      builder: (ctx) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.all(24 * s),
          decoration: BoxDecoration(
            color: const Color(0xFF060E11).withOpacity(0.95),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24 * s),
              topRight: Radius.circular(24 * s),
            ),
            border: Border.all(color: const Color(0xFF6EAF91).withOpacity(0.4), width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40 * s,
                  height: 4 * s,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2 * s),
                  ),
                ),
              ),
              SizedBox(height: 20 * s),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16 * s),
              ...options.map((opt) {
                final isSelected = opt == selectedValue;
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(ctx);
                    onSelected(opt);
                    showAppToast(context, '$title: $opt');
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10 * s),
                    padding: EdgeInsets.symmetric(horizontal: 16 * s, vertical: 14 * s),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF6EAF91).withOpacity(0.15)
                          : const Color(0xFFD9D9D9).withOpacity(0.03),
                      borderRadius: BorderRadius.circular(12 * s),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF6EAF91)
                            : const Color(0xFFD9D9D9).withOpacity(0.15),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          opt,
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: isSelected ? const Color(0xFF6EAF91) : Colors.white,
                            fontSize: 15 * s,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                        if (isSelected)
                          Icon(Icons.check_circle, color: const Color(0xFF6EAF91), size: 18 * s),
                      ],
                    ),
                  ),
                );
              }),
              SizedBox(height: 16 * s),
            ],
          ),
        ),
      ),
    );
  }

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

              // Section 1: Что отправлять
              Text(
                'Что отправлять',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 16 * s),
              _buildSectionCard(
                s,
                children: [
                  _buildSwitchTile(
                    s,
                    svgPath: 'assets/images/bell.svg',
                    title: 'О новых утечках',
                    value: _newLeaks,
                    onChanged: (val) => setState(() => _newLeaks = val),
                  ),
                  _buildSwitchTile(
                    s,
                    svgPath: 'assets/images/alert-triangle.svg',
                    title: 'О повышении риска',
                    value: _riskIncrease,
                    onChanged: (val) => setState(() => _riskIncrease = val),
                  ),
                  _buildSwitchTile(
                    s,
                    svgPath: 'assets/images/bar-chart-2.svg',
                    title: 'Об изменении Security Score',
                    value: _scoreChange,
                    onChanged: (val) => setState(() => _scoreChange = val),
                  ),
                  _buildSwitchTile(
                    s,
                    svgPath: 'assets/images/file-text.svg',
                    title: 'О важных событиях мониторинга',
                    value: _monitorEvents,
                    onChanged: (val) => setState(() => _monitorEvents = val),
                    isLast: true,
                  ),
                ],
              ),
              SizedBox(height: 32 * s),

              // Section 2: Способы доставки
              Text(
                'Способы доставки',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 16 * s),
              _buildSectionCard(
                s,
                children: [
                  _buildSwitchTile(
                    s,
                    svgPath: 'assets/images/smartphone.svg',
                    title: 'Push-уведомления на телефон',
                    value: _pushDelivery,
                    onChanged: (val) => setState(() => _pushDelivery = val),
                  ),
                  _buildSwitchTile(
                    s,
                    svgPath: 'assets/images/mail.svg',
                    title: 'Дублировать на Email',
                    value: _emailDelivery,
                    onChanged: (val) => setState(() => _emailDelivery = val),
                    isLast: true,
                  ),
                ],
              ),
              SizedBox(height: 32 * s),

              // Section 3: Поведение и расписание
              Text(
                'Поведение и расписание',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 16 * s),
              _buildSectionCard(
                s,
                children: [
                  _buildSwitchTile(
                    s,
                    svgPath: 'assets/images/volume-2.svg',
                    title: 'Звук уведомлений',
                    value: _sound,
                    onChanged: (val) => setState(() => _sound = val),
                  ),
                  _buildSwitchTile(
                    s,
                    svgPath: 'assets/images/smartphone-1.svg',
                    title: 'Вибрация',
                    value: _vibration,
                    onChanged: (val) => setState(() => _vibration = val),
                  ),
                  _buildDropdownTile(
                    s,
                    svgPath: 'assets/images/moon.svg',
                    title: 'Режим тишины',
                    valueText: _quietMode,
                    onTap: () => _showSelectionModal(
                      context,
                      title: 'Режим тишины',
                      options: _quietModeOptions,
                      selectedValue: _quietMode,
                      onSelected: (val) => setState(() => _quietMode = val),
                    ),
                  ),
                  _buildDropdownTile(
                    s,
                    svgPath: 'assets/images/clock.svg',
                    title: 'Частота сводок',
                    valueText: _frequency,
                    isLast: true,
                    onTap: () => _showSelectionModal(
                      context,
                      title: 'Частота сводок',
                      options: _frequencyOptions,
                      selectedValue: _frequency,
                      onSelected: (val) => setState(() => _frequency = val),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 120 * s),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard(double s, {required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9).withOpacity(0.03),
        borderRadius: BorderRadius.circular(16 * s),
        border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.2)),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile(
    double s, {
    required String svgPath,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool isLast = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * s, vertical: 12 * s),
      decoration: isLast
          ? null
          : BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white.withOpacity(0.03)),
              ),
            ),
      child: Row(
        children: [
          Container(
            width: 40 * s,
            height: 40 * s,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10 * s),
              border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.2)),
            ),
            child: Center(
              child: SvgPicture.asset(
                svgPath,
                width: 20 * s,
                height: 20 * s,
                colorFilter: const ColorFilter.mode(Color(0xFF6EAF91), BlendMode.srcIn),
              ),
            ),
          ),
          SizedBox(width: 16 * s),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'GoogleSans',
                color: Colors.white,
                fontSize: 14 * s,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Switch(
            value: value,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF6EAF91),
            inactiveTrackColor: Colors.white24,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownTile(
    double s, {
    required String svgPath,
    required String title,
    required String valueText,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16 * s, vertical: 14 * s),
        decoration: isLast
            ? null
            : BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white.withOpacity(0.03)),
                ),
              ),
        child: Row(
          children: [
            Container(
              width: 40 * s,
              height: 40 * s,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10 * s),
                border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.2)),
              ),
              child: Center(
                child: SvgPicture.asset(
                  svgPath,
                  width: 20 * s,
                  height: 20 * s,
                  colorFilter: const ColorFilter.mode(Color(0xFF6EAF91), BlendMode.srcIn),
                ),
              ),
            ),
            SizedBox(width: 16 * s),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 14 * s,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Text(
              valueText,
              style: TextStyle(
                fontFamily: 'GoogleSans',
                color: const Color(0xFFACACAC),
                fontSize: 13 * s,
              ),
            ),
            SizedBox(width: 6 * s),
            Icon(Icons.keyboard_arrow_down, color: const Color(0xFFACACAC), size: 18 * s),
          ],
        ),
      ),
    );
  }
}
