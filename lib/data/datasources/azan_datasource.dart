import 'package:al_qamar/constants/api.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:al_qamar/utils/error_handling/check_exceptions.dart';
import 'package:dio/dio.dart';

abstract class AzanDatasource {
  Future<Response> getAzanTime({required String city, required String country});
}

class AzanRemote implements AzanDatasource {
  final Dio _dio;
  AzanRemote(this._dio);

  @override
  Future<Response> getAzanTime(
      {required String city, required String country}) async {
    try {
      Response response = await _dio.get(
        '${Api.azan}/${DateTime.now().year}/${DateTime.now().month}',
        queryParameters: {
          'city': city,
          'country': country,
        },
      );

      return response;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }
}
