import 'package:al_qamar/models/live.dart';
import 'package:al_qamar/models/program.dart';

class ProgramTime {
  final String? _collectionId;
  final String? _collectionName;
  final Live? _live;
  final List<Program>? _program;

  ProgramTime(
    this._collectionId,
    this._collectionName,
    this._live,
    this._program,
  );

  factory ProgramTime.fromMapJson(Map<String, dynamic> jsonObject) {
    return ProgramTime(
      jsonObject['collectionId'],
      jsonObject['collectionName'],
      Live.fromMapJson(jsonObject['expand']['live']),
      jsonObject['expand']['program']
          .map<Program>((e) => Program.fromMapJson(e))
          .toList(),
    );
  }

  String get collectionId => _collectionId ?? '';
  String get collectionName => _collectionName ?? '';
  Live get live => _live ?? Live('', '', '', null, '', '', '', null, null);
  List<Program> get program => _program ?? [];
}
