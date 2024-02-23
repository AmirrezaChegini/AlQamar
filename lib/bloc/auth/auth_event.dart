sealed class AuthEvent {}

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

class LogoutAuthEvent extends AuthEvent {}
