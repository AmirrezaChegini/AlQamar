import 'package:al_qamar/bloc/auth/auth_event.dart';
import 'package:al_qamar/bloc/auth/auth_state.dart';
import 'package:al_qamar/data/repositories/auth_repository.dart';
import 'package:al_qamar/models/user.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:al_qamar/utils/storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _repository;

  AuthBloc(this._repository) : super(InitAuthState()) {
    on<LoginAuthEvent>((event, emit) async {
      emit(LoadingAuthState());

      ApiModel<User, String> either = await _repository.login(
        email: event.email,
        password: event.password,
      );

      either.fold(
        (data) => emit(CompleteAuthState(data)),
        (error) => emit(FailedAuthState(error)),
      );
    });
    on<RegisterAuthEvent>((event, emit) async {
      emit(LoadingAuthState());

      String email = '';
      String password = '';
      String errorMessage = '';

      ApiModel<User, String> registerEither = await _repository.register(
        email: event.email,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
      );

      registerEither.fold(
        (data) {
          email = event.email;
          password = event.password;
        },
        (error) => errorMessage = error,
      );

      if (errorMessage.isEmpty) {
        add(LoginAuthEvent(email, password));
      } else {
        emit(FailedAuthState(errorMessage));
      }
    });

    on<LogoutAuthEvent>((event, emit) async {
      await Storage.clearAll();
      emit(InitAuthState());
    });
  }
}
