abstract class UserEvent {}

class CreateUserEvent extends UserEvent {
  final String firstName;
  final String lastName;

  CreateUserEvent(this.firstName, this.lastName);
}

class GetUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final int id;
  final String? firstName;
  final String? lastName;
  final String? bio;

  UpdateUserEvent(this.id, this.firstName, this.lastName, this.bio);
}
