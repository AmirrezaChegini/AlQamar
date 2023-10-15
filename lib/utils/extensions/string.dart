import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension StringExt on String {
  String getPureTime() {
    String time = this;
    return time.substring(0, time.indexOf(' '));
  }

  String localizeError(BuildContext context) {
    String error = this;
    switch (error) {
      case 'noInternetConnection':
        return AppLocalizations.of(context)!.noInternetConnection;
      default:
        return '';
    }
  }
}
