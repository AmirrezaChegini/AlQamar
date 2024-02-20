import 'package:al_qamar/data/datasources/article_datasource.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class IArticelRepository {
  Future<ApiModel<List<Article>, String>> getAllArticles({required int page});
  Future<ApiModel<List<Article>, String>> getForceArticles();
  Future<ApiModel<List<Article>, String>> getLastArticles();
  Future<ApiModel<Article, String>> getArticle({required int articleID});
  Future<ApiModel<List<Article>, String>> searchArticles(
      {required String searchText});
  Future<ApiModel<List<Article>, String>> getArticleByCategory({
    required int categoryId,
    required int page,
  });
}

class ArticleRepositoryImple implements IArticelRepository {
  final ArticleDatasource _datasource;
  ArticleRepositoryImple(this._datasource);

  @override
  Future<ApiModel<List<Article>, String>> getAllArticles(
      {required int page}) async {
    try {
      Response response = await _datasource.getAllArticles(page: page);
      return ApiModel.success(await compute(_allArticleList, response));
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }

  @override
  Future<ApiModel<List<Article>, String>> getForceArticles() async {
    try {
      Response response = await _datasource.getForceArticles();
      return ApiModel.success(await compute(_articleList, response));
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }

  @override
  Future<ApiModel<Article, String>> getArticle({required int articleID}) async {
    try {
      Response response = await _datasource.getArticle(articleID: articleID);
      return ApiModel.success(await compute(_article, response));
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }

  @override
  Future<ApiModel<List<Article>, String>> getLastArticles() async {
    try {
      Response response = await _datasource.getLastArticles();
      return ApiModel.success(await compute(_articleList, response));
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }

  @override
  Future<ApiModel<List<Article>, String>> searchArticles(
      {required String searchText}) async {
    try {
      Response response =
          await _datasource.searchArticles(searchText: searchText);
      return ApiModel.success(await compute(_articleList, response));
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }

  @override
  Future<ApiModel<List<Article>, String>> getArticleByCategory({
    required int categoryId,
    required int page,
  }) async {
    try {
      Response response = await _datasource.getArticleByCategory(
          categoryId: categoryId, page: page);
      return ApiModel.success(await compute(_articleListByCategory, response));
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
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
