import 'package:al_qamar/constants/api.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:al_qamar/utils/error_handling/check_exceptions.dart';
import 'package:dio/dio.dart';

abstract class LiveDatasource {
  Future<Response> getVideo();
  Future<Response> getAudio();
}

class LiveRemote implements LiveDatasource {
  final Dio _dio;

  LiveRemote(this._dio);

  @override
  Future<Response> getAudio() async {
    try {
      Response response = await _dio.get(Api.audio);

      return response;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<Response> getVideo() async {
    try {
      Response response = await _dio.get(Api.video);

      return response;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }
}
