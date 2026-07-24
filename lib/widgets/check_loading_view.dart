import 'package:flutter/material.dart';

class CheckLoadingView extends StatefulWidget {
  final String label;
  final VoidCallback onComplete;

  const CheckLoadingView({
    super.key,
    required this.label,
    required this.onComplete,
  });

  @override
  State<CheckLoadingView> createState() => _CheckLoadingViewState();
}

class _CheckLoadingViewState extends State<CheckLoadingView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward().then((_) {
      widget.onComplete();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final canvasWidth = sw > 430 ? 430.0 : sw;
    double s(double value) => value * (canvasWidth / 393);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Outer rings
              Container(
                width: s(280),
                height: s(280),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.05), width: 1),
                ),
              ),
              Container(
                width: s(220),
                height: s(220),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
                ),
              ),
              // Inner glowing ring and progress
              Container(
                width: s(160),
                height: s(160),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF060E11),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6EAF91).withOpacity(0.15),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(
                          value: _progressAnimation.value,
                          strokeWidth: s(6),
                          backgroundColor: Colors.white.withOpacity(0.1),
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6EAF91)),
                        ),
                        Center(
                          child: Text(
                            '${(_progressAnimation.value * 100).toInt()}%',
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              fontSize: s(36),
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: s(40)),
          Text(
            widget.label,
            style: TextStyle(
              fontFamily: 'GoogleSans',
              fontSize: s(16),
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
