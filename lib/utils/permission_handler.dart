import 'package:permission_handler/permission_handler.dart';

Future<bool> storagePermission() async {
  if (await Permission.manageExternalStorage.request().isDenied) {
    if (await Permission.manageExternalStorage.request().isPermanentlyDenied) {
      return false;
    } else {
      return true;
    }
  } else {
    return true;
  }
}
