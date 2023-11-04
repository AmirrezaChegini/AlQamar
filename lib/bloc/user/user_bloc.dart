import 'package:al_qamar/bloc/user/user_event.dart';
import 'package:al_qamar/bloc/user/user_state.dart';
import 'package:al_qamar/data/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final IUserRepository _repository;

  UserBloc(this._repository) : super(InitUserState()) {
    on<GetUserEvent>((event, emit) async {
      var either = await _repository.getUser();
      either.fold((l) {
        emit(InitUserState());
      }, (r) {
        emit(CompleteUserState(r));
      });
    });

    on<CreateUserEvent>((event, emit) async {
      var either = await _repository.createUser(
          firstName: event.firstName, lastName: event.lastName);

      either.fold((l) {
        emit(InitUserState());
      }, (r) async {
        emit(CompleteUserState(r));
      });
    });

    on<UpdateUserEvent>((event, emit) async {
      var either = await _repository.updateUser(
        id: event.id,
        firstName: event.firstName,
        lastName: event.lastName,
        bio: event.bio,
      );

      either.fold((l) {
        emit(InitUserState());
      }, (r) {
        emit(CompleteUserState(r));
      });
    });
  }
}
