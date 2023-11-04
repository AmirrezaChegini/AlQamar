import 'package:al_qamar/models/article.dart';

abstract class BookmarkState {}

class InitBookmarkState extends BookmarkState {}

class LoadingBookmarkState extends BookmarkState {}

class EmptyBookmarkState extends BookmarkState {}

class CompleteBookmarkState extends BookmarkState {
  final List<Article> bookmarkList;

  CompleteBookmarkState(this.bookmarkList);
}

class CompleteAddBookmarkState extends BookmarkState {
  final String message;
  CompleteAddBookmarkState(this.message);
}

class CompleteRemoveBookmarkState extends BookmarkState {
  final String message;
  CompleteRemoveBookmarkState(this.message);
}

class FailBookmarkState extends BookmarkState {
  final String errorMessage;
  FailBookmarkState(this.errorMessage);
}
