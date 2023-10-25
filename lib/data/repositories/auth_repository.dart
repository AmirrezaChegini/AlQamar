import 'package:al_qamar/data/datasources/auth_datasource.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:al_qamar/utils/storage.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class IAuthRepository {
  Future<Either<String, String>> login({
    required String email,
    required String password,
  });
  Future<Either<String, String>> register({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<String, String>> verify({
    required String email,
    required String otp,
  });
  Future<Either<String, String>> logout({
    required String email,
    required String password,
  });

  Future<Either<String, String>> resendOtp({required String email});
}

class AuthRepositoryImpl implements IAuthRepository {
  final AuthDatasource _datasource;

  AuthRepositoryImpl(this._datasource);

  @override
  Future<Either<String, String>> login(
      {required String email, required String password}) async {
    try {
      Response response =
          await _datasource.login(email: email, password: password);

      String token = response.data['data'];
      String message = response.data['message'];

      await Storage.saveString(key: 'token', value: token);

      return right(message);
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }

  @override
  Future<Either<String, String>> logout(
      {required String email, required String password}) async {
    try {
      Response response =
          await _datasource.logout(email: email, password: password);

      String message = response.data['data'];

      return right(message);
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }

  @override
  Future<Either<String, String>> register(
      {required String name,
      required String email,
      required String password}) async {
    try {
      Response response = await _datasource.register(
          name: name, email: email, password: password);

      String message = response.data['message'];

      return right(message);
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }

  @override
  Future<Either<String, String>> verify(
      {required String email, required String otp}) async {
    try {
      Response response = await _datasource.verify(email: email, otp: otp);

      String token = response.data['data']['token'];
      String message = response.data['message'];

      await Storage.saveString(key: 'token', value: token);

      return right(message);
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }

  @override
  Future<Either<String, String>> resendOtp({required String email}) async {
    try {
      Response response = await _datasource.resendOtp(email: email);

      String message = response.data['message'];

      return right(message);
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }
}
