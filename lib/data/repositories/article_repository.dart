import 'package:al_qamar/data/datasources/article_datasource.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class IArticelRepository {
  Future<Either<String, List<Article>>> getAllArticles();
  Future<Either<String, List<Article>>> getForceArticles();
}

class ArticleRepositoryImple implements IArticelRepository {
  final ArticleDatasource _datasource;
  ArticleRepositoryImple(this._datasource);

  @override
  Future<Either<String, List<Article>>> getAllArticles() async {
    try {
      Response response = await _datasource.getAllArticles();
      return right(await compute(_articleList, response));
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }

  @override
  Future<Either<String, List<Article>>> getForceArticles() async {
    try {
      Response response = await _datasource.getForceArticles();
      return right(await compute(_articleList, response));
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }
}

List<Article> _articleList(Response response) {
  List<Article> articleList = response.data['data']['data']
      .map<Article>((e) => Article.fromMapJson(e))
      .toList();

  return articleList;
}
