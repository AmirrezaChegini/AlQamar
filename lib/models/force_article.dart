class ForceArticle {
  final String? _collectionId;
  final String? _collectionName;
  final String? _categoryID;
  final String? _id;
  final String? _title;
  final String? _content;

  ForceArticle(
    this._collectionId,
    this._collectionName,
    this._categoryID,
    this._id,
    this._title,
    this._content,
  );

  factory ForceArticle.fromMapJson(Map<String, dynamic> jsonObject) {
    return ForceArticle(
      jsonObject['collectionId'],
      jsonObject['collectionName'],
      jsonObject['categoryID'],
      jsonObject['id'],
      jsonObject['title'],
      jsonObject['content'],
    );
  }

  String get collectionId => _collectionId ?? '';
  String get collectionName => _collectionName ?? '';
  String get categoryID => _categoryID ?? '';
  String get id => _id ?? '';
  String get title => _title ?? '';
  String get content => _content ?? '';
}
