import 'package:al_qamar/utils/storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AppInterceptors implements Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers['requiredToken'] != null &&
        options.headers['requiredToken']) {
      options.headers['Authorization'] =
          'Bearer ${await Storage.getString(key: 'token')}';
    }
    options.headers['Accept'] = 'application/json';
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print(response);
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print(err);
    }
    handler.next(err);
  }
}
