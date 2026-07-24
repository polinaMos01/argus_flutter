import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GreenRoundedIcon extends StatelessWidget {
  final IconData? icon;
  final String? svgPath;
  final double size;
  final double padding;

  const GreenRoundedIcon({
    super.key,
    this.icon,
    this.svgPath,
    this.size = 20,
    this.padding = 10,
  }) : assert(icon != null || svgPath != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size + (padding * 2),
      height: size + (padding * 2),
      decoration: BoxDecoration(
        color: const Color(0xFF132A1C),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: svgPath != null
            ? SvgPicture.asset(
                svgPath!,
                width: size,
                height: size,
                colorFilter: const ColorFilter.mode(Color(0xFF6EAF91), BlendMode.srcIn),
              )
            : Icon(
                icon,
                color: const Color(0xFF6EAF91),
                size: size,
              ),
      ),
    );
  }
}
