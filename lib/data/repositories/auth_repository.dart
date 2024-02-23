import 'package:al_qamar/data/datasources/auth_datasource.dart';
import 'package:al_qamar/models/user.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:al_qamar/utils/storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class IAuthRepository {
  Future<ApiModel<User, String>> login({
    required String email,
    required String password,
  });
  Future<ApiModel<User, String>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });
}

class AuthRepositoryImpl implements IAuthRepository {
  final AuthDatasource _datasource;

  AuthRepositoryImpl(this._datasource);

  @override
  Future<ApiModel<User, String>> login(
      {required String email, required String password}) async {
    try {
      Response response =
          await _datasource.login(email: email, password: password);
      await Future.wait([
        Storage.saveString(key: 'token', value: response.data['token']),
        Storage.saveString(key: 'userID', value: response.data['record']['id']),
      ]);

      return ApiModel.success(
        await compute(
          _loginUser,
          response,
        ),
      );
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }

  @override
  Future<ApiModel<User, String>> register(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) async {
    try {
      return ApiModel.success(
        await compute(
          _user,
          await _datasource.register(
            email: email,
            password: password,
            firstName: firstName,
            lastName: lastName,
          ),
        ),
      );
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }
}

User _loginUser(Response response) {
  return User.fromMapJson(response.data['record']);
}

User _user(Response response) {
  return User.fromMapJson(response.data);
}
