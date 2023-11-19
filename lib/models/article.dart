import 'dart:convert';

import 'package:intl/intl.dart';

class Article {
  final int _id;
  final String? _title;
  final String? _content;
  final String? _writer;
  final String? _type;
  String? _createAt;
  final String? _youtube;
  dynamic _images;
  dynamic _videos;
  dynamic _audios;
  dynamic _pdfs;

  Article(
    this._id,
    this._title,
    this._content,
    this._writer,
    this._type,
    this._createAt,
    this._youtube,
    this._images,
    this._videos,
    this._audios,
    this._pdfs,
  ) {
    _createAt =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(_createAt ?? ''));
    _images =
        _images is String ? jsonDecode(_images) as List<dynamic> : _images;
    _videos =
        _videos is String ? jsonDecode(_videos) as List<dynamic> : _videos;
    _audios =
        _audios is String ? jsonDecode(_audios) as List<dynamic> : _audios;
    _pdfs = _pdfs is String ? jsonDecode(_pdfs) as List<dynamic> : _pdfs;
  }

  factory Article.fromMapJson(Map<String, dynamic> jsonObject) {
    return Article(
      jsonObject['id'],
      jsonObject['title'],
      jsonObject['content'],
      jsonObject['writer'],
      jsonObject['type'],
      jsonObject['created_at'],
      jsonObject['youtube_link'],
      jsonObject['image_paths'],
      jsonObject['video_paths'],
      jsonObject['audio_paths'],
      jsonObject['pdf_paths'],
    );
  }

  int get id => _id;
  String get title => _title ?? '';
  String get content => _content ?? '';
  String get writer => _writer ?? '';
  String get type => _type ?? '';
  String get updateAt => _createAt ?? '';
  String get youtube => _youtube ?? '';
  List<dynamic> get images => _images;
  List<dynamic> get videos => _videos;
  List<dynamic> get audios => _audios;
  List<dynamic> get pdfs => _pdfs;
}
