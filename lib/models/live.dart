import 'package:al_qamar/constants/api.dart';

enum LiveType { video, audio }

class Live {
  final String? _collectionId;
  final String? _collectionName;
  final String? _id;
  final LiveType? _type;
  final String? _url;
  final String? _name;
  final String? _image;
  final DateTime? _created;
  final DateTime? _updated;

  Live(
    this._collectionId,
    this._collectionName,
    this._id,
    this._type,
    this._url,
    this._name,
    this._image,
    this._created,
    this._updated,
  );

  factory Live.fromMapJson(Map<String, dynamic> jsonObject) {
    return Live(
      jsonObject['collectionId'],
      jsonObject['collectionName'],
      jsonObject['id'],
      jsonObject['type'] == 'video' ? LiveType.video : LiveType.audio,
      jsonObject['url'],
      jsonObject['name'],
      '${Api.baseUrl}/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['image']}',
      DateTime.parse(jsonObject['created']),
      DateTime.parse(jsonObject['updated']),
    );
  }

  String get collectionId => _collectionId ?? '';
  String get collectionName => _collectionName ?? '';
  String get id => _id ?? '';
  LiveType get type => _type ?? LiveType.video;
  String get url => _url ?? '';
  String get name => _name ?? '';
  String get image => _image ?? '';
  DateTime get created => _created ?? DateTime.now();
  DateTime get updated => _updated ?? DateTime.now();
}
