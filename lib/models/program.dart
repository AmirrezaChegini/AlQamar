class Program {
  final String? _name;
  final DateTime _time;

  Program(this._name, this._time);

  String get name => _name ?? '';
  DateTime get time => _time;
}
