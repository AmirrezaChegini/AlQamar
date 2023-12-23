import 'package:al_qamar/bloc/favorite/favorite_event.dart';
import 'package:al_qamar/bloc/favorite/favorite_state.dart';
import 'package:al_qamar/data/repositories/favorite_repository.dart';
import 'package:al_qamar/models/article.dart';
import 'package:bloc/bloc.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final IFavoriteRepository _repository;

  FavoriteBloc(this._repository) : super(InitFavoriteState()) {
    on<GetFavorite>((event, emit) {
      List<Article> favoriteList = _repository.getAllFavoriteArticles();

      List<Article> findFavorite =
          favoriteList.where((e) => e.id == event.article.id).toList();

      if (findFavorite.isEmpty) {
        emit(FalseFavoriteState());
      } else {
        emit(TrueFavoriteState());
      }
    });

    on<AddFavorite>((event, emit) async {
      await _repository.addFavorite(article: event.article);
      add(GetFavorite(event.article));
    });

    on<RemoveFavorite>((event, emit) async {
      await _repository.removeFavorite(article: event.article);
      add(GetFavorite(event.article));
    });
  }
}
