import 'package:al_qamar/bloc/bookmark/bookmark_event.dart';
import 'package:al_qamar/bloc/bookmark/bookmark_state.dart';
import 'package:al_qamar/cubit/bookmark_cubit.dart';
import 'package:al_qamar/data/repositories/bookmark_repository.dart';
import 'package:al_qamar/models/article.dart';
import 'package:bloc/bloc.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final IBookmarkRepository _repository;
  final BookmarkCubit bookmarkCubit;

  BookmarkBloc(this._repository, this.bookmarkCubit)
      : super(InitBookmarkState()) {
    on<GetAllBookmark>((event, emit) {
      emit(InitBookmarkState());
      List<Article> bookmarkList = _repository.getAllBookmarks();

      if (bookmarkList.isEmpty) {
        emit(EmptyBookmarkState());
      } else {
        emit(CompleteBookmarkState(bookmarkList));
      }
    });

    on<AddBookmark>((event, emit) async {
      await _repository.addBookmark(article: event.article);
      bookmarkCubit.isBookmark(event.article);
      add(GetAllBookmark());
    });

    on<Removebookmark>((event, emit) async {
      await _repository.removeBookmark(article: event.article);
      bookmarkCubit.isBookmark(event.article);
      add(GetAllBookmark());
    });
  }
}
