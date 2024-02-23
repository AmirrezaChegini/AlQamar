import 'package:al_qamar/constants/api.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:al_qamar/utils/error_handling/check_exceptions.dart';
import 'package:dio/dio.dart';

abstract class AuthDatasource {
  Future<Response> login({
    required String email,
    required String password,
  });
  Future<Response> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });
}

class AuthRemote implements AuthDatasource {
  final Dio _dio;

  AuthRemote(this._dio);

  @override
  Future<Response> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _dio.post(
        Api.login,
        data: {
          'identity': email,
          'password': password,
        },
      );
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<Response> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      return await _dio.post(
        Api.register,
        data: {
          'email': email,
          'emailVisibility': true,
          'password': password,
          'passwordConfirm': password,
          'firstName': firstName,
          'lastName': lastName,
        },
      );
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }
}
