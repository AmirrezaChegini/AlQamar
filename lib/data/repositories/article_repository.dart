import 'package:al_qamar/data/datasources/article_datasource.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class IArticelRepository {
  Future<Either<String, List<Article>>> getAllArticles({required int page});
  Future<Either<String, List<Article>>> getForceArticles();
  Future<Either<String, List<Article>>> getLastArticles();
  Future<Either<String, Article>> getArticle({required int articleID});
  Future<Either<String, List<Article>>> searchArticles(
      {required String searchText});
  Future<Either<String, List<Article>>> getArticleByCategory(
      {required int categoryId});
}

class ArticleRepositoryImple implements IArticelRepository {
  final ArticleDatasource _datasource;
  ArticleRepositoryImple(this._datasource);

  @override
  Future<Either<String, List<Article>>> getAllArticles(
      {required int page}) async {
    try {
      Response response = await _datasource.getAllArticles(page: page);
      return right(await compute(_allArticleList, response));
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

  @override
  Future<Either<String, Article>> getArticle({required int articleID}) async {
    try {
      Response response = await _datasource.getArticle(articleID: articleID);
      return right(await compute(_article, response));
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }

  @override
  Future<Either<String, List<Article>>> getLastArticles() async {
    try {
      Response response = await _datasource.getLastArticles();
      return right(await compute(_articleList, response));
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }

  @override
  Future<Either<String, List<Article>>> searchArticles(
      {required String searchText}) async {
    try {
      Response response =
          await _datasource.searchArticles(searchText: searchText);
      return right(await compute(_articleList, response));
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }

  @override
  Future<Either<String, List<Article>>> getArticleByCategory(
      {required int categoryId}) async {
    try {
      Response response =
          await _datasource.getArticleByCategory(categoryId: categoryId);
      return right(await compute(_articleListByCategory, response));
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }
}

List<Article> _articleListByCategory(Response response) {
  List<Article> articleList = response.data['data']['articles']['data']
      .map<Article>((e) => Article.fromMapJson(e))
      .toList();

  return articleList;
}

List<Article> _articleList(Response response) {
  List<Article> articleList = response.data['data']
      .map<Article>((e) => Article.fromMapJson(e))
      .toList();

  return articleList;
}

List<Article> _allArticleList(Response response) {
  List<Article> articleList = response.data['data']['data']
      .map<Article>((e) => Article.fromMapJson(e))
      .toList();

  return articleList;
}

Article _article(Response response) {
  Article article = Article.fromMapJson(response.data['data']);
  return article;
}
