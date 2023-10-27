import 'package:al_qamar/constants/api.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:al_qamar/utils/error_handling/check_exceptions.dart';
import 'package:dio/dio.dart';

abstract class CalenderDatasource {
  Future<Response> getCalender({required String day});
}

class CalenderRemote implements CalenderDatasource {
  final Dio _dio;
  CalenderRemote(this._dio);

  @override
  Future<Response> getCalender({required String day}) async {
    try {
      Response response = await _dio.post(
        Api.calender,
        options: Options(headers: {'requiredToken': true}),
        data: {'day': day},
      );

      return response;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }
}
