import 'package:al_qamar/models/article.dart';

sealed class BookmarkState {}

class InitBookmarkState extends BookmarkState {}

class CompleteBookmarkState extends BookmarkState {
  final List<Article> bookmarkList;
  CompleteBookmarkState(this.bookmarkList);
}

class EmptyBookmarkState extends BookmarkState {}
