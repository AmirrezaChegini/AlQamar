sealed class UserState {}

class InitUserState extends UserState {}

class LoadingUserState extends UserState {}

class CompleteUserState extends UserState {}

class FailedUserState extends UserState {
  final String errorMessage;
  FailedUserState(this.errorMessage);
}
