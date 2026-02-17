import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnome_challenge/core/config/app_env.dart';
import 'package:gnome_challenge/core/network/domain/network_client.dart';
import 'package:gnome_challenge/core/network/infrastructure/dio_network_client.dart';

final baseUrlProvider = Provider<String>((ref) {
  return AppEnv.gnomesDataUrl;
});

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ref.watch(baseUrlProvider),
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ),
  );

  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }

  return dio;
});

final networkClientProvider = Provider<NetworkClient>((ref) {
  return DioNetworkClient(ref.watch(dioProvider));
});
