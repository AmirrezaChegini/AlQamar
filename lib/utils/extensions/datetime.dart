import 'package:hijri/hijri_calendar.dart';

extension DatatimeExt on DateTime {
  int getHijriDate() {
    DateTime date = this;
    return HijriCalendar.fromDate(date).hDay;
  }
}
