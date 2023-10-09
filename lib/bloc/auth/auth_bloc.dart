import 'package:al_qamar/bloc/auth/auth_event.dart';
import 'package:al_qamar/bloc/auth/auth_state.dart';
import 'package:al_qamar/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _repository;

  AuthBloc(this._repository) : super(InitAuthState()) {
    on<RegisterAuthEvent>((event, emit) async {
      // emit(LoadingAuthState());
      await Future.delayed(const Duration(seconds: 2));

      var either = await _repository.register(
        name: event.name,
        email: event.email,
        password: event.password,
      );

      either.fold((erroMessage) {
        emit(FailAuthState(erroMessage));
      }, (message) {
        emit(CompleteRegisterState(message));
      });
    });

    on<LoginAuthEvent>((event, emit) async {
      // emit(LoadingAuthState());
      await Future.delayed(const Duration(seconds: 2));

      var either = await _repository.login(
        email: event.email,
        password: event.password,
      );

      either.fold((erroMessage) {
        emit(FailAuthState(erroMessage));
      }, (message) {
        emit(CompleteAuthState(message));
      });
    });

    on<VerifyAuthEvent>((event, emit) async {
      // emit(LoadingAuthState());
      await Future.delayed(const Duration(seconds: 2));

      var either = await _repository.verify(
        email: event.email,
        otp: event.otp,
      );

      either.fold((erroMessage) {
        emit(FailVerifyState(erroMessage));
      }, (message) {
        emit(CompleteAuthState(message));
      });
    });

    on<LogoutAuthEvent>((event, emit) async {
      // emit(LoadingAuthState());
      await Future.delayed(const Duration(seconds: 2));

      var either = await _repository.logout(
        email: event.email,
        password: event.password,
      );

      either.fold((erroMessage) {
        emit(FailAuthState(erroMessage));
      }, (message) {
        emit(InitAuthState());
      });
    });
  }
}
