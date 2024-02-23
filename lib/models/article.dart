import 'package:al_qamar/constants/api.dart';
import 'package:al_qamar/models/writer.dart';

class Article {
  final String? _collectionId;
  final String? _collectionName;
  final String? _categoryID;
  final bool? _force;
  final String? _id;
  final String? _title;
  final String? _content;
  final Writer? _writer;
  final String? _writerID;
  final String? _youtube;
  final List<dynamic>? _images;
  final List<dynamic>? _audios;
  final List<dynamic>? _videos;
  final List<dynamic>? _pdfs;
  final DateTime? _created;
  final DateTime? _updated;

  Article(
    this._collectionId,
    this._collectionName,
    this._categoryID,
    this._force,
    this._id,
    this._title,
    this._content,
    this._writer,
    this._writerID,
    this._youtube,
    this._images,
    this._audios,
    this._videos,
    this._pdfs,
    this._created,
    this._updated,
  );

  factory Article.fromMapJson(Map<String, dynamic> jsonObject) {
    return Article(
      jsonObject['collectionId'],
      jsonObject['collectionName'],
      jsonObject['categoryID'],
      jsonObject['force'],
      jsonObject['id'],
      jsonObject['title'],
      jsonObject['content'],
      Writer.fromMapJson(jsonObject['expand']['writerID']),
      jsonObject['writerID'],
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
  String get categoryID => _categoryID ?? '';
  bool get force => _force ?? false;
  String get id => _id ?? '';
  String get title => _title ?? '';
  String get content => _content ?? '';
  Writer get writer => _writer ?? Writer('', '', '', '', null, null);
  String get writerID => _writerID ?? '';
  String get youtube => _youtube ?? '';
  List<dynamic> get images => _images ?? [];
  List<dynamic> get audios => _audios ?? [];
  List<dynamic> get videos => _videos ?? [];
  List<dynamic> get pdfs => _pdfs ?? [];
  DateTime get created => _created ?? DateTime.now();
  DateTime get updated => _updated ?? DateTime.now();
}
