class Api {
  Api._();

  //base url
  static const String baseUrl = 'https://amirrezagu.liara.run';
  static const String baseUrlSite = 'https://alghamar-vercel.vercel.app';
  static const int perPage = 10;

  //auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String verify = '/auth/verify';
  static const String logout = '/auth/logout';
  static const String resendOtp = '/auth/resend-otp';

  //user
  static const String profile = '/profile';

  //category
  static const String category = '/api/collections/category/records';

  //articles
  static const String articles = '/api/collections/article/records';
  static const String forceArticles = '/api/collections/forceArticle/records';

  //calender
  static const String calender = '/calendar';

  //live
  static const String video = '/live/video';
  static const String audio = '/live/audio';

  //azan
  static const String azan = 'https://api.aladhan.com/v1/timingsByCity';
}
