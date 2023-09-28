import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon({
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
    return SvgPicture.asset(
      icon,
      // ignore: deprecated_member_use
      color: color,
      width: width,
      height: height,
      matchTextDirection: matchDirection,
    );
  }
}
