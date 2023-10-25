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
    required String name,
    required String email,
    required String password,
  });
  Future<Response> verify({
    required String email,
    required String otp,
  });
  Future<Response> logout({
    required String email,
    required String password,
  });

  Future<Response> resendOtp({required String email});
}

class AuthRemote implements AuthDatasource {
  final Dio _dio;

  AuthRemote(this._dio);

  @override
  Future<Response> login(
      {required String email, required String password}) async {
    try {
      Response response = await _dio.post(
        Api.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      return response;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<Response> logout(
      {required String email, required String password}) async {
    try {
      Response response = await _dio.post(
        Api.logout,
        data: {
          'email': email,
          'password': password,
        },
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
  Future<Response> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _dio.post(
        Api.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      return response;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<Response> verify({required String email, required String otp}) async {
    try {
      Response response = await _dio.post(
        Api.verify,
        data: {
          'email': email,
          'otp': otp,
        },
      );

      return response;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<Response> resendOtp({required String email}) async {
    try {
      Response response = await _dio.post(
        Api.resendOtp,
        data: {'email': email},
      );

      return response;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }
}
