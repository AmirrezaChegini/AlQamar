import 'package:al_qamar/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static final SharedPreferences _sharedPref = locator.get();

  static Future<void> saveString({required key, required String value}) async {
    await _sharedPref.setString(key, value);
  }

  static String getString({required String key}) {
    return _sharedPref.getString(key) ?? '';
  }

  static void clearAll() async {
    await _sharedPref.clear();
  }

  static void removeKey({required String key}) async {
    await _sharedPref.remove(key);
  }

  static bool isLoggedIn() {
    return getString(key: 'token').isEmpty ? false : true;
  }
}
