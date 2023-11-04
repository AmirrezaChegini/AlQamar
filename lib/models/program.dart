class Program {
  final String? _name;
  final String? _time;

  Program(this._name, this._time);

  String get name => _name ?? '';
  String get time => _time ?? '';
}
