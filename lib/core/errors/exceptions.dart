class ServerException implements Exception {
  const ServerException([this.message = 'Server error']);

  final String message;

  @override
  String toString() => message;
}

class CacheException implements Exception {
  const CacheException([this.message = 'Cache error']);

  final String message;

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  const NetworkException([this.message = 'No network connection']);

  final String message;

  @override
  String toString() => message;
}

class AuthException implements Exception {
  const AuthException([this.message = 'Authentication failed']);

  final String message;

  @override
  String toString() => message;
}
