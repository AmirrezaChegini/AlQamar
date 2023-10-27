import 'dart:convert';

import 'package:intl/intl.dart';

class Calender {
  final int _id;
  final String? _title;
  final String? _content;
  String? _createAt;
  final String? _day;
  dynamic _images;
  dynamic _videos;
  dynamic _audios;
  dynamic _pdfs;

  Calender(
    this._id,
    this._title,
    this._content,
    this._createAt,
    this._day,
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

  factory Calender.fromMapJson(Map<String, dynamic> jsonObject) {
    return Calender(
      jsonObject['id'],
      jsonObject['title'],
      jsonObject['content'],
      jsonObject['created_at'],
      jsonObject['day'],
      jsonObject['image_paths'],
      jsonObject['video_paths'],
      jsonObject['audio_paths'],
      jsonObject['pdf_paths'],
    );
  }

  int get id => _id;
  String get title => _title ?? '';
  String get content => _content ?? '';
  String get updateAt => _createAt ?? '';
  String get day => _day ?? '';
  List<dynamic>? get images => _images;
  List<dynamic>? get videos => _videos;
  List<dynamic>? get audios => _audios;
  List<dynamic>? get pdfs => _pdfs;
}
