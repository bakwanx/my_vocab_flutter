
class ServerException implements Exception {
  String? message;

  ServerException({this.message});
}

class LocalException implements Exception {

  String? message;
  LocalException({this.message});
}

class NetworkException implements Exception {

  String? message;
  NetworkException({this.message});
}

class PermissionException implements Exception {

  String? message;
  PermissionException({this.message});
}

