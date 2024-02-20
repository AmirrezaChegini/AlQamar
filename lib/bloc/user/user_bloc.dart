import 'package:al_qamar/bloc/user/user_event.dart';
import 'package:al_qamar/bloc/user/user_state.dart';
import 'package:al_qamar/data/repositories/user_repository.dart';
import 'package:al_qamar/models/user.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final IUserRepository _repository;

  UserBloc(this._repository) : super(InitUserState()) {
    on<GetUserEvent>((event, emit) async {
      ApiModel<User, String> either = await _repository.getUser();

      either.fold(
        (data) => emit(CompleteUserState(data)),
        (error) => emit(InitUserState()),
      );
    });

    on<CreateUserEvent>((event, emit) async {
      ApiModel<String, String> either = await _repository.createUser(
        firstName: event.firstName,
        lastName: event.lastName,
      );

      either.fold(
        (data) => add(GetUserEvent()),
        (error) => emit(InitUserState()),
      );
    });

    on<UpdateUserEvent>((event, emit) async {
      ApiModel<String, String> either = await _repository.updateUser(
        id: event.id,
        firstName: event.firstName,
        lastName: event.lastName,
        bio: event.bio,
      );

      either.fold(
        (data) => add(GetUserEvent()),
        (error) => emit(InitUserState()),
      );
    });
  }
}
