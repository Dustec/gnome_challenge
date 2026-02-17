enum NetworkExceptionType {
  connectionTimeout,
  sendTimeout,
  receiveTimeout,
  badCertificate,
  badResponse,
  cancel,
  connectionError,
  unknown,
}

class NetworkException implements Exception {
  const NetworkException({
    required this.type,
    required this.message,
    this.statusCode,
    this.cause,
  });

  final NetworkExceptionType type;
  final String message;
  final int? statusCode;
  final Object? cause;

  @override
  String toString() {
    return 'NetworkException(type: $type, statusCode: $statusCode, message: $message)';
  }
}
