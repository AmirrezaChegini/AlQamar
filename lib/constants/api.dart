class Api {
  Api._();

  //base url
  static const String baseUrl = 'https://yadme.com';
  static const String baseUrlSite = 'https://alghamar-vercel.vercel.app';

  //auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String verify = '/auth/verify';
  static const String logout = '/auth/logout';
  static const String resendOtp = '/auth/resend-otp';

  //user
  static const String profile = '/profile';

  //articles
  static const String articles = '/article';
  static const String lastArticles = '/article/last';
  static const String searchArticles = '/article/search';
  static const String forceArticles = '/article/force-news';

  //calender
  static const String calender = '/calendar';

  //live
  static const String video = '/live/video';
  static const String audio = '/live/audio';

  //category
  static const String category = '/category';
  //azan
  static const String azan = 'https://api.aladhan.com/v1/timingsByCity';
}
