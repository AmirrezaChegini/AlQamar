class Writer {
  final String? _collectionId;
  final String? _collectionName;
  final String? _id;
  final String? _name;
  final DateTime? _created;
  final DateTime? _updated;

  Writer(
    this._collectionId,
    this._collectionName,
    this._id,
    this._name,
    this._created,
    this._updated,
  );

  factory Writer.fromMapJson(Map<String, dynamic> jsonObject) {
    return Writer(
      jsonObject['collectionId'],
      jsonObject['collectionName'],
      jsonObject['id'],
      jsonObject['name'],
      DateTime.parse(jsonObject['created']),
      DateTime.parse(jsonObject['updated']),
    );
  }

  String get collectionId => _collectionId ?? '';
  String get collectionName => _collectionName ?? '';
  String get id => _id ?? '';
  String get name => _name ?? '';
  DateTime get created => _created ?? DateTime.now();
  DateTime get updated => _updated ?? DateTime.now();
}
