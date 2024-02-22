import 'dart:io';

import 'package:flutter/cupertino.dart';

PageRoute<dynamic> pageRoute({required Widget child}) {
  if (Platform.isIOS) {
    return CupertinoPageRoute(builder: (context) => child);
  } else {
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
}
