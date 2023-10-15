class AppExceptions implements Exception {
  final String _message;
  AppExceptions(this._message);
  String get message => _message;
}

class FetchDataEx extends AppExceptions {
  FetchDataEx({String? message}) : super(message ?? 'noInternetConnection');
}

class ServerEx extends AppExceptions {
  ServerEx({String? message}) : super(message ?? 'There Is A Server Error');
}

class NotFoundEx extends AppExceptions {
  NotFoundEx({String? message}) : super(message ?? 'Not Found');
}

class AuthEx extends AppExceptions {
  AuthEx({String? message})
      : super(message ?? 'Email Or Password Is Incorrect');
}

class BadReqEx extends AppExceptions {
  BadReqEx({String? message}) : super(message ?? 'Wrong Format');
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
