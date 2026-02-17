import 'package:dio/dio.dart';
import 'package:gnome_challenge/core/network/domain/network_client.dart';
import 'package:gnome_challenge/core/network/domain/network_exception.dart';
import 'package:gnome_challenge/core/network/domain/network_request.dart';
import 'package:gnome_challenge/core/network/domain/network_response.dart';

class DioNetworkClient implements NetworkClient {
  DioNetworkClient(this._dio);

  final Dio _dio;

  @override
  Future<NetworkResponse<T>> send<T>(
    NetworkRequest request, {
    NetworkDecoder<T>? decoder,
  }) async {
    try {
      final response = await _dio.request<dynamic>(
        request.path,
        data: request.body,
        queryParameters: request.queryParameters,
        options: Options(
          method: _methodToString(request.method),
          headers: request.headers,
        ),
      );

      final parsedData =
          decoder != null ? decoder(response.data) : response.data as T;

      return NetworkResponse<T>(
        data: parsedData,
        statusCode: response.statusCode,
        headers: Map<String, List<String>>.unmodifiable(response.headers.map),
      );
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  String _methodToString(HttpMethod method) {
    switch (method) {
      case HttpMethod.get:
        return 'GET';
      case HttpMethod.post:
        return 'POST';
      case HttpMethod.put:
        return 'PUT';
      case HttpMethod.patch:
        return 'PATCH';
      case HttpMethod.delete:
        return 'DELETE';
    }
  }

  NetworkException _mapException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkException(
          type: NetworkExceptionType.connectionTimeout,
          message: 'Connection timeout',
          cause: error,
        );
      case DioExceptionType.sendTimeout:
        return NetworkException(
          type: NetworkExceptionType.sendTimeout,
          message: 'Send timeout',
          cause: error,
        );
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          type: NetworkExceptionType.receiveTimeout,
          message: 'Receive timeout',
          cause: error,
        );
      case DioExceptionType.badCertificate:
        return NetworkException(
          type: NetworkExceptionType.badCertificate,
          message: 'Bad certificate',
          cause: error,
        );
      case DioExceptionType.badResponse:
        return NetworkException(
          type: NetworkExceptionType.badResponse,
          message: error.message ?? 'Bad response',
          statusCode: error.response?.statusCode,
          cause: error,
        );
      case DioExceptionType.cancel:
        return NetworkException(
          type: NetworkExceptionType.cancel,
          message: 'Request cancelled',
          cause: error,
        );
      case DioExceptionType.connectionError:
        return NetworkException(
          type: NetworkExceptionType.connectionError,
          message: error.message ?? 'Connection error',
          cause: error,
        );
      case DioExceptionType.unknown:
        return NetworkException(
          type: NetworkExceptionType.unknown,
          message: error.message ?? 'Unknown network error',
          cause: error,
        );
    }
  }
}
