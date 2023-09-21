extension DateTimeEx on String {
  String formatToArabicMonthYear() {
    String date = this;
    final hijriMonth = [
      'محرم',
      'صفر',
      'ربیع الاول',
      'ربیع الثانی',
      'جمادی الاول',
      'جمادی الثانیه',
      'رجب',
      'شعبان',
      'رمضان',
      'شوال',
      'ذیقعده ',
      'ذیحجه',
    ];

    String year = date.substring(4, date.length);
    String month = hijriMonth[int.parse(date.substring(2, 3))];

    return '$month $year';
  }
}
