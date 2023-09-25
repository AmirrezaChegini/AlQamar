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

    List<String> parts = date.split('/');

    String year = parts[2];
    String month = hijriMonth[int.parse(parts[1])];

    return '$month $year';
  }
}
