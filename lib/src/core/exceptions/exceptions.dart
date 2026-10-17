/// Thrown by a data source when the (mock) server refuses a request.
class ServerException implements Exception {
  const ServerException([this.message]);

  final String? message;

  @override
  String toString() => 'ServerException: ${message ?? ''}';
}

/// Thrown when the request is understood but the input is wrong — a bad
/// password, an unknown promo code. [code] is what the UI maps to a message.
class ValidationException implements Exception {
  const ValidationException(this.code);

  final String code;

  @override
  String toString() => 'ValidationException: $code';
}

class CacheException implements Exception {
  const CacheException([this.message]);

  final String? message;

  @override
  String toString() => 'CacheException: ${message ?? ''}';
}
