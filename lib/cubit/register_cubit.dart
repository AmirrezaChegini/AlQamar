import 'package:bloc/bloc.dart';

class RegisterCubit extends Cubit<bool> {
  RegisterCubit() : super(false);

  void goToOtp(bool show) {
    emit(show);
  }
}
