import 'package:al_qamar/constants/colors.dart';
import 'package:flutter/material.dart';

class CurvedPainter extends CustomPainter {
  CurvedPainter({
    required this.value0,
    required this.value10,
    required this.value70,
  });

  final double value0;
  final double value10;
  final double value70;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.grey200
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;
    Path path = Path()
      ..moveTo(0, 80)
      ..quadraticBezierTo(5, 80, 5, value70)
      ..lineTo(5, value10)
      ..quadraticBezierTo(5, value0, 15, value0)
      ..lineTo(65, value0)
      ..quadraticBezierTo(75, value0, 75, value10)
      ..lineTo(75, value70)
      ..quadraticBezierTo(75, 80, 80, 80)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
