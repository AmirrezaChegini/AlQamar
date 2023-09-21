import 'package:hijri/hijri_calendar.dart';

extension HijriExt on DateTime {
  int getHijriDate() {
    DateTime date = this;
    return HijriCalendar.fromDate(date).hDay;
  }
}
