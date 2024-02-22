import 'package:al_qamar/models/article.dart';

sealed class FavoriteEvent {}

class GetFavorite extends FavoriteEvent {
  final Article article;
  GetFavorite(this.article);
}

class AddFavorite extends FavoriteEvent {
  final Article article;
  AddFavorite(this.article);
}

class RemoveFavorite extends FavoriteEvent {
  final Article article;
  RemoveFavorite(this.article);
}
