import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return icon.contains('svg')
        ? SvgPicture.asset(
            icon,
            // ignore: deprecated_member_use
            color: color,
            width: width,
            height: height,
            matchTextDirection: matchDirection,
          )
        : Image.asset(
            icon,
            color: color,
            width: width,
            height: height,
            matchTextDirection: matchDirection,
          );
  }
}
