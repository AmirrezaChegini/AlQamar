import 'package:image_picker/image_picker.dart';

abstract class UserEvent {}

class CreateUserEvent extends UserEvent {
  final String firstName;
  final String lastName;

  CreateUserEvent(this.firstName, this.lastName);
}

class GetUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final int id;
  final String firstName;
  final String lastName;
  final XFile? avatar;
  final String bio;

  UpdateUserEvent({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.avatar,
    required this.bio,
  });
}
