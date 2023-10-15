import 'package:intl/intl.dart';

class Article {
  final int _id;
  final int _categoryID;
  final String _title;
  final String _content;
  final String _writer;
  final String _type;
  String _updateAt;
  final String _youtube;
  List<dynamic>? _images;
  List<dynamic>? _audios;
  List<dynamic>? _pdfs;

  Article(
    this._id,
    this._categoryID,
    this._title,
    this._content,
    this._writer,
    this._type,
    this._updateAt,
    this._youtube,
    this._images,
    this._audios,
    this._pdfs,
  ) {
    _updateAt = DateFormat('yyyy-MM-dd').format(DateTime.parse(_updateAt));
    _images = _images?.map((e) => 'http://192.168.213.2:8585$e').toList();
    _audios = _audios?.map((e) => 'http://192.168.213.2:8585$e').toList();
    _pdfs = _pdfs?.map((e) => 'http://192.168.213.2:8585$e').toList();
  }

  factory Article.fromMapJson(Map<String, dynamic> jsonObject) {
    return Article(
      jsonObject['id'],
      jsonObject['category_id'],
      jsonObject['title'],
      jsonObject['content'],
      jsonObject['writer'],
      jsonObject['type'],
      jsonObject['updated_at'],
      jsonObject['youtube_link'],
      jsonObject['image_paths'],
      jsonObject['audio_paths'],
      jsonObject['pdf_paths'],
    );
  }

  int get id => _id;
  int get categoryID => _categoryID;
  String get title => _title;
  String get content => _content;
  String get writer => _writer;
  String get type => _type;
  String get updateAt => _updateAt;
  String get youtube => _youtube;
  List<dynamic>? get images => _images;
  List<dynamic>? get audios => _audios;
  List<dynamic>? get pdfs => _pdfs;
}
