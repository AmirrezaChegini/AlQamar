import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

extension DatatimeExt on DateTime {
  int getHijriDate() {
    DateTime date = this;
    return HijriCalendar.fromDate(date).hDay;
  }

  String getFormatDate() {
    DateTime dateTime = this;

    return DateFormat('MM/dd/yyyy').format(dateTime);
  }
}
