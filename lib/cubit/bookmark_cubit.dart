import 'package:al_qamar/data/repositories/bookmark_repository.dart';
import 'package:al_qamar/models/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkCubit extends Cubit<bool> {
  final IBookmarkRepository _repository;

  BookmarkCubit(this._repository) : super(false);

  bool bookmark = false;

  void isBookmarked(int articleID) async {
    var either = await _repository.getBookmarks();

    either.fold((l) {}, (r) {
      List<Article> article = r.where((e) => e.id == articleID).toList();

      if (article.isNotEmpty) {
        bookmark = true;
        emit(bookmark);
      } else {
        bookmark = false;
        emit(bookmark);
      }
    });
  }

  void changeBookmark() {
    bookmark = !bookmark;
    emit(bookmark);
  }
}
