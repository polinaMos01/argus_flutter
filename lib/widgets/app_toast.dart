import 'dart:ui';
import 'package:flutter/material.dart';

void showAppToast(BuildContext context, String message, {bool isError = false}) {
  final double screenWidth = MediaQuery.of(context).size.width;
  final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
  final double s = canvasWidth / 393.0;

  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      margin: EdgeInsets.only(
        bottom: 110 * s, // Positioned floating ABOVE the bottom navigation toolbar
        left: 20 * s,
        right: 20 * s,
      ),
      duration: const Duration(seconds: 3),
      content: ClipRRect(
        borderRadius: BorderRadius.circular(16 * s),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16 * s, vertical: 14 * s),
            decoration: BoxDecoration(
              color: isError
                  ? const Color(0xFFB21010).withOpacity(0.25)
                  : const Color(0xFF6EAF91).withOpacity(0.20),
              borderRadius: BorderRadius.circular(16 * s),
              border: Border.all(
                color: isError
                    ? const Color(0xFFFF4B4B).withOpacity(0.45)
                    : const Color(0xFF6EAF91).withOpacity(0.45),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 32 * s,
                  height: 32 * s,
                  decoration: BoxDecoration(
                    color: isError
                        ? const Color(0xFFFF4B4B).withOpacity(0.2)
                        : const Color(0xFF6EAF91).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isError ? Icons.error_outline : Icons.check_circle_outline,
                    color: isError ? const Color(0xFFFF4B4B) : const Color(0xFF6EAF91),
                    size: 20 * s,
                  ),
                ),
                SizedBox(width: 12 * s),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: Colors.white,
                      fontSize: 14 * s,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
