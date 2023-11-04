import 'package:al_qamar/data/datasources/user_datasource.dart';
import 'package:al_qamar/models/user.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class IUserRepository {
  Future<Either<String, User>> createUser(
      {required String firstName, required String lastName});
  Future<Either<String, User>> getUser();
  Future<Either<String, User>> updateUser({
    required int id,
    String? firstName,
    String? lastName,
    String? bio,
  });
}

class UserRepositoryImpl implements IUserRepository {
  final UserDatasource _datasource;
  UserRepositoryImpl(this._datasource);
  @override
  Future<Either<String, User>> createUser(
      {required String firstName, required String lastName}) async {
    try {
      Response response = await _datasource.createUser(
          firstName: firstName, lastName: lastName);

      return right(await compute(_newUser, response));
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
  Future<Either<String, User>> updateUser({
    required int id,
    String? firstName,
    String? lastName,
    String? bio,
  }) async {
    try {
      Response response = await _datasource.updateUser(
        id: id,
        firstName: firstName,
        lastName: lastName,
        bio: bio,
      );

      return right(await compute(_newUser, response));
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }
}

User _newUser(Response response) {
  User newUser = User.fromMapJson(response.data['data']);
  return newUser;
}

User _getUser(Response response) {
  User user = User.fromMapJson(response.data['data'][0]);
  return user;
}
