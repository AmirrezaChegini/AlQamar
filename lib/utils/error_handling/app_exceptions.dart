class AppExceptions implements Exception {
  final String _message;
  AppExceptions(this._message);
  String get message => _message;
}

class FetchDataEx extends AppExceptions {
  FetchDataEx({String? message}) : super(message ?? 'No internet connection');
}

class ServerEx extends AppExceptions {
  ServerEx({String? message}) : super(message ?? 'There is a server error');
}

class NotFoundEx extends AppExceptions {
  NotFoundEx({String? message}) : super(message ?? 'Not found');
}

class AuthEx extends AppExceptions {
  AuthEx({String? message})
      : super(message ?? 'Email or Password is incorrect');
}

class BadReqEx extends AppExceptions {
  BadReqEx({String? message}) : super(message ?? 'Wrong format');
}

class UnAuthorizedEx extends AppExceptions {
  UnAuthorizedEx({String? message})
      : super(message ?? 'Email or Password is incorrect');
}

class ForbiddenEx extends AppExceptions {
  ForbiddenEx({String? message})
      : super(message ?? 'Please verify your account');
}

class AlreadyEx extends AppExceptions {
  AlreadyEx({String? message})
      : super(message ?? 'There is an account with this email');
}

class SomethingWrongEx extends AppExceptions {
  SomethingWrongEx({String? message}) : super(message ?? 'Something wrong');
}
