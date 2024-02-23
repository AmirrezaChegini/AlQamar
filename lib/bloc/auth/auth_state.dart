import 'package:al_qamar/models/user.dart';

sealed class AuthState {}

class InitAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class CompleteAuthState extends AuthState {
  final User user;
  CompleteAuthState(this.user);
}

class FailedAuthState extends AuthState {
  final String errorMessage;
  FailedAuthState(this.errorMessage);
}
