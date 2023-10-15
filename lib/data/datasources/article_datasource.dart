import 'package:al_qamar/constants/api.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:al_qamar/utils/error_handling/check_exceptions.dart';
import 'package:dio/dio.dart';

abstract class ArticleDatasource {
  Future<List<Article>> getAllArticles();
  Future<List<Article>> getForceArticles();
}

class ArticleRemote implements ArticleDatasource {
  final Dio _dio;
  ArticleRemote(this._dio);

  @override
  Future<List<Article>> getAllArticles() async {
    try {
      Response response = await _dio.get(
        Api.articles,
        options: Options(headers: {'requiredToken': true}),
      );

      List<Article> articleList = response.data['data']['data']
          .map<Article>((e) => Article.fromMapJson(e))
          .toList();

      return articleList;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<List<Article>> getForceArticles() async {
    try {
      Response response = await _dio.get(
        Api.forceArticles,
        options: Options(headers: {'requiredToken': true}),
      );

      List<Article> articleList = response.data['data']
          .map<Article>((e) => Article.fromMapJson(e))
          .toList();

      return articleList;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }
}
