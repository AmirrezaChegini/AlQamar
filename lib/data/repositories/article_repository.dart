import 'package:al_qamar/data/datasources/article_datasource.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/models/force_article.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class IArticelRepository {
  Future<ApiModel<List<Article>, String>> getAllArticles({required int page});
  Future<ApiModel<List<ForceArticle>, String>> getForceArticles();
  Future<ApiModel<Article, String>> getArticle({required String articleID});
  Future<ApiModel<List<Article>, String>> searchArticles(
      {required String searchText});
  Future<ApiModel<List<Article>, String>> getArticleByCategory({
    required String categoryId,
    required int page,
  });
  Future<ApiModel<List<Article>, String>> getArticleByWriter({
    required String writerID,
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
      return ApiModel.success(
        await compute(
          _articles,
          await _datasource.getAllArticles(page: page),
        ),
      );
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }

  @override
  Future<ApiModel<List<ForceArticle>, String>> getForceArticles() async {
    try {
      return ApiModel.success(
        await compute(
          _forceArticles,
          await _datasource.getForceArticles(),
        ),
      );
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }

  @override
  Future<ApiModel<Article, String>> getArticle(
      {required String articleID}) async {
    try {
      return ApiModel.success(
        await compute(
          _article,
          await _datasource.getArticle(articleID: articleID),
        ),
      );
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }

  @override
  Future<ApiModel<List<Article>, String>> searchArticles(
      {required String searchText}) async {
    try {
      return ApiModel.success(
        await compute(
          _articles,
          await _datasource.searchArticles(searchText: searchText),
        ),
      );
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }

  @override
  Future<ApiModel<List<Article>, String>> getArticleByCategory({
    required String categoryId,
    required int page,
  }) async {
    try {
      return ApiModel.success(
        await compute(
          _articles,
          await _datasource.getArticleByCategory(
            categoryId: categoryId,
            page: page,
          ),
        ),
      );
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }

  @override
  Future<ApiModel<List<Article>, String>> getArticleByWriter(
      {required String writerID, required int page}) async {
    try {
      return ApiModel.success(
        await compute(
          _articles,
          await _datasource.getArticleByCategory(
            categoryId: writerID,
            page: page,
          ),
        ),
      );
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }
}

List<Article> _articles(Response response) {
  return response.data['items']
      .map<Article>((e) => Article.fromMapJson(e))
      .toList();
}

List<ForceArticle> _forceArticles(Response response) {
  return response.data['items']
      .map<ForceArticle>((e) => ForceArticle.fromMapJson(e))
      .toList();
}

Article _article(Response response) {
  return Article.fromMapJson(response.data);
}
