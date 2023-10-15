import 'package:al_qamar/constants/api.dart';
import 'package:al_qamar/models/user.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:al_qamar/utils/error_handling/check_exceptions.dart';
import 'package:dio/dio.dart';

abstract class UserDatasource {
  Future<User> createUser({
    required String firstName,
    required String lastName,
  });
  Future<User> getUser();
  Future<User> updateUser({
    required int id,
    String? firstName,
    String? lastName,
    String? bio,
  });
}

class UserRemote implements UserDatasource {
  final Dio _dio;
  UserRemote(this._dio);

  @override
  Future<User> createUser(
      {required String firstName, required String lastName}) async {
    try {
      Response response = await _dio.post(
        Api.profile,
        options: Options(headers: {'requiredToken': true}),
        data: {
          'first_name': firstName,
          'last_name': lastName,
        },
      );

      User newUser = User.fromMapJson(response.data['data']);
      return newUser;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<User> getUser() async {
    try {
      Response response = await _dio.get(
        Api.profile,
        options: Options(headers: {'requiredToken': true}),
      );
      User user = User.fromMapJson(response.data['data'][0]);
      return user;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<User> updateUser({
    required int id,
    String? firstName,
    String? lastName,
    String? bio,
  }) async {
    try {
      Response response = await _dio.put(
        '${Api.profile}/$id',
        options: Options(headers: {'requiredToken': true}),
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'bio': bio,
        },
      );
      User user = response.data['data'];
      return user;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }
}
