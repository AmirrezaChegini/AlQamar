import 'dart:io';

import 'package:al_qamar/di.dart';
import 'package:open_settings_plus/open_settings_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class GetPermission {
  static final OpenSettingsPlusAndroid settingAndroid = locator.get();
  static final OpenSettingsPlusIOS settingIos = locator.get();

  GetPermission._();

  static Future<bool> camera() async {
    PermissionStatus status;

    status = await Permission.camera.request();

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      status = await Permission.camera.request();

      if (status.isGranted) {
        return true;
      } else {
        return false;
      }
    } else {
      if (Platform.isAndroid) {
        settingAndroid.applicationSettings();
      }
      if (Platform.isIOS) {
        settingIos.settings();
      }

      return false;
    }
  }
}
