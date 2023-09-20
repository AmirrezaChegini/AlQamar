import 'package:intl/intl.dart';

extension DateTimeEx on DateTime {
  String formatToMiladi() {
    DateTime date = this;
    final arabicMonths = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];

    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSS');
    final parsedDate = formatter.parse(date.toString());

    final month = arabicMonths[parsedDate.month - 1];
    final year = parsedDate.year.toString();

    return '$month $year';
  }
}
