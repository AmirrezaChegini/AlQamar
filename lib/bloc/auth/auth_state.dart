abstract class AuthState {}

class InitAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class LoadingVerifyState extends AuthState {}

class CompleteRegisterState extends AuthState {
  final String message;
  CompleteRegisterState(this.message);
}

class CompleteResendCodeState extends AuthState {
  final String message;
  CompleteResendCodeState(this.message);
}

class CompleteVerifyState extends AuthState {
  final String message;
  CompleteVerifyState(this.message);
}

class CompleteLoginState extends AuthState {
  final String message;
  CompleteLoginState(this.message);
}

class CompleteLogoutState extends AuthState {}

class FailAuthState extends AuthState {
  final String errorMessage;
  FailAuthState(this.errorMessage);
}

class FailVerifyState extends AuthState {
  final String errorMessage;
  FailVerifyState(this.errorMessage);
}
