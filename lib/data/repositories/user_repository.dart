import 'package:al_qamar/data/datasources/user_datasource.dart';
import 'package:al_qamar/models/user.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class IUserRepository {
  Future<ApiModel<String, String>> createUser(
      {required String firstName, required String lastName});
  Future<ApiModel<User, String>> getUser();
  Future<ApiModel<String, String>> updateUser({
    required int id,
    required String firstName,
    required String lastName,
    required String bio,
  });
}

class UserRepositoryImpl implements IUserRepository {
  final UserDatasource _datasource;
  UserRepositoryImpl(this._datasource);
  @override
  Future<ApiModel<String, String>> createUser(
      {required String firstName, required String lastName}) async {
    try {
      await _datasource.createUser(firstName: firstName, lastName: lastName);

      return ApiModel.success('ok');
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }

  @override
  Future<ApiModel<User, String>> getUser() async {
    try {
      Response response = await _datasource.getUser();

      return ApiModel.success(await compute(_getUser, response));
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }

  @override
  Future<ApiModel<String, String>> updateUser({
    required int id,
    required String firstName,
    required String lastName,
    required String bio,
  }) async {
    try {
      await _datasource.updateUser(
        id: id,
        firstName: firstName,
        lastName: lastName,
        bio: bio,
      );

      return ApiModel.success('ok');
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }
}

User _getUser(Response response) {
  User user = User.fromMapJson(response.data['data'][0]);
  return user;
}
