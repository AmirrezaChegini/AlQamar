import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    super.key,
    required this.icon,
    this.color,
    this.width,
    this.height,
    this.matchDirection = false,
  });

  final String icon;
  final Color? color;
  final double? width;
  final double? height;
  final bool matchDirection;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      icon,
      color: color,
      width: width,
      height: height,
      matchTextDirection: matchDirection,
    );
  }
}
