import 'package:al_qamar/constants/api.dart';
import 'package:share_plus/share_plus.dart';

class ShareData {
  ShareData._();
  static Future<void> shareUrl(int id) async {
    await Share.shareUri(Uri.parse('${Api.baseUrlSite}/$id'));
  }

  static Future<void> shareText(String text) async {
    await Share.share(text);
  }
}
