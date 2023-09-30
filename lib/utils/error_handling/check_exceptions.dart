import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:dio/dio.dart';

class CheckExceptions {
  static dynamic validate(Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 201:
        return response;
      case 208:
        return response;
      case 400:
        throw BadReqEx(message: response.statusMessage);
      case 401:
        throw UnAuthorizedEx(message: response.data['message']);
      case 403:
        throw ForbiddenEx(message: response.data['message']);
      case 404:
        throw NotFoundEx(message: response.data['message']);
      case 406:
        throw AlreadyEx(message: response.data['message']);
      case 422:
        throw AuthEx(message: response.data['message']);
      case 500:
        throw ServerEx(message: response.statusMessage);
      default:
        throw FetchDataEx(message: response.statusMessage);
    }
  }
}
