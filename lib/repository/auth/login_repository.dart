import 'package:bloc_clean_coding/models/user/user_model.dart';
import 'package:bloc_clean_coding/res/app_url.dart';
import 'package:flutter/material.dart';

import '../../data/network/network_services_api.dart';

class LoginRepository {
  final NetworkServicesApi _api = NetworkServicesApi();

  Future<dynamic> loginApiService(dynamic data) async {
    try {
      dynamic response = await _api.postApiService(AppUrl.loginEndPoint, data);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> logoutApiService() async {
    try {
      dynamic response = await _api.postApiService(AppUrl.logoutEndPoint , null);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> checkLoginApiService() async {
    try {
      final response = await _api.getApiService(AppUrl.checkLoginEndPoint);

      // 🧠 Check and log response data
      if (response != null) {
        debugPrint("✅ checkLoginApiService → Response: $response");
      } else {
        debugPrint("⚠️ checkLoginApiService → No response or null data received");
      }

      return response;
    } catch (e) {
      debugPrint("❌ checkLoginApiService → Error: $e");
      rethrow;
    }
  }

}
