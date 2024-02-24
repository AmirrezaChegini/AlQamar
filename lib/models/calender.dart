import 'package:al_qamar/constants/api.dart';

class Calender {
  final String? _collectionId;
  final String? _collectionName;
  final String? _id;
  final DateTime? _choosingDate;
  final String? _title;
  final String? _content;
  final String? _youtube;
  final List<dynamic>? _images;
  final List<dynamic>? _audios;
  final List<dynamic>? _videos;
  final List<dynamic>? _pdfs;
  final DateTime? _created;
  final DateTime? _updated;

  Calender(
    this._collectionId,
    this._collectionName,
    this._id,
    this._choosingDate,
    this._title,
    this._content,
    this._youtube,
    this._images,
    this._audios,
    this._videos,
    this._pdfs,
    this._created,
    this._updated,
  );

  factory Calender.fromMapJson(Map<String, dynamic> jsonObject) {
    return Calender(
      jsonObject['collectionId'],
      jsonObject['collectionName'],
      jsonObject['id'],
      DateTime.parse(jsonObject['choosingDate']),
      jsonObject['title'],
      jsonObject['content'],
      jsonObject['youtube'],
      jsonObject['images']
          .map<String>((e) =>
              '${Api.baseUrl}/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/$e')
          .toList(),
      jsonObject['audios']
          .map<String>((e) =>
              '${Api.baseUrl}/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/$e')
          .toList(),
      jsonObject['videos']
          .map<String>((e) =>
              '${Api.baseUrl}/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/$e')
          .toList(),
      jsonObject['pdfs']
          .map<String>((e) =>
              '${Api.baseUrl}/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/$e')
          .toList(),
      DateTime.parse(jsonObject['created']),
      DateTime.parse(jsonObject['updated']),
    );
  }

  String get collectionId => _collectionId ?? '';
  String get collectionName => _collectionName ?? '';
  String get id => _id ?? '';
  DateTime get choosingDate => _choosingDate ?? DateTime.now();
  String get title => _title ?? '';
  String get content => _content ?? '';
  String get youtube => _youtube ?? '';
  List<dynamic> get images => _images ?? [];
  List<dynamic> get audios => _audios ?? [];
  List<dynamic> get videos => _videos ?? [];
  List<dynamic> get pdfs => _pdfs ?? [];
  DateTime get created => _created ?? DateTime.now();
  DateTime get updated => _updated ?? DateTime.now();
}
