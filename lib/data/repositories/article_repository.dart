import 'package:al_qamar/data/datasources/article_datasource.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:dartz/dartz.dart';

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
      List<Article> articleList = await _datasource.getAllArticles();
      return right(articleList);
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }

  @override
  Future<Either<String, List<Article>>> getForceArticles() async {
    try {
      List<Article> articleList = await _datasource.getForceArticles();
      return right(articleList);
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }
}
