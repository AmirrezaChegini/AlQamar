import 'package:al_qamar/models/article.dart';
import 'package:hive/hive.dart';

abstract class BookmarkDatasource {
  List<Article> getAllBookmarks();
  Future<void> addBookmark({required Article article});
  Future<void> removeBookmark({required Article article});
}

class BookmarkLocal implements BookmarkDatasource {
  final Box<Article> bookmarkBox = Hive.box<Article>('bookmarkBox');

  @override
  Future<void> addBookmark({required Article article}) async {
    await bookmarkBox.put(article.id, article);
  }

  @override
  List<Article> getAllBookmarks() {
    return bookmarkBox.values.toList();
  }

  @override
  Future<void> removeBookmark({required Article article}) async {
    await bookmarkBox.delete(article.id);
  }
}
