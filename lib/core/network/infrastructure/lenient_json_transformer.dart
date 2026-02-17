import 'dart:convert';

import 'package:dio/dio.dart';

class LenientJsonTransformer extends FusedTransformer {
  @override
  Future<dynamic> transformResponse(
    RequestOptions options,
    ResponseBody responseBody,
  ) async {
    final transformed = await super.transformResponse(options, responseBody);

    if (options.responseType == ResponseType.json &&
        transformed is String &&
        transformed.isNotEmpty) {
      try {
        return jsonDecode(transformed);
      } on FormatException {
        return transformed;
      }
    }

    return transformed;
  }
}
