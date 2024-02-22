import 'package:al_qamar/data/repositories/bookmark_repository.dart';
import 'package:al_qamar/models/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkCubit extends Cubit<bool> {
  final IBookmarkRepository _repository;

  BookmarkCubit(this._repository) : super(false);

  void isBookmark(Article article) {
    List<Article> findBookmark =
        _repository.getAllBookmarks().where((e) => e.id == article.id).toList();

    findBookmark.isNotEmpty ? emit(true) : emit(false);
  }
}
