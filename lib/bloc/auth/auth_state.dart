abstract class AuthState {}

class InitAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class CompleteRegisterState extends AuthState {
  final String message;
  CompleteRegisterState(this.message);
}

class CompleteAuthState extends AuthState {
  final String message;
  CompleteAuthState(this.message);
}

class FailAuthState extends AuthState {
  final String errorMessage;
  FailAuthState(this.errorMessage);
}

class FailVerifyState extends AuthState {
  final String errorMessage;
  FailVerifyState(this.errorMessage);
}
