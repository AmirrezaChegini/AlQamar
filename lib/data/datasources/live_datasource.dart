import 'package:al_qamar/constants/api.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:al_qamar/utils/error_handling/check_exceptions.dart';
import 'package:dio/dio.dart';

abstract class LiveDatasource {
  Future<Response> getLive();
  Future<Response> getprogram();
}

class LiveRemote implements LiveDatasource {
  final Dio _dio;

  LiveRemote(this._dio);

  @override
  Future<Response> getLive() async {
    try {
      return await _dio.get(Api.live);
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<Response> getprogram() async {
    try {
      return await _dio.get(
        Api.program,
        queryParameters: {'expand': 'live, program'},
      );
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }
}
