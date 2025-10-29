import 'dart:io';
import 'package:flutter/foundation.dart';

class AppUrl {
  static const String pcIp = "localhost"; // Your PC LAN IP
  static const String port = "3000";

  static String get apiBaseUrl {
    if (kIsWeb) {
      return "http://$pcIp:$port/api/";
    } else if (Platform.isAndroid) {
      return defaultTargetPlatform == TargetPlatform.android
          ? "http://10.0.2.2:$port/api/" // Emulator http://10.0.2.2:3000/api/auth/login
          : "http://$pcIp:$port/api/";  // Physical device
    } else {
      return "http://$pcIp:$port/api/";  // iOS or others
    }
  }

  static String get socketBaseUrl {
    if (kIsWeb) {
      return "http://$pcIp:$port/";
    } else if (Platform.isAndroid) {
      return defaultTargetPlatform == TargetPlatform.android
          ? "http://10.0.2.2:$port/" // Emulator
          : "http://$pcIp:$port/";   // Physical device
    } else {
      return "http://$pcIp:$port/";
    }
  }

  // Auth Endpoints
  static  String signupEndPoint = '${apiBaseUrl}auth/signup';
  static String loginEndPoint = '${apiBaseUrl}auth/login';
  static String  logoutEndPoint = '${apiBaseUrl}auth/logout';
  static String updateProfileEndPoint = '${apiBaseUrl}auth/update-profile';
  static String checkLoginEndPoint = '${apiBaseUrl}auth/check-auth';

  // Movies Endpoints
  static String fetchMoviesEndPoint = 'https://www.episodate.com/api/most-popular?page=1';
}
