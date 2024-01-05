
class ServerException implements Exception {
  String? message;

  ServerException({this.message});
}

class LocalException implements Exception {}
