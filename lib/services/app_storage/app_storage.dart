import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppStorage {
  static final _webStorage = FlutterSecureStorage();

  static Future<void> setItem(String key, String value) async {
    if (kIsWeb) {

      await _webStorage.write(key: key , value: value);
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
    }
  }

  static Future<String?> getItem(String key) async {
    if (kIsWeb) {

      return _webStorage.read(key: key);
    } else {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(key);
    }
  }

  static Future<void> clear() async {
    if (kIsWeb) {
      await _webStorage.deleteAll();
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    }
  }
}
