abstract class BookmarkEvent {}

class AddBookmarkEvent extends BookmarkEvent {
  final int articelID;
  AddBookmarkEvent(this.articelID);
}

class RemoveBookmarkEvent extends BookmarkEvent {
  final int articelID;
  RemoveBookmarkEvent(this.articelID);
}

class GetAllBookmarkEvent extends BookmarkEvent {}
