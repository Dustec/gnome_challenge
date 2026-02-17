import 'package:gnome_challenge/core/network/domain/network_request.dart';
import 'package:gnome_challenge/core/network/domain/network_response.dart';

typedef NetworkDecoder<T> = T Function(dynamic rawData);

abstract class NetworkClient {
  Future<NetworkResponse<T>> send<T>(
    NetworkRequest request, {
    NetworkDecoder<T>? decoder,
  });
}
