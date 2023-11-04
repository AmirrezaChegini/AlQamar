import 'package:al_qamar/constants/api.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:al_qamar/utils/error_handling/check_exceptions.dart';
import 'package:dio/dio.dart';

abstract class ArticleDatasource {
  Future<Response> getAllArticles({required int page});
  Future<Response> getForceArticles();
  Future<Response> getLastArticles();
  Future<Response> getArticle({required int articleID});
  Future<Response> searchArticles({required String searchText});
}

class ArticleRemote implements ArticleDatasource {
  final Dio _dio;
  ArticleRemote(this._dio);

  @override
  Future<Response> getAllArticles({required int page}) async {
    try {
      Response response = await _dio.get(
        Api.articles,
        queryParameters: {'page': page},
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
      Response response = await _dio.get(Api.forceArticles);

      return response;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<Response> getArticle({required int articleID}) async {
    try {
      Response response = await _dio.get('${Api.articles}/$articleID');

      return response;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<Response> getLastArticles() async {
    try {
      Response response = await _dio.get(Api.lastArticles);

      return response;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<Response> searchArticles({required String searchText}) async {
    try {
      Response response = await _dio.get('${Api.searchArticles}/$searchText');

      return response;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }
}
