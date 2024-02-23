import 'package:al_qamar/bloc/user/user_event.dart';
import 'package:al_qamar/bloc/user/user_state.dart';
import 'package:al_qamar/data/repositories/user_repository.dart';
import 'package:al_qamar/models/user.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final IUserRepository _repository;

  User? user;

  UserBloc(this._repository) : super(InitUserState()) {
    on<GetUserEvent>((event, emit) async {
      ApiModel<User, String> eitehr = await _repository.getUser();

      eitehr.fold(
        (data) {
          user = data;
          emit(CompleteUserState());
        },
        (error) => emit(FailedUserState(error)),
      );
    });
    on<UpdateUserEvent>((event, emit) async {
      emit(LoadingUserState());
      ApiModel<User, String> eitehr = await _repository.updateUser(
        userID: event.userID,
        firstName: event.firstName,
        lastName: event.lastName,
        bio: event.bio,
        image: event.image,
      );

      eitehr.fold(
        (data) {
          user = data;
          emit(CompleteUserState());
        },
        (error) => emit(FailedUserState(error)),
      );
    });

    on<SetUserEvent>((event, emit) {
      user = event.user;
      emit(CompleteUserState());
    });
    on<LogoutUserEvent>((event, emit) {
      user = null;
      emit(InitUserState());
    });
  }
}
