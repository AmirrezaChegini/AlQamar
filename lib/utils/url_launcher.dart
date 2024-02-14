import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  UrlLauncher._();

  static Future<void> launch(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
