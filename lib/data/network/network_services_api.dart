import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../services/app_storage/app_storage.dart';
import '../exceptions/app_exceptions.dart';
import 'base_api_services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NetworkServicesApi extends BaseApiServices {
  @override
  Future getApiService(String url) async {
    dynamic jsonResponse;
    try {
      final token = await _getToken();
      if (token == null) {
        throw FetchDataException("❌ No token found in storage");
      }

      final headers = {"Authorization": "Bearer $token"};

      debugPrint("➡️ GET $url");
      debugPrint("➡️ Headers: $headers");

      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));
      // final response = await http
      //     .get(Uri.parse(url))
      //     .timeout(const Duration(seconds: 10));

      jsonResponse = returnResponse(response);

      return jsonResponse;

    } on SocketException {
      throw NoInternetConnection("No internet connection");
    } on TimeoutException {
      throw RequestTimeOutException("Request timeout");
    } on FetchDataException  {
      throw FetchDataException("Something went wrong");
    } on UnauthorisedException {
      throw UnauthorisedException("Unauthorized - no token");
    } on BadRequestException {
      throw BadRequestException("Invalid credentials");
    } on NotFoundException {
      throw NotFoundException("User not found");
    } on ClientException {
      throw ClientException("Client Error");
    }

  }

  @override
  Future<dynamic> postApiService(String url, dynamic data) async {
    print("Data => $data");
    print("Url => $url");
    dynamic jsonResponse;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));

      jsonResponse = returnResponse(response);

      return jsonResponse;

    } on SocketException {
      throw NoInternetConnection("No internet connection");
    } on TimeoutException {
      throw RequestTimeOutException("Request timeout");
    } on FetchDataException  {
      throw FetchDataException("Something went wrong");
    } on UnauthorisedException {
      throw UnauthorisedException("Unauthorized - no token");
    } on BadRequestException {
      throw BadRequestException("Invalid credentials");
    } on NotFoundException {
      throw NotFoundException("User not found");
    } on ClientException {
      throw ClientException("Client Error");
    }
  }

  @override
  Future<dynamic> deleteApiService(String url) async {
    dynamic jsonResponse;
    try {
      final token = await _getToken();
      if (token == null) {
        throw FetchDataException("❌ No token found in storage");
      }

      final headers = {"Authorization": "Bearer $token"};

      debugPrint("➡️ GET $url");
      debugPrint("➡️ Headers: $headers");

      final response = await http
          .delete(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));

      jsonResponse = returnResponse(response);

      return jsonResponse;
    } on SocketException {
      throw NoInternetConnection("No internet connection");
    } on TimeoutException {
      throw RequestTimeOutException("Request timeout");
    } on FetchDataException  {
      throw FetchDataException("Something went wrong");
    } on UnauthorisedException {
      throw UnauthorisedException("Unauthorized - no token");
    } on BadRequestException {
      throw BadRequestException("Invalid credentials");
    } on NotFoundException {
      throw NotFoundException("User not found");
    } on ClientException {
      throw ClientException("Client Error");
    }
  }

  @override
  Future<dynamic> patchApiService(String url, dynamic data) async {
    dynamic jsonResponse;
    try {
      final token = await _getToken();
      if (token == null) {
        throw FetchDataException("❌ No token found in storage");
      }

      final headers = {"Authorization": "Bearer $token"};

      debugPrint("➡️ GET $url");
      debugPrint("➡️ Headers: $headers");

      final response = await http
          .patch(Uri.parse(url), headers: headers, body: data)
          .timeout(const Duration(seconds: 10));

      jsonResponse = returnResponse(response);

      return jsonResponse;
    } on SocketException {
      throw NoInternetConnection("No internet connection");
    } on TimeoutException {
      throw RequestTimeOutException("Request timeout");
    } on FetchDataException  {
      throw FetchDataException("Something went wrong");
    } on UnauthorisedException {
      throw UnauthorisedException("Unauthorized - no token");
    } on BadRequestException {
      throw BadRequestException("Invalid credentials");
    } on NotFoundException {
      throw NotFoundException("User not found");
    } on ClientException {
      throw ClientException("Client Error");
    }
  }

  @override
  Future<dynamic> putApiService(String url, dynamic data) async {
    dynamic jsonResponse;
    try {
      final token = await _getToken();
      if (token == null) {
        throw FetchDataException("❌ No token found in storage");
      }

      final headers = {"Authorization": "Bearer $token"};

      debugPrint("➡️ GET $url");
      debugPrint("➡️ Headers: $headers");

      final response = await http
          .put(Uri.parse(url), headers: headers, body: data)
          .timeout(const Duration(seconds: 10));

      jsonResponse = returnResponse(response);

      return jsonResponse;
    } on SocketException {
      throw NoInternetConnection("No internet connection");
    } on TimeoutException {
      throw RequestTimeOutException("Request timeout");
    } on FetchDataException  {
      throw FetchDataException("Something went wrong");
    } on UnauthorisedException {
      throw UnauthorisedException("Unauthorized - no token");
    } on BadRequestException {
      throw BadRequestException("Invalid credentials");
    } on NotFoundException {
      throw NotFoundException("User not found");
    } on ClientException {
      throw ClientException("Client Error");
    }
  }

  // TODO: PATCH Multipart (File Upload)
  @override
  Future<dynamic> getPatchMultipartApiResponse(
    String url,
    File file,
    String token,
  ) async {
    try {
      final request = http.MultipartRequest("PATCH", Uri.parse(url));
      request.headers.addAll({"Authorization": "Bearer $token"});

      request.files.add(
        await http.MultipartFile.fromPath("profilePic", file.path),
      );

      debugPrint("➡️ PATCH Multipart $url");
      debugPrint("➡️ File: ${file.path}");

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      return returnResponse(response);
    } on SocketException {
      throw FetchDataException("❌ No Internet Connection");
    }
  }

  // TODO: Helper to get token from storage
  Future<String?> _getToken() async {
    // final prefs = await SharedPreferences.getInstance();
    // return prefs.getString("token");

    // Create storage
    // final storage = FlutterSecureStorage();
    // // Read value
    // // final token = await storage.read(key: "token");
    // return await storage.read(key: "token");
    final token = await AppStorage.getItem('token');
    return token;
  }

  // TODO: HTTP Response
  dynamic returnResponse(http.Response response) {
    final statusCode = response.statusCode;
    final body = response.body.isNotEmpty ? jsonDecode(response.body) : null;

    switch (statusCode) {
      case 200:
      case 201:
        return body ?? {"status": "$statusCode"};
      case 400:
        // 🔹 Throw exception for bad requests (e.g., invalid credentials)
        throw BadRequestException(body?['message'] ?? '');
      case 401:
        throw UnauthorisedException(
          body?['message'] ?? '',
        );
      case 403:
        throw UnauthorisedException(body?['message'] ?? '');
      case 404:
        throw NotFoundException(body?['message'] ?? '');
      case 500:
        throw FetchDataException(body?['message'] ?? '');
      default:
        throw FetchDataException(
          'Error communicating with server: $statusCode',
        );
    }
  }
}
