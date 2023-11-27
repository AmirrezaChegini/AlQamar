import 'package:al_qamar/models/article.dart';

sealed class BookmarkEvent {}

class GetAllBookmark extends BookmarkEvent {}

class AddBookmark extends BookmarkEvent {
  final Article article;
  AddBookmark(this.article);
}

class Removebookmark extends BookmarkEvent {
  final Article article;
  Removebookmark(this.article);
}
