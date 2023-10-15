import 'package:al_qamar/constants/api.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:al_qamar/utils/error_handling/check_exceptions.dart';
import 'package:dio/dio.dart';

abstract class AuthDatasource {
  Future<String> login({
    required String email,
    required String password,
  });
  Future<String> register({
    required String name,
    required String email,
    required String password,
  });
  Future<String> verify({
    required String email,
    required String otp,
  });
  Future<String> logout({
    required String email,
    required String password,
  });

  Future<String> resendOtp({required String email});
}

class AuthRemote implements AuthDatasource {
  final Dio _dio;

  AuthRemote(this._dio);

  @override
  Future<String> login(
      {required String email, required String password}) async {
    try {
      Response response = await _dio.post(
        Api.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      return response.data['data'];
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<String> logout(
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

      return response.data['data'];
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<String> register({
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

      return response.data['message'];
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<String> verify({required String email, required String otp}) async {
    try {
      Response response = await _dio.post(
        Api.verify,
        data: {
          'email': email,
          'otp': otp,
        },
      );

      String token = response.data['data']['token'];

      return token;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }

  @override
  Future<String> resendOtp({required String email}) async {
    try {
      Response response = await _dio.post(
        Api.resendOtp,
        data: {'email': email},
      );

      String message = response.data['message'];
      return message;
    } on DioException catch (e) {
      e.response == null
          ? throw FetchDataEx()
          : throw CheckExceptions.validate(e.response!);
    }
  }
}
