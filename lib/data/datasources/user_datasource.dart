import 'package:al_qamar/constants/api.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:al_qamar/utils/error_handling/check_exceptions.dart';
import 'package:al_qamar/utils/storage.dart';
import 'package:dio/dio.dart';

abstract class UserDatasource {
  Future<Response> getUser();
  Future<Response> updateUser({
    required String userID,
    String? firstName,
    String? lastName,
    String? bio,
    String? image,
  });
}

class UserRemote implements UserDatasource {
  final Dio _dio;
  UserRemote(this._dio);

  @override
  Future<Response> getUser() async {
    try {
      String userID = await Storage.getString(key: 'userID');
      return await _dio.get(
        '${Api.user}/$userID',
        options: Options(headers: {'requiredToken': true}),
      );
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<Response> updateUser({
    required String userID,
    String? firstName,
    String? lastName,
    String? bio,
    String? image,
  }) async {
    try {
      return await _dio.patch(
        '${Api.user}/$userID',
        options: Options(headers: {'requiredToken': true}),
        data: {
          'firstName': firstName,
          'lastName': lastName,
          'bio': bio,
          'image': image,
        },
      );
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }
}
