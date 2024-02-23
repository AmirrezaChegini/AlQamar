import 'package:al_qamar/data/datasources/user_datasource.dart';
import 'package:al_qamar/models/user.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class IUserRepository {
  Future<ApiModel<User, String>> getUser();
  Future<ApiModel<User, String>> updateUser({
    required String userID,
    String? firstName,
    String? lastName,
    String? bio,
    String? image,
  });
}

class UserRepositoryImpl implements IUserRepository {
  final UserDatasource _datasource;
  UserRepositoryImpl(this._datasource);

  @override
  Future<ApiModel<User, String>> getUser() async {
    try {
      return ApiModel.success(
        await compute(
          _user,
          await _datasource.getUser(),
        ),
      );
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }

  @override
  Future<ApiModel<User, String>> updateUser({
    required String userID,
    String? firstName,
    String? lastName,
    String? bio,
    String? image,
  }) async {
    try {
      return ApiModel.success(
        await compute(
          _user,
          await _datasource.updateUser(
            userID: userID,
            firstName: firstName,
            lastName: lastName,
            bio: bio,
            image: image,
          ),
        ),
      );
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }
}

User _user(Response response) {
  return User.fromMapJson(response.data);
}
