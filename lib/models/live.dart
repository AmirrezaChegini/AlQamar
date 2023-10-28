import 'package:al_qamar/models/program.dart';

class Live {
  final int _id;
  final String? _name;
  final String? _url;
  final String? _type;
  final Map<String, dynamic>? programsMap;
  List<Program>? _programList;

  Live(
    this._id,
    this._name,
    this._url,
    this._type,
    this.programsMap,
  ) {
    _programList = programsMap?.entries
        .map<Program>((e) => Program(e.key, e.value))
        .toList();
  }

  factory Live.fromMapJson(Map<String, dynamic> jsonObject) {
    return Live(
      jsonObject['id'],
      jsonObject['name'],
      jsonObject['url'],
      jsonObject['type'],
      jsonObject['list_programs'],
    );
  }

  int get id => _id;
  String get name => _name ?? '';
  String get url => _url ?? '';
  String get type => _type ?? '';
  List<Program> get programList => _programList ?? [];
}
