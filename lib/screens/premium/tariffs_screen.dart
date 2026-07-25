import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/app_toast.dart';

class TariffsScreen extends StatefulWidget {
  const TariffsScreen({super.key});

  @override
  State<TariffsScreen> createState() => _TariffsScreenState();
}

class _TariffsScreenState extends State<TariffsScreen> {
  String _activePlan = 'PREMIUM_MONTHLY'; // Default active plan shown in screenshot

  // MODAL 1: Confirm Plan Change (Figma Node 159-1920)
  void _showConfirmChangePlanModal({
    required BuildContext context,
    required String targetPlanName,
    required String targetPlanKey,
    required String priceText,
    required String dateText,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;

    final currentPlanName = _activePlan == 'PREMIUM_MONTHLY'
        ? 'Premium Monthly'
        : (_activePlan == 'PREMIUM_YEARLY' ? 'Premium Yearly' : 'Free');

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
            border: Border.all(color: const Color(0xFF6EAF91).withOpacity(0.3), width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10 * s),

              // Thin Green Circle with (!) Exclamation Icon (Figma Node 159-1920)
              Container(
                width: 64 * s,
                height: 64 * s,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF6EAF91), width: 1.5),
                ),
                child: Center(
                  child: Text(
                    '!',
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: const Color(0xFF6EAF91),
                      fontSize: 32 * s,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20 * s),

              // Title: Сменить тариф?
              Text(
                'Сменить тариф?',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 22 * s,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 12 * s),

              // Description
              Text(
                'Вы переходите с $currentPlanName на $targetPlanName. Следующее списание: $priceText $dateText. Текущая подписка будет пересчитана.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: const Color(0xFFACACAC),
                  fontSize: 14 * s,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 28 * s),

              // Button 1: Подтвердить >
              GestureDetector(
                onTap: () {
                  Navigator.pop(ctx);
                  _showPlanChangedSuccessModal(
                    context: context,
                    targetPlanName: targetPlanName,
                    targetPlanKey: targetPlanKey,
                    dateText: dateText,
                  );
                },
                child: Container(
                  height: 52 * s,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF0F3A2A),
                        Color(0xFF072118),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(26 * s),
                    border: Border.all(color: const Color(0xFF6EAF91).withOpacity(0.6)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Подтвердить',
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          color: Colors.white,
                          fontSize: 16 * s,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8 * s),
                      Icon(Icons.chevron_right, color: Colors.white, size: 18 * s),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16 * s),

              // Button 2: Отмена
              GestureDetector(
                onTap: () => Navigator.pop(ctx),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8 * s),
                  child: Text(
                    'Отмена',
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: Colors.white,
                      fontSize: 15 * s,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16 * s),
            ],
          ),
        ),
      ),
    );
  }

  // MODAL 2: Plan Changed Success (Figma Node 159-1936)
  void _showPlanChangedSuccessModal({
    required BuildContext context,
    required String targetPlanName,
    required String targetPlanKey,
    required String dateText,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Scaffold(
        backgroundColor: const Color(0xFF060E11),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32 * s),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Thin Green Circle with Double Checkmark Icon (Figma Node 159-1936)
                Container(
                  width: 120 * s,
                  height: 120 * s,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E493C).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.done_all,
                      color: const Color(0xFF6EAF91),
                      size: 48 * s,
                    ),
                  ),
                ),
                SizedBox(height: 32 * s),

                // Title: Тариф изменён!
                Text(
                  'Тариф изменён!',
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    color: Colors.white,
                    fontSize: 24 * s,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12 * s),

                // Subtitle
                Text(
                  'Вы перешли на $targetPlanName.\nСледующий платёж: $dateText.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    color: const Color(0xFFACACAC),
                    fontSize: 15 * s,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 40 * s),

                // Button: Готово
                GestureDetector(
                  onTap: () {
                    Navigator.pop(ctx);
                    setState(() {
                      _activePlan = targetPlanKey;
                    });
                    showAppToast(context, 'Тариф успешно обновлен!');
                  },
                  child: Container(
                    height: 52 * s,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF0F3A2A),
                          Color(0xFF072118),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(26 * s),
                      border: Border.all(color: const Color(0xFF6EAF91).withOpacity(0.6)),
                    ),
                    child: Center(
                      child: Text(
                        'Готово',
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          color: Colors.white,
                          fontSize: 16 * s,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCancelSubscriptionModal(BuildContext context) {
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
            border: Border.all(color: const Color(0xFFFF4B4B).withOpacity(0.4), width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40 * s,
                height: 4 * s,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2 * s),
                ),
              ),
              SizedBox(height: 20 * s),

              Text(
                'Отменить подписку?',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 20 * s,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8 * s),
              Text(
                'Ваша подписка Premium будет действовать до 15.06.2025. После этой даты приложение перейдет на Базовый тариф.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: const Color(0xFFACACAC),
                  fontSize: 14 * s,
                  height: 1.35,
                ),
              ),
              SizedBox(height: 24 * s),

              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(ctx),
                      child: Container(
                        height: 48 * s,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9).withOpacity(0.08),
                          borderRadius: BorderRadius.circular(24 * s),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Center(
                          child: Text(
                            'Оставить',
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: Colors.white,
                              fontSize: 15 * s,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12 * s),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(ctx);
                        setState(() {
                          _activePlan = 'FREE';
                        });
                        showAppToast(context, 'Автопродление подписки отменено');
                      },
                      child: Container(
                        height: 48 * s,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF4B4B).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(24 * s),
                          border: Border.all(color: const Color(0xFFFF4B4B)),
                        ),
                        child: Center(
                          child: Text(
                            'Отменить',
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: const Color(0xFFFF4B4B),
                              fontSize: 15 * s,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24 * s),
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
              SizedBox(height: 96 * s), // MainLayout top header space

              // Top Active Card: Ваш тариф (Matching Figma screenshot 1-to-1)
              Container(
                padding: EdgeInsets.all(16 * s),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9).withOpacity(0.03),
                  borderRadius: BorderRadius.circular(16 * s),
                  border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.18)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ваш тариф',
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: Colors.white,
                                fontSize: 18 * s,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 6 * s),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12 * s, vertical: 4 * s),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6EAF91),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/crown.svg',
                                    width: 14 * s,
                                    height: 14 * s,
                                    colorFilter: const ColorFilter.mode(Color(0xFF060E11), BlendMode.srcIn),
                                  ),
                                  SizedBox(width: 6 * s),
                                  Text(
                                    _activePlan == 'PREMIUM_YEARLY'
                                        ? 'PREMIUM YEARLY'
                                        : (_activePlan == 'PREMIUM_MONTHLY' ? 'PREMIUM' : 'FREE'),
                                    style: TextStyle(
                                      fontFamily: 'GoogleSans',
                                      color: const Color(0xFF060E11),
                                      fontSize: 12 * s,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Активен',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: const Color(0xFF6EAF91),
                            fontSize: 16 * s,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12 * s),
                    Text(
                      _activePlan == 'PREMIUM_YEARLY'
                          ? 'Следующее списание: 15.07.2025 · 2490 ₽/год'
                          : (_activePlan == 'PREMIUM_MONTHLY' ? 'Следующее списание: 15.06.2025 · 299 ₽/мес' : 'Бесплатный период активен'),
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: const Color(0xFFACACAC),
                        fontSize: 13 * s,
                      ),
                    ),
                    SizedBox(height: 16 * s),
                    Divider(color: Colors.white.withOpacity(0.08), height: 1),
                    SizedBox(height: 12 * s),

                    // Способы оплаты
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => context.push('/profile/payment-methods'),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8 * s),
                        child: Row(
                          children: [
                            Container(
                              width: 38 * s,
                              height: 38 * s,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD9D9D9).withOpacity(0.04),
                                borderRadius: BorderRadius.circular(10 * s),
                                border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.2)),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/images/credit-card.svg',
                                  width: 18 * s,
                                  height: 18 * s,
                                  colorFilter: const ColorFilter.mode(Color(0xFF6EAF91), BlendMode.srcIn),
                                ),
                              ),
                            ),
                            SizedBox(width: 14 * s),
                            Expanded(
                              child: Text(
                                'Способы оплаты',
                                style: TextStyle(
                                  fontFamily: 'GoogleSans',
                                  color: Colors.white,
                                  fontSize: 15 * s,
                                ),
                              ),
                            ),
                            Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.5), size: 18 * s),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 4 * s),

                    // История платежей
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => context.push('/profile/payment-history'),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8 * s),
                        child: Row(
                          children: [
                            Container(
                              width: 38 * s,
                              height: 38 * s,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD9D9D9).withOpacity(0.04),
                                borderRadius: BorderRadius.circular(10 * s),
                                border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.2)),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/images/builling.svg',
                                  width: 18 * s,
                                  height: 18 * s,
                                  colorFilter: const ColorFilter.mode(Color(0xFF6EAF91), BlendMode.srcIn),
                                ),
                              ),
                            ),
                            SizedBox(width: 14 * s),
                            Expanded(
                              child: Text(
                                'История платежей',
                                style: TextStyle(
                                  fontFamily: 'GoogleSans',
                                  color: Colors.white,
                                  fontSize: 15 * s,
                                ),
                              ),
                            ),
                            Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.5), size: 18 * s),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16 * s),

              // Centered Link: Отменить подписку
              Center(
                child: GestureDetector(
                  onTap: () => _showCancelSubscriptionModal(context),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8 * s),
                    child: Text(
                      'Отменить подписку',
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: const Color(0xFFACACAC),
                        fontSize: 14 * s,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24 * s),

              // Title: Тарифы
              Text(
                'Тарифы',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: Colors.white,
                  fontSize: 18 * s,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16 * s),

              // CARD 1: Бесплатный (Free) — 0 ₽
              GestureDetector(
                onTap: () {
                  if (_activePlan == 'FREE') return;
                  _showConfirmChangePlanModal(
                    context: context,
                    targetPlanName: 'Free',
                    targetPlanKey: 'FREE',
                    priceText: '0 ₽',
                    dateText: 'бессрочно',
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20 * s),
                  decoration: BoxDecoration(
                    color: _activePlan == 'FREE'
                        ? const Color(0xFF6EAF91).withOpacity(0.08)
                        : const Color(0xFFD9D9D9).withOpacity(0.03),
                    borderRadius: BorderRadius.circular(16 * s),
                    border: Border.all(
                      color: _activePlan == 'FREE'
                          ? const Color(0xFF6EAF91)
                          : const Color(0xFFD9D9D9).withOpacity(0.18),
                      width: _activePlan == 'FREE' ? 1.5 : 1.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Бесплатный (Free) — 0 ₽',
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          color: Colors.white,
                          fontSize: 16 * s,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 14 * s),
                      _buildFeatureLine(s, '3 проверки в день', isAvailable: true),
                      SizedBox(height: 8 * s),
                      _buildFeatureLine(s, 'Базовый мониторинг', isAvailable: true),
                      SizedBox(height: 8 * s),
                      _buildFeatureLine(s, 'Расширенный мониторинг', isAvailable: false),
                      if (_activePlan == 'FREE') ...[
                        SizedBox(height: 16 * s),
                        Center(
                          child: Text(
                            'Ваш текущий план',
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: const Color(0xFF6EAF91),
                              fontSize: 14 * s,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16 * s),

              // CARD 2: Premium Monthly — 299 ₽ (Active Plan Card in Screenshot)
              GestureDetector(
                onTap: () {
                  if (_activePlan == 'PREMIUM_MONTHLY') return;
                  _showConfirmChangePlanModal(
                    context: context,
                    targetPlanName: 'Premium Monthly',
                    targetPlanKey: 'PREMIUM_MONTHLY',
                    priceText: '299 ₽',
                    dateText: '15.06.2025',
                  );
                },
                child: Container(
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
                    borderRadius: BorderRadius.circular(16 * s),
                    border: Border.all(
                      color: _activePlan == 'PREMIUM_MONTHLY'
                          ? const Color(0xFF6EAF91)
                          : Colors.white.withOpacity(0.18),
                      width: _activePlan == 'PREMIUM_MONTHLY' ? 1.5 : 1.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6EAF91).withOpacity(0.15),
                        blurRadius: 16 * s,
                        offset: Offset(0, 4 * s),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Premium Monthly — 299 ₽',
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: Colors.white,
                              fontSize: 16 * s,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/images/crown.svg',
                            width: 20 * s,
                            height: 20 * s,
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                        ],
                      ),
                      SizedBox(height: 14 * s),
                      _buildFeatureLine(s, 'Увеличенные лимиты проверок', isAvailable: true),
                      SizedBox(height: 8 * s),
                      _buildFeatureLine(s, 'Расширенный мониторинг', isAvailable: true),
                      SizedBox(height: 8 * s),
                      _buildFeatureLine(s, 'Полный доступ к истории', isAvailable: true),
                      SizedBox(height: 8 * s),
                      _buildFeatureLine(s, 'Cyber Advisor Recommendations', isAvailable: true),
                      SizedBox(height: 20 * s),
                      Center(
                        child: Text(
                          _activePlan == 'PREMIUM_MONTHLY' ? 'Ваш текущий план' : 'Перейти на помесячный план',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white,
                            fontSize: 15 * s,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16 * s),

              // CARD 3: Premium Yearly - 2490 ₽ (Figma Node 159-1920 Trigger)
              GestureDetector(
                onTap: () {
                  if (_activePlan == 'PREMIUM_YEARLY') return;
                  _showConfirmChangePlanModal(
                    context: context,
                    targetPlanName: 'Premium Yearly',
                    targetPlanKey: 'PREMIUM_YEARLY',
                    priceText: '2490 ₽',
                    dateText: '15.07.2025.',
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20 * s),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9).withOpacity(0.03),
                    borderRadius: BorderRadius.circular(16 * s),
                    border: Border.all(
                      color: _activePlan == 'PREMIUM_YEARLY'
                          ? const Color(0xFF6EAF91)
                          : const Color(0xFFD9D9D9).withOpacity(0.18),
                      width: _activePlan == 'PREMIUM_YEARLY' ? 1.5 : 1.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Premium Yearly - 2490 ₽',
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: Colors.white,
                              fontSize: 16 * s,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/images/crown.svg',
                            width: 20 * s,
                            height: 20 * s,
                            colorFilter: const ColorFilter.mode(Colors.white70, BlendMode.srcIn),
                          ),
                        ],
                      ),
                      SizedBox(height: 8 * s),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10 * s, vertical: 4 * s),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6EAF91).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20 * s),
                        ),
                        child: Text(
                          'ВЫГОДНО (-30%)',
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: const Color(0xFF6EAF91),
                            fontSize: 11 * s,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 16 * s),

                      // Dark Green Gradient Action Button: Перейти на годовой план
                      Container(
                        height: 48 * s,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF0F3A2A),
                              Color(0xFF072118),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(24 * s),
                          border: Border.all(color: const Color(0xFF6EAF91).withOpacity(0.6)),
                        ),
                        child: Center(
                          child: Text(
                            _activePlan == 'PREMIUM_YEARLY' ? 'Ваш текущий план' : 'Перейти на годовой план',
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: Colors.white,
                              fontSize: 15 * s,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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

  Widget _buildFeatureLine(double s, String text, {required bool isAvailable}) {
    return Row(
      children: [
        Container(
          width: 18 * s,
          height: 18 * s,
          decoration: BoxDecoration(
            color: isAvailable
                ? const Color(0xFF6EAF91).withOpacity(0.2)
                : const Color(0xFFFF4B4B).withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isAvailable ? Icons.check : Icons.close,
            color: isAvailable ? const Color(0xFF6EAF91) : const Color(0xFFFF4B4B),
            size: 12 * s,
          ),
        ),
        SizedBox(width: 10 * s),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'GoogleSans',
            color: isAvailable ? Colors.white.withOpacity(0.9) : const Color(0xFFACACAC),
            fontSize: 13 * s,
            decoration: isAvailable ? TextDecoration.none : TextDecoration.lineThrough,
          ),
        ),
      ],
    );
  }
}
