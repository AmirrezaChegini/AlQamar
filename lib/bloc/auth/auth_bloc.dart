import 'package:al_qamar/bloc/auth/auth_event.dart';
import 'package:al_qamar/bloc/auth/auth_state.dart';
import 'package:al_qamar/data/repositories/auth_repository.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:al_qamar/utils/storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _repository;

  AuthBloc(this._repository) : super(InitAuthState()) {
    on<RegisterAuthEvent>((event, emit) async {
      emit(LoadingAuthState());
      await Future.wait([
        Storage.saveString(key: 'email', value: event.email),
        Storage.saveString(key: 'firstName', value: event.firstName),
        Storage.saveString(key: 'lastName', value: event.lastName),
      ]);
      ApiModel<String, String> either = await _repository.register(
        name: '${event.firstName} ${event.lastName}',
        email: event.email,
        password: event.password,
      );

      either.fold((data) {
        emit(CompleteRegisterState(data));
      }, (error) {
        emit(FailAuthState(error));
      });
    });

    on<LoginAuthEvent>((event, emit) async {
      emit(LoadingAuthState());
      ApiModel<String, String> either = await _repository.login(
        email: event.email,
        password: event.password,
      );

      either.fold((data) {
        emit(CompleteLoginState(data));
      }, (error) {
        emit(FailAuthState(error));
      });
    });

    on<VerifyAuthEvent>((event, emit) async {
      emit(LoadingVerifyState());
      String email = await Storage.getString(key: 'email');
      ApiModel<String, String> either = await _repository.verify(
        email: email,
        otp: event.otp,
      );

      either.fold((data) {
        emit(CompleteVerifyState(data));
      }, (error) async {
        emit(FailVerifyState(error));
      });
    });

    on<ResendCodeEvent>((event, emit) async {
      emit(LoadingVerifyState());
      ApiModel<String, String> either =
          await _repository.resendOtp(email: event.email);

      either.fold((data) {
        emit(CompleteResendCodeState(data));
      }, (error) {
        emit(FailVerifyState(error));
      });
    });

    on<LogoutAuthEvent>((event, emit) async {
      emit(LoadingAuthState());
      ApiModel<String, String> either = await _repository.logout();

      either.fold((data) {
        Storage.clearAll();
        emit(CompleteLogoutState());
      }, (error) {
        emit(FailAuthState(error));
      });
    });

    on<CheckEmailEvent>((event, emit) async {
      String email = await Storage.getString(key: 'email');
      if (email.isNotEmpty) {
        emit(CompleteRegisterState('You must enter OTP code'));
      } else {
        emit(InitAuthState());
      }
    });

    on<ChangeInfoEvent>((event, emit) async {
      await Future.wait([
        Storage.removeKey(key: 'email'),
        Storage.removeKey(key: 'firstName'),
        Storage.removeKey(key: 'lastName'),
      ]);
      emit(InitAuthState());
    });
  }
}
