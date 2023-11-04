abstract class AuthEvent {}

class LoginAuthEvent extends AuthEvent {
  final String email;
  final String password;

  LoginAuthEvent(this.email, this.password);
}

class RegisterAuthEvent extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  RegisterAuthEvent(this.firstName, this.lastName, this.email, this.password);
}

class VerifyAuthEvent extends AuthEvent {
  final String otp;

  VerifyAuthEvent(this.otp);
}

class ResendCodeEvent extends AuthEvent {
  final String email;

  ResendCodeEvent(this.email);
}

class LogoutAuthEvent extends AuthEvent {}

class CheckEmailEvent extends AuthEvent {}
