import 'package:flutter/material.dart';

class CheckDirect {
  static bool isRTL(BuildContext context) {
    return TextDirection.rtl == Directionality.of(context);
  }
}
