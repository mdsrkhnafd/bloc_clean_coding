import 'package:bloc_clean_coding/models/movies/movies.dart';
import 'package:flutter/material.dart';

import '../../data/network/network_services_api.dart';
import '../../res/app_url.dart';

class MoviesRepository {
  final NetworkServicesApi _api = NetworkServicesApi();

  Future<MoviesModel> fetchMoviesApiService() async {
    try {
      final response = await _api.getApiService(AppUrl.fetchMoviesEndPoint);

      // 🧠 Check and log response data
      if (response != null) {
        debugPrint("✅ fetchMoviesApiService → Response: $response");
      } else {
        debugPrint("⚠️ fetchMoviesApiService → No response or null data received");
      }

      return MoviesModel.fromJson(response);
    } catch (e) {
      debugPrint("❌ fetchMoviesApiService → Error: $e");
      rethrow;
    }
  }
}