import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AppInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print(response);
    }

    handler.next(response);
  }
}
