import 'package:al_qamar/utils/extensions/string.dart';

class AzanTime {
  final String _day;
  String _fajr;
  String _sunrise;
  String _dhuhr;
  String _asr;
  String _sunset;
  String _maghrib;
  String _isha;

  AzanTime(
    this._day,
    this._fajr,
    this._sunrise,
    this._dhuhr,
    this._asr,
    this._sunset,
    this._maghrib,
    this._isha,
  ) {
    _fajr = _fajr.getPureTime();
    _sunrise = _sunrise.getPureTime();
    _dhuhr = _dhuhr.getPureTime();
    _asr = _asr.getPureTime();
    _sunset = _sunset.getPureTime();
    _maghrib = _maghrib.getPureTime();
    _isha = _isha.getPureTime();
  }

  factory AzanTime.fromMapJson(Map<String, dynamic> jsonObject) {
    return AzanTime(
      jsonObject['date']['gregorian']['day'],
      jsonObject['timings']['Fajr'],
      jsonObject['timings']['Sunrise'],
      jsonObject['timings']['Dhuhr'],
      jsonObject['timings']['Asr'],
      jsonObject['timings']['Sunset'],
      jsonObject['timings']['Maghrib'],
      jsonObject['timings']['Isha'],
    );
  }

  String get day => _day;
  String get fajr => _fajr;
  String get sunrise => _sunrise;
  String get dhuhr => _dhuhr;
  String get asr => _asr;
  String get sunset => _sunset;
  String get maghrib => _maghrib;
  String get isha => _isha;
}
