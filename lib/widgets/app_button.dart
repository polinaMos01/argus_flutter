import 'dart:ui';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double? height;
  final double? width;

  const AppButton({
    super.key,
    required this.text,
    required this.onTap,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(31 * s),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6.85, sigmaY: 6.85),
          child: Container(
            height: height ?? (54 * s),
            width: width ?? double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(62, 114, 97, 0.28),
              borderRadius: BorderRadius.circular(31 * s),
              border: Border.all(color: const Color(0xFF6EAF91).withOpacity(0.12), width: 1.0),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF194832).withOpacity(0.1),
                  blurRadius: 10 * s,
                  offset: Offset(0, 4 * s),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'GoogleSans',
                color: Colors.white,
                fontSize: 16 * s,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.32,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
