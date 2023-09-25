import 'package:al_qamar/constants/colors.dart';
import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  const CircleWidget({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding = 0,
    this.shadows,
    this.backgroundColor = AppColors.white,
  });
  final Widget child;
  final double? width;
  final double? height;
  final double padding;
  final List<BoxShadow>? shadows;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        boxShadow: shadows,
      ),
      child: child,
    );
  }
}
