import 'package:share_plus/share_plus.dart';

class ShareData {
  ShareData._();
  static void share(String text) {
    Share.share(text);
  }
}
