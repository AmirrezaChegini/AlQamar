import 'package:al_qamar/data/datasources/auth_datasource.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:al_qamar/utils/storage.dart';
import 'package:dio/dio.dart';

abstract class IAuthRepository {
  Future<ApiModel<String, String>> login({
    required String email,
    required String password,
  });
  Future<ApiModel<String, String>> register({
    required String name,
    required String email,
    required String password,
  });
  Future<ApiModel<String, String>> verify({
    required String email,
    required String otp,
  });
  Future<ApiModel<String, String>> logout();
  Future<ApiModel<String, String>> resendOtp({required String email});
}

class AuthRepositoryImpl implements IAuthRepository {
  final AuthDatasource _datasource;

  AuthRepositoryImpl(this._datasource);

  @override
  Future<ApiModel<String, String>> login(
      {required String email, required String password}) async {
    try {
      Response response =
          await _datasource.login(email: email, password: password);

      String token = response.data['data'];
      String message = response.data['message'];

      await Storage.saveString(key: 'token', value: token);

      return ApiModel.success(message);
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }

  @override
  Future<ApiModel<String, String>> logout() async {
    try {
      Response response = await _datasource.logout();

      Storage.removeKey(key: 'token');

      return ApiModel.success(response.data['message']);
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }

  @override
  Future<ApiModel<String, String>> register(
      {required String name,
      required String email,
      required String password}) async {
    try {
      Response response = await _datasource.register(
          name: name, email: email, password: password);

      String message = response.data['message'];

      return ApiModel.success(message);
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }

  @override
  Future<ApiModel<String, String>> verify(
      {required String email, required String otp}) async {
    try {
      Response response = await _datasource.verify(email: email, otp: otp);

      String token = response.data['data']['token'];
      String message = response.data['message'];

      await Storage.saveString(key: 'token', value: token);

      return ApiModel.success(message);
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }

  @override
  Future<ApiModel<String, String>> resendOtp({required String email}) async {
    try {
      Response response = await _datasource.resendOtp(email: email);

      String message = response.data['message'];

      return ApiModel.success(message);
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }
}
