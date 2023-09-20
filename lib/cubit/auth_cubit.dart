import 'package:bloc/bloc.dart';

class AuthCubit extends Cubit<bool> {
  AuthCubit() : super(false);

  void signIn(bool sign) {
    emit(sign);
  }
}
