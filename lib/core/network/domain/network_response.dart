class NetworkResponse<T> {
  const NetworkResponse({
    required this.data,
    required this.statusCode,
    required this.headers,
  });

  final T data;
  final int? statusCode;
  final Map<String, List<String>> headers;
}
