import 'package:flutter/material.dart';

PageRouteBuilder<dynamic> fadePageTran({required Widget child}) {
  return PageRouteBuilder(
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeIn,
        ),
      ),
      child: child,
    ),
    pageBuilder: (context, animation, secondaryAnimation) => child,
  );
}
