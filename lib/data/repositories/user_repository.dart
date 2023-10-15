import 'package:al_qamar/data/datasources/user_datasource.dart';
import 'package:al_qamar/models/user.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:dartz/dartz.dart';

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
      User user = await _datasource.createUser(
          firstName: firstName, lastName: lastName);

      return right(user);
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }

  @override
  Future<Either<String, User>> getUser() async {
    try {
      User user = await _datasource.getUser();

      return right(user);
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
      User user = await _datasource.updateUser(
        id: id,
        firstName: firstName,
        lastName: lastName,
        bio: bio,
      );

      return right(user);
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }
}
