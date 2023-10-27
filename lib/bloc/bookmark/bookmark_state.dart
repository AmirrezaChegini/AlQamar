abstract class BookmarkState {}

class InitBookmarkState extends BookmarkState {}

class LoadingBookmarkState extends BookmarkState {}

class CompleteBookmarkState extends BookmarkState {}

class FailBookmarkState extends BookmarkState {
  final String errorMessage;
  FailBookmarkState(this.errorMessage);
}
