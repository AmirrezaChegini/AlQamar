import 'package:al_qamar/constants/api.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:al_qamar/utils/error_handling/check_exceptions.dart';
import 'package:dio/dio.dart';

abstract class CategoryDatasource {
  Future<Response> getAllCategories();
}

class CategoryRemote implements CategoryDatasource {
  final Dio _dio;
  CategoryRemote(this._dio);

  @override
  Future<Response> getAllCategories() async {
    try {
      Response response = await _dio.get(Api.category);

      return response;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }
}
