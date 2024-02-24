class Program {
  final String? _collectionId;
  final String? _collectionName;
  final String? _id;
  final DateTime? _date;
  final String? _name;
  final DateTime? _created;
  final DateTime? _updated;

  Program(
    this._collectionId,
    this._collectionName,
    this._id,
    this._date,
    this._name,
    this._created,
    this._updated,
  );

  factory Program.fromMapJson(Map<String, dynamic> jsonObject) {
    return Program(
      jsonObject['collectionId'],
      jsonObject['collectionName'],
      jsonObject['id'],
      DateTime.parse(jsonObject['date']),
      jsonObject['name'],
      DateTime.parse(jsonObject['created']),
      DateTime.parse(jsonObject['updated']),
    );
  }

  String get collectionId => _collectionId ?? '';
  String get collectionName => _collectionName ?? '';
  String get id => _id ?? '';
  DateTime get date => _date ?? DateTime.now();
  String get name => _name ?? '';
  DateTime get created => _created ?? DateTime.now();
  DateTime get updated => _updated ?? DateTime.now();
}
