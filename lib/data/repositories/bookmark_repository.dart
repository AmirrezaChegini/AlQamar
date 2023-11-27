import 'package:al_qamar/data/datasources/bookmark_datasource.dart';
import 'package:al_qamar/models/article.dart';

abstract class IBookmarkRepository {
  List<Article> getAllBookmarks();
  Future<void> addBookmark({required Article article});
  Future<void> removeBookmark({required Article article});
}

class BookmarkRepositoryImpl implements IBookmarkRepository {
  final BookmarkDatasource _datasource;
  BookmarkRepositoryImpl(this._datasource);

  @override
  Future<void> addBookmark({required Article article}) async {
    await _datasource.addBookmark(article: article);
  }

  @override
  List<Article> getAllBookmarks() {
    return _datasource.getAllBookmarks();
  }

  @override
  Future<void> removeBookmark({required Article article}) async {
    await _datasource.removeBookmark(article: article);
  }
}
