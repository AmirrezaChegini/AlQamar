import 'package:al_qamar/di.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static final FlutterSecureStorage _storage = locator.get();
  Storage._();

  static Future<void> saveString({required key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String> getString({required String key}) async {
    return await _storage.read(key: key) ?? '';
  }

  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  static Future<void> removeKey({required String key}) async {
    await _storage.delete(key: key);
  }

  static Future<bool> isLoggedIn() async {
    return await getString(key: 'token').then((value) => value.isNotEmpty);
  }
}
