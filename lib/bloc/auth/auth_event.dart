abstract class AuthEvent {}

class LoginAuthEvent extends AuthEvent {
  final String email;
  final String password;

  LoginAuthEvent(this.email, this.password);
}

class RegisterAuthEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  RegisterAuthEvent(this.name, this.email, this.password);
}

class VerifyAuthEvent extends AuthEvent {
  final String email;
  final String otp;

  VerifyAuthEvent(this.email, this.otp);
}

class ResendCodeEvent extends AuthEvent {
  final String email;

  ResendCodeEvent(this.email);
}

class LogoutAuthEvent extends AuthEvent {}
