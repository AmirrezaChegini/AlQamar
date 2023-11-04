import 'package:al_qamar/constants/api.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:al_qamar/utils/error_handling/check_exceptions.dart';
import 'package:dio/dio.dart';

abstract class BookmarkDatasource {
  Future<Response> addBookmark({required int articleID});
  Future<Response> removeBookmark({required int articleID});
  Future<Response> getBookmarks();
}

class BookmarkRemote implements BookmarkDatasource {
  final Dio _dio;
  BookmarkRemote(this._dio);

  @override
  Future<Response> addBookmark({required int articleID}) async {
    try {
      Response userResponse = await _dio.get(
        Api.profile,
        options: Options(headers: {'requiredToken': true}),
      );

      final String userID = userResponse.data['data'][0]['user_id'];

      Response response = await _dio.post(
        '/user/${int.parse(userID)}/bookmark/$articleID',
        options: Options(headers: {'requiredToken': true}),
      );

      return response;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<Response> getBookmarks() async {
    try {
      Response userResponse = await _dio.get(
        Api.profile,
        options: Options(headers: {'requiredToken': true}),
      );

      final String userID = userResponse.data['data'][0]['user_id'];

      Response response = await _dio.get(
        '/user/${int.parse(userID)}/bookmark-list',
        options: Options(headers: {'requiredToken': true}),
      );

      return response;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<Response> removeBookmark({required int articleID}) async {
    try {
      Response userResponse = await _dio.get(
        Api.profile,
        options: Options(headers: {'requiredToken': true}),
      );

      final String userID = userResponse.data['data'][0]['user_id'];

      Response response = await _dio.delete(
        '/user/${int.parse(userID)}/bookmark/$articleID',
        options: Options(headers: {'requiredToken': true}),
      );

      return response;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }
}
