import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizeError {
  static String getError(String error, BuildContext context) {
    switch (error) {
      case 'noInternetConnection':
        return AppLocalizations.of(context)!.noInternetConnection;
      default:
        return '';
    }
  }
}
