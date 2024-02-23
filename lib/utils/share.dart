import 'package:share_plus/share_plus.dart';

class ShareData {
  ShareData._();
  static Future<void> shareText(String text) async {
    await Share.share(text);
  }
}
