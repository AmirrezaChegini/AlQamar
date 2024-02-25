class AppExceptions implements Exception {
  final String _message;
  AppExceptions(this._message);
  String get message => _message;
}

class FetchDataEx extends AppExceptions {
  FetchDataEx({String? message}) : super(message ?? 'noInternetConnection');
}

class ServerEx extends AppExceptions {
  ServerEx({String? message}) : super(message ?? 'serverError');
}

class NotFoundEx extends AppExceptions {
  NotFoundEx({String? message}) : super(message ?? 'notFound');
}

class BadReqEx extends AppExceptions {
  BadReqEx({String? message}) : super(message ?? 'badRequest');
}

class UnAuthorizedEx extends AppExceptions {
  UnAuthorizedEx({String? message}) : super(message ?? 'unAuthorized');
}

class ForbiddenEx extends AppExceptions {
  ForbiddenEx({String? message}) : super(message ?? 'youAreNotAllowed');
}
