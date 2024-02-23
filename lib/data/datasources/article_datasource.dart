import 'package:al_qamar/constants/api.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:al_qamar/utils/error_handling/check_exceptions.dart';
import 'package:dio/dio.dart';

abstract class ArticleDatasource {
  Future<Response> getAllArticles({required int page});
  Future<Response> getForceArticles();
  Future<Response> getArticle({required String articleID});
  Future<Response> searchArticles({required String searchText});
  Future<Response> getArticleByCategory({
    required String categoryId,
    required int page,
  });
  Future<Response> getArticleByWriter({
    required String writerID,
    required int page,
  });
}

class ArticleRemote implements ArticleDatasource {
  final Dio _dio;
  ArticleRemote(this._dio);

  @override
  Future<Response> getAllArticles({required int page}) async {
    try {
      return await _dio.get(
        Api.articles,
        queryParameters: {
          'sort': '-created',
          'expand': 'writerID',
          'perPage': Api.perPage,
          'page': page,
        },
      );
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<Response> getForceArticles() async {
    try {
      return await _dio.get(Api.forceArticles);
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<Response> getArticle({required String articleID}) async {
    try {
      return await _dio.get(
        '${Api.articles}/$articleID',
        queryParameters: {'expand': 'writerID'},
      );
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<Response> searchArticles({required String searchText}) async {
    try {
      return await _dio.get(
        Api.articles,
        queryParameters: {
          'sort': '-created',
          'expand': 'writerID',
          'perPage': 20,
          'page': 1,
          'filter': '(content~"$searchText" || title~"$searchText")',
        },
      );
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<Response> getArticleByCategory({
    required String categoryId,
    required int page,
  }) async {
    try {
      return await _dio.get(
        Api.articles,
        queryParameters: {
          'sort': '-created',
          'expand': 'writerID',
          'perPage': Api.perPage,
          'page': page,
          'filter': '(categoryID="$categoryId")',
        },
      );
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<Response> getArticleByWriter({
    required String writerID,
    required int page,
  }) async {
    try {
      return await _dio.get(
        Api.articles,
        queryParameters: {
          'sort': '-created',
          'expand': 'writerID',
          'perPage': Api.perPage,
          'page': page,
          'filter': '(categoryID="$writerID")',
        },
      );
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }
}
