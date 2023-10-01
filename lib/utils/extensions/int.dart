extension IntExt on int {
  String getHijriMonth() {
    int month = this - 1;
    const List<String> hijriMonth = [
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

    return month == 12 ? hijriMonth[0] : hijriMonth[month];
  }

  String getGeorgiaMonth() {
    int month = this - 1;
    const List<String> georgiaMonth = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return month == 12 ? georgiaMonth[0] : georgiaMonth[month];
  }

  String getWeekDay() {
    int day = this - 1;
    const List<String> weeks = [
      'الاثنین',
      'الثلاثاء',
      'الأربعاء',
      'الخمیس',
      'الجمعة',
      'السبت',
      'الأحد',
    ];

    return weeks[day];
  }
}
