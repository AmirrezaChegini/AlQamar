import 'package:al_qamar/data/datasources/favorite_datasource.dart';
import 'package:al_qamar/models/article.dart';

abstract class IFavoriteRepository {
  List<Article> getAllFavoriteArticles();
  Future<void> addFavorite({required Article article});
  Future<void> removeFavorite({required Article article});
}

class FavoriteRepositoryImpl implements IFavoriteRepository {
  final FavoriteDatasource _datasource;

  FavoriteRepositoryImpl(this._datasource);

  @override
  Future<void> addFavorite({required Article article}) async {
    await _datasource.addFavorite(article: article);
  }

  @override
  List<Article> getAllFavoriteArticles() {
    return _datasource.getAllFavoriteArticles();
  }

  @override
  Future<void> removeFavorite({required Article article}) async {
    await _datasource.removeFavorite(article: article);
  }
}
