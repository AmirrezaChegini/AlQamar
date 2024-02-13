import 'package:hijri/hijri_calendar.dart';

extension HijriExt on HijriCalendar {
  String getHijri() {
    List<String> parts = '$this'.split('/');

    return '${parts[2]}-${parts[1].padLeft(2, '0')}-${parts[0].padLeft(2, '0')}';
  }
}
