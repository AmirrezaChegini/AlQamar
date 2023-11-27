import 'package:al_qamar/constants/api.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:al_qamar/utils/error_handling/check_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

abstract class AzanDatasource {
  Future<Response> getAzanTime({
    required String city,
    required String country,
    required int method,
    required int midnightMode,
    required String tune,
  });
}

class AzanRemote implements AzanDatasource {
  final Dio _dio;
  AzanRemote(this._dio);

  @override
  Future<Response> getAzanTime({
    required String city,
    required String country,
    required int method,
    required int midnightMode,
    required String tune,
  }) async {
    try {
      Response response = await _dio.get(
        '${Api.azan}/${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
        queryParameters: {
          'city': city,
          'country': country,
          'method': method,
          'midnightMode': midnightMode,
          'tune': tune,
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
