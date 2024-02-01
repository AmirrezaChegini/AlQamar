import 'package:al_qamar/data/datasources/user_datasource.dart';
import 'package:al_qamar/models/user.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

abstract class IUserRepository {
  Future<Either<String, String>> createUser(
      {required String firstName, required String lastName});
  Future<Either<String, User>> getUser();
  Future<Either<String, String>> updateUser({
    required int id,
    required String firstName,
    required String lastName,
    XFile? avatar,
    required String bio,
  });
}

class UserRepositoryImpl implements IUserRepository {
  final UserDatasource _datasource;
  UserRepositoryImpl(this._datasource);
  @override
  Future<Either<String, String>> createUser(
      {required String firstName, required String lastName}) async {
    try {
      await _datasource.createUser(firstName: firstName, lastName: lastName);

      return right('ok');
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }

  @override
  Future<Either<String, User>> getUser() async {
    try {
      Response response = await _datasource.getUser();

      return right(await compute(_getUser, response));
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }

  @override
  Future<Either<String, String>> updateUser({
    required int id,
    required String firstName,
    required String lastName,
    XFile? avatar,
    required String bio,
  }) async {
    try {
      await _datasource.updateUser(
        id: id,
        firstName: firstName,
        lastName: lastName,
        avatar: avatar,
        bio: bio,
      );

      return right('ok');
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }
}

User _getUser(Response response) {
  User user = User.fromMapJson(response.data['data'][0]);
  return user;
}
