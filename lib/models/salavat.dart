import 'package:hive/hive.dart';
part 'salavat.g.dart';

@HiveType(typeId: 0)
class Salavat extends HiveObject {
  @HiveField(0)
  final int _id;

  @HiveField(1, defaultValue: 0)
  final int _numbers;

  Salavat(this._id, this._numbers);

  int get id => _id;
  int get numbers => _numbers;
}
