import 'package:al_qamar/constants/api.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:al_qamar/utils/error_handling/check_exceptions.dart';
import 'package:al_qamar/utils/extensions/datetime.dart';
import 'package:dio/dio.dart';

abstract class CalenderDatasource {
  Future<Response> getAllCalender({required DateTime day});
}

class CalenderRemote implements CalenderDatasource {
  final Dio _dio;
  CalenderRemote(this._dio);

  @override
  Future<Response> getAllCalender({required DateTime day}) async {
    try {
      return await _dio.get(
        Api.calender,
        options: Options(headers: {'requiredToken': true}),
        queryParameters: {
          'filter': '(choosingDate~"${day.getFormatDate()}")',
        },
      );
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }
}
