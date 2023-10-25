import 'package:al_qamar/constants/api.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:al_qamar/utils/error_handling/check_exceptions.dart';
import 'package:dio/dio.dart';

abstract class ArticleDatasource {
  Future<Response> getAllArticles();
  Future<Response> getForceArticles();
}

class ArticleRemote implements ArticleDatasource {
  final Dio _dio;
  ArticleRemote(this._dio);

  @override
  Future<Response> getAllArticles() async {
    try {
      Response response = await _dio.get(
        Api.articles,
        options: Options(headers: {'requiredToken': true}),
      );

      return response;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<Response> getForceArticles() async {
    try {
      Response response = await _dio.get(
        Api.forceArticles,
        options: Options(headers: {'requiredToken': true}),
      );

      return response;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }
}
