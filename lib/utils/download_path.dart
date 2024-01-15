import 'dart:io';

import 'package:path_provider/path_provider.dart';

class DownloadPath {
  Future<String> getDownloadPath() async {
    if (Platform.isAndroid) {
      return '/storage/emulated/0/Alqamar';
    } else {
      final Directory iosDir = await getApplicationDocumentsDirectory();
      return '${iosDir.path}/Alqamar';
    }
  }
}
