// splash_services.dart
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/routes/routes_name.dart';
import '../app_storage/app_storage.dart';

class SplashServices {
  Future<void> checkLogin(BuildContext context) async {
    // Wait 3 seconds for splash effect
    await Future.delayed(const Duration(seconds: 3));

    if (!context.mounted) return; // Ensure widget is still in the tree

    // final prefs = await SharedPreferences.getInstance();
    // final token = prefs.getString('token');

    // Create storage
    // final storage = FlutterSecureStorage();
    // final token = await storage.read(key: "token");

    final token = await AppStorage.getItem('token');

    if (token != null && token.isNotEmpty) {
      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.homeScreen, (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.loginScreen, (route) => false);
    }
  }
}
