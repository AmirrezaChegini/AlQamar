import 'package:al_qamar/data/datasources/bookmark_datasource.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class IBookmarkRepository {
  Future<Either<String, String>> addBookmark({required int articleID});
  Future<Either<String, String>> removeBookmark({required int articleID});
  Future<Either<String, List<Article>>> getBookmarks();
}

class BookmarkRepositoryImpl implements IBookmarkRepository {
  final BookmarkDatasource _datasource;
  BookmarkRepositoryImpl(this._datasource);

  @override
  Future<Either<String, String>> addBookmark({required int articleID}) async {
    try {
      Response response = await _datasource.addBookmark(articleID: articleID);

      return right(response.data['message']);
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }

  @override
  Future<Either<String, List<Article>>> getBookmarks() async {
    try {
      Response response = await _datasource.getBookmarks();

      return right(await compute(_articleList, response));
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }

  @override
  Future<Either<String, String>> removeBookmark(
      {required int articleID}) async {
    try {
      Response response =
          await _datasource.removeBookmark(articleID: articleID);

      return right(response.data['message']);
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }
}

List<Article> _articleList(Response response) {
  List<Article> articleList = response.data['data']
      .map<Article>((e) => Article.fromMapJson(e))
      .toList();

  return articleList;
}
