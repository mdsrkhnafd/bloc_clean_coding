class AppException implements Exception {
  final String? message;
  final String? prefix;

  AppException([this.message, this.prefix]);

  @override
  String toString() {
    if (message != null  && prefix != null) {
      return "$prefix: $message";
    } else if (prefix != null) {
      return "$prefix";
    } else if (message != null) {
      return "$message";
    } else {
      return "Something went wrong";
    }
  }
}

class NoInternetConnection extends AppException {
  NoInternetConnection([String? message])
      : super(message, "No Internet Connection");
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, "Fetch Data Error");
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, "Bad Request");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message])
      : super(message, "Unauthorized");
}

class RequestTimeOutException extends AppException {
  RequestTimeOutException([String? message])
      : super(message, "Request Timeout");
}

class ServerException extends AppException {
  ServerException([String? message]) : super(message, "Server Error");
}

class CacheException extends AppException {
  CacheException([String? message]) : super(message, "Cache Error");
}

class NotFoundException extends AppException {
  NotFoundException([String? message]) : super(message, "Not Found");
}

class ClientException extends AppException {
  ClientException([String? message]) : super(message, "Client Error");
}
