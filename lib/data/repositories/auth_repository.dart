import 'package:al_qamar/data/datasources/auth_datasource.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:al_qamar/utils/storage.dart';
import 'package:dartz/dartz.dart';

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
      String token = await _datasource.login(email: email, password: password);
      await Storage.saveString(key: 'token', value: token);

      return right('Login successfully');
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }

  @override
  Future<Either<String, String>> logout(
      {required String email, required String password}) async {
    try {
      String message =
          await _datasource.logout(email: email, password: password);

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
      String message = await _datasource.register(
          name: name, email: email, password: password);

      return right(message);
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }

  @override
  Future<Either<String, String>> verify(
      {required String email, required String otp}) async {
    try {
      String token = await _datasource.verify(email: email, otp: otp);
      await Storage.saveString(key: 'token', value: token);

      return right('Verify successfully');
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }

  @override
  Future<Either<String, String>> resendOtp({required String email}) async {
    try {
      String message = await _datasource.resendOtp(email: email);
      return right(message);
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }
}
