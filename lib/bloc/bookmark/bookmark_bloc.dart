import 'package:al_qamar/bloc/bookmark/bookmark_event.dart';
import 'package:al_qamar/bloc/bookmark/bookmark_state.dart';
import 'package:al_qamar/data/repositories/bookmark_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final IBookmarkRepository _repository;

  BookmarkBloc(this._repository) : super(InitBookmarkState()) {
    on<AddBookmarkEvent>((event, emit) async {
      var either = await _repository.addBookmark(articleID: event.articelID);

      either.fold((l) {
        emit(FailBookmarkState(l));
      }, (r) {
        emit(CompleteAddBookmarkState(r));
      });
    });

    on<RemoveBookmarkEvent>((event, emit) async {
      var either = await _repository.removeBookmark(articleID: event.articelID);

      either.fold((l) {
        emit(FailBookmarkState(l));
      }, (r) {
        emit(CompleteRemoveBookmarkState(r));
      });
    });

    on<GetAllBookmarkEvent>((event, emit) async {
      emit(LoadingBookmarkState());
      var either = await _repository.getBookmarks();

      either.fold((l) {
        emit(FailBookmarkState(l));
      }, (r) {
        r.isNotEmpty
            ? emit(CompleteBookmarkState(r))
            : emit(EmptyBookmarkState());
      });
    });
  }
}
