class Api {
  Api._();

  //auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String verify = '/auth/verify';
  static const String logout = '/auth/logout';
  static const String resendOtp = '/auth/resend-otp';

  //user
  static const String profile = '/profile';

  static const String azan = 'https://api.aladhan.com/v1/calendarByCity';
}
