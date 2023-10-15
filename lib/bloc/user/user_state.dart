import 'package:al_qamar/models/user.dart';

abstract class UserState {}

class InitUserState extends UserState {}

class CompleteUserState extends UserState {
  final User user;
  CompleteUserState(this.user);
}
