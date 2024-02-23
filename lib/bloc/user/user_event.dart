import 'package:al_qamar/models/user.dart';

sealed class UserEvent {}

class GetUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final String userID;
  final String? firstName;
  final String? lastName;
  final String? bio;
  final String? image;

  UpdateUserEvent({
    required this.userID,
    this.firstName,
    this.lastName,
    this.bio,
    this.image,
  });
}

class SetUserEvent extends UserEvent {
  final User user;
  SetUserEvent(this.user);
}

class LogoutUserEvent extends UserEvent {}
