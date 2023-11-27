import 'package:flutter/material.dart';

class CheckDirect {
  CheckDirect._();

  static bool isRTL(BuildContext context) {
    return TextDirection.rtl == Directionality.of(context);
  }
}
