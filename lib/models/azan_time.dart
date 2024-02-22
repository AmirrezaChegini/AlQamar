class AzanTime {
  final String? _fajr;
  final String? _sunrise;
  final String? _dhuhr;
  final String? _sunset;
  final String? _isha;
  final String? _midnight;

  AzanTime(
    this._fajr,
    this._sunrise,
    this._dhuhr,
    this._sunset,
    this._isha,
    this._midnight,
  );

  factory AzanTime.fromMapJson(Map<String, dynamic> jsonObject) {
    return AzanTime(
      jsonObject['Fajr'],
      jsonObject['Sunrise'],
      jsonObject['Dhuhr'],
      jsonObject['Sunset'],
      jsonObject['Isha'],
      jsonObject['Midnight'],
    );
  }

  String get fajr => _fajr ?? '';
  String get sunrise => _sunrise ?? '';
  String get dhuhr => _dhuhr ?? '';
  String get sunset => _sunset ?? '';
  String get isha => _isha ?? '';
  String get midnight => _midnight ?? '';
}
