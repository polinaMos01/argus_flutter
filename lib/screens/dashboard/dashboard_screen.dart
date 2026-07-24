import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../security/security_score_screen.dart';
import '../checks/email_check_screen.dart';
import '../checks/phone_check_screen.dart';
import '../checks/file_check_screen.dart';
import '../threats/threats_list_screen.dart';
import '../tools/cyber_advisor_screen.dart';
import '../tools/password_center_screen.dart';
import '../tools/data_exposure_screen.dart';
import '../tools/weekly_report_screen.dart';
import '../premium/tariffs_screen.dart';
import '../notifications/notifications_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  bool _showToast = false;

  late AnimationController _animController;
  
  // Bezier curve
  static const _bezierCurve = Cubic(0.25, 0.1, 0.25, 1.0);

  // Animations based on timeline keyframes (4000ms duration)
  late Animation<double> _mainCardBgOpacity;
  
  late Animation<double> _gaugeScale;
  late Animation<double> _gaugeOpacity;
  
  late Animation<double> _gaugeArcOpacity;
  late Animation<double> _gaugeArcSweep;
  
  late Animation<double> _scoreScale;
  late Animation<double> _scoreOpacity;
  
  late Animation<double> _scoreMaxOpacity;
  
  late Animation<double> _textGoodTranslationY;
  late Animation<double> _textGoodOpacity;
  
  late Animation<double> _textKeepUpTranslationY;
  late Animation<double> _textKeepUpOpacity;
  
  late Animation<double> _shieldIconScale;
  late Animation<double> _shieldIconOpacity;
  
  late Animation<double> _progressBarHeaderTextOpacity;
  late Animation<double> _progressBarTrackOpacity;
  late Animation<double> _progressBarFillScaleX;
  late Animation<double> _progressBarFillOpacity;
  late Animation<double> _progressBarScoreTextOpacity;
  
  late Animation<double> _card1ScaleX;
  late Animation<double> _card1Opacity;
  late Animation<double> _card1ContentOpacity;
  
  late Animation<double> _card2ScaleX;
  late Animation<double> _card2Opacity;
  late Animation<double> _card2ContentOpacity;
  
  late Animation<double> _card3ScaleX;
  late Animation<double> _card3Opacity;
  late Animation<double> _card3ContentOpacity;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    // Node 53:376 - Main Rating Card Background
    _mainCardBgOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.16, curve: _bezierCurve),
      ),
    );

    // Nodes 53:451, 53:454 - Circular Gauge Scale & Opacity
    _gaugeScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.04, 0.28, curve: _bezierCurve),
      ),
    );
    _gaugeOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.04, 0.28, curve: _bezierCurve),
      ),
    );

    // Node 53:463 - Gauge progress arc drawing
    _gaugeArcOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.12, 0.20, curve: _bezierCurve),
      ),
    );
    _gaugeArcSweep = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.12, 0.60, curve: _bezierCurve),
      ),
    );

    // Node 53:456 - Score Text "86"
    _scoreScale = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.12, 0.36, curve: _bezierCurve),
      ),
    );
    _scoreOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.12, 0.36, curve: _bezierCurve),
      ),
    );

    // Node 53:457 - Score Max Text "/100"
    _scoreMaxOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.20, 0.40, curve: _bezierCurve),
      ),
    );

    // Node 53:458 - Text "Хорошо"
    _textGoodTranslationY = Tween<double>(begin: 10.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.20, 0.40, curve: _bezierCurve),
      ),
    );
    _textGoodOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.20, 0.40, curve: _bezierCurve),
      ),
    );

    // Node 53:459 - Text "Так держать!"
    _textKeepUpTranslationY = Tween<double>(begin: 10.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.24, 0.44, curve: _bezierCurve),
      ),
    );
    _textKeepUpOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.24, 0.44, curve: _bezierCurve),
      ),
    );

    // Node 109:1667 - Shield icon in the card
    _shieldIconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.24, 0.40, curve: _bezierCurve),
      ),
    );
    _shieldIconOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.24, 0.40, curve: _bezierCurve),
      ),
    );

    // Node 109:1678 - Progress bar title "Утечки данных"
    _progressBarHeaderTextOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.36, 0.48, curve: _bezierCurve),
      ),
    );

    // Node 109:1682 - Progress bar track
    _progressBarTrackOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.424, 0.544, curve: _bezierCurve),
      ),
    );

    // Node 109:1685 - Progress bar fill Scale & Opacity
    _progressBarFillScaleX = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.52, 0.72, curve: _bezierCurve),
      ),
    );
    _progressBarFillOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.52, 0.58, curve: _bezierCurve),
      ),
    );

    // Node 109:1684 - Progress bar score "71%"
    _progressBarScoreTextOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.456, 0.576, curve: _bezierCurve),
      ),
    );

    // Node 109:1680 - Card 1 background scale & opacity
    _card1ScaleX = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.40, 0.60, curve: _bezierCurve),
      ),
    );
    _card1Opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.40, 0.60, curve: _bezierCurve),
      ),
    );
    // Node 109:1679 - Card 1 content
    _card1ContentOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.392, 0.512, curve: _bezierCurve),
      ),
    );

    // Node 109:1681 - Card 2 background scale & opacity
    _card2ScaleX = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.44, 0.64, curve: _bezierCurve),
      ),
    );
    _card2Opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.44, 0.64, curve: _bezierCurve),
      ),
    );
    // Node 109:1698 - Card 2 content
    _card2ContentOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.40, 0.52, curve: _bezierCurve),
      ),
    );

    // Node 109:1683 - Card 3 background scale & opacity
    _card3ScaleX = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.48, 0.68, curve: _bezierCurve),
      ),
    );
    _card3Opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.48, 0.68, curve: _bezierCurve),
      ),
    );
    // Node 109:1701 - Card 3 content
    _card3ContentOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.40, 0.52, curve: _bezierCurve),
      ),
    );

    _animController.forward();

    // Show toast automatically after 1 minute
    Future.delayed(const Duration(minutes: 1), () {
      if (mounted) {
        setState(() {
          _showToast = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double realWidth = MediaQuery.of(context).size.width;
    final isMobile = realWidth < 600;
    final double canvasWidth = isMobile ? realWidth : 430.0;
    
    // Scale factor based on the design width of 430
    final double scale = canvasWidth / 430.0;
    double s(double val) => val * scale;
    
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: canvasWidth,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF060E11),
            gradient: RadialGradient(
              center: Alignment(0, 1.2),
              radius: 1.5,
              colors: [
                Color(0xFF132A1C),
                Color(0xFF060E11),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Scrollable Dashboard Body
              Positioned.fill(
                bottom: 0,
                child: RefreshIndicator(
                  onRefresh: () async {
                    _animController.reset();
                    _animController.forward();
                    await Future.delayed(const Duration(milliseconds: 1000));
                  },
                  color: const Color(0xFF6EAF91),
                  backgroundColor: const Color(0xFF132A1C),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SizedBox(
                      width: canvasWidth,
                      height: s(1170), // total scroll height exactly containing the premium banner
                      child: Stack(
                        children: [
                          // Header: Welcome
                          Positioned(
                            left: s(24),
                            top: s(72),
                            child: Text(
                              'Добро пожаловать',
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: const Color(0xFFABABAB),
                                fontSize: s(14),
                                fontWeight: FontWeight.w400,
                                height: 1.30,
                              ),
                            ),
                          ),
                          Positioned(
                            left: s(24),
                            top: s(99),
                            child: Text(
                              'Алекс Томсон',
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: Colors.white,
                                fontSize: s(24),
                                fontWeight: FontWeight.w400,
                                height: 1.30,
                              ),
                            ),
                          ),
                          
                          // Notification Bell
                          Positioned(
                            right: s(24),
                            top: s(75),
                            width: s(22),
                            height: s(22),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                context.push('/notifications');
                              },
                              child: SvgPicture.asset(
                                'assets/images/bell.svg',
                                width: s(22),
                                height: s(22),
                              ),
                            ),
                          ),

                          // Rating section title and badge
                          Positioned(
                            left: s(24),
                            top: s(156),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                context.push('/security-score');
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Рейтинг безопасности',
                                    style: TextStyle(
                                      fontFamily: 'GoogleSans',
                                      color: Colors.white,
                                      fontSize: s(18),
                                      fontWeight: FontWeight.w400,
                                      height: 1.30,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  SvgPicture.asset(
                                    'assets/images/chevron_right.svg',
                                    width: s(8),
                                    height: s(16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: s(294),
                            top: s(158),
                            child: Container(
                              width: s(113),
                              height: s(21),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD1FFE9),
                                borderRadius: BorderRadius.circular(s(31)),
                              ),
                              child: Text(
                                'Мониторинг активен',
                                style: TextStyle(
                                  fontFamily: 'GoogleSans',
                                  color: const Color(0xFF2D493C),
                                  fontSize: s(10),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),

                          // Safety Rating Card (x: 24, y: 197, width: 383, height: 308)
                          Positioned(
                            left: s(24),
                            top: s(197),
                            width: s(383),
                            height: s(308),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                context.push('/security-score');
                              },
                              child: _buildAnimatedSafetyRatingCard(s),
                            ),
                          ),

                          // Quick Checks (3 cards at y: 514)
                          Positioned(
                            left: 0,
                            top: s(514),
                            width: canvasWidth,
                            height: s(116),
                            child: _buildAnimatedQuickChecksRow(s),
                          ),

                          // Recent Threats Section (y: 656)
                          Positioned(
                            left: s(27),
                            top: s(656),
                            child: Text(
                              'Последние угрозы',
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: Colors.white,
                                fontSize: s(18),
                                fontWeight: FontWeight.w400,
                                height: 1.30,
                              ),
                            ),
                          ),
                          Positioned(
                            left: s(296),
                            top: s(656),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                context.push('/threats');
                              },
                              child: Text(
                                'Посмотреть все',
                                style: TextStyle(
                                  fontFamily: 'GoogleSans',
                                  color: const Color(0xFFABABAB),
                                  fontSize: s(14),
                                  fontWeight: FontWeight.w400,
                                  height: 1.30,
                                ),
                              ),
                            ),
                          ),

                          // Threats Card (y: 694)
                          Positioned(
                            left: s(24),
                            top: s(694),
                            width: s(382),
                            height: s(70),
                            child: _buildThreatsCard(s),
                          ),

                          // Quick Tools Grid (y: 782)
                          Positioned(
                            left: s(24),
                            top: s(782),
                            width: s(382),
                            height: s(300),
                            child: _buildQuickToolsGrid(s),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),



              // Fixed Status Bar removed to prevent overlapping with system clock
              // Fixed Bottom Navigation Bar removed because MainLayout provides it

              // Fixed Premium Scan Banner pinned above the toolbar (edge-to-edge)
              Positioned(
                bottom: s(12),
                left: 0,
                right: 0,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    context.push('/tariffs');
                  },
                  child: _buildPremiumBanner(s),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Status Bar matching Figma precisely
  Widget _buildStatusBar(double Function(double) s) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: s(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Time
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: s(18), bottom: s(13)),
              child: Row(
                children: [
                  SizedBox(width: s(16)),
                  Text(
                    '1:47',
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: Colors.white,
                      fontSize: s(18),
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.44,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Dynamic Island Spacer
          Container(
            padding: EdgeInsets.only(top: s(11), bottom: s(6)),
            child: Container(
              width: s(126),
              height: s(37),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          // System Icons (Cellular, Wifi, Battery)
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: s(18), bottom: s(13)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset('assets/images/cellularbars F17.svg', width: s(18), height: s(12)),
                  SizedBox(width: s(5)),
                  SvgPicture.asset('assets/images/wifi F17.svg', width: s(16), height: s(12)),
                  SizedBox(width: s(5)),
                  SvgPicture.asset('assets/images/battery.100 F22 Fina.svg', width: s(25), height: s(12)),
                  SizedBox(width: s(14)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  // Safety Rating Card (height: 308) with timeline animations
  Widget _buildAnimatedSafetyRatingCard(double Function(double) s) {
    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) {
        return Opacity(
          opacity: _mainCardBgOpacity.value,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.85, sigmaY: 3.85),
              child: Container(
                width: s(383),
                height: s(308),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.12),
                    width: 1,
                  ),
                ),
                child: Stack(
                  children: [
                    // Wavy line graph drawing behind status texts
                    Positioned(
                      left: s(12),
                      right: s(12),
                      top: s(140),
                      height: s(82),
                      child: IgnorePointer(
                        child: ClipRect(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            widthFactor: _gaugeArcSweep.value,
                            child: SvgPicture.asset(
                              'assets/images/wave_line.svg',
                              width: s(359),
                              height: s(82),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Gauge and status (Good!)
                    Positioned(
                      top: s(16),
                      left: s(17),
                      right: s(17),
                      child: Row(
                        children: [
                          // Circular Gauge (138x138)
                          Transform.scale(
                            scale: _gaugeScale.value,
                            child: Opacity(
                              opacity: _gaugeOpacity.value,
                              child: SizedBox(
                                width: s(138),
                                height: s(138),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CustomPaint(
                                      size: Size(s(138), s(138)),
                                      painter: ScoreGaugePainter(
                                        score: 86,
                                        sweepProgress: _gaugeArcSweep.value,
                                        arcOpacity: _gaugeArcOpacity.value,
                                      ),
                                    ),
                                    // Shield checkmark icon inside gauge at the top
                                    Positioned(
                                      top: s(24),
                                      child: Transform.scale(
                                        scale: _shieldIconScale.value,
                                        child: Opacity(
                                          opacity: _shieldIconOpacity.value,
                                          child: SvgPicture.asset(
                                            'assets/images/shield_checkmark.svg',
                                            width: s(16),
                                            height: s(19),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Score text (offset slightly down to account for shield checkmark at top)
                                    Positioned(
                                      top: s(48),
                                      child: Transform.scale(
                                        scale: _scoreScale.value,
                                        child: Opacity(
                                          opacity: _scoreOpacity.value,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '86',
                                                style: TextStyle(
                                                  fontFamily: 'GoogleSans',
                                                  color: Colors.white,
                                                  fontSize: s(52),
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.0,
                                                ),
                                              ),
                                              Opacity(
                                                opacity: _scoreMaxOpacity.value,
                                                child: Text(
                                                  '/100',
                                                  style: TextStyle(
                                                    fontFamily: 'GoogleSans',
                                                    color: Colors.white.withOpacity(0.37),
                                                    fontSize: s(12),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Status texts
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Transform.translate(
                                  offset: Offset(0, _textGoodTranslationY.value),
                                  child: Opacity(
                                    opacity: _textGoodOpacity.value,
                                    child: ShaderMask(
                                      shaderCallback: (bounds) => const LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color(0xFF6EAF91),
                                          Color(0xFFD1FFEA),
                                          Color(0xFF2E493C),
                                        ],
                                        stops: [0.17, 0.50, 0.82],
                                      ).createShader(bounds),
                                      child: Text(
                                        'Хорошо',
                                        style: TextStyle(
                                          fontFamily: 'GoogleSans',
                                          color: Colors.white,
                                          fontSize: s(32),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Transform.translate(
                                  offset: Offset(0, _textKeepUpTranslationY.value),
                                  child: Opacity(
                                    opacity: _textKeepUpOpacity.value,
                                    child: Text(
                                      'Так держать!',
                                      style: TextStyle(
                                        fontFamily: 'GoogleSans',
                                        color: Colors.white,
                                        fontSize: s(16),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // "Утечки данных" 71% progress bar
                    Positioned(
                      bottom: s(74),
                      left: s(17),
                      right: s(17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Opacity(
                                opacity: _progressBarHeaderTextOpacity.value,
                                child: Text(
                                  'Утечки данных',
                                  style: TextStyle(
                                    fontFamily: 'GoogleSans',
                                    color: Colors.white.withOpacity(0.4),
                                    fontSize: s(12),
                                  ),
                                ),
                              ),
                              Opacity(
                                opacity: _progressBarScoreTextOpacity.value,
                                child: Text(
                                  '71%',
                                  style: TextStyle(
                                    fontFamily: 'GoogleSans',
                                    color: Colors.white.withOpacity(0.4),
                                    fontSize: s(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Opacity(
                            opacity: _progressBarTrackOpacity.value,
                            child: Container(
                              height: s(4),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Opacity(
                                opacity: _progressBarFillOpacity.value,
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: 0.71 * _progressBarFillScaleX.value,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF6EAF91),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Bottom stats row: 12, 7, 86%
                    Positioned(
                      bottom: s(20),
                      left: s(17),
                      right: s(17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStatItem('12', 'угроз', 'найдено', s),
                          _buildDivider(s),
                          _buildStatItem('7', 'проверок', 'сегодня', s),
                          _buildDivider(s),
                          _buildStatItemPercentage('86', '%', 'уровень', 'защиты', s),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatItem(String value, String label1, String label2, double Function(double) s) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'GoogleSans',
            color: Colors.white,
            fontSize: s(32),
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: s(8)),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label1,
              style: TextStyle(
                fontFamily: 'GoogleSans',
                color: Colors.white.withOpacity(0.4),
                fontSize: s(10),
              ),
            ),
            Text(
              label2,
              style: TextStyle(
                fontFamily: 'GoogleSans',
                color: Colors.white.withOpacity(0.4),
                fontSize: s(10),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItemPercentage(String value, String percentage, String label1, String label2, double Function(double) s) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: TextStyle(
                fontFamily: 'GoogleSans',
                color: Colors.white,
                fontSize: s(32),
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              percentage,
              style: TextStyle(
                fontFamily: 'GoogleSans',
                color: Colors.white,
                fontSize: s(12),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(width: s(8)),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label1,
              style: TextStyle(
                fontFamily: 'GoogleSans',
                color: Colors.white.withOpacity(0.4),
                fontSize: s(10),
              ),
            ),
            Text(
              label2,
              style: TextStyle(
                fontFamily: 'GoogleSans',
                color: Colors.white.withOpacity(0.4),
                fontSize: s(10),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDivider(double Function(double) s) {
    return Container(
      height: s(24),
      width: 1,
      color: Colors.white.withOpacity(0.15),
    );
  }

  // Quick checks (3 absolute-positioned cards matching y: 514 exactly, with scaling)
  Widget _buildAnimatedQuickChecksRow(double Function(double) s) {
    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) {
        return Stack(
          children: [
            // Card 1: Email check (x: 24)
            Positioned(
              left: s(24),
              top: 0,
              width: s(121),
              height: s(116),
              child: Opacity(
                opacity: _card1Opacity.value,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.diagonal3Values(_card1ScaleX.value, 1.0, 1.0),
                  child: _buildQuickCheckCard(
                    'Проверка\ne-mail',
                    'assets/images/email_check.svg', // glowing envelope SVG
                    _card1ContentOpacity.value,
                    () {
                      context.push('/email-check');
                    },
                    s,
                    iconWidth: s(50),
                    iconHeight: s(43),
                    iconLeft: s(3), // 16 - 13.2 (SVG internal offset)
                    iconTop: s(3),
                  ),
                ),
              ),
            ),
            
            // Card 2: Phone check (x: 154)
            Positioned(
              left: s(154),
              top: 0,
              width: s(121),
              height: s(116),
              child: Opacity(
                opacity: _card2Opacity.value,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.diagonal3Values(_card2ScaleX.value, 1.0, 1.0),
                  child: _buildQuickCheckCard(
                    'Проверка телефона',
                    'assets/images/phone_check.svg', // phone SVG
                    _card2ContentOpacity.value,
                    () {
                      context.push('/phone-check');
                    },
                    s,
                    iconWidth: s(42),
                    iconHeight: s(49),
                    iconLeft: s(3),
                    iconTop: s(3),
                  ),
                ),
              ),
            ),
            
            // Card 3: File check (x: 285)
            Positioned(
              left: s(285),
              top: 0,
              width: s(121),
              height: s(116),
              child: Opacity(
                opacity: _card3Opacity.value,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.diagonal3Values(_card3ScaleX.value, 1.0, 1.0),
                  child: _buildQuickCheckCard(
                    'Проверка файла',
                    'assets/images/file_check.svg', // file SVG
                    _card3ContentOpacity.value,
                    () {
                      context.push('/file-check');
                    },
                    s,
                    iconWidth: s(18),
                    iconHeight: s(24),
                    iconLeft: s(16),
                    iconTop: s(16),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildQuickCheckCard(
    String title,
    String svgAssetPath,
    double contentOpacity,
    VoidCallback onTap,
    double Function(double) s, {
    required double iconWidth,
    required double iconHeight,
    required double iconLeft,
    required double iconTop,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: s(121),
        height: s(116),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.12),
            width: 1,
          ),
        ),
        child: Opacity(
          opacity: contentOpacity,
          child: Stack(
            children: [
              // Absolute positioned custom SVG Icon
              Positioned(
                left: iconLeft,
                top: iconTop,
                width: iconWidth,
                height: iconHeight,
                child: SvgPicture.asset(
                  svgAssetPath,
                  width: iconWidth,
                  height: iconHeight,
                  fit: BoxFit.fill,
                ),
              ),
              // Text at the bottom
              Positioned(
                left: s(17),
                bottom: s(12),
                width: s(87),
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    color: Colors.white,
                    fontSize: s(14),
                    fontWeight: FontWeight.w400,
                    height: 1.30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Threats Card
  Widget _buildThreatsCard(double Function(double) s) {
    return Container(
      width: s(378),
      height: s(70),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          // Red glowing dot at left: 17, top: 19
          Positioned(
            left: s(17),
            top: s(19),
            width: s(8),
            height: s(8),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFF0000).withOpacity(0.57),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF0000).withOpacity(0.6),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
          
          // Title "Новый слив данных" at left: 36, top: 14
          Positioned(
            left: s(36),
            top: s(14),
            child: Text(
              'Новый слив данных',
              style: TextStyle(
                fontFamily: 'GoogleSans',
                color: Colors.white,
                fontSize: s(14),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          
          // Subtitle "Ваш email найден в новой утечке" at left: 35, top: 37
          Positioned(
            left: s(35),
            top: s(37),
            child: Text(
              'Ваш email найден в новой утечке',
              style: TextStyle(
                fontFamily: 'GoogleSans',
                color: Colors.white.withOpacity(0.4),
                fontSize: s(12),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          
          // Time "2 мин" at right: 16, top: 14
          Positioned(
            right: s(16),
            top: s(14),
            child: Text(
              '2 мин',
              style: TextStyle(
                fontFamily: 'GoogleSans',
                color: Colors.white.withOpacity(0.4),
                fontSize: s(12),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Quick Tools Grid (2x2) with absolute positioning inside tool cards
  Widget _buildQuickToolsGrid(double Function(double) s) {
    return SizedBox(
      width: s(377),
      height: s(280),
      child: Stack(
        children: [
        // Cyber Advisor (top-left)
        Positioned(
          left: 0,
          top: 0,
          width: s(180),
          height: s(132),
          child: _buildToolCard(
            'Cyber Advisor',
            'AI-помощник',
            'assets/images/cyber_advisor.png',
            s(105),
            s(103),
            s,
            imgLeft: s(64),
            imgTop: s(3),
            onTap: () {
              context.push('/advisor');
            },
          ),
        ),
        // Password Center (top-right)
        Positioned(
          left: s(197),
          top: 0,
          width: s(180),
          height: s(132),
          child: _buildToolCard(
            'Password Center',
            'Генератор паролей',
            'assets/images/password_center.png',
            s(119),
            s(94),
            s,
            imgLeft: s(61),
            imgTop: s(7),
            onTap: () {
              context.push('/password-center');
            },
          ),
        ),
        // Data Exposure (bottom-left)
        Positioned(
          left: 0,
          top: s(148),
          width: s(180),
          height: s(132),
          child: _buildToolCard(
            'Data Exposure',
            'Что утекло',
            'assets/images/data_exposure.png',
            s(110),
            s(90),
            s,
            imgLeft: s(70),
            imgTop: s(9),
            onTap: () {
              context.push('/monitoring');
            },
          ),
        ),
        // Weekly Report (bottom-right)
        Positioned(
          left: s(197),
          top: s(148),
          width: s(180),
          height: s(132),
          child: _buildToolCard(
            'Weekly Report',
            'Отчёт за неделю',
            'assets/images/weekly_report.png',
            s(92),
            s(77),
            s,
            imgLeft: s(62),
            imgTop: s(3),
            onTap: () {
              context.push('/weekly-report');
            },
          ),
        ),
      ],
      ),
    );
  }

  Widget _buildToolCard(
    String title,
    String subtitle,
    String imageAssetPath,
    double imageWidth,
    double imageHeight,
    double Function(double) s, {
    required double imgLeft,
    required double imgTop,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(0.08),
              const Color(0xFF6EAF91).withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.05),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            // 3D Glow Illustration positioned on the right
            Positioned(
              left: imgLeft,
              top: imgTop,
              width: imageWidth,
              height: imageHeight,
              child: Opacity(
                opacity: 0.35,
                child: Image.asset(
                  imageAssetPath,
                  width: imageWidth,
                  height: imageHeight,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Text Content
            Positioned(
              left: s(12),
              top: s(78),
              width: s(153),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: Colors.white,
                      fontSize: s(14),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: Colors.white.withOpacity(0.4),
                      fontSize: s(12),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  // Premium Banner matching Figma specifications exactly
  Widget _buildPremiumBanner(double Function(double) s) {
    return Container(
      width: double.infinity,
      height: s(36),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF6EAF91),
            Color(0xFFD1FFEA),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Mail envelope icon (Group-2.svg) on the left
              SvgPicture.asset(
                'assets/images/premium_bolt.svg',
                width: s(16),
                height: s(16),
                colorFilter: const ColorFilter.mode(Color(0xFF2E493C), BlendMode.srcIn),
              ),
              const SizedBox(width: 8),
              Text(
                'Активировать Premium Scan со скидкой 70%',
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  color: const Color(0xFF2D493C),
                  fontSize: s(14),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Bottom Navigation Bar with SVGs and 3D Center FAB (fixed at bottom)
  Widget _buildBottomNavigationBar(double Function(double) s, double bottomPadding) {
    return Container(
      height: s(96) + bottomPadding,
      decoration: BoxDecoration(
        color: const Color(0xFF060E11).withOpacity(0.92),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Top thin dividing line
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            height: 1,
            child: Container(
              color: const Color(0x1ED9D9D9),
            ),
          ),
          // Nav items row
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            height: s(96),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildNavItem(0, 'assets/images/nav_home.svg', 'Дом', s),
                SizedBox(width: s(40)),
                _buildNavItem(1, 'assets/images/nav_checks.svg', 'Проверки', s),
                SizedBox(width: s(100)), // Center gap
                _buildNavItem(2, 'assets/images/nav_monitoring.svg', 'Мониторинг', s),
                SizedBox(width: s(16)),
                _buildNavItem(3, 'assets/images/nav_profile.svg', 'Профиль', s),
              ],
            ),
          ),
          // Center FAB (Brain) - perfectly centered vertically in the 96px toolbar
          Positioned(
            top: s(8), // (96 - 80) / 2
            left: 0,
            right: 0,
            child: Center(
              child: _buildFabItem(s),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String svgAssetPath, String label, double Function(double) s) {
    final isSelected = index == 0; // Dashboard is index 0
    final color = isSelected ? const Color(0xFFD1FFEA) : Colors.white.withOpacity(0.4);
    return GestureDetector(
      onTap: () {
        if (index == 1) {
          context.go('/checks');
        } else if (index == 2) {
          context.go('/monitoring');
        } else if (index == 3) {
          context.go('/profile');
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 4,
        children: [
          SvgPicture.asset(
            svgAssetPath,
            width: s(32),
            height: s(32),
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.visible,
            style: TextStyle(
              fontFamily: 'GoogleSans',
              color: color,
              fontSize: s(12),
              fontWeight: FontWeight.w400,
              height: 1.30,
            ),
          ),
        ],
      ),
    );
  }

  // FAB using 3D Glowing AI Icon (nav_brain.png)
  Widget _buildFabItem(double Function(double) s) {
    return GestureDetector(
      onTap: () {
        // Open AI chatbot page or similar
      },
      child: Container(
        width: s(88),
        padding: EdgeInsets.symmetric(vertical: s(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: s(80),
              height: s(80),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF6EAF91),
                    Color(0xFFD1FFEA),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                border: Border.all(
                  color: const Color(0xFFD1FFEA),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x4000FF87),
                    blurRadius: s(9),
                  ),
                  BoxShadow(
                    color: const Color(0xFF00FF87),
                    blurRadius: s(5),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/nav_brain.png',
                width: s(41),
                height: s(46),
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Painter for Safety Score Circular Gauge with Sweep Animation support
class ScoreGaugePainter extends CustomPainter {
  final double score; // 0 to 100
  final double sweepProgress; // 0 to 1
  final double arcOpacity; // 0 to 1

  ScoreGaugePainter({
    required this.score,
    required this.sweepProgress,
    required this.arcOpacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    final rect = Rect.fromCircle(center: center, radius: radius);
    
    const double startAngle = 3 * 3.1415926535897932 / 4; // 135 degrees (bottom-left)
    const double totalSweep = 1.5 * 3.1415926535897932; // 270 degrees

    // Draw background track (horseshoe)
    final trackPaint = Paint()
      ..color = Colors.white.withOpacity(0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, startAngle, totalSweep, false, trackPaint);

    // Draw progress arc
    if (arcOpacity > 0) {
      final progressPaint = Paint()
        ..shader = LinearGradient(
          colors: [
            const Color(0xFF6EAF91).withOpacity(arcOpacity),
            const Color(0xFFD1FFAF).withOpacity(arcOpacity),
          ],
        ).createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8
        ..strokeCap = StrokeCap.round;

      // The glow effect
      final glowPaint = Paint()
        ..shader = LinearGradient(
          colors: [
            const Color(0xFF6EAF91).withOpacity(arcOpacity * 0.4),
            const Color(0xFFD1FFAF).withOpacity(arcOpacity * 0.4),
          ],
        ).createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 14
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

      final currentSweep = totalSweep * (score / 100) * sweepProgress;
      
      canvas.drawArc(rect, startAngle, currentSweep, false, glowPaint);
      canvas.drawArc(rect, startAngle, currentSweep, false, progressPaint);
    }
  }

  @override
  bool shouldRepaint(covariant ScoreGaugePainter oldDelegate) {
    return oldDelegate.score != score ||
        oldDelegate.sweepProgress != sweepProgress ||
        oldDelegate.arcOpacity != arcOpacity;
  }
}
