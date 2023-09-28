import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon({
    super.key,
    required this.icon,
    this.colorFilter,
    this.width,
    this.height,
    this.matchDirection = true,
  });

  final String icon;
  final ColorFilter? colorFilter;
  final double? width;
  final double? height;
  final bool matchDirection;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      colorFilter: colorFilter,
      width: width,
      height: height,
      matchTextDirection: matchDirection,
    );
  }
}
