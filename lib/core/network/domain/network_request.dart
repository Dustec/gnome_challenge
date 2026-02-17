enum HttpMethod { get, post, put, patch, delete }

class NetworkRequest {
  const NetworkRequest({
    required this.path,
    required this.method,
    this.queryParameters,
    this.body,
    this.headers,
  });

  const NetworkRequest.get(
    this.path, {
    this.queryParameters,
    this.headers,
  })  : method = HttpMethod.get,
        body = null;

  const NetworkRequest.post(
    this.path, {
    this.queryParameters,
    this.body,
    this.headers,
  }) : method = HttpMethod.post;

  const NetworkRequest.put(
    this.path, {
    this.queryParameters,
    this.body,
    this.headers,
  }) : method = HttpMethod.put;

  const NetworkRequest.patch(
    this.path, {
    this.queryParameters,
    this.body,
    this.headers,
  }) : method = HttpMethod.patch;

  const NetworkRequest.delete(
    this.path, {
    this.queryParameters,
    this.body,
    this.headers,
  }) : method = HttpMethod.delete;

  final String path;
  final HttpMethod method;
  final Map<String, dynamic>? queryParameters;
  final Object? body;
  final Map<String, String>? headers;
}
