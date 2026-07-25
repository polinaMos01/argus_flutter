import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _introController;
  late Animation<double> _shieldOpacity;
  late Animation<double> _shieldScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _logoScale;
  late Animation<Offset> _subtextOffset;
  late Animation<double> _subtextOpacity;
  late Animation<double> _loadingProgress;
  late Animation<double> _loadingOpacity;
  late Animation<double> _buttonOpacity;
  
  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(reverse: true);
    
    _introController = AnimationController(vsync: this, duration: const Duration(milliseconds: 3800));
    
    _shieldOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _introController, curve: const Interval(0.0, 0.25, curve: Curves.easeOut)),
    );

    _shieldScale = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _introController, curve: const Interval(0.0, 0.35, curve: Curves.easeOutBack)),
    );
    
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _introController, curve: const Interval(0.20, 0.50, curve: Curves.easeOut)),
    );

    _logoScale = Tween<double>(begin: 0.30, end: 1.0).animate(
      CurvedAnimation(parent: _introController, curve: const Interval(0.20, 0.55, curve: Curves.easeOutBack)),
    );

    _subtextOffset = Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _introController, curve: const Interval(0.40, 0.65, curve: Curves.easeOutCubic)),
    );

    _subtextOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _introController, curve: const Interval(0.40, 0.65, curve: Curves.easeOut)),
    );
    
    _loadingProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _introController, curve: const Interval(0.3, 0.85, curve: Curves.easeInOut)),
    );
    
    _loadingOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween<double>(1.0), weight: 85),
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.0), weight: 5),
      TweenSequenceItem(tween: ConstantTween<double>(0.0), weight: 10),
    ]).animate(_introController);
    
    _buttonOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _introController, curve: const Interval(0.88, 1.0, curve: Curves.easeOut)),
    );

    _introController.forward();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _introController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, 1.2),
            radius: 1.5,
            colors: [
              Color(0xFF132A1C),
              Color(0xFF0A0A0F),
            ],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 3),
                
                // Shield + Circles
                AnimatedBuilder(
                  animation: _introController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _shieldScale.value,
                      child: Opacity(
                        opacity: _shieldOpacity.value,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedBuilder(
                              animation: _pulseController,
                              builder: (context, child) {
                                return CustomPaint(
                                  size: const Size(421, 421),
                                  painter: CirclesPainter(
                                    progress: _pulseController.value,
                                    baseColor: AppColors.colorGreenLight.withValues(alpha: 0.15),
                                  ),
                                );
                              },
                            ),
                            AnimatedBuilder(
                              animation: _pulseController,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: 0.95 + (_pulseController.value * 0.05),
                                  child: child,
                                );
                              },
                              child: SizedBox(
                                width: 122,
                                height: 105,
                                child: Stack(
                                  clipBehavior: Clip.hardEdge,
                                  children: [
                                    Positioned(
                                      top: -65.6,
                                      left: 0,
                                      right: 0,
                                      child: Image.asset(
                                        'assets/images/shield.png',
                                        width: 122,
                                        height: 244,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 60),
                
                // Logo & Text with WOW Scale and Slide Entrance
                AnimatedBuilder(
                  animation: _introController,
                  builder: (context, child) {
                    return Column(
                      children: [
                        Transform.scale(
                          scale: _logoScale.value,
                          child: Opacity(
                            opacity: _logoOpacity.value,
                            child: SvgPicture.asset('assets/images/node_84_3328.svg', width: 260),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SlideTransition(
                          position: _subtextOffset,
                          child: Opacity(
                            opacity: _subtextOpacity.value,
                            child: const Text(
                              'Ваша безопасность.\nНаша миссия.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                
                const Spacer(flex: 4),
                
                // Button
                AnimatedBuilder(
                  animation: _buttonOpacity,
                  builder: (context, child) {
                    return IgnorePointer(
                      ignoring: _buttonOpacity.value == 0,
                      child: Opacity(
                        opacity: _buttonOpacity.value,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 48.0),
                          child: InkWell(
                            onTap: () => context.go('/welcome'),
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              width: 280,
                              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                              decoration: BoxDecoration(
                                color: const Color(0xFF132A1C).withValues(alpha: 0.8), 
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: const Color(0xFF2E5B3F).withValues(alpha: 0.5), width: 1.5), 
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      'Начать проверку',
                                      style: TextStyle(
                                        fontFamily: 'GoogleSans', 
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right, 
                                    color: Colors.white54,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Loading line at the very bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _introController,
              builder: (context, child) {
                if (_loadingOpacity.value == 0) return const SizedBox.shrink();
                return Opacity(
                  opacity: _loadingOpacity.value,
                  child: LinearProgressIndicator(
                    value: _loadingProgress.value,
                    backgroundColor: const Color(0xFF060E11),
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorGreen),
                    minHeight: 2.0,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
}

class CirclesPainter extends CustomPainter {
  final double progress;
  final Color baseColor;

  CirclesPainter({required this.progress, required this.baseColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    // Radii matching diameters: 205, 277, 349, 421
    final diameters = [205.0, 277.0, 349.0, 421.0];
    
    final fillPaint = Paint()
      ..style = PaintingStyle.fill;
      
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (int i = 0; i < diameters.length; i++) {
      double wavePhase = (progress * pi * 2) - (i * 0.6);
      double waveIntensity = (sin(wavePhase) + 1.0) / 2.0;
      double baseOpacity = 1.0 - (i / diameters.length) * 0.5; 
      double finalOpacity = baseOpacity * (0.1 + 0.9 * waveIntensity);
      
      double currentRadius = (diameters[i] / 2) * (1.0 + 0.02 * waveIntensity);
      final rect = Rect.fromCircle(center: center, radius: currentRadius);
      
      // Fill color: hsba(0, 0%, 85%, 0.02)
      fillPaint.color = HSVColor.fromAHSV(0.02 * finalOpacity, 0.0, 0.0, 0.85).toColor();
      canvas.drawCircle(center, currentRadius, fillPaint);
      
      // Border colors: Linear Gradient
      // 1. hsba(0, 0%, 85%, 1)
      // 2. hsba(152, 55%, 62%, 0.18)
      strokePaint.shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          HSVColor.fromAHSV(1.0 * finalOpacity, 0.0, 0.0, 0.85).toColor(),
          HSVColor.fromAHSV(0.18 * finalOpacity, 152.0, 0.55, 0.62).toColor(),
        ],
      ).createShader(rect);
      
      canvas.drawCircle(center, currentRadius, strokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CirclesPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

