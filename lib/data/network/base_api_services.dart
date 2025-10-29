import 'dart:io';

abstract class BaseApiServices {
  // TODO: fetch data from server
  Future<dynamic> getApiService(String url);
  // TODO: post data to server
  Future<dynamic> postApiService(String url , dynamic data);
  // TODO: update data to server
  Future<dynamic> putApiService(String url , dynamic data);
  // TODO: update data to server
  Future<dynamic> patchApiService(String url , dynamic data);
  // TODO: delete data from server
  Future<dynamic> deleteApiService(String url);

  // ✅ New method for file uploads with PATCH
  Future<dynamic> getPatchMultipartApiResponse(String url, File file, String token);
}