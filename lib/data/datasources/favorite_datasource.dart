import 'package:al_qamar/models/article.dart';
import 'package:hive/hive.dart';

abstract class FavoriteDatasource {
  List<Article> getAllFavoriteArticles();
  Future<void> addFavorite({required Article article});
  Future<void> removeFavorite({required Article article});
}

class FavoriteLocal implements FavoriteDatasource {
  final Box<Article> favoriteBox = Hive.box<Article>('favoriteBox');

  @override
  Future<void> addFavorite({required Article article}) async {
    await favoriteBox.put(article.id, article);
  }

  @override
  List<Article> getAllFavoriteArticles() {
    return favoriteBox.values.toList();
  }

  @override
  Future<void> removeFavorite({required Article article}) async {
    await favoriteBox.delete(article.id);
  }
}
